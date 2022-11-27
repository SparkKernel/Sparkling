local cfg = Config:Get('Player')
local NonSaving = cfg:Get('NonSaving')

local Object = function(id)
    local self = {}

    local function Get() return Users.Players[id] or nil end

    local service = {
        on = function(tt,value,isnot,change,now,ban)
            local User = Get()
            if User ~= nil then 
                if User[tt] ~= value then Warn(isnot) end
                if tt == "ban" then 
                    User[tt] = change 
                    DropPlayer(User["src"], "You've been banned - for the reason: "..ban)
                else 
                    User[tt] = ban
                end
            else
                local data = MySQL.query.await('SELECT * FROM users WHERE steam = ?', {id})
                
                local unpack = table.unpack(data)
                if unpack == nil then return Error("Cannot find user in DB") end
                local data = json.decode(unpack['data']) or default

                data[tt] = change

                MySQL.query.await('UPDATE users SET data = ? WHERE steam = ?', {json.encode(data, {indent=true}), id})
                Debug(now)
            end
        end,
        off = function(tt,value,now,nut,find)
            if Get() ~= nil then Users.Players[id].whitelist = true end

            local data = MySQL.query.await('SELECT * FROM users WHERE steam = ?', {id})

            local unpack = table.unpack(data)
            if not unpack then return Error(find) end
            local data = json.decode(unpack['data'])

            if not data then return Warn(nut) end

            data[tt] = value

            MySQL.query.await('UPDATE users SET data = ? WHERE steam = ?', {json.encode(data, {indent=true}), id})
            
            Debug(now)
        end,
        is = function(tt, value)
            local User = Get()

            if User ~= nil then
                if tt == 'whitelist' then 
                    return User[tt] 
                else  
                    return false 
                end 
            end

            local resp = MySQL.query.await('SELECT * FROM users WHERE steam = ?', {id})

            local unpacked = table.unpack(resp)
            if unpacked == nil then return false end 
            local data = json.decode(unpacked['data']) or nil

            if data[tt] == value then return false end
            return true
        end
    }

    function self:Ban(reason)
        reason = reason or ''
        service.on("ban", 0, "User is already banned", reason, "User is now banned", reason)
    end

    function self:Unban()
        service.off('ban', 0, 'User is now unbanned', 'User is not banned', 'Cannot find user in DB', false)
    end

    function self:Whitelist()
        service.on("whitelist", false, true, "User is already whitelistet", "User is now whitelisted")
    end

    function self:Unwhitelist()
        service.off('whitelist', false, 'User is now unwhitelisted', 'User is not whitelited', 'Cannot find user in DB')
    end

    function self:Kick(reason)
        local User = Get()
        if User == nil then return Error("User does not exist.") end
        DropPlayer(User['src'], reason)
    end 

    function self:IsBanned() 
        return service.is('ban', 0)
    end

    function self:isWhitelisted() 
        return service.is('whitelist', false) 
    end

    return self
end

PlayerObjects:Add({
    name = "Admin",
    object = Object
})