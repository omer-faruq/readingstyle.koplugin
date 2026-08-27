--[[--
Reading style — friendly controls for the settings that decide how a book looks.

The plugin does not render anything itself. It builds a small CSS snippet from a
handful of plain controls and hands it to crengine through KOReader's existing
style tweak pipeline, and it drives KOReader's own document settings (line
spacing, margins, word spacing) through their normal events.

How the CSS gets in
-------------------
ReaderStyleTweak owns the tweak CSS, and ReaderTypeset asks it for the text every
time the stylesheet is (re)built: at load (readertypeset.lua:39), when a tweak is
toggled (:353) and when the style sheet changes (:362). We wrap that one accessor
on the instance, so our snippet is appended on every one of those paths and can
never be dropped by a tweak the user toggles later. ReaderTypeset:onApplyStyleSheet
returns true and swallows the event, so listening for it instead would not work.

The wrapping happens in init() rather than in onReadSettings() and that timing is
load-bearing: plugins are registered at readerui.lua:464 and the ReadSettings
event that builds the first stylesheet is only sent at :484. Injecting CSS after
that point changes the document's rendering hash, which sets ReaderRolling's
rerender-and-reload machinery going — the book closes and reopens half a minute
later, looking exactly like a crash. Getting in before the first render avoids it.

Scopes
------
A style table can live at three levels, and the most specific one that exists
wins outright (there is no merging — one table is in charge at a time):

    this book          doc_settings.reading_style
    this language      G_reader_settings.reading_style_languages[<lang>]
    all books          G_reader_settings.reading_style
--]]

local ConfirmBox = require("ui/widget/confirmbox")
local Dispatcher = require("dispatcher")
local Event = require("ui/event")
local KoPresets = require("ui/presets")
local Notification = require("ui/widget/notification")
local UIManager = require("ui/uimanager")
local WidgetContainer = require("ui/widget/container/widgetcontainer")
local logger = require("logger")
local _ = require("readingstyle_gettext")
local T = require("ffi/util").template

local Builtin = require("readingstyle_presets")
local Css = require("readingstyle_css")
local Menu = require("readingstyle_menu")
local Quick = require("readingstyle_quick")
local Sandbox = require("readingstyle_sandbox")
local Settings = require("readingstyle_settings")

local SETTING_STYLE = "reading_style"
local SETTING_LANGUAGES = "reading_style_languages"
local SETTING_PRESETS = "reading_style_presets"
local SETTING_CYCLE_INDEX = "reading_style_presets_cycle_index"
local SETTING_AUTO_APPLY = "reading_style_auto_apply"
local SETTING_SCOPE = "reading_style_scope"

local ReadingStyle = WidgetContainer:extend{
    name = "readingstyle",
    is_doc_only = true,
    -- Every style change re-renders the book, so a spin widget held down would
    -- otherwise re-render on every tick. Coalesce bursts of changes.
    apply_delay = 0.5,
}

function ReadingStyle:init()
    -- Only crengine documents have a stylesheet to extend; ReaderStyleTweak is
    -- not registered for anything else.
    if not self.ui or not self.ui.styletweak then return end
    self.active = true

    self.global_style = Settings.sanitize(G_reader_settings:readSetting(SETTING_STYLE, {}))
    self.language_styles = Settings.sanitizeLanguages(
        G_reader_settings:readSetting(SETTING_LANGUAGES, {}))
    self.book_style = self.ui.doc_settings:readSetting(SETTING_STYLE)
    if self.book_style then
        Settings.sanitize(self.book_style)
    end
    self.auto_apply = G_reader_settings:nilOrTrue(SETTING_AUTO_APPLY)
    self.language = self:readBookLanguage()
    self.scope = self:readScope()

    -- Stable reference, so it can be unscheduled.
    self.apply_callback = function() self:applyNow() end

    self:hookStyleTweak()
    self:setupPresets()
    self:onDispatcherRegisterActions()
    self.ui.menu:registerToMainMenu(self)
end

--- Book metadata, with the reader's own custom fields layered over the file's.
-- extendProps is what readerui.lua:495 uses; language is one of the fields a
-- reader can set by hand, and setting it is exactly what someone does when a
-- book declares none, so it has to be honoured or that fix appears to do nothing.
function ReadingStyle:extendProps(original_props)
    local ok, props = pcall(function()
        local BookInfo = require("apps/filemanager/filemanagerbookinfo")
        return BookInfo.extendProps(original_props, self.ui.document.file)
    end)
    if ok and props then return props end
    return original_props
