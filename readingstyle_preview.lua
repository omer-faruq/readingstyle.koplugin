--[[--
Reading style — rendering pages with the candidate style, without applying it.

The trick, and the whole reason this is possible at all
------------------------------------------------------
In the live document there is no such thing as "show me but do not apply":
handing crengine a stylesheet *is* applying it. But KOReader already draws
pages in a forked subprocess for Book Map and Page Browser, and the comment at
the top of ReaderThumbnail:_getPageImage says why that is safe: the subprocess
"will die just after drawing the page, and all will be forgotten, without
impact on the parent process". So the candidate style can be handed to crengine
*there*, and the book on screen never moves.

One fork does everything, and this is what makes turning pages affordable:

  1. The fork inherits a document that is *already rendered* with the style in
     force, so the "before" images cost nothing at all — draw them first.
  2. Then the candidate CSS and the pending engine values go in and the book is
     re-rendered once. This is the expensive part, and it is paid once no
     matter how many pages the window covers.
  3. Then the same xpointers are drawn again, giving position-aligned "after"
     images from the identical drawing pipeline.

That last point is why ui.thumbnail is not used for the "before" half even
though it can render pages: it hides the footer, raises the font gamma and
crops the top status bar (readerthumbnail.lua:433-523). Pairing its output with
ours would show the reader a pipeline difference and call it a style
difference.

Memory is the constraint, not speed
-----------------------------------
The subprocess holds a second render of the book — KOReader's own background
renderer measures that at around 60 MB for a big book — and every page image is
another one to three megabytes. On a 256 MB device that is the whole budget, so
two rules run through this file:

  * pixels never become Lua strings. Each image is announced by a small record
    and its bytes are then written straight out of the blitbuffer and read
    straight into another one. Serializing them instead costs four copies of
    every image, all of them garbage-collected, which is what makes a device
    run out of memory.
  * the window is sized from what the device actually has free, and a preview
    that will not fit is refused rather than attempted.

Rules for the subprocess, each of which has a reason
----------------------------------------------------
  * Never call document:close(). That writes the crengine cache; ReaderRolling
    holds its own background renderer back with an mmap'ed flag until the main
    process says the cache may be written (readerrolling.lua:1943-1974). Our
    render is never going to be reloaded, so it must not touch the cache at
    all. Letting runInSubProcess reach its own C._exit(0) writes nothing.
  * enablePartialRerendering(false) and setCallback(), as the core background
    renderer does: we want one full synchronous render, and no progress
    callback drawing into a screen buffer that no longer belongs to us.
  * saveSettings neutered and statistics dropped, so the subprocess cannot
    touch the book's state on disk (readerthumbnail.lua:417-419).
  * Engine values go in through the innermost document setter, never by firing
    the event: the event handlers go on to UpdatePos, which inhibits input and
    schedules UI work. Nothing in this process may process events.
  * The footer stays visible, unlike in thumbnails. It is part of the page
    geometry — the bottom margin is computed from its height — and this is
    supposed to be what the page will really look like.
--]]

local Blitbuffer = require("ffi/blitbuffer")
local Device = require("device")
local Persist = require("persist")
local UIManager = require("ui/uimanager")
local ffi = require("ffi")
local ffiutil = require("ffi/util")
local logger = require("logger")
local util = require("util")
local Screen = Device.screen

local Protocol = require("readingstyle_preview_protocol")
local Settings = require("readingstyle_settings")

local Preview = {}

--- How long to wait for the subprocess before giving up on it. A full render of
-- a large book is seconds, not minutes; well past this something is wrong and
-- the reader should get their screen back.
Preview.TIMEOUT = 180

Preview.POLL_INTERVAL = 0.1

-- Subprocess side -----------------------------------------------------------

