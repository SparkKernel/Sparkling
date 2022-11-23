RegisterNetEvent('Sparkling:UI:Prompt:Status', function(status, data)
    local source = source
    
    local id = Users.Utility.GetSteam(source)
    
    if Users.Players[id] == nil or Users.Players[id].interface.prompt == nil then return end -- user has no ongoing prompt

    local func = Users.Players[id].interface.prompt
    Users.Players[id].interface.prompt = nil
    func(status, data)
end)

local Object = function(id)
    local self = {}

    function Get() return Users.Players[id] or nil end

    self.Prompt = {}
    function self.Prompt:Has()
        return Users.Players[id].interface ~= nil
    end
    function self.Prompt:Show(text, update)
        if Get() == nil then
            Warn("Cannot find user (prompt)")
            return false
        end
        if Get()['interface']['prompt'] ~= nil then
            Warn("User is already in a prompt")
            return false
        end

        Users.Players[id].interface.prompt = update

        TriggerClientEvent('Sparkling:UI:Prompt:Show', Get()['src'], text)
    end

    return self
end

PlayerObjects:Add({
    name = "Interface",
    object = Object
})