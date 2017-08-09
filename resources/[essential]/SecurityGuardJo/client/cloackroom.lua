local buttons = {}
buttons[#buttons+1] = {name = txt[config.lang]["cloackroom_take_service_normal_title"], func = "clockIn_Uniformed"}
buttons[#buttons+1] = {name = "Clock in as Security Guard 1", func = "clockIn_Uniformed1"}
buttons[#buttons+1] = {name = "Clock in as Security Guard 2", func = "clockIn_Uniformed2"}
buttons[#buttons+1] = {name = "Clock in as Security Guard 3", func = "clockIn_Uniformed3"}
buttons[#buttons+1] = {name = "Clock in as Security Guard 4", func = "clockIn_Uniformed4"}
buttons[#buttons+1] = {name = "Clock in as Security Guard 5", func = "clockIn_Uniformed5"}
buttons[#buttons+1] = {name = "Clock in as Security Guard 6", func = "clockIn_Uniformed6"}
buttons[#buttons+1] = {name = "Clock in as Security Guard 7", func = "clockIn_Uniformed7"}


if(config.enableOutfits == true) then
	buttons[#buttons+1] = {name = txt[config.lang]["cloackroom_add_yellow_vest_title"], func = "cloackroom_add_yellow_vest"}
	buttons[#buttons+1] = {name = txt[config.lang]["cloackroom_remove_yellow_vest_title"], func = "cloackroom_rem_yellow_vest"}
end

local hashSkin = GetHashKey("mp_m_freemode_01")

function clockIn_Uniformed1()
	-- Citizen.Trace("BOL3")
	ServiceOn()
	giveUniforme("IG_ProlSec_02")
	drawNotification(txt[config.lang]["now_in_service_notification"])
	drawNotification(txt[config.lang]["help_open_menu_notification"])
end

function clockIn_Uniformed2()
	-- Citizen.Trace("BOL3")
	ServiceOn()
	giveUniforme("U_M_M_ProlSec_01")
	drawNotification(txt[config.lang]["now_in_service_notification"])
	drawNotification(txt[config.lang]["help_open_menu_notification"])
end

function clockIn_Uniformed3()
	-- Citizen.Trace("BOL3")
	ServiceOn()
	giveUniforme("S_M_M_Security_01")
	drawNotification(txt[config.lang]["now_in_service_notification"])
	drawNotification(txt[config.lang]["help_open_menu_notification"])
end

function clockIn_Uniformed4()
	-- Citizen.Trace("BOL3")
	ServiceOn()
	giveUniforme("U_M_M_JewelSec_01")
	drawNotification(txt[config.lang]["now_in_service_notification"])
	drawNotification(txt[config.lang]["help_open_menu_notification"])
end

function clockIn_Uniformed5()
	-- Citizen.Trace("BOL3")
	ServiceOn()
	giveUniforme("S_M_Y_DevinSec_01")
	drawNotification(txt[config.lang]["now_in_service_notification"])
	drawNotification(txt[config.lang]["help_open_menu_notification"])
end

function clockIn_Uniformed6()
	-- Citizen.Trace("BOL3")
	ServiceOn()
	giveUniforme("S_M_M_HighSec_01")
	drawNotification(txt[config.lang]["now_in_service_notification"])
	drawNotification(txt[config.lang]["help_open_menu_notification"])
end

function clockIn_Uniformed7()
	-- Citizen.Trace("BOL3")
	ServiceOn()
	giveUniforme("S_M_M_HighSec_02")
	drawNotification(txt[config.lang]["now_in_service_notification"])
	drawNotification(txt[config.lang]["help_open_menu_notification"])
end


function clockOut()
	ServiceOff()
	removeUniforme()
	drawNotification(txt[config.lang]["break_service_notification"])
end

function cloackroom_add_yellow_vest()
	Citizen.CreateThread(function()
		if(GetEntityModel(GetPlayerPed(-1)) == hashSkin) then
			SetPedComponentVariation(GetPlayerPed(-1), 8, 59, 0, 2)
		else
			SetPedComponentVariation(GetPlayerPed(-1), 8, 36, 0, 2)
		end
	end)
end

function cloackroom_rem_yellow_vest()
	Citizen.CreateThread(function()
		if(GetEntityModel(GetPlayerPed(-1)) == hashSkin) then
			SetPedComponentVariation(GetPlayerPed(-1), 8, 58, 0, 2)
		else
			SetPedComponentVariation(GetPlayerPed(-1), 8, 35, 0, 2)
		end
	end)
end

function giveUniforme(thigs)
	Citizen.CreateThread(function()
		if(config.enableOutfits == true) then
			if(GetEntityModel(GetPlayerPed(-1)) == hashSkin) then

				SetPedPropIndex(GetPlayerPed(-1), 1, 5, 0, 2)             --Sunglasses
				SetPedPropIndex(GetPlayerPed(-1), 2, 0, 0, 2)             --Bluetoothn earphone
				SetPedComponentVariation(GetPlayerPed(-1), 11, 55, 0, 2)  --Shirt
				SetPedComponentVariation(GetPlayerPed(-1), 8, 58, 0, 2)   --Nightstick decoration
				SetPedComponentVariation(GetPlayerPed(-1), 4, 35, 0, 2)   --Pants
				SetPedComponentVariation(GetPlayerPed(-1), 6, 24, 0, 2)   --Shooes
				SetPedComponentVariation(GetPlayerPed(-1), 10, 8, 0, 2)   --rank
				
			else

				SetPedPropIndex(GetPlayerPed(-1), 1, 11, 3, 2)           --Sunglasses
				SetPedPropIndex(GetPlayerPed(-1), 2, 0, 0, 2)            --Bluetoothn earphone
				SetPedComponentVariation(GetPlayerPed(-1), 3, 14, 0, 2)  --Non buggy tshirt
				SetPedComponentVariation(GetPlayerPed(-1), 11, 48, 0, 2) --Shirt
				SetPedComponentVariation(GetPlayerPed(-1), 8, 35, 0, 2)  --Nightstick decoration
				SetPedComponentVariation(GetPlayerPed(-1), 4, 34, 0, 2)  --Pants
				SetPedComponentVariation(GetPlayerPed(-1), 6, 29, 0, 2)  --Shooes
				SetPedComponentVariation(GetPlayerPed(-1), 10, 7, 0, 2)  --rank
			
			end
		else
			local model = GetHashKey(thigs)

			RequestModel(model)
			while not HasModelLoaded(model) do
				RequestModel(model)
				Citizen.Wait(0)
			end
		 
			SetPlayerModel(PlayerId(), model)			
			SetModelAsNoLongerNeeded(model)
			SetPedRandomComponentVariation(GetPlayerPed(-1), false)
			SetPedRandomProps(GetPlayerPed(-1))
		end
		
		RemoveAllPedWeapons(GetPlayerPed(-1), true)
	end)
end

function giveInterventionUniforme()
	Citizen.CreateThread(function()
		
		local model = GetHashKey("s_m_y_swat_01")

		RequestModel(model)
		while not HasModelLoaded(model) do
			RequestModel(model)
			Citizen.Wait(0)
		end
	 
		SetPlayerModel(PlayerId(), model)
		SetModelAsNoLongerNeeded(model)
		SetPedRandomComponentVariation(GetPlayerPed(-1), false)
		SetPedRandomProps(GetPlayerPed(-1))
		RemoveAllPedWeapons(GetPlayerPed(-1), true)
	end)
end

function removeUniforme()
	Citizen.CreateThread(function()
		if(config.enableOutfits == true) then
			RemoveAllPedWeapons(GetPlayerPed(-1))
			TriggerServerEvent("skin_customization:SpawnPlayer")
		else
			local model = GetHashKey("a_m_y_mexthug_01")

			RequestModel(model)
			while not HasModelLoaded(model) do
				RequestModel(model)
				Citizen.Wait(0)
			end
		 
			SetPlayerModel(PlayerId(), model)
			SetModelAsNoLongerNeeded(model)
			RemoveAllPedWeapons(GetPlayerPed(-1))
			TriggerServerEvent("mm:spawn")			
		end
	end)
end

function OpenCloackroom()
	if(anyMenuOpen.menuName ~= "cloackroom" and not anyMenuOpen.isActive) then
		SendNUIMessage({
			title = txt[config.lang]["cloackroom_global_title"],
			buttons = buttons,
			action = "setAndOpen"
		})
		
		anyMenuOpen.menuName = "cloackroom"
		anyMenuOpen.isActive = true
	end
end