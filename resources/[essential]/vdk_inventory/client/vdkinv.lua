ITEMS = {}
NewItems = {}
-- flag to keep track of whether player died to prevent
-- multiple runs of player dead code
local playerdead = false
local maxCapacity = 64
local refreshTime = 60000


-- register events, only needs to be done once
RegisterNetEvent("item:reset")
RegisterNetEvent("item:getItems")
RegisterNetEvent("item:updateQuantity")
RegisterNetEvent("item:setItem")
RegisterNetEvent("item:sell")
RegisterNetEvent("gui:getItems")
RegisterNetEvent("gui:getItems1")
RegisterNetEvent("player:receiveItem")
RegisterNetEvent("player:looseItem")
RegisterNetEvent("player:sellItem")
RegisterNetEvent("player:getQuantity")



------------------------- EVENTS -------------------------

-- handles when a player spawns either from joining or after death
AddEventHandler("playerSpawned", function()
    TriggerServerEvent("item:getItems")
    -- reset player dead flag
    playerdead = false
end)

AddEventHandler("playerDropped", function()
    updateQuantities()
end)



AddEventHandler("gui:getItems", function(THEITEMS)
    ITEMS = {}
    ITEMS = THEITEMS
    --InventoryMenu()
    --Citizen.Trace("Bol")
end)

AddEventHandler("gui:getItems1", function(THEITEMS)
    ITEMS = {}
    ITEMS = THEITEMS
    InventoryMenu()
    --Citizen.Trace("Bol")
end)

AddEventHandler("player:getQuantity", function(fooditem, source)
    local weight = getWeight()
    TriggerServerEvent("player:cbgetQuantity", weight, fooditem, source)
end)

AddEventHandler("player:receiveItem", function(item, quantity, weight)
    if(weight == nil) then
        if (getWeight() + 1 <= maxCapacity) then
            item = tonumber(item)
            if (ITEMS[item] == nil) then
                new(item, quantity)
            else
                add({ item, quantity })
            end
        end
    else 
        if (getWeight() + weight <= maxCapacity) then
            item = tonumber(item)
            if (ITEMS[item] == nil) then
                new(item, quantity)
            else
                add({ item, quantity })
            end
        end
    end
end)

AddEventHandler("player:looseItem", function(item, quantity)
    item = tonumber(item)
    if (ITEMS[item].quantity >= quantity) then
        delete({ item, quantity })
    end
end)

AddEventHandler("player:sellItem", function(item, price)
    item = tonumber(item)
    if (ITEMS[item].quantity > 0) then
        sell({ item, price })
        Citizen.Trace("Sell Part2")
    end
end)

------------------------- METHODS -------------------------

function sell(arg)
    Citizen.Trace("Sell Part3")
    local itemId = tonumber(arg[1])
    local price = arg[2]
    local item = ITEMS[itemId]
    --item.quantity = item.quantity - 1
    --NewItems[itemId] = item.quantity
    local newQty = item.quantity - 1
    TriggerServerEvent("item:sell", price)
    TriggerServerEvent("item:updateQuantity", newQty, itemId)
    ITEMS[itemId].quantity = newQty
    InventoryMenu()
end

function delete(arg)
    local itemId = tonumber(arg[1])
    local qty = arg[2]
    local curqty = ITEMS[itemId].quantity
    local qty = curqty - qty
    --NewItems[itemId] = item.quantity
    TriggerServerEvent("item:updateQuantity", qty, itemId)
    ITEMS[itemId].quantity = qty
    if(tonumber(qty) == 0) then
        ITEMS[itemId] = nil
    end
    InventoryMenu()
end

function add(arg)
    local itemId = tonumber(arg[1])
    local qty = arg[2]
    local curqty = ITEMS[itemId].quantity
    local qty = curqty + qty
    --NewItems[itemId] = item.quantity
    TriggerServerEvent("item:updateQuantity", qty, itemId)
    ITEMS[itemId].quantity = qty
    InventoryMenu()
end

function new(item, quantity)
    TriggerServerEvent("item:setItem", item, quantity)
    --updateQuantities()
    --TriggerServerEvent("item:getItems")
end

function give(item)
    local player = getNearPlayer()
    if player then
        local res = 1
        if (ITEMS[item].quantity - res >= 0) then
            TriggerServerEvent("player:giveItem", item, ITEMS[item].libelle, res, GetPlayerServerId(player))
        end
    end
