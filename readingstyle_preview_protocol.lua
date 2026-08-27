--[[--
Reading style — the pure half of the preview.

Two jobs, neither of which needs KOReader:

  * framing the records the preview subprocess streams back through its pipe,
  * the small pieces of arithmetic and wording the subprocess and the widget
    both need (which margins a set of pending changes adds up to, and how to
    say "Line 105% -> 120%" in one line).

Keeping them here means readingstyle_test.lua can exercise them in plain
LuaJIT. Everything that touches a document, a fork or the screen lives in
readingstyle_preview.lua.

The shape of the stream, and why it is not just serialized tables
-----------------------------------------------------------------
Each image is announced by a small length-prefixed record — the page it is, how
big it is, which buffer type — and the pixels follow it raw, straight from the
blitbuffer's memory into the pipe and straight back out into another
blitbuffer. Nothing about them ever becomes a Lua string.

That is not an optimisation, it is the difference between working and not. A
screen-sized image is one to three megabytes; serializing it costs a copy in
the child (blitbuffer to string) and another to hand to the codec, then a copy
into the parent's read buffer and another into the new blitbuffer. Four copies
of every image, all of them garbage-collected objects, on top of a subprocess
that is already holding a second render of the book. On a device with 256 MB
that is what runs it out of memory.

The pipe holds 64 KB, so the child blocks inside write() until the parent
drains it: the parent has to read while the child is still working, and cannot
wait for EOF the way ffiutil.readAllFromFD does.
--]]

local Settings = require("readingstyle_settings")
local _ = require("readingstyle_gettext")

local Protocol = {}

Protocol.HEADER_SIZE = 4
--- Header records are small tables; a length beyond this means the stream is
-- out of step and the reader should give up rather than allocate on trust.
Protocol.MAX_RECORD = 64 * 1024

--- Room to leave for the subprocess's own re-render before spending anything
-- on images. Deliberately generous: being told "not enough memory" is a much
-- better outcome than taking the reader down with it.
Protocol.RENDER_RESERVE = 48 * 1024 * 1024

-- Framing -------------------------------------------------------------------

local floor = math.floor

--- Little-endian uint32, built with string.char so no struct library is needed.
function Protocol.packLength(n)
    if type(n) ~= "number" or n < 0 or n >= 4294967296 then return nil end
    n = floor(n)
    return string.char(n % 256, floor(n / 256) % 256, floor(n / 65536) % 256, floor(n / 16777216) % 256)
end

function Protocol.unpackLength(buffer, at)
    at = at or 1
    local b1, b2, b3, b4 = buffer:byte(at, at + Protocol.HEADER_SIZE - 1)
    if not b4 then return nil end
    return b1 + b2 * 256 + b3 * 65536 + b4 * 16777216
end

