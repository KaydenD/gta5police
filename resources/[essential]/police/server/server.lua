local couchFunctions = {}

if(db.driver == "couchdb") then
	TriggerEvent('es:exposeDBFunctions', function(dbExposed)
		couchFunctions = dbExposed
		dbExposed.createDatabase("police", function()end)
	end)
end

local inServiceCops = {}

function addCop(identifier)
	if(db.driver == "mysql-async") then
		MySQL.Async.fetchAll("SELECT * FROM police WHERE identifier = '"..identifier.."'", { ['@identifier'] = identifier}, function (result)
			if(result[1] == nil) then
				MySQL.Async.execute("INSERT INTO police (`identifier`) VALUES ('"..identifier.."')", { ['@identifier'] = identifier})
			end
		end)
	elseif(db.driver == "couchdb") then
		couchFunctions.getDocumentByRow("police", "identifier", identifier, function(document)
			if(document == false) then
				couchFunctions.createDocument("police", {
					identifier = identifier,
					rank = "Recruit"
				}, function()end)
			end
		end)
	end
end

function remCop(identifier)
	if(db.driver == "mysql-async") then
		MySQL.Async.execute("DELETE FROM police WHERE identifier = '"..identifier.."'", { ['@identifier'] = identifier})
	elseif(db.driver == "couchdb") then
		couchFunctions.getDocumentByRow("police", "identifier", identifier, function(document)
			if(document ~= false) then
				couchFunctions.updateDocument("police", document._id, {
					identifier = document.identifier .. "/"
				}, function()end)
			end
		end)
	end
end

function checkIsCop(identifier)
	if(db.driver == "mysql-async") then
		MySQL.Async.fetchAll("SELECT * FROM police WHERE identifier = '"..identifier.."'", { ['@identifier'] = identifier}, function (result)
			if(result[1] == nil) then
				print("bad cop")
				TriggerClientEvent('police:receiveIsCop', source, "unknown")
			else
				print("good cop")
				TriggerClientEvent('police:receiveIsCop', source, result[1].rank)
			end
		end)
	elseif(db.driver == "couchdb") then
		couchFunctions.getDocumentByRow("police", "identifier", identifier, function(document)
			if(document == false) then
				TriggerClientEvent('police:receiveIsCop', source, "unknown")
			else
				TriggerClientEvent('police:receiveIsCop', source, document.rank)
			end
		end)
	end
end

AddEventHandler('playerDropped', function()
	if(inServiceCops[source]) then
		inServiceCops[source] = nil
		
		if(config.useJobSystem == true) then
			TriggerEvent("jobssystem:disconnectReset", source, config.job.officer_not_on_duty_job_id)
		end
		
		for i, c in pairs(inServiceCops) do
			TriggerClientEvent("police:resultAllCopsInService", i, inServiceCops)
		end
	end
end)

if(config.useCopWhitelist == true) then
	--RegisterServerEvent('police:checkIsCop')
	AddEventHandler('es:playerLoaded', function(source)
	local source7 = source
		TriggerEvent('es:getPlayerFromId', source, function(user)
			local identifier = user.getIdentifier()
			MySQL.Async.fetchAll("SELECT * FROM police WHERE identifier = '"..identifier.."'", { ['@identifier'] = identifier}, function (result)
				if(result[1] == nil) then
					print("bad cop")
					TriggerClientEvent('police:receiveIsCop', source, "unknown")
				else
					print("good cop")
				
     				user.receiveIsCop(result)
					--TriggerClientEvent('police:receiveIsCop', source, result[1].rank)
				end
			end)
			MySQL.Async.fetchAll("SELECT timeleft FROM jailedPlayers WHERE identifier = @identifier", { ['@identifier'] = identifier}, function (result)
				if(result[1]) then
					print("jail")
					TriggerClientEvent('jail:teleportPlayer', source7, tonumber(result[1].timeleft), false, true)
				end
			end)
		end)
	end)
end

RegisterServerEvent('explodePlayerTyre')
AddEventHandler('explodePlayerTyre', function(plate)
	TriggerClientEvent("explodePlayerTyreClient", -1, plate)
end)

