local cfg = Config:Get('Player')
local NonSaving = cfg:Get('NonSaving')
local default = cfg:Get('Default') 

local Object = function(id)
    local self = {}

    local function Get() return Users.Players[id] or nil end

    local service = {
        on = function(
                tt, -- type of (change)
                value, -- this needs 
                change -- the value it needs to set it to
            )
            local User = Get()
            if User ~= nil then 
                if User[tt] ~= value then Warn("value is not set") return false end
                if tt == "ban" then User[tt] = change DropPlayer(User["src"], "You've been banned - for the reason: "..change)
                else User[tt] = change end
                return true
            else
                local data, update = GetUpdate(id)
                if not data then Error("User does not exist", 'Sparkling', 'user: '..id, 'Modules/Users/Objects/AdminObject.lua') return false end
                data[tt] = change
                update(data)
                return true
            end
        end,
        off = function(
                tt, -- type of (change)
                value -- value it sets it to
            )
            if Get() ~= nil then
                if tt == "whitelist" then Users.Players[id].whitelist = true return true
                else return false end
            end

            local data, update = GetUpdate(id)
            if not data then Error("User does not exist", 'Sparkling', 'user: '..id, 'Modules/Users/Objects/AdminObject.lua') return false end

            data[tt] = value

            update(data)
            return true
        end,
        is = function(tt, value)
            local User = Get()

            if User ~= nil then 
                if tt == 'whitelist' then return User[tt] 
                else return false end 
            end

            local data = GetUpdate(id)

            if data[tt] == value then return false end

            return true
        end
    }

    function self:Ban(reason)
        reason = reason or ''
        service.on("ban", 0, reason)
    end

    function self:Unban()
        return service.off('ban', 0, 'User is now unbanned', 'User is not banned', 'Cannot find user in DB', false)
    end

    function self:Whitelist()
        return service.on("whitelist", false, true)
    end

    function self:Unwhitelist()
        return service.off('whitelist', false, 'User is now unwhitelisted', 'User is not whitelited', 'Cannot find user in DB')
    end

    function self:Kick(reason)
        local User = Get()  
        reason = reason or ''
        if User == nil then Error("User does not exist.", 'Sparkling', 'No information', 'Modules/Users/Objects/AdminObject.lua') return false end
        DropPlayer(User['src'], reason)
        return true
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