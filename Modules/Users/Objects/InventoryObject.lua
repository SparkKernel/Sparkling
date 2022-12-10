local cfg = Config:Get('Items')
local Items = cfg:Get('Items')
local PlayerWeight = cfg:Get('PlayerWeight')

local Object = function(id)
    local self = {}

    local function Get() return Users.Players[id] or nil end

    function self:Weight()
        local User = Get()
        local data = {}
        local weight = 0
        if User == nil then
            local d = GetUpdate(id)
            data = d.inventory
        else
            data = User.inventory
        end

        for k,v in pairs(data) do
            local item = Items[k]
            local ww = 0
            if item == nil then
                Debug("Trying to calculate non-existing item, setting weight to 0")
            else
                ww = item.Weight
            end

            weight = weight + ww * v
        end

        return weight
    end

    function self:Get()
        local User = Get()
        if User == nil then
            local data = GetUpdate(id)

            return data.inventory
        else
            return User.inventory
        end
    end

    function self:Can(item, amount)
        if not Items[item] then
            Debug("Cannot find item", 'Sparkling', 'item: '..item)
            return false
        end

        local Weight = Items[item].Weight * amount
        local UserWeight = self:Weight()

        if UserWeight + Weight > PlayerWeight then
            return false
        end

        return true
    end

    function self:Add(item, amount)
        if not Items[item] then
            Debug("Cannot find item", 'Sparkling', 'item: '..item)
            return false
        end

        local weight = Items[item].Weight * amount
        
        local User = Get()
        if User == nil then
            local data, update = GetUpdate(id)
            local UserWeight = self:Weight()
            if UserWeight + weight > PlayerWeight then
                Debug("User does not have enough storage", 'Sparkling', 'storage: '..weight+UserWeight..'/'..PlayerWeight)
                return false 
            end

            if data.inventory[item] then
                data.inventory[item] = data.inventory[item] + amount
            else
                data.inventory[item] = amount
            end
            update(data)
        else
            if User.inventory[item] then User.inventory[item] = User.inventory[item] + amount
            else User.inventory[item] = amount
            end
        end
    end
    
    function self:Remove(item, amount)
        if not Items[item] then
            Debug("Cannot find item", 'Sparkling', 'item: '..item)
            return false
        end

        local User = Get()
        if User == nil then
            local data, update = GetUpdate(id)
            if data.inventory[item] then
                if data.inventory[item] - amount < 0 then
                    Debug("Amount is going to be lover than 0! So deleting item from inventory")
                    data.inventory[item] = nil
                else
                    data.inventory[item] = data.inventory[item] - amount
                end
                
                update(data)
            else
                Debug("User does not have removed item")
            end
        else    
            if User.inventory[item] then
                if data.inventory[item] - amount < 0 then
                    Debug("Amount is going to be lover than 0! So deleting item from inventory")
                    User.inventory[item] = nil
                else User.inventory[item] = User.inventory[item] - amount
                end
            else Debug("User does not have removed item")
            end
        end
    end

    function self:Set(item, amount)
        if not Items[item] then
            Debug("Cannot find item", 'Sparkling', 'item: '..item)
            return false
        end

        local User = Get()
        if User == nil then
            local data, update = GetUpdate(id)
            data.inventory[item] = amount
            update(data)
        else    
            data.inventory[item] = amount
        end
    end
    
    return self
end

PlayerObjects:Add({
    name = "Inventory",
    object = Object
})