RegisterNetEvent("Sparkling:UI:Notify:Add", function(text, color)
    print(text, color)
    SendNUIMessage({text = text, color = color})
end)