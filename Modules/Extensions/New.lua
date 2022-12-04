function Extension.Funcs:New(name)
    local ret = {}
    local events = {}
    local ignore = true

    -- Events
    ret.Events = {}
    function ret.Events:Add(event)
        if events[event] ~= nil then return Error("Event already exists!", 'Sparkling', 'name: '..name, 'Modules/Extensions/New.lua') end
        events[event] = {}
        return EventObject(name, event)
    end

    function ret.Events:Get() return events end

    -- End Events

    function ret:Add(ext)
        if Extension.Registered[name] ~= nil and not ignore then return Error("Already a extension with that name!", 'Sparkling', 'name: '..name, 'Modules/Extensions/New.lua') end

        if not ext["Events"] then return end

        Extension.Events[name] = {}

        local ev = ext.Events:Get()
        for v in pairs(ev) do
            Extension.Events[name][v] = {}
        end

        ext.Events = {}
        function ext.Events:Handle(event, func)
            if Extension.Events[name][event] == nil then return Error("Cannot handle a non-existent event", 'Sparkling', 'name: '..name, 'Modules/Extensions/New.lua') end
            table.insert(Extension.Events[name][event], func)
        end

        function ext.Events:Get(event)
            if Extension.Events[name][event] == nil then return Error("Cannot get a non-existent event", 'Sparkling', 'name: '..name, 'Modules/Extensions/New.lua') end
            return EventObject(name, event)
        end

        function ext.Events:Exist(event) if Extension.Events[name][event] == nil then return false else return true end end

        Extension.Registered[name] = ext

        Debug("Added extension!", 'Sparkling', 'name: '..name, 'Modules/Extensions/New.lua')
    end

    return ret
end

Sparkling.Extensions = Extension.Funcs