--[[
################################################################
- Creator: Jyben
- Date: 02/05/2017
- Url: https://github.com/Jyben/emergency
- Licence: Apache 2.0
################################################################
--]]

local done = true
RegisterServerEvent('es_em:sendEmergency')
AddEventHandler('es_em:sendEmergency',
  function(reason, playerIDInComa, x, y, z)
    local source3 = source
    TriggerEvent("es:getPlayers", function(players)
      for i,v in pairs(players) do
        TriggerClientEvent('es_em:sendEmergencyToDocs', i, reason, playerIDInComa, x, y, z, source3)
      end
    end)
  end
)

RegisterServerEvent('es_em:getTheCall')
AddEventHandler('es_em:getTheCall',
  function(playerName, playerID, x, y, z, sourcePlayerInComa)
    TriggerEvent("es:getPlayers", function(players)
      for i,v in pairs(players) do
        TriggerClientEvent('es_em:callTaken', i, playerName, playerID, x, y, z, sourcePlayerInComa)
      end
    end)
  end
)

RegisterServerEvent('es_em:sv_resurectPlayer')
AddEventHandler('es_em:sv_resurectPlayer',
  function(sourcePlayerInComa)
    TriggerClientEvent('es_em:cl_resurectPlayer', sourcePlayerInComa)
  end
)

RegisterServerEvent('es_em:sv_getJobId')
AddEventHandler('es_em:sv_getJobId',
  function()
    local source1 = source
    TriggerClientEvent('es_em:cl_setJobId', source, GetJobId(source1))
  end
)

RegisterServerEvent('es_em:sv_getDocConnected')
AddEventHandler('es_em:sv_getDocConnected', function()
  local source2 = source
  local isConnected = false
  local executed_query = MySQL.Sync.fetchScalar("SELECT identifier FROM users WHERE job = 11 AND enService = 1")

  if(executed_query ~= nil) then
    isConnected = true
  end
  print(isConnected)
  TriggerClientEvent('es_em:cl_getDocConnected', source2, isConnected)
end)

AddEventHandler('es:playerDropped', function(user)
  print("Dropped")
  local player = user.getIdentifier()
  print(player)
  local jew = MySQL.Sync.execute("UPDATE users SET enService = 0 WHERE identifier = @identifier", {['@identifier'] = player})
end)

AddEventHandler('es:firstSpawn', function(source) 
  --print("FirstSpawen")
  --local jew = MySQL.Sync.execute("UPDATE users SET enService = 0 and job = 1 WHERE enService = 1 OR job = 11", {['@identifier'] = player})
end)

RegisterServerEvent('es_em:sv_setService')
AddEventHandler('es_em:sv_setService',
  function(service)
    TriggerEvent('es:getPlayerFromId', source,
      function(user)
        local executed_query = MySQL.Sync.execute("UPDATE users SET enService = @service WHERE identifier = @identifier", {['@identifier'] = user.getIdentifier(), ['@service'] = service})
      end
    )
  end
)

RegisterServerEvent('es_em:sv_removeMoney')
AddEventHandler('es_em:sv_removeMoney',
  function()
    TriggerEvent("es:getPlayerFromId", source,
      function(user)
        if(user)then
          if user.getMoney() > 0 then
            user.setMoney(0)
          end
        end
      end
    )
  end
)

RegisterServerEvent('es_em:sv_sendMessageToPlayerInComa')
AddEventHandler('es_em:sv_sendMessageToPlayerInComa',
  function(sourcePlayerInComa)
    print("sendMessageToPlayerInComa")
    TriggerClientEvent('es_em:cl_sendMessageToPlayerInComa', sourcePlayerInComa)
  end
)

AddEventHandler('playerDropped', function()
  TriggerEvent('es:getPlayerFromId', source,
    function(user)
      if(user) then
        local executed_query = MySQL.Sync.execute("UPDATE users SET enService = 0 WHERE identifier = @identifier", {['@identifier'] = user.getIdentifier()})
      end
    end
  )
end)

TriggerEvent('es:addCommand', 'respawn', function(source, args, user)
  TriggerClientEvent('es_em:cl_respawn', source)
end)

function GetJobId(source)
  local jobId = -1

  TriggerEvent('es:getPlayerFromId', source,
    function(user)
      print(user.getIdentifier())
      local executed_query = MySQL.Sync.fetchScalar("SELECT CanBeMedic FROM users WHERE identifier = @identifier", {['@identifier'] = user.getIdentifier()})
      --local result = MySQL:getResults(executed_query, {'job_id'}, "identifier")

      if (executed_query ~= nil) then
        jobId = executed_query
      end
    end
  )

  return jobId
end