end

function updateQuantities()
    for item, quantity in pairs(NewItems) do
        TriggerServerEvent("item:updateQuantity", quantity, item)
    end
end

function PlayerIsDead()
    -- do not run if already ran
    if playerdead then
        return
    end
    TriggerServerEvent("item:reset")
end
function drop (itemId)
    TriggerEvent('player:looseItem', itemId, 1)
end

function use(val)
    local itemId = val[1]
    local canUse = val[2]
    local Amount = val[3]
    if canUse ~= 0 then
        if canUse == 1 then
            drink(itemId)
            TriggerEvent("food:vdrink", Amount)
        elseif canUse == 2 then
            eat(itemId)
            TriggerEvent("food:veat", Amount)
        elseif canUse == 3 then
            RepairVehicle()
            --TriggerEvent("food:veat", Amount)
        else 
            Toxicated()
            Citizen.Wait(7000)
            ClearPedTasks(GetPlayerPed(-1))
            Reality()
        end
        --if(canUse ~= 3) then
        TriggerEvent('player:looseItem', itemId, 1)
        --end
    else
        Chat("This object does nothing")
    end
end

function Toxicated()
	  Citizen.Wait(5000)
	  DoScreenFadeOut(1000)
	  Citizen.Wait(1000)
	  ClearPedTasksImmediately(GetPlayerPed(-1))
	  SetTimecycleModifier("spectator5")
	  SetPedMotionBlur(GetPlayerPed(-1), true)
	  SetPedMovementClipset(GetPlayerPed(-1), "MOVE_M@DRUNK@SLIGHTLYDRUNK", true)
	  SetPedIsDrunk(GetPlayerPed(-1), true)
	  DoScreenFadeIn(1000)
end

function Reality()
  Citizen.Wait(50000)
  DoScreenFadeOut(1000)
  Citizen.Wait(1000)
  DoScreenFadeIn(1000)
  ClearTimecycleModifier()
  ResetScenarioTypesEnabled()
  ResetPedMovementClipset(GetPlayerPed(-1), 0)
  SetPedIsDrunk(GetPlayerPed(-1), false)
  SetPedMotionBlur(GetPlayerPed(-1), false)
end

function GiveMoney()
    local playerNear = getNearPlayer()
    if playerNear then
        DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 30)
        while (UpdateOnscreenKeyboard() == 0) do
            DisableAllControlActions(0);
            Wait(0);
        end
        if (GetOnscreenKeyboardResult()) then
            local res = tonumber(GetOnscreenKeyboardResult())
            if res > 0 then
                TriggerServerEvent("player:swapMoney", res, GetPlayerServerId(playerNear))
            end
        end
    end
end

------------------------- USE SUBMETHODS --------------------------

function eat(item)
    local pid = PlayerPedId()
    RequestAnimDict("mp_player_inteat@burger")
    while (not HasAnimDictLoaded("mp_player_inteat@burger")) do Citizen.Wait(0) end
    TaskPlayAnim(pid, 'mp_player_inteat@burger', 'mp_player_int_eat_burger', 1.0, -1.0, 2000, 0, 1, true, true, true)
    TriggerEvent("player:consumeItem", "feed", 20)
    
end

function drink(item)
    local pid = PlayerPedId()
    RequestAnimDict("amb@world_human_drinking@coffee@male@idle_a")
    while (not HasAnimDictLoaded("amb@world_human_drinking@coffee@male@idle_a")) do Citizen.Wait(0) end
    TaskPlayAnim(pid, 'amb@world_human_drinking@coffee@male@idle_a', 'idle_a', 1.0, -1.0, 2000, 0, 1, true, true, true)
    TriggerEvent("player:consumeItem", "drink", 10)
end

