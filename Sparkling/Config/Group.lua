local cfg = {} -- ignore

cfg.Groups = {
    Owner = {
        Events = {
            OnSpawn = function()
                print("HEY")
            end
        },
        Permissions = {
            'kick',
            'ban'
        }
    }
}

Config:Add('Group', cfg) -- ignore