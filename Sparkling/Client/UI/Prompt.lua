function status(type, data)
    SetNuiFocus(false, false)
    TriggerServerEvent('Sparkling:UI:Prompt:Status', type, data)
end

RegisterNetEvent("Sparkling:UI:Prompt:Show", function(text)
    SetNuiFocus(true, true)
    SendNUIMessage({show = true, text=text})
end)

RegisterNUICallback('cancel', function(data, cb)
    status(false, "")
    cb(true)
end)

RegisterNUICallback('submit', function(data, cb)
    status(true, data['text'])
    cb(true)
end)