end

--- The book's language as a bare code, or nil when it declares none.
--
-- Timing, which is the whole difficulty here. At init() the crengine document
-- has been created but not parsed: readerui defers loadDocument() into a
-- postInitCallback (readerui.lua:331-333) that only runs at :486, after plugins
-- are registered at :464 and after the ReadSettings at :484 that builds the first
-- stylesheet. Asking the document for metadata at init() therefore returns
-- nothing at all, and every book looks as though it declares no language.
--
-- So init() reads the copy KOReader saved the last time this book was opened,
-- and onPreRenderDocument below asks the loaded document once it is available.
--
-- Three-letter codes are folded onto their two-letter equivalent through the
-- alias table ReaderTypography exports, or a book tagged "tur" and one tagged
-- "tr" would get two separate Turkish profiles. Both spellings are common in
-- the wild, and to the reader they are the same language.
function ReadingStyle:readBookLanguage(from_loaded_document)
    local props
    if from_loaded_document then
        local ok, loaded = pcall(function() return self.ui.document:getProps() end)
        props = self:extendProps(ok and loaded or nil)
    else
        -- Ask the document anyway: crengine looks to parse metadata on demand,
        -- so this does answer before loadDocument() on the books tested. Where
        -- it comes back empty, fall back to what KOReader cached on the previous
        -- open — and for a book never opened before, neither has an answer and
        -- onPreRenderDocument below supplies one before anything is drawn.
        local ok, early = pcall(function() return self.ui.document:getProps() end)
        props = self:extendProps(ok and early or nil)
        if type(props) ~= "table" or not props.language then
            props = self:extendProps(self.ui.doc_settings:readSetting("doc_props"))
        end
    end
    if type(props) ~= "table" then return nil end

    local code = Settings.languageKey(props.language)
    if not code then return nil end

    local ok_typography, Typography = pcall(require, "apps/reader/modules/readertypography")
    local aliases = ok_typography and Typography.LANG_ALIAS_TO_LANG_TAG
    local canonical = aliases and aliases[code]
    if canonical then
        -- The table maps onto full tags ("eng" -> "en-US"), so run the result
        -- back through languageKey to get the bare code we store profiles under.
        return Settings.languageKey(canonical) or code
    end
    return code
end

--- The document is parsed by now and nothing has been rendered yet — which
-- readerui.lua:338-340 documents as the point for reading settings that need the
-- loaded document. It is also the last moment the stylesheet can change for free:
-- ReaderRolling records the rendering hash in a later postInitCallback, so a
-- change made here is simply part of the first render rather than a re-render.
--
-- Only the language can have been wrong until now, and only for a book being
-- opened for the first time; every later open had the cached metadata at init().
function ReadingStyle:onPreRenderDocument()
    if not self.active then return end

    local language = self:readBookLanguage(true)
    if language == self.language then return end

    self.language = language
    self.scope = self:readScope()
    self.css = nil
    self.style_name = nil

    -- Deliberately not ApplyStyleSheet: that also fires UpdatePos, and there is
    -- no rendered position to update yet. Just hand crengine the new sheet.
    local typeset = self.ui.typeset
    if typeset then
        self.ui.document:setStyleSheet(typeset.css, self.ui.styletweak:getCssText())
    end
end

--- A readable name for a language code, for the scope menu.
--
-- Translator carries a full ISO 639-1 table, already translated into the
-- reader's own language and — the part that matters here — keyed by bare codes,
-- which is exactly what a profile is filed under. Its second return value says
-- whether the code was actually recognised; without checking it, an unknown code
-- comes back shouted in capitals rather than left alone.
--
-- An earlier version built this from ReaderTypography's hyphenation map instead.
-- That map is keyed by dictionary rather than by language and seeds itself with
-- three pseudo-dictionaries — "@none", "@softhyphens", "@algorithm" — all filed
-- under the tag "en". An English book was therefore announced as "Books in
-- @none". It also had nothing to say about languages with no hyphenation
-- dictionary, Chinese among them.
function ReadingStyle:getLanguageName(code)
    if not code then return nil end
    local ok, Translator = pcall(require, "ui/translator")
    if ok and Translator and Translator.getLanguageName then
        local name, recognised = Translator:getLanguageName(code)
        if recognised and name and name ~= "" then
            return name
        end
    end
    return code
