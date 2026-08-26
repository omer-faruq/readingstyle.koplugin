--[[--
Reading style — stylesheet generator.

Pure Lua, no KOReader dependencies: directly testable in plain LuaJIT.

Turns a style table (see readingstyle_settings) into a CSS snippet that is
appended to KOReader's style tweaks, and so lands at the very end of the
stylesheet crengine is given.

Three rules govern everything here:

  * A key that is not set emits nothing. The publisher's styles, and any style
    tweak the user enabled by hand, stay exactly as they are.

  * Order is the cascade. Our declarations all carry !important, so between our
    own rules the later one wins. Headings are therefore written after the
    generic text rules, and the user's custom CSS is written last of all.

  * Nothing goes in that KOReader's own tweak catalogue does not already use.
    frontend/ui/data/css_tweaks.lua is the authority on what crengine actually
    honours; selectors copied from there are marked as such.
--]]

local Css = {}

-- Which heading levels count as "a chapter". Books disagree: most use h1, plenty
-- use h2, a few use h3 for what a reader would call a chapter. Applying chapter
-- spacing down to h3 blows apart books with many sub-headings, which is why this
-- is a setting; an unset value keeps the widest behaviour for existing styles.
local CHAPTER_LEVELS = {
    h1 = "h1",
    h1h2 = "h1, h2",
    h1h2h3 = "h1, h2, h3",
}
local DEFAULT_CHAPTER_LEVELS = "h1h2h3"

local ALL_HEADINGS = "h1, h2, h3, h4, h5, h6"
local AFTER_HEADING = "h1 + p, h2 + p, h3 + p, h4 + p, h5 + p, h6 + p"

-- Paragraph spacing hangs off the previous sibling, so anything that can sit
-- between two paragraphs has to be listed or the gap silently disappears after
-- a picture or a pull quote. Not exhaustive, and cannot be: the publisher may
-- wrap anything in anything.
local BEFORE_PARAGRAPH =
    "p + p, blockquote + p, div + p, figure + p, img + p, table + p, ul + p, ol + p"

--- 1.5 -> "1.5em", 0 -> "0" (a bare zero needs no unit and reads better in logs).
local function em(value)
    if value == 0 then return "0" end
    return ("%gem"):format(value)
end

local function chapterSelector(style)
    return CHAPTER_LEVELS[style.chapter_levels] or CHAPTER_LEVELS[DEFAULT_CHAPTER_LEVELS]
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
    for _index, declaration in ipairs(declarations) do
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
    if style.para_indent == nil and style.para_spacing == nil
            and not style.avoid_widows_orphans then
        return
    end
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
            sheet:rule(BEFORE_PARAGRAPH, { ("margin-top: %s"):format(em(style.para_spacing)) })
        end
    end

    if style.avoid_widows_orphans then
        -- From css_tweaks.lua "widows_orphans_avoid". The DocFragment rule is the
        -- part that actually works on EPUB: crengine's per-fragment element is
        -- what the publisher's own rules are scoped against.
        sheet:add("body { orphans: 2; widows: 2; }")
        sheet:rule("DocFragment", { "orphans: 2", "widows: 2" })
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