RegisterServerEvent('police:takeService')
AddEventHandler('police:takeService', function()

	if(not inServiceCops[source]) then
		inServiceCops[source] = GetPlayerName(source)
		
		for i, c in pairs(inServiceCops) do
			TriggerClientEvent("police:resultAllCopsInService", i, inServiceCops)
		end
	end
end)

RegisterServerEvent('police:breakService')
AddEventHandler('police:breakService', function()

	if(inServiceCops[source]) then
		inServiceCops[source] = nil
		
		for i, c in pairs(inServiceCops) do
			TriggerClientEvent("police:resultAllCopsInService", i, inServiceCops)
		end
	end
end)

AddEventHandler('chatMessage', function(source, name, msg)
	if(inServiceCops[source]) then
		sm = stringsplit(msg, " ");
		if sm[1] == "/lockbc" or sm[1] == "/Lockbc" or sm[1] == "/LOCKBC" then
			CancelEvent()
			local plate = string.upper(sm[2])
			TriggerClientEvent("simp:baitCarDisable", -1 , plate)
		end
	end
end)

AddEventHandler('chatMessage', function(source, name, msg)
	if(inServiceCops[source]) then
		sm = stringsplit(msg, " ");
		if sm[1] == "/unlockbc" or sm[1] == "/Unlockbc" or sm[1] == "/UNLOCKBC" then
			CancelEvent()
			local plate = string.upper(sm[2])
			TriggerClientEvent("simp:baitCarunlock", -1 , plate)
		end
	end
end)

-----------------------------------------------
-- StringSplit Function, Just Ignore this. --
-----------------------------------------------
function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end

RegisterServerEvent('police:getAllCopsInService')
AddEventHandler('police:getAllCopsInService', function()
	TriggerClientEvent("police:resultAllCopsInService", source, inServiceCops)
end)

RegisterServerEvent('police:removeWeapons')
AddEventHandler('police:removeWeapons', function(target)
	local identifier = getPlayerID(target)
	if(db.driver == "mysql-async") then
		MySQL.Sync.execute("DELETE FROM user_weapons WHERE identifier='"..identifier.."'",{['@user']= identifier})
	end
	TriggerClientEvent("police:removeWeapons", target)
end)

RegisterServerEvent('police:removeWeapons1')
AddEventHandler('police:removeWeapons1', function()
	local source8 = source
	local identifier = getPlayerID(source)
	print(identifier)
	if(db.driver == "mysql-async") then
		MySQL.Sync.execute("DELETE FROM user_weapons WHERE identifier=@user",{['@user']= identifier})
	end
	TriggerClientEvent("police:removeWeapons", source8)
end)

RegisterServerEvent('InsertJailDBTime')
AddEventHandler('InsertJailDBTime', function(time)
	local source8 = source
	local identifier = getPlayerID(source)
	print(identifier)
	if(db.driver == "mysql-async") then
		MySQL.Async.execute("INSERT INTO jailedPlayers (identifier, timeleft) VALUES (@user, @time)",{['@user']= identifier, ['@time'] = time}, function() end)
		MySQL.Async.execute("UPDATE users SET Weplicenselvl = 0 WHERE identifier = @user",{['@user']= identifier}, function() end)
		MySQL.Async.execute("INSERT INTO jail_history (id, charName, jailTime) VALUES (@user, @name ,@time)",{['@user']= identifier, ['@name']= GetPlayerName(source8), ['@time'] = time}, function() end)
	end
end)

RegisterServerEvent('UpdateJailDBTime')
AddEventHandler('UpdateJailDBTime', function(time)
	local source8 = source
	local identifier = getPlayerID(source)
	--print(identifier)
	MySQL.Async.execute('UPDATE jailedPlayers SET timeleft=@time WHERE identifier=@user', {['@user']= identifier, ['@time'] = time}, function(rowsChanged)
    --print(rowsChanged)
	end)
end)

RegisterServerEvent('DeleteJailDB')
AddEventHandler('DeleteJailDB', function()
	local source8 = source
	local identifier = getPlayerID(source)
	--print(identifier)
	if(db.driver == "mysql-async") then
		MySQL.Sync.execute("DELETE FROM jailedPlayers WHERE identifier=@user",{['@user']= identifier})
	end
	--TriggerClientEvent("police:removeWeapons", source8)
end)
--[[
RegisterServerEvent('JailTelFormDB')
AddEventHandler('JailTelFormDB', function()
	local source8 = source
	local identifier = getPlayerID(source)
	TriggerClientEvent('jail:teleportPlayer', t, amount, source, false)

end)
]]

