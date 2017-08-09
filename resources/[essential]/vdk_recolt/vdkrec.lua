--Variables
local recoltDistance = 5
local timeForRecolt = 4000 --1000 for 1 second
--

local near
local jobId
JOBS = {}
BLIPS = {}
--RegisterNetEvent("jobs:getJobs")
RegisterNetEvent("cli:getJobs")
--[[
AddEventHandler("playerSpawned", function()
    TriggerServerEvent("jobs:getJobs")
end)
]]
-- Get the list of all jobs in the database and create the blip associated
AddEventHandler("cli:getJobs", function(listJobs)
    JOBS = listJobs
    Citizen.Trace("Jobs Is Jobs")
    Citizen.CreateThread(function()
        for _, item in pairs(BLIPS) do
            if(item) then
                RemoveBlip(item)
            end
        end
        for _, item in pairs(JOBS) do
            --Citizen.Trace(item.raw_item)
            if(tonumber(item.isLegal) == 1) then
                setBlip(item.fx, item.fy, item.fz, 17, item.collectmarkername)
                setBlip(item.tx, item.ty, item.tz, 18, item.processmarkertag)
                setBlip(item.sx, item.sy, item.sz, 19, item.sellMarkerName)
            end
        end
    end)
end)



-- Control if the player of is near of a place of job
function IsNear()
    local ply = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(ply, 0)
    for k, item in pairs(JOBS) do
        local distance_field = GetDistanceBetweenCoords(tonumber(item.fx), tonumber(item.fy), tonumber(item.fz), plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
        local distance_treatment = GetDistanceBetweenCoords(tonumber(item.tx), tonumber(item.ty), tonumber(item.tz), plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
        local distance_seller = GetDistanceBetweenCoords(tonumber(item.sx), tonumber(item.sy), tonumber(item.sz), plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
        if (distance_field <= tonumber(item.harvestRadius)) then
            jobId = k
            return 'field'
        elseif (distance_treatment <= tonumber(item.processRadius)) then
            jobId = k
            return 'treatment'
        elseif (distance_seller <= tonumber(item.sellRadius)) then
            jobId = k
            return 'seller'
        end
    end
    return false
end

function IsNearMarker()
    local ply = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(ply, 0)
    for k, item in pairs(JOBS) do
        local distance_field = GetDistanceBetweenCoords(tonumber(item.fx), tonumber(item.fy), tonumber(item.fz), plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
        local distance_treatment = GetDistanceBetweenCoords(tonumber(item.tx), tonumber(item.ty), tonumber(item.tz), plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
        local distance_seller = GetDistanceBetweenCoords(tonumber(item.sx), tonumber(item.sy), tonumber(item.sz), plyCoords["x"], plyCoords["y"], plyCoords["z"], true)       
        if (distance_field <= 100) then
            --Citizen.Trace(tostring(distance_field) .. " " .. tostring(item.raw_item))
            return {tonumber(item.fx), tonumber(item.fy), tonumber(item.fz), (((tonumber(item.harvestRadius)) * 2 ) + .001)}
        elseif (distance_treatment <= 100) then
            return {tonumber(item.tx), tonumber(item.ty), tonumber(item.tz), (((tonumber(item.processRadius)) * 2) + .001)}
        elseif (distance_seller <= 100) then
            return {tonumber(item.sx), tonumber(item.sy), tonumber(item.sz), (((tonumber(item.sellRadius)) * 2) + .001)}
        end
    end   
    return false            
end
local wasFishing = false
-- Display the message of recolting/treating/selling and trigger the associated event(s)
local notEnd = true
function recolt(text, rl)
    if (text == 'Récolte') then
        TriggerEvent("mt:missiontext",' Harvesting ~g~' .. tostring(JOBS[jobId].raw_item) .. '~s~...', tonumber(JOBS[jobId].HarvestTime) - 800)
        local oldID = jobId
        local oldTime = GetGameTimer()
        notEnd = true
        local ped = GetPlayerPed(-1)
        if(JOBS[jobId].harvestAnim ~= "none" and  wasFishing == false) then
            TaskStartScenarioInPlace(ped, JOBS[jobId].harvestAnim, 0, false)
            wasFishing = true
        end
        while(IsNear() == "field" and jobId == oldID and (notEnd == true)) do
            Citizen.Wait(1)
             if(GetTimeDifference(GetGameTimer(), oldTime) >= (tonumber(JOBS[jobId].HarvestTime) - 800)) then
				TriggerEvent("player:receiveItem", tonumber(JOBS[jobId].raw_id), 1, tonumber(JOBS[jobId].raw_weight))
                TriggerEvent("mt:missiontext", rl .. ' ~g~' .. tostring(JOBS[jobId].raw_item) .. '~s~...', 800)	
                if(JOBS[jobId].harvestAnim ~= "none") then
                    wasFishing = true
                end
                notEnd = false				
			end               
        end
        if(notEnd) then
            TriggerEvent("mt:missiontext",' ', 800)
            if(JOBS[oldID].harvestAnim ~= "none") then
                ClearPedTasksImmediately(ped)
                wasFishing = false
            end  
        end               
    elseif (text == 'Traitement') then
        Citizen.Trace("Got to Proccess")
        TriggerEvent("mt:missiontext",' Processing ~g~' .. tostring(JOBS[jobId].raw_item) .. '~s~...', tonumber(JOBS[jobId].ProcessTime) - 800)
        local oldID = jobId
        local oldTime = GetGameTimer()
        notEnd = true
        while(IsNear() == "treatment" and jobId == oldID and (notEnd == true)) do
            Citizen.Wait(1)
             if(GetTimeDifference(GetGameTimer(), oldTime) >= (tonumber(JOBS[jobId].ProcessTime) - 800)) then
				if(math.random(1, 1000) > tonumber(JOBS[jobId].ChangeOfExpolde1in1000)) then
                    TriggerEvent("player:looseItem", tonumber(JOBS[jobId].raw_id), 1)
                    TriggerEvent("player:receiveItem", tonumber(JOBS[jobId].treat_id), 1, tonumber(JOBS[jobId].treated_weight))
                    TriggerEvent("mt:missiontext", rl .. ' ~g~' .. tostring(JOBS[jobId].treat_item) .. '~s~...', 800)
                else
                    TriggerEvent("player:looseItem", tonumber(JOBS[jobId].raw_id), 1)
                    AddExplosion(JOBS[jobId].tx, JOBS[jobId].ty, JOBS[jobId].tz, EXPLOSION_TANKER, 15.0, true, false, 5.0)                    
                end
                notEnd = false				
			end               
        end
        if(notEnd) then
            TriggerEvent("mt:missiontext",' ', 800)    
        end 
        --[[
        Citizen.Wait(tonumber(JOBS[jobId].ProcessTime) - 800)
        if(IsNear() == "treatment" and jobId == oldID) then
            if(math.random(1, 1000) > tonumber(JOBS[jobId].ChangeOfExpolde1in1000)) then
                TriggerEvent("player:looseItem", tonumber(JOBS[jobId].raw_id), 1)
                TriggerEvent("player:receiveItem", tonumber(JOBS[jobId].treat_id), 1, tonumber(JOBS[jobId].treated_weight))
                TriggerEvent("mt:missiontext", rl .. ' ~g~' .. tostring(JOBS[jobId].treat_item) .. '~s~...', 800)
            else
                AddExplosion(JOBS[jobId].tx, JOBS[jobId].ty, JOBS[jobId].tz, EXPLOSION_TANKER, 15.0, true, false, 5.0)
            end
        end
        ]]
    elseif (text == 'Vente') then
        TriggerEvent("mt:missiontext", ' Selling ~g~' .. tostring(JOBS[jobId].treat_item) .. '~s~...', timeForRecolt - 800)
        local oldID = jobId
        local oldTime = GetGameTimer()
        notEnd = true
        while(IsNear() == "seller" and jobId == oldID and (notEnd == true)) do
            Citizen.Wait(1)
             if(GetTimeDifference(GetGameTimer(), oldTime) >= (timeForRecolt - 800)) then
				if(tonumber(JOBS[jobId].price) == 0) then
                    TriggerEvent("player:sellItem", tonumber(JOBS[jobId].treat_id), math.random(tonumber(JOBS[jobId].minrand), tonumber(JOBS[jobId].maxrand)))
                else
                    TriggerEvent("player:sellItem", tonumber(JOBS[jobId].treat_id), tonumber(JOBS[jobId].price))
                    Citizen.Trace(JOBS[jobId].price)
                    Citizen.Trace("Sell Part1")
                end
                TriggerEvent("mt:missiontext",' SOLD ~g~' .. tostring(JOBS[jobId].treat_item) .. '~s~', 800)
                notEnd = false				
			end               
        end
        if(notEnd) then
            TriggerEvent("mt:missiontext",' ', 800)    
        end 
        --[[
        Citizen.Wait(timeForRecolt - 800)
        if(tonumber(JOBS[jobId].price) == 0) then
            TriggerEvent("player:sellItem", tonumber(JOBS[jobId].treat_id), math.random(tonumber(JOBS[jobId].minrand), tonumber(JOBS[jobId].maxrand)))
        else
            TriggerEvent("player:sellItem", tonumber(JOBS[jobId].treat_id), tonumber(JOBS[jobId].price))
        end
        TriggerEvent("mt:missiontext",' SOLD ~g~' .. tostring(JOBS[jobId].treat_item) .. '~s~', 800)
        ]]
    end
    Citizen.Wait(800)
end

function setBlip(x, y, z, num, markerName)
    local blip = AddBlipForCoord(x, y, z)
    SetBlipSprite(blip, tonumber(num))
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(tostring(markerName))
    EndTextCommandSetBlipName(blip)
    table.insert(BLIPS, blip)
end

local timeWhenEnd = 0

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        if wasFishing then
            if IsControlJustPressed(1, 34) or IsControlJustPressed(1, 32) or IsControlJustPressed(1, 8) or IsControlJustPressed(1, 9) then
                ClearPedTasksImmediately(GetPlayerPed(-1))
                wasFishing = false
                timeWhenEnd = GetGameTimer()
                notEnd = false
                TriggerEvent("mt:missiontext",' ', 800)
            end
        end
    end
end)

Citizen.CreateThread(function()
    Citizen.Wait(5000)
    while true do
        if(JOBS ~= {}) then
        Citizen.Wait(1)
        near = IsNear()
        local ply = GetPlayerPed(-1)
        if(near) then
            --Citizen.Trace(near)
            if (exports.vdk_inventory:notFull() == true) then
                if (near == 'field' and exports.vdk_inventory:getWeightPotential(tonumber(JOBS[jobId].raw_id), 1, tonumber(JOBS[jobId].raw_weight)) and ((JOBS[jobId].weaponToCollect == "none") or (GetSelectedPedWeapon(ply) == GetHashKey(JOBS[jobId].weaponToCollect)))) then
                    if(tonumber(JOBS[jobId].harvestItemNeeded) == 0) then
                        recolt('Récolte', '+1')
                    else
                        if (exports.vdk_inventory:getQuantity(JOBS[jobId].harvestItemNeeded) > 0) and (GetTimeDifference(GetGameTimer(), timeWhenEnd) >= 3000) then
                            recolt('Récolte', '+1')
                        end
                    end
                elseif (near == 'treatment' and exports.vdk_inventory:getQuantity(JOBS[jobId].raw_id) > 0) then
                    Citizen.Trace("treatment recolt")
                    recolt('Traitement', '+1')
                elseif (near == 'seller' and exports.vdk_inventory:getQuantity(JOBS[jobId].treat_id) > 0) then
                    recolt('Vente', '-1')
                end
            elseif (wasFishing) then
                ClearPedTasksImmediately(ply)
                wasFishing = false
            else
                if (near == 'field') then
                    TriggerEvent("mt:missiontext",'~r~FULL~w~', 1000)
                elseif (near == 'treatment' and exports.vdk_inventory:getQuantity(JOBS[jobId].raw_id) > 0) then
                    Citizen.Trace("treatment recolt")
                    recolt('Traitement', '+1')
                elseif (near == 'seller' and exports.vdk_inventory:getQuantity(JOBS[jobId].treat_id) > 0) then
                    recolt('Vente', '-1')
                end         
            end
        end
        end
    end
end)

Citizen.CreateThread(function()
    Citizen.Wait(1000)
    while true do
    if(JOBS ~= {}) then
        Citizen.Wait(1)
        near = IsNearMarker()
        if(near) then
            DrawMarker(1,near[1],near[2],near[3],0,0,0,0,0,0,near[4],near[4],0.5001,0,155,255,200,0,0,0,0)
        end
    end
    end
end)

function Chat(debugg)
    TriggerEvent("chatMessage", '', { 0, 0x99, 255 }, tostring(debugg))
end