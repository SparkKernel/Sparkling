local Sparkling = exports['Sparkling']:Spark()
local Extensions = Sparkling:Extensions()

local myExtension = Extensions:New()

myExtension.Value = "lol"

function myExtension:bob()
    print("bob is cool lol")
end

Extensions:Add('myExtensionName', myExtension) 
