# Sparkling - A framework made by frackz
Welcome to Sparkling, a currently closed-based framework. Made by frackz, has features like experiences, inbuilt logging, etc.



This is currently just the framework, so if you want to work with it - you need to have some experience.


### Experiences.
Experiences is for functions that third-party scripts can make. So if you make a "robbery" script for example - and you want your customers to have a "api" for your script, you can use experiences.

#### Example of an experience.
```lua
local Sparkling = exports['sparkling']:Spark()
local Experience = Sparking:Experience()

local MyExperience = Experience:New()

function MyExperience:Print(message)
   print(message)
end

Experience:Add('MyExperience', MyExperience)
```
#### Example of getting a experience.
```lua
local Sparkling = exports['sparkling']:Spark()
local Experience = Sparking:Experience()

local MyExperience = Experience:Get('MyExperience')

MyExperience:Print("Welcome to Sparkling experiences.")

-- output:
Welcome to Sparkling experiences.
```

### Events
Events is just like experiences, just for events - easy to setup. :)
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
