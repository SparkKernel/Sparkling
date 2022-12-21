RegisterCallback('HasWeapon', function(weapon)
    local ped = PlayerPedId()
    if string.find(weapon, 'weapon_') then
        return HasPedGotWeapon(ped, GetHashKey(weapon))
    else
        return HasPedGotWeapon(ped, weapon)
    end
end)

RegisterCallback('GetWeapons', function(allWeapons)
    local ped = PlayerPedId()
    local weapons = {}
    for i,v in pairs(allWeapons) do
        if HasPedGotWeapon(ped, GetHashKey(v)) then table.insert(weapons, v) end
    end
    return weapons
end)

RegisterNetEvent('Sparkling:GiveWeapon', function(weapon, ammo)
    local ped = PlayerPedId()
    GiveWeaponToPed(ped, GetHashKey(weapon), ammo, false, false)
end)

RegisterNetEvent('Sparkling:RemoveWeapon', function(weapon)
    local ped = PlayerPedId()
    RemoveWeaponFromPed(ped, GetHashKey(weapon))
end)

RegisterCallback('GetAmmo', function(weapon)
    local ped = PlayerPedId()
    return GetAmmoInPedWeapon(ped, GetHashKey(weapon))
end)

RegisterNetEvent('Sparkling:SetAmmo', function(weapon, ammo)
    local ped = PlayerPedId()
    if string.find(weapon, 'weapon_') then
        SetPedAmmo(ped, GetHashKey(weapon), ammo)
    else
        SetPedAmmo(ped, weapon, ammo)
    end
end)

RegisterCallback('GetCurrentWeapon', function()
    local ped = PlayerPedId()
    return GetSelectedPedWeapon(ped)
end)