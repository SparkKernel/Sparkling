local cfg = Config:Get('Group')

local Groups = cfg:Get('Groups')

GroupObject = function(id)
    local self = {}

    function Get() return Users.Players[id] or nil end

    function self:Has(group)
        local User = Get()

        if User == nil then Debug("Cannot find user") return false end

        for _,v in pairs(User['groups']) do
            if v == group then
                return true
            end
        end

        return false
    end

    function self:Add(group)
        local User = Get()
        if User == nil then return Debug("Cannot find user") end

        local Has = self:Has(group)
        if Has == true then return false end

        if Groups[group] == nil then return false end

        table.insert(Users.Players[id].groups, group)

        Debug("Success")
    end

    function self:Remove(group)
        local User = Get()
        if User == nil then return Debug("Cannot find user") end

        local Has = self:Has(group)
        if Has == false then return false end

        for i,v in pairs(User['groups']) do
            if v == group then
                table.remove(Users.Players[id].groups, i)
            end
        end

        Debug("Success")
    end

    function self:Permission(perm)
        local User = Get()
        if User == nil then return Debug("Cannot find user") end
        print(json.encode(User))
        for i,v in pairs(User['groups']) do
            if Groups[v] == nil then return Error("User has group that doesn't exist. (group="..v..")") end
            local perms = Groups[v].Permissions
            for i,v in pairs(perms) do
                if v == perm then
                    return true
                end
            end
        end

        return false
    end 

    return self
end