--[[Info]]--




--[[Register]]--


RegisterServerEvent('ply_garages2:SetVehInGarage')
RegisterServerEvent('ply_garages2:UpdateVeh')
RegisterServerEvent('ply_garages2:SetVehOut')
RegisterServerEvent('ply_garages2:SellVehicle')
RegisterServerEvent("ply_basemod:getPlayerVehicle")
RegisterServerEvent("doesOwnLockedCar")



--[[Function]]--

function getPlayerID(source)
  return getIdentifiant(GetPlayerIdentifiers(source))
end

function getIdentifiant(id)
  for _, v in ipairs(id) do
    return v
  end
end

function checkIfThereIsAnyVehicleInTheGarage(id)
	return MySQL.Sync.fetchScalar("SELECT garage_id FROM user_vehicle WHERE identifier=@identifier AND garage_id=@id",	{['@id'] = id, ['@identifier'] = getPlayerID(source)})
end

function addGarageToPlayer(id)
	MySQL.Async.execute("INSERT INTO user_garage (identifier,garage_id) VALUES (@identifier,@garage_id)", {['@identifier'] = getPlayerID(source), ['@garage_id'] = id}, function(data)
	end)
end

function updateSateOfGarate(id,state)
	MySQL.Async.execute("UPDATE garages SET available=@state WHERE id=@id", {['@state'] = state, ['@id'] = id}, function(data)
	end)
end

function deleteGarageFromPlayer(id)
	MySQL.Async.execute("DELETE from user_garage WHERE garage_id=@garage_id", {['@garage_id'] = id}, function(data)
	end)
end

function updateSateOfPlayerVehicle(plate,state,instance,source)
	local vehicles = {}
	MySQL.Async.execute("UPDATE user_vehicle SET vehicle_state=@state, instance=@instance WHERE vehicle_plate=@plate", {['@instance'] = instance, ['@state'] = state, ['@plate'] = plate}, function(data)
	MySQL.Async.fetchAll("SELECT * FROM user_vehicle WHERE identifier=@identifier",{['@identifier'] = getPlayerID(source)}, function(data1)
		for _, v in ipairs(data1) do
			t = {
			["id"] = v.id,
			["identifier"] = v.identifier,
			["garage_id"] = v.garage_id,
			["vehicle_name"] = v.vehicle_name,
			["vehicle_model"] = v.vehicle_model,
			["vehicle_price"] = v.vehicle_price,
			["vehicle_plate"] = v.vehicle_plate,
			["vehicle_state"] = v.vehicle_state,
			["vehicle_primarycolor"] = v.vehicle_colorprimary,
			["vehicle_secondarycolor"] = v.vehicle_colorsecondary,
			["vehicle_pearlescentcolor"] = v.vehicle_pearlescentcolor,
			["vehicle_wheelcolor"] = v.vehicle_wheelcolor,
			["vehicle_neoncolor1"] = v.vehicle_neoncolor1,
			["vehicle_neoncolor2"] = v.vehicle_neoncolor2,
			["vehicle_neoncolor3"] = v.vehicle_neoncolor3,
			["vehicle_windowtint"] = v.vehicle_windowtint,
			["vehicle_wheeltype"] = v.vehicle_wheeltype,
			["vehicle_mods0"] = v.vehicle_mods0,
			["vehicle_mods1"] = v.vehicle_mods1,
			["vehicle_mods2"] = v.vehicle_mods2,
			["vehicle_mods3"] = v.vehicle_mods3,
			["vehicle_mods4"] = v.vehicle_mods4,
			["vehicle_mods5"] = v.vehicle_mods5,
			["vehicle_mods6"] = v.vehicle_mods6,
			["vehicle_mods7"] = v.vehicle_mods7,
			["vehicle_mods8"] = v.vehicle_mods8,
			["vehicle_mods9"] = v.vehicle_mods9,
			["vehicle_mods10"] = v.vehicle_mods10,
			["vehicle_mods11"] = v.vehicle_mods11,
			["vehicle_mods12"] = v.vehicle_mods12,
			["vehicle_mods13"] = v.vehicle_mods13,
			["vehicle_mods14"] = v.vehicle_mods14,
			["vehicle_mods15"] = v.vehicle_mods15,
			["vehicle_mods16"] = v.vehicle_mods16,
			["vehicle_turbo"] = v.vehicle_turbo,
			["vehicle_tiresmoke"] = v.vehicle_tiresmoke,
			["vehicle_xenon"] = v.vehicle_xenon,
			["vehicle_mods23"] = v.vehicle_mods23,
			["vehicle_mods24"] = v.vehicle_mods24,
			["vehicle_neon0"] = v.vehicle_neon0,
			["vehicle_neon1"] = v.vehicle_neon1,
			["vehicle_neon2"] = v.vehicle_neon2,
			["vehicle_neon3"] = v.vehicle_neon3,
			["vehicle_bulletproof"] = v.vehicle_bulletproof,
			["vehicle_smokecolor1"] = v.vehicle_smokecolor1,
			["vehicle_smokecolor2"] = v.vehicle_smokecolor2,
			["vehicle_smokecolor3"] = v.vehicle_smokecolor3,
			["vehicle_modvariation"] = v.vehicle_modvariation,
			["insurance"] = v.insurance,
			["instance"] = v.instance
		}

			table.insert(vehicles, t)
		end
		TriggerClientEvent("ply_garages2:getVehicles", source, vehicles)
	end)
	end)
