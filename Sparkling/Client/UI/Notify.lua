-- Notifications handler

RegisterNetEvent("Sparkling:UI:Notify:Add", function(text, color)
    SendNUIMessage({brow = text, color = color})
end)