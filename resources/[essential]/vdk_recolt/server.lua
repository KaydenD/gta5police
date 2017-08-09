--egisterServerEvent("jobs:getJobs")
AddEventHandler("es:playerLoaded", function (source)
    TriggerEvent('es:getPlayerFromId', source, function(user)
        MySQL.Async.fetchAll("SELECT price, job_id,harvestRadius,processRadius,sellRadius,ChangeOfExpolde1in1000, minrand, maxrand, isLegal,collectmarkername,processmarkertag ,sellMarkerName, HarvestTime,ProcessTime,weaponToCollect,harvestAnim,harvestItemNeeded,  p4.`weight` AS raw_weight, p5.`weight` AS treated_weight, i1.`id` AS raw_id, i1.`libelle` AS raw_item, i2.`id` AS treat_id, i2.`libelle` AS treat_item, p1.x AS fx, p1.y AS fy, p1.z AS fz, p2.x AS tx, p2.y AS ty, p2.z AS tz, p3.x AS sx, p3.y AS sy, p3.z AS sz FROM recolt LEFT JOIN items i1 ON recolt.`raw_id`=i1.id LEFT JOIN items i2 ON recolt.`treated_id`=i2.id LEFT JOIN coordinates p1 ON recolt.`field_id`=p1.id LEFT JOIN coordinates p2 ON recolt.`treatment_id`=p2.id LEFT JOIN coordinates p3 ON recolt.`seller_id`=p3.id LEFT JOIN items p4 ON recolt.`raw_id`=p4.id LEFT JOIN items p5 ON recolt.`treated_id`=p5.id",{},
        function(result)
            if (result) then
                 MySQL.Async.fetchScalar("SELECT job FROM users WHERE identifier = @identifier", {['@identifier'] = user.getIdentifier()}, function(result1)
                    local toSend = {}
                    for _, item in pairs(result) do
                        if((tonumber(item.job_id) == tonumber(result1)) or (tonumber(item.job_id) == 0)) then
                            table.insert(toSend, item)
                            print(item.raw_id)
                        end
                    end
                    print(toSend[1].raw_item)
                    TriggerClientEvent("cli:getJobs", source, toSend)
                end)
            end
        end)
    end)
end)

RegisterServerEvent("updateWhenJob")
AddEventHandler("updateWhenJob", function (source)
    TriggerEvent('es:getPlayerFromId', source, function(user)
        MySQL.Async.fetchAll("SELECT price, job_id,harvestRadius,processRadius,sellRadius,ChangeOfExpolde1in1000, minrand, maxrand, isLegal,collectmarkername,processmarkertag ,sellMarkerName, HarvestTime,ProcessTime,weaponToCollect,harvestAnim,harvestItemNeeded,  p4.`weight` AS raw_weight, p5.`weight` AS treated_weight, i1.`id` AS raw_id, i1.`libelle` AS raw_item, i2.`id` AS treat_id, i2.`libelle` AS treat_item, p1.x AS fx, p1.y AS fy, p1.z AS fz, p2.x AS tx, p2.y AS ty, p2.z AS tz, p3.x AS sx, p3.y AS sy, p3.z AS sz FROM recolt LEFT JOIN items i1 ON recolt.`raw_id`=i1.id LEFT JOIN items i2 ON recolt.`treated_id`=i2.id LEFT JOIN coordinates p1 ON recolt.`field_id`=p1.id LEFT JOIN coordinates p2 ON recolt.`treatment_id`=p2.id LEFT JOIN coordinates p3 ON recolt.`seller_id`=p3.id LEFT JOIN items p4 ON recolt.`raw_id`=p4.id LEFT JOIN items p5 ON recolt.`treated_id`=p5.id",{},
        function(result)
            if (result) then
                 MySQL.Async.fetchScalar("SELECT job FROM users WHERE identifier = @identifier", {['@identifier'] = user.getIdentifier()}, function(result1)
                    local toSend = {}
                    for _, item in pairs(result) do
                        if((tonumber(item.job_id) == tonumber(result1)) or (tonumber(item.job_id) == 0)) then
                            table.insert(toSend, item)
                            print("InsertFromJob")
                        end
                    end
                    print(toSend[1].raw_item)
                    TriggerClientEvent("cli:getJobs", source, toSend)
                end)
            end
        end)
    end)
end)