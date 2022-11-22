local cfg = Config:Get('Group')

local Groups = cfg:Get('Groups')

local Object = function(id)
    local self = {}

    function Get() return Users.Players[id] or nil end

    function GRP()
        local resp = MySQL.query.await('SELECT * FROM users WHERE steam = ?', {id})
        if table.unpack(resp) == nil then return false end
        local data = json.decode(table.unpack(resp)['data'])
        if not data then return false end
        return data
    end

    function Service(dataFunc)
        local data = MySQL.query.await('SELECT * FROM users WHERE steam = ?', {id})

        local unpack = table.unpack(data)
        if unpack == nil then return Error("Cannot find user in DB") end
        local data = json.decode(unpack['data'])
        if not data then return Warn("User has no data") end

        dataFunc(data)

        MySQL.query.await('UPDATE users SET data = ? WHERE steam = ?', {json.encode(data), id})
        
        Debug("Success adding or removing group through db")
    end

    function self:Has(group)
        local User = Get()

        if User == nil then
            local data = GRP()
            if data ~= false then
                for _,v in pairs(data['groups']) do if v == group then return true end end
            end
            return false
        end

        for _,v in pairs(User['groups']) do if v == group then return true end end

        return false
    end

    function self:Get()
        local User = Get()
        if User == nil then 
            local data = GRP()
            if data == false then return {} end
            return data.groups
        end
        
        return User.groups
    end

    function self:Add(group)
        local User = Get()
        if Groups[group] == nil then Debug("Invalid group") return false end
        
        local Has = self:Has(group)
        if Has == true then Debug("User already has group") return false end

        if User == nil then 
            return Service(function(data)
                table.insert(data.groups, group)
                return data
            end)
        end

        table.insert(Users.Players[id].groups, group)

        Debug("Success")
    end

    function self:Remove(group)
        local User = Get()
        if User == nil then 
            return Service(function(data)
                for i,v in pairs(data['groups']) do if v == group then table.remove(data.groups, i) end end
                return data
            end)
        end

        local Has = self:Has(group)
        if Has == false then return false end

        for i,v in pairs(User['groups']) do if v == group then table.remove(Users.Players[id].groups, i) end end

        Debug("Success")
    end

    function self:Permission(perm)
        local User = Get()
        if User == nil then
            local data = GRP() --grab data
            if data == false then return false end
            User = data
        end

        for i,v in pairs(User['groups']) do
            if Groups[v] == nil then return Error("User has group that doesn't exist. (group="..v..")") end
            local perms = Groups[v].Permissions
            for i,v in pairs(perms) do if v == perm then return true end end
        end

        return false
    end 

    return self
end

PlayerObjects:Add({
    name = "Group",
    object = Object
})