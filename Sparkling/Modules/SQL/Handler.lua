SQL = {}

local SparkSQL = exports.Sparkling

local cfg = Config:Get('Database')

SparkSQL:createConnection(cfg:Get('Info')) -- create connection

function SQL.query(query, params, cb)
    SparkSQL:query(query, params, cb)
end

function SQL.sync(query, params)
    local data = nil
    SQL.query(query, params, function(result)
        print("RES "..json.encode(result))
        data = result
    end)    

    CreateThread(function()
        repeat
            Wait(50)
        until
            data ~= nil
    end)

    return data
end

local data = SQL.sync('SELECT * FROM users', {})
print("D:"..tostring(data))