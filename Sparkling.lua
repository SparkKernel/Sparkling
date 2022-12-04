-- Main resource for Sparkling

Sparks = {}

SQL.Execute([[
    CREATE TABLE IF NOT EXISTS users(
        id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
        steam varchar(255) NOT NULL,
        data LONGTEXT DEFAULT NULL
    );
]])

Success("Main module loaded!")

function Spark() return Sparks end