end

function ReadingStyle:hookStyleTweak()
    local styletweak = self.ui.styletweak
    if styletweak.readingstyle_hooked then return end
    styletweak.readingstyle_hooked = true

    local original_getCssText = styletweak.getCssText
    styletweak.getCssText = function(tweak_self)
        local tweaks_css = original_getCssText(tweak_self)
        local style_css = self:getCss()
        if style_css == "" then
            return tweaks_css
        end
        -- Appended last, so our declarations outrank the tweaks the user enabled
        -- by hand. That is the intended precedence: this plugin is the front end,
        -- the tweak list is the workshop underneath it.
        if tweaks_css and tweaks_css ~= "" then
            return tweaks_css .. "\n\n" .. style_css
        end
        return style_css
    end
end

-- Style table and scope -----------------------------------------------------
--
-- Which level this book reads from is an explicit choice, stored with the book,
-- not something inferred from which tables happen to exist. Inferring it made
-- switching scope destructive — the only way to stop a book style from being in
-- charge was to delete it — and one tap on the quick screen could take a style
-- with it. Now switching only changes where you are editing; deleting is its own
-- action, and has to be asked for.

local SCOPE_ORDER = {
    [Settings.SCOPE_GLOBAL] = 1,
    [Settings.SCOPE_LANGUAGE] = 2,
    [Settings.SCOPE_BOOK] = 3,
}

--- The scope stored with this book, or the one the old model would have inferred.
-- Settings written before the scope was recorded still open at the level they
-- were being edited at, because the inference is exactly what used to happen.
function ReadingStyle:readScope()
    local stored = self.ui.doc_settings:readSetting(SETTING_SCOPE)
    if stored and SCOPE_ORDER[stored] then
        if stored == Settings.SCOPE_BOOK and self.book_style then return stored end
        if stored == Settings.SCOPE_LANGUAGE and self.language
                and self.language_styles[self.language] then
            return stored
        end
        if stored == Settings.SCOPE_GLOBAL then return stored end
        -- Stored scope names a level whose table has since been removed.
    end
    if self.book_style then return Settings.SCOPE_BOOK end
    if self.language and self.language_styles[self.language] then
        return Settings.SCOPE_LANGUAGE
    end
    return Settings.SCOPE_GLOBAL
end

function ReadingStyle:getScope()
    return self.scope or Settings.SCOPE_GLOBAL
end

--- The style table currently in charge. Callers may mutate it in place.
function ReadingStyle:getStyle()
    if self.scope == Settings.SCOPE_BOOK and self.book_style then
        return self.book_style
    end
    if self.scope == Settings.SCOPE_LANGUAGE and self.language
            and self.language_styles[self.language] then
        return self.language_styles[self.language]
    end
    return self.global_style
end

--- Moves editing to another level, and nothing else.
-- A level that has no style yet is seeded from whatever is on screen, so picking
-- a scope never changes the page by itself. Levels you move away from keep their
-- styles, ready for when you switch back.
function ReadingStyle:setScope(scope)
    if not SCOPE_ORDER[scope] then return false end
    if scope == Settings.SCOPE_LANGUAGE and not self.language then return false end

    local seed = Settings.copy(self:getStyle())
    if scope == Settings.SCOPE_BOOK then
        self.book_style = self.book_style or seed
    elseif scope == Settings.SCOPE_LANGUAGE then
        self.language_styles[self.language] = self.language_styles[self.language] or seed
    end

    self.scope = scope
    self:styleChanged(true)
    return true
end

--- Does this level hold a style at all?
function ReadingStyle:hasStyleAt(scope)
    if scope == Settings.SCOPE_BOOK then return self.book_style ~= nil end
    if scope == Settings.SCOPE_LANGUAGE then
        return self.language ~= nil and self.language_styles[self.language] ~= nil
    end
    return not Settings.isEmpty(self.global_style)
end