RegisterServerEvent('police:checkingPlate')
AddEventHandler('police:checkingPlate', function(plate)
	local source1 = source
	if(db.driver == "mysql-async") then
		MySQL.Async.fetchAll("SELECT playername FROM user_vehicle WHERE vehicle_plate = @plate", { ['@plate'] = plate }, function (result)
			if(result[1]) then
				for _, v in ipairs(result) do
					TriggerClientEvent("police:notify", source1, "CHAR_ANDREAS", 1, txt[config.lang]["title_notification"], false, txt[config.lang]["vehicle_checking_plate_part_1"]..plate..txt[config.lang]["vehicle_checking_plate_part_2"] .. v.playername..txt[config.lang]["vehicle_checking_plate_part_3"])
				end
			else
				TriggerClientEvent("police:notify", source1, "CHAR_ANDREAS", 1, txt[config.lang]["title_notification"], false, txt[config.lang]["vehicle_checking_plate_part_1"]..plate..txt[config.lang]["vehicle_checking_plate_not_registered"])
			end
		end)
	end
end)

RegisterServerEvent('police:removeIllegalVeh')
AddEventHandler('police:removeIllegalVeh', function(plate)
	local source1 = source
	if(db.driver == "mysql-async") then
		MySQL.Async.execute("DELETE `vehicle_inventory` FROM `vehicle_inventory` LEFT JOIN `items` ON `vehicle_inventory`.`item` = `items`.`id` WHERE `plate` = @plate AND isIllegal = 1", { ['@plate'] = plate }, function (result)
			print(result)
			if(tonumber(result) > 0) then
				TriggerClientEvent("police:notify", source1, "CHAR_ANDREAS", 1, txt[config.lang]["title_notification"], false, tostring(result) .. " Items Removed")
				TriggerEvent('car:getCarsFromDb')
				print("Triggered getCarsFromDb")
			else
				TriggerClientEvent("police:notify", source1, "CHAR_ANDREAS", 1, txt[config.lang]["title_notification"], false, "No Illegal Items found")
			end
		end)
	end
end)

RegisterServerEvent('police:confirmUnseat')
AddEventHandler('police:confirmUnseat', function(t)
	TriggerClientEvent("police:notify", source, "CHAR_ANDREAS", 1, txt[config.lang]["title_notification"], false, txt[config.lang]["unseat_sender_notification_part_1"] .. GetPlayerName(t) .. txt[config.lang]["unseat_sender_notification_part_2"])
	TriggerClientEvent('police:unseatme', t)
end)

RegisterServerEvent('police:dragRequest')
AddEventHandler('police:dragRequest', function(t)
	TriggerClientEvent("police:notify", source, "CHAR_ANDREAS", 1, txt[config.lang]["title_notification"], false, txt[config.lang]["drag_sender_notification_part_1"] .. GetPlayerName(t) .. txt[config.lang]["drag_sender_notification_part_2"])
	TriggerClientEvent('police:toggleDrag', t, source)
end)

RegisterServerEvent('police:targetCheckInventory')
AddEventHandler('police:targetCheckInventory', function(target)

TriggerEvent('es:getPlayerFromId', source, function(user)
     -- The user object is either nil or the loaded user.


	local identifier = getPlayerID(target)
	print(identifier)
	if(config.useVDKInventory == true) then
		if(db.driver == "mysql-async") then
			MySQL.Async.fetchAll("SELECT * FROM `user_inventory` JOIN items ON items.id = user_inventory.item_id WHERE user_id = '"..identifier.."'", { ['@username'] = identifier }, function (result)
				local strResult = txt[config.lang]["checking_inventory_part_1"] .. GetPlayerName(target) .. txt[config.lang]["checking_inventory_part_2"]
				
				for _, v in ipairs(result) do
					if(v.quantity ~= 0) then
						strResult = strResult .. v.quantity .. "*" .. v.libelle .. ", "
					end
					
					if(v.isIllegal == "1" or v.isIllegal == "True" or v.isIllegal == 1 or v.isIllegal == true) then
						--TriggerClientEvent('police:dropIllegalItem', target, v.item_id)
					end
				end
				--print(strResult)
				--TriggerClientEvent("police:notify", source, "CHAR_ANDREAS", 1, txt[config.lang]["title_notification"], false, strResult)
				user.notify(strResult)
			end)
		end
	end
	
	if(config.useWeashop == true) then
	
		if(db.driver == "mysql-async") then
			MySQL.Async.fetchAll("SELECT * FROM user_weapons WHERE identifier = '"..identifier.."'", { ['@username'] = identifier }, function (result)
				local strResult = txt[config.lang]["checking_weapons_part_1"] .. GetPlayerName(target) .. txt[config.lang]["checking_weapons_part_2"]
				
				for _, v in ipairs(result) do
					strResult = strResult .. v.weapon_model .. ", "
				end
				
				--TriggerClientEvent("police:notify", source, "CHAR_ANDREAS", 1, txt[config.lang]["title_notification"], false, strResult)
				user.notify(strResult)
			end)
		end
	end	
	end)
end)

