-- EventObject file handler for the Extensions module
-- Created by frackz

EventObject = function(module, event)
    local self = {}
    function self:Run(args)
        if Extension.Events[module][event] == nil then return Error("Cannot find event "..event, 'Sparkling', 'Tried to run non-existing event', 'Modules/Extensions/EventObject.lua') end
        for k,v in pairs(Extension.Events[module][event]) do
            v(table.unpack(args))
        end
    end
    function self:Clear()
        if Events[module][event] == nil then return Error("Cannot find event "..event, 'Sparkling', 'Tried to clear non-existing event', 'Modules/Extensions/EventObject.lua') end
        Extension.Events[module][event] = {}
    end
    function self:Delete()
        if Events[module][event] == nil then return Error("Cannot find event "..event, 'Sparkling', 'Tried to delete non-existing event', 'Modules/Extensions/EventObject.lua') end
        Extension.Events[module][event] = nil
    end
    return self
end