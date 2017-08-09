local states = {}
states.frozen = false
states.frozenPos = nil



RegisterNetEvent('es_admin:spawnVehicle')
AddEventHandler('es_admin:spawnVehicle', function(v)
	local carid = GetHashKey(v)
	local playerPed = GetPlayerPed(-1)
	if playerPed and playerPed ~= -1 then
		RequestModel(carid)
		while not HasModelLoaded(carid) do
				Citizen.Wait(0)
		end
		local playerCoords = GetEntityCoords(playerPed)

		veh = CreateVehicle(carid, playerCoords, 0.0, true, false)
		SetVehicleAsNoLongerNeeded(veh)
		TaskWarpPedIntoVehicle(playerPed, veh, -1)
	end
end)

RegisterNetEvent('es_admin:doHashes')
AddEventHandler('es_admin:doHashes', function(hashes)
	local done = 1
	Citizen.CreateThread(function()
		while done - 1 < #hashes do
			Citizen.Wait(50)
			TriggerServerEvent('es_admin:givePos', hashes[done] .. "=" .. GetHashKey(hashes[done]) .. "\n")
			TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, 'Vehicles left: ' .. (#hashes - done) )
			done = done + 1
		end
	end)
end)

RegisterNetEvent('es_admin:getHash')
AddEventHandler('es_admin:getHash', function(h)
	TriggerEvent("chatMessage", "HASH", {255, 0, 0}, tostring(GetHashKey(h)))
end)

RegisterNetEvent('es_admin:freezePlayer')
AddEventHandler("es_admin:freezePlayer", function(state)
	local player = PlayerId()

	local ped = GetPlayerPed(-1)

	states.frozen = state
	states.frozenPos = GetEntityCoords(ped, false)

	if not state then
			if not IsEntityVisible(ped) then
					SetEntityVisible(ped, true)
			end

			if not IsPedInAnyVehicle(ped) then
					SetEntityCollision(ped, true)
			end

			FreezeEntityPosition(ped, false)
			--SetCharNeverTargetted(ped, false)
			SetPlayerInvincible(player, false)
	else

			SetEntityCollision(ped, false)
			FreezeEntityPosition(ped, true)
			--SetCharNeverTargetted(ped, true)
			SetPlayerInvincible(player, true)
			--RemovePtfxFromPed(ped)

			if not IsPedFatallyInjured(ped) then
					ClearPedTasksImmediately(ped)
			end
	end
end)

RegisterNetEvent('es_admin:teleportUser')
AddEventHandler('es_admin:teleportUser', function(x, y, z)
	SetEntityCoords(GetPlayerPed(-1), x, y, z)
	states.frozenPos = {x = x, y = y, z = z}
end)

RegisterNetEvent('burst')
AddEventHandler('burst', function()
	Citizen.Trace("deflate1")
	if(IsPedInAnyVehicle(GetPlayerPed(-1), false)) then
		Citizen.Trace("deflate2")
		local veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
		SetVehicleTyreBurst(veh, 0, true, 1000.0)
		SetVehicleTyreBurst(veh, 1, true, 1000.0)
		SetVehicleTyreBurst(veh, 2, true, 1000.0)
		SetVehicleTyreBurst(veh, 3, true, 1000.0)
		SetVehicleTyreBurst(veh, 4, true, 1000.0)
		SetVehicleTyreBurst(veh, 5, true, 1000.0)
		--SetVehicleUndrivable(veh, true)
	end
end)

RegisterNetEvent('addHatBack')
AddEventHandler('addHatBack', function(user)
	Citizen.Trace("Add Hat")
	if (GetEntityModel(GetPlayerPed(-1)) == GetHashKey("mp_m_freemode_01") or GetEntityModel(GetPlayerPed(-1)) == GetHashKey("mp_f_freemode_01")) then
		--Citizen.Trace("deflate2")
		--Citizen.Trace(user.helmet .. " " .. user.helmet_txt)
		SetPedPropIndex(GetPlayerPed(-1), 0, tonumber(user.helmet), tonumber(user.helmet_txt), 0)
	end
end)



RegisterNetEvent('es_admin:slap')
AddEventHandler('es_admin:slap', function()
	local ped = GetPlayerPed(-1)

	ApplyForceToEntity(ped, 1, 9500.0, 3.0, 7100.0, 1.0, 0.0, 0.0, 1, false, true, false, false)
end)

RegisterNetEvent('es_admin:givePosition')
AddEventHandler('es_admin:givePosition', function(msg)
	local pos = GetEntityCoords(GetPlayerPed(-1))
	local heading = GetEntityHeading(GetPlayerPed(-1))
	local string = msg .. " {" .. pos.x .. ",".. pos.y .. "," .. tostring(pos.z - 1) .. "},\n"
	TriggerServerEvent('es_admin:givePos', string)
	TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, 'Position saved to file.')
end)

