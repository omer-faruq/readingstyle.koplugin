--[[--
Reading style — stylesheet generator.

Pure Lua, no KOReader dependencies: directly testable in plain LuaJIT.

Turns a style table (see readingstyle_settings) into a CSS snippet that is
appended to KOReader's style tweaks, and so lands at the very end of the
stylesheet crengine is given.

Two rules govern everything here:

  * A key that is not set emits nothing. The publisher's styles, and any style
    tweak the user enabled by hand, stay exactly as they are.

  * Order is the cascade. Our declarations all carry !important, so between our
    own rules the later one wins. Headings are therefore written after the
    generic text rules, and the user's custom CSS is written last of all.
--]]

local Css = {}

-- Chapter titles are h1 in most EPUBs, but plenty of books use h2 (and a few h3)
-- for the same purpose. Sub-sections at those levels get the treatment too; that
-- is the price of not knowing what the publisher meant by a heading.
local CHAPTER_HEADINGS = "h1, h2, h3"
local ALL_HEADINGS = "h1, h2, h3, h4, h5, h6"
local AFTER_HEADING = "h1 + p, h2 + p, h3 + p, h4 + p, h5 + p, h6 + p"

--- 1.5 -> "1.5em", 0 -> "0" (a bare zero needs no unit and reads better in logs).
local function em(value)
    if value == 0 then return "0" end
    return ("%gem"):format(value)
end

--- Collects lines, skipping nils, so builders can stay declarative.
local Sheet = {}
Sheet.__index = Sheet

local function newSheet()
    return setmetatable({ lines = {} }, Sheet)
end

