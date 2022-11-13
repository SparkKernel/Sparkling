PlayerObject = function(id)
    local self = {}
    self.ID = id
    
    self.Identity = IdentityObject(self.ID)
    self.Group = GroupObject(self.ID)
    self.Cash = CashObject(self.ID)
    self.Survival = SurvivalObject(self.ID)
    self.Admin = AdminObject(self.ID)
    self.Inventory = InventoryObject(self.ID)

    return self
end