Sparks = {}
SQL = exports.oxmysql

SQL:execute([[
    CREATE TABLE IF NOT EXISTS users(
        id varchar(255) NOT NULL,
        data LONGTEXT NOT NULL
    );
]])

--print(SQL.query('SELECT * FROM users WHERE license = ?', {"1"}))

print("[Sparkling] Loaded main module!")

function Spark() return Sparks end