local function g(d)
    local h = 0
    for i = 1, #d do
        h = (h * 1337 + d:byte(i)) % 2^31
    end
    math.randomseed(h)

    local c = "abcdefghijklmnopqrstuvwxyz0123456789"
    local c2 = #c
    local o = {}
    for i = 1, 50 do
        local i2 = math.random(c2)
        o[i] = c:sub(i2, i2)
    end
    return table.concat(o)
end

local h2 = game:GetService("RbxAnalyticsService"):GetClientId()
if not h2 then
    game.Players.LocalPlayer:Kick("Please Make Sure Your Executor Supported.")
    return
end

local h3 = g(h2)
local h4 = "hwid.key"

if isfile(h4) then
    if readfile(h4) ~= h3 then
        writefile(h4, h3)
        game.Players.LocalPlayer:Kick("You Were Kicked Due Spoofing HWID Or Factory Reseted Device.")
        return
    end
else
    writefile(h4, h3)
end
