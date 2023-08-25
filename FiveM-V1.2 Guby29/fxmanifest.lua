-- Resource Metadata
fx_version 'cerulean'
games { 'gta5' }

author 'Guby29'
description 'Premier Script'
version '1.0.0'

-- What to run
client_scripts {
    'client.lua',
    'client_two.lua',


    "src/client/RMenu.lua",
    "src/client/menu/RageUI.lua",
    "src/client/menu/Menu.lua",
    "src/client/menu/MenuController.lua",
    "src/client/components/*.lua",
    "src/client/menu/elements/*.lua",
    "src/client/menu/items/*.lua",
    "src/client/menu/panels/*.lua",
    "src/client/menu/windows/*.lua"
}

server_script 'server.lua'
