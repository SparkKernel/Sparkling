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

function SQL.Query(query, params, cb)
    SparkSQL:query(query, params, function(result)
        if result['sqlMessage'] then
            Error("Error occured while trying to execute query ["..tostring(result['sqlMessage']).."]", 'SparkDB')
            cb(false)
        else
            cb(result)
        end
    end)
end

function SQL.Sync(query, params)
    local p = promise.new()
    SQL.Query(query, params, function(result)
        if result ~= false then
            p:resolve(result)
        end
    end)

    return Citizen.Await(p)
end

function SQL.Execute(query)
    SQL.Query(query, {}, function() end)
end