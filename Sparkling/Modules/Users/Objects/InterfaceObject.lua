RegisterNetEvent('Sparkling:UI:Prompt:Status', function(status, data)
    local source = source
    
    local id = Users.Utility.GetSteam(source)
    
    if Users.Players[id] == nil or Users.Players[id].interface.prompt == nil then return end -- user has no ongoing prompt

    local func = Users.Players[id].interface.prompt
    Users.Players[id].interface.prompt = nil
    func(status, data)
end)

local function close(src)
    local source = source
    if src ~= nil then
        source=src
    end
    local id = Users.Utility.GetSteam(source)

    if Users.Players[id] == nil or Users.Players[id].interface.menu == nil then return print("no menu open") end

    Users.Players[id].interface.menu = nil

    TriggerClientEvent("Sparkling:UI:Menu:Close", source)
end

RegisterNetEvent('Sparkling:UI:Menu:TryClose', close)

RegisterNetEvent('Sparkling:UI:Menu:Click', function(button)
    local source = source
    local id = Users.Utility.GetSteam(source)

    if Users.Players[id] == nil or Users.Players[id].interface.menu == nil then return print("no menu open") end

    local menu = Users.Players[id].interface.menu

    local found = false

    for i,v in pairs(menu.data) do
        if v == button then
            found = true
            break
        end
    end

    if not found then return print("cannot find button") end

    menu.click(button)
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

        function new:Buttons(d)
            for i,v in pairs(d) do
                local playerGroups = Users.Players[Users.Utility.GetSteam(source)].groups
                if v[1] ~= nil then
                    local hasAccess = false
                    for _, neededGroup in pairs(v) do
                        if hasAccess then break end
                        for _, playerGroup in pairs(playerGroups) do
                            if neededGroup == playerGroup then hasAccess = true break end
                        end
                    end
                    if hasAccess then
                        table.insert(data, i) 
                    end
                else
                    table.insert(data, i) 
                end
            end
        end

        function new:Show(text, click)
            if Get() == nil then
                Warn("Cannot find user (menu)")
                return false
            end
            if Get()['interface']['menu'] ~= nil then
                Warn("User is already in a menu")
                return false
            end
    
            Users.Players[id].interface.menu = {data=data, click=click}
    
            TriggerClientEvent('Sparkling:UI:Menu:Show', Get()['src'], text, data)
        end    

        function new:Close()
            local User = Get()
            if User == nil then return print("Cannot find user") end

            close(User['src'])
        end

        return new
    end
    return self
end

PlayerObjects:Add({
    name = "Interface",
    object = Object
})