local Object = function(id)
    local self = {}

    local function Get() return Users.Players[id] or nil end

    local service = {
        change = function(type, value)
            local User = Get()

            if User ~= nil then Users.Players[id].identity[type] = value end

            local data, update = GetUpdate(id)
            if not data then Error("cannot find user") return false end

            data['identity'][type] = value

            update(data)
            return true
        end,

        get = function(type)
            local User = Get()

            if User ~= nil then return User.identity[type] end

            local data, update = GetUpdate(id)
            if not data then return false end

            return data.identity[type]
        end
    }

    self.First = {}
    function self.First:Change(value) service.change('first', value) end
    function self.First:Get() return service.get('first') end

    self.Last = {}
    function self.Last:Change(value) service.change('last', value) end
    function self.Last:Get() return service.get('last') end

    function self:GetName()
        local User = Get()
        local first = self.First:Get()

        if first == false then return Error("Cannot find user in DB") end -- if it can't find user

        local last = self.Last:Get()
        return {
            first = first,
            last = last,
            string = first..' '..last
        }
    end

    return self
end 

PlayerObjects:Add({
    name = "Identity",
    object = Object
})