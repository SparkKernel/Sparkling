local Sparkling = exports['Sparkling']:Spark()
local Extensions = Sparkling:Extensions()

local Ex = Extensions:Get('Testing')

local Events = Ex:Events()

Events:Handle('123', function()
    print("BOB")
end)

Ex:Bob()