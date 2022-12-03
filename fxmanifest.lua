fx_version 'cerulean'
game 'gta5'

author 'Fr3ckzDK <github.com/dkfrede>'
description 'A FiveM framework named Sparkling'
version '1.0'

server_export 'Spark'

ui_page 'Interface/index.html'
files {
    'Interface/*',
    'Interface/prompt/*',
    'Interface/menu/*',
    'Interface/notify/*',
}

server_scripts {
    -- Configs
    'Config.lua',
    'Config/*',
    'Testing/Config.lua',
    
    -- SQL
    'SQL/SQL.js',
    'SQL/Handler.lua',
    
    'Sparkling.lua',

    -- Utility
    'Utility/Error.lua',
    
    -- Extensions
    'Modules/Extensions/*',

    -- PlayerObject
    'Modules/Users/Objects/PlayerObject.lua',

    -- PlayerObject's objects?:
        'Modules/Users/Objects/AdminObject.lua',
        'Modules/Users/Objects/CashObject.lua',
        'Modules/Users/Objects/GroupObject.lua',
        'Modules/Users/Objects/IdentityObject.lua',
        'Modules/Users/Objects/InventoryObject.lua',
        'Modules/Users/Objects/InterfaceObject.lua',
        'Modules/Users/Objects/SurvivalObject.lua',
        'Modules/Users/Handler.lua',
        'Modules/Users/Utility.lua',
        'Modules/Users/Online.lua',

    -- Testing
    'Testing/PlayerObject.lua',

    -- Updater
    'Updater.lua',

    'Modules/Menu.lua'
}

client_scripts {
    "Client/Spawned.lua",
    'Client/UI/*'
}