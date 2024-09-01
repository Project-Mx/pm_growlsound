fx_version 'cerulean'
game 'gta5'
lua54 'yes'
files {
    'html/ui.html',
    'html/sounds/stomach_growl.ogg'
}

ui_page 'html/ui.html'

client_scripts {
    'config.lua',
    'client/hunger_thirst_alert.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server.lua'
}


escrow_ignore {
    'config.lua'
  }