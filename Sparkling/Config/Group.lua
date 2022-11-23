Config = Config or {}

Config.Groups = {
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
    },
    Admin = {
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