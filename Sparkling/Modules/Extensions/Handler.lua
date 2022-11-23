Sparkling = exports['Sparkling']:Spark()

Extension = {}
Extension.Funcs = {}
Extension.Events = {}
Extension.Registered = {}

function Extension.Funcs:Get(name)
    if Extension.Registered[name] == nil then return Error("Cannot find extension with name "..name.." as requested!") end 
    return Extension.Registered[name]
end

function Extension.Funcs:Delete(name)
    if Extension.Registered[name] == nil then return Error("Tried to remove extension extension, but there is no extension with that name! (name="..name..")") end
    Extension.Registered[name] = nil
end