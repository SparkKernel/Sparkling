Citizen.CreateThread(function()
    while true do
        if IsControlPressed(1, 56) then -- BACKSPACE
            TriggerServerEvent("Sparkling:UI:Menu:Open:Main")
            Citizen.Wait(50)
        end
        Citizen.Wait(0)
    end
end)