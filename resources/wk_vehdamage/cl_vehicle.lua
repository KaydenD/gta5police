--[[------------------------------------------------------------------------
    Vehicle Damage Shit
------------------------------------------------------------------------]]--
local levelOfDamageToKillThisBitch = 900.0
local notSent = false

function IsValidVehicle( veh )
    local model = GetEntityModel( veh )

    if ( IsThisModelACar( model ) or IsThisModelABike( model ) or IsThisModelAQuadbike( model ) ) then  
        return true 
    else 
        return false 
    end 
end 

function ManageVehicleDamage()
    local ped = GetPlayerPed( -1 )

    if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then 
        if ( IsPedSittingInAnyVehicle( ped ) ) then 
            local vehicle = GetVehiclePedIsIn( ped, false )

            if ( GetPedInVehicleSeat( vehicle, -1 ) == ped ) then 
                local damage = GetVehicleEngineHealth( vehicle )
                --Citizen.Trace(tostring(damage))
                if ( damage < levelOfDamageToKillThisBitch and IsValidVehicle( vehicle ) and notSent == false) then 
                    SetVehicleEngineHealth( vehicle, 300 )
                    SetVehicleEngineOn( vehicle, false, true )
                    exports.pNotify:SendNotification({text = "Your car is too damaged, Use a repair kit to fix it", type = "success", queue = "left", timeout = 3000, layout = "centerRight"})
                    notSent = true
                elseif (notSent and damage > levelOfDamageToKillThisBitch and IsValidVehicle( vehicle )) then
                    notSent = false
                end 
            end  
        end 
    end 
end 

Citizen.CreateThread( function()
    while true do 
        ManageVehicleDamage()

        Citizen.Wait( 0 )
    end 
end )


--[[------------------------------------------------------------------------
    Vehicle Fix
------------------------------------------------------------------------]]--
--[[
RegisterNetEvent( 'wk:fixVehicle' )
AddEventHandler( 'wk:fixVehicle', function() 
    local ped = GetPlayerPed( -1 )

    if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then 
        if ( IsPedSittingInAnyVehicle( ped ) ) then 
            local vehicle = GetVehiclePedIsIn( ped, false )

            if ( GetPedInVehicleSeat( vehicle, -1 ) == ped ) then 
                SetVehicleEngineHealth( vehicle, 1000 )
                SetVehicleEngineOn( vehicle, true, true )
                SetVehicleFixed( vehicle )
            end  
        end 
    end 
end )
]]