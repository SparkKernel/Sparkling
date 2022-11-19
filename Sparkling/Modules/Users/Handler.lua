Users = {}
Users.Funcs = {}
Users.Players = {
    
}
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
    else
        steam = Users.Utility.GetSteam(source)
        if steam == '' then 
            Error("Cannot find user")
        end
    end

    return PlayerObject(
        steam
    )
end

Users.Funcs.Create = function(_, _, def)
    local source=source
    local steam = Users.Utility.GetSteam(source) -- get steam

    def.defer() -- defer

    if steam == '' then return def.done(Errors['SteamError']) end

    Wait(0)

    def.update(Messages['Checking'])

    local resp = MySQL.query.await('SELECT * FROM users WHERE id = ?', {steam})

    Debug("A user joined "..steam)

    if table.unpack(resp) ~= nil then
        def.update(Messages['Registered'])
        Debug("User already registered")
    else
        Debug("Creating user "..steam)

        def.update(Messages['Creating'])

        MySQL.query.await('INSERT INTO users (id) VALUES (?)', {steam})
    end
    Users.Funcs.Load(source, steam, resp, def)


    def.done()
end

Users.Funcs.Load = function(source, steam, db, def)
    if Users.Players[steam] then return Error("An error occurred, player with steam "..steam.." is already loaded?") end

    local data = {
        ['connecting'] = true
    }

    if table.unpack(db) ~= nil then
        if json.decode(table.unpack(db)['data']) ~= nil then
            db = json.decode(table.unpack(db)['data'])
            for k,v in pairs(default) do
                --Debug("K: "..tostring(k).." V: "..tostring(v).." DB[K]: "..tostring(db[k]))
                if db[k] == nil then
                    data[k] = v
                else
                    data[k] = db[k]
                end
            end
        else
            Debug("Default 2")
            data = default
        end
    else
        Debug("Default 1")
        data = default
    end


    if data['ban'] ~= nil and data['ban'] ~= 0 then
        Debug("User tried to join, but is banned")
        if def ~= true then 
            def.done(
                Config:Format(Messages['Banned'], {
                    reason = tostring(data['ban']),
                    id = steam
                })
            )
        end
        return
    end

    data['src'] = source

    Users.Players[steam] = data
    print("HEY")

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
    if Users.Players[steam] == nil then
        return Debug("User does not exist")
    end

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
    data['id'] = nil
    data['src'] = nil

    Debug("Saved: "..json.encode(data))

    MySQL.query.await(
        'UPDATE users SET data = ? WHERE id = ?', 
        {
            json.encode(data),
            steam
        }
    )
    Users.Players[steam] = nil
end

AddEventHandler('playerDropped', Users.Funcs.Remove)
AddEventHandler("playerConnecting", Users.Funcs.Create)
RegisterNetEvent("Sparkling:Spawned", Users.Funcs.Spawned)

Sparkling.Users = Users.Funcs