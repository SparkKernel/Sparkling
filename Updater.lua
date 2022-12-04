-- This handles new updates, and if the new update is a emergency, it will warn the user for good.

local Url = 'https://raw.githubusercontent.com/SparkKernel/Sparkling/main/data.json'

local CurrentVersion = '1.0'

local MakeRequest = function(callback)
    PerformHttpRequest(Url, callback)
end

MakeRequest(function(_, result)
    local table = json.decode(result)

    local version = table['version']

    local emergincies = table['emergincies']

    if tonumber(CurrentVersion) > tonumber(version) then return Warn("Wait, why is your version higher than the newest? Hm....", 'Sparkling', 'Do not change your version.', 'Updater.lua') end

    for k,v in pairs(emergincies) do
        if tonumber(k) > tonumber(version) then return Warn("A error in our sparkling data file is found, please report this", 'Sparkling', 'Report at: https://discord.gg/XUP5hywRHn', 'Updater.lua') end
    end

    if version == CurrentVersion then
        Success("Nice version!", 'Sparkling', 'Your version is up to date', 'Updater.lua')
    else
        local emergency = emergincies[tostring(tonumber(CurrentVersion)+0.1)]
        if not emergency then return Error("Version is outdated, please update.") end
        Error("Please update, this version is outdated - the version is flagged as a emergency.", 'Sparkling', 'Update this version', 'Updater.lua')
        Warn("Please resolve this, ask for help in our discord server, if you can't do it :)", 'Sparkling', 'At: https://discord.gg/XUP5hywRHn', 'Updater.lua')
    end 
end)
