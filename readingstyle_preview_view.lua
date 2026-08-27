--[[--
Reading style — the preview screen.

A workbench, not a confirmation dialog. While it is open the reader can change
anything the plugin owns, turn pages to see how the change lands elsewhere in
the book, and only then decide. Nothing reaches the book until *Apply*, and
*Cancel* leaves it exactly as it was found.

Three things make that work, and they live in three different places:

  * the sandbox (main.lua): while it is on, style changes are never applied and
    engine settings are remembered instead of being driven into the document,
  * the batch (readingstyle_preview.lua): one fork renders the book once and
    draws a window of pages either side of the reading position, so turning a
    page inside the preview is instant,
  * this file: it re-runs the batch whenever the settings change under it, and
    starts a new one when the reader walks off the end of the window.

Two ways of looking at a page
-----------------------------
"Full page" is the default and flips between before and after **in the same
pixels**. Side by side sounds like the obvious way to compare two renders, but
at half the screen width a change in line spacing, word spacing or indent is
not legible any more — and those are most of what this plugin does. An A/B flip
at full size shows them plainly, and on an e-ink screen it costs one full
refresh.

"Side by side" is the second view, for the questions the flip is bad at:
margins, paragraph spacing, how much room a chapter heading takes, whether an
image still fits its page. Tapping one half brings it back to full size.
--]]

local Blitbuffer = require("ffi/blitbuffer")
local ButtonTable = require("ui/widget/buttontable")
local CenterContainer = require("ui/widget/container/centercontainer")
local Device = require("device")
local Font = require("ui/font")
local FrameContainer = require("ui/widget/container/framecontainer")
local Geom = require("ui/geometry")
local GestureRange = require("ui/gesturerange")
local HorizontalGroup = require("ui/widget/horizontalgroup")
local HorizontalSpan = require("ui/widget/horizontalspan")
local ImageWidget = require("ui/widget/imagewidget")
local InputContainer = require("ui/widget/container/inputcontainer")
local Size = require("ui/size")
local TextBoxWidget = require("ui/widget/textboxwidget")
local TextWidget = require("ui/widget/textwidget")
local TitleBar = require("ui/widget/titlebar")
local UIManager = require("ui/uimanager")
local VerticalGroup = require("ui/widget/verticalgroup")
local VerticalSpan = require("ui/widget/verticalspan")
local logger = require("logger")
local Screen = Device.screen
local _ = require("readingstyle_gettext")
local T = require("ffi/util").template

local Preview = require("readingstyle_preview")
local Protocol = require("readingstyle_preview_protocol")

local PreviewView = InputContainer:extend{
    plugin = nil,
    engine = nil,          -- engine values to seed the sandbox with
    css = nil,             -- optional candidate CSS
    -- state
    mode = "flip",         -- "flip" or "split"
    side = "after",
    index = 1,
}

function PreviewView:init()
    self.width = Screen:getWidth()
    self.height = Screen:getHeight()
    self.covers_fullscreen = true
    self.positions = {}
    self.state = "loading"

    -- Everything the reader does from here on is held in the sandbox until they
    -- decide. Values handed over by the quick screen (which batches its own)
    -- move into it, so there is one place holding pending changes, not two.
    local sandbox = self.plugin:beginSandbox()
    for key, value in pairs(self.engine or {}) do
        sandbox:setEngine(key, value)
    end
    -- Seeding is not a change the reader made under the preview: clear the flag
    -- so the first settings screen that closes does not trigger a second render.
    self.plugin:takeSandboxChange()
    -- Any settings screen, however it was opened, reports back through this.
    sandbox.watcher = function() self:_afterSettings() end

    if Device:isTouchDevice() then
        local range = Geom:new{ x = 0, y = 0, w = self.width, h = self.height }
        self.ges_events = {
            Tap = { GestureRange:new{ ges = "tap", range = range } },
            Hold = { GestureRange:new{ ges = "hold", range = range } },
            Swipe = { GestureRange:new{ ges = "swipe", range = range } },
            MultiSwipe = { GestureRange:new{ ges = "multiswipe", range = range } },
        }
    end
    if Device:hasKeys() then
        self.key_events = {
            Close = { { Device.input.group.Back } },
            PreviousPage = { { Device.input.group.PgBack } },
            NextPage = { { Device.input.group.PgFwd } },
        }
    end

    self:_render()
end

-- The batch ------------------------------------------------------------------

