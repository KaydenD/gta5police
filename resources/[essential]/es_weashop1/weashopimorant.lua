Citizen.Trace("PRE")
--print("test")
local firstspawn = 0
AddEventHandler('playerSpawned', function(spawn)
if firstspawn == 0 then
	ShowWeashopBlips(true)
	Citizen.Trace("WOWO IT SHOULD DO")
	firstspawn = 1
end
--TriggerServerEvent("weaponshop:playerSpawned", spawn)
end)


RegisterNetEvent('giveWeapon')
AddEventHandler('giveWeapon', function(name, delay)
	Citizen.Trace("giveWeapon")
	Citizen.CreateThread(function()          
		    local weapon = GetHashKey(name)
        if(weapon == GetHashKey("WEAPON_BZGAS")) then
          --GiveWeaponToPed(GetPlayerPed(-1), weapon, 1, false)
          GiveWeaponToPed(GetPlayerPed(-1), weapon, 1, 0, false)
        else
          GiveWeaponToPed(GetPlayerPed(-1), weapon, 1000, false)
        end
    end)
end)
Citizen.Trace("Part1")
local weashop = {
  {
    opened = false,
    title = "Weapon store",
    currentmenu = "main",
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
          {title = "Melee weapons", name = "Melee", description = ""},
          {title = "Class 1 Weapons", name = "Pistolets", description = ""},
          --{title = "Class 2 Weapons", name = "MachineGuns", description = ""},
          --{title = "Shotgun", name = "Shotguns", description = ""},
          --{title = "Class 3 Weapons", name = "AssaultRifles", description = ""}
          --{title = "Sniper rifle", name = "SniperRifles", description = ""},
          --{title = "Heavy Weapons", name = "HeavyWeapons", description = ""},
          --{title = "Thrown weapons", name = "ThrownWeapons", description = ""},
        }
      },
      ["Melee"] = {
        title = "Melee weapons",
        name = "Melee",
        buttons = {
          {title = "Knife", name = "Knife", costs = 650, description = {}, model = "WEAPON_Knife", licenselevel = 0},
          --{title = "Metal Detector", name = "Metal Detector", costs = 155000, description = {}, model = "WEAPON_CROWBAR", licenselevel = 0},
          --{title = "Pickaxe", name = "Pickaxe", costs = 10000, description = {}, model = "WEAPON_POOLCUE", licenselevel = 0}
          --{title = "Nightstick", name = "Nightstick", costs = 25000, description = {}, model = "WEAPON_Nightstick"},
          --{title = "Hammer", name = "Hammer", costs = 18000, description = {}, model = "WEAPON_HAMMER"},
          {title = "Bat", name = "Bat", costs = 400, description = {}, model = "WEAPON_Bat", licenselevel = 0},
          --{title = "Crowbar", name = "Crowbar", costs = 30000, description = {}, model = "WEAPON_Crowbar"},
          --{title = "Golfclub", name = "Golfclub", costs = 120000, description = {}, model = "WEAPON_Golfclub"},
          --{title = "Bottle", name = "Bottle", costs = 120000, description = {}, model = "WEAPON_Bottle"},
          {title = "Dagger", name = "Dagger", costs = 650, description = {}, model = "WEAPON_Dagger", licenselevel = 0},
          --{title = "Hatchet", name = "Hatchet", costs = 120000, description = {}, model = "WEAPON_Hatchet"},
          --{title = "KnuckleDuster", name = "KnuckleDuster", costs = 120000, description = {}, model = "WEAPON_KnuckleDuster"},
          --{title = "Machete", name = "Machete", costs = 30000, description = {}, model = "WEAPON_Machete"},
          --{title = "Flashlight", name = "Flashlight", costs = 120000, description = {}, model = "WEAPON_Flashlight"},
          --{title = "SwitchBlade", name = "SwitchBlade", costs = 120000, description = {}, model = "WEAPON_SwitchBlade"},
          --{title = "Poolcue", name = "Poolcue", costs = 120000, description = {}, model = "WEAPON_Poolcue"},
          --{title = "Wrench", name = "Wrench", costs = 120000, description = {}, model = "WEAPON_Wrench"},
          --{title = "Battleaxe", name = "Battleaxe", costs = 120000, description = {}, model = "WEAPON_Battleaxe"},
        }
      },
      ["Pistolets"] = {
        title = "Class 1 Weapons",
        name = "Pistolets",
        buttons = {
          {title = "Beretta M9", name = "Beretta M9", costs = 750, description = {}, model = "WEAPON_Pistol", licenselevel = 1},
          {title = "Glock 17", name = "Glock 17", costs = 1000, description = {}, model = "WEAPON_CombatPistol", licenselevel = 1},
          {title = "Desert eagle", name = "Desert eagle", costs = 8000, description = {}, model = "WEAPON_PISTOL50", licenselevel = 1},
          --{title = "SNS Pistol", name = "SNSPistol", costs = 5000, description = {}, model = "WEAPON_SNSPistol"},
          {title = "FNX .45", name = "FNX .45", costs = 10000, description = {}, model = "WEAPON_HeavyPistol", licenselevel = 1},
          {title = "Colt Defender", name = "Colt Defender", costs = 500, description = {}, model = "WEAPON_VintagePistol", licenselevel = 1},
          --{title = "Marksman Pistol", name = "MarksmanPistol", costs = 2000, description = {}, model = "WEAPON_MarksmanPistol"},
          --{title = "Revolver", name = "Revolver", costs = 1900, description = {}, model = "WEAPON_Revolver"},
          --{title = "AP Pistol", name = "APPistol", costs = 2700, description = {}, model = "WEAPON_APPistol"},
          --{title = "Stun Gun", name = "StunGun", costs = 2800, description = {}, model = "WEAPON_StunGun"},
          --{title = "Flare Gun", name = "FlareGun", costs = 2900, description = {}, model = "WEAPON_FlareGun"},
        }
      },
      ["MachineGuns"] = {
        title = "Class 2 Weapons",
        name = "MachineGuns",
        buttons = {
          {title = "Mossberg 500", name = "Mossberg 500", costs = 15000, description = {}, model = "WEAPON_SawnoffShotgun", licenselevel = 2},
          --{title = "Machine Pistol", name = "MachinePistol", costs = 155000, description = {}, model = "WEAPON_MachinePistol", licenselevel = 2},
          --{title = "SMG", name = "SMG", costs = 25000, description = {}, model = "WEAPON_SMG"},
          --{title = "Assault SMG", name = "AssaultSMG", costs = 18000, description = {}, model = "WEAPON_AssaultSMG"},
          --{title = "Combat PDW", name = "CombatPDW", costs = 85000, description = {}, model = "WEAPON_CombatPDW"},
          --{title = "MG", name = "MG", costs = 30000, description = {}, model = "WEAPON_MG"},
          --{title = "Combat MG", name = "CombatMG", costs = 120000, description = {}, model = "WEAPON_CombatMG"},
          --{title = "Gusenberg", name = "Gusenberg", costs = 120000, description = {}, model = "WEAPON_Gusenberg"},
          --{title = "Mini SMG", name = "MiniSMG", costs = 120000, description = {}, model = "WEAPON_MiniSMG", licenselevel = 2}
        }
      },
      --[[
      ["Shotguns"] = {
        title = "Shotgun",
        name = "Shotguns",
        buttons = {
          -- {title = "Pump Shotgun", name = "PumpShotgun", costs = 150000, description = {}, model = "WEAPON_PumpShotgun"},
          {title = "Sawn-off Shotgun", name = "SawnoffShotgun", costs = 220000, description = {}, model = "WEAPON_SawnoffShotgun"},
          {title = "Bullpup Shotgun", name = "BullpupShotgun", costs = 250000, description = {}, model = "WEAPON_BullpupShotgun"},
          {title = "Assault Shotgun", name = "AssaultShotgun", costs = 280000, description = {}, model = "WEAPON_AssaultShotgun"},
          {title = "Musket", name = "Musket", costs = 850000, description = {}, model = "WEAPON_Musket"},
          {title = "Heavy Shotgun", name = "HeavyShotgun", costs = 35000, description = {}, model = "WEAPON_HeavyShotgun"},
          {title = "Double-Barrel Shotgun", name = "DoubleBarrelShotgun", costs = 400000, description = {}, model = "WEAPON_DoubleBarrelShotgun"},
          {title = "Auto Shotgun", name = "Autoshotgun", costs = 450000, description = {}, model = "WEAPON_Autoshotgun"},
        }
      },
      ]]
      ["AssaultRifles"] = {
        title = "Class 3 Weapons",
        name = "AssaultRifles",
        buttons = {
          --{title = "Assault Rifle", name = "AssaultRifle", costs = 250000, description = {}, model = "WEAPON_AssaultRifle"},
          --{title = "Carbine Rifle", name = "CarbineRifle", costs = 250000, description = {}, model = "WEAPON_CarbineRifle"},
          --{title = "Advanced Rifle", name = "AdvancedRifle", costs = 300000, description = {}, model = "WEAPON_AdvancedRifle"},
          --{title = "Special Carbine", name = "SpecialCarbine", costs = 310000, description = {}, model = "WEAPON_SpecialCarbine"},
          --{title = "Bullpup Rifle", name = "BullpupRifle", costs = 350000, description = {}, model = "WEAPON_BullpupRifle"},
          --{title = "FCompact Rifle", name = "CompactRifle", costs = 400000, description = {}, model = "WEAPON_CompactRifle"},
          {title = "Gusenberg", name = "Gusenberg", costs = 120000, description = {}, model = "WEAPON_Gusenberg", licenselevel = 3},
          {title = "SMG", name = "SMG", costs = 25000, description = {}, model = "WEAPON_SMG", licenselevel = 3},
          {title = "Assault SMG", name = "AssaultSMG", costs = 18000, description = {}, model = "WEAPON_AssaultSMG", licenselevel = 3},
          {title = "Combat PDW", name = "CombatPDW", costs = 85000, description = {}, model = "WEAPON_CombatPDW", licenselevel = 3}

        }
      }
      --[[
      ["SniperRifles"] = {
        title = "Sniper Rifles",
        name = "SniperRifles",
        buttons = {
          {title = "Sniper Rifle", name = "SniperRifle", costs = 500000, description = {}, model = "WEAPON_SniperRifle"},
          {title = "Heavy Sniper", name = "HeavySniper", costs = 800000, description = {}, model = "WEAPON_HeavySniper"},
          {title = "Marksman Rifle", name = "MarksmanRifle", costs = 1000000, description = {}, model = "WEAPON_MarksmanRifle"},
        }
      },
      ["HeavyWeapons"] = {
        title = "Heavy Weapons",
        name = "HeavyWeapons",
        buttons = {
          {title = "Grenade Launcher", name = "GrenadeLauncher", costs = 500000, description = {}, model = "WEAPON_GrenadeLauncher"},
          {title = "RPG", name = "RPG", costs = 800000, description = {}, model = "WEAPON_RPG"},
          {title = "Minigun", name = "Minigun", costs = 1000000, description = {}, model = "WEAPON_Minigun"},
          {title = "Firework", name = "Firework", costs = 1000000, description = {}, model = "WEAPON_Firework"},
          {title = "Railgun", name = "Railgun", costs = 999999999, description = {}, model = "WEAPON_Railgun"},
          {title = "Homing Launcher", name = "HomingLauncher", costs = 1000000, description = {}, model = "WEAPON_HomingLauncher"},
          {title = "Smoke-grenade Launcher", name = "GrenadeLauncherSmoke", costs = 1000000, description = {}, model = "WEAPON_GrenadeLauncherSmoke"},
          {title = "Compact Launcher", name = "CompactLauncher", costs = 1000000, description = {}, model = "WEAPON_CompactLauncher"},
        }
      },
      ["ThrownWeapons"] = {
        title = "Thrown Weapons",
        name = "ThrownWeapons",
        buttons = {
          {title = "Grenade", name = "Grenade", costs = 1500, description = {}, model = "WEAPON_Grenade"},
          {title = "Sticky Bomb", name = "StickyBomb", costs = 15500, description = {}, model = "WEAPON_StickyBomb"},
          {title = "Proximity Mine", name = "ProximityMine", costs = 250000, description = {}, model = "WEAPON_ProximityMine"},
          {title = "BZ Gas", name = "BZGas", costs = 1800, description = {}, model = "WEAPON_BZGas"},
          {title = "Molotov", name = "Molotov", costs = 85000, description = {}, model = "WEAPON_Molotov"},
          {title = "Fire Extinguisher", name = "FireExtinguisher", costs = 3000, description = {}, model = "WEAPON_FireExtinguisher"},
          {title = "Petrol Can", name = "PetrolCan", costs = 120000, description = {}, model = "WEAPON_PetrolCan"},
          {title = "Flare", name = "Flare", costs = 12000, description = {}, model = "WEAPON_Flare"},
          {title = "Ball", name = "Ball", costs = 120, description = {}, model = "WEAPON_Ball"},
          {title = "Snowball", name = "Snowball", costs = 120, description = {}, model = "WEAPON_Snowball"},
          {title = "Smoke Grenade", name = "SmokeGrenade", costs = 12000, description = {}, model = "WEAPON_SmokeGrenade"},
          --{title = "Bombe artisanale", name = "Pipebomb", costs = 3000, description = {}, model = "WEAPON_Pipebomb"},
        }
        ]]
      }
    },
    {
      opened = false,
      title = "Black Market",
      currentmenu = "main",
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
            {title = "Switchblade", name = "Switchblade", costs = 400, description = {}, model = "WEAPON_SWITCHBLADE", licenselevel = 0},
            {title = "Makarov", name = "Makarov", costs = 6500, description = {}, model = "WEAPON_SNSPISTOL", licenselevel = 0},
            {title = "Snubnosed .357", name = "Snubnosed .357", costs = 6500, description = {}, model = "WEAPON_REVOLVER", licenselevel = 0}
          }
        }
      }
    },
    {
    opened = false,
    title = "Platic Store",
    currentmenu = "main",
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
          {title = "Plastic", name = "Plastic", costs = 20000, description = {}, model = "26", licenselevel = 0}
        }
      }
      }
    },
        {
    opened = false,
    title = "Acid Store",
    currentmenu = "main",
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
          {title = "Acid", name = "Acid", costs = 60000, description = {}, model = "27", licenselevel = 0}
        }
      }
      }
    },
    {
    opened = false,
    title = "Cricket Wireless",
    currentmenu = "main",
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
          {title = "Cheap ass phone", name = "Cheap ass phone", costs = 20, description = {}, model = "28", licenselevel = 0}
        }
      }
      }
    },
    {
    opened = false,
    title = "Cabela's Outfitters",
    currentmenu = "main",
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
          {title = "Over Under Shotgun", name = "Over Under Shotgun", costs = 3000, description = {}, model = "WEAPON_DBSHOTGUN", licenselevel = 2},
          --{title = "Marksman Pistol", name = "Marksman Pistol", costs = 1000, description = {}, model = "WEAPON_MARKSMANPISTOL", licenselevel = 1},
          {title = "Remington 870", name = "Remington 870", costs = 5000, description = {}, model = "WEAPON_BullpupShotgun", licenselevel = 2},
          {title = "Remington 700", name = "Remington 700", costs = 35000, description = {}, model = "WEAPON_SniperRifle", licenselevel = 2},
          {title = "Fishing Pole", name = "Fishing Pole", costs = 1000, description = {}, model = "38", licenselevel = 0}
        }
      }
      }
    },
    {
    opened = false,
    title = "Home Depot",
    currentmenu = "main",
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
          {title = "Hammer", name = "Hammer", costs = 1500, description = {}, model = "WEAPON_HAMMER", licenselevel = 0},
          {title = "Pickaxe", name = "Pickaxe", costs = 1000, description = {}, model = "WEAPON_POOLCUE", licenselevel = 0},
          {title = "Metal Detector", name = "Metal Detector", costs = 1500, description = {}, model = "WEAPON_CROWBAR", licenselevel = 0},
          {title = "Bag of Charcoal", name = "Metal Detector", costs = 1500, description = {}, model = "35", licenselevel = 0},
          {title = "Tree Stump Remover", name = "Tree Stump Remover", costs = 1500, description = {}, model = "34", licenselevel = 0},
          {title = "Galvanized Steel Pipe", name = "Galvanized Steel Pipe", costs = 1500, description = {}, model = "36", licenselevel = 0},
          {title = "Sledge Hammer", name = "Sledge Hammer", costs = 1500, description = {}, model = "WEAPON_GOLFCLUB", licenselevel = 0},
        }
      }
      }
    },
    {
      opened = false,
      title = "Black Market",
      currentmenu = "main",
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
            {title = "BZ gas", name = "BZ gas", costs = 500, description = {}, model = "WEAPON_BZGAS", licenselevel = 0}
          }
        }
      }
    }
}
Citizen.Trace("Part2")
local fakeWeapon = ''
local weashop_locations = {
{entering = {74.504,-1971.366,19.788}, inside = {74.504,-1971.366,19.788}, outside = {74.504,-1971.366,19.788}, isBlackMarket = true, shopNumber = 2},
{entering = {20.757692337036, -1107.5169677734, 29.797033309937}, inside = {20.757692337036, -1107.5169677734, 29.797033309937}, outside = {20.757692337036, -1107.5169677734, 29.797033309937}, isBlackMarket = false, shopNumber = 1, blip = 110, markerText = "Weapon Store"},
{entering = {-3171.5866699219, 1086.4406738281, 20.838752746582 }, inside = {-3171.5866699219, 1086.4406738281, 20.838752746582 }, outside = {-3171.5866699219, 1086.4406738281, 20.838752746582 }, isBlackMarket = false, shopNumber = 1, blip = 110, markerText = "Weapon Store"},
{entering = {843.62298583984, -1032.2601318359, 28.194862365723}, inside = {843.62298583984, -1032.2601318359, 28.194862365723}, outside = {843.62298583984, -1032.2601318359, 28.194862365723}, isBlackMarket = false, shopNumber = 1, blip = 110, markerText = "Weapon Store"},
{entering = {811.67248535156, -2155.9697265625, 29.619024276733 }, inside = {811.67248535156, -2155.9697265625, 29.619024276733 }, outside = {811.67248535156, -2155.9697265625, 29.619024276733 }, isBlackMarket = false, shopNumber = 1, blip = 110, markerText = "Weapon Store"},
{entering = {-1306.8151855469, -392.64849853516, 36.695762634277}, inside = {-1306.8151855469, -392.64849853516, 36.695762634277}, outside = {-1306.8151855469, -392.64849853516, 36.695762634277}, isBlackMarket = false, shopNumber = 1, blip = 110, markerText = "Weapon Store"},
{entering = {251.37413024902, -48.727554321289, 69.941055297852}, inside = {251.37413024902, -48.727554321289, 69.941055297852}, outside = {251.37413024902, -48.727554321289, 69.941055297852}, isBlackMarket = false, shopNumber = 1, blip = 110, markerText = "Weapon Store"},
{entering = {1693.3104248047, 3758.0876464844, 34.705299377441 }, inside = {1693.3104248047, 3758.0876464844, 34.705299377441}, outside = {1693.3104248047, 3758.0876464844, 34.705299377441}, isBlackMarket = false, shopNumber = 1, blip = 110, markerText = "Weapon Store"},
{entering = {-663.33032226563, -937.03619384766,21.829216003418  }, inside = {-663.33032226563, -937.03619384766,21.829216003418  }, outside = {-663.33032226563, -937.03619384766,21.829216003418  }, isBlackMarket = false, shopNumber = 1, blip = 110, markerText = "Weapon Store"},
{entering = {-602.55780029297,-1600.0891113281,26.010820388794}, inside = {-602.55780029297,-1600.0891113281,26.010820388794}, outside = {-602.55780029297,-1600.0891113281,26.010820388794}, isBlackMarket = true, shopNumber = 3},
{entering = {473.90646362305,-1311.6633300781,28.206930160522}, inside = {473.90646362305,-1311.6633300781,28.206930160522}, outside = {473.90646362305,-1311.6633300781,28.206930160522}, isBlackMarket = true, shopNumber = 4},
{entering = {49.601188659668,-1453.2890625,28.311950683594}, inside = {49.601188659668,-1453.2890625,28.311950683594}, outside = {49.601188659668,-1453.2890625,28.311950683594}, isBlackMarket = true, shopNumber = 5},
{entering = {2569.4272460938,295.8733215332,107.73474884033}, inside = {2569.4272460938,295.8733215332,107.73474884033}, outside = {2569.4272460938,295.8733215332,107.73474884033}, isBlackMarket = false, shopNumber = 6, blip = 141, markerText = "Cabela's Outfitters"},
{entering = {2749.3283691406,3472.0793457031,54.677284240723}, inside = {2749.3283691406,3472.0793457031,54.677284240723}, outside = {2749.3283691406,3472.0793457031,54.677284240723}, isBlackMarket = false, shopNumber = 7, blip = 446, markerText = "Home Depot"},
{entering = {152.96492004395,-3111.7526855469,4.8963079452515}, inside = {152.96492004395,-3111.7526855469,4.8963079452515}, outside = {152.96492004395,-3111.7526855469,4.8963079452515}, isBlackMarket = true, shopNumber = 8, blip = 110, markerText = "Home Depot"},
}
Citizen.Trace("Part3")
local weashop_blips ={}
local inrangeofweashop = false
local currentlocation = nil
local boughtWeapon = false
local shopinrange = 1

