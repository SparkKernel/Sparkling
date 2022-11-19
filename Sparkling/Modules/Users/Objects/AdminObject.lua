AdminObject = function(id)
    local self = {}

    function Get() return Users.Players[id] or nil end

    local service = {
        ['on'] = function(
            type, -- Type
            value, -- If it is value change
            isnot, -- The needed value is not (warn message)
            change, -- The value it gets set to if success
            now, -- The debug message back
            ban
        )
            reason = reason or true
            local User = Get()
            if User ~= nil then
                if User[type] == value then
                    if type ~= "ban" then User[type] = change else User[type] = ban end
                    if type == 'ban' then DropPlayer(User["src"], "You've been banned - for the reason: "..ban) end
                    Debug("On event used!")
                else
                    return Warn(isnot)
                end
            else
                Users.Utility:GetUpdate({
                    ['get'] = {
                        ['query'] = 'SELECT * FROM users WHERE id = ?',
                        ['args'] = {id},
                        ['callback'] = function(data, update)
                            local unpack = data['unpack']
                            if not unpack then return Error("Cannot find user in DB") end

                            local data = json.decode(unpack['data']) or default
    
                            data[type] = change
    
                            update({json.encode(data), id})
    
                            Debug(now)
                        end
                    },
                    ['update'] = {
                        ['query'] = 'UPDATE users SET data = ? WHERE id = ?'
                    }
                })
            end
        end,
        ['off'] = function(
            type, -- Type of change
            value, -- The value its getting set to
            now, -- Success debug message
            nut, -- The user doesn't have data warn message
            find -- Cannot find user (error message)
        )
            Users.Utility:GetUpdate({
                ['get'] = {
                    ['query'] = 'SELECT * FROM users WHERE id = ?',
                    ['args'] = {id},
                    ['callback'] = function(data, update)
                        local unpack = data['unpack']
                        if not unpack then 
                            return Error(find) 
                        end
    
                        local data = json.decode(unpack['data'])
    
                        if not data then 
                            return Warn(nut) 
                        end

                        data[type] = value
    
                        update({json.encode(data), id})
                        
                        Debug(now)
                    end
                },
                ['update'] = {
                    ['query'] = 'UPDATE users SET data = ? WHERE id = ?'
                }
            })
        end,
        ['is'] = function(type, value)
            local User = Get()

            if User == nil then 
                local resp = MySQL.query.await('SELECT * FROM users WHERE id = ?', {id})

                local unpacked = table.unpack(resp)
                if unpacked == nil then return false end 
                local data = json.decode(unpacked['data']) or nil

                if data[type] == value then return false end
                return true
            else
                if type == 'whitelist' then
                    return User[type]
                else
                    return false
                end
            end
        end
    }

    function self:Ban(reason)
        reason = reason or ''
        service.on("ban",0,reason,"User is already banned","User is now banned",reason)
    end

    function self:Unban()
        service.off('ban',0,'User is now unbanned','User is not banned','Cannot find user in DB',false)
    end

    function self:Whitelist()
        service.on(
            "whitelist",
            false,
            true,
            "User is already whitelistet",
            "User is now whitelisted"
        )
    end

    function self:Unwhitelist()
        service.off('whitelist',false,'User is now unwhitelisted','User is not whitelited','Cannot find user in DB')
    end

    function self:Kick(reason)
        local User = Get()
        if User == nil then return Error("User does not exist.") end
        DropPlayer(User['src'], reason)
    end 

    -- is

    function self:IsBanned() 
        return service.is('ban',0)
    end

    function self:isWhitelisted() 
        return service.is('whitelist',false) 
    end

    return self
end