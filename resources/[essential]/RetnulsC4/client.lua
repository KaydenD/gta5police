local pos = {["x"] = 2676.0375976563, ["y"] = 2791.0534667969, ["z"] = 39.518848419189}


function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function hasGoods()
    local hasPlastic = false
    local hasPhone = false
    local hasAcid = false
    if (exports.vdk_inventory:getQuantity(26) > 0) then
        hasPlastic = true
    end
    if (exports.vdk_inventory:getQuantity(27) > 0) then
        hasAcid = true
    end
    if (exports.vdk_inventory:getQuantity(28) > 0) then
        hasPhone = true
    end
    if (hasPlastic and hasAcid and hasPhone) then
        return true
    else 
        return false
    end
end

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(1)

			local playerPos = GetEntityCoords(GetPlayerPed(-1), true)

			if (Vdist(playerPos.x, playerPos.y, playerPos.z, pos.x, pos.y, pos.z) < 100.0) then
				
				DrawMarker(1, pos.x, pos.y, pos.z, 0, 0, 0, 0, 0, 0, 3.0001, 3.0001, 1.5001, 255, 165, 0,165, 0, 0, 0,0)

				if (Vdist(playerPos.x, playerPos.y, playerPos.z, pos.x, pos.y, pos.z) < 1.5) then
					DisplayHelpText("Press E to manufacture C4")

					if (IsControlJustReleased(1, 51)) then
						if (hasGoods()) then
                            TriggerEvent('player:looseItem', 26, 1)
                            TriggerEvent('player:looseItem', 27, 1)
                            TriggerEvent('player:looseItem', 28, 1)
                            local hash = GetHashKey("WEAPON_STICKYBOMB")
			                GiveWeaponToPed(GetPlayerPed(-1), hash, 1, 0, false)
                            exports.pNotify:SendNotification({text = "This thing's so sticky, better wear gloves.", type = "success", queue = "left", timeout = 3000, layout = "centerRight"})
                        else
                            exports.pNotify:SendNotification({text = "You don't have the goods", type = "success", queue = "left", timeout = 3000, layout = "centerRight"})
                        end
					end
				end
			end
		end
end)


local pos1 = {["x"] = 984.68377685547, ["y"] = -92.148780822754, ["z"] = 73.849830627441}


function hasGoods1()
    local hasPipe = false
    local hasSulfur = false
    local hasTreeRemover = false
    local hasCharcoal = false
    if (exports.vdk_inventory:getQuantity(36) > 0) then
        hasPipe = true
    end
    if (exports.vdk_inventory:getQuantity(33) >= 4) then
        hasSulfur = true
    end
    if (exports.vdk_inventory:getQuantity(35) > 0) then
        hasCharcoal = true
    end
    if (exports.vdk_inventory:getQuantity(34) >= 30) then
        hasTreeRemover = true
    end
    if (hasPipe and hasSulfur and hasTreeRemover and hasCharcoal) then
        return true
    else 
        return false
    end
end

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(1)

			local playerPos = GetEntityCoords(GetPlayerPed(-1), true)

			if (Vdist(playerPos.x, playerPos.y, playerPos.z, pos1.x, pos1.y, pos1.z) < 100.0) then
				
				DrawMarker(1, pos1.x, pos1.y, pos1.z, 0, 0, 0, 0, 0, 0, 3.0001, 3.0001, 1.5001, 255, 165, 0,165, 0, 0, 0,0)

				if (Vdist(playerPos.x, playerPos.y, playerPos.z, pos1.x, pos1.y, pos1.z) < 1.5) then
					DisplayHelpText("Press E to manufacture a pipebomb")

					if (IsControlJustReleased(1, 51)) then
						if (hasGoods1()) then
                            TriggerEvent('player:looseItem', 36, 1)
                            TriggerEvent('player:looseItem', 33, 4)
                            TriggerEvent('player:looseItem', 35, 1)
                            TriggerEvent('player:looseItem', 34, 30)
                            local hash = GetHashKey("WEAPON_PIPEBOMB")
			                GiveWeaponToPed(GetPlayerPed(-1), hash, 1, 0, false)
                            exports.pNotify:SendNotification({text = "Success!", type = "success", queue = "left", timeout = 3000, layout = "centerRight"})
                        else
                            exports.pNotify:SendNotification({text = "You don't have the goods", type = "success", queue = "left", timeout = 3000, layout = "centerRight"})
                        end
					end
				end
			end
		end
end)
