local Sparkling = Spark()

local Extension = {}
local Funcs = {}

function Sparkling:Extensions() return Funcs end

function Funcs:New() return {} end

function Funcs:Add(name, ext)
    if Extension[name] ~= nil then return print("[Sparkling] Tried to add a extension, but there is already a extension with that name! (name="..name..")") end
    Extension[name] = ext
    print("[Sparkling] Added extension with name "..name)
end

function Funcs:Get(name)
    if Extension[name] == nil then 
        return print("[Sparkling] Cannot find extension with name "..name.." as requested!")
    end
    return Extension[name]
end

function Funcs:Delete(name)
    if Extension[name] == nil then return print("[Sparkling] Tried to remove extension extension, but there is no extension with that name! (name="..name..")") end
    Extension[name] = nil
end