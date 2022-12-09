local MenuOpen = false
local CurrentIndex = 1
local Data = {}
local CurrentColor = '#EF5064'

RegisterNetEvent("Sparkling:UI:Menu:Show", function(text, data, color) -- show meni
    SendNUIMessage({show = true, text=text, object="menu", list=data, color=color})
    CurrentIndex = #data Data = data MenuOpen = true
    CurrentColor = color
end)

RegisterNetEvent('Sparkling:UI:Menu:Close', function() -- close menu
    SendNUIMessage({show = false, text=text, object="menu"})
    MenuOpen = false Data = {}
end)

function Move(method, old) SendNUIMessage({object="menu", oldIndex=old, index=CurrentIndex, method=method, color=CurrentColor}) end

CreateThread(function()
    while true do
        if MenuOpen then 
            if IsControlJustPressed(1, 177) then -- BACKSPACE
                TriggerServerEvent("Sparkling:UI:Menu:TryClose")
            elseif IsControlJustPressed(1, 187) then -- DOWN
                local old = CurrentIndex
                if CurrentIndex ~= 1 then CurrentIndex = CurrentIndex - 1 Move('down', 0) -- down
                else CurrentIndex = #Data Move('teleport', old) -- teleport
                end
            elseif IsControlJustPressed(1, 188) then -- UP
                local old = CurrentIndex
                if CurrentIndex ~= #Data then CurrentIndex = CurrentIndex + 1 Move('up', 0) -- up
                else CurrentIndex = 1 Move('teleport', old) -- teleport
                end
            elseif IsControlJustPressed(1, 191) then -- Pressed
                local PressedIndex = Data[#Data-CurrentIndex+1]
                TriggerServerEvent("Sparkling:UI:Menu:Click", PressedIndex)
            end
        end
        Wait(0)
    end
end)