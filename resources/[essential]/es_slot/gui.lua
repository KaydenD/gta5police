-- -- -- -- E 	D 	I 	T -- -- -- --
local EmojiList = {
	'🍎', 
	'🍋', -- don't remove
	'🍉', 
	'🍊', 
	'🍒', -- don't remove
	'🍇', 
	'🍑', 
	'🍓'
}
local price = {}
price.line3 = {
	cherry = 20,
	lemon = 15,
	other = 10
}
price.line2 = {
	cherry = 5,
	other = 2
}


-- Thank you ideo for GUI
Menu = {}
Menu.GUI = {}
Menu.TitleGUI = {}
Menu.buttonCount = 0
Menu.titleCount = 0
Menu.selection = 0
Menu.hidden = true
MenuTitle = "Menu"

-------------------
posXMenu = 0.1
posYMenu = 0.05
width = 0.1
height = 0.05

posXMenuTitle = 0.1
posYMenuTitle = 0.05
widthMenuTitle = 0.1
heightMenuTitle = 0.05
-------------------
function Menu.addTitle(name)
  local yoffset = 0.3
  local xoffset = 0
  local xmin = posXMenuTitle
  local ymin = posYMenuTitle
  local xmax = widthMenuTitle
  local ymax = heightMenuTitle
  Menu.TitleGUI[Menu.titleCount +1] = {}
  Menu.TitleGUI[Menu.titleCount +1]["name"] = name
  Menu.TitleGUI[Menu.titleCount+1]["xmin"] = xmin + xoffset
  Menu.TitleGUI[Menu.titleCount+1]["ymin"] = ymin * (Menu.titleCount + 0.01) +yoffset
  Menu.TitleGUI[Menu.titleCount+1]["xmax"] = xmax 
  Menu.TitleGUI[Menu.titleCount+1]["ymax"] = ymax 
  Menu.titleCount = Menu.titleCount+1
end
function Menu.addButton(name, func,args)
  local yoffset = 0.3
  local xoffset = 0  
  local xmin = posXMenu
  local ymin = posYMenu
  local xmax = width
  local ymax = height
  Menu.GUI[Menu.buttonCount +1] = {}
  Menu.GUI[Menu.buttonCount +1]["name"] = name
  Menu.GUI[Menu.buttonCount+1]["func"] = func
  Menu.GUI[Menu.buttonCount+1]["args"] = args
  Menu.GUI[Menu.buttonCount+1]["active"] = false
  Menu.GUI[Menu.buttonCount+1]["xmin"] = xmin + xoffset
  Menu.GUI[Menu.buttonCount+1]["ymin"] = ymin * (Menu.buttonCount + 0.01) +yoffset
  Menu.GUI[Menu.buttonCount+1]["xmax"] = xmax 
  Menu.GUI[Menu.buttonCount+1]["ymax"] = ymax 
  Menu.buttonCount = Menu.buttonCount+1
end
local input = {["HOME"] = 51,["DOWN"] = 173,["TOP"] = 27,["NENTER"] =  201}
function Menu.updateSelection() 
  if IsControlJustPressed(1, input["DOWN"])  then 
    if(Menu.selection < Menu.buttonCount -1  )then
      Menu.selection = Menu.selection +1
    else
      Menu.selection = 0
    end
  elseif IsControlJustPressed(1, input["TOP"]) then
    if(Menu.selection > 0)then
      Menu.selection = Menu.selection -1
    else
      Menu.selection = Menu.buttonCount-1
    end
  elseif IsControlJustPressed(1, input["NENTER"])  then
      MenuCallFunction(Menu.GUI[Menu.selection +1]["func"], Menu.GUI[Menu.selection +1]["args"])
  end
  local iterator = 0
  for id, settings in ipairs(Menu.GUI) do
    Menu.GUI[id]["active"] = false
    if(iterator == Menu.selection ) then
      Menu.GUI[iterator +1]["active"] = true
    end
    iterator = iterator +1
  end
