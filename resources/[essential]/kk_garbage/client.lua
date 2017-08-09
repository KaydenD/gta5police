
local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local jobId = 1
local onDutyLoc = {["x"] = -327.68060302734, ["y"] = -1523.7197265625, ["z"] = 26.535755157471}
local truckSpawnLoc = {["x"] = -315.62954711914, ["y"] = -1534.4766845703, ["z"] = 26.637542724609}
local trashDump = {["x"] = -426.11807250977, ["y"] = -1687.2401123047, ["z"] = 18.029062271118}
local onDuty = false
local garbageLocs = {
{34.586521148682,-1011.3880004883,28.4566822052},
{-24.391639709473,-971.43090820313,28.369186401367},
{-94.157051086426,-1468.8337402344,32.101062774658},
{-355.54388427734,-1459.2456054688,28.580219268799},
{-327.38641357422,-1359.0874023438,30.295722961426},
{-234.60820007324,-1302.4919433594,30.295967102051},
{-363.2981262207,-1864.9235839844,19.5279712677},
{142.89874267578,-1662.50390625,28.376617431641},
{157.36724853516,-1651.9636230469,28.291662216187},
{138.3123626709,-1594.9278564453,28.361848831177},
{300.57925415039,-1287.6630859375,29.426132202148},
{-640.51708984375,-2350.6162109375,12.945272445679},
{-1145.5596923828,-1970.4346923828,12.160362243652},
{122.82598114014,-2561.2790527344,5.2447619438171},
{952.99932861328,-2180.8298339844,29.551584243774},
{892.51336669922,-1586.8369140625,29.382211685181},
{831.75677490234,-1315.8914794922,25.163497924805},
{826.44390869141,-1062.9495849609,26.954694747925},
{796.97229003906,-758.27667236328,25.874586105347},
{1125.9714355469,-464.61785888672,65.488830566406},
{317.21267700195,-215.4354095459,53.086269378662},
{266.11944580078,-180.79124450684,60.570892333984},
{-150.22402954102,-20.467844009399,57.213619232178},
{-727.06622314453,-427.70697021484,34.305206298828},
{-1134.2766113281,-431.65521240234,35.110004425049},
{-1392.7685546875,-445.61770629883,33.478134155273},
{-1504.3104248047,-512.81750488281,31.806827545166},
{-1842.1478271484,-1176.1412353516,12.017228126526},
{-1990.4293212891,-487.05075073242,10.60950756073},
{-1192.0024414063,-1511.2883300781,3.3733291625977},
{-1263.4659423828,-1374.1157226563,3.1459107398987},
{-1227.9012451172,-1219.5164794922,5.9508676528931},
{-1049.28125,-1016.6243896484,1.1503565311432},
{-586.40893554688,-750.37866210938,28.487033843994},
{-225.41390991211,-637.72143554688,32.437160491943},
{-360.68978881836,-960.84649658203,30.080604553223},
{-359.35049438477,-642.75360107422,30.719896316528},
{288.33239746094,-613.8408203125,42.418891906738},
{395.66192626953,-739.78558349609,28.2767162323}
}
local BLIPS = {}
local propsobj = nil
local blipForPickup = nil
local pickUpCoords = {}
RegisterNetEvent("garbageJobsReturn")
AddEventHandler("garbageJobsReturn", function(id)
    jobId = id
	if(jobId ~= 13) then
		onDuty = false
		if(blipForPickup) then
			SetBlipRoute(blipForPickup, false)
			RemoveBlip(blipForPickup)
		end
	end
	for _, item in pairs(BLIPS) do
         if(item) then
        	RemoveBlip(item)
        end
    end
	if(jobId == 13) then
		setBlip(onDutyLoc.x, onDutyLoc.y, onDutyLoc.z, 85, "Garbage Duty Location")
		setBlip(trashDump.x, trashDump.y, trashDump.z, 85, "Garbage Dump")
	end
	math.randomseed(GetGameTimer())
	math.random()
	math.random()
	math.random()
	math.random()
	math.random()
	math.random()
end)


