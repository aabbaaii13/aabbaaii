local a
a = hookfunction(game:GetService("Players").LocalPlayer.Kick, newcclosure(function(b, c)
    if typeof(c) == "string" and (c:find("swatted") or c:find("nuh uh") or c:find("try")) then
        return nil
    end
    return a(b, c)
end))
local function d()
    if game:GetService("Players").LocalPlayer:FindFirstChild("PlayerScripts") then
        if game:GetService("Players").LocalPlayer.PlayerScripts:FindFirstChild("QuitsAntiCheatLocal") then
            game:GetService("Players").LocalPlayer.PlayerScripts.QuitsAntiCheatLocal.Enabled = false
            game:GetService("Players").LocalPlayer.PlayerScripts.QuitsAntiCheatLocal:Destroy()
        end
        if game:GetService("Players").LocalPlayer.PlayerScripts:FindFirstChild("QuitsAntiCheatChecker") then
            game:GetService("Players").LocalPlayer.PlayerScripts.QuitsAntiCheatChecker.Enabled = false
            game:GetService("Players").LocalPlayer.PlayerScripts.QuitsAntiCheatChecker:Destroy()
        end
    end
end
task.spawn(function()
    setthreadidentity(2)
    while task.wait(1) do
        d()
    end
end)
d()
