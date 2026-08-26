--[[--
Reading style — the quick style screen.

One screen with the four settings people actually reach for, each on a
[ − ] [ value ] [ + ] row, plus alignment and scope. Holding a value opens the
full spin widget for that setting, with its "book default" button.

Why the changes are batched
---------------------------
Every style change makes crengine re-render the page. Applying on each tap of
[ + ] would make holding the button unusable, so taps only update the label and
a short timer does the actual work once the reader stops tapping. The Apply
button flushes that timer, and is the only way anything happens when the reader
has turned "apply changes immediately" off.
--]]

local ButtonDialog = require("ui/widget/buttondialog")
local SpinWidget = require("ui/widget/spinwidget")
local UIManager = require("ui/uimanager")
local _ = require("readingstyle_gettext")
local T = require("ffi/util").template

local Settings = require("readingstyle_settings")

local Quick = {}

--- Long enough that holding [+] does not re-render on every tick, short enough
-- that a deliberate single tap still feels immediate.
local APPLY_DELAY = 0.6

local BOOK_DEFAULT = _("book default")

--- Alignment cycles through unset as well: "leave it to the publisher" is a
-- state the reader needs to be able to get back to without opening a submenu.
local ALIGN_CYCLE = { false, "left", "justify", "right" }
local ALIGN_LABELS = {
    left = _("Left"),
    justify = _("Justified"),
    right = _("Right"),
}

local ROWS = {
    { key = "para_indent",          engine = false, label = _("Indent") },
    { key = "para_spacing",         engine = false, label = _("Spacing") },
    { key = "chapter_space_before", engine = false, label = _("Chapter") },
    { key = "line_spacing",         engine = true,  label = _("Line"), step = 5 },
}

-- Values --------------------------------------------------------------------

local function specFor(row)
    return row.engine and Settings.ENGINE_SCHEMA[row.key] or Settings.CSS_SCHEMA[row.key]
end

local function currentValue(state, row)
    if row.engine then
        local pending = state.pending_engine[row.key]
        if pending ~= nil then return pending end
        return state.plugin:getEngineValue(row.key)
    end
    return state.plugin:getValue(row.key)
end

local function formatValue(row, value)
    if value == nil then return BOOK_DEFAULT end
    local spec = specFor(row)
    local text
    if row.engine then
        text = tostring(math.floor(value))
    else
        text = spec.precision:format(value)
    end
    if spec.unit then
        text = text .. "\u{202F}" .. spec.unit
    end
    return text
end

local function rowLabel(state, row)
    return T("%1   %2", row.label, formatValue(row, currentValue(state, row)))
end

-- Painting ------------------------------------------------------------------

local function repaint(state)
    if not state.dialog then return end
    UIManager:setDirty(state.dialog, function()
        return "ui", state.dialog.movable.dimen
    end)
end

--- Updates one button's label without rebuilding the dialog.
-- Passing the button's existing width keeps the frame intact, so this stays a
-- cheap partial refresh instead of a full relayout.
local function setButtonText(state, id, text)
    local button = state.dialog and state.dialog:getButtonById(id)
    if button then
        button:setText(text, button.width)
    end
end

local function refreshRow(state, row)
    setButtonText(state, "value_" .. row.key, rowLabel(state, row))
    repaint(state)
end

-- Applying ------------------------------------------------------------------

local function flush(state)
    UIManager:unschedule(state.flush_callback)
    -- Each of these events re-renders on its own, so no extra apply is needed
    -- for them; only the CSS half goes through the plugin's apply.
    for key, value in pairs(state.pending_engine) do
        state.plugin:setEngineValue(key, value)
        state.pending_engine[key] = nil
    end
    if state.plugin:hasPendingChanges() then
        state.plugin:applyNow()
    end
end

local function scheduleFlush(state)
    UIManager:unschedule(state.flush_callback)
    -- With immediate apply off, nothing happens until the reader presses Apply.
    if not state.plugin.auto_apply then return end
    UIManager:scheduleIn(APPLY_DELAY, state.flush_callback)
end

-- Controls ------------------------------------------------------------------

local function step(state, row, direction)
    local spec = specFor(row)
    local value = currentValue(state, row)
    if value == nil then
        -- First press on an untouched setting lands on the schema default,
        -- rather than jumping one step away from an invisible starting point.
        value = spec.default or spec.min
    else
        local increment = (row.step or spec.step) * direction
        value = Settings.round(value + increment, spec.step)
        value = math.max(spec.min, math.min(spec.max, value))
    end

    if row.engine then
        state.pending_engine[row.key] = value
    else
        -- Never immediate: the timer below decides when the book re-renders.
        state.plugin:setValue(row.key, value, false)
    end
    refreshRow(state, row)
    scheduleFlush(state)
end

