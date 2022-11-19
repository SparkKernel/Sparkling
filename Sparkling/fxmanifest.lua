fx_version 'cerulean'
game 'gta5'

author 'Fr3ckzDK <github.com/dkfrede>'
description 'A FiveM framework named Sparkling'
version '1.0'

server_export 'Spark'

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'Sparkling.lua',

    -- Configs
    'Config.lua',
    'Config/Player.lua',
    'Testing/Config.lua',

    -- Utility
    'Utility/Error.lua',
    
    -- Extensions
    'Modules/Extensions/Handler.lua',
    'Modules/Extensions/EventObject.lua',
    'Modules/Extensions/New.lua',

    -- PlayerObject
    'Modules/Users/Objects/PlayerObject.lua',

    -- PlayerObject's objects?:
        'Modules/Users/Objects/AdminObject.lua',
        'Modules/Users/Objects/CashObject.lua',
        'Modules/Users/Objects/GroupObject.lua',
        'Modules/Users/Objects/IdentityObject.lua',
        'Modules/Users/Objects/InventoryObject.lua',
        'Modules/Users/Objects/SurvivalObject.lua',
        'Modules/Users/Handler.lua',
        'Modules/Users/Utility.lua',

    -- Testing
    'Testing/PlayerObject.lua',

    -- Updater
    'Updater.lua'
}

client_scripts {
    "Client/Spawned.lua"
}