Citizen.Trace("Part4")

RegisterNetEvent("getWeightReturn")
AddEventHandler("getWeightReturn", function(THEITEMS)
  if(exports.vdk_inventory:getWeightPotential(tonumber(fakeWeapon.model), 1, tonumber(THEITEMS))) then
    TriggerServerEvent('CheckMoneyForVdk', fakeWeapon.costs * 1)
  else
    exports.pNotify:SendNotification({text = "Not enough space", type = "error", queue = "left", timeout = 3000, layout = "centerRight"})
  end
end)

local function LocalPed()
return GetPlayerPed(-1)
end
Citizen.Trace("Part5")

function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x , y)
end
Citizen.Trace("Part6")
function IsPlayerInRangeOfweashop()
return inrangeofweashop
end
Citizen.Trace("Part7")
function ShowWeashopBlips(bool)
	Citizen.Trace("WOWO IT SHOULD DO")
	if bool and #weashop_blips == 0 then
		for station,pos in pairs(weashop_locations) do
			local loc = pos
			pos1 = pos.entering
			--Citizen.Trace(pos.isBlackMarket)
			if (pos.isBlackMarket == false) then
			local blip = AddBlipForCoord(pos1[1],pos1[2],pos1[3])
			-- 60 58 137
			SetBlipSprite(blip,pos.blip)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(pos.markerText)
			EndTextCommandSetBlipName(blip)
			SetBlipAsShortRange(blip,true)
			SetBlipAsMissionCreatorBlip(blip,true)
			table.insert(weashop_blips, {hasblip = true, blip = blip, pos = loc})
			else 
				table.insert(weashop_blips, {hasblip = false, pos = loc})
			end
		end
		Citizen.CreateThread(function()
			while #weashop_blips > 0 do
				Citizen.Wait(0)
				local inrange = false
				local shopuihgvdfsa = 1
				for i,b in ipairs(weashop_blips) do
          DrawMarker(1,b.pos.entering[1],b.pos.entering[2],b.pos.entering[3],0,0,0,0,0,0,2.001,2.0001,0.5001,0,155,255,200,0,0,0,0)
					if IsPlayerWantedLevelGreater(GetPlayerIndex(),0) == false and weashop[b.pos.shopNumber].opened == false and IsPedInAnyVehicle(LocalPed(), true) == false and  GetDistanceBetweenCoords(b.pos.entering[1],b.pos.entering[2],b.pos.entering[3],GetEntityCoords(LocalPed())) < 2 then
            if(b.pos.shopNumber == 7) then
              drawTxt('Press ~g~ENTER~s~ to enter ~b~ Home Depot',0,1,0.5,0.8,0.6,255,255,255,255)
            else
						  drawTxt('Press ~g~ENTER~s~ to buy ~b~ Weapons',0,1,0.5,0.8,0.6,255,255,255,255)
            end
						currentlocation = b
						inrange = true
						shopuihgvdfsa = b.pos.shopNumber
					elseif IsPlayerWantedLevelGreater(GetPlayerIndex(),0) == false and weashop[b.pos.shopNumber].opened == true and IsPedInAnyVehicle(LocalPed(), true) == false and  GetDistanceBetweenCoords(b.pos.entering[1],b.pos.entering[2],b.pos.entering[3],GetEntityCoords(LocalPed())) < 2 then
						shopuihgvdfsa = b.pos.shopNumber
					end
				end
				inrangeofweashop = inrange
				shopinrange = shopuihgvdfsa
        --Citizen.Trace(tostring(shopinrange))
			end
		end)
	elseif bool == false and #weashop_blips > 0 then
		for i,b in ipairs(weashop_blips) do
				if DoesBlipExist(b.blip) then
					SetBlipAsMissionCreatorBlip(b.blip,false)
					Citizen.InvokeNative(0x86A652570E5F25DD, Citizen.PointerValueIntInitialized(b.blip))
				end
		end
		weashop_blips = {}
	end
