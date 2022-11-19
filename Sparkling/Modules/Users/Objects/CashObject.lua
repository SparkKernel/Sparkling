CashObject = function(id)
    local self = {}

    function Get() return Users.Players[id] or nil end

    function self:Get()
        local User = Get()
        if User == nil then print("NO") return 0 end
        return User['cash']
    end

    function self:Payment( -- Try payment, if true then it will remove cash and return true. (Makes it easier for payments)
        price -- The amount of payment
    )

        if Get() == nil then return false end

        if self:Get() >= price then
            Users.Players[id]['cash'] = self:Get() - price
            return true
        else
            return false
        end
    end

    function self:Add( -- Add cash to money
        amount
    )
        if Get() == nil then return end
        Users.Players[id]['cash'] = Get()['cash'] + amount
    end

    function self:Set( -- Set cash amount
        amount
    )
        if Get() == nil then return end
        Users.Players[id]['cash'] = amount
    end

    return self
end