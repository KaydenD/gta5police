server_scripts {
	'server.lua',
	'@mysql-async/lib/MySQL.lua'
}
client_script {
	'GUI.lua',
	'client/vdkinv.lua',
	'client/anims.lua',
}

export 'getQuantity'
export 'notFull'