--- Deletes the style stored at a level. The one deliberate way to lose settings.
function ReadingStyle:removeStyleAt(scope)
    if scope == Settings.SCOPE_BOOK then
        self.book_style = nil
    elseif scope == Settings.SCOPE_LANGUAGE and self.language then
        self.language_styles[self.language] = nil
    elseif scope == Settings.SCOPE_GLOBAL then
        Settings.clear(self.global_style)
    end

    if self.scope == scope and scope ~= Settings.SCOPE_GLOBAL then
        -- Editing has to land somewhere that still exists.
        if scope == Settings.SCOPE_BOOK and self:hasStyleAt(Settings.SCOPE_LANGUAGE) then
            self.scope = Settings.SCOPE_LANGUAGE
        else
            self.scope = Settings.SCOPE_GLOBAL
        end
    end
    self:styleChanged(true)
end

--- Writes the style now on screen onto a broader level, and edits there from now on.
-- setScope only seeds a level that is still empty, so on its own it cannot answer
-- "make this the default for Turkish" once a Turkish style exists — it would just
-- move editing over to the old Turkish style. This overwrites the target with
-- what the reader is actually looking at.
function ReadingStyle:promoteStyleTo(scope)
    if scope == Settings.SCOPE_LANGUAGE and not self.language then return false end
    local promoted = Settings.copy(self:getStyle())

    if scope == Settings.SCOPE_LANGUAGE then
        self.language_styles[self.language] = promoted
    else
        -- In place: G_reader_settings holds a reference to this very table.
        Settings.clear(self.global_style)
        for key, value in pairs(promoted) do
            self.global_style[key] = value
        end
    end

    self.scope = scope
    self:styleChanged(true)
    return true
end

--- True when promoting would overwrite a style that is already there.
function ReadingStyle:promotionOverwrites(scope)
    if scope == Settings.SCOPE_LANGUAGE then
        return not Settings.isEmpty(self.language and self.language_styles[self.language])
    end
    return not Settings.isEmpty(self.global_style)
end

-- Values --------------------------------------------------------------------

function ReadingStyle:getValue(key)
    return self:getStyle()[key]
end

--- Sets (or with a nil value, clears) one style key and applies the result.
function ReadingStyle:setValue(key, value, immediate)
    local style = self:getStyle()
    if not Settings.set(style, key, value) then
        logger.warn("ReadingStyle: rejected value for", key, value)
        return false
    end
    self:styleChanged(immediate)
    return true
end

--- On/off setting where "off" and "book default" are the same answer.
function ReadingStyle:toggleValue(key)
    self:setValue(key, Settings.nextToggle(self:getValue(key)), true)
end

--- Three-state setting: book default, on, off, and round again.
function ReadingStyle:cycleTristate(key)
    self:setValue(key, Settings.nextTristate(self:getValue(key)), true)
end

--- Current value of a KOReader-owned setting (line spacing, margins, ...).
--- The value the menus should show. Under a preview sandbox that is the value
-- the reader has chosen there, which the book has not been told about yet;
-- pass raw = true for what the document is actually rendering with (the
-- preview needs both, to say "105% -> 120%").
function ReadingStyle:getEngineValue(key, raw)
    local spec = Settings.ENGINE_SCHEMA[key]
    if not spec then return nil end
    if not raw and self.sandbox then
        local value = self.sandbox:engineValue(key)
        if value ~= nil then return value end
    end
    local configurable = self.ui.document.configurable
    return configurable and configurable[spec.configurable]
end

--- What KOReader itself considers the default for a setting: the reader's own
-- saved default if they ever pressed "save as default", otherwise the built-in
-- one. Same pair creoptions.lua uses to decide where to put its star.
function ReadingStyle:getEngineDefault(key)
    local spec = Settings.ENGINE_SCHEMA[key]
    local value = G_reader_settings:readSetting(spec.global_key)
    if value == nil and spec.default_key then
        value = G_defaults:readSetting(spec.default_key)
    end
    if value == nil then
        value = spec.default_value
    end
    return value
end

--- True when a KOReader-owned setting still sits at that default.
-- Note this says nothing about who changed it: the bottom config bar writes the
-- same settings, and a change made there is marked here too. That is the honest
-- reading of the marker — it means "this book does not look default", not "this
-- plugin changed it".
function ReadingStyle:isEngineDefault(key)
    local current = self:getEngineValue(key)
    local default = self:getEngineDefault(key)
    if current == nil or default == nil then return true end
    if type(current) == "table" or type(default) == "table" then
        return type(current) == "table" and type(default) == "table"
            and current[1] == default[1] and current[2] == default[2]
    end
    return current == default
end

