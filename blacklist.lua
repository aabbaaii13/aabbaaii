local blacklist = {
    ["hwid_1"] = true,
    ["hwid_2"] = true,
}

if not isfile("hwid.key") then
    game.Players.LocalPlayer:Kick("Missing HWID")
    return
end

local hwid = readfile("hwid.key")
if not blacklist[hwid] then
    game.Players.LocalPlayer:Kick("Patched")
end