end
Citizen.Trace("Part8")
function f(n)
	return n + 0.0001
end
Citizen.Trace("Part9")
function LocalPed()
	return GetPlayerPed(-1)
end
Citizen.Trace("Part10")
function try(f, catch_f)
	local status, exception = pcall(f)
	if not status then
		catch_f(exception)
	end
end
Citizen.Trace("Part11")
function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end
Citizen.Trace("Part12")
--local veh = nil
function OpenCreator()
	boughtWeapon = false
	local ped = GetPlayerPed(-1)
	local pos = currentlocation.pos.inside
	FreezeEntityPosition(ped,true)
	-- SetEntityVisible(ped,false)
	local g = Citizen.InvokeNative(0xC906A7DAB05C8D2B,pos[1],pos[2],pos[3],Citizen.PointerValueFloat(),0)
	--SetEntityCoords(ped,pos[1],pos[2],g)
	SetEntityHeading(ped,pos[4])
	weashop[shopinrange].currentmenu = "main"
	weashop[shopinrange].opened = true
	weashop[shopinrange].selectedbutton = 0
end
Citizen.Trace("Part13")
function CloseCreator()
	Citizen.CreateThread(function()
		local ped = GetPlayerPed(-1)
		if not boughtWeapon then
			local pos = currentlocation.pos.entering
			--SetEntityCoords(ped,pos[1],pos[2],pos[3])
			FreezeEntityPosition(ped,false)
			-- SetEntityVisible(ped,true)
			weashop[shopinrange].opened = false
			weashop[shopinrange].menu.from = 1
			weashop[shopinrange].menu.to = 10
		else
			Citizen.Trace("bol")
      if(tonumber(fakeWeapon.model)) then
        TriggerEvent("player:receiveItem", tonumber(fakeWeapon.model), 1)
      else
			  local pos = currentlocation.pos.entering
			  local hash = GetHashKey(fakeWeapon.model)
        if(hash == GetHashKey("WEAPON_BZGAS")) then
          --GiveWeaponToPed(ped, hash, 1, 0, false)
          GiveWeaponToPed(GetPlayerPed(-1), hash, 1, 0, false)
          Citizen.Trace("BZ Gas")
        else
			    GiveWeaponToPed(ped, hash, 1000, 0, false)
        end
      end
		end
	end)
