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
        {
            health = Data.hp
        }
    )
    SetEntityCoords(
        ped,
        Data.coords.x.x or Data.coords.x,
        Data.coords.x.y or Data.coords.y,
        Data.coords.x.z or Data.coords.z,
        false,
        false,
        false
    )
end)