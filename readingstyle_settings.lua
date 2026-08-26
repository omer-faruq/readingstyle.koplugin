--[[--
Reading style — settings model.

Pure Lua, no KOReader dependencies: directly testable in plain LuaJIT.

A style table holds only the keys the user has explicitly set. An absent key
means "leave the publisher's styles alone" — the plugin is additive by design
and never blanket-overrides what it was not asked to.

Two kinds of settings live side by side:

  CSS keys     Turned into a stylesheet snippet by readingstyle_css and appended
               to KOReader's style tweaks. Owned and stored by this plugin, and
               scoped (all books / this book / books in this language).

  Engine keys  Line spacing, word spacing, page margins. These are KOReader's own
               document settings; the plugin drives them through events and reads
               them back from document.configurable. They are deliberately NOT
               stored here — KOReader already persists them per book, and a second
               copy would only drift out of sync. They are captured in presets,
               which is the one place a snapshot actually makes sense.
--]]

local Settings = {}

--- Style keys this plugin owns and renders into CSS.
-- kind:    "number" | "bool" | "enum" | "string"
-- default: value used when the setting is switched on from "book default"
Settings.CSS_SCHEMA = {
    -- Paragraphs
    para_indent           = { kind = "number", min = 0,    max = 6,   step = 0.1,  precision = "%.1f", unit = "em", default = 1.2 },
    para_spacing          = { kind = "number", min = 0,    max = 4,   step = 0.1,  precision = "%.1f", unit = "em", default = 0.5 },
    first_para_no_indent  = { kind = "bool" },
    first_para_no_spacing = { kind = "bool" },
    avoid_widows_orphans  = { kind = "bool" },
    quote_style           = { kind = "enum", values = { "indented", "indented_italic", "plain" }, default = "indented" },
    -- Chapters
    chapter_space_before  = { kind = "number", min = 0,    max = 10,  step = 0.5,  precision = "%.1f", unit = "em", default = 2 },
    chapter_space_after   = { kind = "number", min = 0,    max = 6,   step = 0.1,  precision = "%.1f", unit = "em", default = 1 },
    chapter_font_size     = { kind = "number", min = 50,   max = 250, step = 5,    precision = "%d",   unit = "%",  default = 120 },
    chapter_align         = { kind = "enum", values = { "left", "center", "right" }, default = "center" },
    chapter_bold          = { kind = "bool" },
    chapter_italic        = { kind = "bool" },
    chapter_uppercase     = { kind = "bool" },
    chapter_small_caps    = { kind = "bool" },
    chapter_rule          = { kind = "bool" },
    -- Which heading levels count as a chapter. Unset keeps the historical
    -- behaviour (all three), so an existing style keeps looking the same.
    chapter_levels        = { kind = "enum", values = { "h1", "h1h2", "h1h2h3" }, default = "h1h2" },
    chapter_page_break    = { kind = "enum", values = { "h1", "h1h2" }, default = "h1" },
    -- Text
    text_align            = { kind = "enum", values = { "left", "justify", "right" }, default = "justify" },
    letter_spacing        = { kind = "number", min = -0.1, max = 0.5, step = 0.01, precision = "%.2f", unit = "em", default = 0.05 },
    emphasis_style        = { kind = "enum", values = { "bold", "underline" }, default = "bold" },
    sub_sup_smaller       = { kind = "bool" },
    -- Ink: what the page is made of, rather than how it is laid out
    force_black_text      = { kind = "bool" },
    no_background         = { kind = "bool" },
    link_black            = { kind = "bool" },
    link_no_underline     = { kind = "bool" },
    -- Images
    image_width           = { kind = "enum", values = { "original", "page", "text" }, default = "text" },
    image_align           = { kind = "enum", values = { "left", "center", "right" }, default = "center" },
    image_no_overflow     = { kind = "bool" },
    hide_images           = { kind = "bool" },
    -- Advanced
    pre_wrap              = { kind = "bool" },
    custom_css            = { kind = "string" },
}

