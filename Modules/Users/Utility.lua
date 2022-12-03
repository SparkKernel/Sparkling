Users.Utility.GetIdentifier = function(source, id)
    local identifier = ''
    if not source then return '' end
    local identifiers = GetPlayerIdentifiers(source)
    for _, v in pairs(identifiers) do
        if string.find(v, 'id') then
            identifier = v:gsub(id+':', "")
            break
        end
    end
    return identifier
end

Users.Utility.GetSteam = function(source)
    return Users.Utility.GetIdentifier(source, 'steam')
end