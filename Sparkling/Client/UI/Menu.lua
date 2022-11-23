local MenuOpen = false
local CurrentIndex = 1
local Indexes = 0

RegisterNetEvent("Sparkling:UI:Menu:Show", function(text, data)
    SendNUIMessage({show = true, text=text, object="menu", list=data})
    Indexes = #data
    CurrentIndex = #data
    MenuOpen = true
end)

RegisterNetEvent('Sparkling:UI:Menu:Close', function()
    SendNUIMessage({show = false, text=text, object="menu"})
    MenuOpen = false
end)

function Move(method)
    SendNUIMessage({object="menu", index=CurrentIndex, method=method})
end

Citizen.CreateThread(function()
    while true do
        if MenuOpen  then 
            if IsControlPressed(1, 177) then -- BACKSPACE
                TriggerServerEvent("Sparkling:UI:Menu:TryClose")
                print("CLOSE")
                Citizen.Wait(50)
            elseif IsControlJustPressed(1, 187) then -- DOWN
                if CurrentIndex == 1 then
                    print("AT LOWEST")
                else
                    CurrentIndex = CurrentIndex - 1
                end
                Move('down')
            elseif IsControlJustPressed(1, 188) then -- UP
                if CurrentIndex == Indexes then print("TOP OF MENU") else
                    CurrentIndex = CurrentIndex + 1
                end
                Move('up')
            end
        end
        Citizen.Wait(0)
    end
end)

--[[
RegisterNUICallback('cancel', function(data, cb)
    status(false, "")
    cb(true)
end)

RegisterNUICallback('submit', function(data, cb)
    status(true, data['text'])
    cb(true)
end)]]