end

function checkIFPlayerHasAlreadyBoughtThisGarage(id)
	return MySQL.Sync.fetchScalar("SELECT garage_id FROM user_garage WHERE identifier=@identifier AND garage_id=@id", {['@id'] = id, ['@identifier'] = getPlayerID(source)})
end

function sellVehicle(plate, id, source)
	MySQL.Async.execute("DELETE from user_vehicle WHERE identifier=@identifier AND vehicle_plate=@plate", {['@identifier'] = id, ['@plate'] = plate}, function(data)
	local vehicles = {}
	print("delete")
	MySQL.Async.fetchAll("SELECT * FROM user_vehicle WHERE identifier=@identifier",{['@identifier'] = id}, function(data1)
		for _, v in ipairs(data1) do
			t = {
			["id"] = v.id,
			["identifier"] = v.identifier,
			["garage_id"] = v.garage_id,
			["vehicle_name"] = v.vehicle_name,
			["vehicle_model"] = v.vehicle_model,
			["vehicle_price"] = v.vehicle_price,
			["vehicle_plate"] = v.vehicle_plate,
			["vehicle_state"] = v.vehicle_state,
			["vehicle_primarycolor"] = v.vehicle_colorprimary,
			["vehicle_secondarycolor"] = v.vehicle_colorsecondary,
			["vehicle_pearlescentcolor"] = v.vehicle_pearlescentcolor,
			["vehicle_wheelcolor"] = v.vehicle_wheelcolor,
			["vehicle_neoncolor1"] = v.vehicle_neoncolor1,
			["vehicle_neoncolor2"] = v.vehicle_neoncolor2,
			["vehicle_neoncolor3"] = v.vehicle_neoncolor3,
			["vehicle_windowtint"] = v.vehicle_windowtint,
			["vehicle_wheeltype"] = v.vehicle_wheeltype,
			["vehicle_mods0"] = v.vehicle_mods0,
			["vehicle_mods1"] = v.vehicle_mods1,
			["vehicle_mods2"] = v.vehicle_mods2,
			["vehicle_mods3"] = v.vehicle_mods3,
			["vehicle_mods4"] = v.vehicle_mods4,
			["vehicle_mods5"] = v.vehicle_mods5,
			["vehicle_mods6"] = v.vehicle_mods6,
			["vehicle_mods7"] = v.vehicle_mods7,
			["vehicle_mods8"] = v.vehicle_mods8,
			["vehicle_mods9"] = v.vehicle_mods9,
			["vehicle_mods10"] = v.vehicle_mods10,
			["vehicle_mods11"] = v.vehicle_mods11,
			["vehicle_mods12"] = v.vehicle_mods12,
			["vehicle_mods13"] = v.vehicle_mods13,
			["vehicle_mods14"] = v.vehicle_mods14,
			["vehicle_mods15"] = v.vehicle_mods15,
			["vehicle_mods16"] = v.vehicle_mods16,
			["vehicle_turbo"] = v.vehicle_turbo,
			["vehicle_tiresmoke"] = v.vehicle_tiresmoke,
			["vehicle_xenon"] = v.vehicle_xenon,
			["vehicle_mods23"] = v.vehicle_mods23,
			["vehicle_mods24"] = v.vehicle_mods24,
			["vehicle_neon0"] = v.vehicle_neon0,
			["vehicle_neon1"] = v.vehicle_neon1,
			["vehicle_neon2"] = v.vehicle_neon2,
			["vehicle_neon3"] = v.vehicle_neon3,
			["vehicle_bulletproof"] = v.vehicle_bulletproof,
			["vehicle_smokecolor1"] = v.vehicle_smokecolor1,
			["vehicle_smokecolor2"] = v.vehicle_smokecolor2,
			["vehicle_smokecolor3"] = v.vehicle_smokecolor3,
			["vehicle_modvariation"] = v.vehicle_modvariation,
			["insurance"] = v.insurance,
			["instance"] = v.instance
		}

			table.insert(vehicles, t)
		end
		print(vehicles[1].id)
		TriggerClientEvent("ply_garages2:getVehicles", source, vehicles)
	end)
	end)
