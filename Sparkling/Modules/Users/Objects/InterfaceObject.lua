RegisterNetEvent('Sparkling:UI:Prompt:Status', function(status, data)
    local source = source
    
    local id = Users.Utility.GetSteam(source)
    
    if Users.Players[id] == nil or Users.Players[id].interface.prompt == nil then return end -- user has no ongoing prompt

    local func = Users.Players[id].interface.prompt
    Users.Players[id].interface.prompt = nil
    func(status, data)
end)

RegisterNetEvent('Sparkling:UI:Menu:TryClose', function()
    local source = source
    local id = Users.Utility.GetSteam(source)

    if Users.Players[id] == nil or Users.Players[id].interface.menu == nil then return print("no menu open") end

    Users.Players[id].interface.menu = nil

    TriggerClientEvent("Sparkling:UI:Menu:Close", source)
end)

local Object = function(id)
    local self = {}

    function Get() return Users.Players[id] or nil end

    self.Prompt = {}
    function self.Prompt:Has()
        return Users.Players[id].interface.prompt ~= nil
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

    self.Menu = {}
    function self.Menu:Has()
        return Users.Players[id].interface.menu ~= nil
    end
    function self.Menu:New()
        local new = {}
        local data = {}

        function new:Button(name)
            table.insert(data, name)
        end

        function new:Show(text)
            if Get() == nil then
                Warn("Cannot find user (menu)")
                return false
            end
            if Get()['interface']['menu'] ~= nil then
                Warn("User is already in a menu")
                return false
            end
    
            Users.Players[id].interface.menu = true
    
            TriggerClientEvent('Sparkling:UI:Menu:Show', Get()['src'], text, data)
        end    

        return new
    end
    return self
end

PlayerObjects:Add({
    name = "Interface",
    object = Object
})