function ReadingStyle:countChangedEngineValues(keys)
    local count = 0
    for _index, key in ipairs(keys or Settings.ENGINE_KEYS) do
        if not self:isEngineDefault(key) then
            count = count + 1
        end
    end
    return count
end

--- Changes a KOReader-owned setting through its own event.
-- The configurable is written first because several of these events (the margin
-- ones, in particular) only act on the document and leave the stored value to
-- the config dialog that normally sends them. Without this the change would not
-- survive closing the book.
function ReadingStyle:setEngineValue(key, value)
    local spec = Settings.ENGINE_SCHEMA[key]
    if not spec then return false end

    -- clampEngine also returns a fresh table for paired values, which matters:
    -- the configurable is handed straight to KOReader, which then owns and
    -- mutates it, and a preset must not find itself edited from underneath.
    value = Settings.clampEngine(key, value)
    if value == nil then
        logger.warn("ReadingStyle: ignoring unusable value for", key)
        return false
    end

    -- Counted by getStyleName, so the label has to be recomputed.
    self.style_name = nil

    if self.sandbox then
        -- Under a preview, remember it instead of driving the document. This is
        -- the single place a KOReader document setting is set from this plugin,
        -- which is what makes a sandbox possible at all: nothing else has to
        -- know, and cancelling has nothing to undo here because nothing was set.
        self.sandbox:setEngine(key, value)
        return true
    end

    local configurable = self.ui.document.configurable
    if configurable then
        configurable[spec.configurable] = value
    end
    self.ui:handleEvent(Event:new(spec.event, value))
    return true
end

-- Applying ------------------------------------------------------------------

function ReadingStyle:getCss()
    -- Only ever set inside the preview subprocess, which dies with it. The
    -- stylesheet hook installed at init() then hands crengine the candidate
    -- instead of the current style, and nothing else has to change. Setting
    -- this in the reader's own process would apply the candidate for real.
    if self.preview_css then
        return self.preview_css
    end
    if self.css == nil then
        self.css = Css.build(self:getStyle())
    end
    return self.css
end

--- Records a change and gets it on screen.
-- immediate is for deliberate one-off actions (a menu item, loading a preset);
-- the debounced path is for controls that can fire in bursts.
function ReadingStyle:styleChanged(immediate)
    self.css = nil
    self.style_name = nil
    self.pending = true
    if self.sandbox then
        -- The style tables are plain data: changing them shows up nowhere until
        -- something applies them, so a sandbox only has to stop applying.
        self.sandbox:markChanged()
        return
    end
    if self.defer_apply then
        -- The quick style screen batches every change itself and flushes them
        -- in one go; scheduling here as well would re-render the book twice.
        return
    end
    if immediate then
        self:applyNow()
        return
    end
    if not self.auto_apply then return end
    UIManager:unschedule(self.apply_callback)
    UIManager:scheduleIn(self.apply_delay, self.apply_callback)
end

function ReadingStyle:applyNow()
    if self.sandbox then
        -- Reached from the quick screen's flush and the menu's "Apply now",
        -- both of which stay usable under a preview. The preview's own Apply
        -- is the only way out of the sandbox.
        self.sandbox:markChanged()
        return
    end
    UIManager:unschedule(self.apply_callback)
    self.css = nil
    self.pending = false
    self.ui:handleEvent(Event:new("ApplyStyleSheet"))
end

function ReadingStyle:hasPendingChanges()
    return self.pending == true
end

--- Writes the generated CSS into KOReader's user style tweaks folder.
-- A graduation path: the look survives without the plugin, as an ordinary tweak
-- the reader can enable, edit or share. ReaderStyleTweak scans that folder when
-- a document opens and re-reads each file on every rebuild, so the file shows up
-- after a restart and stays live thereafter.
function ReadingStyle:exportAsStyleTweak()
    local css = self:getCss()
    if css == "" then return nil, "nothing to write" end

    local DataStorage = require("datastorage")
    local directory = DataStorage:getDataDir() .. "/styletweaks"
    local lfs = require("libs/libkoreader-lfs")
    if lfs.attributes(directory, "mode") ~= "directory" then
        lfs.mkdir(directory)
    end

    local path = directory .. "/reading_style.css"
    local file, err = io.open(path, "w")
    if not file then return nil, err end
    file:write("/* Written by the Reading style plugin. Edits here are kept:\n")
    file:write("   the plugin never reads this file back, it only overwrites it\n")
    file:write("   when you choose \"Save as a style tweak\" again. */\n\n")
    file:write(css)
    file:write("\n")
    file:close()
    return path