end

function vehiclePrice(plate, id)
	return MySQL.Sync.fetchScalar("SELECT vehicle_price FROM user_vehicle WHERE identifier=@identifier AND vehicle_plate=@plate",{['@identifier'] = id, ['@plate'] = plate})		
end

--[[Local/Global]]--



--[[Events]]--


AddEventHandler("doesOwnLockedCar", function(plate, vehicleHandle)
	local source4 = source
	TriggerEvent('es:getPlayerFromId', source4, function(user)
		local player = user.getIdentifier()
		MySQL.Async.fetchScalar("SELECT vehicle_model FROM user_vehicle WHERE vehicle_plate=@plate AND identifier=@id", {['@plate'] = plate, ['@id'] = player}, function(data)
			if(data) then
				print(data)
				TriggerClientEvent("doesOwnLockedCarReturn", source4, plate, vehicleHandle)
			else
				user.notify("You don't own this car")
			end
		end)
	end)
end)

AddEventHandler("ply_garages2:SetVehInGarage", function(plate)
	local state = "In"
	local instance = 0
	updateSateOfPlayerVehicle(plate,state,instance,source)
end)

AddEventHandler("ply_garages2:SetVehOut", function(plate,instance)
	local state = "Out"
	local garage_id = 1
	updateSateOfPlayerVehicle(plate,state,instance,source)
end)