--- Ordered for deterministic iteration (menus, presets, CSS, tests).
Settings.CSS_KEYS = {
    "para_indent", "para_spacing", "first_para_no_indent", "first_para_no_spacing",
    "avoid_widows_orphans", "quote_style",
    "chapter_levels", "chapter_space_before", "chapter_space_after",
    "chapter_font_size", "chapter_align", "chapter_bold", "chapter_italic",
    "chapter_uppercase", "chapter_small_caps", "chapter_rule", "chapter_page_break",
    "text_align", "letter_spacing", "emphasis_style", "sub_sup_smaller",
    "force_black_text", "no_background", "link_black", "link_no_underline",
    "image_width", "image_align", "image_no_overflow", "hide_images",
    "pre_wrap", "custom_css",
}

--- Keys grouped by the menu section that shows them, so a section can be marked
-- as changed and reset without repeating the list in the menu file.
Settings.PARAGRAPH_KEYS = {
    "para_indent", "para_spacing", "first_para_no_indent", "first_para_no_spacing",
    "avoid_widows_orphans", "quote_style",
}
Settings.CHAPTER_KEYS = {
    "chapter_levels", "chapter_space_before", "chapter_space_after",
    "chapter_font_size", "chapter_align", "chapter_bold", "chapter_italic",
    "chapter_uppercase", "chapter_small_caps", "chapter_rule", "chapter_page_break",
}
Settings.TEXT_KEYS = {
    "text_align", "letter_spacing", "emphasis_style", "sub_sup_smaller",
}
Settings.INK_KEYS = {
    "force_black_text", "no_background", "link_black", "link_no_underline",
}
Settings.IMAGE_KEYS = {
    "image_width", "image_align", "image_no_overflow", "hide_images",
}

--- Settings that belong to KOReader, driven through events.
-- configurable: key in document.configurable holding the current value
-- event:        event to dispatch to change it
-- pair:         value is a two-number table, with its own left/right ranges
-- global_key:   G_reader_settings key holding the user's own default ("save as
--               default" in KOReader writes these)
-- default_key:  G_defaults key with the built-in default, used when the reader
--               has never saved one. Both mirror what creoptions.lua marks with
--               a star, so "at default" here means the same as it does there.
-- default_value: literal fallback for the few settings creoptions declares a
--               default for inline, without a G_defaults entry.
-- precision:    format string, for the settings that are not whole numbers.
-- Ranges mirror frontend/ui/data/creoptions.lua, so the plugin cannot ask the
-- engine for a value KOReader's own config dialog would refuse.
Settings.ENGINE_SCHEMA = {
    line_spacing   = { configurable = "line_spacing",   event = "SetLineSpace",        min = 50, max = 200, step = 1, hold_step = 5, unit = "%",
                       global_key = "copt_line_spacing",   default_key = "DCREREADER_CONFIG_LINE_SPACE_PERCENT_MEDIUM" },
    word_expansion = { configurable = "word_expansion", event = "SetWordExpansion",    min = 0,  max = 20,  step = 1, hold_step = 4, unit = "%",
                       global_key = "copt_word_expansion", default_key = "DCREREADER_CONFIG_WORD_EXPANSION_NONE" },
    -- Ranges from creoptions.lua's "more options" panel. Contrast (font_gamma)
    -- is deliberately left out: KOReader stores it as an index into a gamma
    -- table rather than a value, which this min/max model cannot express.
    font_base_weight = { configurable = "font_base_weight", event = "SetFontBaseWeight",
                       min = -3, max = 5.5, step = 0.25, hold_step = 1, precision = "%+.2f",
                       global_key = "copt_font_base_weight", default_value = 0 },
    t_page_margin  = { configurable = "t_page_margin",  event = "SetPageTopMargin",    min = 0,  max = 60,  step = 1, hold_step = 5,
                       global_key = "copt_t_page_margin",  default_key = "DCREREADER_CONFIG_T_MARGIN_SIZES_LARGE" },
    b_page_margin  = { configurable = "b_page_margin",  event = "SetPageBottomMargin", min = 0,  max = 60,  step = 1, hold_step = 5,
                       global_key = "copt_b_page_margin",  default_key = "DCREREADER_CONFIG_B_MARGIN_SIZES_LARGE" },
    word_spacing   = {
        configurable = "word_spacing", event = "SetWordSpacing", pair = true, unit = "%",
        global_key = "copt_word_spacing", default_key = "DCREREADER_CONFIG_WORD_SPACING_MEDIUM",
        left  = { min = 10, max = 500, step = 1, hold_step = 10 }, -- scaling
        right = { min = 25, max = 100, step = 1, hold_step = 10 }, -- reduction
    },
    h_page_margins = {
        configurable = "h_page_margins", event = "SetPageHorizMargins", pair = true,
        global_key = "copt_h_page_margins", default_key = "DCREREADER_CONFIG_H_MARGIN_SIZES_MEDIUM",
        left  = { min = 0, max = 60, step = 1, hold_step = 5 },
        right = { min = 0, max = 60, step = 1, hold_step = 5 },
    },
}

