local Callbacks = {}

RegisterCallback = function(name, func)
    if Callbacks[name] ~= nil then return print("CALLBACK ALREADY EXISTS") end
    Callbacks[name] = func
end

RegisterNetEvent("Sparkling:TriggerClientCallback", function(name, callbackId, ...)
    if Callbacks[name] == nil then return print("CALLBACK DOES NOT EXIST") end
    local resp = Callbacks[name](...)
    TriggerServerEvent("Sparkling:ReturnClientCallback", callbackId, resp)
end)
