--[[--
Reading style — the bookkeeping half of the preview sandbox.

While a preview is open the reader can change anything the plugin owns without
the book being touched. Two things make that possible, and only one of them is
in this file:

  * main.lua stops applying and stops driving KOReader's document settings,
  * this module remembers what the book looked like before, and what the reader
    has chosen since.

Which is why it is pure: no KOReader dependencies, so the part that has to be
exactly right — that cancelling really does put everything back — is testable
in plain LuaJIT.

What has to be restored, and what does not
------------------------------------------
Style tables are plain data that nothing reads until something applies them, so
they can be edited freely and simply put back. All three levels are snapshotted,
not just the one being edited: switching scope under a preview is allowed, and
switching seeds a level that had no style of its own.

Engine settings (line spacing, margins…) need no restoring at all. Under a
sandbox they are never written to the document, only remembered here, so there
is nothing to undo — which is the reason the sandbox intercepts them rather
than letting them through and reversing them afterwards.
--]]

local Settings = require("readingstyle_settings")

local Sandbox = {}
Sandbox.__index = Sandbox

--- state is what the plugin looks like right now:
--   scope, pending, global (style table), book (style table or nil),
--   languages (code -> style table)
function Sandbox.new(state)
    state = state or {}
    return setmetatable({
        -- What the reader has chosen for KOReader's own document settings.
        -- Handed to the preview subprocess as it is.
        engine = {},
        dirty = false,
        snapshot = {
            scope = state.scope,
            pending = state.pending,
            global = Settings.copy(state.global),
            book = state.book and Settings.copy(state.book) or nil,
            languages = Settings.copyLanguages(state.languages),
        },
    }, Sandbox)
end

function Sandbox:setEngine(key, value)
    if not Settings.ENGINE_SCHEMA[key] then return false end
    self.engine[key] = value
    self.dirty = true
    return true
end

function Sandbox:engineValue(key)
    return self.engine[key]
end

--- The chosen engine settings in the schema's own order, so applying them is
-- deterministic: two settings that talk to the same crengine property (the
-- margins, when the reader has top and bottom linked) must land in the same
-- order every time, or the result depends on table iteration.
function Sandbox:orderedEngine()
    local list = {}
    for _index, key in ipairs(Settings.ENGINE_KEYS) do
        local value = self.engine[key]
        if value ~= nil then
            list[#list + 1] = { key = key, value = value }
        end
    end
    return list
end

function Sandbox:markChanged()
    self.dirty = true
end

--- True once per change. The preview asks after every settings screen closes,
-- to decide whether it has to render again.
function Sandbox:takeChange()
    local dirty = self.dirty
    self.dirty = false
    return dirty
end

function Sandbox:hasEngineChanges()
    return next(self.engine) ~= nil
end

--- What the plugin has to put back when the reader cancels. Detached from both
-- the plugin's live tables and this sandbox, so nothing that happens afterwards
-- can reach back into it.
function Sandbox:restored()
    local snapshot = self.snapshot
    return {
        scope = snapshot.scope,
        pending = snapshot.pending,
        global = Settings.copy(snapshot.global),
        book = snapshot.book and Settings.copy(snapshot.book) or nil,
        languages = Settings.copyLanguages(snapshot.languages),
    }
end

return Sandbox
