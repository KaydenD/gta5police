local buttons = {}
buttons[#buttons+1] = {name = "Infernus", func = "Spawninfernus"}
buttons[#buttons+1] = {name = "Honda Civic", func = "SpawnCivic"}
buttons[#buttons+1] = {name = "Mercedes W210 AMG", func = "SpawnW210"}
buttons[#buttons+1] = {name = "2016 Dodge Charger SRT", func = "SpawnSRT"}
buttons[#buttons+1] = {name = "Chevy Suburban", func = "SpawnSuburban"}

function Spawninfernus()
	SpawnerVeh("infernus")
	CloseMenu()
end
function SpawnCivic()
	SpawnerVeh("ek9")
	CloseMenu()
end
function SpawnW210()
	SpawnerVeh("w210amg")
	CloseMenu()
end
function SpawnSRT()
	SpawnerVeh("16charger")
	CloseMenu()
end
function SpawnSuburban()
	SpawnerVeh("SUBN")
	CloseMenu()
end



function SpawnerVeh(hash)
	local car = GetHashKey(hash)
	local playerPed = GetPlayerPed(-1)
	RequestModel(car)
	while not HasModelLoaded(car) do
			Citizen.Wait(0)
	end
	local playerCoords = GetEntityCoords(playerPed)
	local baitvehicle = CreateVehicle(car, playerCoords, 90.0, true, false)
	SetVehicleMod(baitvehicle, 11, 2)
	SetVehicleMod(baitvehicle, 12, 2)
	SetVehicleMod(baitvehicle, 13, 2)
	--SetVehicleEnginePowerMultiplier(baitvehicle, 35.0)
	SetVehicleOnGroundProperly(baitvehicle)
	SetVehicleHasBeenOwnedByPlayer(baitvehicle,true)
	local netid = NetworkGetNetworkIdFromEntity(baitvehicle)
	SetNetworkIdCanMigrate(netid, true)
	NetworkRegisterEntityAsNetworked(VehToNet(baitvehicle))
	TaskWarpPedIntoVehicle(playerPed, baitvehicle, -1)
	SetEntityInvincible(baitvehicle, false)
	SetEntityAsMissionEntity(baitvehicle, true, true)
end

function OpenBaitCar()
	CloseMenu()
	SendNUIMessage({
		title = "Spawn Bait Car",
		buttons = buttons,
		action = "setAndOpen"
	})
	
	anyMenuOpen.menuName = "garage1"
	anyMenuOpen.isActive = true
end