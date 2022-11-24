local Sparkling = exports['Sparkling']:Spark()
local Menus = {
    Admin = {
        Data = {
            ['Ban'] = {"Owner"},
            ['Unban'] = {"Owner"},
            ['Kick'] = {"Admin", "Owner"},
            ['Whitelist'] = {"Admin", "Owner"},
            ['Unwhitelist'] = {"Admin", "Owner"}
        },
        Funcs = {
            Ban = function(User)
                User.Interface.Prompt:Show("User (id, steam-hex, source)", function(status, answer)
                    if status then
                        print("OK")
                    end     
                end)
            end,
            Unban = function(User)

            end,
            Kick = function(User)

            end,
            Whitelist = function(User)

            end,
            Unwhitelist = function(User)

            end,
        }
    },
    Inventory = {
        Data = {
            
        },
        Funcs = {
            
        }
    }
}

RegisterNetEvent('Sparkling:UI:Menu:Open:Main', function()
    local source = source
    local User = Sparkling.Users.Get(source)

    if not User.Interface.Menu:Has() then
        if User == nil then return Error("Cannot find user") end

        local Menu = User.Interface.Menu:New()
        Menu:Buttons({
            ['Admin'] = {"Admin", "Owner"},
            ['Inventory'] = {}
        })
        Menu:Show("Main Menu", function(button)
            if Menus[button] == nil then return print("cannot find menu") end
            local NewMenu = User.Interface.Menu:New()
            NewMenu:Buttons(Menus[button].Data)
            Menu:Close()
            NewMenu:Show(button.." Menu", function(btn)
                if not User:isOnline() then return end
                Menus[button].Funcs[btn](User)
            end)
        end)
    end
end)