--- Starts (or restarts) a preview batch. opts.origin_xpointer, opts.back and
-- opts.forward say which window to cover; opts.focus_page which page to show
-- once it arrives.
function PreviewView:_render(opts)
    opts = opts or {}

    -- Drop every reference to the previous batch's images *before* freeing
    -- them: the loading screen holds no ImageWidgets, so nothing can be
    -- painting from a buffer that is about to go away.
    self.state = "loading"
    self.positions = {}
    self.index = 1
    self.meta = nil -- dom_stale belongs to the batch that reported it
    self.focus_page = opts.focus_page
    self:_rebuild()

    if self.session then
        self.session:cancel()
        self.session:freeImages()
        self.session = nil
    end

    self.session = Preview.start{
        plugin = self.plugin,
        engine = self.plugin:sandboxEngine(),
        css = self.css,
        origin_xpointer = opts.origin_xpointer or Preview.currentXPointer(self.plugin),
        origin_offset = opts.origin_offset,
        back = opts.back,
        forward = opts.forward,
        on_batch = function(positions, page_count, origin_index)
            self.positions = positions
            self.page_count = page_count
            self.index = self:_indexForPage(self.focus_page) or origin_index
            self.focus_page = nil
        end,
        on_image = function(kind, index, bb)
            local position = self.positions[index]
            if not position then return end
            position[kind] = bb
            if index ~= self.index then return end
            -- The "after" image is the one the reader came for; showing the
            -- "before" half on its own would only flash the page they are
            -- already looking at.
            if kind == "after" and self.state == "loading" then
                self.state = "ready"
                self:_rebuild()
            elseif self.state == "ready" then
                self:_rebuild()
            end
        end,
        on_done = function(meta)
            self.meta = meta
            if self.state == "loading" then
                self.state = "error"
                self.error_message = _("The preview did not produce a page.")
            end
            self:_rebuild()
        end,
        on_error = function(message, reason)
            logger.warn("ReadingStyle preview failed:", message, reason)
            self.state = "error"
            if reason == "memory" then
                -- Worth saying plainly: the preview needs room for a second
                -- copy of the rendered book, and this is a real limit on small
                -- devices rather than something that went wrong.
                self.error_message = _("There is not enough free memory for a preview right now.\n\nA preview renders a second copy of the book in a separate process, which needs room. Closing other things, or reopening the book, usually frees enough.")
            else
                self.error_message = _("The preview could not be rendered on this device.")
            end
            self:_rebuild()
        end,
    }
end

--- A settings screen has closed over the preview. If anything changed, the
-- batch is rendered again at the page being looked at; if not, the preview
-- only has to be painted back over whatever was covering it.
function PreviewView:_afterSettings()
    if self.closing then return end
    if self.plugin:takeSandboxChange() then
        local position = self:_currentPosition()
        self:_render{
            origin_xpointer = position.xpointer,
            focus_page = position.page,
        }
    else
        UIManager:setDirty(self, "full")
    end
end

function PreviewView:_indexForPage(page)
    if not page then return nil end
    for index, position in ipairs(self.positions) do
        if position.page == page then return index end
    end
    return nil
end

function PreviewView:_currentPosition()
    return self.positions[self.index] or {}
end

-- Layout ---------------------------------------------------------------------

function PreviewView:_titleText()
    if self.state ~= "ready" then
        -- Same word the menu item used, for the moment right after tapping it.
        -- Once there is a page to look at the title says what the page is
        -- instead, which is the more useful thing to know by then.
        return _("Playground")
    end
    local what
    if self.mode == "split" then
        what = _("Preview: before | after")
    else
        what = self.side == "after" and _("Preview: after") or _("Preview: before")
    end
    local page = self:_currentPosition().page
    if page and self.page_count then
        return T("%1 — %2", what, T(_("page %1 of %2"), page, self.page_count))
    end
    return what
end

function PreviewView:_subtitleText()
    local plugin = self.plugin
    return Protocol.subtitle(
        Protocol.summarizeEngine(Preview.currentEngineValues(plugin), plugin:sandboxEngine()),
        plugin:hasPendingChanges())
end

function PreviewView:_message(text, height)
    return CenterContainer:new{
        dimen = Geom:new{ w = self.width, h = height },
        TextBoxWidget:new{
            text = text,
            face = Font:getFace("infofont"),
            width = math.floor(self.width * 0.8),
            alignment = "center",
        },
    }
end

