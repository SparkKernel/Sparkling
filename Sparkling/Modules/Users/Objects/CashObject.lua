CashObject = function(id)
    local self = {}

    function Get() return Users.Players[id] or nil end

    function self:Get()
        local User = Get() or {cash = 0}
        return User['cash']
    end

    function self:Payment(price)
        if Get() == nil then return false end
        if self:Get() >= price then
            Users.Players[id]['cash'] = self:Get() - price
            return true
        end
        return false
    end

    function self:Add(amount)
        if Get() == nil then return end
        Users.Players[id]['cash'] = Get()['cash'] + amount
    end

    function self:Set(amount)
        if Get() == nil then return end
        Users.Players[id]['cash'] = amount
    end

    return self
end