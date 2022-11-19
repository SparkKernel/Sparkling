PlayerObject = function(id)
    local self = {}
    self.id = id

    -- endpoint
    if Users.Players[id] then
        self.Endpoint = GetPlayerEndpoint(Users.Players[id].src) or nil
    else
        self.Endpoint = nil
    end

    function self:isOnline()
        if Users.Players[id] == nil then return false else return true end
    end

    self.Identity = IdentityObject(self.id)
    self.Group = GroupObject(self.id)
    self.Cash = CashObject(self.id)
    self.Survival = SurvivalObject(self.id)
    self.Admin = AdminObject(self.id)
    self.Inventory = InventoryObject(self.id)

    return self
end