local Sparkling = exports['Sparkling']:Spark()

local Extensions = Sparkling:Extensions()
local Extension = Extensions:New('Testing')

local Events = Extension:Events()

Events:Add('123')

function Extension:Bob()
    print("HEY")
end

Extension:Add(Extension)