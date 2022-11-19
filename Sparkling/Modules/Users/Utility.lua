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