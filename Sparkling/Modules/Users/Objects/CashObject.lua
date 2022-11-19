CashObject = function(id)
    local self = {}

    function Get() return Users.Players[id] or nil end

    function self:Get()
        local User = Get()
        if User == nil then return 0 end
        return User['cash']
    end

    function self:Payment( -- Try payment, if true then it will remove cash and return true. (Makes it easier for payments)
        amount -- The amount of payment
    )

    end
end