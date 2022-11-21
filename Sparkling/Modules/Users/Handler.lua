Users = {}
Users.Funcs = {}
Users.Players = {}
Users.FromId = {} -- (id:) (steam hex)
Users.Utility = {}

local cfg = Config:Get('Player')

local default = cfg:Get('Default')

local Errors = cfg:Get('Errors')

local Messages = cfg:Get('Messages')

local LoadDelay = cfg:Get('LoadDelay')

Users.Funcs.Get = function(source)
    local steam
    if type(source) == "string" then 
        steam=source
        if tonumber(source) then
            steam = Users.FromId[source]
        end
    else
        steam = Users.Utility.GetSteam(source)
        if steam == '' then Warn("Cannot find user") end
    end

    return PlayerObject(steam)
end

Users.Funcs.Create = function(_, _, def)
    local source=source
    local steam = Users.Utility.GetSteam(source) -- get steam

    def.defer() -- defer

    if steam == '' then return def.done(Errors['SteamError']) end

    Wait(0)

    def.update(Messages['Checking'])

    local resp = MySQL.query.await('SELECT * FROM users WHERE steam = ?', {steam})

    Debug("A user joined "..steam)
    print(json.encode(resp))

    if table.unpack(resp) ~= nil then
        def.update(Messages['Registered'])
        Debug("User already registered")
    else
        Debug("Creating user "..steam)

        def.update(Messages['Creating'])

        MySQL.query.await('INSERT INTO users (steam) VALUES (?)', {steam})
        resp = MySQL.query.await('SELECT * FROM users WHERE steam = ?', {steam})
        print(json.encode(resp))
    end
    Users.Funcs.Load(source, steam, resp, def)

    def.done()
end

Users.Funcs.Load = function(source, steam, db, def)
    if Users.Players[steam] then return Error("An error occurred, player with steam "..steam.." is already loaded?") end

    local data = {
        ['connecting'] = true
    }
    
    local ordb = db

    if table.unpack(db) ~= nil then
        local CurrentData = json.decode(table.unpack(db)['data'])
        if CurrentData == nil then 
            data = default 
        else
            for k,v in pairs(default) do
                if CurrentData[k] == nil then
                    data[k] = v
                else
                    data[k] = CurrentData[k]
                end
            end
        end
    else data = default end


    if data['ban'] ~= nil and data['ban'] ~= 0 then
        Debug("User tried to join, but is banned")
        if def ~= true then def.done(Config:Format(Messages['Banned'], {reason = tostring(data['ban']),id = steam})) end
        return
    end

    data['src'] = source

    local idd = tostring(table.unpack(ordb)['id'])

    data['id'] = idd

    Users.Players[steam] = data 
    Users.FromId[idd] = steam

    if def ~= true then def.done() end

    if def ~= true then
        Wait(LoadDelay*1000)
        if Users.Players[steam] and Users.Players[steam]['connecting'] == true then
            DropPlayer(source, Messages['LoadDelay'])
        end
    else
        Users.Players[steam]['connecting'] = false
    end
end

Users.Funcs.Spawned = function()
    local source = source
    local steam = Users.Utility.GetSteam(source)
    print(steam)
    if Users.Players[steam] == nil then return Warn("User does not exist") end

    Users.Players[steam]['connecting'] = false
    Debug("Spawned")
end

Users.Funcs.Remove = function()
    local source = source
    local steam = Users.Utility.GetSteam(source)
    print(steam)
    
    if Users.Players[steam] == nil then
        return Warn("A user left the server, but was not registered? Please check this out.")
    end

    local data = Users.Players[steam]
    data['connecting'] = nil
    data['steam'] = nil
    data['src'] = nil

    Users.FromId[data.id] = nil
    data['id'] = nil

    Debug("Saved: "..json.encode(data))

    MySQL.query.await('UPDATE users SET data = ? WHERE steam = ?', {json.encode(data),steam})

    Users.Players[steam] = nil
end

-- events
AddEventHandler('playerDropped', Users.Funcs.Remove)
AddEventHandler("playerConnecting", Users.Funcs.Create)
RegisterNetEvent("Sparkling:Spawned", Users.Funcs.Spawned)

Sparkling.Users = Users.Funcs