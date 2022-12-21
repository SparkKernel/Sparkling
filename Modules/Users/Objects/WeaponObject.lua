local cfg = Config:Get('Weapons'):Get('List')

local Object = function(id)
    local val = {}

    local function Get() return Users.Players[id] or nil end

    local Client = ClientObject(id)

    function val:Get()
        if Get() == nil then return end
        local weapons = nil
        Client:Callback('GetWeapons', function(resp) weapons = resp end, cfg)
        
        while weapons == nil do Citizen.Wait(1) end
        return weapons
    end 

    function val:Has(weapon)
        if Get() == nil then return end

        local has = nil

        Client:Callback('HasWeapon', function(resp)
            if not resp then has = false return end
            has = true
        end, weapon)

        while has == nil do Citizen.Wait(1) end
        return has
    end

    function val:Give(weapon, ammo)
        if val:Has(weapon) then return end
        Client:Event('Sparkling:GiveWeapon', weapon, ammo)
    end

    function val:Remove(weapon)
        if not val:Has(weapon) then return end
        Client:Event('Sparkling:RemoveWeapon', weapon, ammo)
    end

    function val:Current()
        if Get() == nil then return end

        local weapon = nil

        Client:Callback('GetCurrentWeapon', function(resp)
            if not resp then weapon = false return end
            weapon = resp
        end)
        while weapon == nil do Citizen.Wait(1) end
        return weapon
    end

    val.Ammo = {}
    function val.Ammo:Get(weapon)
        if Get() == nil then return 0 end
        if not val:Has(weapon) then return 0 end
        local ammo = nil
        Client:Callback('GetAmmo', function(resp)
            if not resp then ammo = false return end
            ammo = resp
        end, weapon)
        while ammo == nil do Citizen.Wait(1) end
        return ammo
    end
    function val.Ammo:Set(weapon, ammo)
        if not val:Has(weapon) then return end
        Client:Event('Sparkling:SetAmmo', weapon, ammo)
    end
    function val.Ammo:Add(weapon, ammo)
        if not val:Has(weapon) then return end
        local CurrentAmmo = val.Ammo:Get(weapon)
        Client:Event('Sparkling:SetAmmo', weapon, ammo+CurrentAmmo)
    end
    function val.Ammo:Remove(weapon, ammo)
        if not val:Has(weapon) then return end
        local CurrentAmmo = val.Ammo:Get(weapon)
        if CurrentAmmo-ammo <= 0 then return false end
        Client:Event('Sparkling:SetAmmo', weapon, CurrentAmmo-ammo)
    end

    return val
end

PlayerObjects:Add({
    name = "Weapon",
    object = Object
})