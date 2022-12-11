SparkClient = {}

RegisterNetEvent("Sparkling:AddClientFunction", function(name, func)
    local source = source
    func(source)
    if SparkClient[name] ~= nil then return end

    SparkClient[name] = func
end)