end
Citizen.Trace("Part14")
function drawMenuButton(button,x,y,selected)
	local menu = weashop[shopinrange].menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(menu.scale, menu.scale)
	if selected then
		SetTextColour(0, 0, 0, 255)
	else
		SetTextColour(255, 255, 255, 255)
	end
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(button.title)
	if selected then
		DrawRect(x,y,menu.width,menu.height,255,255,255,255)
	else
		DrawRect(x,y,menu.width,menu.height,0,0,0,150)
	end
	DrawText(x - menu.width/2 + 0.005, y - menu.height/2 + 0.0028)
end
Citizen.Trace("Part15")
function drawMenuInfo(text)
	local menu = weashop[shopinrange].menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(0.45, 0.45)
	SetTextColour(255, 255, 255, 255)
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawRect(0.675, 0.95,0.65,0.050,0,0,0,150)
	DrawText(0.365, 0.934)
end
Citizen.Trace("Part16")
function drawMenuRight(txt,x,y,selected)
	local menu = weashop[shopinrange].menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(menu.scale, menu.scale)
	SetTextRightJustify(1)
	if selected then
		SetTextColour(0, 0, 0, 255)
	else
		SetTextColour(255, 255, 255, 255)
	end
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(txt)
	DrawText(x + menu.width/2 - 0.03, y - menu.height/2 + 0.0028)
