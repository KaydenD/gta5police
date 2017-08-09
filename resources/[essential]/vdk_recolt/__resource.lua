dependency 'vdk_inventory'

server_scripts {
	'server.lua',
	'@mysql-async/lib/MySQL.lua'
}

client_script {
	'vdkrec.lua'
}