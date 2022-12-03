const {createPool} = require('mysql')

const invoke = async (cb,args) => {
    setImmediate(() => cb(args))
}

var connection = null;

const createSQLConnection = (conURI) => {
    const con = createPool(conURI)

    con.getConnection(err => {
        if (err) return console.log("[SparkDB] Cannot connect to DB ["+err+"]")
        console.log("[SparkDB] Connected to DB!")
    })

    connection = con
}

const execute = (sql, params) => {
    return new Promise((resolve, reject) => {
        connection.query(
            sql,
            params,
            (err, result, fields) => {
                if (err) reject(err);
                resolve(result, fields)
            }
        )
    })
}

global.exports('query', (sql, params, cb) => {
    if (connection == null) return console.log("[SparkDB] Cannot execute query if connection is not made.")

    execute(sql, params).then((result, fields) => {
        invoke(cb, result)
    })    
})

global.exports('createConnection', (connectionURI, callback) => createSQLConnection(connectionURI))