end
Citizen.Trace("Part17")
function drawMenuTitle(txt,x,y)
local menu = weashop[shopinrange].menu
	SetTextFont(2)
	SetTextProportional(0)
	SetTextScale(0.5, 0.5)
	SetTextColour(255, 255, 255, 255)
	SetTextEntry("STRING")
	AddTextComponentString(txt)
	DrawRect(x,y,menu.width,menu.height,0,0,0,150)
	DrawText(x - menu.width/2 + 0.005, y - menu.height/2 + 0.0028)
end
Citizen.Trace("Part18")
function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end
Citizen.Trace("Part19")
function Notify(text)
SetNotificationTextEntry('STRING')
AddTextComponentString(text)
DrawNotification(false, false)
end
Citizen.Trace("Part20")
function DoesPlayerHaveWeapon(model,button,y,selected, source)
		local t = false
		local hash = GetHashKey(model)
		--t = HAS_PED_GOT_WEAPON(source,hash,false) --Check if player already has selected weapon !!!! THIS DOES NOT WORK !!!!!
		if t then
			drawMenuRight("OWNED",weashop[shopinrange].menu.x,y,selected)
		else
			drawMenuRight("$ " .. button.costs ,weashop[shopinrange].menu.x,y,selected)
		end
end
Citizen.Trace("Part21")
local backlock = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsControlJustPressed(1,201) and IsPlayerInRangeOfweashop() then
			--Citizen.Trace(shopinrange)
			--Citizen.Trace(inrangeofweashop)
			--Citizen.Trace(weashop[shopinrange].opened)
			if weashop[shopinrange].opened then
				CloseCreator()
			else
				OpenCreator()
			end
		end
		if weashop[shopinrange].opened then
			local ped = LocalPed()
			local menu = weashop[shopinrange].menu[weashop[shopinrange].currentmenu]
			drawTxt(weashop[shopinrange].title,1,1,weashop[shopinrange].menu.x,weashop[shopinrange].menu.y,1.0, 255,255,255,255)
			drawMenuTitle(menu.title, weashop[shopinrange].menu.x,weashop[shopinrange].menu.y + 0.08)
			drawTxt(weashop[shopinrange].selectedbutton.."/"..tablelength(menu.buttons),0,0,weashop[shopinrange].menu.x + weashop[shopinrange].menu.width/2 - 0.0385,weashop[shopinrange].menu.y + 0.067,0.4, 255,255,255,255)
			local y = weashop[shopinrange].menu.y + 0.12
			buttoncount = tablelength(menu.buttons)
			local selected = false

			for i,button in pairs(menu.buttons) do
				if i >= weashop[shopinrange].menu.from and i <= weashop[shopinrange].menu.to then

					if i == weashop[shopinrange].selectedbutton then
						selected = true
					else
						selected = false
					end
					drawMenuButton(button,weashop[shopinrange].menu.x,y,selected)
					if button.costs ~= nil then
						DoesPlayerHaveWeapon(button.model,button,y,selected,ped)
					end
					y = y + 0.04
					if selected and IsControlJustPressed(1,201) then
            Citizen.Trace("Part1")
						ButtonSelected(button)
					end
				end
			end
		end
		if weashop[shopinrange].opened then
			if IsControlJustPressed(1,202) then
				Back()
			end
			if IsControlJustReleased(1,202) then
				backlock = false
			end
			if IsControlJustPressed(1,188) then
				if weashop[shopinrange].selectedbutton > 1 then
					weashop[shopinrange].selectedbutton = weashop[shopinrange].selectedbutton -1
					if buttoncount > 10 and weashop[shopinrange].selectedbutton < weashop[shopinrange].menu.from then
						weashop[shopinrange].menu.from = weashop[shopinrange].menu.from -1
						weashop[shopinrange].menu.to = weashop[shopinrange].menu.to - 1
					end
				end
			end
			if IsControlJustPressed(1,187)then
				if weashop[shopinrange].selectedbutton < buttoncount then
					weashop[shopinrange].selectedbutton = weashop[shopinrange].selectedbutton +1
					if buttoncount > 10 and weashop[shopinrange].selectedbutton > weashop[shopinrange].menu.to then
						weashop[shopinrange].menu.to = weashop[shopinrange].menu.to + 1
						weashop[shopinrange].menu.from = weashop[shopinrange].menu.from + 1
					end
				end
			end
		end

	end