--- The page image at the largest size that fits, inside a hairline frame.
--
-- The frame is not decoration. The image is scaled down to make room for the
-- title bar and the buttons, and it is letterboxed inside whatever space is
-- left, so without a line at its edge there is no way to tell where the page
-- ends and the screen begins — which makes the margins, one of the main things
-- worth previewing, impossible to judge.
--
-- It has to be measured rather than delegated: ImageWidget:getSize() reports
-- the box it was given, not the size the image was scaled to
-- (imagewidget.lua:379-389), so a frame wrapped straight around it would sit
-- out in the empty band beside the page rather than on its edge.
function PreviewView:_framedImage(bb, area_width, area_height)
    if area_width >= bb:getWidth() and area_height >= bb:getHeight() then
        -- Room for the page at its real size, which is what the full-size view
        -- exists for: no scaling, so the blitbuffer reaches the screen pixel
        -- for pixel — literally what the book will look like. And no frame
        -- either: at 1:1 the page edge *is* the screen edge, and a border would
        -- cover a row of the page to say so.
        return ImageWidget:new{
            image = bb,
            image_disposable = false,
            width = bb:getWidth(),
            height = bb:getHeight(),
            scale_factor = 1,
        }
    end

    local border = Size.border.default
    local inner_width = math.max(1, area_width - 2 * border)
    local inner_height = math.max(1, area_height - 2 * border)
    local scale = math.min(inner_width / bb:getWidth(), inner_height / bb:getHeight())
    return FrameContainer:new{
        bordersize = border,
        padding = 0,
        margin = 0,
        color = Blitbuffer.COLOR_BLACK,
        background = Blitbuffer.COLOR_WHITE,
        ImageWidget:new{
            image = bb,
            image_disposable = false, -- the session owns these
            width = math.max(1, math.floor(bb:getWidth() * scale)),
            height = math.max(1, math.floor(bb:getHeight() * scale)),
            scale_factor = 0, -- best fit, aspect ratio kept
        },
    }
end

function PreviewView:_labelledImage(bb, label, width, height)
    local label_widget = TextWidget:new{
        text = label,
        face = Font:getFace("xx_smallinfofont"),
        max_width = width,
    }
    local label_height = label_widget:getSize().h
    return VerticalGroup:new{
        align = "center",
        CenterContainer:new{
            dimen = Geom:new{ w = width, h = label_height },
            label_widget,
        },
        CenterContainer:new{
            dimen = Geom:new{ w = width, h = height - label_height },
            self:_framedImage(bb, width, height - label_height),
        },
    }
end

function PreviewView:_content(height)
    if self.state == "error" then
        return self:_message(self.error_message or _("The preview failed."), height)
    end
    if self.state == "loading" then
        return self:_message(
            _("Rendering the book with the new style…\n\nThe book on screen is not being changed. This takes about as long as applying the style would."),
            height)
    end

    local position = self:_currentPosition()
    if self.mode == "split" and position.before and position.after then
        local gap = Size.padding.large
        local half = math.floor((self.width - 3 * gap) / 2)
        return CenterContainer:new{
            dimen = Geom:new{ w = self.width, h = height },
            HorizontalGroup:new{
                align = "center",
                self:_labelledImage(position.before, _("Before"), half, height),
                HorizontalSpan:new{ width = gap },
                self:_labelledImage(position.after, _("After"), half, height),
            },
        }
    end

    local bb = position[self.side] or position.after or position.before
    if not bb then
        return self:_message(_("This page has not been rendered yet."), height)
    end
    return CenterContainer:new{
        dimen = Geom:new{ w = self.width, h = height },
        self:_framedImage(bb, self.width, height),
    }
end

function PreviewView:_buttons()
    if self.state == "loading" then
        return {{
            { text = _("Cancel"), callback = function() self:onClose() end },
        }}
    end
    if self.state == "error" then
        return {{
            { text = _("Close"), callback = function() self:onClose() end },
        }}
    end

    local position = self:_currentPosition()
    local both_sides = position.before ~= nil and position.after ~= nil

    local view_row = {
        {
            text = "◀",
            enabled = self:_canTurn(-1),
            callback = function() self:onPreviousPage() end,
        },
    }
    if self.mode == "flip" then
        view_row[#view_row + 1] = {
            text = self.side == "after" and _("Show before") or _("Show after"),
            enabled = both_sides,
            callback = function() self:onFlip() end,
        }
        view_row[#view_row + 1] = {
            text = _("Side by side"),
            enabled = both_sides,
            callback = function()
                self.mode = "split"
                self:_rebuild()
            end,
        }
    else
        view_row[#view_row + 1] = {
            text = _("Full page"),
            callback = function()
                self.mode = "flip"
                self:_rebuild()
            end,
        }
    end
    view_row[#view_row + 1] = {
        text = "▶",
        enabled = self:_canTurn(1),
        callback = function() self:onNextPage() end,
    }

    local decide_row = {
        {
            text = _("Settings"),
            callback = function() self:onShowSettings() end,
        },
        {
            text = _("Apply"),
            callback = function() self:onApply() end,
        },
        {
            text = _("Cancel"),
            callback = function() self:onClose() end,
        },
    }

    return { view_row, decide_row }
