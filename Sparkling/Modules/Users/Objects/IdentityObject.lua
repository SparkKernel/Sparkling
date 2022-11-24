local Object = function(id)
    local self = {}

    function Get() return Users.Players[id] or nil end

    local service = {
        change = function(type, value)
            local User = Get()

            if User ~= nil then Users.Players[id].identity[type] = value end

            local data = MySQL.query.await('SELECT * FROM users WHERE steam = ?', {id})

            local unpack = table.unpack(data)
            if unpack == nil then return Error("Cannot find user in DB") end
            local data = json.decode(unpack['data'])

            if not data then return Warn("User has no data") end

            data['identity'][type] = value

            MySQL.query.await('UPDATE users SET data = ? WHERE steam = ?', {json.encode(data, {indent=true}), id})
            
            Debug("Success changing name through db")
        end,

        get = function(type)
            local User = Get()

            if User ~= nil then return User.identity[type] end

            local resp = MySQL.query.await('SELECT * FROM users WHERE steam = ?', {id})
            local unpack = table.unpack(resp)

            if unpack == nil then return false end

            local data = json.decode(unpack['data'])

            Debug("Got name trough db")

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