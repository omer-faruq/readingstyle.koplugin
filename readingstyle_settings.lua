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
    -- Chapters
    chapter_space_before  = { kind = "number", min = 0,    max = 10,  step = 0.5,  precision = "%.1f", unit = "em", default = 2 },
    chapter_space_after   = { kind = "number", min = 0,    max = 6,   step = 0.1,  precision = "%.1f", unit = "em", default = 1 },
    chapter_font_size     = { kind = "number", min = 50,   max = 250, step = 5,    precision = "%d",   unit = "%",  default = 120 },
    chapter_align         = { kind = "enum", values = { "left", "center", "right" }, default = "center" },
    chapter_bold          = { kind = "bool" },
    chapter_italic        = { kind = "bool" },
    chapter_uppercase     = { kind = "bool" },
    -- Text
    text_align            = { kind = "enum", values = { "left", "justify", "right" }, default = "justify" },
    letter_spacing        = { kind = "number", min = -0.1, max = 0.5, step = 0.01, precision = "%.2f", unit = "em", default = 0.05 },
    -- Images
    image_width           = { kind = "enum", values = { "original", "page", "text" }, default = "text" },
    image_align           = { kind = "enum", values = { "left", "center", "right" }, default = "center" },
    image_no_overflow     = { kind = "bool" },
    -- Advanced
    custom_css            = { kind = "string" },
}

--- Ordered for deterministic iteration (menus, presets, CSS, tests).
Settings.CSS_KEYS = {
    "para_indent", "para_spacing", "first_para_no_indent", "first_para_no_spacing",
    "chapter_space_before", "chapter_space_after", "chapter_font_size",
    "chapter_align", "chapter_bold", "chapter_italic", "chapter_uppercase",
    "text_align", "letter_spacing",
    "image_width", "image_align", "image_no_overflow",
    "custom_css",
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
-- Ranges mirror frontend/ui/data/creoptions.lua, so the plugin cannot ask the
-- engine for a value KOReader's own config dialog would refuse.
Settings.ENGINE_SCHEMA = {
    line_spacing   = { configurable = "line_spacing",   event = "SetLineSpace",        min = 50, max = 200, step = 1, hold_step = 5, unit = "%",
                       global_key = "copt_line_spacing",   default_key = "DCREREADER_CONFIG_LINE_SPACE_PERCENT_MEDIUM" },
    word_expansion = { configurable = "word_expansion", event = "SetWordExpansion",    min = 0,  max = 20,  step = 1, hold_step = 4, unit = "%",
                       global_key = "copt_word_expansion", default_key = "DCREREADER_CONFIG_WORD_EXPANSION_NONE" },
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
Settings.TEXT_ENGINE_KEYS = { "line_spacing", "word_spacing", "word_expansion" }
Settings.LAYOUT_ENGINE_KEYS = { "h_page_margins", "t_page_margin", "b_page_margin" }

Settings.ENGINE_KEYS = {
    "line_spacing", "word_spacing", "word_expansion",
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

--- Is this a value the schema accepts for this key?
function Settings.isValid(key, value)
    local spec = Settings.CSS_SCHEMA[key]
    if not spec or value == nil then return false end
    if spec.kind == "number" then return isValidNumber(spec, value) end
    if spec.kind == "bool"   then return type(value) == "boolean" end
    if spec.kind == "enum"   then return isValidEnum(spec, value) end
    if spec.kind == "string" then return type(value) == "string" and value ~= "" end
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

--- Normalizes a book language ("tr-TR", "TR") into a profile key ("tr").
function Settings.languageKey(language)
    if type(language) ~= "string" then return nil end
    return language:lower():match("^(%a%a%a?)")
end

return Settings
