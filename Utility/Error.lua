local function newDebug(color)
    return function(reason, name, extra, file)
        name = name or 'Sparkling'
        if extra ~= nil then extra = ' | '..extra..' | ' else extra = '' end
        if file ~= nil then file = '('..file..')' else file = '' end
        print("\27["..color.."["..name.."] | "..reason..extra..file.."\27[0m")
    end
end

Error = newDebug('31;1m')
Debug = newDebug('34;1m')
Warn = newDebug('33m')
Success = newDebug('0;92m')

RegisterCommand('clearchat', function(source)
    TriggerClientEvent('chat:clear', source)
end)