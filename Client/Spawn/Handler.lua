
local ped = GetPlayerPed(-1)
RegisterNetEvent('Sparkling:SpawnHandler', function(t, args)
    print(t,args.health)
    if t == 'health' then
        SetEntityHealth(ped, args.health)
    end
end)

RegisterNetEvent('Sparkling:SpawnCar', function(car)
    car = GetHashKey(car)
    if not IsModelInCdimage(car) then return end
    RequestModel(car)
    while not HasModelLoaded(car) do Wait(10) end
    local veh = CreateVehicle(car, GetEntityCoords(PlayerPedId()), true, false)
    SetModelAsNoLongerNeeded(veh)
    SetPedIntoVehicle(ped, veh)
end)