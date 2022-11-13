local Sparkling = exports['Sparkling']:Spark()
local Users = Sparkling.Users

RegisterCommand('ban', function(source, args)
    local User = Users.Get(args[1])
    User.Admin:Ban(args[2])
end)

RegisterCommand('unban', function(source, args)
    local User = Users.Get(args[1])
    User.Admin:Unban(args[2])
end)

RegisterCommand('whitelist', function(source, args)
    local User = Users.Get(args[1])
    User.Admin:Whitelist()
end)

RegisterCommand('unwhitelist', function(source, args)
    local User = Users.Get(args[1])
    User.Admin:Unwhitelist()
end)