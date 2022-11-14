Users.Utility.GetSteam = function(source)
    local steam = ''
    if not source then return steam end
    local identifiers = GetPlayerIdentifiers(source)
    for _, v in pairs(identifiers) do
        if string.find(v, "steam") then
            steam = v:gsub("steam:", "")
            break
        end
    end
    return steam
end

function Users.Utility:GetUpdate(
    data
)   
    local get = data['get']
    local update = data['update']

    function call(args)
        SQL:query(update['query'], args)
    end

    local resp = SQL:query(get['query'], get['args'], function(db)

        local data = {
            ['raw'] = db,
            ['unpack'] = table.unpack(db)
        }

        get['callback'](data, call)
    end)
end