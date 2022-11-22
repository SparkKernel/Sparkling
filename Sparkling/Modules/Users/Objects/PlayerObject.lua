PlayerObjects = {}
local Registered = {}

function PlayerObjects:Add(tb) table.insert(Registered, tb) end

PlayerObject = function(steam)
    local self = {}
    self.steam = steam

    -- user id
    if Users.Players[steam] ~= nil then
        self.id = Users.Players[steam].id
    else
        local resp = table.unpack(MySQL.query.await('SELECT * FROM users WHERE steam = ?', {steam}))
        if resp == nil then
            self.id = nil
        else
            self.id = resp['id']
        end
    end

    -- endpoint
    if Users.Players[steam] then
        self.endpoint = GetPlayerEndpoint(Users.Players[steam].src) or nil
    else
        self.endpoint = nil
    end

    function self:isOnline()
        if Users.Players[steam] == nil then return false else return true end
    end

    for i,v in pairs(Registered) do
        self[v['name']] = v['object'](steam)
    end

    return self
end