IdentityObject = function(id)
    local self = {}

    function Get() return Users.Players[id] or nil end

    local service = {
        change = function(
            type, 
            value
        )
            local User = Get()
            if User == nil then 

                Users.Utility:GetUpdate({
                    get = {
                        query = 'SELECT * FROM users WHERE id = ?', args = {id},
                        callback = function(data, update)
                            local unpack = data.unpack

                            if unpack == nil then return Error("Cannot find user in DB") end

                            local data = json.decode(unpack['data'])
        
                            if not data then return Warn("User has no data") end

                            data['identity'][type] = value
        
                            update({json.encode(data), id})
                            
                            Debug("Success changing name through db")
                        end
                    },
                    update = {
                        query = 'UPDATE users SET data = ? WHERE id = ?'
                    }
                })
            else
                Users.Players[id].identity[type] = value
            end
        end,

        get = function(type)
            local User = Get()

            if User == nil then 
                local resp = MySQL.query.await('SELECT * FROM users WHERE id = ?', {id})

                if table.unpack(resp) == nil then
                    return false
                end

                local data = json.decode(table.unpack(resp)['data'])

                Debug("Got name trough db")

                return data.identity[type]
            end

            return User.identity[type]
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
        if first == false then return Error("Cannot find user in DB") end
        local last = self.Last:Get()
        return {
            first = first,
            last = last,
            string = first..' '..last
        }
    end

    return self
end 