fx_version 'cerulean'
game 'gta5'

author 'Fr3ckzDK <github.com/dkfrede>'
description 'A FiveM framework named Sparkling'
version '1.0'

server_export 'Spark'

server_scripts {
    'Sparkling.lua',
    'Utility/Error.lua',
    
    -- Extensions
    'Modules/Extensions/Extensions.lua',
    'Modules/Extensions/EventObject.lua',
    'Modules/Extensions/New.lua',

    'Modules/Users.lua',
    'Modules/Events.lua',
    'Testing.lua'
}