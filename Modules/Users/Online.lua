local cfg = Config:Get('Player')
local DebugLoad = cfg:Get('DebugLoad')

CreateThread(function()
    if DebugLoad then
        for _, src in ipairs(GetPlayers()) do
            local steam = Users.Utility.GetSteam(src)
            local resp = UserDB:GetData({steam = steam})

            Debug("Automatic load of player "..steam)
            Wait(500)
            Users.Funcs.Load(src,steam,resp,true)
        end
    end
end)