function RepairVehicle()
		Citizen.CreateThread(function()
		local ply = GetPlayerPed(-1)
		local plyCoords = GetEntityCoords(ply, true)
		veh = GetClosestVehicle(plyCoords["x"], plyCoords["y"], plyCoords["z"], 5.001, 0, 70)
	    --TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_VEHICLE_MECHANIC", 0, true)  
        --TaskPlayAnim(GetPlayerPed(-1),"mini@repair","fixing_a_ped", 8.0, 0.0, -1, 1, 0, 0, 0, 0)		
        TaskStartScenarioInPlace(ped, "world_human_vehicle_mechanic", 0, false)
	    Citizen.Wait(15000)
        SetVehicleEngineHealth(veh, 1000.0)
		SetVehicleFixed(veh, 1)
		SetVehicleDeformationFixed(veh, 1)
		SetVehicleUndriveable(veh, 1)    
		ClearPedTasksImmediately(GetPlayerPed(-1))
        SetEntityCoords(ply, plyCoords["x"], plyCoords["y"], plyCoords["z"])
	    ShowNotification("~g~Vehicle is fully Repaired~r~Turn on Engine")
	end)
end

function ShowNotification( text )
    SetNotificationTextEntry( "STRING" )
    AddTextComponentString( text )
    DrawNotification( false, false )
end

------------------------- EXPORTS METHODS -------------------------

function getQuantity(itemId)
    for i, v in pairs(ITEMS) do
        if i == tonumber(itemId) then
            return v.quantity
        end
    end
    return 0
end

function getPods()
    local pods = 0
    for _, v in pairs(ITEMS) do
        pods = pods + v.quantity
    end
    return pods
end

function getWeight()
    local pods = 0
    for _, v in pairs(ITEMS) do
        pods = pods + (v.weight * v.quantity)
    end
    return pods
end

function getWeightPotential(itemsID, qty, weight)
    print(itemsID)
    if((getWeight() + (weight * qty)) <= maxCapacity) then
        return true
    else
        return false
    end
    --return pods
end

function notFull()
    if (getWeight() < maxCapacity) then return true end
end

------------------------- MENU -------------------------

local vehiclesStuff = {}

function PersonnalMenu()
    ped = GetPlayerPed(-1);
    MenuTitle="Menu :"
    ClearMenu()
    Menu.addButton("Inventory", "InventoryMenu", nil)
    Menu.addButton("Animations", "animsMenu", nil)
    Menu.addButton("Car Menu", "carMenu", nil)
    --Menu.addButton("Toggle Lock", "toggleLock", nil)
    Citizen.Trace("Bol1")
end

function carMenu()
    ClearMenu()
    MenuTitle="Vehicle Options :"    
    Menu.addButton("Toggle Lock", "toggleLock", nil)
    Menu.addButton("Toggle Engine", "toggleEngine", nil)
    -- Menu.addButton("Put in Car", "PutInCoffre", itemId)
end

function toggleEngine()
    local ped = GetPlayerPed(-1)
    if(IsPedInAnyVehicle(ped, false)) then
		local veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
        if(GetPedInVehicleSeat(veh, -1) == ped) then
           -- Citizen.Trace(tostring(GetIsVehicleEngineRunning(veh)))
           local plate = GetVehicleNumberPlateText(veh)
           if(vehiclesStuff[plate]) then
                if(vehiclesStuff[plate].running) then
		            SetVehicleEngineOn(veh, false, false)
                    SetVehicleUndriveable(veh, true)
                    vehiclesStuff[plate].running = false
                    Chat("Engine Off")
                else
                    SetVehicleEngineOn(veh, true, false)
                    SetVehicleUndriveable(veh, false)
                    vehiclesStuff[plate].running= true
                    Chat("Engine On")
                end
            else
                vehiclesStuff[plate] = {["running"] = true, ["locked"] = nil}
                toggleEngine()
            end
        else
            Chat("You need to be the driver to do that")
        end
	else
        Chat("You have to be in a car dumb dumb")
    end
end

function toggleLock()
    local pos = GetEntityCoords(GetPlayerPed(-1))
	local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 20.0, 0.0)

	local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
	local _, _, _, _, vehicleHandle = GetRaycastResult(rayHandle)
	if(DoesEntityExist(vehicleHandle)) then
        if(IsEntityAVehicle(vehicleHandle)) then
            TriggerServerEvent("doesOwnLockedCar", GetVehicleNumberPlateText(vehicleHandle), vehicleHandle)
        end
    else
        Chat("Your not looking at a car")
    end
end

