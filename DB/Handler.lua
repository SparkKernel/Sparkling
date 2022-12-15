DB = {}

local cfg = Config:Get('Lite')

local tables = {}

local success = function(text) Success(text) end
local errr = function(err) Error(err) end
local table = function(err) table.insert(tables, tabel) end

local d = exports.Sparkling:createLiteCon(cfg:Get('DB'), success, errr, table)
tables = d.tables
function DB:Create(name, data)
    d.class.tableCreate(name, data)
end

function DB:CreateIfNotExists(name, data)
    if not d.class.tableExists(name) then
        d.class.tableCreate(name, data)
        return true
    else return false
    end
end

function DB:Exists(name)
    return d.class.tableExists(name)
end

function DB:Get(table)
    local found = false
    for i,v in pairs(tables) do
        if v == table then
            found = true
            break
        end
    end
    if found == false then Error("Cannot find table") end
    local r = {}
    function r:Exists() return true end

    function r:GetData(identifiers) return d.class.getDataWhere(table, identifiers) end
    function r:GetAll(identifiers) return d.class.getAllDataWhere(table, identifiers) end
    function r:InsertData(data) d.class.insertData(table, data) end
    function r:Remove(identifiers) d.class.removeOnce(table, identifiers) end

    return r
end