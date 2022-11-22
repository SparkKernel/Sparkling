local Object = function(id)
    local self = {}

    function Get() return Users.Players[id] or nil end

    local services = {
        set = function(type, to)
            local User = Get()
            if User == nil then return Error("Cannot find user") end
            if to > 100 then return end

            Users.Players[id]['survival'][type] = to
        end,
        get = function(type)
            local User = Get()
            if User == nil then return Error("Cannot find user") end

            return Users.Players[id]['survival'][type]
        end,
        add = function(type, amount)
            local User = Get()
            if User == nil then return Error("Cannot find user") end

            if Users.Players[id]['survival'][type]+amount > 100 then
                Users.Players[id]['survival'][type] = 100
                return
            end

            Users.Players[id]['survival'][type] = Users.Players[id]['survival'][type]+amount
        end,
        remove = function(type, amount)
            local User = Get()
            if User == nil then return Error("Cannot find user") end

            if Users.Players[id]['survival'][type]-amount < 0 then 
                Users.Players[id]['survival'][type] = 0
                return
            end

            Users.Players[id]['survival'][type] = Users.Players[id]['survival'][type]-amount
        end,
    }

    self.Hunger = {}
    function self.Hunger:Set(amount) services.set('hunger', amount) end
    function self.Hunger:Get() return services.get('hunger') end
    function self.Hunger:Add(amount) services.add('hunger', amount) end
    function self.Hunger:Remove(amount) services.remove('hunger', amount) end

    self.Thirst = {}
    function self.Thirst:Set(amount) services.set('thirst', amount) end
    function self.Thirst:Get() return services.get('thirst') end
    function self.Thirst:Add(amount) services.add('thirst', amount) end
    function self.Thirst:Remove(amount) services.remove('thirst', amount) end

    return self
end

PlayerObjects:Add({
    name = "Survival",
    object = Object
})