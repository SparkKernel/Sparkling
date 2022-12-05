local cfg = {} -- ignore

cfg.LoadDelay = 60 -- If user is not loaded after this, they will be kicked (to make sure exploiters wont bypass load)

cfg.Errors = {
    SteamError = "Whoops, seems that you doesn't have steam open."-- Error if user doesn't have a steam-identifier
}

cfg.RegenerationMultiplier = 0.2 -- Multiplier of regeneration

cfg.Messages = {
    Checking = "Checking your steam / data", -- This will show when its checking their data
    Registered = "You are already registered, loading in", -- This will show when a registered user is logging in
    Creating = "Creating your user...", -- This will show when its creating their user
    Banned = "Whoops, you are banned - for the reason: @{reason}", -- This will show if the user is banned
    LoadDelay = "A error occurred, you wasn't loaded after delay"
}

cfg.NonSaving = { -- ignore (if you don't know what you're doing)
    'connecting',
    'src',
    'id',
    'interface'
}

cfg.DebugLoad = true -- if this is true everytime you reload the resource, it will reload all players.

cfg.Default = { -- defualt data
    hp = 100,
    src = 0,
    ban = 0,
    whitelist = false,
    cash = 420,
    groups = {},
    inventory = {},
    survival = {
        hunger = 100,
        thirst = 100
    },
    identity = {
        first = 'Change',
        last = "Your name"
    }
}

Config:Add('Player', cfg) -- ignore