fx_version "cerulean"
game "gta5"
lua54 "yes"

name "melons_cooldown"
description "Cooldown system for robberies"
author "IlMelons"
version "1.0.0"
repository "https://github.com/IlMelons/melons_cooldown"

server_only "yes"

server_scripts {
    "@ox_lib/init.lua",
    "checker.lua",
    "config/server.lua",
    "server/server.lua",
}