end
function Menu.renderGUI()
  if not Menu.hidden then
    Menu.renderTitle()
    Menu.renderButtons()
    Menu.updateSelection()
  end
end
function Menu.renderBox(xMin,xMax,yMin,yMax,color1,color2,color3,color4)
  DrawRect(xMin, yMin,xMax, yMax, color1, color2, color3, color4);
end
function drawText(x,y ,width,height,scale, text, r,g,b,a,n)
    SetTextFont(n)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0,0,0,0,255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    --SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.0125)
end
function Menu.renderTitle()
  local yoffset = 0.3
  local xoffset = 0
  local xmin = posXMenuTitle
  local ymin = posYMenuTitle
  local xmax = widthMenuTitle
  local ymax = heightMenuTitle
  for id, settings in pairs(Menu.TitleGUI) do
    local screen_w = 0
    local screen_h = 0
    screen_w, screen_h =  GetScreenResolution(0, 0)
    boxColor = {20,30,10,255}
    SetTextFont(7)
    SetTextScale(0.0,0.5)
    SetTextColour(255, 255, 255, 255)
    SetTextCentre(true)
    SetTextDropShadow(0, 0, 0, 0, 0)
    SetTextEdge(0, 0, 0, 0, 0)
    SetTextEntry("STRING") 
    AddTextComponentString('~y~'..string.upper(settings["name"]))
    DrawText(settings["xmin"], (settings["ymin"] - heightMenuTitle - 0.0125))
    Menu.renderBox(settings["xmin"] ,settings["xmax"], settings["ymin"] - heightMenuTitle, settings["ymax"],boxColor[1],boxColor[2],boxColor[3],boxColor[4])
  end 
end
function Menu.renderButtons()
  for id, settings in pairs(Menu.GUI) do
    local screen_w = 0
    local screen_h = 0
    screen_w, screen_h =  GetScreenResolution(0, 0)
    boxColor = {42,63,17,255}
    if(settings["active"]) then
      boxColor = {107,158,44,255}
    end
    SetTextFont(0)
    SetTextScale(0.0,0.4)
    SetTextColour(255, 255, 255, 255)
    SetTextCentre(true)
    SetTextDropShadow(0, 0, 0, 0, 0)
    SetTextEdge(0, 0, 0, 0, 0)
    SetTextEntry("STRING") 
    AddTextComponentString(settings["name"])
    DrawText(settings["xmin"], (settings["ymin"] - 0.0125 )) 
    Menu.renderBox(settings["xmin"] ,settings["xmax"], settings["ymin"], settings["ymax"],boxColor[1],boxColor[2],boxColor[3],boxColor[4])
   end     
end
--------------------------------------------------------------------------------------------------------------------
function ClearMenu()
  Menu.GUI = {}
  Menu.buttonCount = 0
  Menu.titleCount = 0
  Menu.selection = 0
end

function MenuCallFunction(fnc, arg)
  _G[fnc](arg)
end
--------------------------------------------------------------------------------------------------------------------
-- _Darkz
local money = 100
function SlotMenu()
  ClearMenu()
  Menu.addTitle("Slots")
  Menu.addButton("~h~Spin","Spin",nil)
  Menu.addButton("+","Plus",nil) 
  Menu.addButton("-","Minus",nil) 
end
function csgorollMenu()
  ClearMenu()
  Menu.addTitle("Roulette")
  Menu.addButton("~r~Red","roll",1)
  Menu.addButton("~g~Green","roll",2)
  Menu.addButton("~u~Black","roll",3)
  Menu.addButton("+","Plus",nil) 
  Menu.addButton("-","Minus",nil) 
end
function _NIL()
	return true
end
local rolling = false
function roll(color)
  if(rolling == false) then
    Chat("Rolling", 255,255,255)
    rolling = true
    Citizen.Wait(3000)
    TriggerServerEvent("MoneyCheck", money, color)
    rolling = false
  else
    Chat("Please Wait", 255,255,255)
  end
end

