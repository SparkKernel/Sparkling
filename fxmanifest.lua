fx_version 'adamant'
game 'gta5'

author 'Fr3ckzDK <github.com/dkfrede>'
description 'A FiveM framework named Sparkling'
version '1.0'

server_export 'Spark'

ui_page 'Interface/index.html'

files {
    'Interface/clipboard.js',
    'Interface/*',
    'Interface/prompt/*',
    'Interface/menu/*',
    'Interface/notify/*',
}

shared_script 'Shared/*'

client_scripts {
    'Client/Callback/*',
    'Client/Weapons/*',
    "Client/Spawned.lua",
    'Client/UI/*',
    'Client/Spawn/Handler.lua',
    'Client/Menu/*',
    'Client/NUI/Handler.lua'
}

server_scripts {
    'Utility/Error.lua',
    -- Configs
    'Config.lua',
    'Config/*',
    'Testing/Config.lua',
    
    -- SQL
    'SQL/SQL.js',
    'SQL/Handler.lua',

    -- Webhooks
    'Webhooks/Handler.lua',
    
    'Sparkling.lua',

    -- Utility    
    -- Extensions
    'Modules/Client/*',
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
        'Modules/Users/Objects/PositionObject.lua',
        'Modules/Users/Objects/NUIObject.lua',
        'Modules/Users/Handler.lua',

        'Modules/Users/Online.lua',

        'Modules/Users/Utility.lua',

    -- Testing
    'Testing/PlayerObject.lua',

    "Modules/Users/SpawnHandler.lua",
    "Modules/Users/QuitHandler.lua",

    -- Updater
    'Updater.lua',

    'Modules/Menu.lua'
}