Users = {}
Users.Funcs = {}
Users.Players = {}
Users.FromId = {} -- (id:) (steam hex)
Users.Utility = {}

local cfg = Config:Get('Player')
local standardDefault = cfg:Get('Default')
local default = standardDefault
default['connecting'] = true
default['interface'] = {}
default['noclip'] = false

local Errors = cfg:Get('Errors')
local Messages = cfg:Get('Messages')
local LoadDelay = cfg:Get('LoadDelay')
local NonSaving = cfg:Get('NonSaving')

local cfg2 = Config:Get('Group')

local Groups = cfg2:Get('Groups')

SpawnHandler = {}
QuitHandler = nil -- wil be defined in QuitHandler.lua

UserDB = DB:Get('users')

function Users.Funcs:Get(source, cb)
    local callback = false
    if cb ~= nil then callback = true end
    local steam
    if type(source) == "string" then 
        if tonumber(source) then -- is id
            if not Users.FromId[source] and not callback then -- do
                local resp = UserDB:GetData({id = source})
                if resp == nil then Error("Cannot find user by id!", 'Sparkling', 'identifier: '..source, 'Modules/Users/Handler.lua') return nil end
                steam = resp['steam']
            elseif Users.FromId[source] and not callback then
                steam = Users.FromId[source]
            else
                local resp = UserDB:GetData({id = source})
                if resp == nil then Error("Cannot find user by id!", 'Sparkling', 'identifier: '..source, 'Modules/Users/Handler.lua') return nil end
                steam = resp['steam']

                cb(PlayerObject(steam, true))
            end
        else
            steam=source -- if is steam-hex
        end
    else
        steam = Users.Utility.GetSteam(source)
        if steam == '' then Warn("Cannot find user") end
    end

    return PlayerObject(steam, callback)
end

Users.Funcs.Create = function(_, _, def)
    local source = source
    local steam = Users.Utility.GetSteam(source) -- get steam

    def.defer()

    if steam == '' then return def.done(Errors['SteamError']) end

    Wait(0) -- wait

    def.update(Messages['Checking'])

    local resp = UserDB:GetData({steam = steam})

    Debug("A user joined "..steam)

    if resp ~= nil then
        def.update(Messages['Registered'])
        Debug("User already registered")
    else
        Debug("Creating user "..steam)
        def.update(Messages['Creating'])

        UserDB:InsertData({
            steam = steam,
            id = UserDB:GetMaxValue('id') or 1,
            data = nil
        })
        resp = UserDB:GetData({steam = steam}) -- get
    end
    Users.Funcs.Load(source, steam, resp, def)

    def.done()
end

Users.Funcs.Load = function(source, steam, db, def)
    if Users.Players[steam] then return Debug("Player is already registered!", 'Sparkling', 'steam: '..steam) end

    local data = {
        ['connecting'] = true,
        ['interface'] = {},
        ['noclip'] = false
    }
    
    if db ~= nil then
        local CurrentData = json.decode(db['data'])
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

    if data['ban'] ~= nil and data['ban'] ~= 0 then -- user is banned
        Debug("User tried to join, but is banned")
        if def ~= true then def.done(Config:Format(Messages['Banned'], {reason = tostring(data['ban']),id = steam})) end
        return
    end

    local id = tostring(db['id'])

    data['src'] = source
    data['id'] = id

    Users.Players[steam] = data 
    Users.FromId[id] = steam

    if def ~= true then
        def.done()
        Wait(LoadDelay*1000)
        if Users.Players[steam] and Users.Players[steam]['connecting'] == true then DropPlayer(source, Messages['LoadDelay']) end
    else
        Users.Funcs.Spawned(source)
    end
end

Users.Funcs.Spawned = function(src)
    local source = source
    if tonumber(src) then source=src end
    
    local steam = Users.Utility.GetSteam(source)
    if Users.Players[steam] == nil then return Warn("User does not exist") end
    
    local wasConnected = false
    if not Users.Players[steam].connecting then
        wasConnected = true
        return Debug("User spawned, but is already registered - user probaly died...")
    end

    if not tonumber(src) then
        Debug("Spawned: "..steam)
    else
        Debug("Debugly spawned user "..steam)
    end

    if not wasConnected then
        for k,v in pairs(Users.Players[steam]['groups']) do
            if not Groups[v] then break end
            Groups[v]['Events']['OnSpawn'](PlayerObject(steam))
        end
    end

    for k,v in pairs(SpawnHandler) do
        v(PlayerObject(steam), Users.Players[steam])
    end

    Users.Players[steam]['connecting'] = false -- user is now connected, and is spawned (so the user doesn't get kicked)
end

Users.Funcs.Remove = function()
    local source = source
    local steam = Users.Utility.GetSteam(source)
    
    Debug("User removed: "..steam)
    
    if Users.Players[steam] == nil then return Warn("A user left the server, but was not registered? Please check this out.") end

    local data = Users.Players[steam]
    data = QuitHandler(PlayerObject(steam), Users.Players[steam], data)
    Users.Players[steam]['quitting'] = true

    Users.FromId[data.id] = nil
    for i,v in pairs(NonSaving) do
        data[v] = nil
    end

    Debug("Saved data from user ("..steam.."): "..json.encode(data))

    Users.Players[steam] = nil -- removes the user for good

    UserDB:Update({
        steam = steam
    },
    {
        data = json.encode(data, {indent=true})
    })
end

-- events
AddEventHandler('playerDropped', Users.Funcs.Remove)
AddEventHandler("playerConnecting", Users.Funcs.Create)
RegisterNetEvent("Sparkling:Spawned", Users.Funcs.Spawned)

Sparkling.Users = Users.Funcs