RegisterNetEvent('es_admin:kill')
AddEventHandler('es_admin:kill', function()
	SetEntityHealth(GetPlayerPed(-1), 0)
end)

RegisterNetEvent('es_admin:heal')
AddEventHandler('es_admin:heal', function()
	SetEntityHealth(GetPlayerPed(-1), 200)
end)

RegisterNetEvent('es_admin:crash')
AddEventHandler('es_admin:crash', function()
	while true do
	end
end)

local noclip = false

RegisterNetEvent("es_admin:noclip")
AddEventHandler("es_admin:noclip", function(t)
	local msg = "disabled"
	if(noclip == false)then
		noclip_pos = GetEntityCoords(GetPlayerPed(-1), false)
	end

	noclip = not noclip

	if(noclip)then
		msg = "enabled"
	end

	TriggerEvent("chatMessage", "SYSTEM", {255, 0, 0}, "Noclip has been ^2^*" .. msg)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if(states.frozen)then
			ClearPedTasksImmediately(GetPlayerPed(-1))
			SetEntityCoords(GetPlayerPed(-1), states.frozenPos)
		end
	end
end)


function showStuff(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

RegisterNetEvent("es_admin:TPMARKER")
AddEventHandler("es_admin:TPMARKER", function()
	teleportToWaypoint()
end)


function teleportToWaypoint()
	local targetPed = GetPlayerPed(-1)
	local targetVeh = GetVehiclePedIsUsing(targetPed)
	if(IsPedInAnyVehicle(targetPed))then
		targetPed = targetVeh
	end

	if(not IsWaypointActive())then
		--showStuff("Map Marker not found.")
		return
	end

	local waypointBlip = GetFirstBlipInfoId(8) -- 8 = Waypoint ID
	local x,y,z = table.unpack(Citizen.InvokeNative(0xFA7C7F0AADF25D09, waypointBlip, Citizen.ResultAsVector())) 



	-- Ensure Entity teleports above the ground
	local ground
	local groundFound = false
	local groundCheckHeights = {100.0, 150.0, 50.0, 0.0, 200.0, 250.0, 300.0, 350.0, 400.0,450.0, 500.0, 550.0, 600.0, 650.0, 700.0, 750.0, 800.0}


	for i,height in ipairs(groundCheckHeights) do
		SetEntityCoordsNoOffset(targetPed, x,y,height, 0, 0, 1)
		Wait(50)

		ground,z = GetGroundZFor_3dCoord(x,y,height)
		if(ground) then
			z = z + 3
			groundFound = true
			break;
		end
	end

	if(not groundFound)then
		z = 1000
		GiveDelayedWeaponToPed(PlayerPedId(), 0xFBAB5776, 1, 0) -- Parachute
	end

	SetEntityCoordsNoOffset(targetPed, x,y,z, 0, 0, 1)
	--showStuff("Teleported to waypoint.")
end

local heading = 0

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if(noclip)then
			SetEntityCoordsNoOffset(GetPlayerPed(-1),  noclip_pos.x,  noclip_pos.y,  noclip_pos.z,  0, 0, 0)

			if(IsControlPressed(1,  34))then
				heading = heading + 1.5
				if(heading > 360)then
					heading = 0
				end
				SetEntityHeading(GetPlayerPed(-1),  heading)
			end
			if(IsControlPressed(1,  9))then
				heading = heading - 1.5
				if(heading < 0)then
					heading = 360
				end
				SetEntityHeading(GetPlayerPed(-1),  heading)
			end
			if(IsControlPressed(1,  8))then
				noclip_pos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 1.0, 0.0)
			end
			if(IsControlPressed(1,  32))then
				noclip_pos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, -1.0, 0.0)
			end

			if(IsControlPressed(1,  27))then
				noclip_pos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 0.0, 1.0)
			end
			if(IsControlPressed(1,  173))then
				noclip_pos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 0.0, -1.0)
			end
		end
	end
end)
