Sparks = {}

SQL.Execute([[
    CREATE TABLE IF NOT EXISTS users(
        id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
        steam varchar(255) NOT NULL,
        data LONGTEXT DEFAULT NULL
    );
]])

--print(SQL.query('SELECT * FROM users WHERE license = ?', {"1"}))

print("[Sparkling] Loaded main module!")

function Spark() return Sparks end