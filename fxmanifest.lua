fx_version "cerulean"
game "gta5"
lua54 "yes"

shared_scripts {
  "lib/*.lua",
  "config.lua"
}

client_scripts {
  "client/classes/*.lua",
  "client/main.lua"
}

server_scripts {
  "bridge/server/*.lua",
  "server/main.lua"
}