end

function ReadingStyle:setAutoApply(enabled)
    self.auto_apply = enabled
    G_reader_settings:saveSetting(SETTING_AUTO_APPLY, enabled)
    if enabled and self.pending then
        self:applyNow()
    end
end

-- Presets -------------------------------------------------------------------

function ReadingStyle:setupPresets()
    self.preset_obj = {
        presets = G_reader_settings:readSetting(SETTING_PRESETS, {}),
        cycle_index = G_reader_settings:readSetting(SETTING_CYCLE_INDEX),
        dispatcher_name = "load_reading_style_preset",
        saveCycleIndex = function(this)
            G_reader_settings:saveSetting(SETTING_CYCLE_INDEX, this.cycle_index)
        end,
        buildPreset = function() return self:buildPreset() end,
        loadPreset = function(preset) self:loadPreset(preset) end,
    }
end

--- Snapshot of everything the plugin can restore: our style plus the KOReader
-- document settings the user drove from our menus.
function ReadingStyle:buildPreset()
    local preset = { style = Settings.copy(self:getStyle()), engine = {} }
    for _index, key in ipairs(Settings.ENGINE_KEYS) do
        local value = self:getEngineValue(key)
        if type(value) == "table" then
            value = { value[1], value[2] }
        end
        preset.engine[key] = value
    end
    return preset
end

function ReadingStyle:loadPreset(preset)
    if type(preset) ~= "table" then return end
    local style = Settings.clear(self:getStyle())
    for key, value in pairs(preset.style or {}) do
        Settings.set(style, key, value)
    end
    -- Only the engine settings the preset actually names: the rest stay as the
    -- reader left them.
    for _index, key in ipairs(Settings.ENGINE_KEYS) do
        local value = preset.engine and preset.engine[key]
        if value ~= nil then
            self:setEngineValue(key, value)
        end
    end
    self:styleChanged(true)
end

function ReadingStyle:loadBuiltinPreset(id)
    local preset = Builtin.getBuiltin(id)
    if not preset then return end
    self:loadPreset(Builtin.copy(preset))
    Notification:notify(T(_("Reading style: %1"), preset.name))
end

--- Name to show as the current style, when it happens to match a known profile.
-- Counts both halves. A book whose line spacing or margins were changed is not
-- showing publisher defaults, whoever changed them and wherever they are stored,
-- so the label has to say so or it contradicts what the reader is looking at.
function ReadingStyle:getStyleName()
    -- Cached like the CSS: a menu row's text_func runs on every redraw, and this
    -- walks every built-in and user preset. Dropped by styleChanged.
    if self.style_name then return self.style_name end

    local style = self:getStyle()
    local css_count = Settings.count(style)
    local engine_count = self:countChangedEngineValues()

    if css_count == 0 and engine_count == 0 then
        self.style_name = _("Publisher default")
        return self.style_name
    end

    self.style_name = self:matchPresetName(style)
        or T(_("Custom (%1)"), css_count + engine_count)
    return self.style_name
end

