local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local TweenService = game:GetService("TweenService")
_G.BaseTweenSpeed = 0.15 
_G.AutoTourActive = false
_G.ReverseTourActive = false
_G.PostWaveBuffer = 0.05 
_G.CelestialSoundID = "73087452882886" -- Your Default ID


local Window = Rayfield:CreateWindow({
   Name = "Escape Tsunami For Brainrots!",
   LoadingTitle = "Loading cool script",
   LoadingSubtitle = "by rtz_andruuux",
   ConfigurationSaving = {Enabled = true, FolderName = "TsunamiScript"},
   KeySystem = false,
})

local function GetNearestGapIndex()
    local gaps = workspace:FindFirstChild("Misc") and workspace.Misc:FindFirstChild("Gaps")
    local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not gaps or not hrp then return 1 end
    local nearestIndex, minDistance = 1, math.huge
    for i = 1, 9 do
        local gap = gaps:FindFirstChild("Gap" .. i)
        if gap then
            local dist = (hrp.Position - gap:GetModelCFrame().Position).Magnitude
            if dist < minDistance then
                minDistance, nearestIndex = dist, i
            end
        end
    end
    return nearestIndex
end

local function IsPathClear(targetPos)
    local tsunamiFolder = workspace:FindFirstChild("ActiveTsunamis")
    if not tsunamiFolder then return true end
    local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return true end
    local padding = 45
    local currentPos = hrp.Position
    local minX, maxX = math.min(currentPos.X, targetPos.X) - padding, math.max(currentPos.X, targetPos.X) + padding
    local minZ, maxZ = math.min(currentPos.Z, targetPos.Z) - padding, math.max(currentPos.Z, targetPos.Z) + padding
    for _, model in pairs(tsunamiFolder:GetChildren()) do
        for _, part in pairs(model:GetChildren()) do
            if part:IsA("BasePart") and string.find(string.lower(part.Name), "wave") then
                local wPos = part.Position
                if (wPos.X >= minX and wPos.X <= maxX) and (wPos.Z >= minZ and wPos.Z <= maxZ) then
                    return false 
                end
            end
        end
    end
    return true 
end

local function SmartMove(targetPos, areaName)
    local char = game.Players.LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if hrp then
        local finalSpeed = _G.BaseTweenSpeed
        local areaNum = tonumber(string.match(areaName, "%d+"))
        if areaNum and areaNum >= 6 then
            finalSpeed = _G.BaseTweenSpeed * 5.0 
        end
        local info = TweenInfo.new(finalSpeed, Enum.EasingStyle.Linear)
        local tween = TweenService:Create(hrp, info, {CFrame = CFrame.new(targetPos)})
        tween:Play()
        tween.Completed:Wait()
    end
end

local MainTab = Window:CreateTab("Main", 4483362458)
local AutoTab = Window:CreateTab("Auto", 4483345998)
local TeleportTab = Window:CreateTab("Teleport", 4483362458)

MainTab:CreateSection("General")
MainTab:CreateButton({Name = "Infinite Yield", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))() end})
MainTab:CreateButton({
    Name = "Copy Discord Link",
    Callback = function()
        setclipboard("https://discord.gg/J9dSv7hq55")
        Rayfield:Notify({
            Title = "Discord Copied!",
            Content = "Link copied to clipboard (https://discord.gg/J9dSv7hq55)",
            Duration = 5
        })
    end
})

AutoTab:CreateSection("Farming")
AutoTab:CreateToggle({
   Name = "Auto collect money",
   CurrentValue = false,
   Flag = "MagicCollect",
   Callback = function(state)
       _G.MagicCollect = state
       task.spawn(function()
           while _G.MagicCollect do
               local root = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
               if root then
                   for _, v in pairs(workspace:GetDescendants()) do
                       if v.Name == "Collect" and v:IsA("BasePart") then
                           firetouchinterest(root, v, 0)
                           task.wait()
                           firetouchinterest(root, v, 1)
                       end
                   end
               end
               task.wait(1)
           end
       end)
   end,
})