--- Engine settings grouped by the menu section that shows them, so a section
-- can be marked as changed without hard-coding the list in two places.
Settings.TEXT_ENGINE_KEYS = {
    "line_spacing", "word_spacing", "word_expansion", "font_base_weight",
}
Settings.LAYOUT_ENGINE_KEYS = { "h_page_margins", "t_page_margin", "b_page_margin" }

Settings.ENGINE_KEYS = {
    "line_spacing", "word_spacing", "word_expansion", "font_base_weight",
    "h_page_margins", "t_page_margin", "b_page_margin",
}

--- Scopes a style table can be stored in, most specific first.
Settings.SCOPE_BOOK = "book"
Settings.SCOPE_LANGUAGE = "language"
Settings.SCOPE_GLOBAL = "global"

--- Spin widgets accumulate float error (1.2000000000000002); snap to the step.
local function round(value, step)
    local decimals = 1
    if step and step < 1 then
        decimals = step < 0.1 and 100 or 10
    end
    local offset = value >= 0 and 0.5 or -0.5
    return math.floor(value * decimals + offset) / decimals
end
Settings.round = round

local function isValidNumber(spec, value)
    return type(value) == "number"
        and value == value -- NaN
        and value >= spec.min and value <= spec.max
end

local function isValidEnum(spec, value)
    for _, allowed in ipairs(spec.values) do
        if value == allowed then return true end
    end
    return false
end

--- Hand-written CSS goes into doc_settings and G_reader_settings, which are
-- rewritten in full on every save. A runaway paste should not turn a settings
-- file into megabytes.
Settings.MAX_CUSTOM_CSS = 64 * 1024

--- Is this a value the schema accepts for this key?
function Settings.isValid(key, value)
    local spec = Settings.CSS_SCHEMA[key]
    if not spec or value == nil then return false end
    if spec.kind == "number" then return isValidNumber(spec, value) end
    if spec.kind == "bool"   then return type(value) == "boolean" end
    if spec.kind == "enum"   then return isValidEnum(spec, value) end
    if spec.kind == "string" then
        return type(value) == "string" and value ~= "" and #value <= Settings.MAX_CUSTOM_CSS
    end
    return false
end

--- Sets a key, dropping it entirely when value is nil ("use book default").
function Settings.set(style, key, value)
    if value == nil then
        style[key] = nil
        return true
    end
    local spec = Settings.CSS_SCHEMA[key]
    if spec and spec.kind == "number" and type(value) == "number" then
        -- Clamp rather than reject: a spin widget can only reach the bounds anyway,
        -- and a preset written by another version should not silently lose a setting.
        value = math.max(spec.min, math.min(spec.max, round(value, spec.step)))
    end
    if not Settings.isValid(key, value) then return false end
    style[key] = value
    return true
end

function Settings.isSet(style, key)
    return style ~= nil and style[key] ~= nil
end

--- Value, or the schema default when unset (where does "+" start from?).
function Settings.getOrDefault(style, key)
    if style and style[key] ~= nil then return style[key] end
    local spec = Settings.CSS_SCHEMA[key]
    return spec and spec.default
end

