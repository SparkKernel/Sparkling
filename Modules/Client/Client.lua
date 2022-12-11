SparkClient = {}
local Ids = {}

function SparkClient:Run(source, name, func, ...)
    local id = tostring(math.random(1000000, 9999999))
    Ids[id] = func

    TriggerClientEvent('Sparkling:TriggerClientCallback', source, name, id, ...)
end

RegisterNetEvent('Sparkling:ReturnClientCallback', function(id, resp)
    if Ids[id] == nil then return print("Cannot find id") end

    Ids[id](resp)
end)