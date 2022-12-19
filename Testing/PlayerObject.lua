-- This is a testing-file
-- This is hard-coded asf (bc its for testing lol)

local cfg = Config:Get('Weapons'):Get('List')

RegisterCommand('test', function(src)
    local User = Sparkling.Users:Get(src)
    print(User.Weapon:Give('weapon_snspistol_mk2', 250))
end)

RegisterCommand('test123', function(src, args)
    local User = Sparkling.Users:Get(args[1])
    User.Admin:Unban()
end)