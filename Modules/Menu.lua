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
                        local TargetUser = Sparkling.Users:Get(target)
                        if TargetUser == nil then
                            return User.Interface.Notify:Add("Cannot find user",'#F64668')
                        end
                        User.Interface.Prompt:Show("Reason of the ban", '50px', function(status, reason)
                            if status then
                                User.Interface.Notify:Add("You successfully banned user "..target.."!",'#92DE8D')
                                TargetUser.Admin:Ban(reason)
                            else
                                User.Interface.Notify:Add("You cancelled the ban.",'#F64668')
                            end
                        end)
                    else
                        User.Interface.Notify:Add("You cancelled the ban.",'#F64668')
                    end     
                end)
            end,
            Unban = function(User)
                User.Interface.Prompt:Show("User id, hex, or source", '50px', function(status, target)
                    if status then
                        local TargetUser = Sparkling.Users:Get(target)
                        if TargetUser == nil then 
                            return User.Interface.Notify:Add("Cannot find user",'#F64668')
                        end
                        TargetUser.Admin:Unban()
                        User.Interface.Notify:Add("You successfully unbanned user "..target.."!",'#92DE8D')
                    else
                        User.Interface.Notify:Add("You cancelled the unban.",'#F64668')
                    end     
                end)
            end,
            Kick = function(User)
                User.Interface.Prompt:Show("User id, hex, or source", '50px', function(status, target)
                    if status then
                        local TargetUser = Sparkling.Users:Get(target)
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
                                User.Interface.Notify:Add("You cancelled the kick.",'#F64668')
                            end
                        end)
                    else
                        User.Interface.Notify:Add("You cancelled the kick.",'#F64668')
                    end
                end)
            end,
            Whitelist = function(User)
                User.Interface.Prompt:Show("User id, hex, or source", '50px', function(status, target)
                    if status then
                        local TargetUser = Sparkling.Users:Get(target)
                        if TargetUser == nil then 
                            return User.Interface.Notify:Add("Cannot find user",'#F64668')
                        end
                        TargetUser.Admin:Whitelist()
                        User.Interface.Notify:Add("You successfully whitelisted user "..target.."!",'#92DE8D')
                    else
                        User.Interface.Notify:Add("You cancelled the whitelist.",'#F64668')
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
    },
    Testing = {
        Data = {
            [1] = {buttonName = "Copy Coords"},
            [2] = {buttonName = "Noclip"},
            [3] = {buttonName = "Spawn Car"},
            [4] = {buttonName = "Give Weapon"},
            [5] = {buttonName = "Refill Ammo"},
            [6] = {buttonName = "Repair Vehicle"},
            [7] = {buttonName = "Delete Vehicle"}
        },
        Funcs = {
            ['Copy Coords'] = function(User)
                local x,y,z = User.Position:Get()
                User.NUI.Clipboard:Copy(x..', '..y..', '..z)
                User.Interface.Notify:Add("Copied coords to your clipboard!",'#92DE8D')
            end,
            ['Noclip'] = function(User)
                local User = Users.Players[User.steam]
                User.noclip = not User.noclip

                TriggerClientEvent("Sparkling:ToggleNoclip", User.src, User.noclip)
            end,
            ['Spawn Car'] = function(User)
                User.Interface.Prompt:Show("Please write the car-code", '50px', function(status, car)
                    if status then
                        User.Client:Event('Sparkling:SpawnCar', car)
                        User.Interface.Notify:Add("Here is your new "..car.."!",'#92DE8D')
                    else
                        User.Interface.Notify:Add("Whoops, no car for you :)",'#F64668')
                    end 
                end)
            end,
            ['Give Weapon'] = function(User)
                User.Interface.Prompt:Show("Please enter the weapon name", '50px', function(status, weapon)
                    if status then
                        User.Weapon:Give('weapon_'..weapon, 250)
                        User.Interface.Notify:Add("Here is your new "..weapon.."!",'#92DE8D')
                    else
                        User.Interface.Notify:Add("Whoops, no weapon for you :)",'#F64668')
                    end 
                end)
            end,
            ['Refill Ammo'] = function(User)
                User.Weapon.Ammo:Set(User.Weapon:Current(), 250)
            end,
            ['Repair Vehicle'] = function(User)
                if GetVehiclePedIsIn(ped, false) then
                    local response = User.Client:Callback('Repair')
                    print(response)
                    if response then
                        User.Interface.Notify:Add("You repaired your vehicle.",'#92DE8D')
                    else
                        User.Interface.Notify:Add("You need to be in a vehicle!",'#F64668')
                    end
                end
            end,
            ['Delete Vehicle'] = function(User)
                DeleteVehicle(GetVehiclePedIsIn(GetPlayerPed(User.src), false))
            end
        }
    }
}

RegisterNetEvent('Sparkling:UI:Menu:Open:Main', function()
    local source = source
    local User = Sparkling.Users:Get(source)

    if not User.Interface.Menu:Has() then
        if User == nil then return Error("Cannot find user", 'Sparkling', 'Trying to open Main Menu', 'Modules/Menu.lua') end

        local Menu = User.Interface.Menu:New()
        Menu:Buttons({
            [1] = {buttonName = "Admin", perms = {"Admin", "Owner"}},
            [2] = {buttonName = "Inventory"},
            [3] = {buttonName = "Testing"},
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