end)
Citizen.Trace("Part22")
function round(num, idp)
  if idp and idp>0 then
    local mult = 10^idp
    return math.floor(num * mult + 0.5) / mult
  end
  return math.floor(num + 0.5)
end
Citizen.Trace("Part23")
function ButtonSelected(button)
	local ped = GetPlayerPed(-1)
	local this = weashop[shopinrange].currentmenu
	local btn = button.name
	--if this == "main" then
		if btn == "Melee" then
			OpenMenu('Melee')
		elseif btn == "Pistolets" then
			OpenMenu('Pistolets')
		elseif btn == "MachineGuns" then
			OpenMenu('MachineGuns')
		elseif btn == "Shotguns" then
			OpenMenu('Shotguns')
		elseif btn == "AssaultRifles" then
			OpenMenu('AssaultRifles')
		elseif btn == "SniperRifles" then
			OpenMenu('SniperRifles')
		elseif btn == "HeavyWeapons" then
			OpenMenu('HeavyWeapons')
		elseif btn == "ThrownWeapons" then
			OpenMenu('ThrownWeapons')
		else
      fakeWeapon = button
      if(tonumber(fakeWeapon.model)) then 
        TriggerServerEvent("item:getWeight", tonumber(fakeWeapon.model))
      else
        if(fakeWeapon.model ~= "WEAPON_BZGAS") then
		      TriggerServerEvent('CheckMoneyForWea',button.model,button.costs,button.licenselevel)
          Citizen.Trace("Part2")
        else
          TriggerServerEvent('CheckMoneyForWeaWithotInster',button.model,button.costs,button.licenselevel)
          Citizen.Trace(fakeWeapon.model)
        end
      end
    end
  --[[
	else
		fakeWeapon = button
    if(tonumber(fakeWeapon.model)) then 
      TriggerServerEvent("item:getWeight", tonumber(fakeWeapon.model))
    else
		  TriggerServerEvent('CheckMoneyForWea',button.model,button.costs,button.licenselevel)
      Citizen.Trace("Part2")
    end
	end
  ]]
end
Citizen.Trace("Part24")
RegisterNetEvent('FinishMoneyCheckForWea')
AddEventHandler('FinishMoneyCheckForWea', function()
	Citizen.Trace("Brough and doing asdadf")
	boughtWeapon = true
	CloseCreator()
end)
Citizen.Trace("Part25")
RegisterNetEvent('ToManyWeapons')
AddEventHandler('ToManyWeapons', function()
	boughtWeapon = false
	CloseCreator()
end)
Citizen.Trace("Part27")
function OpenMenu(menu)
	weashop[shopinrange].lastmenu = weashop[shopinrange].currentmenu
	weashop[shopinrange].menu.from = 1
	weashop[shopinrange].menu.to = 10
	weashop[shopinrange].selectedbutton = 0
	weashop[shopinrange].currentmenu = menu
end
Citizen.Trace("Part28")
function Back()
	if backlock then
		return
	end
	backlock = true
	if weashop[shopinrange].currentmenu == "main" then
		boughtWeapon = false
		CloseCreator()
	else
		OpenMenu(weashop[shopinrange].lastmenu)
	end

end
Citizen.Trace("Part29")
function stringstarts(String,Start)
   return string.sub(String,1,string.len(Start))==Start
end
Citizen.Trace("Part30")

