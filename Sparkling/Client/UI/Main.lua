CreateThread(function()
    while true do
        if IsControlPressed(1, 56) then -- BACKSPACE
            TriggerServerEvent("Sparkling:UI:Menu:Open:Main")
            Wait(50)
        end
        Wait(0)
    end
end)