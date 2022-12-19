local cfg = Config:Get('Player')
local regen = cfg:Get('RegenerationMultiplier')

local Handler = function(source, t, args)
    TriggerClientEvent("Sparkling:SpawnHandler", source, t, args)
end

table.insert(SpawnHandler, function(User, Data)
    local source = Data['src']    
    local ped = GetPlayerPed(source)
    Handler(
        source,
        'health',
        { health = Data.hp }
    )
    SetEntityCoords(
        ped,
        Data.coords.x,
        Data.coords.y,
        Data.coords.z,
        false,
        false,
        false
    )
end)