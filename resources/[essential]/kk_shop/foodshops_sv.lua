RegisterServerEvent('kk:buyLicense')
AddEventHandler('kk:buyLicense', function(fooditem)
		TriggerEvent('es:getPlayerFromId', source, function(user)
			local player = user.getIdentifier()
			local curliclevel = 0
			if(user.getMoney() >= fooditem[2]) then 
				MySQL.Async.fetchAll('SELECT Weplicenselvl FROM users WHERE identifier = @username', {['@username'] = player}, function(result)
					curliclevel = tonumber(result[1].Weplicenselvl)
					print(curliclevel, result[1].Weplicenselvl)
					if (curliclevel < fooditem[1]) then
						user.removeMoney(fooditem[2])
						MySQL.Async.execute('UPDATE users SET Weplicenselvl=@lvl WHERE identifier = @username', {['@username'] = player, ['@lvl'] = fooditem[1]}, function(rowsChanged) end)
						user.notify("You have Bought the Class " .. fooditem[1] .. " Weapon License")
					else
						user.notify("You already have this license")
					end
				end)
			else
				user.notify("You have have enough money to buy this")
			end
		end)
end)