--[[--
Reading style — built-in profiles.

Data only; the sole KOReader dependency is gettext for the profile names, so a
test can load this in plain LuaJIT by stubbing that one module.

A preset is a snapshot of both halves of the plugin:

    {
        style  = { ... CSS keys, see readingstyle_settings.CSS_KEYS ... },
        engine = { ... KOReader document settings, ENGINE_KEYS ... },
    }

Either half may be absent or partial. Loading a preset replaces the whole style
table (so a preset that does not mention paragraph spacing turns it off, rather
than leaving the previous value behind) but only touches the engine settings it
actually names — the others are KOReader's business and are left alone.

The built-ins below are the five profiles from the design document. They are
read-only; "save as preset" writes user presets into G_reader_settings instead.
--]]

local _ = require("readingstyle_gettext")

local Presets = {}

--- Margin values are KOReader's unscaled units, matching defaults.lua
-- (DCREREADER_CONFIG_*_MARGIN_SIZES_*): 5 small, 10 medium, 15 large.
Presets.BUILTIN = {
    {
        id = "default",
        name = _("Publisher default"),
        description = _("Clears every reading style setting and lets the book look the way its publisher intended."),
        style = {},
        engine = {},
    },
    {
        id = "compact",
        name = _("Compact"),
        description = _("Tight lines and small margins, no space between paragraphs. Fits the most text on a page."),
        style = {
            para_indent = 1,
            para_spacing = 0,
            first_para_no_indent = true,
            chapter_space_before = 1,
            chapter_space_after = 0.5,
            text_align = "justify",
        },
        engine = {
            line_spacing = 95,
            h_page_margins = { 5, 5 },
            t_page_margin = 5,
            b_page_margin = 5,
        },
    },
    {
        id = "traditional",
        name = _("Traditional"),
        description = _("Printed-book typography: indented paragraphs with no gap between them, centred chapter titles with room above."),
        style = {
            para_indent = 1.5,
            para_spacing = 0,
            first_para_no_indent = true,
            chapter_space_before = 2,
            chapter_space_after = 1,
            chapter_align = "center",
            text_align = "justify",
        },
        engine = {
            line_spacing = 100,
            h_page_margins = { 10, 10 },
            t_page_margin = 10,
            b_page_margin = 10,
        },
    },
    {
        id = "spacious",
        name = _("Spacious"),
        description = _("Blank line between paragraphs, no indentation, generous line spacing and margins. Easy on tired eyes."),
        style = {
            para_indent = 0,
            para_spacing = 0.8,
            chapter_space_before = 3,
            chapter_space_after = 1.5,
            chapter_align = "center",
            text_align = "justify",
        },
        engine = {
            line_spacing = 120,
            h_page_margins = { 15, 15 },
            t_page_margin = 15,
            b_page_margin = 15,
        },
    },
    {
        id = "ereader",
        name = _("E-reader"),
        description = _("The familiar e-reader look: no indentation, a small gap between paragraphs, moderate spacing throughout."),
        style = {
            para_indent = 0,
            para_spacing = 0.5,
            chapter_space_before = 2,
            chapter_space_after = 1,
            text_align = "justify",
        },
        engine = {
            line_spacing = 110,
            h_page_margins = { 10, 10 },
            t_page_margin = 10,
            b_page_margin = 10,
        },
    },
}

function Presets.getBuiltin(id)
    for _index, preset in ipairs(Presets.BUILTIN) do
        if preset.id == id then return preset end
    end
end

--- True when the style half of a preset matches the given style table exactly.
-- Used to show which preset (if any) the current settings correspond to.
function Presets.stylesMatch(style, other, keys)
    style = style or {}
    other = other or {}
    for _index, key in ipairs(keys) do
        local a, b = style[key], other[key]
        if type(a) == "number" and type(b) == "number" then
            if math.abs(a - b) > 0.001 then return false end
        elseif a ~= b then
            return false
        end
    end
    return true
end

--- Deep-ish copy: presets are handed to callers that may mutate them.
function Presets.copy(preset)
    local copy = { style = {}, engine = {} }
    for key, value in pairs(preset.style or {}) do
        copy.style[key] = value
    end
    for key, value in pairs(preset.engine or {}) do
        if type(value) == "table" then
            copy.engine[key] = { value[1], value[2] }
        else
            copy.engine[key] = value
        end
    end
    return copy
end

return Presets