local function buildQuotes(sheet, style)
    if style.quote_style == nil then return end
    sheet:section("Block quotes")

    if style.quote_style == "plain" then
        sheet:rule("blockquote", {
            "margin-left: 0", "margin-right: 0", "font-style: normal",
        })
        return
    end

    local declarations = { "margin-left: 2em", "margin-right: 2em" }
    if style.quote_style == "indented_italic" then
        declarations[#declarations + 1] = "font-style: italic"
    end
    sheet:rule("blockquote", declarations)
end

local function buildText(sheet, style)
    if style.text_align == nil and style.letter_spacing == nil
            and style.emphasis_style == nil and not style.sub_sup_smaller then
        return
    end
    sheet:section("Text")

    if style.text_align ~= nil then
        sheet:rule("body, p, li", { ("text-align: %s"):format(style.text_align) })
    end
    if style.letter_spacing ~= nil then
        sheet:rule("body, p, li", { ("letter-spacing: %s"):format(em(style.letter_spacing)) })
    end

    if style.emphasis_style == "bold" then
        sheet:rule("em, i", { "font-style: normal", "font-weight: bold" })
    elseif style.emphasis_style == "underline" then
        sheet:rule("em, i", { "font-style: normal", "text-decoration: underline" })
    end

    if style.sub_sup_smaller then
        -- From css_tweaks.lua "sub_sup_smaller": the vertical-align half is what
        -- stops footnote markers from stretching the line they sit on.
        sheet:rule("sup", { "font-size: 50%", "vertical-align: super" })
        sheet:rule("sub", { "font-size: 50%", "vertical-align: sub" })
    end
end

--- Colour, background and links: what the page is made of rather than how it is
-- laid out. All of it exists to fight publisher styling that assumes a backlit
-- screen — grey body text and tinted boxes print badly on e-ink.
local function buildInk(sheet, style)
    if not (style.force_black_text or style.no_background
            or style.link_black or style.link_no_underline) then
        return
    end
    sheet:section("Ink")

    if style.force_black_text then
        -- From css_tweaks.lua "pure_black_and_white", minus the background half,
        -- which is its own setting here.
        sheet:rule("*", { "color: black", "border-color: black" })
    end
    if style.no_background then
        -- The empty background-image is deliberate and comes from the same tweak:
        -- it is what cancels an inherited one in crengine.
        sheet:add("* { background-color: transparent !important; background-image: !important; }")
    end

    -- After the wildcards above, so links keep their own answer either way.
    if style.link_black then
        sheet:rule("a, a *", { "color: black" })
    end
    if style.link_no_underline then
        sheet:rule("a, a *", { "text-decoration: none" })
    end
end

local function buildChapters(sheet, style)
    local declarations = {}
    if style.chapter_space_before ~= nil then
        declarations[#declarations + 1] = ("margin-top: %s"):format(em(style.chapter_space_before))
    end
    if style.chapter_space_after ~= nil then
        declarations[#declarations + 1] = ("margin-bottom: %s"):format(em(style.chapter_space_after))
    end
    if style.chapter_font_size ~= nil then
        declarations[#declarations + 1] = ("font-size: %d%%"):format(style.chapter_font_size)
    end
    if style.chapter_bold ~= nil then
        declarations[#declarations + 1] = ("font-weight: %s"):format(style.chapter_bold and "bold" or "normal")
    end
    if style.chapter_italic ~= nil then
        declarations[#declarations + 1] = ("font-style: %s"):format(style.chapter_italic and "italic" or "normal")
    end
    if style.chapter_uppercase ~= nil then
        declarations[#declarations + 1] = ("text-transform: %s"):format(style.chapter_uppercase and "uppercase" or "none")
    end
    if style.chapter_small_caps ~= nil then
        declarations[#declarations + 1] = ("font-variant: %s"):format(style.chapter_small_caps and "small-caps" or "normal")
    end
    if style.chapter_rule then
        declarations[#declarations + 1] = "border-bottom: 1px solid"
        declarations[#declarations + 1] = "padding-bottom: 0.3em"
    end

    if #declarations == 0 and style.chapter_align == nil
            and style.chapter_page_break == nil then
        return
    end
    sheet:section("Chapter titles")

    local selector = chapterSelector(style)
    if #declarations > 0 then
        sheet:rule(selector, declarations)
    end

    if style.chapter_page_break ~= nil then
        local break_selector = style.chapter_page_break == "h1" and "h1" or "h1, h2"
        sheet:rule(break_selector, {
            "page-break-before: always",
            -- Keeps the title with the text it introduces, instead of stranded
            -- at the foot of the page it just started.
            "page-break-after: avoid",
        })
        if style.chapter_page_break == "h1h2" then
            -- A subtitle directly under a chapter title must not start a second
            -- page of its own. Copied from css_tweaks.lua "New page on <H2>".
            sheet:rule("h1 + h2", { "page-break-before: avoid" })
        end
    end

    if style.chapter_align ~= nil then
        -- All six levels regardless of what counts as a chapter: a centred h1
        -- above a left-aligned h4 looks like a bug rather than a choice. Written
        -- after the text rules above so it beats the inherited body alignment.
        sheet:rule(ALL_HEADINGS, { ("text-align: %s"):format(style.chapter_align) })
    end
end

local function buildImages(sheet, style)
    if style.hide_images then
        sheet:section("Images")
        -- Nothing else about images can matter once they are gone.
        sheet:rule("img, svg", { "display: none" })
        return
    end

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

local function buildPreformatted(sheet, style)
    if not style.pre_wrap then return end
    sheet:section("Preformatted text")
    -- Long code lines otherwise run off the page with no way to see the rest.
    sheet:rule("pre", { "white-space: pre-wrap" })
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
    buildQuotes(sheet, style)
    buildText(sheet, style)
    buildInk(sheet, style)
    buildChapters(sheet, style)
    buildImages(sheet, style)
    buildPreformatted(sheet, style)
    buildCustom(sheet, style)

    if sheet:isEmpty() then return "" end
    return "/* Reading style */\n" .. sheet:concat()
end

return Css