RegisterServerEvent('police:targetRemoveIllegal')

AddEventHandler('police:targetRemoveIllegal', function(target)

TriggerEvent('es:getPlayerFromId', source, function(user)
     -- The user object is either nil or the loaded user.


	local identifier = getPlayerID(target)
	print(identifier)
	if(config.useVDKInventory == true) then
		if(db.driver == "mysql-async") then
			MySQL.Async.fetchAll("SELECT * FROM `user_inventory` JOIN items ON items.id = user_inventory.item_id WHERE user_id = '"..identifier.."'", { ['@username'] = identifier }, function (result)
				local strResult = "Removed from player : " .. GetPlayerName(target) .. " Items : "

				for _, v in ipairs(result) do
					if(v.quantity ~= 0) then
						--strResult = strResult .. v.quantity .. "*" .. v.libelle .. ", "
					end
					
					if((v.isIllegal == "1" or v.isIllegal == "True" or v.isIllegal == 1 or v.isIllegal == true) and v.quantity ~= 0) then
						TriggerClientEvent('police:dropIllegalItem', target, v.item_id)
						strResult = strResult .. v.quantity .. "*" .. v.libelle .. ", "
					end
				end
				--print(strResult)
				--TriggerClientEvent("police:notify", source, "CHAR_ANDREAS", 1, txt[config.lang]["title_notification"], false, strResult)
				user.notify(strResult)
			end)
		end
	end
	end)
end)


RegisterServerEvent('police:finesGranted')
AddEventHandler('police:finesGranted', function(target, amount)
	TriggerClientEvent('police:payFines', target, amount, source)
	TriggerClientEvent("police:notify", source, "CHAR_ANDREAS", 1, txt[config.lang]["title_notification"], false, txt[config.lang]["send_fine_request_part_1"]..amount..txt[config.lang]["send_fine_request_part_2"]..GetPlayerName(target))
end)

RegisterServerEvent('jail:teleportToJail')
AddEventHandler('jail:teleportToJail', function(t, amount)
	TriggerClientEvent('jail:teleportPlayer', t, amount, source, false)
end)

RegisterServerEvent('NotifyCop')
AddEventHandler('NotifyCop', function(cop)
	TriggerEvent('es:getPlayerFromId', tonumber(cop), function(user)
     	user.notify("You have to handcuff them first")
	end)
end)

RegisterServerEvent('arrestNotify')
AddEventHandler('arrestNotify', function(time)
	TriggerEvent('es:getPlayerFromId', source, function(user)
     	user.notify("You have " .. tostring(time) .. " seconds left")
	end)
end)



RegisterServerEvent('police:finesETA')
AddEventHandler('police:finesETA', function(officer, code)
	if(code==1) then
		TriggerClientEvent("police:notify", officer, "CHAR_ANDREAS", 1, txt[config.lang]["title_notification"], false, GetPlayerName(source)..txt[config.lang]["already_have_a_pendind_fine_request"])
	elseif(code==2) then
		TriggerClientEvent("police:notify", officer, "CHAR_ANDREAS", 1, txt[config.lang]["title_notification"], false, GetPlayerName(source)..txt[config.lang]["request_fine_timeout"])
	elseif(code==3) then
		TriggerClientEvent("police:notify", officer, "CHAR_ANDREAS", 1, txt[config.lang]["title_notification"], false, GetPlayerName(source)..txt[config.lang]["request_fine_refused"])
	elseif(code==0) then
		TriggerClientEvent("police:notify", officer, "CHAR_ANDREAS", 1, txt[config.lang]["title_notification"], false, GetPlayerName(source)..txt[config.lang]["request_fine_accepted"])
	end
end)

