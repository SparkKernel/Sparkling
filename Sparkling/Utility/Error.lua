Error = function(reason, name)
    name = name or 'Sparkling'
    print('\27[31;1m["..name.."] '..reason..'\27[0m')
end

Debug = function(reason, name)
    name = name or 'Sparkling'
    print("\27[34;1m["..name.."] "..reason.."\27[0m")
end

Warn = function(reason, name)
    name = name or 'Sparkling'
    print("\27[33m["..name.."] "..reason.."\27[0m")
end

Success = function(reason, name)
    name = name or 'Sparkling'
    print("\27[0;92m["..name.."] "..reason.."\27[0m")
end