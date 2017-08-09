ITEMS = {}
itemsLoaded = false
--RegisterNetEvent("jobs:getJobs")

RegisterNetEvent("cli:getJobs")
AddEventHandler("cli:getJobs", function(listJobs) 
    if(itemsLoaded == false) then
        ITEMS = listJobs
        itemsLoaded = true
        Citizen.Trace("Started Get Jobs part 1")
        for index,value in pairs(listJobs) do 
            Citizen.Trace(tostring(index))
            Citizen.Trace(tostring(value.libelle))
        end
        Citizen.Trace("Started Get Jobs part 2")
        for index,value in pairs(ITEMS) do 
            Citizen.Trace(tostring(index))
            Citizen.Trace(tostring(value.libelle))
        end
    end
end)

function getItems()
    Citizen.Trace("GetItemsCur")
    for index,value in pairs(ITEMS) do 
        Citizen.Trace(tostring(index))
        Citizen.Trace(tostring(value.libelle))
    end
    return ITEMS
end

pawnShop = {132.0613,-1771.8416,28.9}
Citizen.CreateThread(function()
	local blip = AddBlipForCoord(pawnShop[1], pawnShop[2], pawnShop[3])
	SetBlipSprite(blip, 439)
	SetBlipScale(blip, 0.8)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Pawn Shop")
	EndTextCommandSetBlipName(blip)
    Citizen.Trace("added blip")
end)
lastPos = {['x'] = nil, ['y'] = nil, ['z'] = nil}
randAmount = nil
-- Constantly check the position of the player


Citizen.CreateThread(function()
    Citizen.Wait(1000)
    while true do
        Citizen.Wait(1)
        --near = IsNear()
        if(itemsLoaded) then
            local ply = GetPlayerPed(-1)
            local plyCoords = GetEntityCoords(ply, 0)
            local nameOfZone = GetNameOfZone(plyCoords["x"], plyCoords["y"], plyCoords["z"])
            if(nameOfZone == "BEACH" or nameOfZone == "DELBE") then
                if(GetSelectedPedWeapon(ply) == GetHashKey("WEAPON_CROWBAR")) then
                    if (exports.vdk_inventory:notFull() == true) then
                        --Citizen.Trace("weapon = crowbar")
                        if(lastPos.x == nil or lastPos.y == nil or lastPos.z == nil) then
                            Citizen.Wait(math.random(10000, 20000))
                            plyCoords = GetEntityCoords(ply, 0)
                            nameOfZone = GetNameOfZone(plyCoords["x"], plyCoords["y"], plyCoords["z"])
                            if(nameOfZone == "BEACH" or nameOfZone == "DELBE") then
                                TriggerEvent("mt:missiontext", ' ~g~' .. "I think I found Something" .. '~s~...', 4000)
                                TaskStartScenarioInPlace(ply, "world_human_gardener_plant", 0, false)
                                Citizen.Wait(4000)
                                ClearPedTasksImmediately(ply)
                                SetCurrentPedWeapon(ply, GetHashKey("WEAPON_CROWBAR"), true)
                                local item = nil
                                if(math.random(1, 100) >= 65) then
                                    item = math.random(13, 18)
                                else
                                    item = math.random(43, 45)
                                end
                                TriggerEvent("player:receiveItem", item, 1)
                                Citizen.Trace(tostring(item))
                                Citizen.Trace("Timer one")
                                for index,value in pairs(ITEMS) do
                                    Citizen.Trace(tostring(index))
                                    Citizen.Trace(tostring(value.libelle))
                                end
                                TriggerEvent("mt:missiontext", ' ~g~' .. "It's a " .. ITEMS[item].libelle ..'~s~...', 1000)
                                lastPos.x = plyCoords["x"]
                                lastPos.y = plyCoords["y"]
                                lastPos.z = plyCoords["z"]
                            end
                        else
                            if(randAmount ~= nil) then
                                if(GetDistanceBetweenCoords(lastPos.x, lastPos.y, lastPos.z, plyCoords["x"], plyCoords["y"], plyCoords["z"], true) > randAmount) then
                                    TriggerEvent("mt:missiontext", ' ~g~' .. "I think I found Something" .. '~s~...', 4000)
                                    TaskStartScenarioInPlace(ply, "world_human_gardener_plant", 0, false)
                                    Citizen.Wait(4000)
                                    ClearPedTasksImmediately(ply)
                                    SetCurrentPedWeapon(ply, GetHashKey("WEAPON_CROWBAR"), true)
                                    local item = nil
                                    if(math.random(1, 100) >= 65) then
                                        item = math.random(13, 18)
                                    else
                                        item = math.random(43, 45)
                                    end
                                    Citizen.Trace("Dist one")
                                    TriggerEvent("player:receiveItem", item, 1)
                                    Citizen.Trace(tostring(item))
                                    TriggerEvent("mt:missiontext", ' ~g~' .. "It's a " .. ITEMS[item].libelle ..'~s~...', 1000)
                                    lastPos.x = plyCoords["x"]
                                    lastPos.y = plyCoords["y"]
                                    lastPos.z = plyCoords["z"]
                                    randAmount = nil
                                end
                            else
                                randAmount = math.random(10, 60)
                            end
                        end

                    else
                        TriggerEvent("mt:missiontext",'~r~FULL~w~', 1000)
                    end
                end
            else
                if(lastPos.x ~= nil or lastPos.y ~= nil or lastPos.z ~= nil) then
                    lastPos.x = nil
                    lastPos.y = nil
                    lastPos.z = nil
                    randAmount = nil
                end
            end
        end
    end
end)

