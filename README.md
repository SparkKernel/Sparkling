# ✨ Sparkling - A framework made by frackz
Welcome to Sparkling, a currently open-source framework. Made by frackz, has features like Extensions, inbuilt logging, events, etc.



This is currently just the framework, so if you want to work with it - you need to have some Extension.


### Extensions.
A method for uploading and getting a component from Spark

#### Example of an Extension.
```lua
local Sparkling = exports['sparkling']:Spark()
local Extension = Sparking:Extensions()

local MyExtension = Extension:New()

function MyExtension:Print(message)
   print(message)
end

Extension:Add('MyExtension', MyExtension)
```
#### Example of getting a Extension.
```lua
local Sparkling = exports['sparkling']:Spark()
local Extension = Sparking:Extensions()

local MyExtension = Extension:Get('MyExtension')

MyExtension:Print("Welcome to Sparkling Extensions.")

-- output:
Welcome to Sparkling Extensions.
```

### Events
Events is just like Extensions, just for events - easy to setup. :)
#### Example of creating and running a event
```lua
local Sparkling = exports['sparkling']:Spark()
local Events = Sparkling:Events()

-- create
local newEvent = Events:Create('eventName')
-- running
newEvent:Run({"arguments", "here"})
```
#### Example of handling a event
```lua
local Sparkling = exports['sparkling']:Spark()
local Events = Sparkling:Events()

-- handler
Events:Handler('eventName', function(text)
    print(text)
end)
```
