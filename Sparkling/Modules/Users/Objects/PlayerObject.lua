PlayerObjects = {}
local Registered = {}

function PlayerObjects:Add(tb) table.insert(Registered, tb) end

function GetUpdate(id)
    local data = MySQL.query.await('SELECT * FROM users WHERE steam = ?', {id})
    local unpack = table.unpack(data)
    if unpack == nil then return false, false end
    local data = json.decode(unpack['data'])
    return data, function(changeData)
        MySQL.query.await('UPDATE users SET data = ? WHERE steam = ?', {json.encode(changeData, {indent=true}), id})
    end
end

PlayerObject = function(steam)
    local self = {}
    
    self.steam = steam

    -- user id
    if Users.Players[steam] ~= nil then
        self.id = Users.Players[steam].id
    else
        -- if (user) is not online, it will grab the id from the db
        local resp = table.unpack(MySQL.query.await('SELECT * FROM users WHERE steam = ?', {steam}))
        if resp == nil then self.id = nil
        else self.id = resp['id'] end
    end

    -- endpoint
    if Users.Players[steam] then
        self.endpoint = GetPlayerEndpoint(Users.Players[steam].src) or nil
    else
        self.endpoint = nil
    end

    function self:isOnline()
        return Users.Players[steam] ~= nil -- should work (not tested)
    end

    for i,v in pairs(Registered) do self[v['name']] = v['object'](steam) end -- make all objects

    return self
end
