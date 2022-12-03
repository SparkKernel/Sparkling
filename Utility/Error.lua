local function newDebug(color)
    return function(reason, name)
        name = name or 'Sparkling'
        print("\27["..color.."["..name.."] "..reason.."\27[0m")
    end
end

Error = newDebug('31;1m')
Debug = newDebug('34;1m')
Warn = newDebug('33m')
Success = newDebug('0;92m')