

local vehshop = {{
	opened = false,
	title = "Vehicle Shop",
	currentmenu = "main",
	mainMenu = "main",
	lastmenu = nil,
	currentpos = nil,
	selectedbutton = 0,
	marker = { r = 0, g = 155, b = 255, a = 200, type = 1 },
	menu = {
		x = 0.9,
		y = 0.08,
		width = 0.2,
		height = 0.04,
		buttons = 10,
		from = 1,
		to = 10,
		scale = 0.4,
		font = 0,
		["main"] = { 
			title = "CATEGORIES", 
			name = "main",
			buttons = { 
				{name = "Vehicles", description = ""},
				{name = "Motorcycles", description = ""},
				{name = "Detroit Imports", description = ''},
			}
		},
		["vehicles"] = { 
			title = "VEHICLES", 
			name = "vehicles",
			buttons = { 
				--{name = "Detroit Imports", description = ''},
				{name = "Compacts", description = ''},
				{name = "Coupes", description = ''},
				{name = "Sedans", description = ''},
				{name = "Sports", description = ''},
				{name = "Sports Classics", description = ''},
				--{name = "Super", description = ''},
				{name = "Muscle", description = ''},
				{name = "Off-Road", description = ''},
				{name = "SUVs", description = ''},
				{name = "Vans", description = ''},
				--{name = "Cycles", description = ''},
			}
		},
		["imports"] = { 
			title = "Detroit Imports", 
			name = "imports",
			buttons = { 
				{name = "Custom Vehicles", description = ""},
				{name = "Custom Motorcycles", description = ""},
			}
		},
		["customCars"] = { 
			title = "Detroit Imports Cars", 
			name = "customCars",
			buttons = { 

			}
		},
		["customBikes"] = { 
			title = "Detroit Imports Bikes", 
			name = "customBikes",
			buttons = { 

			}
		},
		["compacts"] = { 
			title = "compacts", 
			name = "compacts",
			buttons = { 

			}
		},
		["coupes"] = { 
			title = "coupes", 
			name = "coupes",
			buttons = { 

			}
		},
		["sports"] = { 
			title = "sports", 
			name = "sports",
			buttons = { 

			}
		},
		["sportsclassics"] = { 
			title = "sports classics", 
			name = "sportsclassics",
			buttons = { 

			}
		},
		["super"] = { 
			title = "super", 
			name = "super",
			buttons = { 

			}
		},
		["muscle"] = { 
			title = "muscle", 
			name = "muscle",
			buttons = { 

			}
		},
		["offroad"] = { 
			title = "off-road", 
			name = "off-road",
			buttons = { 

			}
		},
		["suvs"] = { 
			title = "suvs", 
			name = "suvs",
			buttons = { 

			}
		},
		["vans"] = { 
			title = "vans", 
			name = "vans",
			buttons = { 

			}
		},
		["sedans"] = { 
			title = "sedans", 
			name = "sedans",
			buttons = { 
	
			}
		},
		["motorcycles"] = { 
			title = "MOTORCYCLES", 
			name = "motorcycles",
			buttons = { 

			}
		},
	}
}, 
{
	opened = false,
	title = "Specialty Vehicles Shop",
	currentmenu = "workCars",
	mainMenu = "workCars",
	lastmenu = nil,
	currentpos = nil,
	selectedbutton = 0,
	marker = { r = 0, g = 155, b = 255, a = 200, type = 1 },
	menu = {
		x = 0.9,
		y = 0.08,
		width = 0.2,
		height = 0.04,
		buttons = 10,
		from = 1,
		to = 10,
		scale = 0.4,
		font = 0,
		["workCars"] = { 
			title = "Work Cars", 
			name = "workCars",
			buttons = { 

			}
		}
	}
}, 
}


getQuantityval = 0
loaded = false
local vehlist = {}
AddEventHandler('onMySQLReady', function ()

	MySQL.Async.fetchAll('SELECT * FROM vehicles', {}, function(vehs)
    	for i, car in pairs(vehs) do
			local t = {name = car.name, costs = tonumber(car.price), description = {}, model = car.model, torqeBoost = car.torqeBoost}
			table.insert(vehshop[tonumber(car.shopNum)].menu[car.catergory].buttons, t)
			vehlist[car.model] = t
			print(car.model, car.torqeBoost)
			--vehshop.menu[car.catergory].buttons
			
		end
		loaded = true
	end)
end)

AddEventHandler("es:playerLoaded", function(source)
    local source1 = source
    if(loaded == false) then
		print("error")
    else
        print("Just  Send")
        TriggerClientEvent("vehShopGetVehReturn", source1, vehshop, vehlist)
    end
end)



