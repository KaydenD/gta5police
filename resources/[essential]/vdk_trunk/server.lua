

local CARS = {}
local maxCapacity = 50
--[[
AddEventHandler("onMySQLReady", function()
local all_cars = MySQL.Sync.fetchAll("SELECT vehicle_plate AS plate, identifier AS ownerid, items.id AS id, items.libelle AS libelle, items.weight AS weight, quantity FROM user_vehicle LEFT JOIN vehicle_inventory ON `user_vehicle`.`vehicle_plate` = `vehicle_inventory`.`plate` LEFT JOIN items ON `vehicle_inventory`.`item` = `items`.`id`")

for _, v in ipairs(all_cars) do
    CARS[v.plate] = {}
    CARS[v.plate]['owneridentifier'] = v.ownerid
    --print(v.plate)
    if v.id and v.libelle and v.quantity and v.weight then
        --table.insert(CARS[v.plate], v.id, {libelle = v.libelle, quantity = v.quantity, v.weight})
        CARS[v.plate][v.id] = {libelle = v.libelle, quantity = v.quantity, weight = v.weight}
    end
end
end)
]]

AddEventHandler("onMySQLReady", function()
MySQL.Async.fetchAll("SELECT vehicle_plate AS plate, identifier AS ownerid, items.id AS id, items.libelle AS libelle, items.weight AS weight, quantity FROM user_vehicle LEFT JOIN vehicle_inventory ON `user_vehicle`.`vehicle_plate` = `vehicle_inventory`.`plate` LEFT JOIN items ON `vehicle_inventory`.`item` = `items`.`id`",
    {}, 
    function(all_cars) 
        --print(all_cars[1].ownerid)
        for _, v in ipairs(all_cars) do
            if(CARS[v.plate] == nil) then
                CARS[v.plate] = {}
            end
            --CARS[v.plate].owneridentifier = v.ownerid
            --print(CARS[v.plate].owneridentifier)
            --print(v.plate, v.id, v.libelle, v.quantity, v.weight)
            if v.id and v.libelle and v.quantity and v.weight then
                --table.insert(CARS[v.plate], v.id, {libelle = v.libelle, quantity = v.quantity, v.weight})
                print(v.plate, v.id, v.libelle, v.quantity, v.weight)
                CARS[v.plate][v.id] = {libelle = v.libelle, quantity = v.quantity, weight = v.weight, owneridentifier = v.ownerid}
            end
        end

    end)
end)

RegisterServerEvent("car:getCarsFromDb")
AddEventHandler("car:getCarsFromDb", function()
    MySQL.Async.fetchAll("SELECT vehicle_plate AS plate, identifier AS ownerid, items.id AS id, items.libelle AS libelle, items.weight AS weight, quantity FROM user_vehicle LEFT JOIN vehicle_inventory ON `user_vehicle`.`vehicle_plate` = `vehicle_inventory`.`plate` LEFT JOIN items ON `vehicle_inventory`.`item` = `items`.`id`",
    {}, 
    function(all_cars) 
        --print(all_cars[1].ownerid)
        for _, v in ipairs(all_cars) do
            CARS[v.plate] = {}
            --CARS[v.plate].owneridentifier = v.ownerid
            --print(CARS[v.plate].owneridentifier)
            --print(v.plate, v.id, v.libelle, v.quantity, v.weight)
            if v.id and v.libelle and v.quantity and v.weight then
                --table.insert(CARS[v.plate], v.id, {libelle = v.libelle, quantity = v.quantity, v.weight})
                print(v.plate, v.id, v.libelle, v.quantity, v.weight)
                CARS[v.plate][v.id] = {libelle = v.libelle, quantity = v.quantity, weight = v.weight, owneridentifier = v.ownerid}
            end
        end

    end)
end)

