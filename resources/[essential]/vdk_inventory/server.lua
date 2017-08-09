

RegisterServerEvent("item:getItems")
RegisterServerEvent("item:getItems1")
RegisterServerEvent("item:getWeight")
RegisterServerEvent("item:updateQuantity")
RegisterServerEvent("item:setItem")
RegisterServerEvent("item:reset")
RegisterServerEvent("item:sell")
RegisterServerEvent("player:giveItem")
RegisterServerEvent("player:swapMoney")
RegisterServerEvent("player:getInfos")

local items = {}
local getQuantityval = 0
AddEventHandler("item:getItems", function()
    TriggerEvent('es:getPlayerFromId', source, function(user) 
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
            user.guiGetItems(items)
        end)
     end)
end)

AddEventHandler("item:getItems1", function(source)
    TriggerEvent('es:getPlayerFromId', source, function(user) 
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
            user.guiGetItems1(items)
        end)
     end)
end)

AddEventHandler("item:getWeight", function(ItemId)
    local source3 = source
    MySQL.Async.fetchScalar("SELECT weight FROM items WHERE id = @ItemId",
    {['@ItemId'] = tonumber(ItemId) },
    function(qItems)
        if(qItems) then
            TriggerClientEvent("getWeightReturn", source3, tonumber(qItems), fakeWeapon) 
        end
    end)
end)

AddEventHandler("item:setItem", function(item, quantity)
    --print(source)
    local source4 = source
    TriggerEvent('es:getPlayerFromId', source4, function(user) 
        local player = user.getIdentifier()    
        print(player)
        MySQL.Async.execute("INSERT INTO user_inventory (`user_id`, `item_id`, `quantity`) VALUES (@player, @item, @qty)",
            {['@player'] = player, ['@item'] = item, ['@qty'] = quantity },
            function(rowsChanged)
            TriggerEvent("item:getItems1", source4)
            print(rowsChanged)
        end)
    end) 
end)

AddEventHandler("item:updateQuantity", function(qty, id)
    TriggerEvent('es:getPlayerFromId', source, function(user)
        local player = user.getIdentifier()
        if(tonumber(qty) ~= 0) then
        MySQL.Async.execute("UPDATE user_inventory SET `quantity` = @qty WHERE `user_id` = @username AND `item_id` = @id",
        { ['@username'] = player, ['@qty'] = tonumber(qty), ['@id'] = tonumber(id) })
        else
        print(qty, id)
        MySQL.Async.execute("DELETE FROM user_inventory WHERE `user_id` = @username AND `item_id` = @id",
        { ['@username'] = player, ['@id'] = tonumber(id) })
        end
    end)
end)

AddEventHandler("item:reset", function()
    local player = getPlayerID(source)
    MySQL.Async.execute("UPDATE user_inventory SET `quantity` = @qty WHERE `user_id` = @username", { ['@username'] = player, ['@qty'] = 0 })
end)

AddEventHandler("item:sell", function(price)
    local done = false
    local source2 = source
    TriggerEvent('es:getPlayerFromId', source2, function(user)
        print("Sell Part4")
        local player = user.getIdentifier()
        if(done == false) then
            --addModeyTest(price, source2)
            TriggerClientEvent("es:addedMoney", source2, tonumber(price), false)
            done = true
        end
    end)
end)
function addModeyTest(amount, source)
    TriggerClientEvent("es:addedMoney", source, tonumber(amount), false)
end
RegisterServerEvent('player:cbgetQuantity')
AddEventHandler("player:cbgetQuantity", function(cbamount)
	getQuantityval = cbamount
end)

AddEventHandler("player:giveItem", function(item, name, qty, target)
    
    TriggerEvent('es:getPlayerFromId', source, function(user)
    TriggerEvent('es:getPlayerFromId', target, function(target1)
    local player = user.getIdentifier()
    local player2 = target1.getIdentifier()
    print(player)
    print(player2)
        --local total = MySQL.Sync.fetchScalar("SELECT SUM(quantity) as total FROM user_inventory WHERE user_id = '@username'", { ['@username'] = player2 })
        target1.getQuantitys()
        print(getQuantityval)
            if (getQuantityval + qty <= 64) then
                --TriggerClientEvent("player:looseItem", source, item, qty)
                user.looseItem(item, qty)
                --TriggerClientEvent("player:receiveItem", target1, item, qty)
                target1.receiveItem(item, qty)
                target1.notify("You have just received " .. qty .. " ".. name)
            end
        end)
    end)
end)



AddEventHandler("player:swapMoney", function(amount, target)
    TriggerEvent('es:getPlayerFromId', source, function(user)
        if user.getMoney() - amount >= 0 then
            user.removeMoney(amount)
            TriggerEvent('es:getPlayerFromId', target, function(user) user.addMoney(amount) end)
        end
    end)
end)

AddEventHandler("player:getInfos", function()
    MySQL.Async.fetchAll("SELECT name, number FROM users WHERE identifier = @player",
    {['@player'] = getPlayerID(source)},
    function(infos)
        nameSplit = stringSplit(infos[1].name, " ")
        local prenom = nameSplit[1]
        local nom = nameSplit[2]
        TriggerClientEvent("player:setInfos", source, prenom, nom, infos[1].number)
    end)
end)

AddEventHandler("player:showIdCard", function(infos, target)
    TriggerClientEvent("player:seeIdCard", target, infos)
end)

-- get's the player id without having to use bugged essentials
function getPlayerID(source)
    TriggerEvent('es:getPlayerFromId', source, function(user) 
        return user.getIdentifier()    
    end) 
end


function stringSplit(self, delimiter)
  local a = self:Split(delimiter)
  local t = {}

  for i = 0, #a - 1 do
     table.insert(t, a[i])
  end

  return t
end