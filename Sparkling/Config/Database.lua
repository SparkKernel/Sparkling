local cfg = {} -- ignore

cfg.Info = {
    user = "root",
    password = "",
    host = "localhost",
    database = "spark",
    port = 3306,
    connectionLimit = 10,
    dateStrings = true
}

Config:Add('Database', cfg) -- ignore