RegisterServerEvent("car:getItems")
AddEventHandler("car:getItems", function(plate)
    local res = nil
    local source2 = source
    print(plate)
    if CARS[plate] then
        for index,value in pairs(CARS[plate]) do print(index,value.quantity) end
        res = CARS[plate]
    elseif(IsGarbageTruck(plate)) then
        res = {}
    end
    TriggerEvent('es:getPlayerFromId', source2, function(user) 
    items = {}
    local player = user.getIdentifier(source)
    --print(player)
    -- for i = 0, 23 do
        MySQL.Async.fetchAll("SELECT * FROM user_inventory JOIN items ON `user_inventory`.`item_id` = `items`.`id` WHERE user_id = @username",
        {['@username'] = player },
        function(qItems)
            --print(qItems)
            if (qItems) then
                for index, item in ipairs(qItems) do
                    --print(index)
                    --for index,value in pairs(item) do print(index,value) end
                    t = { ["quantity"] = item.quantity, ["libelle"] = item.libelle, ["canUse"] = item.canUse, ["Amount"] = item.Amount, ["weight"] = item.weight }
                    --print(item.item_id)
                    --or index,value in pairs(t) do print(index,value) end
                    --table.insert(items, tonumber(item.item_id), t)
                    items[tonumber(item.item_id)] = t
                    
                end
            end
            for index,value in pairs(items) do print(index,value) end
            TriggerClientEvent("car:hoodContent", source2, res, items)
            user.guiGetItems(items)
        end)
     end)
    
end)

function getMaxCap(plate)
    if(IsGarbageTruck(plate)) then
        return 500
    else
        return maxCapacity
    end
end

function IsGarbageTruck(plate)
    if(string.find(plate, "GARB")) then
        return true
    else
        return false
    end
end

RegisterServerEvent("car:receiveItem")
AddEventHandler("car:receiveItem", function(plate, item, lib, quantity, weight)
    if not(CARS[plate]) then
        CARS[plate] = {}
    end
    local source1 = source
    print(plate)
    local maxCapacityTemp = getMaxCap(plate)
    if (getWeight(plate) + (weight * quantity) <= maxCapacityTemp) then
        if(IsGarbageTruck(plate)) then
            TriggerEvent('es:getPlayerFromId', source1, function(user)   
                print(item, quantity, plate, lib, weight)
                add({ item, quantity, plate, lib, weight, user.getIdentifier()})
                TriggerClientEvent("player:looseItem", source1, item, quantity)
            end)
        else
            print(item, quantity, plate, lib, weight)
            add({ item, quantity, plate, lib, weight, false})
            TriggerClientEvent("player:looseItem", source1, item, quantity)
        end
    else
        TriggerEvent('es:getPlayerFromId', source1, function(user) 
            user.notify("Not enough space in car. Max space = " .. tostring(maxCapacityTemp))      
        end)
    end
end)


RegisterServerEvent("deleteTrashFromTruck")
AddEventHandler("deleteTrashFromTruck", function(plate)
    if not(CARS[plate]) then
        CARS[plate] = {}
        return
    end
    local cItem = CARS[plate][25]
    local source3 = source
    TriggerEvent('es:getPlayerFromId', source3, function(user) 
        if(IsGarbageTruck(plate)) then
            if (cItem.quantity > 0) then
                print(cItem.quantity)
                user.addMoney(tonumber(cItem.quantity) * 600)
                delete({ 25, cItem.quantity, plate })
                --TriggerClientEvent("player:receiveItem", source3, item, quantity, cItem.weight)
                user.notify("Trash Dumped, GET BACK TO WORK")
            else
                user.notify("No trash to dump")
            end
        else
            user.notify("Not a Garbage Truck")
        end
    end)
end)

RegisterServerEvent("car:looseItem")
AddEventHandler("car:looseItem", function(plate, item, quantity)
    local cItem = CARS[plate][item]
    local source3 = source
    TriggerEvent('es:getPlayerFromId', source3, function(user) 
        if(cItem.owneridentifier == user.getIdentifier()) then
            if (cItem.quantity >= quantity) then
                delete({ item, quantity, plate })
                TriggerClientEvent("player:receiveItem", source3, item, quantity, cItem.weight)
            end
        else
            user.notify("You can't take stuff out of other peoples cars")
        end
    end)
end)

