


RegisterServerEvent("item:sell")


items = {}
getQuantityval = 0
loaded = false
AddEventHandler("es:playerLoaded", function(source)
    local source1 = source
    print("select stuff from ITEMS")
    if(loaded == false) then
        print("select stuff from ITEMS DB")
        MySQL.Async.fetchAll("SELECT * FROM items",
        {},
        function(qItems)
            --print(qItems)
            if (qItems) then
                for index, item in ipairs(qItems) do
                    --print(index)
                    --for index,value in pairs(item) do print(index,value) end
                    t = { ["libelle"] = item.libelle, ["canUse"] = item.canUse, ["weight"] = item.weight, ["sellPrice"] = item.sellPrice }
                    --print(item.item_id)
                    --or index,value in pairs(t) do print(index,value) end
                    --table.insert(items, tonumber(item.item_id), t)
                    items[tonumber(item.id)] = t
                end
                TriggerClientEvent("cli:getJobs", source1, items)
            end
            for index,value in pairs(items) do print(index,value.libelle) end
            --user.guiGetItems(items)
            loaded = true
            
        end)
    else
        print("Just  Send")
        TriggerClientEvent("cli:getJobs", source1, items)
    end
end)

AddEventHandler("item:sell", function(price)
    TriggerEvent('es:getPlayerFromId', source, function(user)
        local player = user.getIdentifier()
        user.addMoney(tonumber(price))
    end)
end)

