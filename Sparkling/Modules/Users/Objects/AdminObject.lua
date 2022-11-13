AdminObject = function(id)
    local self = {}

    local helper = {
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
                    User[type] = change
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
                        if not unpack then return Error(find) end
    
                        local data = json.decode(unpack['data'])
    
                        if not data then return Warn(nut) end

                        data[type] = value
    
                        update({json.encode(data), id})
    
                        Debug(now)
                    end
                },
                ['update'] = {
                    ['query'] = 'UPDATE users SET data = ? WHERE id = ?'
                }
            })
        end
    }

    function Get()
        return Users.Players[id] or nil
    end

    function self:Ban(reason)
        helper.on(
            "ban",
            0,
            reason,
            "User is already banned",
            "User is now banned",
            reason
        )
    end

    function self:Unban()
        helper.off(
            'ban',
            0,
            'User is now unbanned',
            'User is not banned',
            'Cannot find user in DB',
            false
        )
    end

    function self:Whitelist()
        helper.on(
            "whitelist",
            false,
            true,
            "User is already whitelistet",
            "User is now whitelisted"
        )
    end

    function self:Unwhitelist()
        helper.off(
            'whitelist',
            false,
            'User is now unwhitelisted',
            'User is not whitelited',
            'Cannot find user in DB'
        )
    end

    return self
end