AddEventHandler('BuyForVeh', function(name, vehicle, price, plate, primarycolor, secondarycolor, pearlescentcolor, wheelcolor)
    CARS[plate] = {}
end)

function add(arg)
    local itemId = arg[1]
    local qty = arg[2]
    local plate = arg[3]
    local lib = arg[4]
    local weight = tonumber(arg[5])
    local ownerid = nil
    if(arg[6]) then
        ownerid = arg[6]
        print("BOL use args" .. ownerid)
    else
        ownerid = getOwnerId(plate)
        print("BOL use ID" .. ownerid)
    end
    print("test")
    print(plate)
    print(ownerid)
    local query
    local item
    if CARS[plate][itemId] then
        item = CARS[plate][itemId]
        query = "UPDATE vehicle_inventory SET `quantity` = @qty WHERE `plate` = @plate AND `item` = @item"
        item.quantity = item.quantity + qty
    else
        CARS[plate][itemId] = {quantity = qty, libelle = lib, weight = weight, owneridentifier = ownerid}
        item = CARS[plate][itemId]
        print(CARS[plate][itemId].libelle)
        if(IsGarbageTruck(plate)) then
            query = "INSERT INTO vehicle_inventory (`quantity`,`plate`,`item`, `IsGarb`) VALUES (@qty,@plate,@item, 1)"
        else
            query = "INSERT INTO vehicle_inventory (`quantity`,`plate`,`item`) VALUES (@qty,@plate,@item)"
        end
    end
    MySQL.Async.execute(query,{ ['@plate'] = plate, ['@qty'] = item.quantity, ['@item'] = itemId })
end

function getOwnerId(plate)
    if(IsGarbageTruck(plate)) then
        return false
    else
        return MySQL.Sync.fetchScalar("SELECT identifier FROM user_vehicle WHERE vehicle_plate = @plate",{ ['@plate'] = plate})
    end
end

function delete(arg)
    local itemId = tonumber(arg[1])
    local qty = arg[2]
    local plate = arg[3]
    local item = CARS[plate][itemId]
    local oldqty = item.quantity
    item.quantity = item.quantity - qty
    if(item.quantity ~= 0) then
    MySQL.Async.execute("UPDATE vehicle_inventory SET `quantity` = @qty WHERE `plate` = @plate AND `item` = @item",
    { ['@plate'] = plate, ['@qty'] = item.quantity, ['@item'] = itemId })
    else
    MySQL.Async.execute("DELETE FROM vehicle_inventory WHERE `plate` = @plate AND `item` = @item AND `quantity` = @qty",
    { ['@plate'] = plate, ['@qty'] = oldqty, ['@item'] = itemId })
    CARS[plate][itemId] = nil
    end
end

function getPods(plate)
    local pods = 0
    for _, v in pairs(CARS[plate]) do
        pods = pods + v.quantity
    end
    return pods
end

function getWeight(plate)
    if(CARS[plate]) then
        local pods = 0
        for _, v in pairs(CARS[plate]) do
            pods = pods + (v.weight * v.quantity)
        end
        return pods
    else
        return 0
    end
end

-- get's the player id without having to use bugged essentials
function getPlayerID(source)
    local identifiers = GetPlayerIdentifiers(source)
    local player = getIdentifiant(identifiers)
    return player
end

-- gets the actual player id unique to the player,
-- independent of whether the player changes their screen name
function getIdentifiant(id)
    for _, v in ipairs(id) do
        return v
    end
end

function stringSplit(self, delimiter)
  local a = self:Split(delimiter)
  local t = {}

  for i = 0, #a - 1 do
     table.insert(t, a[i])
  end

  return t
end