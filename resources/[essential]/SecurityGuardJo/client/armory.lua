local buttonsCategories = {}
buttonsCategories[#buttonsCategories+1] = {name = txt[config.lang]["armory_basic_kit"], func = "giveBasicKit"}
buttonsCategories[#buttonsCategories+1] = {name = "Get Coffee and Donuts", func = "giveFoods"}
buttonsCategories[#buttonsCategories+1] = {name = txt[config.lang]["armory_add_bulletproof_vest_title"], func = "addBulletproofVest"}
buttonsCategories[#buttonsCategories+1] = {name = txt[config.lang]["armory_remove_bulletproof_vest_title"], func = "removeBulletproofVest"}

local hashSkin = GetHashKey("mp_m_freemode_01")

function giveFoods()
	TriggerEvent("player:receiveItem", 29, 4, 4)
	TriggerEvent("player:receiveItem", 30, 2, 2)
end

function giveBasicKit()
	GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_STUNGUN"), 200, true, true)
	GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_NIGHTSTICK"), 200, true, true)
	GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_FLASHLIGHT"), 200, true, true)
end

function addBulletproofVest()
	Citizen.CreateThread(function()
		if(config.enableOutfits == true) then
			if(GetEntityModel(GetPlayerPed(-1)) == hashSkin) then
				SetPedComponentVariation(GetPlayerPed(-1), 9, 4, 1, 2)
			else
				SetPedComponentVariation(GetPlayerPed(-1), 9, 6, 1, 2)
			end
		end
		SetPedArmour(GetPlayerPed(-1), 100)
	end)
end

function removeBulletproofVest()
	Citizen.CreateThread(function()
		if(config.enableOutfits == true) then
			SetPedComponentVariation(GetPlayerPed(-1), 9, 0, 1, 2)
		end
		SetPedArmour(GetPlayerPed(-1), 0)
	end)
end

function BackArmory()
	CloseMenu()
	OpenArmory()
end