end

function PreviewView:_rebuild()
    if self[1] then
        pcall(function() self[1]:free() end)
    end

    if self.chrome_hidden and self.state == "ready" then
        -- Nothing but the page. Loading and error states always keep their
        -- chrome, so there is never a screen with no way out of it.
        self[1] = FrameContainer:new{
            width = self.width,
            height = self.height,
            padding = 0,
            margin = 0,
            bordersize = 0,
            background = Blitbuffer.COLOR_WHITE,
            self:_content(self.height),
        }
        if self.shown then
            UIManager:setDirty(self, "full")
        end
        return
    end

    local title_bar = TitleBar:new{
        width = self.width,
        fullscreen = true,
        align = "center",
        title = self:_titleText(),
        subtitle = self:_subtitleText(),
        with_bottom_line = true,
        -- Discoverable twin of the hold gesture: the page is worth seeing at
        -- its real size, and nobody guesses a long press on their own.
        left_icon = self.state == "ready" and "control.expand" or nil,
        left_icon_tap_callback = function() self:onToggleChrome() end,
        close_callback = function() self:onClose() end,
        show_parent = self,
    }

    local button_table = ButtonTable:new{
        width = self.width - 2 * Size.padding.default,
        buttons = self:_buttons(),
        zero_sep = true,
        show_parent = self,
    }

    local warning
    if self.meta and self.meta.dom_stale then
        warning = TextWidget:new{
            text = _("Applying this will reload the book."),
            face = Font:getFace("xx_smallinfofont"),
            max_width = self.width - 2 * Size.padding.default,
        }
    end

    local chrome_height = title_bar:getHeight() + button_table:getSize().h
        + (warning and warning:getSize().h or 0) + 2 * Size.padding.small
    local content_height = math.max(Screen:scaleBySize(60), self.height - chrome_height)

    local group = VerticalGroup:new{ align = "center" }
    table.insert(group, title_bar)
    table.insert(group, self:_content(content_height))
    if warning then
        table.insert(group, CenterContainer:new{
            dimen = Geom:new{ w = self.width, h = warning:getSize().h },
            warning,
        })
    end
    table.insert(group, VerticalSpan:new{ width = Size.padding.small })
    table.insert(group, CenterContainer:new{
        dimen = Geom:new{ w = self.width, h = button_table:getSize().h },
        button_table,
    })

    self[1] = FrameContainer:new{
        width = self.width,
        height = self.height,
        padding = 0,
        margin = 0,
        bordersize = 0,
        background = Blitbuffer.COLOR_WHITE,
        group,
    }

    if self.shown then
        -- Two page images swapping in place: a partial refresh would leave the
        -- old text ghosted over the new.
        UIManager:setDirty(self, "full")
    end
end

-- Turning pages --------------------------------------------------------------

function PreviewView:_canTurn(delta)
    if self.state ~= "ready" then return false end
    if self.positions[self.index + delta] then return true end
    -- Off the end of this batch: only if the book itself has a page there.
    local page = self:_currentPosition().page
    if not page then return false end
    local target = page + delta
    return target >= 1 and (not self.page_count or target <= self.page_count)
end

function PreviewView:_turn(delta)
    if not self:_canTurn(delta) then return true end

    local target_index = self.index + delta
    if self.positions[target_index] then
        self.index = target_index
        self:_rebuild()
        return true
    end

    -- A new batch, centred on the page being turned to and reaching in the
    -- direction of travel. One re-render buys another window of pages — and on
    -- a device whose budget is a single page, centring on the target rather
    -- than on where we are is what makes the turn work at all.
    local position = self:_currentPosition()
    local back, forward = Preview.windowNow(self.plugin)
    local span = (back or 0) + (forward or 0)
    self:_render{
        origin_xpointer = position.xpointer,
        origin_offset = delta,
        back = delta < 0 and span or 0,
        forward = delta > 0 and span or 0,
        focus_page = position.page + delta,
    }
    return true
end

function PreviewView:onNextPage()
    return self:_turn(1)
end

function PreviewView:onPreviousPage()
    return self:_turn(-1)
end

-- Settings under the preview -------------------------------------------------

