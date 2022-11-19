PlayerObject = function(id)
    local self = {}
    self.ID = id

    -- endpoint
    if Users.Players[id] then
        self.Endpoint = GetPlayerEndpoint(Users.Players[id].src) or nil
    else
        self.Endpoint = nil
    end

    function self:isOnline()
        if Users.Players[id] == nil then return false else return true end
    end

    self.Identity = IdentityObject(self.ID)
    self.Group = GroupObject(self.ID)
    self.Cash = CashObject(self.ID)
    self.Survival = SurvivalObject(self.ID)
    self.Admin = AdminObject(self.ID)
    self.Inventory = InventoryObject(self.ID)

    return self
end