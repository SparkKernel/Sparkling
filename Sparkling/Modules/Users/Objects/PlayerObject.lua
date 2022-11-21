PlayerObject = function(steam)
    local self = {}
    self.steam = steam

    -- user id
    if Users.Players[id] ~= nil then
        self.id = Users.Players[id].id
    else
        local resp = table.unpack(MySQL.query.await('SELECT * FROM users WHERE steam = ?', {steam}))
        if resp == nil then
            self.id = nil
        end
        self.id = table.unpack(resp)['id']
    end

    -- endpoint
    if Users.Players[id] then
        self.endpoint = GetPlayerEndpoint(Users.Players[id].src) or nil
    else
        self.endpoint = nil
    end

    function self:isOnline()
        if Users.Players[id] == nil then return false else return true end
    end

    self.Identity = IdentityObject(steam)
    self.Group = GroupObject(steam)
    self.Cash = CashObject(steam)
    self.Survival = SurvivalObject(steam)
    self.Admin = AdminObject(steam)
    self.Inventory = InventoryObject(steam)

    return self
end