local Object = function(id)
    local self = {}

    local function Get() return Users.Players[id] or nil end

    self.Clipboard = {}
    function self.Clipboard:Copy(text) -- copies text to clipboard of user
        local user = Get()
        if user == nil then return false end

        TriggerClientEvent('Sparkling:SendNuiMessage', user.src, {
            clip = true,
            text = text
        })
    end

    function self:Send(data)
        local user = Get()
        if user == nil then return false end

        TriggerClientEvent('Sparkling:SendNuiMessage', user.src, data)
    end

    return self
end

PlayerObjects:Add({
    name = "NUI",
    object = Object
})