--- The name of whichever preset the current settings happen to equal.
-- Matching on values rather than remembering what was last loaded means the name
-- survives a restart, and stops being shown the moment anything is edited — both
-- of which are what the reader expects from a label.
function ReadingStyle:matchPresetName(style)
    for _index, preset in ipairs(Builtin.BUILTIN) do
        if preset.id ~= "default"
                and Builtin.stylesMatch(style, preset.style, Settings.CSS_KEYS)
                and self:enginesMatch(preset.engine) then
            return preset.name
        end
    end

    -- User presets, in a stable order so an exact tie always names the same one.
    local names = {}
    for name in pairs(self.preset_obj.presets) do
        names[#names + 1] = name
    end
    table.sort(names)
    for _index, name in ipairs(names) do
        local preset = self.preset_obj.presets[name]
        if type(preset) == "table"
                and Builtin.stylesMatch(style, preset.style, Settings.CSS_KEYS)
                and self:enginesMatch(preset.engine) then
            return name
        end
    end
end

--- True when every engine setting a preset names is currently at that value.
function ReadingStyle:enginesMatch(engine)
    for _index, key in ipairs(Settings.ENGINE_KEYS) do
        local wanted = engine and engine[key]
        if wanted ~= nil then
            local current = self:getEngineValue(key)
            if type(wanted) == "table" then
                if type(current) ~= "table"
                        or current[1] ~= wanted[1] or current[2] ~= wanted[2] then
                    return false
                end
            elseif current ~= wanted then
                return false
            end
        end
    end
    return true
end

--- Puts a group of settings back to default: this plugin's own keys are cleared,
-- and KOReader's are set to the value it would put a star next to.
--
-- Both halves, because both halves are what the changed-marker beside a section
-- counts and what the style name counts. A reset that cleared only half of it
-- would leave the menu still saying five things had changed.
--
-- Both lists are explicit — there is no "nil means everything" shorthand, since
-- a section that resets only KOReader's settings would then silently clear the
-- whole style.
function ReadingStyle:resetStyle(keys, engine_keys)
    local style = self:getStyle()
    for _index, key in ipairs(keys or {}) do
        style[key] = nil
    end

    for _index, key in ipairs(engine_keys or {}) do
        local default = self:getEngineDefault(key)
        if default ~= nil then
            self:setEngineValue(key, default)
        end
    end

    self:styleChanged(true)
end

--- Everything, at the level currently being edited. Styles stored at the other
-- levels are left alone; removing those is what the delete actions are for.
function ReadingStyle:resetAll()
    self:resetStyle(Settings.CSS_KEYS, Settings.ENGINE_KEYS)
end

function ReadingStyle:confirmReset(keys, engine_keys, text, touchmenu_instance)
    UIManager:show(ConfirmBox:new{
        text = text,
        ok_text = _("Reset"),
        ok_callback = function()
            self:resetStyle(keys, engine_keys)
            if touchmenu_instance then
                touchmenu_instance:updateItems()
            end
        end,
    })
end

-- Menus, gestures, events ---------------------------------------------------

function ReadingStyle:addToMainMenu(menu_items)
    if not self.active then return end
    menu_items.reading_style = {
        -- Next to "Style tweaks", which is what this is a friendly face for.
        sorting_hint = "typeset",
        text_func = function()
            return T(_("Reading style: %1"), self:getStyleName())
        end,
        sub_item_table = Menu.build(self),
    }
end

function ReadingStyle:showQuickStyle()
    if not self.active then return end
    Quick.show(self)
end

-- Preview sandbox -----------------------------------------------------------
--
-- While a preview is open the reader can change anything this plugin owns, and
-- none of it may reach the book: the forked preview process is the only thing
-- that renders those changes. Two properties make that possible, and they are
-- the reason every control in this plugin goes through the same few functions:
--
--   * the style tables are plain data. A change to them is invisible until
--     something applies it, so the sandbox simply stops applying (styleChanged
--     and applyNow above).
--   * setEngineValue is the only place a KOReader document setting is driven,
--     so the sandbox intercepts it and remembers the value instead.
--
-- Cancelling therefore has nothing to undo on the engine side — nothing was
-- ever set — and only has to put the style tables back where they were.

function ReadingStyle:beginSandbox()
    if self.sandbox then return self.sandbox end
    self.sandbox = Sandbox.new{
        scope = self.scope,
        pending = self.pending,
        global = self.global_style,
        book = self.book_style,
        languages = self.language_styles,
    }
    return self.sandbox
end

function ReadingStyle:inSandbox()
    return self.sandbox ~= nil
end

--- The pending engine values, to hand to the preview subprocess.
function ReadingStyle:sandboxEngine()
    return self.sandbox and self.sandbox.engine or {}
end

--- True once, per change: the preview asks after every settings screen closes
-- so it knows whether it has to render again.
function ReadingStyle:takeSandboxChange()
    if not self.sandbox then return false end
    return self.sandbox:takeChange()
end

--- Called by a settings screen as it closes. A preview holding the sandbox
-- registers a watcher here, so that whichever screen the reader used — the
-- menu, the quick screen — the preview knows to render again. A no-op when no
-- preview is open, which is what every caller expects.
function ReadingStyle:settingsScreenClosed()
    local sandbox = self.sandbox
    if not sandbox or not sandbox.watcher then return end
    sandbox.watcher()
end

--- Ends the sandbox: keep = true applies everything the reader chose there to
-- the book for real, keep = false leaves the book exactly as it was found.
function ReadingStyle:endSandbox(keep)
    local sandbox = self.sandbox
    if not sandbox then return end
    self.sandbox = nil

    if keep then
        -- Engine settings first, each through its own event, then one apply for
        -- the style half: the same order and the same cost as the quick screen's
        -- flush, which is the closest thing to this the plugin already had.
        local engine_changes = sandbox:orderedEngine()
        for _index, change in ipairs(engine_changes) do
            self:setEngineValue(change.key, change.value)
        end
        self.css = nil
        self.style_name = nil
        -- Nothing changed under the preview: applying anyway would re-render the
        -- book for no reason, which is exactly what a preview exists to avoid.
        if self.pending or #engine_changes > 0 then
            self:applyNow()
        end
        return
    end

    local restored = sandbox:restored()
    self.global_style = restored.global
    self.book_style = restored.book
    self.language_styles = restored.languages
    self.scope = restored.scope
    self.pending = restored.pending
    self.css = nil
    self.style_name = nil
end

-- Preview -------------------------------------------------------------------
--
-- Loaded on demand, and only ever from these two functions: a reader who never
-- opens a preview never loads the code, never forks anything, and pays nothing
-- for the feature existing.

function ReadingStyle:canPreview()
    if not self.active then return false end
    local ok, Preview = pcall(require, "readingstyle_preview")
    if not ok then
        logger.warn("ReadingStyle: preview module missing:", Preview)
        return false
    end
    return Preview.isAvailable(self)
end

--- opts: engine (engine values to start the sandbox with), css (candidate).
-- Applying and cancelling belong to the preview screen: it owns the sandbox
-- for as long as it is open.
function ReadingStyle:showPreview(opts)
    if not self.active then return end
    -- One at a time: the sandbox has a single owner, and the settings screens
    -- reachable from inside a preview can lead back here.
    if self:inSandbox() then return end
    local ok, PreviewView = pcall(require, "readingstyle_preview_view")
    if not ok then
        logger.warn("ReadingStyle: preview view missing:", PreviewView)
        Notification:notify(_("Preview is not available on this device."))
        return
    end
    if not self:canPreview() then
        Notification:notify(_("Preview is not available for this book."))
        return
    end
    PreviewView.show(self, opts or {})
end

function ReadingStyle.getPresets()
    return KoPresets.getPresets({
        presets = G_reader_settings:readSetting(SETTING_PRESETS, {}),
    })
end

function ReadingStyle:genPresetMenuItemTable()
    return KoPresets.genPresetMenuItemTable(self.preset_obj,
        _("Save current reading style as preset"))
end

function ReadingStyle:onDispatcherRegisterActions()
    Dispatcher:registerAction("reading_style_quick", {
        category = "none", event = "ShowReadingStyle",
        title = _("Reading style"), rolling = true,
    })
    Dispatcher:registerAction("load_reading_style_preset", {
        category = "string", event = "LoadReadingStylePreset",
        title = _("Load reading style preset"),
        args_func = ReadingStyle.getPresets, rolling = true,
    })
    Dispatcher:registerAction("cycle_reading_style_presets", {
        category = "none", event = "CycleReadingStylePresets",
        title = _("Cycle reading style presets"), rolling = true,
    })
end

function ReadingStyle:onShowReadingStyle()
    self:showQuickStyle()
    return true
end

function ReadingStyle:onLoadReadingStylePreset(preset_name)
    if not self.active then return end
    return KoPresets.onLoadPreset(self.preset_obj, preset_name, true)
end

function ReadingStyle:onCycleReadingStylePresets()
    if not self.active then return end
    return KoPresets.cycleThroughPresets(self.preset_obj, true)
end

function ReadingStyle:onSaveSettings()
    if not self.active then return end
    -- Saved even when empty: a book whose scope is "this book" with nothing set
    -- means "publisher defaults for this book", which is a different answer from
    -- "no style of its own, follow the global one".
    self.ui.doc_settings:saveSetting(SETTING_STYLE, self.book_style)
    self.ui.doc_settings:saveSetting(SETTING_SCOPE,
        self.scope ~= Settings.SCOPE_GLOBAL and self.scope or nil)
    G_reader_settings:saveSetting(SETTING_STYLE, self.global_style)
    G_reader_settings:saveSetting(SETTING_LANGUAGES, self.language_styles)
end

function ReadingStyle:onCloseWidget()
    if self.apply_callback then
        UIManager:unschedule(self.apply_callback)
    end
end

return ReadingStyle
