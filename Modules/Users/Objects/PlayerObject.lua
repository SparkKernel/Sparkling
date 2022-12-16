PlayerObjects = {}
local Registered = {}

function PlayerObjects:Add(tb) table.insert(Registered, tb) end

function GetUpdate(id)
    local data = UserDB:GetData({steam = id})
    if data == nil then return false, false end
    data = data['data']
    return data, function(changeData)
        UserDB:Update({
            steam = id
        }, {
            data = json.encode(changeData, {indent=true})
        })
    end
end

PlayerObject = function(steam, callback)
    local self = {}
    
    self.steam = steam

    -- user id
    if Users.Players[steam] ~= nil then
        self.id = Users.Players[steam].id
    else
        -- if (user) is not online, it will grab the id from the db
        local resp = UserDB:GetData({steam = steam})
        if resp == nil then self.id = nil
        else self.id = resp['id'] end
    end

    -- endpoint
    if Users.Players[steam] and Users.Players[steam].src and Users.Players[steam].quitting == nil then
        self.endpoint = GetPlayerEndpoint(Users.Players[steam].src) or nil
    else
        self.endpoint = nil
    end

    function self:isOnline()
        return Users.Players[steam] ~= nil -- should work (not tested)
    end

    for i,v in pairs(Registered) do self[v['name']] = v['object'](steam, callback) end -- make all objects

    return self
end
