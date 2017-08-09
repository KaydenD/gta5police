--DrawMarker(1,item.x, item.y, item.z-1.0001, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)
-- local kmh = GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false)) * 3.6

-------- GUI options --------
options = {
    x = 0.9,
    y = 0.2,
    width = 0.4,
    height = 0.04,
    scale = 0.4,
    font = 0,
    menu_title = "radar",
    menu_subtitle = "Categories",
    color_r = 30,
    color_g = 144,
    color_b = 255,
}

-------- Script --------

radarActivated = false
limitSpeed = 130
inSubMenu = false

local xp = 0
local xm = 0
local yp = 0
local ym = 0


local lastNumberPlate = ""
local blackListedModelsArray = {}
local blackListedPlatesArray = {}

local onlyShowModel = false
local onlyShowPlate = false

Citizen.CreateThread(function()

	while true do
		Citizen.Wait(0)
		Menu.renderGUI(options)
		renderMenuHUD()
		tick()
	end

end)

Citizen.CreateThread(function()

	while true do
		Citizen.Wait(0)

		if(radarActivated == true) then

			if(IsPedInAnyPoliceVehicle(GetPlayerPed(-1))) then

			 	local playerPos = GetEntityCoords(GetPlayerPed(-1))
		--	DrawMarker(1,plyCoords["x"]+xm-xp, plyCoords["y"]+ym-yp, plyCoords["z"]-1.0001, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 178, 236, 93, 155, 0, 0, 2, 0, 0, 0, 0)

				local x = (playerPos.x+xm)-xp
				local y = (playerPos.y+ym)-yp
				local z = playerPos.z

				DrawMarker(1,x,y,z,0,0,0,0,0,0,2.001,2.0001,0.5001,0,155,255,200,0,0,0,0)


				local veh = GetClosestVehicle(x, y, playerPos.z-1.0001, 5.001, 0, 70)
				local kmh = GetEntitySpeed(veh) * 3.6


				if(veh ~=nil) then
					if(GetVehicleNumberPlateText(veh) ~=nil) then
						if(GetVehicleNumberPlateText(veh)==lastNumberPlate) then
						else
							local str = ""

							if(kmh > limitSpeed) then
								str = str.."~g~"..text[lang].speed.." : ~r~"..round(kmh,0).."\n"
							else
								str = str.."~g~"..text[lang].speed.." : ~b~"..round(kmh,0).."\n"
							end

							local blackListedPlate = false
							local blackListedModel = false

							for _,v in pairs(blackListedPlatesArray) do
								if(GetVehicleNumberPlateText(veh) == v) then
									str = str.."~g~"..text[lang].plate.." : ~r~"..GetVehicleNumberPlateText(veh).."\n"
									blackListedPlate = true
								end
							end

							if(blackListedPlate == false) then
								str = str.."~g~"..text[lang].plate.." : ~b~"..GetVehicleNumberPlateText(veh).."\n"
							end


							for _,v in pairs(blackListedModelsArray) do
								if(GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(veh))) == v) then
									str = str.."~g~"..text[lang].model.." : ~r~"..GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(veh)))
									blackListedModel = true
								end
							end

							if(blackListedModel == false) then
								str = str.."~g~"..text[lang].model.." : ~b~"..GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(veh)))
							end

							if((onlyShowPlate == true and blackListedPlate == true) or (onlyShowModel == true and blackListedModel == true) or (onlyShowModel == false and onlyShowPlate == false)) then
								SendNotification(str)
								lastNumberPlate = GetVehicleNumberPlateText(veh)
							end
						end
					else
						t, d = GetClosestPlayer(x,y,z)
						if(d ~= -1 and d < 2) then
							veh = GetVehiclePedIsUsing(GetPlayerPed(-1))
							kmh = GetEntitySpeed(veh) * 3.6


							if(GetVehicleNumberPlateText(veh)==lastNumberPlate) then
							else
								local str = ""

								if(kmh > limitSpeed) then
									str = str.."~g~"..text[lang].speed.." : ~r~"..round(kmh,0).."\n"
								else
									str = str.."~g~"..text[lang].speed.." : ~b~"..round(kmh,0).."\n"
								end

								local blackListedPlate = false
								local blackListedModel = false

								for _,v in pairs(blackListedPlatesArray) do
									if(GetVehicleNumberPlateText(veh) == v) then
										str = str.."~g~"..text[lang].plate.." : ~r~"..GetVehicleNumberPlateText(veh).."\n"
										blackListedPlate = true
									end
								end

								if(blackListedPlate == false) then
									str = str.."~g~"..text[lang].plate.." : ~b~"..GetVehicleNumberPlateText(veh).."\n"
								end


								for _,v in pairs(blackListedModelsArray) do
									if(GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(veh))) == v) then
										str = str.."~g~"..text[lang].model.." : ~r~"..GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(veh)))
										blackListedModel = true
									end
								end

								if(blackListedModel == false) then
									str = str.."~g~"..text[lang].model.." : ~b~"..GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(veh)))
								end

								if((onlyShowPlate == true and blackListedPlate == true) or (onlyShowModel == true and blackListedModel == true) or (onlyShowModel == false and onlyShowPlate == false)) then
									SendNotification(str)
									lastNumberPlate = GetVehicleNumberPlateText(veh)
								end
							end							
						end
					end
				end
			else
				radarActivated = false
			end
		end
	end