--- The plugin's own menu tree, on top of the preview. Every control in it goes
-- through the plugin's setters, which the sandbox has intercepted, so nothing
-- the reader does here reaches the book. When the menu closes and something
-- did change, the batch is rendered again.
function PreviewView:onShowSettings()
    local StyleMenu = require("readingstyle_menu")

    local items = StyleMenu.build(self.plugin, { sandbox = true })

    local menu_container = CenterContainer:new{
        ignore = "height",
        dimen = Screen:getSize(),
    }
    local menu
    if Device:isTouchDevice() or Device:hasDPad() then
        -- One tab holding the plugin's own tree, the way applauncher builds a
        -- standalone TouchMenu (applauncher.koplugin/main.lua:996-1006).
        local tab = { icon = "appbar.typeset" }
        for _index, item in ipairs(items) do
            tab[#tab + 1] = item
        end
        local TouchMenu = require("ui/widget/touchmenu")
        menu = TouchMenu:new{
            width = Screen:getWidth(),
            tab_item_table = { tab },
            show_parent = menu_container,
        }
    else
        local ListMenu = require("ui/widget/menu")
        menu = ListMenu:new{
            title = _("Reading style"),
            item_table = items,
            width = Screen:getWidth() - Screen:scaleBySize(50),
            show_parent = menu_container,
        }
    end

    menu.close_callback = function()
        UIManager:close(menu_container)
        self:_afterSettings()
    end

    menu_container[1] = menu
    UIManager:show(menu_container)
    return true
end

-- Events ---------------------------------------------------------------------

function PreviewView:onShow()
    self.shown = true
    UIManager:setDirty(self, "full")
    return true
end

function PreviewView:onFlip()
    if self.state ~= "ready" then return true end
    local position = self:_currentPosition()
    if not (position.before and position.after) then return true end
    if self.mode == "split" then
        self.mode = "flip"
    else
        self.side = self.side == "after" and "before" or "after"
    end
    self:_rebuild()
    return true
end

--- Hides everything but the page, and brings it back. Worth having beyond the
-- extra room: with the chrome gone the image is displayed at exactly 1:1, so
-- what is on the screen is what the book will be, pixel for pixel.
function PreviewView:onToggleChrome()
    if self.state ~= "ready" then return true end
    self.chrome_hidden = not self.chrome_hidden
    self:_rebuild()
    return true
end

function PreviewView:onHold()
    return self:onToggleChrome()
end

function PreviewView:onTap(_arg, ges)
    if self.state ~= "ready" then return true end
    if self.mode == "split" and ges and ges.pos then
        -- Tapping a half brings that half up to full size, which is where the
        -- typography is actually readable.
        self.side = ges.pos.x < self.width / 2 and "before" or "after"
        self.mode = "flip"
        self:_rebuild()
        return true
    end
    return self:onFlip()
end

--- Swiping turns pages, as it does in the book. Flipping between before and
-- after is a tap, because that is the gesture you can repeat without moving
-- your eyes off the paragraph you are comparing.
function PreviewView:onSwipe(_arg, ges)
    local direction = ges and ges.direction
    if direction == "west" then
        return self:onNextPage()
    elseif direction == "east" then
        return self:onPreviousPage()
    end
    return true
end

function PreviewView:onMultiSwipe()
    self:onClose()
    return true
end

function PreviewView:onApply()
    -- Everything the reader set under the preview, applied to the book in one
    -- go: engine settings through their events, then a single style apply.
    self.decided = true
    self.plugin:endSandbox(true)
    UIManager:close(self)
    return true
end

--- Back, and the multiswipe above, leave the full-size view before they leave
-- the playground: a reader who hid the chrome and forgot how gets their
-- buttons back rather than losing what they were working on.
function PreviewView:onClose()
    if self.chrome_hidden then
        self.chrome_hidden = false
        self:_rebuild()
        return true
    end
    UIManager:close(self)
    return true
end

function PreviewView:onCloseWidget()
    self.closing = true
    if not self.decided then
        -- Puts the style tables back. Nothing has to be undone on the engine
        -- side: under the sandbox those values never reached the document.
        self.plugin:endSandbox(false)
    end
    if self.session then
        self.session:cancel()
        -- The ImageWidgets never owned these (image_disposable = false), so the
        -- session frees them once, here, however the screen was left.
        self.session:freeImages()
        self.session = nil
    end
    self.positions = {}
    UIManager:setDirty(nil, "full")
end

--- The one call the rest of the plugin makes.
function PreviewView.show(plugin, opts)
    opts = opts or {}
    UIManager:show(PreviewView:new{
        plugin = plugin,
        engine = opts.engine or {},
        css = opts.css,
    })
end

return PreviewView