local ENGINE_SETTERS = {
    line_spacing     = function(document, value) document:setInterlineSpacePercent(value) end,
    font_base_weight = function(document, value) document:setFontBaseWeight(value) end,
    word_spacing     = function(document, value) document:setWordSpacing(value) end,
    word_expansion   = function(document, value) document:setWordExpansion(value) end,
}

--- write() in a loop, straight from a pointer. A screen-sized image is far
-- larger than the 64 KB pipe buffer, so this blocks until the parent has
-- drained enough to take the rest — which is what we want: it paces the child
-- to the parent rather than piling images up in memory.
local function writeAll(fd, pointer, size)
    local ptr = ffi.cast("const uint8_t *", pointer)
    local remaining = size
    while remaining > 0 do
        local written = tonumber(ffi.C.write(fd, ptr, remaining))
        if written <= 0 then return false end
        ptr = ptr + written
        remaining = remaining - written
    end
    return true
end

--- Applies the pending engine values the way each event handler eventually
-- does, one document setter per key, with no events fired. The margins are the
-- one composite: ReaderTypeset keeps all four together and scales them, and
-- adds the footer's height to the bottom one unless the footer reclaims its own
-- space (readertypeset.lua:541-551).
local function applyEngineValues(ui, engine)
    local document = ui.document
    for key, value in pairs(engine) do
        local spec = Settings.ENGINE_SCHEMA[key]
        if spec and value ~= nil then
            if document.configurable then
                document.configurable[spec.configurable] = value
            end
            local setter = ENGINE_SETTERS[key]
            if setter then
                setter(document, value)
            end
        end
    end

    if Protocol.touchesMargins(engine) and ui.typeset and ui.typeset.unscaled_margins then
        local margins = Protocol.marginsFor(ui.typeset.unscaled_margins, engine,
            ui.typeset.sync_t_b_page_margins)
        local bottom = Screen:scaleBySize(margins[4])
        local footer = ui.view and ui.view.footer
        if footer and not footer.reclaim_height then
            bottom = bottom + footer:getHeight()
        end
        document:setPageMargins(Screen:scaleBySize(margins[1]), Screen:scaleBySize(margins[2]),
            Screen:scaleBySize(margins[3]), bottom)
    end
end

