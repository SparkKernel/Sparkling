Error = function(reason)
    print('\27[31;1m[Sparkling] '..reason..'\27[0m')
end

Debug = function(reason)
    print("\27[34;1m[Sparkling] "..reason.."\27[0m")
end

Warn = function(reason)
    print("\27[33m[Sparkling] "..reason.."\27[0m")
end

Success = function(reason)
    print("\27[0;92m[Sparkling] "..reason.."\27[0m")
end