Sparks = {}

MySQL.execute([[
    CREATE TABLE IF NOT EXISTS users(
        id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
        steam varchar(255) NOT NULL,
        data LONGTEXT DEFAULT NULL
    );
]])

--print(SQL.query('SELECT * FROM users WHERE license = ?', {"1"}))

print("[Sparkling] Loaded main module!")

exports('Spark', function()
    return Sparks
end)
exports('GetConfig', function()
    return Config
end)