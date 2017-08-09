

RegisterServerEvent('paycheck:salary')
AddEventHandler('paycheck:salary', function()
  	local salary = math.random(50,200)
  	-- local salary = 50 -- FR -- Pour salaire fixe -- EN -- For Fixed salary
	TriggerEvent('es:getPlayerFromId', source, function(user)
  	-- FR -- Ajout de l'argent à l'utilisateur -- EN -- Adding money to the user
  	local user_id = user.getIdentifier()
  	-- FR -- Requête qui permet de recuperer le métier de l'utilisateur -- EN -- Query that retrieves the user's trade
    MySQL.Async.fetchAll("SELECT salary FROM users INNER JOIN jobs ON users.job = jobs.job_id WHERE identifier = @username",{['@username'] = user_id}, function (salary_job)
    	user.addMoney((salary_job[1].salary))
			user.notify("Salary received : ".. (salary_job[1].salary))
    end)
end)
end)
