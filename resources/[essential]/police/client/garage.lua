local buttons = {}
buttons[#buttons+1] = {name = "Crown Vic", func = "Spawnpolice"}
buttons[#buttons+1] = {name = "Taurus", func = "Spawnpolice3"}
buttons[#buttons+1] = {name = "Charger", func = "Spawnpolice2"}
buttons[#buttons+1] = {name = "Michigan State Patrol", func = "Spawnsheriff"}
buttons[#buttons+1] = {name = "Unmarked Charger", func = "Spawnfbi"}
buttons[#buttons+1] = {name = "Unmarked Crown Vic", func = "Spawnpolice4"}
buttons[#buttons+1] = {name = "Unmarked Taheo", func = "Spawnfbi2"}
buttons[#buttons+1] = {name = "Police Bike", func = "Spawnpoliceb"}
buttons[#buttons+1] = {name = "Transport Van", func = "Spawnpolicet"}
buttons[#buttons+1] = {name = "DNR Truck", func = "Spawnsheriff2"}
buttons[#buttons+1] = {name = "Bear Cat", func = "Spawnriot"}

function Spawnpolice()
	CloseMenu()
	SpawnerVeh("police")
end
function Spawnpolice2()
	CloseMenu()
	SpawnerVeh("police2")
end
function Spawnpolice3()
	CloseMenu()
	SpawnerVeh("police3")
end
function Spawnpolice4()
	CloseMenu()
	SpawnerVeh("police4")
end
function Spawnsheriff()
	CloseMenu()
	SpawnerVeh("sheriff")
end
function Spawnsheriff2()
	CloseMenu()
	SpawnerVeh("sheriff2")
end
function Spawnfbi()
	CloseMenu()
	SpawnerVeh("fbi")
end
function Spawnfbi2()
	CloseMenu()
	SpawnerVeh("fbi2")
end

function Spawnpoliceb()
	CloseMenu()
	SpawnerVeh("policeb")
end

function Spawnpolicet()
	CloseMenu()
	SpawnerVeh("policet")
end
function Spawnriot()
	CloseMenu()
	SpawnerVeh("riot")
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

function OpenGarage()
	CloseMenu()
	SendNUIMessage({
		title = txt[config.lang]["garage_global_title"],
		buttons = buttons,
		action = "setAndOpen"
	})
	
	anyMenuOpen.menuName = "garage"
	anyMenuOpen.isActive = true
end