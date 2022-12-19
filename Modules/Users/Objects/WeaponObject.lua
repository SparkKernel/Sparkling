local cfg = Config:Get('Weapons'):Get('List')

local Object = function(id)
    local self = {}

    local function Get() return Users.Players[id] or nil end

    local Client = ClientObject(id)

    function self:Get()
        if Get() == nil then return end

        local weapons = nil
        Client:Callback('GetWeapons', function(resp)
            weapons = resp
        end, cfg)

        while weapons == nil do Citizen.Wait(1) end

        return weapons
    end 

    function self:Has(weapon)
        if Get() == nil then return end

        local has = nil

        Client:Callback('HasWeapon', function(resp)
            if not resp then has = false return end
            has = true
        end, weapon)

        while has == nil do Citizen.Wait(1) end
        return has
    end

    function self:Give(weapon, ammo)
        if self:Has(weapon) then return end
        Client:Event('Sparkling:GiveWeapon', weapon, ammo)
    end

    return self
end

PlayerObjects:Add({
    name = "Weapon",
    object = Object
})