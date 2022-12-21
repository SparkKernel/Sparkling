local Ids = {}

RegisterNetEvent('Sparkling:ReturnClientCallback', function(id, resp)
    if Ids[id] == nil then return Error("Cannot find callback-id", 'Sparkling', 'id: '..id) end
    Ids[id](resp) Ids[id] = nil
end)

ClientObject = function(id)
    local self = {}

    local function Get() return Users.Players[id] or nil end

    function self:Event(name, ...)
        if Get() == nil then return end
        TriggerClientEvent(name, Get().src, ...)
    end

    function self:Callback(name, func, ...)
        if Get() == nil then return end
        local callback = tostring(math.random(1000000, 9999999))
        Ids[callback] = func
        TriggerClientEvent('Sparkling:TriggerClientCallback', Get().src, name, callback, ...)
    end

    return self
end

PlayerObjects:Add({
    name = "Client",
    object = ClientObject
})