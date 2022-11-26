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

    local menu = Users.Players[id].interface.menu

    Users.Players[id].interface.menu = nil

    TriggerClientEvent("Sparkling:UI:Menu:Close", source)

    if menu.close ~= nil then
        menu.close()
    end
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

    if not found then return print("Cannot find button") end

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
        if Get() == nil then return false end
        return Users.Players[id].interface.menu ~= nil
    end
    function self.Menu:New()
        local new = {}
        local title = 'Basic'
        local callbacks = {}
        local data = {}

        function new:Title(t) title = t end
        function new:Callback(press, close) callbacks['press'] = press callbacks['close'] = close end

        function new:Buttons(d)
            if Get() == nil then return Error("User is not registered.") end
            for i,v in pairs(d) do
                local playerGroups = Get().groups
                if v.perms ~= nil then
                    local hasAccess = false
                    for _, neededGroup in pairs(v.perms) do
                        if hasAccess then break end
                        for _, playerGroup in pairs(playerGroups) do
                            if neededGroup == playerGroup then hasAccess = true break end
                        end
                    end
                    if hasAccess then
                        table.insert(data, v.buttonName) 
                    end
                else
                    table.insert(data, v.buttonName) 
                end
            end
        end

        function new:Show()
            if Get() == nil then
                Warn("Cannot find user (menu)")
                return false
            end
            if Get()['interface']['menu'] ~= nil then
                Warn("User is already in a menu")
                return false
            end

            if callbacks['press'] == nil then
                return Error("Cannot have a nil press callback")
            end

            print(json.encode(data))
    
            Users.Players[id].interface.menu = {data=data, click=callbacks['press'], close=callbacks['close']}
    
            TriggerClientEvent('Sparkling:UI:Menu:Show', Get()['src'], title, data)
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