RegisterServerEvent('CheckMoneyForCar')
AddEventHandler('CheckMoneyForCar', function(model,price)
    local source1 = source
	TriggerEvent('es:getPlayerFromId', source, function(user)
		print("Got to server")
		if (tonumber(user.getMoney()) >= tonumber(price)) then
			local player = user.getIdentifier()
			local nb_weapon = 0
			MySQL.Async.fetchAll('SELECT * FROM user_vehicle WHERE identifier = @username and vehicle_model = @model', {['@username'] = player, ['@model'] = model}, function(result)
				if result then
					for k,v in ipairs(result) do
						nb_weapon = nb_weapon + 1
					end
				end
				print(nb_weapon, player)
				if (tonumber(nb_weapon) == 0) then
					user.removeMoney((price))
					TriggerClientEvent('FinishMoneyCheckForcar', source1)
					--user.FinishMoneyCheckForWea()

		
				else
				user.notify("You already own this car")
				end
			end)
		else
			user.notify("You don't have enough cash!")

		end		
	end)
end)

RegisterServerEvent("CarShopAddTooDB")
AddEventHandler("CarShopAddTooDB", function(model, plate, plateindex, primarycolor, secondarycolor, pearlescentcolor, wheelcolor, neoncolor1, neoncolor2, neoncolor3, windowtint, wheeltype, mods0, mods1, mods2, mods3, mods4, mods5, mods6, mods7, mods8, mods9, mods10, mods11, mods12, mods13, mods14, mods15, mods16, turbo, tiresmoke, xenon, mods23, mods24, neon0, neon1, neon2, neon3, bulletproof, smokecolor1, smokecolor2, smokecolor3, variation)
	local source2 = source
	TriggerEvent('es:getPlayerFromId', source, function(user)
   		MySQL.Async.fetchAll("SELECT * FROM vehicles WHERE model=@model", {['@model'] = model}, function(data)
        	MySQL.Async.execute("INSERT INTO user_vehicle (identifier,vehicle_name,vehicle_model,vehicle_price,vehicle_plate,vehicle_state,playername) VALUES (@username,@name,@vehicle,@price,@plate,@state,@player)",
        	{['@username'] = user.getIdentifier(), ['@name'] = data[1].name, ['@vehicle'] = model, ['@price'] = data[1].price, ['@plate'] = plate, ['@state'] = "Out", ['@player'] = GetPlayerName(source2)}, function(data)
				TriggerClientEvent("FinishDBstuffForcar", source2)
				    MySQL.Async.execute("UPDATE user_vehicle SET vehicle_plateindex=@plateindex, vehicle_colorprimary=@primarycolor, vehicle_colorsecondary=@secondarycolor, vehicle_pearlescentcolor=@pearlescentcolor, vehicle_wheelcolor=@wheelcolor, vehicle_neoncolor1=@neoncolor1, vehicle_neoncolor2=@neoncolor2, vehicle_neoncolor3=@neoncolor3, vehicle_windowtint=@windowtint, vehicle_wheeltype=@wheeltype, vehicle_mods0=@mods0, vehicle_mods1=@mods1, vehicle_mods2=@mods2, vehicle_mods3=@mods3, vehicle_mods4=@mods4, vehicle_mods5=@mods5, vehicle_mods6=@mods6, vehicle_mods7=@mods7, vehicle_mods8=@mods8, vehicle_mods9=@mods9, vehicle_mods10=@mods10, vehicle_mods11=@mods11, vehicle_mods12=@mods12, vehicle_mods13=@mods13, vehicle_mods14=@mods14, vehicle_mods15=@mods15, vehicle_mods16=@mods16, vehicle_turbo=@turbo, vehicle_tiresmoke=@tiresmoke, vehicle_xenon=@xenon, vehicle_mods23=@mods23, vehicle_mods24=@mods24, vehicle_neon0=@neon0, vehicle_neon1=@neon1, vehicle_neon2=@neon2, vehicle_neon3=@neon3, vehicle_bulletproof=@bulletproof, vehicle_smokecolor1=@smokecolor1, vehicle_smokecolor2=@smokecolor2, vehicle_smokecolor3=@smokecolor3, vehicle_modvariation=@variation WHERE identifier=@identifier AND vehicle_plate=@plate",
					{['@identifier'] = user.getIdentifier(), ['@plateindex'] = plateindex, ['@primarycolor'] = primarycolor, ['@secondarycolor'] = secondarycolor, ['@pearlescentcolor'] = pearlescentcolor, ['@wheelcolor'] = wheelcolor, ['@neoncolor1'] = neoncolor1 , ['@neoncolor2'] = neoncolor2, ['@neoncolor3'] = neoncolor3, ['@windowtint'] = windowtint, ['@wheeltype'] = wheeltype, ['@mods0'] = mods0, ['@mods1'] = mods1, ['@mods2'] = mods2, ['@mods3'] = mods3, ['@mods4'] = mods4, ['@mods5'] = mods5, ['@mods6'] = mods6, ['@mods7'] = mods7, ['@mods8'] = mods8, ['@mods9'] = mods9, ['@mods10'] = mods10, ['@mods11'] = mods11, ['@mods12'] = mods12, ['@mods13'] = mods13, ['@mods14'] = mods14, ['@mods15'] = mods15, ['@mods16'] = mods16, ['@turbo'] = turbo, ['@tiresmoke'] = tiresmoke, ['@xenon'] = xenon, ['@mods23'] = mods23, ['@mods24'] = mods24, ['@neon0'] = neon0, ['@neon1'] = neon1, ['@neon2'] = neon2, ['@neon3'] = neon3, ['@bulletproof'] = bulletproof, ['@plate'] = plate, ['@smokecolor1'] = smokecolor1, ['@smokecolor2'] = smokecolor2, ['@smokecolor3'] = smokecolor3, ['@variation'] = variation}, function(data)
						local vehicles = {}
						MySQL.Async.fetchAll("SELECT * FROM user_vehicle WHERE identifier=@identifier",{['@identifier'] =  user.getIdentifier()}, function(data1)
		for _, v in ipairs(data1) do
			t = {
			["id"] = v.id,
			["identifier"] = v.identifier,
			["garage_id"] = v.garage_id,
			["vehicle_name"] = v.vehicle_name,
			["vehicle_model"] = v.vehicle_model,
			["vehicle_price"] = v.vehicle_price,
			["vehicle_plate"] = v.vehicle_plate,
			["vehicle_state"] = v.vehicle_state,
			["vehicle_primarycolor"] = v.vehicle_colorprimary,
			["vehicle_secondarycolor"] = v.vehicle_colorsecondary,
			["vehicle_pearlescentcolor"] = v.vehicle_pearlescentcolor,
			["vehicle_wheelcolor"] = v.vehicle_wheelcolor,
			["vehicle_neoncolor1"] = v.vehicle_neoncolor1,
			["vehicle_neoncolor2"] = v.vehicle_neoncolor2,
			["vehicle_neoncolor3"] = v.vehicle_neoncolor3,
			["vehicle_windowtint"] = v.vehicle_windowtint,
			["vehicle_wheeltype"] = v.vehicle_wheeltype,
			["vehicle_mods0"] = v.vehicle_mods0,
			["vehicle_mods1"] = v.vehicle_mods1,
			["vehicle_mods2"] = v.vehicle_mods2,
			["vehicle_mods3"] = v.vehicle_mods3,
			["vehicle_mods4"] = v.vehicle_mods4,
			["vehicle_mods5"] = v.vehicle_mods5,
			["vehicle_mods6"] = v.vehicle_mods6,
			["vehicle_mods7"] = v.vehicle_mods7,
			["vehicle_mods8"] = v.vehicle_mods8,
			["vehicle_mods9"] = v.vehicle_mods9,
			["vehicle_mods10"] = v.vehicle_mods10,
			["vehicle_mods11"] = v.vehicle_mods11,
			["vehicle_mods12"] = v.vehicle_mods12,
			["vehicle_mods13"] = v.vehicle_mods13,
			["vehicle_mods14"] = v.vehicle_mods14,
			["vehicle_mods15"] = v.vehicle_mods15,
			["vehicle_mods16"] = v.vehicle_mods16,
			["vehicle_turbo"] = v.vehicle_turbo,
			["vehicle_tiresmoke"] = v.vehicle_tiresmoke,
			["vehicle_xenon"] = v.vehicle_xenon,
			["vehicle_mods23"] = v.vehicle_mods23,
			["vehicle_mods24"] = v.vehicle_mods24,
			["vehicle_neon0"] = v.vehicle_neon0,
			["vehicle_neon1"] = v.vehicle_neon1,
			["vehicle_neon2"] = v.vehicle_neon2,
			["vehicle_neon3"] = v.vehicle_neon3,
			["vehicle_bulletproof"] = v.vehicle_bulletproof,
			["vehicle_smokecolor1"] = v.vehicle_smokecolor1,
			["vehicle_smokecolor2"] = v.vehicle_smokecolor2,
			["vehicle_smokecolor3"] = v.vehicle_smokecolor3,
			["vehicle_modvariation"] = v.vehicle_modvariation,
			["insurance"] = v.insurance,
			["instance"] = v.instance
		}

			table.insert(vehicles, t)
		end
		TriggerEvent("car:getCarsFromDb")
		TriggerClientEvent("ply_garages2:getVehicles", source2, vehicles)
	end)

					end)
        	end)		
    	end)
	end)
end)
RegisterServerEvent("carshop:UpdateVeh")
AddEventHandler('carshop:UpdateVeh', function(plate, plateindex, primarycolor, secondarycolor, pearlescentcolor, wheelcolor, neoncolor1, neoncolor2, neoncolor3, windowtint, wheeltype, mods0, mods1, mods2, mods3, mods4, mods5, mods6, mods7, mods8, mods9, mods10, mods11, mods12, mods13, mods14, mods15, mods16, turbo, tiresmoke, xenon, mods23, mods24, neon0, neon1, neon2, neon3, bulletproof, smokecolor1, smokecolor2, smokecolor3, variation)
	TriggerEvent('es:getPlayerFromId', source, function(user)

    end)
end)


