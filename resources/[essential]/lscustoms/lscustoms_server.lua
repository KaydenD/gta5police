local tbl = {
[1] = {locked = false, playerIn = nil},
[2] = {locked = false, playerIn = nil},
[3] = {locked = false, playerIn = nil},
[4] = {locked = false, playerIn = nil}
}
RegisterServerEvent('lockGarage')
AddEventHandler('lockGarage', function(b,garage)
	tbl[tonumber(garage)].locked = b
	if(b == true) then 
		tbl[tonumber(garage)].playerIn = source
	else 
		tbl[tonumber(garage)].playerIn = nil
	end
	TriggerClientEvent('lockGarage',-1,tbl)
	print(json.encode(tbl))
end)
RegisterServerEvent('getGarageInfo')
AddEventHandler('getGarageInfo', function()
TriggerClientEvent('lockGarage',-1,tbl)
print(json.encode(tbl))
end)

AddEventHandler('playerDropped', function()
	for i,garage in ipairs(tbl) do
		if(garage.playerIn == source) then
			garage.playerIn = nil
			garage.locked = false
		end
	end
	print(json.encode(tbl))
	TriggerClientEvent('lockGarage',-1,tbl)
end)