function Protocol.frame(payload)
    return Protocol.packLength(#payload) .. payload
end

--- The most pages one batch will ever cover. Past this the window stops
-- growing however roomy the device is: the images are held for as long as the
-- playground is open, and a reader who wants to look at half a chapter is
-- better served by a second render than by the plugin sitting on 40 MB.
Protocol.MAX_POSITIONS = 6

--- How many pages a batch can cover without putting the device at risk.
--
-- The subprocess re-renders the whole book, which is where the memory goes:
-- KOReader's own background renderer measures that at around 60 MB for a big
-- book (readerrolling.lua:1926-1930). Whatever is left after reserving room for
-- that is what the images may use. Each position in the window costs one image,
-- plus one more for the single "before" image the flip needs on the page the
-- reader started from.
--
-- The re-render is paid once per batch, so every page inside the window is a
-- free page turn and every page past it costs seconds. That is why the window
-- leans forward: one page back is enough to check what the previous page did,
-- and everything else is better spent on where the reader is going.
--
-- Returns back, forward — or nil when there is not even room for a single page,
-- which is a refusal the caller must pass on rather than trying anyway.
function Protocol.windowFor(free_bytes, image_bytes, reserve_bytes)
    if not free_bytes or not image_bytes or image_bytes <= 0 then
        -- No idea how much room there is (not Linux, unreadable /proc): take
        -- the smallest window rather than guessing upwards.
        return 0, 0
    end
    reserve_bytes = reserve_bytes or Protocol.RENDER_RESERVE
    local budget = free_bytes - reserve_bytes
    local positions = floor((budget - image_bytes) / image_bytes)
    if positions < 1 then return nil end
    if positions > Protocol.MAX_POSITIONS then
        positions = Protocol.MAX_POSITIONS
    end
    if positions == 1 then return 0, 0 end
    if positions == 2 then return 0, 1 end
    -- From three up: one page of context behind, the rest ahead.
    return 1, positions - 2
end

-- Margins -------------------------------------------------------------------

--- The four unscaled margins a set of pending engine changes adds up to.
--
-- base is ReaderTypeset's own unscaled_margins, in its order: left, top,
-- right, bottom. The sync_t_b flag mirrors ReaderTypeset:onSetPageTopMargin,
-- which copies a changed top margin onto the bottom one (and back) when the
-- reader has asked for the two to move together. When a pending set names both
-- and syncing is on, the bottom one is applied last and wins for both — the
-- same thing that happens when the two menu items are used one after the other.
function Protocol.marginsFor(base, engine, sync_t_b)
    local margins = { base[1], base[2], base[3], base[4] }
    engine = engine or {}

    local horizontal = engine.h_page_margins
    if type(horizontal) == "table" then
        margins[1], margins[3] = horizontal[1], horizontal[2]
    end
    if engine.t_page_margin then
        margins[2] = engine.t_page_margin
        if sync_t_b then margins[4] = engine.t_page_margin end
    end
    if engine.b_page_margin then
        margins[4] = engine.b_page_margin
        if sync_t_b then margins[2] = engine.b_page_margin end
    end
    return margins
end

function Protocol.touchesMargins(engine)
    if type(engine) ~= "table" then return false end
    return engine.h_page_margins ~= nil or engine.t_page_margin ~= nil or engine.b_page_margin ~= nil
end

-- Wording -------------------------------------------------------------------

--- Short names for the engine settings, for the one-line summary in the title
-- bar. The quick screen's own labels are deliberately terser than the menu's;
-- these follow the menu, because here there is no row of controls to give the
-- reader the context.
local ENGINE_LABELS = {
    line_spacing     = _("Line spacing"),
    word_spacing     = _("Word spacing"),
    word_expansion   = _("Word expansion"),
    font_base_weight = _("Font weight"),
    h_page_margins   = _("Side margins"),
    t_page_margin    = _("Top margin"),
    b_page_margin    = _("Bottom margin"),
}

function Protocol.formatEngineValue(key, value)
    local spec = Settings.ENGINE_SCHEMA[key]
    if not spec or value == nil then return nil end
    local text
    if spec.pair then
        if type(value) ~= "table" then return nil end
        text = string.format("%s/%s", tostring(floor(value[1])), tostring(floor(value[2])))
    elseif spec.precision then
        text = string.format(spec.precision, value)
    else
        text = tostring(floor(value))
    end
    if spec.unit then
        text = text .. spec.unit
    end
    return text
end

local function sameValue(a, b)
    if type(a) == "table" and type(b) == "table" then
        return a[1] == b[1] and a[2] == b[2]
    end
    return a == b
end

--- "Line spacing 105% -> 120%  ·  Top margin 10 -> 4", or nil when nothing
-- differs. current_values is a key -> value lookup of what the book is showing
-- now; pending is what the preview is about to show instead.
function Protocol.summarizeEngine(current_values, pending)
    if type(pending) ~= "table" then return nil end
    local parts = {}
    -- ENGINE_KEYS rather than pairs(), so the order is the same every time.
    for _index, key in ipairs(Settings.ENGINE_KEYS) do
        local target = pending[key]
        if target ~= nil then
            local current = current_values and current_values[key]
            if not sameValue(current, target) then
                local from = Protocol.formatEngineValue(key, current) or "—"
                local to = Protocol.formatEngineValue(key, target)
                if to then
                    parts[#parts + 1] = string.format("%s %s → %s",
                        ENGINE_LABELS[key] or key, from, to)
                end
            end
        end
    end
    if #parts == 0 then return nil end
    return table.concat(parts, "  ·  ")
end

--- The subtitle for the preview: engine changes if there are any, and a note
-- that the style itself changed when it did. Deliberately says nothing about
-- which CSS declarations differ: the plugin does not keep the applied CSS, so
-- claiming a specific difference there would be a guess.
function Protocol.subtitle(engine_summary, style_pending)
    local parts = {}
    if engine_summary then parts[#parts + 1] = engine_summary end
    if style_pending then parts[#parts + 1] = _("style changes") end
    if #parts == 0 then return nil end
    return table.concat(parts, "  ·  ")
end

return Protocol
