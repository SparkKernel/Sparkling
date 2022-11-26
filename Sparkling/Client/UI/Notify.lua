RegisterNetEvent("Sparkling:UI:Notify:Add", function(text, color)
    print(text, color)
    SendNUIMessage({brow = text, color = color})
end)