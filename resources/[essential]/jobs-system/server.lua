



---------------------------------- FUNCTIONS ----------------------------------

-- Fonction : Récupère le nom du travail
-- Paramètre(s) : id = ID du travail
function nameJob(id)
  return MySQL.Sync.fetchScalar("SELECT job_name FROM jobs WHERE job_id = @namejob", {['@namejob'] = id})
end

-- Fonction : Récupère le travail du joueur
-- Paramètre(s) : player = Identifiant du joueur
function whereIsJob(player)
    MySQL.Async.fetchScalar("SELECT job FROM users WHERE identifier = @identifier", {['@identifier'] = player}, function(res)
      print(res)
      if(res) then
        return tonumber(res)
      else
        return 1
      end
    end)
end

function isInDb(player)
  if MySQL.Sync.fetchScalar("SELECT job FROM users WHERE identifier = @identifier", {['@identifier'] = player}) == nil then
    MySQL.Async.execute("INSERT INTO users (identifier, job) VALUES (@identifier, @value)", {['@value'] = 1, ['@identifier'] = player})
  end 
  return true
end

-- Fonction : Mets à jour le travail du joueur
-- Paramètre(s) : player = Identifiant du joueur, id = ID du travail
function updatejob(player, id, source)
  local job = id
  MySQL.Async.execute("UPDATE users SET `job`=@value WHERE identifier = @identifier", {['@value'] = job, ['@identifier'] = player}, function()
    TriggerEvent("updateWhenJob", source)
  end)
end

function canBeMedic(id)
  return MySQL.Sync.fetchScalar("SELECT CanBeMedic FROM users WHERE identifier = @identifier", {['@identifier'] = id})
end

function canGetJob(id, identifier)
  MySQL.Async.fetchScalar("SELECT whiteListed FROM users WHERE identifier = @identifier", {['@identifier'] = identifier}, function(jew1)
     MySQL.Async.fetchScalar("SELECT Whitelisted FROM jobs WHERE id = @id", {['@id'] = id}, function(jew2)
      if(tonumber(jew1) >= tonumber(jew2)) then
        return true
      else
        return false
      end
    end)
  end)
end
---------------------------------- EVENEMENT ----------------------------------

RegisterServerEvent('jobssystem:jobs')
AddEventHandler('jobssystem:jobs', function(id)
  local source1 = source
  TriggerEvent('es:getPlayerFromId', source1, function(user)
      local player = user.getIdentifier() 
      local test = false
      MySQL.Async.fetchScalar("SELECT whiteListed FROM users WHERE identifier = @identifier", {['@identifier'] = player}, function(jew1)
      MySQL.Async.fetchScalar("SELECT Whitelisted FROM jobs WHERE job_id = @id", {['@id'] = id}, function(jew2)
      if(tonumber(jew1) >= tonumber(jew2)) then
        test = true
      else
        test = false
      end

      if(test) then
        local jobName = nameJob(id)
        updatejob(player, id, source1)
        user.updateJob(jobName)
        -- TriggerClientEvent("es_freeroam:notify", source, "CHAR_MP_STRIPCLUB_PR", 1, "Job", false, "Your Job is now : ".. nameJob)
        user.notify("Your Job is now : ".. jobName)
        print("Test " .. jobName .. " " .. id .. " " .. source)
        TriggerClientEvent("garbageJobsReturn", source1, tonumber(id))
      else
        user.notify("Your not whitelisted for this job")
      end
  end)
  end)
  end)
end)


AddEventHandler('es:playerLoaded', function(source)
  local source2 = source
  TriggerEvent('es:getPlayerFromId', source2, function(user)
      local player = user.getIdentifier() 
      print(player)
      local inthing = isInDb(player)
      local WIJ = 1
      MySQL.Async.fetchScalar("SELECT job FROM users WHERE identifier = @identifier", {['@identifier'] = player}, function(WIJ)
      print(WIJ)
      if(WIJ) then
        WIJ =  tonumber(WIJ)
      end      
      if(WIJ == 7) then
        updatejob(player, 6, source2)
        WIJ = 6 
      end
      if(WIJ == 11) then
        updatejob(player, 10, source2)
        WIJ = 10
      end
      print("Job1", WIJ)
      local jobName = nameJob(WIJ)
      TriggerClientEvent("garbageJobsReturn", source2, tonumber(WIJ))
      TriggerClientEvent("jobssystem:updateJob", source2, jobName)
    end)
    end)
end)

