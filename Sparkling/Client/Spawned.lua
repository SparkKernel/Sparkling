-- Event when the user is spawned in.
AddEventHandler('playerSpawned', function(info)
    TriggerServerEvent('Sparkling:Spawned', info)
end)
