-- Loading MySQL Class

local max_number_weapons = 999 --maximum number of weapons that the player can buy. Weapons given at spawn doesn't count.
local cost_ratio = 100 --Ratio for withdrawing the weapons. This is price/cost_ratio = cost.

RegisterServerEvent('CheckMoneyForWea')
AddEventHandler('CheckMoneyForWea', function(weapon,price,reqlvl)
	TriggerEvent('es:getPlayerFromId', source, function(user)
		print("Got to server")
		if (tonumber(user.getMoney()) >= tonumber(price)) then
			local player = user.getIdentifier()
			local nb_weapon = 0
			MySQL.Async.fetchAll('SELECT * FROM user_weapons WHERE identifier = @username', {['@username'] = player}, function(result)
				if result then
					for k,v in ipairs(result) do
						nb_weapon = nb_weapon + 1
					end
				end
			
			
				print(nb_weapon, player)
				if (tonumber(max_number_weapons) > tonumber(nb_weapon)) then
					local liclvl = 0
					MySQL.Async.fetchAll('SELECT Weplicenselvl FROM users WHERE identifier = @username', {['@username'] = player}, function(result1)
						liclvl = tonumber(result1[1].Weplicenselvl)
						if(liclvl >= reqlvl) then
							user.removeMoney((price))
							if(weapon ~= "WEAPON_BZGAS") then
								MySQL.Async.execute('INSERT INTO user_weapons (identifier,weapon_model) VALUES (@username, @weapon)', {['@username'] = player, ['@weapon'] = weapon}, function(rowsChanged) end)
							end
							-- Trigger some client stuff
							--TriggerClientEvent('FinishMoneyCheckForWea',source)
							user.FinishMoneyCheckForWea()
							-- TriggerClientEvent("giveWeapon", source, weapon , 2000)
							-- TriggerClientEvent("es_freeroam:notify", source, "CHAR_MP_ROBERTO", 1, "Roberto", false, "MURDER TIME. FUN TIME!\n")
							user.notify("heres your gun. HaVe FuN")
						else
							user.notify("You need the Class " .. tostring(reqlvl) .. " To buy this Weapon")
						end
					end)		
				else
				TriggerClientEvent('ToManyWeapons',source)
				-- TriggerClientEvent("es_freeroam:notify", source, "CHAR_MP_ROBERTO", 1, "Roberto", false, "You have reached the weapon limit ! (max: "..max_number_weapons..")\n")
				user.notify("You have reached the weapon limit! (max: "..max_number_weapons..")")
				end
			end)
		else
			-- Inform the player that he needs more money
			-- TriggerClientEvent("es_freeroam:notify", source, "CHAR_MP_ROBERTO", 1, "Roberto", false, "You don't have enough cash !\n")
			user.notify("You don't have enough cash!")

		end		
	end)
end)

RegisterServerEvent('CheckMoneyForWeaWithotInster')
AddEventHandler('CheckMoneyForWeaWithotInster', function(weapon,price,reqlvl)
	TriggerEvent('es:getPlayerFromId', source, function(user)
		print("Got to server")
		if (tonumber(user.getMoney()) >= tonumber(price)) then
			local player = user.getIdentifier()
			local nb_weapon = 0
			MySQL.Async.fetchAll('SELECT * FROM user_weapons WHERE identifier = @username', {['@username'] = player}, function(result)
				if result then
					for k,v in ipairs(result) do
						nb_weapon = nb_weapon + 1
					end
				end
			
			
				print(nb_weapon, player)
				if (tonumber(max_number_weapons) > tonumber(nb_weapon)) then
					local liclvl = 0
					MySQL.Async.fetchAll('SELECT Weplicenselvl FROM users WHERE identifier = @username', {['@username'] = player}, function(result1)
						liclvl = tonumber(result1[1].Weplicenselvl)
						if(liclvl >= reqlvl) then
							user.removeMoney((price))
							--MySQL.Async.execute('INSERT INTO user_weapons (identifier,weapon_model) VALUES (@username, @weapon)', {['@username'] = player, ['@weapon'] = weapon}, function(rowsChanged) end)
							-- Trigger some client stuff
							--TriggerClientEvent('FinishMoneyCheckForWea',source)
							user.FinishMoneyCheckForWea()
							-- TriggerClientEvent("giveWeapon", source, weapon , 2000)
							-- TriggerClientEvent("es_freeroam:notify", source, "CHAR_MP_ROBERTO", 1, "Roberto", false, "MURDER TIME. FUN TIME!\n")
							user.notify("heres your gun. HaVe FuN")
						else
							user.notify("You need the Class " .. tostring(reqlvl) .. " To buy this Weapon")
						end
					end)		
				else
				TriggerClientEvent('ToManyWeapons',source)
				-- TriggerClientEvent("es_freeroam:notify", source, "CHAR_MP_ROBERTO", 1, "Roberto", false, "You have reached the weapon limit ! (max: "..max_number_weapons..")\n")
				user.notify("You have reached the weapon limit! (max: "..max_number_weapons..")")
				end
			end)
		else
			-- Inform the player that he needs more money
			-- TriggerClientEvent("es_freeroam:notify", source, "CHAR_MP_ROBERTO", 1, "Roberto", false, "You don't have enough cash !\n")
			user.notify("You don't have enough cash!")

		end		
	end)
end)

RegisterServerEvent('CheckMoneyForVdk')
AddEventHandler('CheckMoneyForVdk', function(price)
	TriggerEvent('es:getPlayerFromId', source, function(user)
		print("Got to server")
		if (tonumber(user.getMoney()) >= tonumber(price)) then
			local player = user.getIdentifier()
			user.removeMoney(price)
			user.FinishMoneyCheckForWea()
			user.notify("heres your item. HaVe FuN")
		else
			user.notify("You don't have enough cash!")
		end		
	end)
end)

AddEventHandler("es:playerLoaded", function(source)
	TriggerEvent('es:getPlayerFromId', source, function(user)
		-- TriggerEvent('weaponshop:GiveWeaponsToPlayer', source)
	end)
end)

RegisterServerEvent("weaponshop:GiveWeaponsToPlayer")
AddEventHandler("weaponshop:GiveWeaponsToPlayer", function(player)
	TriggerEvent('es:getPlayerFromId', player, function(user)
		local playerID = user.getIdentifier()
		local delay = nil
		print(playerID)
		MySQL.Async.fetchAll('SELECT * FROM user_weapons WHERE identifier = @username', {['@username'] = playerID}, function(result)
			delay = 2000
			if(result)then
				for k,v in ipairs(result) do
						TriggerClientEvent("giveWeapon", player, v.weapon_model, delay)
						print("Gave Weapons")
				end
				-- TriggerClientEvent("es_freeroam:notify", source, "CHAR_MP_ROBERTO", 1, "Roberto", false, "Here are your weapons !\n")
				user.notify("Here are your weapons!")
			end
	
		end)
	end)
end)
