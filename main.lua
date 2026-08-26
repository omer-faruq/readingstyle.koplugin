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
local Settings = require("readingstyle_settings")

local SETTING_STYLE = "reading_style"
local SETTING_LANGUAGES = "reading_style_languages"
local SETTING_PRESETS = "reading_style_presets"
local SETTING_CYCLE_INDEX = "reading_style_presets_cycle_index"
local SETTING_AUTO_APPLY = "reading_style_auto_apply"

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
    self.language_styles = G_reader_settings:readSetting(SETTING_LANGUAGES, {})
    for _lang, style in pairs(self.language_styles) do
        Settings.sanitize(style)
    end
    self.book_style = self.ui.doc_settings:readSetting(SETTING_STYLE)
    if self.book_style then
        Settings.sanitize(self.book_style)
    end
    self.auto_apply = G_reader_settings:nilOrTrue(SETTING_AUTO_APPLY)
    self.language = self:readBookLanguage()

    -- Stable reference, so it can be unscheduled.
    self.apply_callback = function() self:applyNow() end

    self:hookStyleTweak()
    self:setupPresets()
    self:onDispatcherRegisterActions()
    self.ui.menu:registerToMainMenu(self)
end

--- The book language, for the per-language scope.
-- ui.doc_props is only filled in at readerui.lua:495, well after plugins are
-- registered and after the first stylesheet is built, so ask the document.
function ReadingStyle:readBookLanguage()
    local ok, props = pcall(function() return self.ui.document:getProps() end)
    if not ok or not props then return nil end
    return Settings.languageKey(props.language)
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

--- The style table currently in charge. Callers may mutate it in place.
function ReadingStyle:getStyle()
    if self.book_style then return self.book_style end
    if self.language and self.language_styles[self.language] then
        return self.language_styles[self.language]
    end
    return self.global_style
end

function ReadingStyle:getScope()
    if self.book_style then return Settings.SCOPE_BOOK end
    if self.language and self.language_styles[self.language] then
        return Settings.SCOPE_LANGUAGE
    end
    return Settings.SCOPE_GLOBAL
end

local SCOPE_ORDER = {
    [Settings.SCOPE_GLOBAL] = 1,
    [Settings.SCOPE_LANGUAGE] = 2,
    [Settings.SCOPE_BOOK] = 3,
}

--- Moves editing to another scope.
-- Two things happen, in this order: every table more specific than the target is
-- dropped, and the target gets a table if it did not have one, seeded from what
-- the reader is looking at right now.
--
-- So narrowing never changes the page — the new level starts as a copy of the
-- old one. Widening does change it when the broader level already holds a
-- different style, and that is the case the menu confirms first.
function ReadingStyle:setScope(scope)
    if scope == Settings.SCOPE_LANGUAGE and not self.language then return false end
    local target = SCOPE_ORDER[scope]
    local seed = Settings.copy(self:getStyle())

    if target < SCOPE_ORDER[Settings.SCOPE_BOOK] then
        self.book_style = nil
    end
    if target < SCOPE_ORDER[Settings.SCOPE_LANGUAGE] and self.language then
        self.language_styles[self.language] = nil
    end

    if scope == Settings.SCOPE_BOOK then
        self.book_style = self.book_style or seed
    elseif scope == Settings.SCOPE_LANGUAGE then
        self.language_styles[self.language] = self.language_styles[self.language] or seed
    end
    -- The global style always exists, so there is nothing to seed for it.

    self:styleChanged(true)
    return true
end

--- True when switching scope would drop settings instead of carrying them over.
function ReadingStyle:scopeChangeLosesSettings(scope)
    if SCOPE_ORDER[scope] >= SCOPE_ORDER[self:getScope()] then return false end
    if Settings.isEmpty(self:getStyle()) then return false end
    if scope == Settings.SCOPE_LANGUAGE and self.language
            and not self.language_styles[self.language] then
        -- Nothing there yet: the current settings become the language style.
        return false
    end
    return true
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
    self.preset_name = nil -- hand-edited: no longer any named preset
    self:styleChanged(immediate)
    return true
end

--- On/off setting where "off" and "book default" are the same answer.
function ReadingStyle:toggleValue(key)
    local enabled = self:getStyle()[key] == true
    self:setValue(key, enabled and nil or true, true)
end

--- Current value of a KOReader-owned setting (line spacing, margins, ...).
function ReadingStyle:getEngineValue(key)
    local spec = Settings.ENGINE_SCHEMA[key]
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
    if type(value) == "table" then
        -- Paired values are handed straight to the configurable, which KOReader
        -- then owns and mutates. Copy, or loading a preset twice would find the
        -- preset itself had been edited in the meantime.
        value = { value[1], value[2] }
    end
    local configurable = self.ui.document.configurable
    if configurable then
        configurable[spec.configurable] = value
    end
    self.ui:handleEvent(Event:new(spec.event, value))
end

-- Applying ------------------------------------------------------------------

function ReadingStyle:getCss()
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
    self.pending = true
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
    UIManager:unschedule(self.apply_callback)
    self.css = nil
    self.pending = false
    self.ui:handleEvent(Event:new("ApplyStyleSheet"))
end

function ReadingStyle:hasPendingChanges()
    return self.pending == true
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
    self.preset_name = preset.name or self:findPresetName(preset)
    self:styleChanged(true)
end

--- Name a user preset was saved under.
-- ui/presets stores presets keyed by name and hands the stored table straight
-- back on load, without a name inside it, so identity is what we have to go on.
function ReadingStyle:findPresetName(preset)
    for name, stored in pairs(self.preset_obj.presets) do
        if stored == preset then return name end
    end
end

function ReadingStyle:loadBuiltinPreset(id)
    local preset = Builtin.getBuiltin(id)
    if not preset then return end
    local copy = Builtin.copy(preset)
    copy.name = preset.name
    self:loadPreset(copy)
    Notification:notify(T(_("Reading style: %1"), preset.name))
end

--- Name to show as the current style, when it happens to match a known profile.
-- Counts both halves. A book whose line spacing or margins were changed is not
-- showing publisher defaults, whoever changed them and wherever they are stored,
-- so the label has to say so or it contradicts what the reader is looking at.
function ReadingStyle:getStyleName()
    if self.preset_name then return self.preset_name end
    local style = self:getStyle()
    local css_count = Settings.count(style)
    local engine_count = self:countChangedEngineValues()

    if css_count == 0 and engine_count == 0 then
        return _("Publisher default")
    end
    for _index, preset in ipairs(Builtin.BUILTIN) do
        if preset.id ~= "default"
                and Builtin.stylesMatch(style, preset.style, Settings.CSS_KEYS)
                and self:enginesMatch(preset.engine) then
            return preset.name
        end
    end
    return T(_("Custom (%1)"), css_count + engine_count)
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

function ReadingStyle:resetStyle(keys)
    local style = self:getStyle()
    if keys then
        for _index, key in ipairs(keys) do
            style[key] = nil
        end
    else
        Settings.clear(style)
    end
    self.preset_name = nil
    self:styleChanged(true)
end

function ReadingStyle:confirmReset(keys, text, touchmenu_instance)
    UIManager:show(ConfirmBox:new{
        text = text,
        ok_text = _("Reset"),
        ok_callback = function()
            self:resetStyle(keys)
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
    G_reader_settings:saveSetting(SETTING_STYLE, self.global_style)
    G_reader_settings:saveSetting(SETTING_LANGUAGES, self.language_styles)
end

function ReadingStyle:onCloseWidget()
    if self.apply_callback then
        UIManager:unschedule(self.apply_callback)
    end
end

return ReadingStyle
