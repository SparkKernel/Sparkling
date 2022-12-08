
local ped = GetPlayerPed(-1)
RegisterNetEvent('Sparkling:SpawnHandler', function(t, args)
    print(t,args.health)
    if t == 'health' then
        SetEntityHealth(ped, args.health)
    end
end)