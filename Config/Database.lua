local cfg = {} -- ignore

cfg.Info = { -- insert your data here
    host = "localhost",
    user = "root",
    password = "",
    database = "spark",
    port = 3306, -- dont touch if you dont know what you're doing
    connectionLimit = 10, -- ^^
    dateStrings = true -- ^^
}

Config:Add('Database', cfg) -- ignore