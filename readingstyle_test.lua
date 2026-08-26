--[[--
Reading style — tests for the pure modules.

Run from the koreader directory:

    luajit plugins/readingstyle.koplugin/readingstyle_test.lua

Covers readingstyle_settings, readingstyle_css and readingstyle_presets, which
have no KOReader dependencies beyond the localization wrapper (stubbed below). The menu, the quick
style screen and main.lua need a running reader and are not covered here.
--]]

package.path = "plugins/readingstyle.koplugin/?.lua;" .. package.path
-- readingstyle_gettext pulls in the real gettext and logger, neither of which
-- exist outside KOReader. The identity stub is all these modules need.
package.preload["readingstyle_gettext"] = function()
    return setmetatable({}, { __call = function(_self, msgid) return msgid end })
end

local Settings = require("readingstyle_settings")
local Css = require("readingstyle_css")
local Builtin = require("readingstyle_presets")

local failures = 0
local function check(name, ok, detail)
    if ok then
        print("  ok   " .. name)
    else
        failures = failures + 1
        print("  FAIL " .. name .. (detail and ("  -> " .. tostring(detail)) or ""))
    end
end

print("settings")
local s = {}
check("unset style is empty", Settings.isEmpty(s))
check("set valid number", Settings.set(s, "para_indent", 1.2) and s.para_indent == 1.2)
check("float error is rounded", (function()
    Settings.set(s, "para_indent", 1.2000000000000002)
    return s.para_indent == 1.2
end)())
check("out of range is clamped", (function()
    Settings.set(s, "para_indent", 99)
    return s.para_indent == 6
end)())
check("nil clears the key", Settings.set(s, "para_indent", nil) and s.para_indent == nil)
check("bad enum rejected", not Settings.set(s, "text_align", "middle"))
check("good enum accepted", Settings.set(s, "text_align", "justify"))
check("count", Settings.count(s) == 1, Settings.count(s))
check("sanitize drops junk", (function()
    local dirty = { para_indent = 1.2, bogus = true, text_align = "sideways", chapter_font_size = 9999 }
    Settings.sanitize(dirty)
    return dirty.bogus == nil and dirty.text_align == nil
       and dirty.para_indent == 1.2 and dirty.chapter_font_size == 250
end)())
check("language key", Settings.languageKey("tr-TR") == "tr" and Settings.languageKey("EN") == "en"
    and Settings.languageKey(nil) == nil)
check("copy is detached", (function()
    local original = { para_indent = 1 }
    local copy = Settings.copy(original)
    copy.para_indent = 2
    return original.para_indent == 1
end)())

print("css")
check("empty style yields empty css", Css.build({}) == "")
check("non-table yields empty css", Css.build(nil) == "")

local css = Css.build({
    para_indent = 1.2,
    para_spacing = 0.5,
    first_para_no_indent = true,
    chapter_space_before = 2,
    chapter_align = "center",
    text_align = "justify",
})
print(css)
check("indent emitted", css:find("p { text%-indent: 1%.2em !important; }") ~= nil)
check("spacing clears publisher margins", css:find("p { margin%-top: 0 !important; margin%-bottom: 0 !important; }") ~= nil)
check("spacing between paragraphs", css:find("p %+ p { margin%-top: 0%.5em !important; }") ~= nil)
check("first paragraph after heading", css:find("h1 %+ p, h2 %+ p") ~= nil)
check("chapter space", css:find("h1, h2, h3 { margin%-top: 2em !important; }") ~= nil)
check("headings aligned after body align", css:find("body, p, li { text%-align") < css:find("h1, h2, h3, h4, h5, h6 { text%-align"))
check("zero has no unit", Css.build({ para_indent = 0 }):find("text%-indent: 0 !important") ~= nil)

local custom = Css.build({ para_indent = 1, custom_css = "  p.foo { color: red }  " })
check("custom css is last", custom:find("p%.foo") > custom:find("text%-indent"))
check("custom css is trimmed", custom:find("p%.foo { color: red }\n?$") ~= nil)
check("blank custom css skipped", Css.build({ custom_css = "   " }) == "")

local images = Css.build({ image_width = "text", image_align = "center", image_no_overflow = true })
check("image rule is a single block", select(2, images:gsub("img {", "")) == 1, images)
check("image centered", images:find("margin%-left: auto") ~= nil)

print("built-in presets")
check("five profiles", #Builtin.BUILTIN == 5, #Builtin.BUILTIN)

local seen = {}
for _index, preset in ipairs(Builtin.BUILTIN) do
    check(preset.id .. ": unique id", not seen[preset.id])
    seen[preset.id] = true
    check(preset.id .. ": has name and description",
        type(preset.name) == "string" and type(preset.description) == "string")

    for key, value in pairs(preset.style) do
        check(preset.id .. ": style key " .. key .. " is valid",
            Settings.isValid(key, value), tostring(value))
    end

    for key, value in pairs(preset.engine) do
        local spec = Settings.ENGINE_SCHEMA[key]
        check(preset.id .. ": engine key " .. key .. " is known", spec ~= nil)
        if spec then
            if spec.pair then
                check(preset.id .. ": " .. key .. " is a pair in range",
                    type(value) == "table"
                    and value[1] >= spec.left.min and value[1] <= spec.left.max
                    and value[2] >= spec.right.min and value[2] <= spec.right.max)
            else
                check(preset.id .. ": " .. key .. " in range",
                    type(value) == "number" and value >= spec.min and value <= spec.max, value)
            end
        end
    end

    -- Round trip: a preset must survive being written into a style table.
    local style = Settings.clear({})
    for key, value in pairs(preset.style) do
        Settings.set(style, key, value)
    end
    check(preset.id .. ": survives a round trip",
        Builtin.stylesMatch(style, preset.style, Settings.CSS_KEYS))

    local css = Css.build(preset.style)
    if preset.id == "default" then
        check("default emits no css", css == "")
    else
        check(preset.id .. ": emits css", css ~= "")
    end
end

print("copy is detached")
local copy = Builtin.copy(Builtin.getBuiltin("compact"))
copy.style.para_indent = 99
copy.engine.h_page_margins[1] = 99
check("style copy detached", Builtin.getBuiltin("compact").style.para_indent == 1)
check("engine pair copy detached", Builtin.getBuiltin("compact").engine.h_page_margins[1] == 5)
check("getBuiltin on unknown id", Builtin.getBuiltin("nope") == nil)

print("stylesMatch")
check("differs on one key", not Builtin.stylesMatch({ para_indent = 1 }, { para_indent = 2 }, Settings.CSS_KEYS))
check("nil vs value differs", not Builtin.stylesMatch({}, { para_indent = 1 }, Settings.CSS_KEYS))
check("float tolerance", Builtin.stylesMatch({ para_indent = 1.2 }, { para_indent = 1.2000001 }, Settings.CSS_KEYS))

print("")
print(failures == 0 and "ALL PASSED" or (failures .. " FAILURE(S)"))
os.exit(failures == 0 and 0 or 1)
