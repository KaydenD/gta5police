

RegisterServerEvent('gabs:menu')
AddEventHandler('gabs:menu', function(fooditem)
		TriggerEvent('es:getPlayerFromId', source, function(user)
			for k,v in ipairs(fooditems) do
				if (v.name == fooditem) then
					if (user.money >= v.price) then
						user:removeMoney(v.price)
						if (v.type == 1) then
							TriggerClientEvent("food:vdrink", source, v.value)
						elseif (v.type == 2) then
							TriggerClientEvent("food:veat", source, v.value)
						end
					else
						TriggerClientEvent('chatMessage', source, "", {0, 0, 200}, "Vous n'avez pas assez d'argent.")
					end
				end
			end
		end)
end)

local getQuantityval = 0
RegisterServerEvent('player:cbgetQuantity')
AddEventHandler("player:cbgetQuantity", function(cbamount, foodItem1, source2)
	local source1 = source
	getQuantityval = cbamount
	if(source2 == source1) then
		TriggerEvent('es:getPlayerFromId', source1, function(user)		
			if (getQuantityval + foodItem1[4] <= 64) then
				if (user.getMoney() >= foodItem1[3]) then
					user.removeMoney(foodItem1[3])
					TriggerClientEvent("player:receiveItem", source1, foodItem1[1], foodItem1[2])
				else
					TriggerClientEvent('chatMessage', source1, "", {0, 0, 200}, "You don't have enough MOOLAH .")
				end
			else
				TriggerClientEvent('chatMessage', source1, "", {0, 0, 200}, "You don't have enough inventory space.")
			end
		end)
	end
end)

RegisterServerEvent('gabs:menuvdk')
AddEventHandler('gabs:menuvdk', function(fooditem)
	TriggerEvent('es:getPlayerFromId', source, function(user)
		local player = user.getIdentifier()
		user.getQuantitys(fooditem, source)
	end)
end)

function splitString(self, delimiter)
	local words = self:Split(delimiter)
	local output = {}
	for i = 0, #words - 1 do
		table.insert(output, words[i])
	end

	return output
end
