local Sparkling = exports['Sparkling']:Spark()
local Extensions = Sparkling.Extensions

local myEx = Extensions:New('bob')

myEx.Events:Add('123')

myEx:Add(myEx)

Extensions:Get('bob').Events:Handle('123', function() print("bob123") end)

local Events = Extensions:Get('bob').Events

if Events:Exist('123') then
    Events:Get('123'):Run({"123"})
end
