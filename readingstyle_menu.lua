--[[--
Reading style — the menu tree.

Every control here follows the same three-state contract: a setting is either at
"book default" (the plugin emits nothing for it and the publisher's styles apply)
or at an explicit value the reader chose. Numeric rows open a spin widget whose
extra button puts the setting back to "book default"; enum rows are a radio list
with a "book default" entry at the top.

Nothing in this file re-implements a KOReader feature. Line spacing, word spacing
and margins are KOReader's own document settings, driven through their events;
the header and footer submenu is literally the one ReaderFooter builds, borrowed;
and the hand-written CSS editor for a single book is ReaderStyleTweak's.
--]]

local ConfirmBox = require("ui/widget/confirmbox")
local DoubleSpinWidget = require("ui/widget/doublespinwidget")
local Font = require("ui/font")
local InfoMessage = require("ui/widget/infomessage")
local InputDialog = require("ui/widget/inputdialog")
local SpinWidget = require("ui/widget/spinwidget")
local UIManager = require("ui/uimanager")
local util = require("util")
local _ = require("readingstyle_gettext")
local T = require("ffi/util").template

local Builtin = require("readingstyle_presets")
local Settings = require("readingstyle_settings")

local Menu = {}

local BOOK_DEFAULT = _("book default")

local ALIGN_LABELS = {
    left = _("Left"),
    center = _("Centered"),
    right = _("Right"),
    justify = _("Justified"),
}

local IMAGE_WIDTH_LABELS = {
    original = _("Original size"),
    page = _("Fit to page width"),
    text = _("Fit to text width"),
}

local TRISTATE_LABELS = {
    [true] = _("on"),
    [false] = _("off"),
}

-- Formatting ----------------------------------------------------------------

local function formatNumber(spec, value)
    local text = spec.precision:format(value)
    if spec.unit then
        -- Narrow no-break space, as KOReader does everywhere else.
        return text .. "\u{202F}" .. spec.unit
    end
    return text
end

local function formatValue(key, value)
    if value == nil then return BOOK_DEFAULT end
    local spec = Settings.CSS_SCHEMA[key]
    if spec.kind == "number" then return formatNumber(spec, value) end
    if spec.kind == "bool" then return TRISTATE_LABELS[value] end
    if spec.kind == "enum" then
        return (ALIGN_LABELS[value] or IMAGE_WIDTH_LABELS[value] or value)
    end
    return tostring(value)
end

--- Marks anything the reader has moved off "book default", so a changed setting
-- can be found by scanning down the menu instead of opening every submenu.
-- Sections carry the marker when anything inside them carries it.
local MODIFIED_MARKER = " *"

local function anySet(plugin, keys)
    for _index, key in ipairs(keys) do
        if plugin:getValue(key) ~= nil then return true end
    end
    return false
end

local function anyEngineChanged(plugin, keys)
    for _index, key in ipairs(keys) do
        if not plugin:isEngineDefault(key) then return true end
    end
    return false
end

--- engine_keys are KOReader's own settings, marked when they differ from the
-- default KOReader itself would star. The marker therefore means "this does not
-- look default", not "this plugin changed it" — the bottom config bar writes the
-- same settings and its changes show up here too.
local function marked(plugin, keys, text, engine_keys)
    if anySet(plugin, keys) or (engine_keys and anyEngineChanged(plugin, engine_keys)) then
        return text .. MODIFIED_MARKER
    end
    return text
end

local function rowText(title, key, plugin)
    local text = T("%1: %2", title, formatValue(key, plugin:getValue(key)))
    return marked(plugin, { key }, text)
end

-- Generic item builders -----------------------------------------------------

--- Numeric style setting: a row showing the value, opening a spin widget.
local function numberItem(plugin, key, title, help)
    local spec = Settings.CSS_SCHEMA[key]
    return {
        text_func = function() return rowText(title, key, plugin) end,
        help_text = help,
        keep_menu_open = true,
        callback = function(touchmenu_instance)
            local refresh = function()
                if touchmenu_instance then touchmenu_instance:updateItems() end
            end
            UIManager:show(SpinWidget:new{
                title_text = title,
                info_text = help,
                value = Settings.getOrDefault(plugin:getStyle(), key),
                value_min = spec.min,
                value_max = spec.max,
                value_step = spec.step,
                value_hold_step = spec.step * 10,
                precision = spec.precision,
                unit = spec.unit,
                default_value = spec.default,
                extra_text = _("Book default"),
                extra_callback = function()
                    plugin:setValue(key, nil, true)
                    refresh()
                end,
                callback = function(spin)
                    plugin:setValue(key, spin.value, true)
                    refresh()
                end,
            })
        end,
    }
end

--- Enum style setting: a radio submenu with "book default" at the top.
local function enumSubMenu(plugin, key, title, labels, help)
    local spec = Settings.CSS_SCHEMA[key]
    local items = {
        {
            text = _("Book default"),
            help_text = help,
            radio = true,
            separator = true,
            checked_func = function() return plugin:getValue(key) == nil end,
            callback = function() plugin:setValue(key, nil, true) end,
        },
    }
    for _index, value in ipairs(spec.values) do
        items[#items + 1] = {
            text = labels[value] or value,
            radio = true,
            checked_func = function() return plugin:getValue(key) == value end,
            callback = function() plugin:setValue(key, value, true) end,
        }
    end
    return {
        text_func = function() return rowText(title, key, plugin) end,
        help_text = help,
        sub_item_table = items,
    }
end

--- Boolean style setting with three states, cycled by tapping:
--- book default -> on -> off -> book default.
-- A plain checkbox cannot express "leave it to the publisher", which for these
-- settings is a genuinely different answer from "off".
local function tristateItem(plugin, key, title, help)
    return {
        text_func = function() return rowText(title, key, plugin) end,
        help_text = help,
        keep_menu_open = true,
        callback = function(touchmenu_instance)
            local current = plugin:getValue(key)
            local next_value
            if current == nil then
                next_value = true
            elseif current == true then
                next_value = false
            end
            plugin:setValue(key, next_value, true)
            if touchmenu_instance then touchmenu_instance:updateItems() end
        end,
    }
end

--- Plain on/off style setting, where "off" and "unset" mean the same thing.
local function toggleItem(plugin, key, title, help)
    return {
        -- The checkbox already says on or off; the marker is what makes the
        -- parent sections consistent with the rows underneath them.
        text_func = function() return marked(plugin, { key }, title) end,
        help_text = help,
        checked_func = function() return plugin:getValue(key) == true end,
        callback = function() plugin:toggleValue(key) end,
    }
end

--- One of KOReader's own numeric document settings.
local function engineNumberItem(plugin, key, title, help)
    local spec = Settings.ENGINE_SCHEMA[key]
    return {
        text_func = function()
            local value = plugin:getEngineValue(key)
            local text = value and tostring(math.floor(value)) or "?"
            if value and spec.unit then
                text = text .. "\u{202F}" .. spec.unit
            end
            return marked(plugin, {}, T("%1: %2", title, text), { key })
        end,
        help_text = help,
        keep_menu_open = true,
        callback = function(touchmenu_instance)
            UIManager:show(SpinWidget:new{
                title_text = title,
                info_text = help,
                value = plugin:getEngineValue(key) or spec.min,
                value_min = spec.min,
                value_max = spec.max,
                value_step = spec.step,
                value_hold_step = spec.hold_step or spec.step,
                unit = spec.unit,
                callback = function(spin)
                    plugin:setEngineValue(key, spin.value)
                    if touchmenu_instance then touchmenu_instance:updateItems() end
                end,
            })
        end,
    }
end

--- One of KOReader's paired document settings (word spacing, L/R margins).
local function enginePairItem(plugin, key, title, left_text, right_text, help)
    local spec = Settings.ENGINE_SCHEMA[key]
    return {
        text_func = function()
            local value = plugin:getEngineValue(key)
            if type(value) ~= "table" then return title end
            local unit = spec.unit and ("\u{202F}" .. spec.unit) or ""
            return marked(plugin, {},
                T("%1: %2%4, %3%4", title, math.floor(value[1]), math.floor(value[2]), unit),
                { key })
        end,
        help_text = help,
        keep_menu_open = true,
        callback = function(touchmenu_instance)
            local value = plugin:getEngineValue(key) or { spec.left.min, spec.right.min }
            UIManager:show(DoubleSpinWidget:new{
                title_text = title,
                info_text = help,
                left_text = left_text,
                left_value = value[1],
                left_min = spec.left.min,
                left_max = spec.left.max,
                left_step = spec.left.step,
                left_hold_step = spec.left.hold_step,
                right_text = right_text,
                right_value = value[2],
                right_min = spec.right.min,
                right_max = spec.right.max,
                right_step = spec.right.step,
                right_hold_step = spec.right.hold_step,
                unit = spec.unit,
                callback = function(left, right)
                    plugin:setEngineValue(key, { left, right })
                    if touchmenu_instance then touchmenu_instance:updateItems() end
                end,
            })
        end,
    }
end

local function resetItem(plugin, keys, title, question)
    return {
        text = title,
        keep_menu_open = true,
        enabled_func = function()
            local style = plugin:getStyle()
            for _index, key in ipairs(keys) do
                if style[key] ~= nil then return true end
            end
            return false
        end,
        callback = function(touchmenu_instance)
            plugin:confirmReset(keys, question, touchmenu_instance)
        end,
    }
end

-- Sections ------------------------------------------------------------------

local FIRST_PARA_KEYS = { "first_para_no_indent", "first_para_no_spacing" }
local PARAGRAPH_KEYS = { "para_indent", "para_spacing", "first_para_no_indent", "first_para_no_spacing" }

local function paragraphsMenu(plugin)
    return {
        text_func = function() return marked(plugin, PARAGRAPH_KEYS, _("Paragraphs")) end,
        sub_item_table = {
            numberItem(plugin, "para_indent", _("Paragraph indentation"),
                _("How far the first line of each paragraph is indented. Also clears indentation inherited from containers, headings, list items and table cells, which is where doubled-up indents come from.")),
            numberItem(plugin, "para_spacing", _("Space between paragraphs"),
                _("Vertical whitespace between paragraphs. The publisher's own paragraph margins are cleared first, so the value you choose is the value you get instead of being added on top.")),
            {
                text_func = function()
                    return marked(plugin, FIRST_PARA_KEYS, _("First paragraph after a heading"))
                end,
                separator = true,
                sub_item_table = {
                    toggleItem(plugin, "first_para_no_indent", _("No indentation"),
                        _("Do not indent the first line of the paragraph that follows a heading, which is the usual typographic convention.\n\nOnly reaches paragraphs that directly follow the heading. Books that wrap their chapter opening in a container are out of reach.")),
                    toggleItem(plugin, "first_para_no_spacing", _("No space above"),
                        _("Remove the paragraph spacing above the first paragraph after a heading, so it sits directly under the chapter title.")),
                },
            },
            resetItem(plugin, PARAGRAPH_KEYS, _("Reset paragraph settings"),
                _("Reset the paragraph settings to the publisher's defaults?")),
        },
    }
end

local CHAPTER_KEYS = {
    "chapter_space_before", "chapter_space_after", "chapter_font_size",
    "chapter_align", "chapter_bold", "chapter_italic", "chapter_uppercase",
}

local CHAPTER_STYLE_KEYS = { "chapter_bold", "chapter_italic", "chapter_uppercase" }

local CHAPTER_HELP = _("Applies to h1, h2 and h3 headings.\n\nBooks that do not mark their chapter titles as real headings — a styled paragraph inside a container, say — cannot be reached by any of these settings.")

local function chaptersMenu(plugin)
    return {
        text_func = function() return marked(plugin, CHAPTER_KEYS, _("Chapters")) end,
        sub_item_table = {
            numberItem(plugin, "chapter_space_before", _("Space before chapter title"),
                _("Whitespace above chapter and section titles, so a chapter does not start flush against the top of the page.\n\n") .. CHAPTER_HELP),
            numberItem(plugin, "chapter_space_after", _("Space after chapter title"),
                _("Whitespace between a chapter title and the text that follows it.\n\n") .. CHAPTER_HELP),
            numberItem(plugin, "chapter_font_size", _("Chapter title size"),
                _("Size of chapter titles, as a percentage of the surrounding text.\n\n") .. CHAPTER_HELP),
            enumSubMenu(plugin, "chapter_align", _("Chapter title alignment"), ALIGN_LABELS,
                _("Alignment of headings. Applies to all six heading levels, so a centred chapter title does not sit above left-aligned sub-headings.")),
            {
                text_func = function()
                    return marked(plugin, CHAPTER_STYLE_KEYS, _("Chapter title style"))
                end,
                separator = true,
                sub_item_table = {
                    tristateItem(plugin, "chapter_bold", _("Bold"),
                        _("Tap to cycle: book default, on, off.\n\n\"Off\" is not the same as \"book default\": it actively un-bolds titles the publisher made bold.")),
                    tristateItem(plugin, "chapter_italic", _("Italic")),
                    tristateItem(plugin, "chapter_uppercase", _("Uppercase")),
                },
            },
            resetItem(plugin, CHAPTER_KEYS, _("Reset chapter settings"),
                _("Reset the chapter title settings to the publisher's defaults?")),
        },
    }
end

local TEXT_KEYS = { "text_align", "letter_spacing" }

local function textMenu(plugin)
    return {
        text_func = function()
            return marked(plugin, TEXT_KEYS, _("Text"), Settings.TEXT_ENGINE_KEYS)
        end,
        sub_item_table = {
            engineNumberItem(plugin, "line_spacing", _("Line spacing"),
                _("Height of each line, as a percentage. This is KOReader's own line spacing setting, the same one the bottom menu changes.")),
            enumSubMenu(plugin, "text_align", _("Text alignment"), ALIGN_LABELS,
                _("Alignment of body text, paragraphs and list items. Headings keep their own alignment setting.")),
            numberItem(plugin, "letter_spacing", _("Letter spacing"),
                _("Extra space between individual letters. Small amounts can help legibility; anything above about 0.1 em starts to look stretched.")),
            enginePairItem(plugin, "word_spacing", _("Word spacing"), _("Scaling"), _("Reduction"),
                _("Two numbers, and only the first one pushes words apart.\n\nScaling is the width of every space, as a percentage of the font's own space character. 100% is the font's natural width, and KOReader's default is 95% — slightly narrower. Go above 100% for wider gaps.\n\nReduction is how far justification may squeeze those spaces back to fit another word on the line. 100% forbids squeezing, so raise it as well or the wider gaps will not hold.")),
            engineNumberItem(plugin, "word_expansion", _("Word expansion"),
                _("On justified lines with very wide gaps, allow the extra space to be spread inside words as letter spacing instead. Set as a percentage of the font size.")),
            resetItem(plugin, TEXT_KEYS, _("Reset text settings"),
                _("Reset the text settings this plugin controls to the publisher's defaults?\n\nLine spacing and word spacing belong to KOReader and are left alone.")),
        },
    }
end

--- Typography and hyphenation, borrowed from ReaderTypography.
-- That module builds a single tree covering the text language, hyphenation
-- (on/off, left/right limits, soft hyphens, algorithmic fallback, user
-- dictionaries) and hanging punctuation. All of it is reading style, and there
-- is real depth behind it — per-language pattern dictionaries loaded into
-- crengine — so a lesser copy here would be worse than useless.
--
-- The outer array is copied so the two menu trees do not share a table, but the
-- item tables themselves are the live ones: they carry the checked_func and
-- callbacks that drive ReaderTypography.
local function typographyMenu(plugin)
    local typography = plugin.ui.typography
    if not typography or not typography.menu_table then return nil end

    local items = { max_per_page = 7 }
    for _index, item in ipairs(typography.menu_table) do
        items[#items + 1] = item
    end

    return {
        text_func = function()
            return T(_("Typography and hyphenation: %1"),
                typography.hyphenation and _("hyphenation on") or _("hyphenation off"))
        end,
        help_text = _("KOReader's own typography rules, including hyphenation. The language chosen here decides which hyphenation dictionary is used, which is why it lives with the language setting rather than on its own."),
        separator = true,
        sub_item_table = items,
    }
end

local MARGIN_PRESETS = {
    { name = _("Narrow"), h = { 5, 5 },   t = 5,  b = 5 },
    { name = _("Normal"), h = { 10, 10 }, t = 10, b = 10 },
    { name = _("Wide"),   h = { 15, 15 }, t = 15, b = 15 },
}

local function pageLayoutMenu(plugin)
    local presets = {}
    for _index, preset in ipairs(MARGIN_PRESETS) do
        presets[#presets + 1] = {
            text = preset.name,
            keep_menu_open = true,
            callback = function(touchmenu_instance)
                plugin:setEngineValue("h_page_margins", { preset.h[1], preset.h[2] })
                plugin:setEngineValue("t_page_margin", preset.t)
                plugin:setEngineValue("b_page_margin", preset.b)
                if touchmenu_instance then touchmenu_instance:updateItems() end
            end,
        }
    end

    return {
        text_func = function()
            return marked(plugin, {}, _("Page layout"), Settings.LAYOUT_ENGINE_KEYS)
        end,
        sub_item_table = {
            {
                text = _("Margin presets"),
                separator = true,
                sub_item_table = presets,
            },
            enginePairItem(plugin, "h_page_margins", _("Left and right margins"), _("Left"), _("Right"),
                _("Horizontal page margins. These are what set the width of the text column: wider margins mean a narrower, easier-to-scan line.")),
            engineNumberItem(plugin, "t_page_margin", _("Top margin")),
            engineNumberItem(plugin, "b_page_margin", _("Bottom margin"),
                _("Space below the text. The status bar, when shown at the bottom, takes its height from here.")),
        },
    }
end

--- The header and footer submenu, borrowed whole from ReaderFooter.
-- ReaderFooter:addToMainMenu builds one "Status bar" entry that already covers
-- the top header (through ReaderCoptListener) and the bottom footer, with every
-- content option. Re-creating a lesser copy of it here would help nobody.
local function headersFootersMenu(plugin)
    local footer = plugin.ui.view and plugin.ui.view.footer
    if not footer or not footer.addToMainMenu then return nil end
    local borrowed = {}
    local ok = pcall(footer.addToMainMenu, footer, borrowed)
    if not ok or not borrowed.status_bar or not borrowed.status_bar.sub_item_table then
        return nil
    end
    return {
        text = _("Header and footer"),
        sub_item_table = borrowed.status_bar.sub_item_table,
    }
end

local IMAGE_KEYS = { "image_width", "image_align", "image_no_overflow" }

local function imagesMenu(plugin)
    return {
        text_func = function() return marked(plugin, IMAGE_KEYS, _("Images")) end,
        sub_item_table = {
            enumSubMenu(plugin, "image_width", _("Image width"), IMAGE_WIDTH_LABELS,
                _("\"Fit to text width\" only shrinks images that are too wide. \"Fit to page width\" also enlarges smaller ones, which can stretch images that carry explicit pixel dimensions.")),
            enumSubMenu(plugin, "image_align", _("Image alignment"), ALIGN_LABELS,
                _("Aligning images turns them into blocks, which pulls inline images — drop caps, small icons inside a line of text — out of their line. Leave at book default unless you need it.")),
            toggleItem(plugin, "image_no_overflow", _("Prevent images from overflowing the page"),
                _("Caps every image at the width and height of the page, so oversized images no longer spill past the margins.")),
            resetItem(plugin, IMAGE_KEYS, _("Reset image settings"),
                _("Reset the image settings to the publisher's defaults?")),
        },
    }
end

local function editCustomCss(plugin, touchmenu_instance)
    local editor
    editor = InputDialog:new{
        title = _("Custom CSS"),
        input = plugin:getValue("custom_css") or "",
        input_hint = "p.quote {\n    font-style: italic;\n}",
        input_face = Font:getFace("infont", 16),
        para_direction_rtl = false,
        lang = "en",
        fullscreen = true,
        condensed = true,
        allow_newline = true,
        cursor_at_end = false,
        add_nav_bar = true,
        scroll_by_pan = true,
        buttons = {{
            {
                text = _("Prettify"),
                callback = function()
                    editor:setInputText(util.prettifyCSS(editor:getInputText()), true)
                end,
            },
        }},
        save_callback = function(content)
            plugin:setValue("custom_css", content ~= "" and content or nil, true)
            if touchmenu_instance then touchmenu_instance:updateItems() end
            return true, _("Custom CSS applied")
        end,
    }
    UIManager:show(editor)
    editor:onShowKeyboard()
end

local function advancedMenu(plugin)
    return {
        text_func = function() return marked(plugin, { "custom_css" }, _("Advanced")) end,
        sub_item_table = {
            {
                text_func = function()
                    local custom = plugin:getValue("custom_css")
                    if custom then
                        return T(_("Custom CSS (%1 characters)"), #custom)
                    end
                    return _("Custom CSS")
                end,
                help_text = _("Hand-written CSS, appended after everything the controls above produce, so it always wins. It follows the scope you are editing in, exactly like the other settings."),
                keep_menu_open = true,
                callback = function(touchmenu_instance)
                    editCustomCss(plugin, touchmenu_instance)
                end,
            },
            {
                text = _("Edit this book's own tweak"),
                help_text = _("Opens KOReader's book-specific style tweak editor, with its CSS suggestions and prettifier. That tweak is stored by KOReader, separately from this plugin, and applies before these settings."),
                keep_menu_open = true,
                callback = function(touchmenu_instance)
                    plugin.ui.styletweak:onEditBookTweak(touchmenu_instance)
                end,
            },
            {
                text = _("About reading style and style tweaks"),
                keep_menu_open = true,
                callback = function()
                    UIManager:show(InfoMessage:new{
                        text = _([[
This plugin writes a small stylesheet and appends it after your style tweaks, so its settings win wherever the two overlap.

Anything left at "book default" emits nothing at all, and leaves your tweaks and the publisher's styles untouched.

Every change re-renders the book. That is normal, and is what KOReader does for any style change.]]),
                    })
                end,
            },
        },
    }
end

local function presetsMenu(plugin)
    -- Rebuilt on every open: saving, renaming or deleting a user preset has to
    -- show up here without reopening the menu.
    local function items()
        local list = {
            {
                text_func = function()
                    return T(_("Current style: %1"), plugin:getStyleName())
                end,
                enabled = false,
                separator = true,
            },
        }
        for _index, preset in ipairs(Builtin.BUILTIN) do
            list[#list + 1] = {
                text = preset.name,
                help_text = preset.description,
                keep_menu_open = true,
                callback = function(touchmenu_instance)
                    plugin:loadBuiltinPreset(preset.id)
                    if touchmenu_instance then touchmenu_instance:updateItems() end
                end,
            }
        end
        list[#list].separator = true
        for _index, item in ipairs(plugin:genPresetMenuItemTable()) do
            list[#list + 1] = item
        end
        return list
    end

    return {
        text = _("Presets"),
        sub_item_table_func = items,
    }
end

local function scopeMenu(plugin)
    local function scopeItem(scope, text, help, enabled_func)
        return {
            text = text,
            help_text = help,
            radio = true,
            enabled_func = enabled_func,
            checked_func = function() return plugin:getScope() == scope end,
            callback = function(touchmenu_instance)
                if plugin:getScope() == scope then return end
                local function switch()
                    plugin:setScope(scope)
                    if touchmenu_instance then touchmenu_instance:updateItems() end
                end
                if plugin:scopeChangeLosesSettings(scope) then
                    UIManager:show(ConfirmBox:new{
                        text = _("The settings you made for the narrower scope will be discarded, and the broader style takes over.\n\nContinue?"),
                        ok_text = _("Discard"),
                        ok_callback = switch,
                    })
                else
                    switch()
                end
            end,
        }
    end

    local language = plugin.language
    return {
        text_func = function()
            local scope = plugin:getScope()
            local label = _("All books")
            if scope == Settings.SCOPE_BOOK then
                label = _("This book")
            elseif scope == Settings.SCOPE_LANGUAGE then
                label = T(_("Books in %1"), language or "?")
            end
            return T(_("Apply to: %1"), label)
        end,
        sub_item_table = {
            scopeItem(Settings.SCOPE_GLOBAL, _("All books"),
                _("The style you edit here is used for every book that has no style of its own.")),
            scopeItem(Settings.SCOPE_LANGUAGE,
                language and T(_("Books in %1"), language) or _("Books in this language"),
                _("A separate style for books in this language, useful when one language reads better with different paragraph conventions.\n\nUnavailable when the book does not declare a language."),
                function() return language ~= nil end),
            scopeItem(Settings.SCOPE_BOOK, _("This book only"),
                _("A style stored with this book alone. It overrides both of the above.")),
        },
    }
end

-- Assembly ------------------------------------------------------------------

function Menu.build(plugin)
    local items = {
        {
            text = _("Quick style"),
            help_text = _("The settings people reach for most, on one screen. Can also be opened with a gesture."),
            keep_menu_open = true,
            separator = true,
            callback = function(touchmenu_instance)
                if touchmenu_instance then touchmenu_instance:closeMenu() end
                plugin:showQuickStyle()
            end,
        },
        paragraphsMenu(plugin),
        chaptersMenu(plugin),
        textMenu(plugin),
    }

    -- Hyphenation belongs with the text settings, and it comes attached to the
    -- language it depends on.
    local typography = typographyMenu(plugin)
    if typography then
        items[#items + 1] = typography
    end

    items[#items + 1] = pageLayoutMenu(plugin)

    local headers_footers = headersFootersMenu(plugin)
    if headers_footers then
        items[#items + 1] = headers_footers
    end

    items[#items + 1] = imagesMenu(plugin)
    local advanced = advancedMenu(plugin)
    advanced.separator = true
    items[#items + 1] = advanced

    items[#items + 1] = presetsMenu(plugin)
    items[#items + 1] = scopeMenu(plugin)
    items[#items + 1] = {
        text = _("Apply changes immediately"),
        help_text = _("On, changes appear as soon as you make them. Off, they are collected and only applied when you choose \"Apply now\".\n\nEach apply re-renders the book, so turning this off is worth it when you are changing several settings at once."),
        checked_func = function() return plugin.auto_apply end,
        callback = function() plugin:setAutoApply(not plugin.auto_apply) end,
    }
    items[#items + 1] = {
        text = _("Apply now"),
        keep_menu_open = true,
        enabled_func = function() return plugin:hasPendingChanges() end,
        callback = function() plugin:applyNow() end,
    }
    items[#items + 1] = {
        text = _("Reset all reading style settings"),
        keep_menu_open = true,
        separator = true,
        enabled_func = function() return not Settings.isEmpty(plugin:getStyle()) end,
        callback = function(touchmenu_instance)
            plugin:confirmReset(nil,
                _("This restores every reading style setting in the current scope to the publisher's defaults.\n\nKOReader's own settings — line spacing, margins, word spacing — are left alone."),
                touchmenu_instance)
        end,
    }

    return items
end

return Menu
