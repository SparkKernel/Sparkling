-- This is a testing-file
-- This is hard-coded asf (bc its for testing lol)

local cfg = Config:Get('Weapons'):Get('List')

RegisterCommand('test', function(src)
    local User = Sparkling.Users:Get(src)
    --User.Weapon:Give('weapon_pistol50', 250)
    User.Weapon.Ammo:Remove('weapon_pistol50', 10)
    print(User.Weapon.Ammo:Get('weapon_pistol50'))
    --User.Weapon:Give('weapon_pistol50', 250)
end)

RegisterCommand('test123', function(src, args)
    local User = Sparkling.Users:Get(args[1])
    User.Admin:Unban()
end)