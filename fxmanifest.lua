fx_version 'adamant'
game 'gta5'

author 'Stane'

lua54 'yes'

client_scripts { 
    'settings.lua',
    'utils-cl.lua',
    'client.lua'
}

server_scripts { 
    'settings.lua',
    'utils-sv.lua',
    'server.lua'
}

ui_page "web/index.html"

files {
    "web/index.html",
    'web/script.js',
    'web/style.css',
    'web/image/*.png'
}