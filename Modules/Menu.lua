local Sparkling = exports['Sparkling']:Spark()
local Menus = {
    Admin = {
        Data = {
            [1] = {buttonName = "Ban", perms = {"Owner"}},
            [2] = {buttonName = "Unban", perms = {"Owner"}},
            [3] = {buttonName = "Kick", perms = {"Admin", "Owner"}},
            [4] = {buttonName = "Whitelist", perms = {"Admin", "Owner"}},
            [5] = {buttonName = "Unwhitelist", perms = {"Admin", "Owner"}}
        },
        Funcs = {
            Ban = function(User)
                User.Interface.Prompt:Show("User id, hex, or source", '50px', function(status, target)
                    if status then
                        local TargetUser = Sparkling.Users.Get(target)
                        if TargetUser == nil then
                            return User.Interface.Notify:Add("Cannot find user",'#F64668')
                        end
                        User.Interface.Prompt:Show("Reason of the ban", '50px', function(status, reason)
                            if status then
                                User.Interface.Notify:Add("You successfully banned user "..target.."!",'#92DE8D')
                                TargetUser.Admin:Ban(reason)
                            else
                                User.Interface.Notify:Add("You cancelled the ban...",'#F64668')
                            end
                        end)
                    else
                        User.Interface.Notify:Add("You cancelled the ban...",'#F64668')
                    end     
                end)
            end,
            Unban = function(User)
                User.Interface.Prompt:Show("User id, hex, or source", '50px', function(status, target)
                    if status then
                        local TargetUser = Sparkling.Users.Get(target)
                        if TargetUser == nil then 
                            return User.Interface.Notify:Add("Cannot find user",'#F64668')
                        end
                        TargetUser.Admin:Unban()
                        User.Interface.Notify:Add("You successfully unbanned user "..target.."!",'#92DE8D')
                    else
                        User.Interface.Notify:Add("You cancelled the unban...",'#F64668')
                    end     
                end)
            end,
            Kick = function(User)
                User.Interface.Prompt:Show("User id, hex, or source", '50px', function(status, target)
                    if status then
                        local TargetUser = Sparkling.Users.Get(target)
                        if TargetUser == nil then 
                            return User.Interface.Notify:Add("Cannot find user",'#F64668')
                        end
                        User.Interface.Prompt:Show("Reason for the kick", '50px', function(status, reason)
                            if status then
                                if not TargetUser:isOnline() then
                                    return User.Interface.Notify:Add("User is not online",'#F64668')
                                end
                                TargetUser.Admin:Kick(reason)
                                User.Interface.Notify:Add("You successfully kicked user "..target.."!",'#92DE8D')
                            else
                                User.Interface.Notify:Add("You cancelled the kick...",'#F64668')
                            end
                        end)
                    else
                        User.Interface.Notify:Add("You cancelled the kick...",'#F64668')
                    end
                end)
            end,
            Whitelist = function(User)
                User.Interface.Prompt:Show("User id, hex, or source", '50px', function(status, target)
                    if status then
                        local TargetUser = Sparkling.Users.Get(target)
                        if TargetUser == nil then 
                            return User.Interface.Notify:Add("Cannot find user",'#F64668')
                        end
                        TargetUser.Admin:Whitelist()
                        User.Interface.Notify:Add("You successfully whitelisted user "..target.."!",'#92DE8D')
                    else
                        User.Interface.Notify:Add("You cancelled the whitelist...",'#F64668')
                    end
                end)
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
            [1] = {buttonName = "Admin", perms = {"Admin", "Owner"}},
            [2] = {buttonName = "Inventory"},
        })
        Menu:Title("Main Menu")

        Menu:Callback(function(button)
            if Menus[button] == nil then return Warn("Cannot find menu") end
            local NewMenu = User.Interface.Menu:New()
            NewMenu:Buttons(Menus[button].Data)

            Menu:Close()

            NewMenu:Title(button)
            
            NewMenu:Callback(function(btn)
                if not User:isOnline() then return end
                Menus[button].Funcs[btn](User)
            end, function() 
                if not User:isOnline() then return end
                Menu:Show()
            end)

            NewMenu:Show() 
        end,nil)

        Menu:Show()
    end
end)