function Sheet:add(line)
    if line then
        self.lines[#self.lines + 1] = line
    end
end

function Sheet:section(comment)
    if #self.lines > 0 then
        self.lines[#self.lines + 1] = ""
    end
    self.lines[#self.lines + 1] = ("/* %s */"):format(comment)
end

function Sheet:rule(selector, declarations)
    if #declarations == 0 then return end
    local parts = {}
    for _, declaration in ipairs(declarations) do
        parts[#parts + 1] = declaration .. " !important;"
    end
    self:add(("%s { %s }"):format(selector, table.concat(parts, " ")))
end

function Sheet:isEmpty()
    return #self.lines == 0
end

function Sheet:concat()
    return table.concat(self.lines, "\n")
end

local function buildParagraphs(sheet, style)
    if style.para_indent == nil and style.para_spacing == nil then return end
    sheet:section("Paragraphs")

    if style.para_indent ~= nil then
        sheet:rule("p", { ("text-indent: %s"):format(em(style.para_indent)) })
        -- Publishers sometimes indent block containers, which then inherit down
        -- into the paragraph and double up. Take it back from everything but p.
        sheet:rule("body, h1, h2, h3, h4, h5, h6, div, li, td, th", { "text-indent: 0" })
    end

    if style.para_spacing ~= nil then
        -- Clear the publisher's own paragraph margins first, so the value the
        -- user picked is the value they get, rather than being added to it.
        sheet:rule("p", { "margin-top: 0", "margin-bottom: 0" })
        if style.para_spacing > 0 then
            sheet:rule("p + p", { ("margin-top: %s"):format(em(style.para_spacing)) })
        end
    end
end

local function buildFirstParagraph(sheet, style)
    local declarations = {}
    if style.first_para_no_indent then
        declarations[#declarations + 1] = "text-indent: 0"
    end
    if style.first_para_no_spacing then
        declarations[#declarations + 1] = "margin-top: 0"
    end
    if #declarations == 0 then return end

    sheet:section("First paragraph after a heading")
    -- Only reaches paragraphs that are a direct sibling of the heading. Books
    -- that wrap their chapter opening in a container are out of reach; there is
    -- no selector for "first paragraph of the chapter" without knowing the markup.
    sheet:rule(AFTER_HEADING, declarations)
end

local function buildText(sheet, style)
    if style.text_align == nil and style.letter_spacing == nil then return end
    sheet:section("Text")

    if style.text_align ~= nil then
        sheet:rule("body, p, li", { ("text-align: %s"):format(style.text_align) })
    end
    if style.letter_spacing ~= nil then
        sheet:rule("body, p, li", { ("letter-spacing: %s"):format(em(style.letter_spacing)) })
    end
end

local function buildChapters(sheet, style)
    local spacing = {}
    if style.chapter_space_before ~= nil then
        spacing[#spacing + 1] = ("margin-top: %s"):format(em(style.chapter_space_before))
    end
    if style.chapter_space_after ~= nil then
        spacing[#spacing + 1] = ("margin-bottom: %s"):format(em(style.chapter_space_after))
    end
    if style.chapter_font_size ~= nil then
        spacing[#spacing + 1] = ("font-size: %d%%"):format(style.chapter_font_size)
    end
    if style.chapter_bold ~= nil then
        spacing[#spacing + 1] = ("font-weight: %s"):format(style.chapter_bold and "bold" or "normal")
    end
    if style.chapter_italic ~= nil then
        spacing[#spacing + 1] = ("font-style: %s"):format(style.chapter_italic and "italic" or "normal")
    end
    if style.chapter_uppercase ~= nil then
        spacing[#spacing + 1] = ("text-transform: %s"):format(style.chapter_uppercase and "uppercase" or "none")
    end

    if #spacing == 0 and style.chapter_align == nil then return end
    sheet:section("Chapter titles")

    if #spacing > 0 then
        sheet:rule(CHAPTER_HEADINGS, spacing)
    end
    if style.chapter_align ~= nil then
        -- All six levels: a centred h1 above a left-aligned h4 looks like a bug.
        -- Written after the text rules above so it wins over the inherited body
        -- alignment on books that leave their headings unstyled.
        sheet:rule(ALL_HEADINGS, { ("text-align: %s"):format(style.chapter_align) })
    end
end

local function buildImages(sheet, style)
    if style.image_width == nil and style.image_align == nil and not style.image_no_overflow then
        return
    end
    sheet:section("Images")

    local declarations = {}
    if style.image_width == "page" then
        -- Blows the image up to the full text column, aspect ratio be damned on
        -- books that set explicit pixel dimensions. Useful for comics and plates.
        declarations[#declarations + 1] = "width: 100%"
        declarations[#declarations + 1] = "height: auto"
    elseif style.image_width == "text" then
        declarations[#declarations + 1] = "max-width: 100%"
        declarations[#declarations + 1] = "height: auto"
    end
    if style.image_no_overflow then
        declarations[#declarations + 1] = "max-width: 100%"
        declarations[#declarations + 1] = "max-height: 100%"
    end

    if style.image_align ~= nil then
        -- Alignment needs the image to be a block, which pulls inline images
        -- (drop caps, inline icons) out of their line. Accepted trade-off: the
        -- setting is off unless asked for.
        declarations[#declarations + 1] = "display: block"
        declarations[#declarations + 1] = "text-indent: 0"
        if style.image_align == "center" then
            declarations[#declarations + 1] = "margin-left: auto"
            declarations[#declarations + 1] = "margin-right: auto"
        elseif style.image_align == "left" then
            declarations[#declarations + 1] = "margin-left: 0"
            declarations[#declarations + 1] = "margin-right: auto"
        else
            declarations[#declarations + 1] = "margin-left: auto"
            declarations[#declarations + 1] = "margin-right: 0"
        end
    elseif style.image_width == "page" then
        declarations[#declarations + 1] = "display: block"
    end

    sheet:rule("img", declarations)
end

local function buildCustom(sheet, style)
    if type(style.custom_css) ~= "string" then return end
    local custom = style.custom_css:match("^%s*(.-)%s*$")
    if custom == "" then return end
    sheet:section("Custom CSS")
    -- Last in the sheet on purpose: whatever the user wrote by hand outranks
    -- everything the controls above produced.
    sheet:add(custom)
end

--- Builds the stylesheet snippet for a style table. Always returns a string.
function Css.build(style)
    if type(style) ~= "table" then return "" end

    local sheet = newSheet()
    buildParagraphs(sheet, style)
    buildFirstParagraph(sheet, style)
    buildText(sheet, style)
    buildChapters(sheet, style)
    buildImages(sheet, style)
    buildCustom(sheet, style)

    if sheet:isEmpty() then return "" end
    return "/* Reading style */\n" .. sheet:concat()
end

return Css
