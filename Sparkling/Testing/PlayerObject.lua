-- This is a testing-file
-- This is hard-coded asf (bc its for testing lol)

local Sparkling = exports['Sparkling']:Spark()
local Us = Sparkling.Users

RegisterCommand('ban', function(source, args)
    local User = Us.Get(args[1])
    User.Admin:Ban(args[2])
end)

RegisterCommand('unban', function(source, args)
    local User = Us.Get(args[1])
    User.Admin:Unban()
end)

RegisterCommand('whitelist', function(source, args)
    local User = Us.Get(args[1])
    User.Admin:Whitelist()
end)

RegisterCommand('unwhitelist', function(source, args)
    local User = Us.Get(args[1])
    User.Admin:Unwhitelist()
end)

RegisterCommand('kick', function(source, args)
    local User = Us.Get(args[1])
    User.Admin:Kick(args[2])
end)

RegisterCommand('isbanned', function(source, args)
    local User = Us.Get(args[1])
    print(User.Admin:IsBanned())
end)

RegisterCommand('getcash', function(source, args)
    local User = Us.Get(args[1])
    print(User.Cash:Get())
end)

RegisterCommand('isonline', function(source, args)
    local User = Us.Get(args[1])
    Debug("Is online: "..tostring(User:isOnline()))
end)

RegisterCommand('load', function(source, args)
    local steam = Users.Utility.GetSteam(source)
    print(steam)
    local resp = MySQL.query.await('SELECT * FROM users WHERE steam = ?', {steam})

    Debug("Debug register")
    Users.Funcs.Load(source,steam,resp,true)
end)

RegisterCommand('iswhitelisted', function(source, args)
    local User = Us.Get(args[1])
    print(User.Admin:isWhitelisted())
end)

RegisterCommand('payment', function(source, args)
    local User = Us.Get(args[1])
    local Payment = User.Cash:Payment(300)
    print(Payment)
end)

RegisterCommand('add', function(source, args)
    local User = Us.Get(args[1])
    local Payment = User.Cash:Add(300)
end)

RegisterCommand('has', function(source, args)
    local User = Us.Get(args[1])
    print(User.Group:Has(args[2]))
end)

RegisterCommand('groupadd', function(source, args)
    local User = Us.Get(args[1])
    User.Group:Add(args[2])
end)

RegisterCommand('grouprev', function(source, args)
    local User = Us.Get(args[1])
    User.Group:Remove(args[2])
end)
RegisterCommand('permission', function(source, args)
    local User = Us.Get(args[1])
    print(User.Group:Permission(args[2]))
end)

RegisterCommand('groups', function(source, args)
    local User = Us.Get(args[1])
    print(json.encode(User.Group:Get()))
end)

RegisterCommand('hunger', function(source, args)
    local User = Us.Get(args[1])
    local Survival = User.Survival

    Survival.Hunger:Remove(6060606)
    print(Survival.Hunger:Get())
    Survival.Thirst:Remove(6060606)
    print(Survival.Thirst:Get())
end)


RegisterCommand('name', function(source, args)
    local User = Us.Get(args[1])
    User.Identity.Last:Change('bo123b')
    local name = User.Identity:GetName()
    if name then
        print(name.string)
        
    end
end)

RegisterCommand('me', function(source, args)
    print("HEY")
    local User = Us.Get(source)

    print(User.steam)
    print(User.id)
    print(User.endpoint)
end)