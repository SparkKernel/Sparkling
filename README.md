# ✨ Sparkling - A framework made by frackz
Welcome to Sparkling, a currently open-source framework. Made by frackz, has features like Extensions, inbuilt logging, events, etc.



This is currently just the framework, so if you want to work with it - you need to have some experience.


### Extensions.
A method for uploading and getting a component from Spark

#### Example of an Extension.
```lua
local Sparkling = exports['sparkling']:Spark()
local Extension = Sparking.Extensions

local MyExtension = Extension:New('MyExtension') -- Give the extension name

function MyExtension:Print(message)
   print(message)
end

Extension:Add(MyExtension)
```
#### Example of getting a Extension.
```lua
local Sparkling = exports['sparkling']:Spark()
local Extension = Sparking.Extensions

local MyExtension = Extension:Get('MyExtension')

MyExtension:Print("Welcome to Sparkling Extensions.")

-- output:
Welcome to Sparkling Extensions.
```
