Sparks = {}
SQL = exports.oxmysql

SQL:execute([[
    CREATE TABLE IF NOT EXISTS users(
        id INT AUTO_INCREMENT primary key NOT NULL,
        license varchar(255) NOT NULL,
        steam varchar(255) NOT NULL
    );
]])

--print(SQL.query('SELECT * FROM users WHERE license = ?', {"1"}))

print("[Sparkling] Loaded main module!")

function Spark() return Sparks end