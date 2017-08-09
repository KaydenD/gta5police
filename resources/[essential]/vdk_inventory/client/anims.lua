function animsMenu()
    MenuTitle = "Animations :"
    ClearMenu()
    Menu.addButton("Greetings", "animsSub", "salut")
    Menu.addButton("Mood Animations", "animsSub", "humour")
    Menu.addButton("Job Related", "animsSub", "travail")
    Menu.addButton("Festive", "animsSub", "festives")
    Menu.addButton("Other", "animsSub", "autre")
end

local anims = {
    ["festives"] = {
        {"Dance", "animsAction", { lib = "amb@world_human_partying@female@partying_beer@base", anim = "base" }},
        {"Play music", "animsActionScenario", {anim = "WORLD_HUMAN_MUSICIAN" }},
        {"Drink a beer", "animsActionScenario", { anim = "WORLD_HUMAN_DRINKING" }},
        {"Air Guitar", "animsAction", { lib = "anim@mp_player_intcelebrationfemale@air_guitar", anim = "air_guitar" }},
    },
    ["salut"] = {
        {"Wave", "animsAction", { lib = "gestures@m@standing@casual", anim = "gesture_hello" }},
        {"Shaking hands", "animsAction", { lib = "mp_common", anim = "givetake1_a" }},
        {"High Five", "animsAction", { lib = "mp_ped_interaction", anim = "highfive_guy_a" }},
        {"Salute", "animsAction", { lib = "mp_player_int_uppersalute", anim = "mp_player_int_salute" }},
    },
    ["travail"] = {
        --{"Pêcheur", "animsActionScenario", {anim = "world_human_stand_fishing" }},
        {"Farmer", "animsActionScenario", { anim = "world_human_gardener_plant" }},
        {"Mechanic", "animsActionScenario", { anim = "world_human_vehicle_mechanic" }},
        {"Take Notes", "animsActionScenario", { anim = "WORLD_HUMAN_CLIPBOARD" }},
    },
    ["humour"] = {
        {"Cheer", "animsActionScenario", {anim = "WORLD_HUMAN_CHEERING" }},
        {"Thumbs Up", "animsAction", { lib = "anim@mp_player_intcelebrationmale@thumbs_up", anim = "thumbs_up" }},
        {"Calm down ", "animsAction", { lib = "gestures@m@standing@casual", anim = "gesture_easy_now" }},
        {"Scared", "animsAction", { lib = "amb@code_human_cower_stand@female@idle_a", anim = "idle_c" }},
        {"Shaking Head", "animsAction", { lib = "gestures@m@standing@casual", anim = "gesture_damn" }},
        {"Embrace", "animsAction", { lib = "mp_ped_interaction", anim = "kisses_guy_a" }},
        {"Gesture In", "animsAction", { lib = "mp_player_int_upperfinger", anim = "mp_player_int_finger_01_enter" }},
        {"Wave To Police", "animsAction", { lib = "mp_player_int_upperwank", anim = "mp_player_int_wank_01" }},
        {"Kill yourself", "animsAction", { lib = "mp_suicide", anim = "pistol" }},
    },
    ["autre"] = {
        {"Smoking", "animsActionScenario", { anim = "WORLD_HUMAN_SMOKING" }},
        {"Sit", "animsAction", { lib = "anim@heists@prison_heistunfinished_biztarget_idle", anim = "target_idle" }},
        {"Sit Panic", "animsActionScenario", { anim = "WORLD_HUMAN_PICNIC" }},
        {"Lean", "animsActionScenario", { anim = "world_human_leaning" }},
        {"Mexican Clean", "animsActionScenario", { anim = "world_human_maid_clean" }},
        {"Bribe Police", "animsAction", { lib = "mini@prostitutes@sexlow_veh", anim = "low_car_bj_to_prop_female" }},
        {"Grab Dick", "animsAction", { lib = "mp_player_int_uppergrab_crotch", anim = "mp_player_int_grab_crotch" }},
        {"Selfie", "animsActionScenario", { anim = "world_human_tourist_mobile" }},
    }
}

function animsSub(cat)
    ClearMenu()
	for _, v in pairs(anims[cat]) do
        Menu.addButton(v[1] , v[2], v[3])
    end
end

function animsAction(animObj)
    RequestAnimDict(animObj.lib)
    while not HasAnimDictLoaded(animObj.lib) do
        Citizen.Wait(0)
    end
    if HasAnimDictLoaded(animObj.lib) then
        TaskPlayAnim(GetPlayerPed(-1), animObj.lib , animObj.anim ,8.0, -8.0, -1, 0, 0, false, false, false)
    end
end

function animsActionScenario(animObj)
    local ped = GetPlayerPed(-1);

    if ped then
        local pos = GetEntityCoords(ped);
        local head = GetEntityHeading(ped);
        --TaskStartScenarioAtPosition(ped, animObj.anim, pos['x'], pos['y'], pos['z'] - 1, head, -1, false, false);
        TaskStartScenarioInPlace(ped, animObj.anim, 0, false)
        if IsControlJustPressed(1,188) then
        
        end
        Citizen.CreateThread(function()
            while IsPedUsingAnyScenario(ped) do
                Citizen.Wait(5)
                if IsPedUsingAnyScenario(ped) then
                    if IsControlJustPressed(1, 34) or IsControlJustPressed(1, 32) or IsControlJustPressed(1, 8) or IsControlJustPressed(1, 9) then
                        ClearPedTasks(ped)
                    end
                end
            end
        end)
    end
end