Sparkling = Spark()

Extension = {}
Extension.Funcs = {}
Extension.Events = {}
Extension.Registered = {}

function Extension.Funcs:Get(name)
    if Extension.Registered[name] == nil then return Error("Cannot find extension!", 'Sparkling', 'name: '..name, 'Modules/Extensions/Handler.lua') end 
    return Extension.Registered[name]
end

function Extension.Funcs:Delete(name)
    if Extension.Registered[name] == nil then return Error("Tried to remove extension extension!", 'Sparkling', 'name: '..name, 'Modules/Extensions/Handler.lua') end
    Extension.Registered[name] = nil
end