function setBlip(x, y, z, num, markerName)
    local blip = AddBlipForCoord(x, y, z)
    SetBlipSprite(blip, tonumber(num))
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(tostring(markerName))
    EndTextCommandSetBlipName(blip)
    table.insert(BLIPS, blip)
end

function setBlipReturn(x, y, z, num, markerName)
    local blip = AddBlipForCoord(x, y, z)
    SetBlipSprite(blip, tonumber(num))
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(tostring(markerName))
    EndTextCommandSetBlipName(blip)
    return blip
end

function setGarbagePickup()
	math.randomseed(GetGameTimer())
    pickUpCoords = garbageLocs[math.random(1, #garbageLocs)]
	blipForPickup = setBlipReturn(pickUpCoords[1], pickUpCoords[2], pickUpCoords[3], 318, "Pickup Location")
	SetBlipRoute(blipForPickup, true)
	local prophash = GetHashKey("prop_rub_binbag_sd_02")
	RequestModel(prophash)
	while not HasModelLoaded(prophash) do
		Citizen.Wait(0)
	end
	--local _, worldZ = GetGroundZFor_3dCoord(pickUpCoords[1], pickUpCoords[2], pickUpCoords[3])
	propsobj = CreateObjectNoOffset(prophash, pickUpCoords[1], pickUpCoords[2], pickUpCoords[3] + .25, true, true, true)
	--SetNewWaypoint(pickUpCoords[1], pickUpCoords[2])
end

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function spawnGarbageTruck()
	Citizen.Wait(0)
	local myPed = GetPlayerPed(-1)
	local player = PlayerId()
	local vehicle = GetHashKey('TRASH')

	RequestModel(vehicle)

	while not HasModelLoaded(vehicle) do
		Wait(1)
	end
	math.randomseed(GetGameTimer())
	local plate = math.random(100, 9999)
	local coords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, 5.0, 0)
	local spawned_car = CreateVehicle(vehicle, coords, truckSpawnLoc.x, truckSpawnLoc.y, truckSpawnLoc.z, true, false)

	SetVehicleOnGroundProperly(spawned_car)
	SetVehicleNumberPlateText(spawned_car, "Garb" .. tostring(plate))
	SetEntityHeading(spawned_car, 210.0)
	SetPedIntoVehicle(myPed, spawned_car, - 1)
	SetEntityAsMissionEntity(spawned_car, true, true)
	SetModelAsNoLongerNeeded(vehicle)
	--Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(spawned_car))
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local playerPos = GetEntityCoords(GetPlayerPed(-1), true)
		if onDuty and jobId == 13 then
			if (Vdist(playerPos.x, playerPos.y, playerPos.z, pickUpCoords[1], pickUpCoords[2], pickUpCoords[3]) < 100.0) then
				DrawMarker(1, pickUpCoords[1], pickUpCoords[2], pickUpCoords[3], 0, 0, 0, 0, 0, 0, 4.0001, 4.0001, 1.5001, 255, 165, 0,165, 0, 0, 0,0)
				if (Vdist(playerPos.x, playerPos.y, playerPos.z, pickUpCoords[1], pickUpCoords[2], pickUpCoords[3]) < 2.0) then
					if(exports.vdk_inventory:getWeightPotential(25, 1, 20)) then
						DisplayHelpText("Press E to pickup trash")
						if (IsControlJustReleased(1, 51)) then
							exports.pNotify:SendNotification({text = "Trash Picked Up", type = "success", queue = "left", timeout = 3000, layout = "centerRight"})
							if(propsobj) then
								DeleteObject(propsobj)
							end
							if(blipForPickup) then
								SetBlipRoute(blipForPickup, false)
								RemoveBlip(blipForPickup)
							end
							setGarbagePickup()
							TriggerEvent("player:receiveItem", 25, 1, 20)
						end
					else
						DisplayHelpText("Not enough space")
					end
				end
			end
		end
	end
