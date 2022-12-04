SQL = {}

local SparkSQL = exports.Sparkling

local cfg = Config:Get('Database')

SparkSQL:createConnection(
    cfg:Get('Info'), -- use info from config
    function()
        Success("Connected to DB", 'SparkDB', 'host: '..cfg:Get('Info')['host']..', port: '..cfg:Get('Info')['port'], 'SQL/Handler.lua')
    end,
    function(err)
        Error("Cannot connect to DB", 'SparkDB', 'code: '..err.code, 'SQL/Handler.lua')
    end
)

function SQL:Query(query, params, cb)
    SparkSQL:query(query, params, function(result)
        if result['sqlMessage'] then
            Error("Error occured while trying to execute query", 'SparkDB', 'query: '..tostring(result['sqlMessage']), 'SQL/Handler.lua')
            cb(false)
        else
            cb(result)
        end
    end)
end

function SQL:Sync(query, params)
    local p = promise.new()
    SQL:Query(query, params, function(result)
        if result ~= false then
            p:resolve(result)
        end
    end)

    return Citizen.Await(p)
end

function SQL.Execute(query)
    SQL:Query(query, {}, function() end)
end