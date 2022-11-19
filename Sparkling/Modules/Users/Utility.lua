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

    local resp = MySQL.query.await(get['query'], get['args'])

    local data = {
        ['raw'] = resp,
        ['unpack'] = table.unpack(resp)
    }

    get['callback'](data, call)
end