--- Everything the fork does. Split out of the closure below only so it stays
-- readable; it still runs entirely in the child.
local function renderInSubProcess(context, write_fd)
    local plugin = context.plugin
    local ui = plugin.ui
    local document = ui.document
    local codec = context.codec

    local function send(record)
        local ok, payload = pcall(codec.serialize, record)
        if not ok then
            logger.warn("ReadingStyle preview: could not serialize record", payload)
            return false
        end
        local framed = Protocol.frame(payload)
        return writeAll(write_fd, framed, #framed)
    end

    -- 1. Limit our impact on everything the parent still owns.
    ui.saveSettings = function() end
    ui.statistics = nil
    if ui.highlight then ui.highlight.select_mode = false end
    if ui.rolling then ui.rolling.rendering_state = nil end
    document:setCallback()
    document:enablePartialRerendering(false)
    if ui.view.view_mode == "scroll" then
        -- Same order as ReaderThumbnail uses, to avoid a rendering hash change:
        -- one page first, then out of scroll mode.
        ui.rolling:onSetVisiblePages(1)
        ui.view:onSetViewMode("page")
    end

    local bb_type = document.render_color and document.color_bb_type or Blitbuffer.TYPE_BB8

    local function drawAt(xpointer)
        if xpointer then
            document:gotoXPointer(xpointer)
        end
        local page = document:getCurrentPage()
        ui.view.state.page = page
        if ui.bookmark then pcall(ui.bookmark.onPageUpdate, ui.bookmark, page) end
        if ui.pagemap then pcall(ui.pagemap.onPageUpdate, ui.pagemap, page) end
        local bb = Blitbuffer.new(context.width, context.height, bb_type)
        ui.view:paintTo(bb, 0, 0)
        return bb
    end

    --- The record, then the pixels. Nothing in between, and no copy of either.
    local function sendImage(kind, index, page, bb)
        local stride = tonumber(bb.stride)
        send{
            kind = kind,
            index = index,
            page = page,
            w = bb.w,
            h = bb.h,
            stride = stride,
            fmt = bb:getType(),
            rotation = bb:getRotation(),
            inverse = bb:getInverse(),
            bytes = stride * bb.h,
        }
        writeAll(write_fd, bb.data, stride * bb.h)
    end

    -- 2. The window this batch covers, worked out in the render the book is
    -- showing right now: page numbers here therefore mean the same thing they
    -- mean everywhere else in the reader, and each position is carried as an
    -- xpointer, which survives the re-render that page numbers do not.
    local page_count = document:getPageCount()
    document:gotoXPointer(context.origin_xpointer)
    -- The offset is how the reader walks off the end of a window: "the page
    -- after the one I am on", expressed against a position that survives the
    -- re-render. It matters most on a device whose budget is a single page,
    -- where the new window has no room to include where we came from.
    local origin_page = document:getCurrentPage() + (context.origin_offset or 0)
    if origin_page < 1 then origin_page = 1 end
    if origin_page > page_count then origin_page = page_count end
    local positions = {}
    local origin_index = 1
    for offset = -context.back, context.forward do
        local page = origin_page + offset
        if page >= 1 and page <= page_count then
            document:gotoPage(page)
            positions[#positions + 1] = { page = page, xpointer = document:getXPointer() }
            if offset == 0 then
                origin_index = #positions
            end
        end
    end
    send{
        kind = "batch",
        positions = positions,
        page_count = page_count,
        origin_index = origin_index,
    }

    -- 3. "Before": the inherited render, so no rendering is needed for these.
    for index, position in ipairs(positions) do
        local bb = drawAt(position.xpointer)
        sendImage("before", index, position.page, bb)
        bb:free()
    end

    -- 4. The candidate. preview_css is read by ReadingStyle:getCss(), so the
    -- stylesheet hook installed at init() picks it up with no other change;
    -- when it is nil (the usual case) getCss() already returns the pending
    -- style, because a change is written to the style table straight away and
    -- it is only the applying that waits.
    if context.css then
        plugin.preview_css = context.css
    end
    applyEngineValues(ui, context.engine)
    document:setStyleSheet(ui.typeset.css, ui.styletweak:getCssText())
    document._document:renderDocument()

    -- 5. "After": the same positions, found again in the new render.
    for index, position in ipairs(positions) do
        local bb = drawAt(position.xpointer)
        sendImage("after", index, position.page, bb)
        bb:free()
    end

    send{
        kind = "meta",
        -- crengine sometimes cannot reuse the DOM it built for the old styles.
        -- The reader is going to be told "Styles have changed... reloading" if
        -- they apply this; better to say so before they choose.
        dom_stale = document:isBuiltDomStale() and true or false,
    }
end

-- Parent side ---------------------------------------------------------------

local Session = {}
Session.__index = Session

--- Whether a preview can be attempted at all. A fork that fails is handled
-- (the session reports an error and the widget says so), but there is no point
-- offering the menu item for a document that has no stylesheet to preview.
function Preview.isAvailable(plugin)
    if not plugin or not plugin.active then return false end
    local ui = plugin.ui
    if not ui or not ui.document or not ui.rolling or not ui.styletweak or not ui.typeset then
        return false
    end
    return ui.document.getDocumentRenderingHash ~= nil and ffiutil.runInSubProcess ~= nil
end

--- What one page image costs, which is what the window has to be budgeted in.
function Preview.imageBytes(plugin)
    local document = plugin.ui.document
    local bb_type = document.render_color and document.color_bb_type or Blitbuffer.TYPE_BB8
    local bpp = Blitbuffer.TYPE_TO_BPP[tonumber(bb_type)] or 8
    return math.ceil(Screen:getWidth() * bpp / 8) * Screen:getHeight()
end

--- How wide a window this device can afford right now. Returns back, forward,
-- or nil when there is not enough memory for even one page.
function Preview.windowNow(plugin)
    local free = util.calcFreeMem and util.calcFreeMem() or nil
    return Protocol.windowFor(free, Preview.imageBytes(plugin))
end

--- The reading position, as an xpointer: page numbers shift when the book is
-- re-rendered, positions do not.
function Preview.currentXPointer(plugin)
    local ui = plugin.ui
    if ui.rolling and ui.rolling.xpointer then
        return ui.rolling.xpointer
    end
    local ok, xpointer = pcall(function() return ui.document:getXPointer() end)
    if ok then return xpointer end
    return nil
end

--- What the book is showing right now, for the "105% -> 120%" summary. Read
-- raw, past the sandbox: under a preview getEngineValue answers with what the
-- reader has chosen, and the summary needs the other half of that comparison.
function Preview.currentEngineValues(plugin)
    local values = {}
    for _index, key in ipairs(Settings.ENGINE_KEYS) do
        values[key] = plugin:getEngineValue(key, true)
    end
    return values
end

--- opts:
--   plugin    the ReadingStyle instance
--   engine    pending engine values, {} when there are none
--   css       optional candidate CSS; nil means "whatever getCss() says now"
--   origin_xpointer  where the batch is centred; defaults to the reading position
--   origin_offset    pages to step from there before centring (page turns)
--   back, forward    how many pages either side; capped by what memory allows
--   width, height    image size; defaults to the screen
--   on_batch(positions, page_count, origin_index)  the window, before any image
--   on_image(kind, index, bb, page)                as each image arrives
--   on_done(meta)                                  after the last record
--   on_error(message, reason)                      reason is "memory" or nil
function Preview.start(opts)
    local session = setmetatable({
        plugin = opts.plugin,
        on_batch = opts.on_batch,
        on_image = opts.on_image,
        on_done = opts.on_done,
        on_error = opts.on_error,
        images = {},
        stage = "header",
        header = "",
        payload = "",
        started_at = os.time(),
    }, Session)

    local plugin = opts.plugin

    -- What the device can afford is decided here and nowhere else, so no caller
    -- can ask for a window that will not fit.
    local afforded_back, afforded_forward = Preview.windowNow(plugin)
    if not afforded_back then
        session.finished = true
        if session.on_error then
            session.on_error("not enough free memory for a preview", "memory")
        end
        return session
    end
    local span = afforded_back + afforded_forward
    local back = math.min(opts.back or afforded_back, span)
    local forward = math.min(opts.forward or afforded_forward, span)

    local context = {
        plugin = plugin,
        codec = Persist.getCodec("luajit"),
        origin_xpointer = opts.origin_xpointer or Preview.currentXPointer(plugin),
        origin_offset = opts.origin_offset,
        back = back,
        forward = forward,
        engine = opts.engine or {},
        css = opts.css,
        width = opts.width or Screen:getWidth(),
        height = opts.height or Screen:getHeight(),
    }
    session.codec = context.codec

    -- Standby would suspend the CPU out from under the subprocess; the second
    -- core is what the core background renderer asks for too.
    UIManager:preventStandby()
    session.standby_prevented = true
    if Device.enableCPUCores then
        Device:enableCPUCores(2)
        session.cpu_cores_raised = true
    end

    -- The child inherits this heap. Collecting first means it starts from a
    -- compact one, and leaves the parent room for the images about to arrive.
    collectgarbage("collect")

    local pid, read_fd = ffiutil.runInSubProcess(function(_child_pid, child_write_fd)
        local ok, err = pcall(renderInSubProcess, context, child_write_fd)
        if not ok then
            logger.warn("ReadingStyle preview subprocess failed:", err)
            local ok_payload, payload = pcall(context.codec.serialize,
                { kind = "error", message = tostring(err) })
            if ok_payload then
                local framed = Protocol.frame(payload)
                writeAll(child_write_fd, framed, #framed)
            end
        end
        ffi.C.close(child_write_fd)
    end, true) -- with_pipe

    if not pid then
        logger.warn("ReadingStyle preview: fork failed:", read_fd)
        session:_release()
        session.finished = true
        if session.on_error then session.on_error(read_fd) end
        return session
    end

    session.pid = pid
    session.read_fd = read_fd
    session.poll_callback = function() session:_poll() end
    UIManager:scheduleIn(Preview.POLL_INTERVAL, session.poll_callback)
    return session
end

-- Reading the stream ---------------------------------------------------------
--
-- Three stages, and each one reads *exactly* the bytes it still needs. Reading
-- "whatever is available" instead would spill the front of an image's pixels
-- into the string buffer, and those pixels would then have to be copied back
-- out — the copy this protocol exists to avoid.

--- Reads up to `wanted` bytes into a fresh Lua string. Only ever used for the
-- small header records.
function Session:_readString(wanted)
    local available = ffiutil.getNonBlockingReadSize(self.read_fd)
    if not available or available <= 0 then return nil end
    local count = math.min(wanted, available)
    local buffer = ffi.new("uint8_t[?]", count)
    local read = tonumber(ffi.C.read(self.read_fd, buffer, count))
    if read <= 0 then return nil end
    return ffi.string(buffer, read)
end

--- Reads straight into the image being filled. No intermediate anything.
function Session:_readPixels()
    local target = self.incoming
    local available = ffiutil.getNonBlockingReadSize(self.read_fd)
    if not available or available <= 0 then return 0 end
    local count = math.min(target.remaining, available)
    local read = tonumber(ffi.C.read(self.read_fd, target.pointer + target.offset, count))
    if read <= 0 then return read end
    target.offset = target.offset + read
    target.remaining = target.remaining - read
    return read
end

--- Sets up the blitbuffer an image record announced. Allocating it is the one
-- thing here that can fail on a device that is out of memory, so it is asked
-- for politely rather than asserted.
function Session:_beginImage(record)
    local ok, bb = pcall(Blitbuffer.new, record.w, record.h, record.fmt)
    if not ok or not bb then
        return false
    end
    if tonumber(bb.stride) ~= record.stride then
        -- Both sides build the buffer the same way from the same width and
        -- type, so this cannot happen; if it ever does, stop rather than write
        -- pixels into the wrong shape.
        bb:free()
        return false
    end
    if record.rotation then bb:setRotation(record.rotation) end
    if record.inverse then bb:setInverse(record.inverse) end
    self.images[#self.images + 1] = bb
    self.incoming = {
        bb = bb,
        kind = record.kind,
        index = record.index,
        page = record.page,
        pointer = ffi.cast("uint8_t *", bb.data),
        offset = 0,
        remaining = record.bytes,
    }
    return true
end

function Session:_handleRecord(payload)
    local ok, record = pcall(self.codec.deserialize, payload)
    if not ok or type(record) ~= "table" then
        self:_fail("the preview sent something unreadable")
        return
    end
    if record.kind == "error" then
        self:_fail(record.message or "preview failed")
        return
    end
    if record.kind == "meta" then
        self.meta = record
        self:_succeed()
        return
    end
    if record.kind == "batch" then
        if self.on_batch then
            self.on_batch(record.positions or {}, record.page_count, record.origin_index or 1)
        end
        return
    end
    -- An image: its pixels are the next `bytes` bytes on the pipe.
    if not record.bytes or record.bytes <= 0 then return end
    if not self:_beginImage(record) then
        self:_fail("not enough memory for the preview image", "memory")
        return
    end
    self.stage = "pixels"
end

function Session:_finishImage()
    local incoming = self.incoming
    self.incoming = nil
    self.stage = "header"
    self.header = ""
    if self.on_image then
        self.on_image(incoming.kind, incoming.index, incoming.bb, incoming.page)
    end
end

function Session:_poll()
    if self.finished then return end

    local progressed = false
    -- Bounded, so a fast producer cannot keep this loop running through the
    -- whole batch and freeze the UI while it does.
    for _step = 1, 64 do
        if self.finished then return end
        if self.stage == "header" then
            local chunk = self:_readString(Protocol.HEADER_SIZE - #self.header)
            if not chunk then break end
            progressed = true
            self.header = self.header .. chunk
            if #self.header == Protocol.HEADER_SIZE then
                local size = Protocol.unpackLength(self.header)
                if not size or size == 0 or size > Protocol.MAX_RECORD then
                    self:_fail("the preview stream went out of step")
                    return
                end
                self.payload_size = size
                self.payload = ""
                self.stage = "payload"
            end
        elseif self.stage == "payload" then
            local chunk = self:_readString(self.payload_size - #self.payload)
            if not chunk then break end
            progressed = true
            self.payload = self.payload .. chunk
            if #self.payload == self.payload_size then
                local payload = self.payload
                self.payload = ""
                self.header = ""
                self.stage = "header"
                self:_handleRecord(payload)
            end
        else
            local read = self:_readPixels()
            if read <= 0 then break end
            progressed = true
            if self.incoming.remaining == 0 then
                self:_finishImage()
            end
        end
    end
    if self.finished then return end

    if os.time() - self.started_at > Preview.TIMEOUT then
        self:_fail("the preview timed out")
        return
    end

    -- Nothing to read and the subprocess gone means the pipe is at EOF and the
    -- last record never came: the child died before finishing, which on these
    -- devices usually means it ran out of memory.
    if not progressed and ffiutil.isSubProcessDone(self.pid) then
        self.pid = nil
        self:_fail("the preview process ended early", "memory")
        return
    end

    UIManager:scheduleIn(Preview.POLL_INTERVAL, self.poll_callback)
end

function Session:_release()
    if self.poll_callback then
        UIManager:unschedule(self.poll_callback)
    end
    if self.read_fd then
        ffi.C.close(self.read_fd)
        self.read_fd = nil
    end
    self.incoming = nil
    if self.standby_prevented then
        self.standby_prevented = false
        UIManager:allowStandby()
    end
    if self.cpu_cores_raised then
        self.cpu_cores_raised = false
        if Device.enableCPUCores then Device:enableCPUCores(1) end
    end
    if self.pid then
        -- Kills it if it is still running, and reaps it either way.
        ffiutil.terminateSubProcess(self.pid)
        local pid = self.pid
        self.pid = nil
        local attempts = 0
        local reap
        reap = function()
            attempts = attempts + 1
            if ffiutil.isSubProcessDone(pid) or attempts > 20 then return end
            UIManager:scheduleIn(0.5, reap)
        end
        reap()
    end
end

function Session:_succeed()
    if self.finished then return end
    self.finished = true
    self:_release()
    if self.on_done then self.on_done(self.meta or {}) end
end

function Session:_fail(message, reason)
    if self.finished then return end
    self.finished = true
    self:_release()
    if self.on_error then self.on_error(message, reason) end
end

--- Stops the preview without telling anyone: for the reader closing the widget
-- or pressing Cancel, where the caller already knows.
function Session:cancel()
    if self.finished then
        self:_release()
        return
    end
    self.finished = true
    self.cancelled = true
    self:_release()
end

function Session:isFinished()
    return self.finished == true
end

--- Frees every image this session produced, including a half-filled one. The
-- widget calls this when it goes away; nothing else holds a reference.
function Session:freeImages()
    for _index, bb in ipairs(self.images) do
        bb:free()
    end
    self.images = {}
    self.incoming = nil
    -- These are the largest things this plugin ever allocates: do not wait for
    -- the collector to notice, the next batch is usually about to start.
    collectgarbage("collect")
end

Preview.Session = Session

return Preview