AddEventHandler('ply_garages2:UpdateVeh', function(plate, plateindex, primarycolor, secondarycolor, pearlescentcolor, wheelcolor, neoncolor1, neoncolor2, neoncolor3, windowtint, wheeltype, mods0, mods1, mods2, mods3, mods4, mods5, mods6, mods7, mods8, mods9, mods10, mods11, mods12, mods13, mods14, mods15, mods16, turbo, tiresmoke, xenon, mods23, mods24, neon0, neon1, neon2, neon3, bulletproof, smokecolor1, smokecolor2, smokecolor3, variation)
	MySQL.Async.execute("UPDATE user_vehicle SET vehicle_plateindex=@plateindex, vehicle_colorprimary=@primarycolor, vehicle_colorsecondary=@secondarycolor, vehicle_pearlescentcolor=@pearlescentcolor, vehicle_wheelcolor=@wheelcolor, vehicle_neoncolor1=@neoncolor1, vehicle_neoncolor2=@neoncolor2, vehicle_neoncolor3=@neoncolor3, vehicle_windowtint=@windowtint, vehicle_wheeltype=@wheeltype, vehicle_mods0=@mods0, vehicle_mods1=@mods1, vehicle_mods2=@mods2, vehicle_mods3=@mods3, vehicle_mods4=@mods4, vehicle_mods5=@mods5, vehicle_mods6=@mods6, vehicle_mods7=@mods7, vehicle_mods8=@mods8, vehicle_mods9=@mods9, vehicle_mods10=@mods10, vehicle_mods11=@mods11, vehicle_mods12=@mods12, vehicle_mods13=@mods13, vehicle_mods14=@mods14, vehicle_mods15=@mods15, vehicle_mods16=@mods16, vehicle_turbo=@turbo, vehicle_tiresmoke=@tiresmoke, vehicle_xenon=@xenon, vehicle_mods23=@mods23, vehicle_mods24=@mods24, vehicle_neon0=@neon0, vehicle_neon1=@neon1, vehicle_neon2=@neon2, vehicle_neon3=@neon3, vehicle_bulletproof=@bulletproof, vehicle_smokecolor1=@smokecolor1, vehicle_smokecolor2=@smokecolor2, vehicle_smokecolor3=@smokecolor3, vehicle_modvariation=@variation WHERE identifier=@identifier AND vehicle_plate=@plate",
		{['@identifier'] = getPlayerID(source), ['@plateindex'] = plateindex, ['@primarycolor'] = primarycolor, ['@secondarycolor'] = secondarycolor, ['@pearlescentcolor'] = pearlescentcolor, ['@wheelcolor'] = wheelcolor, ['@neoncolor1'] = neoncolor1 , ['@neoncolor2'] = neoncolor2, ['@neoncolor3'] = neoncolor3, ['@windowtint'] = windowtint, ['@wheeltype'] = wheeltype, ['@mods0'] = mods0, ['@mods1'] = mods1, ['@mods2'] = mods2, ['@mods3'] = mods3, ['@mods4'] = mods4, ['@mods5'] = mods5, ['@mods6'] = mods6, ['@mods7'] = mods7, ['@mods8'] = mods8, ['@mods9'] = mods9, ['@mods10'] = mods10, ['@mods11'] = mods11, ['@mods12'] = mods12, ['@mods13'] = mods13, ['@mods14'] = mods14, ['@mods15'] = mods15, ['@mods16'] = mods16, ['@turbo'] = turbo, ['@tiresmoke'] = tiresmoke, ['@xenon'] = xenon, ['@mods23'] = mods23, ['@mods24'] = mods24, ['@neon0'] = neon0, ['@neon1'] = neon1, ['@neon2'] = neon2, ['@neon3'] = neon3, ['@bulletproof'] = bulletproof, ['@plate'] = plate, ['@smokecolor1'] = smokecolor1, ['@smokecolor2'] = smokecolor2, ['@smokecolor3'] = smokecolor3, ['@variation'] = variation}, function(data)
	end)
end)

