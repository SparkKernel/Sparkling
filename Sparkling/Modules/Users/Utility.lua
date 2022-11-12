Users.Utility.GetSteam = function()
    local source = source
    
    local steam = ''
    local identifiers = GetPlayerIdentifiers(source)
    for _, v in pairs(identifiers) do
        if string.find(v, "steam") then
            steam = v:gsub("steam:", "")
            break
        end
    end
    return steam
end