soldStuff = false

Citizen.CreateThread(function()
    Citizen.Wait(1000)
    while true do
        if(itemsLoaded) then
        Citizen.Wait(500)
        --Citizen.Trace("Check pawn loc")
        local ply = GetPlayerPed(-1)
        local plyCoords = GetEntityCoords(ply, 0)
        if(GetDistanceBetweenCoords(pawnShop[1], pawnShop[2], pawnShop[3], plyCoords["x"], plyCoords["y"], plyCoords["z"], true) < 100) then
            --DrawMarker(1,pawnShop[1],pawnShop[2],pawnShop[3],0,0,0,0,0,0,3.001,3.001,0.5001,0,155,255,200,0,0,0,0)
            if(GetDistanceBetweenCoords(pawnShop[1], pawnShop[2], pawnShop[3], plyCoords["x"], plyCoords["y"], plyCoords["z"], true) < 6) then                 
                for i=13, 18 do
                    local qty = exports.vdk_inventory:getQuantity(i)
                    if (qty > 0) then
                        TriggerEvent("mt:missiontext", "Selling " .. ITEMS[i].libelle, 3000)
                        Citizen.Wait(4000)
                        soldStuff = true
                        TriggerEvent("player:looseItem", tonumber(i), qty)
                        TriggerServerEvent("item:sell", ITEMS[i].sellPrice * qty)
                        TriggerEvent("mt:missiontext", "Sold " .. ITEMS[i].libelle, 1000)
                    end
                end
                for i=43, 45 do
                    local qty = exports.vdk_inventory:getQuantity(i)
                    if (qty > 0) then
                        TriggerEvent("mt:missiontext", "Selling " .. ITEMS[i].libelle, 3000)
                        Citizen.Wait(4000)
                        soldStuff = true
                        TriggerEvent("player:looseItem", tonumber(i), qty)
                        TriggerServerEvent("item:sell", ITEMS[i].sellPrice * qty)
                        TriggerEvent("mt:missiontext", "Sold " .. ITEMS[i].libelle, 1000)
                    end
                end
                if(soldStuff) then
                    TriggerEvent("mt:missiontext", "~r~No More Items to sell~w~", 500)
                else
                    TriggerEvent("mt:missiontext", "~r~No Items to sell~w~", 500)
                end
            else
                if(soldStuff) then
                    soldStuff = false
                end
            end
        end
        end
    end
end)

Citizen.CreateThread(function()
    Citizen.Wait(1000)
    while true do
        Citizen.Wait(1)
        --Citizen.Trace("Check pawn loc")
        local ply = GetPlayerPed(-1)
        local plyCoords = GetEntityCoords(ply, 0)
        if(GetDistanceBetweenCoords(pawnShop[1], pawnShop[2], pawnShop[3], plyCoords["x"], plyCoords["y"], plyCoords["z"], true) < 100) then
            DrawMarker(1,pawnShop[1],pawnShop[2],pawnShop[3],0,0,0,0,0,0,3.001,3.001,0.5001,0,155,255,200,0,0,0,0)
        end
    end
end)
