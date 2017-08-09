--[[
################################################################
- Creator: Jyben
- Date: 02/05/2017
- Url: https://github.com/Jyben/emergency
- Licence: Apache 2.0
################################################################
--]]


AddEventHandler('onResourceStart', function(resource)
  print("FirstSpawen")
  local jew = MySQL.Sync.execute("UPDATE users SET enService = 0 and job = 1 WHERE enService = 1 OR job = 11", {})
end)