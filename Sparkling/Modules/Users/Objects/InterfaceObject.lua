local Interfaces = {}

RegisterNetEvent('Sparkling:UI:Prompt:Status', function(status, data)
    local source = source
    
    local id = Users.Utility.GetSteam(source)
    
    if Interfaces[id] == nil then return end -- user has no ongoing prompt

    Interfaces[id](status, data)

    Interfaces[id] = nil
end)

local Object = function(id)
    local self = {}

    function Get() return Users.Players[id] or nil end

    self.Prompt = {}
    function self.Prompt:Show(text, update)
        if Get() == nil then
            return false
        end
        if Interfaces[id] ~= nil then
            return false
        end

        Interfaces[id] = update

        TriggerClientEvent('Sparkling:UI:Prompt:Show', Get()['src'], text)
    end

    return self
end

PlayerObjects:Add({
    name = "Interface",
    object = Object
})