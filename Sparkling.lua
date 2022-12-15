-- Main resource for Sparkling

Sparks = {}

DB.CreateIfNotExists('users', {
    "id",
    "steam",
    "data"
})

Success("Main module loaded!")

function Spark() return Sparks end