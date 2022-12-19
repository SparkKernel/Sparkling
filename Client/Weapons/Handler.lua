local ped = GetPlayerPed(-1)

RegisterCallback('HasWeapon', function(weapon)
    return HasPedGotWeapon(ped, GetHashKey(weapon))
end)

RegisterCallback('GetWeapons', function(allWeapons)
    local weapons = {}
    for i,v in pairs(allWeapons) do
        if HasPedGotWeapon(ped, GetHashKey(v)) then
            table.insert(weapons, v)
        end
    end

    return weapons
end)

RegisterNetEvent('Sparkling:GiveWeapon', function(weapon, ammo)
    GiveWeaponToPed(ped, GetHashKey(weapon), ammo, false, false)
end)