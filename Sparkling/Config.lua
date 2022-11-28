local Configs = {}
Configs.List = {}

Config = {}

function interp(s, tab) return (s:gsub('(@%b{})', function(w) return tab[w:sub(3, -2)] or w end)) end

function Config:Format(s, args)
    return interp(s,args)
end

function Config:Get(file)
    if Configs.List[file] == nil then return end
    local file = Configs.List[file]

    local self = {}

    function self:Get(key, args)
        args = args or nil
        if file[key] == nil then return end
        if args ~= nil then return interp(file[key], args) end
        return file[key]
    end

    return self
end

function Config:Add(file, table)
    if Configs.List[file] then return end
    Configs.List[file] = table
end