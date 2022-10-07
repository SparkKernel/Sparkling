local Sparkling = Spark()

local Users = {}
local Funcs = {}
local Types = {
    ['steam'] = "steam",
    ['license'] = "license",
    ['id'] = "id",
}

function Sparkling:User() return Funcs end

function Funcs:Types()
    return {
        ['Steam'] = "steam",
        ['License'] = "license",
        ['ID'] = "id",
    }
end

function Funcs:Create(source)
    local rockstar = ''
    local steam = ''

    for k,v in pairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1, string.len("steam:")) == "steam:" then
            steam = v
        elseif string.sub(v, 1, string.len("license:")) == "license:" then
            rockstar = v
        end
    end
    print(steam, rockstar)
    SQL:query('INSERT INTO users (license, steam)', {rockstar, steam})
end

function Funcs:Get(type, src)
    if Types[type] == nil then print("[Sparkling] Cannot find get type (src="..src..", type="..type..")") end
    --print(type, src)
    local resp = SQL:query('SELECT * FROM users WHERE id = ?', {tostring(src)})
    print(resp)

    -- funcs and values to return
    function self:Group()
        local GRV = {}
        function GRV:Add(group)
            --print(group)
        end
        function GRV:Has(group)
            --print(group)
        end
        function GRV:Remove(group)
            
        end
        return GRV
    end

    function self:Cash()
        local MRV = {}
        function GRV:Add(cash)

        end
        function GRV:Set(cash)

        end
        function GRV:Get()

        end
        function GRV:Remove(cash)

        end
        function GRV:Payment(cash)

        end
        return MRV
    end

    function self:Survival()
        local SRV = {}
        function SRV:Types()
            return {
                ['hunger'] = "hunger",
                ['thirst'] = "thirst"
            }
        end
        function SRV:Add(type, cash)

        end
        function SRV:Set(type, cash)

        end
        function SRV:Get(type)

        end
        function SRV:Remove(type, cash)

        end
    end

    return self
end