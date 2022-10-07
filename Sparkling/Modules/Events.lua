local Sparkling = Spark()

local Extension = {}
local Funcs = {}

local Events = {}

function Sparkling:Events() return Funcs end

function Funcs:Create(event)
    if Events[event] ~= nil then return print("[Sparkling] Event already exists "..event) end
    Events[event] = {}
    function self:Run(args)
        if Events[event] == nil then return print("[Sparkling] Cannot find event "..event) end
        for k,v in pairs(Events[event]) do
            v(table.unpack(args))
        end
    end
    function self:Clear()
        if Events[event] == nil then return print("[Sparkling] Cannot find event "..event) end
        Events[event] = {}
    end
    function self:Delete()
        if Events[event] == nil then return print("[Sparkling] Cannot find event "..event) end
        Events[event] = nil
    end
    return self
end

function Funcs:Handler(event, func)
    if Events[event] == nil then return print("[Sparkling] Cannot find event "..event) end
    table.insert(Events[event], func)
end