RegisterNetEvent("doesOwnLockedCarReturn")
AddEventHandler("doesOwnLockedCarReturn", function(plate, vehicleHandle)
    if(vehiclesStuff[plate]) then
        if(vehiclesStuff[plate].locked) then
            vehiclesStuff[plate].locked = false
            SetVehicleDoorsLockedForAllPlayers(vehicleHandle, false)
            Chat("Car Unlocked")
        else
            vehiclesStuff[plate].locked = true
            SetVehicleDoorsLockedForAllPlayers(vehicleHandle, true)
            Chat("Car Locked")
        end
    else
        vehiclesStuff[plate] = {["running"] = nil, ["locked"] = nil}
        if(vehiclesStuff[plate].locked) then
            vehiclesStuff[plate].locked = false
            SetVehicleDoorsLockedForAllPlayers(vehicleHandle, false)
            Chat("Car Unlocked")
        else
            vehiclesStuff[plate].locked = true
            SetVehicleDoorsLockedForAllPlayers(vehicleHandle, true)
            Chat("Car Locked")
        end
    end
end)

function InventoryMenu()
    if(Menu.hidden == false) then
        ped = GetPlayerPed(-1);
        MenuTitle="Items: " .. (getWeight() or 0) .. "/" .. maxCapacity
        ClearMenu()
        for index,value in pairs(ITEMS) do Citizen.Trace(tostring(index)) end
        for ind, value in pairs(ITEMS) do
            if (value.quantity > 0) then
                Menu.addButton(tostring(value.libelle) .. " : " .. tostring(value.quantity), "ItemMenu", {ind,value.canUse, value.Amount})
            end
        end
    end
end

function ItemMenu(val)
    local itemId = val[1]
    local canUse = val[2]
    local Amount = val[3]
    ClearMenu()
    MenuTitle="Details :"    
    Menu.addButton("Use", "use", {itemId, canUse, Amount})
    Menu.addButton("Give", "give", itemId)
    Menu.addButton("Drop", "drop", itemId)
    -- Menu.addButton("Put in Car", "PutInCoffre", itemId)
end

function PutInCoffre(itemId)
    local vehFront = VehicleInFront()
    if vehFront then
        local qty = DisplayInput()
        if (getQuantity(itemId) - qty >= 0) then
            TriggerServerEvent("car:receiveItem", vehFront, itemId, ITEMS[itemId].libelle, qty)
        end
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(1, 167) then
            TriggerServerEvent("item:getItems")
        end
        if IsControlJustPressed(1, 311) then
            PersonnalMenu() -- Menu to draw
            Menu.hidden = not Menu.hidden -- Hide/Show the menu
        end
        Menu.renderGUI() -- Draw menu on each tick if Menu.hidden = false
        if IsEntityDead(PlayerPedId()) then
            PlayerIsDead()
            -- prevent the death check from overloading the server
            playerdead = true
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(refreshTime)
        if NewItems then
            updateQuantities()
        end
        NewItems = {}
    end
end)

------------------------- GENERAL METHODS -------------------------

function getPlayers()
    local playerList = {}
    for i = 0, 32 do
        local player = GetPlayerFromServerId(i)
        if NetworkIsPlayerActive(player) then
            table.insert(playerList, player)
        end
    end
    return playerList
end

function getNearPlayer()
    local players = getPlayers()
    local pos = GetEntityCoords(GetPlayerPed(-1))
    local pos2
    local distance
    local minDistance = 3
    local playerNear
    for _, player in pairs(players) do
        pos2 = GetEntityCoords(GetPlayerPed(player))
        distance = GetDistanceBetweenCoords(pos["x"], pos["y"], pos["z"], pos2["x"], pos2["y"], pos2["z"], true)
        if (pos ~= pos2 and distance < minDistance) then
            playerNear = player
            minDistance = distance
        end
    end
    if (minDistance < 3) then
        return playerNear
    end
end

function VehicleInFront()
    local pos = GetEntityCoords(GetPlayerPed(-1))
    local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 3.0, 0.0)
    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
    local a, b, c, d, result = GetRaycastResult(rayHandle)
    return GetVehicleNumberPlateText(result)
end

function DisplayInput()
    DisplayOnscreenKeyboard(1, "FMMC_MPM_TYP8", "", "", "", "", "", 30)
    while UpdateOnscreenKeyboard() == 0 do
        DisableAllControlActions(0)
        Wait(1)
    end
    if (GetOnscreenKeyboardResult()) then
        return tonumber(GetOnscreenKeyboardResult())
    end
end

function Chat(debugg)
    TriggerEvent("chatMessage", '', { 0, 0x99, 255 }, tostring(debugg))
end