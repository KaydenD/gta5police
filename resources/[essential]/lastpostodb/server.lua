--Version 1.5

--Déclaration des EventHandler
RegisterServerEvent("projectEZ:savelastpos")
RegisterServerEvent("projectEZ:SpawnPlayer")

--Intégration de la position dans MySQL
AddEventHandler("projectEZ:savelastpos", function( LastPosX , LastPosY , LastPosZ , LastPosH )
	local source1 = source
	TriggerEvent('es:getPlayerFromId', source1, function(user)
		--Récupération du SteamID.
		local player = user.getIdentifier()
		--Formatage des données en JSON pour intégration dans MySQL.
		local LastPos = "{" .. LastPosX .. ", " .. LastPosY .. ",  " .. LastPosZ .. ", " .. LastPosH .. "}"
		--Exécution de la requêtes SQL.
		MySQL.Async.execute("UPDATE users SET `lastpos`=@lastpos WHERE identifier = @username", {['@username'] = player, ['@lastpos'] = LastPos})
	end)
end)

AddEventHandler("projectEZ:SpawnPlayer", function()
	local source2 = source
	TriggerEvent('es:getPlayerFromId', source2, function(user)
		--Récupération du SteamID.
		local player = user.getIdentifier()
		--Récupération des données générée par la requête.
		local result = MySQL.Sync.fetchScalar("SELECT lastpos FROM users WHERE identifier = @username", {['@username'] = player})	
		-- Vérification de la présence d'un résultat avant de lancer le traitement.
		if(result ~= nil)then
				-- Décodage des données récupérées
				local ToSpawnPos = json.decode(result)
				print(ToSpawnPos[1])
				-- On envoie la derniere position vers le client pour le spawn
				TriggerClientEvent("projectEZ:spawnlaspos", source2, ToSpawnPos[1], ToSpawnPos[2], ToSpawnPos[3])
		end
	end)
end)

-- Sauvegarde de la position lors de la deconnexion
AddEventHandler('es:playerDropped', function(user)
		--Récupération du SteamID.
		print("test save to db dropped")
		local player = user.getIdentifier()
		--Formatage des données en JSON pour intégration dans MySQL.
		local userCoords = user.getCoords()
		local LastPos = "{" .. userCoords.x .. ", " .. userCoords.y .. ",  " .. userCoords.z .. ", " .. "0" .. "}"
		--Exécution de la requêtes SQL.
		MySQL.Async.execute("UPDATE users SET `lastpos`=@lastpos WHERE identifier = @username", {['@username'] = player, ['@lastpos'] = LastPos})
end)