AddEventHandler("ply_garages2:SellVehicle", function(plate)
	local source3 = source
	TriggerEvent('es:getPlayerFromId', source, function(user)
		local player = user.getIdentifier()
		local price = vehiclePrice(plate, player)
		user.addMoney(price / 2)
		sellVehicle(plate, player, source3)
	end)
	
end)
--[[
AddEventHandler("ply_basemod:getGarages", function()
	garages = {}
	MySQL.Async.fetchAll("SELECT * FROM garages",{}, function(data)
		for _, v in ipairs(data) do
			t = { ["id"] = v.id, ["name"] = v.name, ["x"] = v.x, ["y"] = v.y, ["z"] = v.z, ["price"] = v.price, ["blip_colour"] = v.blip_colour, ["blip_id"] = v.blip_id, ["slot"] = v.slot, ["available"] = v.available}
			table.insert(garages, tonumber(v.id), t)
		end
		TriggerClientEvent("ply_garages2:setGarages", source, garages)
	end)
end)
]]
--player garages
--[[
AddEventHandler("ply_basemod:getPlayerGarage", function()
	playergarage = {}
	MySQL.Async.fetchAll("SELECT * FROM user_garage WHERE identifier=@identifier ",{['@identifier'] = getPlayerID(source)}, function(data)
		for _, v in ipairs(data) do
			t = { ["id"] = v.id, ["identifier"] = v.identifier, ["garage_id"] = v.garage_id}
			table.insert(playergarage, tonumber(v.id), t)
		end
		TriggerClientEvent("ply_garages2:setPlayerGarages", source, playergarage)
	end)
end)
]]
--player vehicle
AddEventHandler('es:playerLoaded', function(source)
	vehicles = {}
	print(getPlayerID(source))
	MySQL.Async.execute("UPDATE user_vehicle SET vehicle_state=@state, instance=@instance, playername=@playername WHERE identifier=@player", {['@instance'] = 0, ['@state'] = "In", ['@player'] = getPlayerID(source), ['@playername'] = GetPlayerName(source)}, function(data)
	MySQL.Async.fetchAll("SELECT * FROM user_vehicle WHERE identifier=@identifier",{['@identifier'] = getPlayerID(source)}, function(data)
		for _, v in ipairs(data) do
			t = {
			["id"] = v.id,
			["identifier"] = v.identifier,
			["garage_id"] = v.garage_id,
			["vehicle_name"] = v.vehicle_name,
			["vehicle_model"] = v.vehicle_model,
			["vehicle_price"] = v.vehicle_price,
			["vehicle_plate"] = v.vehicle_plate,
			["vehicle_state"] = v.vehicle_state,
			["vehicle_primarycolor"] = v.vehicle_colorprimary,
			["vehicle_secondarycolor"] = v.vehicle_colorsecondary,
			["vehicle_pearlescentcolor"] = v.vehicle_pearlescentcolor,
			["vehicle_wheelcolor"] = v.vehicle_wheelcolor,
			["vehicle_neoncolor1"] = v.vehicle_neoncolor1,
			["vehicle_neoncolor2"] = v.vehicle_neoncolor2,
			["vehicle_neoncolor3"] = v.vehicle_neoncolor3,
			["vehicle_windowtint"] = v.vehicle_windowtint,
			["vehicle_wheeltype"] = v.vehicle_wheeltype,
			["vehicle_mods0"] = v.vehicle_mods0,
			["vehicle_mods1"] = v.vehicle_mods1,
			["vehicle_mods2"] = v.vehicle_mods2,
			["vehicle_mods3"] = v.vehicle_mods3,
			["vehicle_mods4"] = v.vehicle_mods4,
			["vehicle_mods5"] = v.vehicle_mods5,
			["vehicle_mods6"] = v.vehicle_mods6,
			["vehicle_mods7"] = v.vehicle_mods7,
			["vehicle_mods8"] = v.vehicle_mods8,
			["vehicle_mods9"] = v.vehicle_mods9,
			["vehicle_mods10"] = v.vehicle_mods10,
			["vehicle_mods11"] = v.vehicle_mods11,
			["vehicle_mods12"] = v.vehicle_mods12,
			["vehicle_mods13"] = v.vehicle_mods13,
			["vehicle_mods14"] = v.vehicle_mods14,
			["vehicle_mods15"] = v.vehicle_mods15,
			["vehicle_mods16"] = v.vehicle_mods16,
			["vehicle_turbo"] = v.vehicle_turbo,
			["vehicle_tiresmoke"] = v.vehicle_tiresmoke,
			["vehicle_xenon"] = v.vehicle_xenon,
			["vehicle_mods23"] = v.vehicle_mods23,
			["vehicle_mods24"] = v.vehicle_mods24,
			["vehicle_neon0"] = v.vehicle_neon0,
			["vehicle_neon1"] = v.vehicle_neon1,
			["vehicle_neon2"] = v.vehicle_neon2,
			["vehicle_neon3"] = v.vehicle_neon3,
			["vehicle_bulletproof"] = v.vehicle_bulletproof,
			["vehicle_smokecolor1"] = v.vehicle_smokecolor1,
			["vehicle_smokecolor2"] = v.vehicle_smokecolor2,
			["vehicle_smokecolor3"] = v.vehicle_smokecolor3,
			["vehicle_modvariation"] = v.vehicle_modvariation,
			["insurance"] = v.insurance,
			["instance"] = v.instance
		}
			print(v.vehicle_plate)
			print("bol")
			table.insert(vehicles, t)
		end
		TriggerClientEvent("ply_garages2:getVehicles", source, vehicles)
		--TriggerClientEvent("ply_insurance:getCars", source, vehicles)
	end)
end)
end)
AddEventHandler("ply_basemod:getPlayerVehicle", function()
	vehicles = {}
	MySQL.Async.fetchAll("SELECT * FROM user_vehicle WHERE identifier=@identifier",{['@identifier'] = getPlayerID(source)}, function(data)
		for _, v in ipairs(data) do
			t = {
			["id"] = v.id,
			["identifier"] = v.identifier,
			["garage_id"] = v.garage_id,
			["vehicle_name"] = v.vehicle_name,
			["vehicle_model"] = v.vehicle_model,
			["vehicle_price"] = v.vehicle_price,
			["vehicle_plate"] = v.vehicle_plate,
			["vehicle_state"] = v.vehicle_state,
			["vehicle_primarycolor"] = v.vehicle_colorprimary,
			["vehicle_secondarycolor"] = v.vehicle_colorsecondary,
			["vehicle_pearlescentcolor"] = v.vehicle_pearlescentcolor,
			["vehicle_wheelcolor"] = v.vehicle_wheelcolor,
			["vehicle_neoncolor1"] = v.vehicle_neoncolor1,
			["vehicle_neoncolor2"] = v.vehicle_neoncolor2,
			["vehicle_neoncolor3"] = v.vehicle_neoncolor3,
			["vehicle_windowtint"] = v.vehicle_windowtint,
			["vehicle_wheeltype"] = v.vehicle_wheeltype,
			["vehicle_mods0"] = v.vehicle_mods0,
			["vehicle_mods1"] = v.vehicle_mods1,
			["vehicle_mods2"] = v.vehicle_mods2,
			["vehicle_mods3"] = v.vehicle_mods3,
			["vehicle_mods4"] = v.vehicle_mods4,
			["vehicle_mods5"] = v.vehicle_mods5,
			["vehicle_mods6"] = v.vehicle_mods6,
			["vehicle_mods7"] = v.vehicle_mods7,
			["vehicle_mods8"] = v.vehicle_mods8,
			["vehicle_mods9"] = v.vehicle_mods9,
			["vehicle_mods10"] = v.vehicle_mods10,
			["vehicle_mods11"] = v.vehicle_mods11,
			["vehicle_mods12"] = v.vehicle_mods12,
			["vehicle_mods13"] = v.vehicle_mods13,
			["vehicle_mods14"] = v.vehicle_mods14,
			["vehicle_mods15"] = v.vehicle_mods15,
			["vehicle_mods16"] = v.vehicle_mods16,
			["vehicle_turbo"] = v.vehicle_turbo,
			["vehicle_tiresmoke"] = v.vehicle_tiresmoke,
			["vehicle_xenon"] = v.vehicle_xenon,
			["vehicle_mods23"] = v.vehicle_mods23,
			["vehicle_mods24"] = v.vehicle_mods24,
			["vehicle_neon0"] = v.vehicle_neon0,
			["vehicle_neon1"] = v.vehicle_neon1,
			["vehicle_neon2"] = v.vehicle_neon2,
			["vehicle_neon3"] = v.vehicle_neon3,
			["vehicle_bulletproof"] = v.vehicle_bulletproof,
			["vehicle_smokecolor1"] = v.vehicle_smokecolor1,
			["vehicle_smokecolor2"] = v.vehicle_smokecolor2,
			["vehicle_smokecolor3"] = v.vehicle_smokecolor3,
			["vehicle_modvariation"] = v.vehicle_modvariation,
			["insurance"] = v.insurance,
			["instance"] = v.instance
		}

			table.insert(vehicles, t)
		end
		TriggerClientEvent("ply_garages2:getVehicles", source, vehicles)
		--TriggerClientEvent("ply_insurance:getCars", source, vehicles)
	end)
end)
