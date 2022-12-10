local cfg = {} -- ignore

cfg.PlayerWeight = 30 -- the max weight

cfg.Items = {
    Pistol = {
        Weight = 1.35,
        Display = 'Pistol',
        Description = 'A Pistol gun',
        Usable = true
    }
}

Config:Add('Items', cfg) -- ignore