function Settings.copy(style)
    local copy = {}
    if style then
        for _, key in ipairs(Settings.CSS_KEYS) do
            copy[key] = style[key]
        end
    end
    return copy
end

function Settings.isEmpty(style)
    if not style then return true end
    for _, key in ipairs(Settings.CSS_KEYS) do
        if style[key] ~= nil then return false end
    end
    return true
end

function Settings.count(style)
    local n = 0
    if style then
        for _, key in ipairs(Settings.CSS_KEYS) do
            if style[key] ~= nil then n = n + 1 end
        end
    end
    return n
end

function Settings.clear(style)
    for _, key in ipairs(Settings.CSS_KEYS) do
        style[key] = nil
    end
    return style
end

--- Drops unknown and invalid keys, in place.
-- Settings outlive plugin versions and travel inside presets, so never trust them.
function Settings.sanitize(style)
    if type(style) ~= "table" then return {} end
    local known = {}
    for _, key in ipairs(Settings.CSS_KEYS) do
        known[key] = true
    end
    for key in pairs(style) do
        if not known[key] then
            style[key] = nil
        end
    end
    for _, key in ipairs(Settings.CSS_KEYS) do
        local value = style[key]
        if value ~= nil then
            style[key] = nil
            Settings.set(style, key, value)
        end
    end
    return style
end

--- What a plain on/off setting becomes when it is tapped: on, or back to unset.
-- These live here, as plain functions over a value, because expressing them
-- inline is where this went wrong once already: `enabled and nil or true` looks
-- like a conditional and is not one — nil is falsy, so the `or` always fires and
-- the setting could never be switched off again. Pure, and tested below.
function Settings.nextToggle(current)
    if current == true then return nil end
    return true
end

--- What a three-state setting becomes when it is tapped:
--- book default -> on -> off -> book default.
function Settings.nextTristate(current)
    if current == nil then return true end
    if current == true then return false end
    return nil
end

--- The value after `current` in a cycle, wrapping at the end.
-- `false` is allowed as a member and stands for "unset"; callers turn it back
-- into nil. Returns the first entry when `current` is not in the list.
function Settings.nextInCycle(cycle, current)
    for index, value in ipairs(cycle) do
        if value == current then
            return cycle[(index % #cycle) + 1]
        end
    end
    return cycle[1]
end

local function clampRange(range, value)
    if type(value) ~= "number" or value ~= value then return nil end
    return math.max(range.min, math.min(range.max, value))
end

--- Clamps a KOReader-owned value into the range its schema allows.
-- Returns nil when the value cannot be used at all, so the caller can skip the
-- key and warn instead of handing the engine something KOReader's own config
-- dialog would refuse. Presets travel between versions and devices and can be
-- hand-edited, so this is the gate every engine value passes through.
function Settings.clampEngine(key, value)
    local spec = Settings.ENGINE_SCHEMA[key]
    if not spec then return nil end
    if spec.pair then
        if type(value) ~= "table" then return nil end
        local left = clampRange(spec.left, value[1])
        local right = clampRange(spec.right, value[2])
        if left == nil or right == nil then return nil end
        return { left, right }
    end
    return clampRange(spec, value)
end

--- Sanitizes the whole per-language profile table, keys included.
-- A corrupted or hand-edited settings file can hold anything as a key; an entry
-- filed under a number or a stray boolean would never be reachable but would be
-- written back out forever.
function Settings.sanitizeLanguages(languages)
    if type(languages) ~= "table" then return {} end
    local drop = {}
    for code, style in pairs(languages) do
        if type(code) ~= "string" or Settings.languageKey(code) ~= code
                or type(style) ~= "table" then
            drop[#drop + 1] = code
        else
            Settings.sanitize(style)
        end
    end
    for _index, code in ipairs(drop) do
        languages[code] = nil
    end
    return languages
end

--- Normalizes a book language ("tr-TR", "TR") into a profile key ("tr").
function Settings.languageKey(language)
    if type(language) ~= "string" then return nil end
    return language:lower():match("^(%a%a%a?)")
end

return Settings