RegisterNetEvent("rollFromServer")
AddEventHandler("rollFromServer", function(color)
  local result = math.random(0,14)
  if(result == 0 and color == 2) then
    TriggerServerEvent("es_slot:sv:2", money*14)
    Chat("You Hit Green +$" ..  tostring(money*14), 0,255,0)
  elseif (result > 0 and result < 8 and color == 1) then
    TriggerServerEvent("es_slot:sv:2", money*2)
    Chat("You Hit Red +$" ..  tostring(money*2), 255,0,0)
  elseif (result > 7 and color == 3) then
    TriggerServerEvent("es_slot:sv:2", money*2)
    Chat("You Hit Black +$" ..  tostring(money*2), 0,0,0)
  else
    Chat("You Landed On " ..  tostring(result) .. ' YOU LOSE', 255,255,255)
  end
end)

function Spin()
	rand1 = EmojiList[math.random(#EmojiList)]
	rand2 = EmojiList[math.random(#EmojiList)]
	rand3 = EmojiList[math.random(#EmojiList)]
	TriggerServerEvent('es_slot:sv:1',money,rand1,rand2,rand3)
end
function Chat(text,r,g,b)
	title = ""
	TriggerEvent("chatMessage", title, { r,g,b}, text)
end
function Plus(a)
	money = money + 100
	return money
end
function Minus(a)
	if money > 100 then
		money = money - 100
		return money
	end
	return money
end
RegisterNetEvent("es_slot:1")
AddEventHandler("es_slot:1", function(MoneyRecive,a,b,c)
	if a == b and a == c then
		if a == '🍒' then
			TriggerServerEvent('es_slot:sv:2',MoneyRecive*price.line3.cherry)
		elseif a == '🍋' then
			TriggerServerEvent('es_slot:sv:2',MoneyRecive*price.line3.lemon)
		else
			TriggerServerEvent('es_slot:sv:2',MoneyRecive*price.line3.other)
		end
		Chat('^2LINE:^0 '..a..' '..b..' '..c)
	elseif a == b or b == c then
		if b =='🍒' then
			TriggerServerEvent('es_slot:sv:2',MoneyRecive*price.line2.cherry)
		else
			TriggerServerEvent('es_slot:sv:2',MoneyRecive*price.line2.other)
		end
		Chat('^2GROUP:^0 '..a..' '..b..' '..c)
	else
		Chat('^1UNLUCKY^0: '..a..' '..b..' '..c)
	end
end)

--------

local twentyfourseven_shops = {
	{ ['x'] = -1676.4453125, ['y'] = -1099.01135253906, ['z'] = 13.1965684890747, ['isSlot'] = false},
}

Citizen.CreateThread(function()
	for k,v in ipairs(twentyfourseven_shops)do
		local blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipSprite(blip, 207)
		SetBlipScale(blip, 0.8)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Casino")
		EndTextCommandSetBlipName(blip)
	end
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local pos = GetEntityCoords(GetPlayerPed(-1), false)
		for k,v in ipairs(twentyfourseven_shops) do
			if(Vdist(v.x, v.y, v.z, pos.x, pos.y, pos.z) < 20.0)then
				DrawMarker(1, v.x, v.y, v.z - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 0, 25, 165, 165, 0,0, 0,0)
				if(Vdist(v.x, v.y, v.z, pos.x, pos.y, pos.z) < 1.0)then
					DisplayHelpText("Press  ~INPUT_CONTEXT~   ~y~To Play")
						if IsControlJustPressed(1,input["HOME"]) then
              if(v.isSlot) then
                         SlotMenu()
                         Menu.hidden = not Menu.hidden
              else
                csgorollMenu()
                Menu.hidden = not Menu.hidden
              end
    end
    if not Menu.hidden then
    	DrawRect(0.1,  0.45,  0.1,  0.05,  0,0,0,255)
    	drawText(0.55,  0.42+0.5, 1.0,1.0,0.6,'~g~$~w~'..tostring(money),255,0,0,255,7)
    end
    Menu.renderGUI()
  end
			end
		end
	end
end)

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
