const {createConnection} = require('mysql2')

global.exports('createSQLConnection', (host, user, db) => {
    const con = createConnection({
        host: host,
        user: user,
        database: db
    })

    con.connect(err => {
        if (err) {
            console.log("[SparkDB] Cannot connect to DB ["+err+"]")
        } else {
            console.log("[SparkDB] Connected to DB!")
        }
    })

    const execute = (sql , params) => {
        return new Promise((resolve, reject) => {
            con.execute()
        })
    }
})