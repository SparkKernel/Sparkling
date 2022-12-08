local cfg = Config:Get('Player')

QuitHandler = function(User, Data, ReturnData)
    local source = Data['src']    
    local ped = GetPlayerPed(source)

    local newReturn = ReturnData

    local x,y,z = GetEntityCoords(ped)
    local health = GetEntityHealth(ped)

    newReturn['coords'] = x

    newReturn['hp'] = health

    return newReturn
end