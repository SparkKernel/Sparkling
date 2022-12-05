local cfg = Config:Get('Player')
local regen = cfg:Get('RegenerationMultiplier')

local Handler = function(source, t, args)
    print("SEND TO "..source)
    TriggerClientEvent("Sparkling:SpawnHandler", source, t, args)
end

table.insert(SpawnHandler, function(User, Data)
    local source = Data['src']
    Handler(source, 
        'health',
        {health = Data['hp']}
    )

    Handler(source,
        'regenmul',
        {
            regen = regen
        }    
    )
end)