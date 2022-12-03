const {createPool} = require('mysql2')

const invoke = async (cb,args) => {
    setImmediate(() => cb(args))
}

var connection = null;

const createSQLConnection = (conURI, success, error) => {
    const con = createPool(conURI)

    con.getConnection((err, conn) => {
        if (err) return invoke(error, err)
        invoke(success, {})
        con.releaseConnection(conn)
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
    }).catch((err) => {
        invoke(cb, err)
    })
})

global.exports('createConnection', (connectionURI, suc, err) => createSQLConnection(connectionURI, suc, err))