RegisterServerEvent('police:cuffGranted')
AddEventHandler('police:cuffGranted', function(t)
	TriggerClientEvent("police:notify", source, "CHAR_ANDREAS", 1, txt[config.lang]["title_notification"], false, txt[config.lang]["toggle_cuff_player_part_1"]..GetPlayerName(t)..txt[config.lang]["toggle_cuff_player_part_2"])
	TriggerClientEvent('police:getArrested', t)
end)

RegisterServerEvent('police:forceEnterAsk')
AddEventHandler('police:forceEnterAsk', function(t, v)
	TriggerClientEvent("police:notify", source, "CHAR_ANDREAS", 1, txt[config.lang]["title_notification"], false, txt[config.lang]["force_player_get_in_vehicle_part_1"]..GetPlayerName(t)..txt[config.lang]["force_player_get_in_vehicle_part_2"])
	TriggerClientEvent('police:forcedEnteringVeh', t, v)
end)

RegisterServerEvent('CheckPoliceVeh')
AddEventHandler('CheckPoliceVeh', function(vehicle)
	TriggerClientEvent('FinishPoliceCheckForVeh',source)
	TriggerClientEvent('policeveh:spawnVehicle', source, vehicle)
end)



if(config.useCopWhitelist) then

	TriggerEvent('es:addGroupCommand', 'copadd', "admin", function(source, args, user)
		 if(not args[2]) then
			TriggerClientEvent('chatMessage', source, txt[config.lang]["title_notification"], {255, 0, 0}, txt[config.lang]["usage_command_copadd"])	
		else
			if(GetPlayerName(tonumber(args[2])) ~= nil)then
				local player = tonumber(args[2])
				addCop(getPlayerID(player))
				TriggerClientEvent('chatMessage', source, txt[config.lang]["title_notification"], {255, 0, 0}, txt[config.lang]["command_received"])
				TriggerClientEvent("police:notify", player, "CHAR_ANDREAS", 1, txt[config.lang]["title_notification"], false, txt[config.lang]["become_cop_success"])
				TriggerClientEvent('police:nowCop', player)
			else
				TriggerClientEvent('chatMessage', source, txt[config.lang]["title_notification"], {255, 0, 0}, txt[config.lang]["no_player_with_this_id"])
			end
		end
	end, function(source, args, user) 
		TriggerClientEvent('chatMessage', source, txt[config.lang]["title_notification"], {255, 0, 0}, txt[config.lang]["not_enough_permission"])
	end)

	TriggerEvent('es:addGroupCommand', 'coprem', "admin", function(source, args, user) 
		 if(not args[2]) then
			print("nein")
			TriggerClientEvent('chatMessage', source, txt[config.lang]["title_notification"], {255, 0, 0}, txt[config.lang]["usage_command_coprem"])	
		else
			if(GetPlayerName(tonumber(args[2])) ~= nil)then
				local player = tonumber(args[2])
				remCop(getPlayerID(player))
				TriggerClientEvent("police:notify", player, "CHAR_ANDREAS", 1, txt[config.lang]["title_notification"], false, txt[config.lang]["remove_from_cops"])
				TriggerClientEvent('chatMessage', source, txt[config.lang]["title_notification"], {255, 0, 0}, txt[config.lang]["command_received"])
				TriggerClientEvent('police:noLongerCop', player)
			else
				TriggerClientEvent('chatMessage', source, txt[config.lang]["title_notification"], {255, 0, 0}, txt[config.lang]["no_player_with_this_id"])
			end
		end
	end, function(source, args, user) 
		TriggerClientEvent('chatMessage', source, txt[config.lang]["title_notification"], {255, 0, 0}, txt[config.lang]["not_enough_permission"])
	end)
	
end

function getPlayerID(source)
    local identifiers = GetPlayerIdentifiers(source)
    local player = getIdentifiant(identifiers)
    return player
end

function getIdentifiant(id)
    for _, v in ipairs(id) do
        return v
    end
end