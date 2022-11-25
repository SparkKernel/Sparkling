local MenuOpen = false
local CurrentIndex = 1
local Data = {}

RegisterNetEvent("Sparkling:UI:Menu:Show", function(text, data) -- show meni
    SendNUIMessage({show = true, text=text, object="menu", list=data})
    CurrentIndex = #data Data = data MenuOpen = true
end)

RegisterNetEvent('Sparkling:UI:Menu:Close', function() -- close menu
    SendNUIMessage({show = false, text=text, object="menu"})
    MenuOpen = false Data = {}
end)

function Move(method, old) SendNUIMessage({object="menu", oldIndex=old, index=CurrentIndex, method=method}) end

Citizen.CreateThread(function()
    while true do
        if MenuOpen  then 
            if IsControlJustPressed(1, 177) then -- BACKSPACE
                TriggerServerEvent("Sparkling:UI:Menu:TryClose")
            elseif IsControlJustPressed(1, 187) then -- DOWN
                local old = CurrentIndex
                if CurrentIndex ~= 1 then
                    CurrentIndex = CurrentIndex - 1
                else
                    CurrentIndex = #Data
                    Move('teleport', old)
                end
                Move('down', 0)
            elseif IsControlJustPressed(1, 188) then -- UP
                local old = CurrentIndex
                if CurrentIndex ~= #Data then
                    CurrentIndex = CurrentIndex + 1
                    Move('up')
                else
                    print("TEXT")
                    CurrentIndex = 1
                    Move('teleport', old)
                end
                
            elseif IsControlJustPressed(1, 18) then -- Pressed
                local PressedIndex = Data[#Data-CurrentIndex+1]
                TriggerServerEvent("Sparkling:UI:Menu:Click", PressedIndex)
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