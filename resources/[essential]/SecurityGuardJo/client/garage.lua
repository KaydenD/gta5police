local buttons = {}
buttons[#buttons+1] = {name = "Security Crown Vic", func = "SpawnSCV"}
buttons[#buttons+1] = {name = "Taurus", func = "SpawnCaddy"}


function SpawnSCV()
	CloseMenu()
	SpawnerVeh("policeold2")
end
function SpawnCaddy()
	CloseMenu()
	SpawnerVeh("caddy")
end

function SpawnerVeh(hash)
	local car = GetHashKey(hash)
	local playerPed = GetPlayerPed(-1)
	RequestModel(car)
	while not HasModelLoaded(car) do
			Citizen.Wait(0)
	end
	local playerCoords = GetEntityCoords(playerPed)
	policevehicle = CreateVehicle(car, playerCoords, 90.0, true, false)
	SetVehicleNumberPlateText(policevehicle, "cop")
	SetVehicleMod(policevehicle, 11, 2)
	SetVehicleMod(policevehicle, 12, 2)
	SetVehicleMod(policevehicle, 13, 2)
	--SetVehicleEnginePowerMultiplier(policevehicle, 250.0)
	SetVehicleOnGroundProperly(policevehicle)
	SetVehicleHasBeenOwnedByPlayer(policevehicle,true)
	local netid = NetworkGetNetworkIdFromEntity(policevehicle)
	SetNetworkIdCanMigrate(netid, true)
	NetworkRegisterEntityAsNetworked(VehToNet(policevehicle))
	TaskWarpPedIntoVehicle(playerPed, policevehicle, -1)
	SetEntityInvincible(policevehicle, false)
	SetEntityAsMissionEntity(policevehicle, true, true)
end

function OpenSeq()
	CloseMenu()
	SendNUIMessage({
		title = "Security Garage",
		buttons = buttons,
		action = "setAndOpen"
	})
	
	anyMenuOpen.menuName = "garage2"
	anyMenuOpen.isActive = true
end