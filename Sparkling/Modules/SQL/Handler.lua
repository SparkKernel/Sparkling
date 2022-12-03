SQL = {}

local SparkSQL = exports.Sparkling

local cfg = Config:Get('Database')

SparkSQL:createConnection(
    cfg:Get('Info'),
    function()
        Success("Connected to DB", 'SparkDB')
    end,
    function(err)
        Error("Couldn't connect to DB ["..err.."]", 'SparkDB')
    end
) -- create connection

function SQL.query(query, params, cb)
    SparkSQL:query(query, params, cb)
end

function SQL.sync(query, params)
    local data = nil
    SQL.query(query, params, function(result)
        print("RES "..json.encode(result))
        data = result
    end)    

    repeat
        Wait(50)
    until
        data ~= nil

    return data
end

local data = SQL.sync('SELECT * FROM users', {})
print("D:"..tostring(data))