local cfg = {} -- ignore

cfg.Groups = {
    Owner = {
        Events = {
            OnSpawn = function(User)
                Debug("A user with role Owner just joined! (steam: "..User.steam.." | id: "..User.id)
            end
        },
        Permissions = {
            'kick',
            'ban'
        }
    },
    Admin = {
        Events = {
            OnSpawn = function(User)
                Debug("A user with role Admin just joined! (steam: "..User.steam.." | id: "..User.id)
            end
        },
        Permissions = {
            'kick',
            'ban'
        }
    }
}

Config:Add('Group', cfg) -- ignore