end)

Citizen.CreateThread(
	function()
		local x = trashDump.x
		local y = trashDump.y
		local z = trashDump.z

		while true do
			Citizen.Wait(1)
			if(jobId == 13 and onDuty) then
				local ped = GetPlayerPed(-1)
				local playerPos = GetEntityCoords(ped, true)
				if IsPedInAnyVehicle(ped, false) then
					local veh = GetVehiclePedIsIn(ped, false)
					if (GetPedInVehicleSeat(veh,-1) == ped) then
						if ((Vdist(playerPos.x, playerPos.y, playerPos.z, x, y, z) < 100.0) and jobId == 13 and onDuty) then
							-- Service
							DrawMarker(1, x, y, z, 0, 0, 0, 0, 0, 0, 10.0001, 10.0001, 1.5001, 255, 165, 0,165, 0, 0, 0,0)
		
							if (Vdist(playerPos.x, playerPos.y, playerPos.z, x, y, z) < 5.0) then
								DisplayHelpText("Press E to empty truck")
		
								if (IsControlJustReleased(1, 51)) then
									TriggerServerEvent("deleteTrashFromTruck", GetVehicleNumberPlateText(veh))
								end
							end
						end
					end
				end
			end
		end
	end
)

Citizen.CreateThread(
	function()
		local x = onDutyLoc.x
		local y = onDutyLoc.y
		local z = onDutyLoc.z

		while true do
			Citizen.Wait(1)

			local playerPos = GetEntityCoords(GetPlayerPed(-1), true)

			if (Vdist(playerPos.x, playerPos.y, playerPos.z, x, y, z) < 100.0) and (jobId == 13) then
				-- Service
				DrawMarker(1, x, y, z, 0, 0, 0, 0, 0, 0, 3.0001, 3.0001, 1.5001, 255, 165, 0,165, 0, 0, 0,0)

				if (Vdist(playerPos.x, playerPos.y, playerPos.z, x, y, z) < 2.0) then
					if onDuty then
						DisplayHelpText("Press E to go off duty")
					else
						DisplayHelpText("Press E to go on duty")
					end

					if (IsControlJustReleased(1, 51)) then
						if(onDuty) then
							exports.pNotify:SendNotification({text = "YOUR FIRED", type = "success", queue = "left", timeout = 3000, layout = "centerRight"})
							onDuty = false
							if(propsobj) then
								DeleteObject(propsobj)
							end
							if(blipForPickup) then
								RemoveBlip(blipForPickup)
							end
						else
							exports.pNotify:SendNotification({text = "You are now a Garbage Man (Yep, I assumed your gender)", type = "success", queue = "left", timeout = 3000, layout = "centerRight"})
							onDuty = true
							setGarbagePickup()
						end
					end
				end
			end
		end
end)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(1)

			local playerPos = GetEntityCoords(GetPlayerPed(-1), true)

			if (Vdist(playerPos.x, playerPos.y, playerPos.z, truckSpawnLoc.x, truckSpawnLoc.y, truckSpawnLoc.z) < 100.0) and onDuty and jobId == 13 then
				-- Service car
				DrawMarker(1, truckSpawnLoc.x, truckSpawnLoc.y, truckSpawnLoc.z, 0, 0, 0, 0, 0, 0, 3.0001, 3.0001, 1.5001, 255, 165, 0,165, 0, 0, 0,0)
				if (Vdist(playerPos.x, playerPos.y, playerPos.z, truckSpawnLoc.x, truckSpawnLoc.y, truckSpawnLoc.z) < 2.0) then
					DisplayHelpText('Press ~g~E~s~ to get your Garbage Truck')

					if (IsControlJustReleased(1, 51)) then
						spawnGarbageTruck()
					end
				end
			end
		end
end)

