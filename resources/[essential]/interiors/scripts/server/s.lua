AddEventHandler('es:playerLoaded', function(source)
	local source1 = source
	local executed_query = MySQL.Sync.fetchAll("SELECT * FROM interiors")
	local ints = {}
	if executed_query ~= nil then
		for i=1,#executed_query do
			local t = table.pack(executed_query[i].id,json.decode(executed_query[i].enter),json.decode(executed_query[i].exit),executed_query[i].iname)
			table.insert(ints, t)
		end	
	end
	if ints ~= nil then 
		TriggerClientEvent('sendInteriors', source1, ints) 
	end
end)