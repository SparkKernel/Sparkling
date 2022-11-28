function status(type, data)
    SetNuiFocus(false, false)
    TriggerServerEvent('Sparkling:UI:Prompt:Status', type, data)
end

RegisterNetEvent("Sparkling:UI:Prompt:Show", function(text, size)
    SetNuiFocus(true, true)
    SendNUIMessage({show = true, text=text, size=size, object="prompt"})
end)

RegisterNUICallback('cancel', function(data, cb)
    status(false, "") cb(true)
end)

RegisterNUICallback('submit', function(data, cb)
    status(true, data['text']) cb(true)
end)