end)





function tick()
	DrawMarker(2, 1717,6389, 36, 0.0, 0.0, 0.0, 180.0, 0.0, 0.0, 0.75, 0.75, 0.75, 255, 0, 0, 100, false, true, 2, false, false, false, false)
    DrawMarker(2, 1718,6389, 36, 0.0, 0.0, 0.0, 180.0, 0.0, 0.0, 0.75, 0.75, 0.75, 0, 255, 0, 100, false, true, 2, false, false, false, false)
    DrawMarker(2, 1719,6389, 36, 0.0, 0.0, 0.0, 180.0, 0.0, 0.0, 0.75, 0.75, 0.75, 0, 255, 0, 100, false, true, 2, false, false, false, false)
	if(IsPedInAnyPoliceVehicle(GetPlayerPed(-1))) then
		if(GetEntityModel(GetVehiclePedIsIn(GetPlayerPed(-1), 0)) ~= GetHashKey("POLMAV")) then

			if(IsControlJustPressed(1,29)) then
				if(inSubMenu == true) then
					mainMenu()
				else
					Menu.hidden = not Menu.hidden
					mainMenu()
				end
			end

			if(radarActivated) then
				if(IsControlPressed(1, 61)) then
					if(ym > 0) then
						ym = ym -0.01
					else
						if(yp<=maxDistance) then
							yp = yp + 0.01
						end
					end
				end

				if(IsControlPressed(1, 60)) then
					if(yp > 0) then
						yp = yp-0.01
					else
						if(ym<=maxDistance) then
							ym = ym+0.01
						end
					end
				end

				if(IsControlPressed(1, 108)) then
					if(xm>0) then
						xm = xm-0.01
					else
						if(xp<=maxDistance) then
							xp = xp+0.01
						end
					end
				end

				if(IsControlPressed(1, 107)) then
					if(xp>0) then
						xp = xp-0.01
					else
						if(xm<=maxDistance) then
							xm = xm+0.01
						end
					end
				end
			end
		end
	end
end


function setPower()
	radarActivated = not radarActivated
	xp = 0
	xm = 0
	yp = 0
	ym = 0
	inSubMenu = false
	Menu.hidden = true
end


function onlyShowModels()
	onlyShowModel = not onlyShowModel
	inSubMenu = false
end

function onlyShowPlates()
	onlyShowPlate = not onlyShowPlate
	inSubMenu = false
end


function SendNotification(message)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(message)
	DrawNotification(false, false)
end


function round(num, dec)
  local mult = 10^(dec or 0)
  return math.floor(num * mult + 0.5) / mult
end

function addModelToArray(model)
	table.insert(blackListedModelsArray,model)
end


function addPlateToArray(model)
	table.insert(blackListedPlatesArray,model)
end

function GetPlayers()
    local players = {}

    for i = 0, 31 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
end

function GetClosestPlayer(x,y,z)
	local players = GetPlayers()
	local closestDistance = -1
	local closestPlayer = -1
	
	for index,value in ipairs(players) do
		local target = GetPlayerPed(value)
		if(target ~= ply) then
			local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
			local distance = GetDistanceBetweenCoords(targetCoords["x"], targetCoords["y"], targetCoords["z"], x, y, z, true)
			if(closestDistance == -1 or closestDistance > distance) then
				closestPlayer = value
				closestDistance = distance
			end
		end
	end
	
	return closestPlayer, closestDistance
end