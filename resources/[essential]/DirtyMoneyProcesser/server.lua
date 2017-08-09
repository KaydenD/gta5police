
RegisterServerEvent("blanchisseur:BlanchirCash")
AddEventHandler("blanchisseur:BlanchirCash", function(amount)
	TriggerEvent('es:getPlayerFromId', source, function(user)
			local malt = (math.random(60, 80)) / 100
			print(malt)
			user.addMoney(tonumber(amount) * malt)
			user.notify("Money Cleaned")
	end)
end)