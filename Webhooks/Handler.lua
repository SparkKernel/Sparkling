--[[
    - @parameter: webhook (Is either from Config/Webhooks.lua inside Inbuilt by giving it a name, or just the URL)
    - ? not needed, but if you want data, you need this.

    - Webhooks:Get(webhook, ?callback) 
    -- @?callback this will run, and will give you if the get request was a success, and the data (table)

    - Webhooks:Send(webhook, data(table, or from Webhooks:Create()), ?callback)
    -- @?callback this will run, and will give you information if the sending of the webhook was a success

    - Webhooks:Create(content, username, avatar) (if username is nil, use default, same with avatar) ^^ used over

    - Webhooks:Delete(webhook, ?callback) deletes the webhook
    -- @?callback this will run, and will give you information if the sending of the webhook was a success
]]

Webhooks = {}

local cfg = Config:Get('Webhooks')
local Inbuilt = cfg:Get('Inbuilt')

local function checkStatus(status)
    if status == 204 then return true
    else return false
    end
end

local function SendHook(url, data, callback)
    PerformHttpRequest(url, function(status) if callback then callback(checkStatus(status)) end end, 'POST', json.encode(data), { ['Content-Type'] = 'application/json' })
end

local function GetHook(url, callback)
    PerformHttpRequest(url, function(status, data) callback(checkStatus(status), json.decode(data) or '') end, 'GET')
end

local function DeleteHook(url, callback)
    PerformHttpRequest(url, function(status) if callback then callback(checkStatus(status)) end end, 'DELETE', json.encode(data))
end

function Webhooks:Create(content, username, avatar)
    if content == nil then return end
    local data = {content = content}
    if username ~= nil then data['username'] = username end
    if avatar ~= nil then data['avatar'] = avatar end
    return data
end

function Webhooks:Send(webhook, data, callback)
    callback = callback or nil
    if Inbuilt[webhook] then SendHook(Inbuilt[webhook], data, callback)
    else SendHook(webhook, data, callback)
    end
end

function Webhooks:Get(webhook, callback)
    if not webhook or not callback then return end
    if Inbuilt[webhook] then GetHook(Inbuilt[webhook], callback)
    else GetHook(webhook, callback)
    end
end

function Webhooks:Delete(webhook, callback)
    callback = callback or nil
    if Inbuilt[webhook] then DeleteHook(Inbuilt[webhook], callback)
    else DeleteHook(webhook, callback)
    end
end