local whitelist = {
    ["2av9fft20mwg5b4hz8wnr4rv8op2hb8k7lhof3fk65432774ep"] = true,
    ["ez"] = true,
}

if not isfile("hwid.key") then
    game.Players.LocalPlayer:Kick("Missing HWID")
    return
end

local hwid = readfile("hwid.key")
if not whitelist[hwid] then
    game.Players.LocalPlayer:Kick("Sign Up In Discord.gg/hnq9AGVMwq")
end
