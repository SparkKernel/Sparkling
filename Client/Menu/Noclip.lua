RegisterNetEvent('Sparkling:ToggleNoclip', function(toggle)
    print("noclip")
end)

RegisterCallback('Repair', function()
    if IsPedInAnyVehicle(PlayerPedId(), true) then
        vehicle = GetVehiclePedIsIn(GetPlayerPed(-1))
        SetEntityAsMissionEntity(vehicle, true, true)
        SetVehicleBodyHealth(vehicle, 9999)
        SetVehicleDirtLevel(GetVehiclePedIsIn(GetPlayerPed(-1),false), 0.0)
        SetVehicleFixed(vehicle)
        return true
    else
        return false
    end
end)