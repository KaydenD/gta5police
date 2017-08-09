RegisterServerEvent('es_slot:sv:1')
AddEventHandler('es_slot:sv:1', function(amount,a,b,c)
	TriggerEvent('es:getPlayerFromId', source, function(user)
		if (tonumber(user.getMoney()) >= tonumber(amount)) then
			user.removeMoney(amount)
			TriggerClientEvent("es_slot:1",source,tonumber(amount),tostring(a),tostring(b),tostring(c))
		else
			TriggerClientEvent('chatMessage', source, "", {0, 0, 200}, "^1Not enough money in wallet!^0")
		end
	end)
end)
RegisterServerEvent('es_slot:sv:2')
AddEventHandler('es_slot:sv:2', function(amount)
	TriggerEvent('es:getPlayerFromId', source, function(user)
		user.addMoney(amount)
	end)
end)

RegisterServerEvent('MoneyCheck')
AddEventHandler('MoneyCheck', function(amount,color)
	TriggerEvent('es:getPlayerFromId', source, function(user)
		if (tonumber(user.getMoney()) >= tonumber(amount)) then
			user.removeMoney(amount)
			TriggerClientEvent("rollFromServer",source, color)
		else
			TriggerClientEvent('chatMessage', source, "", {0, 0, 200}, "^1Not enough money in wallet!^0")
		end
	end)
end)