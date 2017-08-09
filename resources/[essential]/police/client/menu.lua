Citizen.Trace("Start Menu")
local buttonsCategories = {}
buttonsCategories[#buttonsCategories+1] = {name = txt[config.lang]["menu_animations_title"], func = "OpenAnimMenu"}
buttonsCategories[#buttonsCategories+1] = {name = txt[config.lang]["menu_citizens_title"], func = "OpenCitizenMenu"}
buttonsCategories[#buttonsCategories+1] = {name = txt[config.lang]["menu_vehicles_title"], func = "OpenVehMenu"}
buttonsCategories[#buttonsCategories+1] = {name = txt[config.lang]["menu_props_title"], func = "OpenPropsMenu"}

local buttonsAnimation = {}
buttonsAnimation[#buttonsAnimation+1] = {name = txt[config.lang]["menu_anim_do_traffic_title"], func = 'DoTraffic'}
buttonsAnimation[#buttonsAnimation+1] = {name = txt[config.lang]["menu_anim_take_notes_title"], func = 'Note'}
buttonsAnimation[#buttonsAnimation+1] = {name = txt[config.lang]["menu_anim_standby_title"], func = 'StandBy'}
buttonsAnimation[#buttonsAnimation+1] = {name = txt[config.lang]["menu_anim_standby_2_title"], func = 'StandBy2'}
buttonsAnimation[#buttonsAnimation+1] = {name = txt[config.lang]["menu_anim_Cancel_emote_title"], func = 'CancelEmote'}

local buttonsCitizen = {}
if(config.useGcIdentity == true) then
	buttonsCitizen[1] = {name = txt[config.lang]["menu_id_card_title"], func = 'CheckId'}
end
if(config.useVDKInventory == true or config.useWeashop == true) then
	buttonsCitizen[#buttonsCitizen+1] = {name = txt[config.lang]["menu_check_inventory_title"], func = 'CheckInventory'}
	buttonsCitizen[#buttonsCitizen+1] = {name = "Confiscate Illegal Items", func = 'removeIllegal'}
end
buttonsCitizen[#buttonsCitizen+1] = {name = txt[config.lang]["menu_weapons_title"], func = 'RemoveWeapons'}
buttonsCitizen[#buttonsCitizen+1] = {name = txt[config.lang]["menu_toggle_cuff_title"], func = 'ToggleCuff'}
buttonsCitizen[#buttonsCitizen+1] = {name = txt[config.lang]["menu_force_player_get_in_car_title"], func = 'PutInVehicle'}
buttonsCitizen[#buttonsCitizen+1] = {name = "Put In jail", func = 'Arrest'}
buttonsCitizen[#buttonsCitizen+1] = {name = txt[config.lang]["menu_force_player_get_out_car_title"], func = 'UnseatVehicle'}
buttonsCitizen[#buttonsCitizen+1] = {name = txt[config.lang]["menu_drag_player_title"], func = 'DragPlayer'}
buttonsCitizen[#buttonsCitizen+1] = {name = txt[config.lang]["menu_fines_title"], func = 'OpenMenuFine'}


local buttonsFine = {}
buttonsFine[#buttonsFine+1] = {name = "$250", func = 'Fines250'}
buttonsFine[#buttonsFine+1] = {name = "$500", func = 'Fines500'}
buttonsFine[#buttonsFine+1] = {name = "$1000", func = 'Fines1000'}
buttonsFine[#buttonsFine+1] = {name = "$1500", func = 'Fines1500'}
buttonsFine[#buttonsFine+1] = {name = "$2000", func = 'Fines2000'}
buttonsFine[#buttonsFine+1] = {name = "$4000", func = 'Fines4000'}
buttonsFine[#buttonsFine+1] = {name = "$6000", func = 'Fines6000'}
buttonsFine[#buttonsFine+1] = {name = "$8000", func = 'Fines8000'}
buttonsFine[#buttonsFine+1] = {name = "$10000", func = 'Fines10000'}
buttonsFine[#buttonsFine+1] = {name = txt[config.lang]["menu_custom_amount_fine_title"], func = 'FinesCustom'}

local buttonsVehicle = {}
if(config.enableCheckPlate == true) then
	buttonsVehicle[#buttonsVehicle+1] = {name = txt[config.lang]["menu_check_plate_title"], func = 'CheckPlate'}
end
--buttonsVehicle[#buttonsVehicle+1] = {name = "Search car", func = 'searchVeh'}
buttonsVehicle[#buttonsVehicle+1] = {name = "Confiscate Illegal Items In car", func = 'removeIllegalVeh'}
buttonsVehicle[#buttonsVehicle+1] = {name = txt[config.lang]["menu_crochet_veh_title"], func = 'Crochet'}

local buttonsProps = {}
buttonsProps[#buttonsProps+1] = {name = "Spawn Spike Strip", func = "SpawnProps"}
buttonsProps[#buttonsProps+1] = {name = txt[config.lang]["menu_remove_last_props_title"], func = "RemoveLastProps"}
buttonsProps[#buttonsProps+1] = {name = txt[config.lang]["menu_remove_all_props_title"], func = "RemoveAllProps"}

function DoTraffic()
	Citizen.CreateThread(function()
        TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_CAR_PARK_ATTENDANT", 0, false)
        Citizen.Wait(60000)
        ClearPedTasksImmediately(GetPlayerPed(-1))
    end)
	drawNotification(txt[config.lang]["menu_doing_traffic_notification"])
end

function Note()
	Citizen.CreateThread(function()
        TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_CLIPBOARD", 0, false)
        Citizen.Wait(20000)
        ClearPedTasksImmediately(GetPlayerPed(-1))
    end) 
	drawNotification(txt[config.lang]["menu_taking_notes_notification"])
end

function StandBy()
	Citizen.CreateThread(function()
        TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_COP_IDLES", 0, true)
        Citizen.Wait(20000)
        ClearPedTasksImmediately(GetPlayerPed(-1))
    end)
	drawNotification(txt[config.lang]["menu_being_stand_by_notification"])
end

function StandBy2()
	Citizen.CreateThread(function()
        TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_GUARD_STAND", 0, 1)
        Citizen.Wait(20000)
        ClearPedTasksImmediately(GetPlayerPed(-1))
    end)
	drawNotification(txt[config.lang]["menu_being_stand_by_notification"])
end

function CancelEmote()
	Citizen.CreateThread(function()
        ClearPedTasksImmediately(GetPlayerPed(-1))
    end)
end

function CheckInventory()
	local t, distance = GetClosestPlayer()
	if(distance ~= -1 and distance < 3) then
		TriggerServerEvent("police:targetCheckInventory", GetPlayerServerId(t))
	else
		TriggerEvent('chatMessage', txt[config.lang]["title_notification"], {255, 0, 0}, txt[config.lang]["no_player_near_ped"])
	end
end

function removeIllegal()
	local t, distance = GetClosestPlayer()
	if(distance ~= -1 and distance < 3) then
		TriggerServerEvent("police:targetRemoveIllegal", GetPlayerServerId(t))
	else
		TriggerEvent('chatMessage', txt[config.lang]["title_notification"], {255, 0, 0}, txt[config.lang]["no_player_near_ped"])
	end
end

function CheckId()
	local t , distance  = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then
		TriggerServerEvent('gc:copOpenIdentity', GetPlayerServerId(t))
    else
		TriggerEvent('chatMessage', txt[config.lang]["title_notification"], {255, 0, 0}, txt[config.lang]["no_player_near_ped"])
	end
end

function RemoveWeapons()
    local t, distance = GetClosestPlayer()
    if(distance ~= -1 and distance < 3) then
        TriggerServerEvent("police:removeWeapons", GetPlayerServerId(t))
    else
        TriggerEvent('chatMessage', txt[config.lang]["title_notification"], {255, 0, 0}, txt[config.lang]["no_player_near_ped"])
    end
end

function ToggleCuff()
	local t, distance = GetClosestPlayer()
	if(distance ~= -1 and distance < 3) then
		TriggerServerEvent("police:cuffGranted", GetPlayerServerId(t))
	else
		TriggerEvent('chatMessage', txt[config.lang]["title_notification"], {255, 0, 0}, txt[config.lang]["no_player_near_ped"])
	end
end
--[[
function Arrest() 
	--local t, distance = GetClosestPlayer()
	Citizen.Trace("Arrest Started")
	Citizen.Trace(tostring(GetPlayerServerId(PlayerId())))
	local target1 = 0
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8S", "", "", "", "", "", 20)
	while (UpdateOnscreenKeyboard() == 0) do
		DisableAllControlActions(0);
		Wait(0);
	end
	if (GetOnscreenKeyboardResult()) then
		local res = tonumber(GetOnscreenKeyboardResult())
		if(res ~= nil and res ~= 0) then
			target1 = res				
		end
	end
	Citizen.Trace(tostring(target1))
	local ply = GetPlayerPed(-1)
	local plyCoords = GetEntityCoords(ply, 0)
	
	local closestDistance = -1
	local target = GetPlayerPed(GetPlayerFromServerId(target1))
	if(target ~= ply) then
		local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
		local distance = Vdist(targetCoords["x"], targetCoords["y"], targetCoords["z"], plyCoords["x"], plyCoords["y"], plyCoords["z"])
		if(closestDistance == -1 or closestDistance > distance) then
			closestDistance = distance
		end
	end

	if(closestDistance ~= -1 and closestDistance < 5) then
		local amount = -1
		DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8S", "", "", "", "", "", 20)
		while (UpdateOnscreenKeyboard() == 0) do
			DisableAllControlActions(0);
			Wait(0);
		end
		if (GetOnscreenKeyboardResult()) then
			local res = tonumber(GetOnscreenKeyboardResult())
			if(res ~= nil and res ~= 0) then
				amount = res				
			end
		end
		
		if(amount ~= -1) then
			if(amount > 4000)
				amount = 4000
			end
			Citizen.Trace(tostring(amount))
			TriggerServerEvent("jail:teleportToJail", target1, amount, GetPlayerServerId(PlayerId()))
		end
	else
		Citizen.Trace("noPlayer")
		TriggerEvent('chatMessage', txt[config.lang]["title_notification"], {255, 0, 0}, txt[config.lang]["no_player_near_ped"])
	end
end
]]
function Arrest()
	
	local amount = 0
	local target1 = 0
	TriggerEvent('chatMessage', '^4[JAIL]', {0,0,0}, "Please type the player ID")
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8S", "", "", "", "", "", 20)
	while (UpdateOnscreenKeyboard() == 0) do
		DisableAllControlActions(0);
		Wait(0);
	end
	if (GetOnscreenKeyboardResult()) then
		local res = tonumber(GetOnscreenKeyboardResult())
		if(res ~= nil and res ~= 0 and tonumber(res)) then
			target1 = res				
		else
				TriggerEvent('chatMessage', '^4[JAIL]', {0,0,0}, "Invaid entry")
			return
		end
	end
	local distance = GetPlayerDistance(target1)
	if(distance ~= -1 and distance < 3) then
			DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8S", "", "", "", "", "", 20)
			while (UpdateOnscreenKeyboard() == 0) do
				DisableAllControlActions(0);
				Wait(0);
			end
			if (GetOnscreenKeyboardResult()) then
				local res = tonumber(GetOnscreenKeyboardResult())
				if(res ~= nil and res ~= 0 and tonumber(res)) then
					amount = res
					if(amount > 6200) then
						amount = 6200
					end				
					TriggerServerEvent("jail:teleportToJail", target1, amount)
				else
					TriggerEvent('chatMessage', '^4[JAIL]', {0,0,0}, "Invaid entry")
					return
				end
			end
	else
		TriggerEvent('chatMessage', '^4[JAIL]', {0,0,0}, "No player near you (maybe get closer) !")
	end
end

function PutInVehicle()
	local t, distance = GetClosestPlayer()
	if(distance ~= -1 and distance < 3) then
		local v = GetVehiclePedIsIn(GetPlayerPed(-1), true)
		TriggerServerEvent("police:forceEnterAsk", GetPlayerServerId(t), v)
	else
		TriggerEvent('chatMessage', txt[config.lang]["title_notification"], {255, 0, 0}, txt[config.lang]["no_player_near_ped"])
	end
end

function UnseatVehicle()
	local t, distance = GetClosestPlayer()
	if(distance ~= -1 and distance < 3) then
		TriggerServerEvent("police:confirmUnseat", GetPlayerServerId(t))
	else
		TriggerEvent('chatMessage', txt[config.lang]["title_notification"], {255, 0, 0}, txt[config.lang]["no_player_near_ped"])
	end
end

function DragPlayer()
	local t, distance = GetClosestPlayer()
	if(distance ~= -1 and distance < 3) then
		TriggerServerEvent("police:dragRequest", GetPlayerServerId(t))
	else
		TriggerEvent('chatMessage', txt[config.lang]["title_notification"], {255, 0, 0}, txt[config.lang]["no_player_near_ped"])
	end
end

function Fines250()
	local t, distance = GetClosestPlayer()
	if(distance ~= -1 and distance < 3) then
		TriggerServerEvent("police:finesGranted", GetPlayerServerId(t), 250)
	else
		TriggerEvent('chatMessage', txt[config.lang]["title_notification"], {255, 0, 0}, txt[config.lang]["no_player_near_ped"])
	end
end

function Fines500()
	local t, distance = GetClosestPlayer()
	if(distance ~= -1 and distance < 3) then
		TriggerServerEvent("police:finesGranted", GetPlayerServerId(t), 500)
	else
		TriggerEvent('chatMessage', txt[config.lang]["title_notification"], {255, 0, 0}, txt[config.lang]["no_player_near_ped"])
	end
end

function Fines1000()
	local t, distance = GetClosestPlayer()
	if(distance ~= -1 and distance < 3) then
		TriggerServerEvent("police:finesGranted", GetPlayerServerId(t), 1000)
	else
		TriggerEvent('chatMessage', txt[config.lang]["title_notification"], {255, 0, 0}, txt[config.lang]["no_player_near_ped"])
	end
end

function Fines1500()
	local t, distance = GetClosestPlayer()
	if(distance ~= -1 and distance < 3) then
		TriggerServerEvent("police:finesGranted", GetPlayerServerId(t), 1500)
	else
		TriggerEvent('chatMessage', txt[config.lang]["title_notification"], {255, 0, 0}, txt[config.lang]["no_player_near_ped"])
	end
end

function Fines2000()
	local t, distance = GetClosestPlayer()
	if(distance ~= -1 and distance < 3) then
		TriggerServerEvent("police:finesGranted", GetPlayerServerId(t), 2000)
	else
		TriggerEvent('chatMessage', txt[config.lang]["title_notification"], {255, 0, 0}, txt[config.lang]["no_player_near_ped"])
	end
end

function Fines4000()
	local t, distance = GetClosestPlayer()
	if(distance ~= -1 and distance < 3) then
		TriggerServerEvent("police:finesGranted", GetPlayerServerId(t), 4000)
	else
		TriggerEvent('chatMessage', txt[config.lang]["title_notification"], {255, 0, 0}, txt[config.lang]["no_player_near_ped"])
	end
end

function Fines6000()
	local t, distance = GetClosestPlayer()
	if(distance ~= -1 and distance < 3) then
		TriggerServerEvent("police:finesGranted", GetPlayerServerId(t), 6000)
	else
		TriggerEvent('chatMessage', txt[config.lang]["title_notification"], {255, 0, 0}, txt[config.lang]["no_player_near_ped"])
	end
end

function Fines8000()
	local t, distance = GetClosestPlayer()
	if(distance ~= -1 and distance < 3) then
		TriggerServerEvent("police:finesGranted", GetPlayerServerId(t), 8000)
	else
		TriggerEvent('chatMessage', txt[config.lang]["title_notification"], {255, 0, 0}, txt[config.lang]["no_player_near_ped"])
	end
end

function Fines10000()
	local t, distance = GetClosestPlayer()
	if(distance ~= -1 and distance < 3) then
		TriggerServerEvent("police:finesGranted", GetPlayerServerId(t), 10000)
	else
		TriggerEvent('chatMessage', txt[config.lang]["title_notification"], {255, 0, 0}, txt[config.lang]["no_player_near_ped"])
	end
end

function FinesCustom()
	local t, distance = GetClosestPlayer()
	if(distance ~= -1 and distance < 3) then
		local amount = -1
		DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8S", "", "", "", "", "", 20)
		while (UpdateOnscreenKeyboard() == 0) do
			DisableAllControlActions(0);
			Wait(0);
		end
		if (GetOnscreenKeyboardResult()) then
			local res = tonumber(GetOnscreenKeyboardResult())
			if(res ~= nil and res ~= 0) then
				amount = res				
			end
		end
		
		if(amount ~= -1) then
			TriggerServerEvent("police:finesGranted", GetPlayerServerId(t), amount)
		end
	else
		TriggerEvent('chatMessage', txt[config.lang]["title_notification"], {255, 0, 0}, txt[config.lang]["no_player_near_ped"])
	end
end

function Crochet()
	Citizen.CreateThread(function()
		local pos = GetEntityCoords(GetPlayerPed(-1))
		local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 20.0, 0.0)

		local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
		local _, _, _, _, vehicleHandle = GetRaycastResult(rayHandle)
		if(DoesEntityExist(vehicleHandle)) then
			local prevObj = GetClosestObjectOfType(pos.x, pos.y, pos.z, 10.0, GetHashKey("prop_weld_torch"), false, true, true)
			if(IsEntityAnObject(prevObj)) then
				SetEntityAsMissionEntity(prevObj)
				DeleteObject(prevObj)
			end
			TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_WELDING", 0, true)
			Citizen.Wait(20000)
			SetVehicleDoorsLockedForAllPlayers(vehicleHandle, false)
			ClearPedTasksImmediately(GetPlayerPed(-1))
			drawNotification(txt[config.lang]["menu_veh_opened_notification"])
		else
			drawNotification(txt[config.lang]["no_veh_near_ped"])
		end
	end)
end

function CheckPlate()
	local pos = GetEntityCoords(GetPlayerPed(-1))
	local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 20.0, 0.0)

	local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
	local _, _, _, _, vehicleHandle = GetRaycastResult(rayHandle)
	if(DoesEntityExist(vehicleHandle)) then
		TriggerServerEvent("police:checkingPlate", GetVehicleNumberPlateText(vehicleHandle))
	else
		drawNotification(txt[config.lang]["no_veh_near_ped"])
	end
end

function removeIllegalVeh()
	local pos = GetEntityCoords(GetPlayerPed(-1))
	local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 20.0, 0.0)

	local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
	local _, _, _, _, vehicleHandle = GetRaycastResult(rayHandle)
	if(DoesEntityExist(vehicleHandle)) then
		TriggerServerEvent("police:removeIllegalVeh", GetVehicleNumberPlateText(vehicleHandle))
	else
		drawNotification(txt[config.lang]["no_veh_near_ped"])
	end
end

local propslist = {}
local propslist1 = {}
function SpawnProps()
	if(#propslist < config.propsSpawnLimitByCop) then
		Citizen.CreateThread(function()
			local prophash = GetHashKey("p_ld_stinger_s")
			RequestModel(prophash)
			while not HasModelLoaded(prophash) do
				Citizen.Wait(0)
			end
			local offset = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 0.75, 0.0)
			local _, worldZ = GetGroundZFor_3dCoord(offset.x, offset.y, offset.z)
			local propsobj = CreateObjectNoOffset(prophash, offset.x, offset.y, worldZ, true, true, true)
			local heading = GetEntityHeading(GetPlayerPed(-1))
			SetEntityHeading(propsobj, heading)
			SetModelAsNoLongerNeeded(prophash)
			SetEntityAsMissionEntity(propsobj)
			local temp = #propslist1+1
			propslist[temp] = ObjToNet(propsobj)
			--local temp = #propslist1+1
			propslist1[temp] = true
			CheckForTyre(temp, offset.x, offset.y, worldZ)
		end)
	end
end

function CheckForTyre(temp, x, y, z)
	Citizen.CreateThread(function()
		local spikeCoords = {["x"] = x, ["y"] = y, ["z"] = z}
		local spikeCoords5 = {["x"] = x, ["y"] = y, ["z"] = z + 5}
		local ped = GetPlayerPed(-1)
		while (propslist1[temp]) do		
			Citizen.Wait(1)	
			--local veh = GetClosestVehicle(x, y, z + .75, 3.000, 0, 70)
			--Citizen.Trace(tostring(x))
			--Citizen.Trace(tostring(y))
			--Citizen.Trace(tostring(z))
			--local entityWorld = GetOffsetFromEntIsEntityAVehicleityInWorldCoords(ped, 0.0, 120.0, 0.0)
    		local rayHandle = CastRayPointToPoint(spikeCoords.x, spikeCoords.y, spikeCoords.z, spikeCoords5.x, spikeCoords5.y, spikeCoords5.z, 10, 0, 0)
    		local a, b, c, d, veh = GetRaycastResult(rayHandle)
			if veh ~=nil then
				if(IsEntityAVehicle(veh)) then
					TriggerServerEvent("explodePlayerTyre", GetVehicleNumberPlateText(veh))
					Citizen.Trace("expolde")
					--[[
					SetVehicleTyreBurst(veh, 0, true, 1000.0)
					SetVehicleTyreBurst(veh, 1, true, 1000.0)
					SetVehicleTyreBurst(veh, 2, true, 1000.0)
					SetVehicleTyreBurst(veh, 3, true, 1000.0)
					SetVehicleTyreBurst(veh, 4, true, 1000.0)
					SetVehicleTyreBurst(veh, 5, true, 1000.0)
					]]
					DeleteObject(NetToObj(propslist[temp]))
					propslist[temp] = nil
					propslist1[temp] = nil
					
				end
			end
		end
	end)
end

RegisterNetEvent('explodePlayerTyreClient')
AddEventHandler('explodePlayerTyreClient', function(plate)
	local ped = GetPlayerPed(-1)
	if IsPedInAnyVehicle(ped, false) then
		local veh = GetVehiclePedIsIn(ped, false)
		if (GetPedInVehicleSeat(veh,-1) == ped) then 
			if(GetVehicleNumberPlateText(veh) == plate) then
				SetVehicleTyresCanBurst(veh,true)
				SetVehicleTyreBurst(veh, 0, true, 1000.0)
				SetVehicleTyreBurst(veh, 1, true, 1000.0)
				SetVehicleTyreBurst(veh, 2, true, 1000.0)
				SetVehicleTyreBurst(veh, 3, true, 1000.0)
				SetVehicleTyreBurst(veh, 4, true, 1000.0)
				SetVehicleTyreBurst(veh, 5, true, 1000.0)
			end
		end
	end
end)

function RemoveLastProps()
	DeleteObject(NetToObj(propslist[#propslist]))
	propslist[#propslist] = nil
	propslist1[#propslist1] = nil
end

function RemoveAllProps()
	for i, props in pairs(propslist) do
		DeleteObject(NetToObj(props))
		propslist[i] = nil
		propslist1[i] = nil
	end
end

function TogglePoliceMenu()
	if((anyMenuOpen.menuName ~= "policemenu" and anyMenuOpen.menuName ~= "policemenu-anim" and anyMenuOpen.menuName ~= "policemenu-citizens" and anyMenuOpen.menuName ~= "policemenu-veh" and anyMenuOpen.menuName ~= "policemenu-fines" and anyMenuOpen.menuName ~= "policemenu-props") and not anyMenuOpen.isActive) then
		SendNUIMessage({
			title = txt[config.lang]["menu_global_title"],
			buttons = buttonsCategories,
			action = "setAndOpen"
		})
		
		anyMenuOpen.menuName = "policemenu"
		anyMenuOpen.isActive = true
	else
		if((anyMenuOpen.menuName ~= "policemenu" and anyMenuOpen.menuName ~= "policemenu-anim" and anyMenuOpen.menuName ~= "policemenu-citizens" and anyMenuOpen.menuName ~= "policemenu-veh" and anyMenuOpen.menuName ~= "policemenu-fines" and anyMenuOpen.menuName ~= "policemenu-props") and anyMenuOpen.isActive) then
			CloseMenu()
			TogglePoliceMenu()
		else
			CloseMenu()
		end
	end
end

function BackMenuPolice()
	if(anyMenuOpen.menuName == "policemenu-anim" or anyMenuOpen.menuName == "policemenu-citizens" or anyMenuOpen.menuName == "policemenu-veh" or anyMenuOpen.menuName == "policemenu-props") then
		CloseMenu()
		TogglePoliceMenu()
	else
		CloseMenu()
		OpenCitizenMenu()
	end
end

function OpenAnimMenu()
	CloseMenu()
	SendNUIMessage({
		title = txt[config.lang]["menu_animations_title"],
		buttons = buttonsAnimation,
		action = "setAndOpen"
	})
	
	anyMenuOpen.menuName = "policemenu-anim"
	anyMenuOpen.isActive = true
end

function OpenCitizenMenu()
	CloseMenu()
	SendNUIMessage({
		title = txt[config.lang]["menu_citizens_title"],
		buttons = buttonsCitizen,
		action = "setAndOpen"
	})
	
	anyMenuOpen.menuName = "policemenu-citizens"
	anyMenuOpen.isActive = true
end



function OpenVehMenu()
	CloseMenu()
	SendNUIMessage({
		title = txt[config.lang]["menu_vehicles_title"],
		buttons = buttonsVehicle,
		action = "setAndOpen"
	})
	
	anyMenuOpen.menuName = "policemenu-veh"
	anyMenuOpen.isActive = true
end

function OpenMenuFine()
	CloseMenu()
	SendNUIMessage({
		title = txt[config.lang]["menu_fines_title"],
		buttons = buttonsFine,
		action = "setAndOpen"
	})
	
	anyMenuOpen.menuName = "policemenu-fines"
	anyMenuOpen.isActive = true
end

function OpenPropsMenu()
	CloseMenu()
	SendNUIMessage({
		title = txt[config.lang]["menu_props_title"],
		buttons = buttonsProps,
		action = "setAndOpen"
	})
	
	anyMenuOpen.menuName = "policemenu-props"
	anyMenuOpen.isActive = true
end
--[[
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		for _, props in pairs(propslist) do
			local ox, oy, oz = table.unpack(GetEntityCoords(NetToObj(props), true))
			local cVeh = GetClosestVehicle(ox, oy, oz, 20.0, 0, 70)
			if(IsEntityAVehicle(cVeh)) then
				if IsEntityAtEntity(cVeh, NetToObj(props), 20.0, 20.0, 2.0, 0, 1, 0) then
					local cDriver = GetPedInVehicleSeat(cVeh, -1)
					TaskVehicleTempAction(cDriver, cVeh, 6, 1000)
					SetVehicleHandbrake(cVeh, true)
					SetVehicleIndicatorLights(cVeh, 0, true)
					SetVehicleIndicatorLights(cVeh, 1, true)
				end
			end
		end
	end
end)
]]