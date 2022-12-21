
local ped = GetPlayerPed(-1)
RegisterNetEvent('Sparkling:SpawnHandler', function(t, args)
    print(t,args.health)
    if t == 'health' then
        SetEntityHealth(ped, args.health)
    end
end)

RegisterCommand('veh', function()
    local ModelHash = 'adder'
    if not IsModelInCdimage(ModelHash) then return end
    RequestModel(ModelHash)
    while not HasModelLoaded(ModelHash) do
        Wait(10)
    end
    local MyPed = PlayerPedId()
    Boat = CreateVehicle(ModelHash, GetEntityCoords(PlayerPedId()), true, false)
    SetModelAsNoLongerNeeded(ModelHash)
end)