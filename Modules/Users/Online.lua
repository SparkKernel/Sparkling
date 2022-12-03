local cfg = Config:Get('Player')
local DebugLoad = cfg:Get('DebugLoad')

CreateThread(function()
    if DebugLoad then
        for _, src in ipairs(GetPlayers()) do
            local steam = Users.Utility.GetSteam(src)
            local resp = SQL.Sync('SELECT * FROM users WHERE steam = ?', {steam})
        
            Debug("Automatic load of player "..steam)
            
            Users.Funcs.Load(src,steam,resp,true)
        end
    end
end)