AutoTab:CreateSection("Alerts")
AutoTab:CreateToggle({
   Name = "Celestial Alerter",
   CurrentValue = false,
   Callback = function(state)
       _G.CelestialNotifier = state
       if state then
           task.spawn(function()
               while _G.CelestialNotifier do
                   pcall(function()
                       local brainrots = workspace:FindFirstChild("ActiveBrainrots")
                       local celestialFolder = brainrots and brainrots:FindFirstChild("Celestial")
                       
                       if celestialFolder and #celestialFolder:GetChildren() > 0 then
                           local s = Instance.new("Sound", game:GetService("SoundService"))
                           s.SoundId = "rbxassetid://" .. tostring(_G.CelestialSoundID)
                           s.Volume = 1
                           s:Play()
                           
                           Rayfield:Notify({
                               Title = "CELESTIAL DETECTED!",
                               Content = "idk celestial detected",
                               Duration = 10
                           })
                           task.wait(15) 
                       end
                   end)
                   task.wait(2)
               end
           end)
       end
   end,
})

AutoTab:CreateInput({
   Name = "Celestial Sound ID",
   PlaceholderText = "Paste ID here...",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      _G.CelestialSoundID = Text
   end,
})

TeleportTab:CreateSection("Auto Teleport")
TeleportTab:CreateButton({
    Name = "STOP TELEPORT",
    Callback = function()
        _G.AutoTourActive = false
        _G.ReverseTourActive = false
        Rayfield:Notify({
            Title = "Stopped",
            Content = "Auto teleport deactivated.",
            Duration = 2
        })
    end
})

TeleportTab:CreateToggle({
   Name = "Start auto teleport",
   CurrentValue = false,
   Callback = function(state)
       _G.AutoTourActive = state
       if state then
           _G.ReverseTourActive = false
           task.spawn(function()
               local gaps = workspace.Misc.Gaps
               while _G.AutoTourActive do
                   local currentPosIndex = GetNearestGapIndex()
                   for i = 1, 9 do
                       if not _G.AutoTourActive then break end
                       if i > currentPosIndex or (i == 1 and currentPosIndex == 9) then
                           local target = gaps:FindFirstChild("Gap" .. i)
                           if target then
                               local targetPos = (target:GetModelCFrame() * CFrame.new(0, -2, 0)).Position
                               while not IsPathClear(targetPos) and _G.AutoTourActive do task.wait(0.1) end
                               SmartMove(targetPos, "Gap" .. i)
                               task.wait(1.5) 
                           end
                       end
                   end
                   task.wait(2) 
               end
           end)
       end
   end,
})

TeleportTab:CreateToggle({
   Name = "Starts reverse auto",
   CurrentValue = false,
   Callback = function(state)
       _G.ReverseTourActive = state
       if state then
           _G.AutoTourActive = false
           task.spawn(function()
               local gaps = workspace.Misc.Gaps
               while _G.ReverseTourActive do
                   local currentPosIndex = GetNearestGapIndex()
                   if currentPosIndex > 1 then
                       for i = currentPosIndex - 1, 1, -1 do
                           if not _G.ReverseTourActive then break end
                           local target = gaps:FindFirstChild("Gap" .. i)
                           if target then
                               local targetPos = (target:GetModelCFrame() * CFrame.new(0, -2, 0)).Position
                               while not IsPathClear(targetPos) and _G.ReverseTourActive do task.wait(0.1) end
                               SmartMove(targetPos, "Gap" .. i)
                               task.wait(1.5) 
                           end
                       end
                   end
                   task.wait(2) 
               end
           end)
       end
   end,
})

TeleportTab:CreateSection("Direct Zone Teleport")
for i = 1, 9 do
    TeleportTab:CreateButton({
        Name = "TP zona " .. i,
        Callback = function()
            local target = workspace.Misc.Gaps:FindFirstChild("Gap" .. i)
            if target then
                local targetPos = (target:GetModelCFrame() * CFrame.new(0, -2, 0)).Position
                SmartMove(targetPos, "Gap" .. i)
                Rayfield:Notify({
                    Title = "Teleported",
                    Content = "Moved to Zone " .. i,
                    Duration = 3
                })
            end
        end
    })
end
