

client_script 'client.lua'


server_script 'server.lua'

--Import mysql-async resource (remove "--" before "server_script" if you want to use mysql-async)
server_script '@mysql-async/lib/MySQL.lua'