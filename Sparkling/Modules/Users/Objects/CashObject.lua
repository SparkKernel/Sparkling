local Object = function(id)
    local self = {}

    local function Get() return Users.Players[id] or nil end

    function self:Get()
        return Get()['cash'] or 0 -- should also work
    end

    function self:Payment(price)
        if Get() == nil or self:Get() <= price then return false end
        Users.Players[id]['cash'] = self:Get() - price
        return true
    end

    function self:Add(amount)
        if Get() ~= nil then Users.Players[id]['cash'] = Get()['cash'] + amount end
    end

    function self:Set(amount)
        if Get() ~= nil then Users.Players[id]['cash'] = amount end
    end

    return self
end

PlayerObjects:Add({
    name = "Cash",
    object = Object
})
