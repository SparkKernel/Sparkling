local cfg = {} -- ignore

cfg.DB = 'data'

cfg.Tables = {
    users = {
        "id",
        "steam",
        "data"
    }
}

Config:Add('Lite', cfg) -- ignore