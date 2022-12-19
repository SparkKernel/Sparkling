const fs = require('fs')
const root = GetResourcePath(GetCurrentResourceName());
const path = `${root}/DB/Data`

const invoke = async (cb,args) => setImmediate(() => cb(args))

class Connection {
    constructor(file, success, error, addTable) {
        this.file = file
        this.path = `${path}/${file}.json`
        this.success = success
        this.error = error
        this.addTable = addTable
        this.queue = false

        this.invoke = (type, text) => invoke(this[type], text)
        setInterval(() => {
            if (this.queue) this.dump()
            this.queue = false
        }, 3000)
        this.dump = () => fs.writeFileSync(this.path, JSON.stringify(this.data))
        

        if (fs.existsSync(this.path)) {
            this.data = JSON.parse(fs.readFileSync(this.path))
            this.invoke('success', 'Connected, already read before!')
        } else {
            this.data = {
                "registered": {},
                "data": {}
            }
            fs.writeFile(this.path, JSON.stringify(this.data), err => {
                if (err) return this.invoke('error', 'Cannot write to file '+this.file+', please fix this.')
                this.invoke('success', 'Created DB! Now ready for use')
            })
        }

        this.dump()
        
        this.tableExists = name => {return this.data.registered[name] != null}
        this.tableGetAll = () => {
            var table = []
            for (const [key] of Object.entries(this.data.registered)) table.push(key)
            return table
        }

        this.tableCreate = (name, data) => {
            if (this.tableExists(name)) return this.invoke('error', 'Table does already exist')

            this.data.registered[name] = data
            this.data.data[name] = []
            this.invoke('addTable', name)
            this.queue = true
        }

        this.tableGet = (name, red) => {
            if (!this.tableExists(name)) return this.invoke('error', 'Table does not already exist')
            return this.data[red][name]
        }

        this.checkKeys = (table, data) => {
            if (!this.tableExists(table)) return this.invoke('error', 'Table does not already exist')
            const tableData = this.tableGet(table, 'registered')

            for (const [key] of Object.entries(data)) if (!tableData.includes(key)) {
                this.invoke('error', 'Key '+key+' is not found! But is sent!')
                return false
            }
            return tableData
        }


        this.insertData = (table, data) => {
            const keys = this.checkKeys(table, data)
            if (!keys) return
            for (const [key] of Object.entries(data)) if (!keys.includes(key)) return console.log("Key is not found")
            this.data.data[table].push(data)
            this.queue = true
        }

        this.devGetData = (table, identifiers, value, dataFunc, isBreaking) => {
            if (!this.checkKeys(table, identifiers)) return
            const entries = Object.entries(identifiers)
            const [key,val] = entries[0]
            var data = value
            for (const e of this.data.data[table]) {
                var found = 0
                if (e[key] == val) for (const [key, val] of entries) 
                    if (e[key] != val) continue
                    else found += 1
                if (found == Object.keys(identifiers).length) {
                    data = dataFunc(data, e)
                    if (isBreaking) break
                }
            }
            return data
        }

        this.getDataWhere = (table, identifiers) => {
            const data = this.devGetData(table, identifiers, null, (_, e) => {
                return e
            }, true)
            if (data != null) return data
            else return null
        }

        this.getAllDataWhere = (table, identifiers) => {
            const data = this.devGetData(table, identifiers, [], (data, e) => {
                data.push(e)
                return data
            }, false)
            if (data.length == 0) return null
            else return data
        }

        this.removeOnce = (table, identifiers) => {
            if (!this.checkKeys(table, identifiers)) return
            this.devGetData(table, identifiers, null, (data, e, index) => {
                this.data.data[table].splice(index-1, index)
                return e
            }, true)
            this.queue = true
        }

        this.update = (table, identifiers, changes, fast) => {
            if (!this.checkKeys(table, identifiers)) return
            this.devGetData(table, identifiers, null, (data, e) => {
                const tableData = this.tableGet(table, 'registered')
                for (const [key, value] of Object.entries(changes)) {
                    if (tableData.includes(key)) e[key] = value
                    else this.invoke('error', 'Cannot find updated key ' + key)
                }
                return e, 0
            }, true)
            this.queue = true
            if (fast) this.dump()
        }

        this.maxValue = (table, op) => {
            const tableData = this.tableGet(table, 'registered')
            if (!tableData.includes(op)) {
                console.log("cannot find op")
                return 0
            }
            const allData = this.tableGet(table, 'data')
            var currentBest = null
            for (const e of allData) {
                if (e[op] > currentBest) {
                    currentBest = e[op]
                }
            }

            return currentBest
        }
    }
}

global.exports('createLiteCon', (file, success, error, addTable, tables) => {
    const connection = new Connection(file, success, error, addTable)
    for (const [key, val] of Object.entries(tables)) {
        if (!connection.tableExists(key)) {
            connection.tableCreate(key, val)
        }
    }
    return {
        tables: connection.tableGetAll(), 
        class: connection
    }
})