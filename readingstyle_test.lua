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
check("spacing between paragraphs", css:find("p %+ p, .- { margin%-top: 0%.5em !important; }") ~= nil)
check("spacing survives an intervening element", css:find("blockquote %+ p") ~= nil
    and css:find("div %+ p") ~= nil and css:find("img %+ p") ~= nil)
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

-- Schema and key list must agree. Forgetting to add a new key to CSS_KEYS is a
-- silent failure: copy, sanitize, count and the CSS builder all iterate the list,
-- so the setting would work in the menu and vanish from presets and resets.
print("schema consistency")
local function listMatchesSchema(label, keys, schema)
    local listed = {}
    for _index, key in ipairs(keys) do
        if listed[key] then
            check(label .. ": " .. key .. " listed twice", false)
        end
        listed[key] = true
        check(label .. ": " .. key .. " is in the schema", schema[key] ~= nil)
    end
    for key in pairs(schema) do
        check(label .. ": " .. key .. " is in the key list", listed[key] == true)
    end
end
listMatchesSchema("CSS", Settings.CSS_KEYS, Settings.CSS_SCHEMA)
listMatchesSchema("ENGINE", Settings.ENGINE_KEYS, Settings.ENGINE_SCHEMA)

check("every css spec has a usable kind", (function()
    for key, spec in pairs(Settings.CSS_SCHEMA) do
        local kind = spec.kind
        if kind ~= "number" and kind ~= "bool" and kind ~= "enum" and kind ~= "string" then
            return false, key
        end
        if kind == "number" and (spec.min == nil or spec.max == nil
                or spec.step == nil or spec.precision == nil) then
            return false, key
        end
        if kind == "enum" and (type(spec.values) ~= "table" or #spec.values == 0) then
            return false, key
        end
    end
    return true
end)())

check("every schema default is a valid value", (function()
    for key, spec in pairs(Settings.CSS_SCHEMA) do
        if spec.default ~= nil and not Settings.isValid(key, spec.default) then
            return false, key
        end
    end
    return true
end)())

check("every engine spec can name its default", (function()
    for _key, spec in pairs(Settings.ENGINE_SCHEMA) do
        if spec.configurable == nil or spec.event == nil or spec.global_key == nil then
            return false
        end
        -- One of the two ways of naming a default has to be there, or the reset
        -- button and the changed-marker have nothing to compare against.
        if spec.default_key == nil and spec.default_value == nil then
            return false
        end
        if spec.pair then
            if not (spec.left and spec.right) then return false end
        elseif spec.min == nil or spec.max == nil then
            return false
        end
    end
    return true
end)())

check("section engine key lists are known keys", (function()
    for _index, list in ipairs({ Settings.TEXT_ENGINE_KEYS, Settings.LAYOUT_ENGINE_KEYS }) do
        for _i, key in ipairs(list) do
            if Settings.ENGINE_SCHEMA[key] == nil then return false, key end
        end
    end
    return true
end)())

print("clampEngine")
check("in range passes through", Settings.clampEngine("line_spacing", 120) == 120)
check("above range clamps down", Settings.clampEngine("line_spacing", 9999) == 200)
check("below range clamps up", Settings.clampEngine("line_spacing", -5) == 50)
check("unknown key rejected", Settings.clampEngine("nope", 100) == nil)
check("non-number rejected", Settings.clampEngine("line_spacing", "120") == nil)
check("nil rejected", Settings.clampEngine("line_spacing", nil) == nil)
check("NaN rejected", Settings.clampEngine("line_spacing", 0/0) == nil)
check("table for a single value rejected", Settings.clampEngine("line_spacing", {1, 2}) == nil)
check("pair clamps both halves", (function()
    local v = Settings.clampEngine("word_spacing", { 9999, 0 })
    return v[1] == 500 and v[2] == 25
end)())
check("pair passes a good value through", (function()
    local v = Settings.clampEngine("word_spacing", { 115, 95 })
    return v[1] == 115 and v[2] == 95
end)())
check("pair returns a fresh table", (function()
    local original = { 100, 80 }
    local clamped = Settings.clampEngine("word_spacing", original)
    clamped[1] = 1
    return original[1] == 100
end)())
check("pair needs a table", Settings.clampEngine("word_spacing", 100) == nil)
check("pair rejects a missing half", Settings.clampEngine("word_spacing", { 100 }) == nil)
check("pair rejects a junk half", Settings.clampEngine("h_page_margins", { 10, "x" }) == nil)

print("new style keys")
local function only(key, value)
    local style = {}
    Settings.set(style, key, value)
    return Css.build(style)
end

check("unset keys emit nothing", (function()
    for _index, key in ipairs(Settings.CSS_KEYS) do
        local style = {}
        if Css.build(style) ~= "" then return false, key end
    end
    return true
end)())

check("every key can produce css on its own", (function()
    -- custom_css needs real CSS text rather than a schema value, and
    -- chapter_levels is a modifier: it narrows the selector the other chapter
    -- settings are written against and emits nothing by itself. Both are covered
    -- by their own checks below.
    local skip = { custom_css = true, chapter_levels = true }
    for _index, key in ipairs(Settings.CSS_KEYS) do
        if not skip[key] then
            local spec = Settings.CSS_SCHEMA[key]
            local value
            if spec.kind == "bool" then
                value = true
            elseif spec.kind == "enum" then
                value = spec.values[1]
            elseif spec.kind == "number" then
                value = spec.default or spec.max
            end
            if value ~= nil and only(key, value) == "" then
                return false, key
            end
        end
    end
    return true
end)())

check("chapter levels narrow the selector", (function()
    local one = Css.build({ chapter_levels = "h1", chapter_space_before = 2 })
    local three = Css.build({ chapter_levels = "h1h2h3", chapter_space_before = 2 })
    return one:find("^/%* Reading style %*/\nh1", 1) == nil -- has a section comment
        and one:find("\nh1 { margin%-top") ~= nil
        and three:find("\nh1, h2, h3 { margin%-top") ~= nil
end)())

check("chapter levels default to all three", (function()
    return Css.build({ chapter_space_before = 2 }):find("\nh1, h2, h3 { margin%-top") ~= nil
end)())

check("alignment still reaches every heading level", (function()
    local css = Css.build({ chapter_levels = "h1", chapter_align = "center" })
    return css:find("h1, h2, h3, h4, h5, h6 { text%-align: center") ~= nil
end)())

check("page break on h2 protects a subtitle", (function()
    local css = Css.build({ chapter_page_break = "h1h2" })
    return css:find("h1, h2 { page%-break%-before: always") ~= nil
        and css:find("h1 %+ h2 { page%-break%-before: avoid") ~= nil
end)())

check("page break on h1 leaves h2 alone", (function()
    local css = Css.build({ chapter_page_break = "h1" })
    return css:find("\nh1 { page%-break%-before: always") ~= nil
        and css:find("h1 %+ h2") == nil
end)())

check("hidden images suppress the other image rules", (function()
    local css = Css.build({ hide_images = true, image_align = "center", image_width = "page" })
    return css:find("img, svg { display: none") ~= nil
        and css:find("margin%-left: auto") == nil
        and css:find("width: 100%%") == nil
end)())

check("widows and orphans reach DocFragment", (function()
    local css = Css.build({ avoid_widows_orphans = true })
    return css:find("DocFragment { orphans: 2") ~= nil and css:find("body { orphans: 2") ~= nil
end)())

check("plain quotes clear the indent", (function()
    local css = Css.build({ quote_style = "plain" })
    return css:find("margin%-left: 0 !important") ~= nil
        and css:find("font%-style: normal") ~= nil
end)())

check("links are written after the wildcards", (function()
    local css = Css.build({ force_black_text = true, link_black = true })
    return css:find("%* { color: black") < css:find("a, a %* { color: black")
end)())

check("tristate off is not the same as unset", (function()
    local off = Css.build({ chapter_bold = false })
    local unset = Css.build({})
    return off:find("font%-weight: normal") ~= nil and unset == ""
end)())

check("custom css is capped", (function()
    local huge = string.rep("a", Settings.MAX_CUSTOM_CSS + 1)
    local style = {}
    Settings.set(style, "custom_css", huge)
    local ok_size = string.rep("b", 100)
    local style2 = {}
    Settings.set(style2, "custom_css", ok_size)
    return style.custom_css == nil and style2.custom_css == ok_size
end)())

print("language profile sanitising")
check("bad keys are dropped", (function()
    local languages = { tr = { para_indent = 1 }, [5] = { para_indent = 1 },
                        ["tr-TR"] = { para_indent = 1 }, en = "not a table" }
    Settings.sanitizeLanguages(languages)
    return languages.tr ~= nil and languages[5] == nil
        and languages["tr-TR"] == nil and languages.en == nil
end)())
check("styles inside are sanitised", (function()
    local languages = { tr = { para_indent = 1, bogus = true } }
    Settings.sanitizeLanguages(languages)
    return languages.tr.bogus == nil and languages.tr.para_indent == 1
end)())
check("non-table input is survivable", type(Settings.sanitizeLanguages(nil)) == "table")

-- A control that can be switched on but not off is the worst kind of bug here:
-- it looks like it works. These walk every tap-driven control, for every key the
-- schema knows, and insist each one comes back to where it started.
print("tap controls are reversible")

check("toggle turns on and off again", (function()
    local value = Settings.nextToggle(nil)
    if value ~= true then return false, "on: " .. tostring(value) end
    value = Settings.nextToggle(value)
    if value ~= nil then return false, "off: " .. tostring(value) end
    return true
end)())

check("toggle treats off as unset", Settings.nextToggle(false) == true)

check("every bool key survives a toggle round trip", (function()
    for _index, key in ipairs(Settings.CSS_KEYS) do
        if Settings.CSS_SCHEMA[key].kind == "bool" then
            local style = {}
            Settings.set(style, key, Settings.nextToggle(style[key]))
            if style[key] ~= true then return false, key .. " would not switch on" end
            Settings.set(style, key, Settings.nextToggle(style[key]))
            if style[key] ~= nil then return false, key .. " would not switch off" end
        end
    end
    return true
end)())

check("tristate walks all three states and returns", (function()
    local seen = {}
    local value = nil
    for _step = 1, 3 do
        value = Settings.nextTristate(value)
        seen[#seen + 1] = tostring(value)
    end
    return table.concat(seen, ",") == "true,false,nil"
end)())

check("every bool key survives a tristate round trip", (function()
    for _index, key in ipairs(Settings.CSS_KEYS) do
        if Settings.CSS_SCHEMA[key].kind == "bool" then
            local style = {}
            for _step = 1, 3 do
                Settings.set(style, key, Settings.nextTristate(style[key]))
            end
            if style[key] ~= nil then return false, key .. " did not come back" end
        end
    end
    return true
end)())

check("a full turn of a cycle returns to the start", (function()
    local cycle = { false, "left", "justify", "right" }
    local value = false
    for _step = 1, #cycle do
        value = Settings.nextInCycle(cycle, value)
    end
    return value == false
end)())

check("cycle reaches every member", (function()
    local cycle = { false, "left", "justify", "right" }
    local seen, value = {}, false
    for _step = 1, #cycle do
        value = Settings.nextInCycle(cycle, value)
        seen[tostring(value)] = true
    end
    return seen["false"] and seen["left"] and seen["justify"] and seen["right"]
end)())

check("cycle handles a value that is not a member", (function()
    return Settings.nextInCycle({ "a", "b" }, "zzz") == "a"
        and Settings.nextInCycle({ "a", "b" }, nil) == "a"
end)())

check("cycle of one stays put", Settings.nextInCycle({ "only" }, "only") == "only")

check("every enum key can be cleared back to book default", (function()
    for _index, key in ipairs(Settings.CSS_KEYS) do
        local spec = Settings.CSS_SCHEMA[key]
        if spec.kind == "enum" then
            local style = {}
            Settings.set(style, key, spec.values[#spec.values])
            if style[key] == nil then return false, key .. " would not set" end
            Settings.set(style, key, nil)
            if style[key] ~= nil then return false, key .. " would not clear" end
        end
    end
    return true
end)())

check("every number key can be cleared back to book default", (function()
    for _index, key in ipairs(Settings.CSS_KEYS) do
        local spec = Settings.CSS_SCHEMA[key]
        if spec.kind == "number" then
            local style = {}
            Settings.set(style, key, spec.default or spec.max)
            if style[key] == nil then return false, key .. " would not set" end
            Settings.set(style, key, nil)
            if style[key] ~= nil then return false, key .. " would not clear" end
        end
    end
    return true
end)())

check("false is a stored value, not an absent one", (function()
    local style = {}
    Settings.set(style, "chapter_bold", false)
    return Settings.count(style) == 1 and not Settings.isEmpty(style)
        and Settings.copy(style).chapter_bold == false
end)())

print("")
print(failures == 0 and "ALL PASSED" or (failures .. " FAILURE(S)"))
os.exit(failures == 0 and 0 or 1)
