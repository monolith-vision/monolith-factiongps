fx_version "cerulean"
game "gta5"
lua54 "yes"

shared_scripts {
  "@es_extended/imports.lua",
  "lib/*.lua",
  "config.lua"
}

client_scripts {
  "client/classes/*.lua",
  "client/main.lua"
}

server_scripts {
  "server/main.lua"
}