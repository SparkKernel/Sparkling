local Object = function(id)
    local self = {}

    local function Get() return Users.Players[id] or nil end

    function self:Get()
        local user = Get()
        if user == nil then return false end
        local pos = GetEntityCoords(GetPlayerPed(user.src))
        return pos.x,pos.y,pos.z
    end

    function self:Set(x, y, z)
        local user = Get()
        if user == nil then return false end
        SetEntityCoords(
            GetPlayerPed(user.src),
            x,
            y,
            z,
            false,
            false,
            false
        )
        return true
    end


    return self
end

PlayerObjects:Add({
    name = "Position",
    object = Object
})