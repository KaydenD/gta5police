CARITEMS = {}
PLAYERITEMS = {}
plateInuse = nil
RegisterNetEvent("car:hoodContent")
AddEventHandler("car:hoodContent", function(items, playeritems)
    if items then
        CARITEMS = items
        PLAYERITEMS = playeritems
        Citizen.Trace("Got to hood this")
        --Citizen.Trace(tostring(CARITEMS['5'].quantity))
        Menu.hidden = not Menu.hidden
        SetVehicleDoorOpen(vehIsuse, 5, false, false)
        plateInuse = GetVehicleNumberPlateText(vehIsuse)
        CoffreMenu()
        MenuWatcher()
    else
        CARITEMS = {}
        vehIsuse = nil
        plateInuse = nil
    end
end)
--[[
AddEventHandler("gui:getItems", function(THEITEMS)
    PLAYERITEMS = {}
    PLAYERITEMS = THEITEMS
    --Citizen.Trace("Bol")
end)
]]
vehIsuse = nil
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        if IsControlJustPressed(1, 182) then
            local vehFront = VehicleInFront()
            if vehFront > 0 then
                if Menu.hidden then
                    ClearMenu()
                    --SetVehicleDoorOpen(vehFront, 5, false, false)
                    TriggerServerEvent("car:getItems", GetVehicleNumberPlateText(vehFront))
                    vehIsuse = vehFront
                else
                    SetVehicleDoorShut(vehFront, 5, false)
                    Menu.hidden = true
                    vehIsuse = nil
                    plateInuse = nil
                end
                --Menu.hidden = not Menu.hidden
            end
        end
        Menu.renderGUI()
    end
end)

function MenuWatcher()
Citizen.CreateThread(function()
    local vehCords = GetEntityCoords(vehIsuse,true)
    local playerPos = GetEntityCoords(GetPlayerPed(-1),true)
    while (Menu.hidden == false) do
        Citizen.Wait(5)
        --vehCords = GetEntityCoords(vehIsuse,true)
        --playerPos = GetEntityCoords(GetPlayerPed(-1),true)
        if(GetDistanceBetweenCoords(GetEntityCoords(vehIsuse), GetEntityCoords(GetPlayerPed(-1))) > 10) then
            Menu.hidden = true
        end        
    end
    SetVehicleDoorShut(vehIsuse, 5, false)
    vehIsuse = nil
    plateInuse = nil
end)
end

function CoffreMenu()
    MenuTitle = "Trunk"
    ClearMenu()
    Menu.addButton("Get Items", "GetItemMenu")
    Menu.addButton("Put in Item", "PutItemMenu")
    Menu.addButton("Close Menu", "CloseMenu")
end

function CloseMenu()
    Menu.hidden = true
end

function getMaxCap(plate)
    if(string.find(plate, "GARB")) then
        return 500
    else
        return 50
    end
end

function GetItemMenu()
    MenuTitle = "Pick Item"
    ClearMenu()
    local totalWeight = 0
    for ind, value in pairs(CARITEMS) do
        if (value.quantity > 0) then
            totalWeight = totalWeight + (tonumber(value.quantity) * tonumber(value.weight))
            Citizen.Trace(tostring(value.quantity))
            Citizen.Trace(tostring(value.weight))
            Menu.addButton(value.libelle .. " : " .. tostring(value.quantity), "GetItem", ind)
        end
    end
    local maxCap = tostring(getMaxCap(plateInuse))
    Menu.addButton("Close Menu", "CloseMenu")
    MenuTitle = tostring(totalWeight) .. "/" .. maxCap .. " space used" 
end

function PutItemMenu()
    MenuTitle = "Choose item"
    ClearMenu()
    for ind, value in pairs(PLAYERITEMS) do
        Citizen.Trace(value.quantity)
        if (tonumber(value.quantity) > 0) then
            Menu.addButton(value.libelle .. " : " .. tostring(value.quantity), "PutItem", ind)
        end
    end
    Menu.addButton("Close Menu", "CloseMenu")
end

function GetItem(id)
    local vehFront = VehicleInFront()
    ClearMenu()
    if vehFront > 0 then
        local qty = DisplayInput()
        if (qty ~= 0 and qty ~= nil) then
            Citizen.Trace(plateInuse)
            if ((exports.vdk_inventory:getWeight() + (qty * CARITEMS[id].weight)) <= 64) then
                TriggerServerEvent("car:looseItem", plateInuse, id, qty)
            else
                exports.pNotify:SendNotification({text = "Not enough space", type = "success", queue = "left", timeout = 3000, layout = "centerRight"})
            end
        end
    end
    Menu.hidden = true
end

function PutItem(id)
    local vehFront = VehicleInFront()
    local item = PLAYERITEMS[id]
    ClearMenu()
    if vehFront > 0 then
        local qty = DisplayInput()
        if (qty ~= 0 and qty ~= nil) then
            Citizen.Trace(plateInuse)
            if(exports.vdk_inventory:getQuantity(id) >= qty) then 
                TriggerServerEvent("car:receiveItem", plateInuse, id, item.libelle, qty, item.weight)
            else 
                exports.pNotify:SendNotification({text = "Not enough items", type = "success", queue = "left", timeout = 3000, layout = "centerRight"})
            end
        end
    end
    Menu.hidden = true
end



function VehicleInFront()
    local pos = GetEntityCoords(GetPlayerPed(-1))
    local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 3.0, 0.0)
    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
    local a, b, c, d, result = GetRaycastResult(rayHandle)
    return result
end

function DisplayInput()
    exports.pNotify:SendNotification({text = "Enter Amount of item to move", type = "success", queue = "left", timeout = 5000, layout = "centerRight"})
    DisplayOnscreenKeyboard(1, "FMMC_MPM_TYP8", "", "", "", "", "", 30)
    while UpdateOnscreenKeyboard() == 0 do
        DisableAllControlActions(0)
        Wait(1)
    end
    if GetOnscreenKeyboardResult() then
        return tonumber(GetOnscreenKeyboardResult())
    else
        return 0
    end
end

function Chat(debugg)
    TriggerEvent("chatMessage", '', { 0, 0x99, 255 }, tostring(debugg))
end