--- Hold on a value opens the full control, including "book default".
local function openSpin(state, row)
    local spec = specFor(row)
    local value = currentValue(state, row) or spec.default or spec.min
    local widget
    local params = {
        title_text = row.label,
        value = value,
        value_min = spec.min,
        value_max = spec.max,
        value_step = spec.step,
        value_hold_step = spec.hold_step or (spec.step * 10),
        unit = spec.unit,
        precision = not row.engine and spec.precision or nil,
        callback = function(spin)
            if row.engine then
                state.pending_engine[row.key] = spin.value
            else
                state.plugin:setValue(row.key, spin.value, false)
            end
            refreshRow(state, row)
            flush(state)
        end,
    }
    if not row.engine then
        params.default_value = spec.default
        params.extra_text = _("Book default")
        params.extra_callback = function()
            state.plugin:setValue(row.key, nil, false)
            refreshRow(state, row)
            flush(state)
        end
    end
    widget = SpinWidget:new(params)
    UIManager:show(widget)
end

local function cycleAlignment(state)
    local current = state.plugin:getValue("text_align") or false
    local index = 1
    for i, value in ipairs(ALIGN_CYCLE) do
        if value == current then
            index = i
            break
        end
    end
    local next_value = ALIGN_CYCLE[(index % #ALIGN_CYCLE) + 1]
    state.plugin:setValue("text_align", next_value or nil, false)
    setButtonText(state, "align", state.alignText())
    repaint(state)
    scheduleFlush(state)
end

local function cycleScope(state)
    local plugin = state.plugin
    local scopes = { Settings.SCOPE_GLOBAL, Settings.SCOPE_BOOK }
    if plugin.language then
        table.insert(scopes, 2, Settings.SCOPE_LANGUAGE)
    end
    local current = plugin:getScope()
    local index = 1
    for i, scope in ipairs(scopes) do
        if scope == current then
            index = i
            break
        end
    end
    local next_scope = scopes[(index % #scopes) + 1]
    -- Widening the scope discards the narrower table; the reader is told which
    -- style is in charge now by the button label, and can cycle straight back.
    plugin:setScope(next_scope)
    setButtonText(state, "scope", state.scopeText())
    for _index, row in ipairs(ROWS) do
        refreshRow(state, row)
    end
    setButtonText(state, "align", state.alignText())
    repaint(state)
    -- A different style is in charge now: show it rather than wait for a timer.
    flush(state)
end

-- Assembly ------------------------------------------------------------------

function Quick.show(plugin)
    local state = {
        plugin = plugin,
        pending_engine = {},
    }
    state.flush_callback = function() flush(state) end

    -- While this screen is open it owns the timing of every apply, so the
    -- plugin must not also schedule one behind our back.
    plugin.defer_apply = true
    state.teardown = function()
        if state.torn_down then return end
        state.torn_down = true
        plugin.defer_apply = false
        flush(state)
    end

    state.alignText = function()
        local value = plugin:getValue("text_align")
        return T("%1: %2", _("Align"), value and ALIGN_LABELS[value] or BOOK_DEFAULT)
    end
    state.scopeText = function()
        local scope = plugin:getScope()
        local label = _("All books")
        if scope == Settings.SCOPE_BOOK then
            label = _("This book")
        elseif scope == Settings.SCOPE_LANGUAGE then
            label = T(_("Lang: %1"), plugin.language or "?")
        end
        return label
    end

    local buttons = {}
    for _index, row in ipairs(ROWS) do
        buttons[#buttons + 1] = {
            {
                text = "\u{2212}", -- minus sign, matching the plus below
                callback = function() step(state, row, -1) end,
            },
            {
                id = "value_" .. row.key,
                text = rowLabel(state, row),
                callback = function() openSpin(state, row) end,
                hold_callback = function() openSpin(state, row) end,
            },
            {
                text = "+",
                callback = function() step(state, row, 1) end,
            },
        }
    end

    buttons[#buttons + 1] = {
        {
            id = "align",
            text = state.alignText(),
            callback = function() cycleAlignment(state) end,
        },
        {
            id = "scope",
            text = state.scopeText(),
            callback = function() cycleScope(state) end,
        },
    }

    buttons[#buttons + 1] = {
        {
            text = _("Reset"),
            callback = function()
                plugin:resetStyle()
                state.pending_engine = {}
                for _index, row in ipairs(ROWS) do
                    refreshRow(state, row)
                end
                setButtonText(state, "align", state.alignText())
                repaint(state)
                flush(state)
            end,
        },
        {
            text = _("Apply"),
            callback = function() flush(state) end,
        },
        {
            text = _("Close"),
            callback = function()
                state.teardown()
                UIManager:close(state.dialog)
            end,
        },
    }

    state.dialog = ButtonDialog:new{
        title = _("Reading style"),
        title_align = "center",
        width_factor = 0.9,
        buttons = buttons,
        dismissable = true,
    }

    -- Anything still queued has to land however the dialog goes away — the Close
    -- button, a tap outside it, the back key, or the reader shutting down. Only
    -- onCloseWidget sees all four, so hook that rather than tap_close_callback.
    local dialog_onCloseWidget = state.dialog.onCloseWidget
    state.dialog.onCloseWidget = function(dialog)
        state.teardown()
        return dialog_onCloseWidget(dialog)
    end

    UIManager:show(state.dialog)
end

return Quick
