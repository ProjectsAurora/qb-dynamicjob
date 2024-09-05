fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'Mobius'
description 'QBcore Shop Script using qb-target and OpenStore'
version '1.0.1'

-- Client scripts
client_scripts {
    'config.lua',
    'client.lua'
}

-- Server scripts
server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua',
    'config.lua'
}

-- Dependencies
dependencies {
    'qb-core'
}

shared_scripts {
	'config.lua'
}
