fx_version 'cerulean'
game 'gta5'

author 'Fr3ckzDK <github.com/dkfrede>'
description 'A FiveM framework named Sparkling'
version '1.0'

server_export 'Spark'

ui_page 'Interface/index.html'
files {
    'Interface/font.otf',
    'Interface/text.ttf',
    'Interface/index.html',
    'Interface/index.js',
    'Interface/menu.js',
    'Interface/notify.js',
    'Interface/index.css',
    'Interface/menu.css',
    'Interface/notify.css',
}

server_scripts {
    -- Configs
    'Config.lua',
    'Config/*',
    'Testing/Config.lua',
    
    -- SQL
    'SQL/SQL.js',
    'Modules/SQL/Handler.lua',
    
    'Sparkling.lua',

    -- Utility
    'Utility/Error.lua',
    
    -- Extensions
    'Modules/Extensions/Handler.lua',
    'Modules/Extensions/EventObject.lua',
    'Modules/Extensions/New.lua',

    -- PlayerObject
    'Modules/Users/Objects/PlayerObject.lua',

    -- PlayerObject's objects?:
        'Modules/Users/Objects/*',
        'Modules/Users/Handler.lua',
        'Modules/Users/Utility.lua',

    -- Testing
    'Testing/PlayerObject.lua',

    -- Updater
    'Updater.lua',

    'Modules/Menu.lua'
}

client_scripts {
    "Client/Spawned.lua",
    'Client/UI/Prompt.lua',
    'Client/UI/Menu.lua',
    'Client/UI/Main.lua',
    'Client/UI/Notify.lua'
}