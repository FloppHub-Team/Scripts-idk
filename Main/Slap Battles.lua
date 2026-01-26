local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local TeleportService = game:GetService("TeleportService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local FloppHubIntro = Instance.new("ScreenGui")
FloppHubIntro.Name = "FloppHubIntro"
FloppHubIntro.ResetOnSpawn = false
FloppHubIntro.IgnoreGuiInset = true
FloppHubIntro.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
FloppHubIntro.Parent = PlayerGui

local BlackFrame = Instance.new("Frame")
BlackFrame.Size = UDim2.fromScale(1, 1)
BlackFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
BlackFrame.BackgroundTransparency = 1
BlackFrame.Parent = FloppHubIntro

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(0.6, 0, 0.2, 0)
TitleLabel.Position = UDim2.new(0.5, 0, -0.2, 0)
TitleLabel.AnchorPoint = Vector2.new(0.5, 0.5)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "{ .•° Flopp Hub °•. }"
TitleLabel.TextScaled = true
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
TitleLabel.TextStrokeTransparency = 0.3
TitleLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
TitleLabel.Parent = FloppHubIntro

local UIGradient = Instance.new("UIGradient", TitleLabel)
UIGradient.Color = ColorSequence.new({
  ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
  ColorSequenceKeypoint.new(0.5, Color3.fromRGB(60, 0, 0)),
  ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
})
UIGradient.Rotation = 45

local SubtitleLabel = Instance.new("TextLabel")
SubtitleLabel.Size = UDim2.new(0, 200, 0, 25)
SubtitleLabel.Position = UDim2.new(0.5, 0, 0.58, 0)
SubtitleLabel.AnchorPoint = Vector2.new(0.5, 0.5)
SubtitleLabel.BackgroundTransparency = 1
SubtitleLabel.Text = "by rtz_andruuux"
SubtitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SubtitleLabel.TextTransparency = 1
SubtitleLabel.TextScaled = true
SubtitleLabel.Font = Enum.Font.Gotham
SubtitleLabel.Parent = FloppHubIntro

local ProgressBar = Instance.new("Frame")
ProgressBar.Size = UDim2.new(0, 0, 0.02, 0)
ProgressBar.Position = UDim2.new(0.5, 0, 0.85, 0)
ProgressBar.AnchorPoint = Vector2.new(0.5, 0)
ProgressBar.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
ProgressBar.BorderSizePixel = 0
ProgressBar.Parent = FloppHubIntro

local function PlayTween(instance, info, properties)
  return TweenService:Create(instance, info, properties)
end

PlayTween(BlackFrame, TweenInfo.new(0.5), {BackgroundTransparency = 0}):Play()
task.wait(0.6)
PlayTween(TitleLabel, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, 0, 0.4, 0)}):Play()
task.wait(1)
PlayTween(TitleLabel, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {TextSize = TitleLabel.TextSize * 1.05}):Play()
PlayTween(SubtitleLabel, TweenInfo.new(1), {TextTransparency = 0}):Play()
task.wait(1.2)

task.spawn(function()
  while SubtitleLabel and SubtitleLabel.Parent do
    PlayTween(SubtitleLabel, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {TextTransparency = 0.5}):Play()
    task.wait(1.2)
    PlayTween(SubtitleLabel, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {TextTransparency = 0}):Play()
    task.wait(1.2)
  end
end)

PlayTween(ProgressBar, TweenInfo.new(2, Enum.EasingStyle.Linear), {Size = UDim2.new(0.8, 0, 0.02, 0)}):Play()

local IntroSound = Instance.new("Sound")
IntroSound.SoundId = "rbxassetid://107004225739474"
IntroSound.Volume = 2
IntroSound.Parent = FloppHubIntro
IntroSound.PlayOnRemove = false
IntroSound:Play()

task.wait(2.5)
PlayTween(BlackFrame, TweenInfo.new(0.8), {BackgroundTransparency = 1}):Play()
PlayTween(TitleLabel, TweenInfo.new(0.8), {TextTransparency = 1}):Play()
PlayTween(SubtitleLabel, TweenInfo.new(0.8), {TextTransparency = 1}):Play()
PlayTween(ProgressBar, TweenInfo.new(0.8), {BackgroundTransparency = 1}):Play()
task.wait(1)
FloppHubIntro:Destroy()

local NotifyGui = game.Players.LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("NotifyGui") or Instance.new("ScreenGui")
NotifyGui.Name = "NotifyGui"
NotifyGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
NotifyGui.ResetOnSpawn = false

local NotifFolder = NotifyGui:FindFirstChild("NotifFolder") or Instance.new("Folder")
NotifFolder.Name = "NotifFolder"
NotifFolder.Parent = NotifyGui

local MAX_NOTIFS = 3
local NOTIF_WIDTH = 340
local NOTIF_HEIGHT = 90
local NOTIF_SPACING = 10
local NOTIF_POS_START = UDim2.new(1, -360, 1, -100)

function Notify(iconId, message, duration)
  duration = duration or 3
  iconId = iconId or 6031075932
  message = message or "Notification"

  for _, notif in ipairs(NotifFolder:GetChildren()) do
    if notif:IsA("Frame") then
      TweenService:Create(notif, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Position = UDim2.new(1, -360, 1, notif.Position.Y.Offset - NOTIF_HEIGHT + NOTIF_SPACING),
      }):Play()
    end
  end

  if MAX_NOTIFS <= #NotifFolder:GetChildren() then
    local firstNotif = NotifFolder:GetChildren()[1]
    if firstNotif then
      firstNotif:Destroy()
    end
  end

  local notifFrame = Instance.new("Frame")
  notifFrame.Size = UDim2.new(0, NOTIF_WIDTH, 0, NOTIF_HEIGHT)
  notifFrame.Position = UDim2.new(1, 360, 1, -100)
  notifFrame.AnchorPoint = Vector2.new(0, 1)
  notifFrame.BackgroundTransparency = 0
  notifFrame.BorderSizePixel = 0
  notifFrame.Parent = NotifFolder
  notifFrame.ZIndex = 10

  local gradient = Instance.new("UIGradient", notifFrame)
  gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 15, 15)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 0, 0))
  })

  Instance.new("UICorner", notifFrame).CornerRadius = UDim.new(0, 12)
  local stroke = Instance.new("UIStroke", notifFrame)
  stroke.Thickness = 2
  stroke.Color = Color3.fromRGB(255, 0, 70)
  stroke.Transparency = 0.1

  local icon = Instance.new("ImageLabel", notifFrame)
  icon.Size = UDim2.new(0, 70, 0, 70)
  icon.Position = UDim2.new(0, 10, 0.5, -35)
  icon.BackgroundTransparency = 1
  icon.Image = "rbxassetid://" .. tostring(iconId)
  icon.ZIndex = 11

  local text = Instance.new("TextLabel", notifFrame)
  text.Size = UDim2.new(1, -90, 1, -20)
  text.Position = UDim2.new(0, 90, 0, 5)
  text.BackgroundTransparency = 1
  text.Text = message
  text.TextColor3 = Color3.fromRGB(255, 255, 255)
  text.TextSize = 19
  text.Font = Enum.Font.GothamBold
  text.TextWrapped = true
  text.TextXAlignment = Enum.TextXAlignment.Left
  text.ZIndex = 11

  local footer = Instance.new("TextLabel", notifFrame)
  footer.Size = UDim2.new(0, 100, 0, 18)
  footer.Position = UDim2.new(1, -105, 1, -20)
  footer.BackgroundTransparency = 1
  footer.Text = "Flopp Hub"
  footer.TextColor3 = Color3.fromRGB(255, 0, 70)
  footer.TextSize = 14
  footer.Font = Enum.Font.GothamSemibold
  footer.TextXAlignment = Enum.TextXAlignment.Right
  footer.ZIndex = 12

  TweenService:Create(notifFrame, TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = NOTIF_POS_START}):Play()

  local sound = Instance.new("Sound", notifFrame)
  sound.SoundId = "rbxassetid://8486683243"
  sound.Volume = 1
  sound:Play()

  task.delay(duration, function()
    TweenService:Create(notifFrame, TweenInfo.new(0.45, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
      Position = UDim2.new(1, 360, 1, notifFrame.Position.Y.Offset),
    }):Play()
    task.wait(0.45)
    notifFrame:Destroy()
  end)
end

Notify(10734966248, "Welcome to Flopp Hub", 5)

local Lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Cat558-uz/Testaaa/refs/heads/main/LibTeste.txt"))()
local Window = Lib:MakeWindow({
  Title = "Flopp Hub : Slap Battles",
  SubTitle = "by rtz_andruuux",
  SaveFolder = "cracked | flopp lib v5.lua",
})

Window:AddMinimizeButton({
  Button = {
    Image = "rbxassetid://10734966248",
    BackgroundTransparency = 7,
  },
  Corner = {
    CornerRadius = UDim.new(0, 8),
  },
})

local HomeTab = Window:MakeTab({"| Home : Hacks End Your Profile", "menu"})
local CombatTab = Window:MakeTab({"| Slap : Combat/Aura", "User"})
local MovementTab = Window:MakeTab({"| Movement : Farming", "navigation"})
local EspTab = Window:MakeTab({"| Esp : Players", "Box"})
local TycoonTab = Window:MakeTab({"| Auto Click : Tycoon", "Sword"})
local FarmTab = Window:MakeTab({"| Farming : Methods", "Script"})
local ProtecTab = Window:MakeTab({"| Protection : ragdoll", "Shield"})

HomeTab:AddParagraph({"Executor", (typeof(identifyexecutor) == "function" and identifyexecutor()) or (typeof(getexecutorname) == "function" and getexecutorname()) or "Unknown"})
HomeTab:AddParagraph({"Nickname", LocalPlayer.Name})
HomeTab:AddParagraph({"Version", "v7.5"})

local ServerSection = HomeTab:AddSection({" Server"})
HomeTab:AddButton({
  Name = "Rejoin Server",
  Callback = function()
    Notify(10709806740, "Waiting to rejoin server", 3)
    TeleportService:Teleport(game.PlaceId, LocalPlayer)
  end,
})

HomeTab:AddButton({
  Name = "Copy Discord (FloppHub Team)",
  Callback = function()
    local url = "https://discord.gg/J9dSv7hq55"
    if setclipboard then
      setclipboard(url)
      Notify(10734966248, "URL Copied to clipboard!", 3)
    else
      print("setclipboard not supported. URL: " .. url)
      Notify(10734966248, "Executor not support copy to clipboard.", 3)
    end
  end,
})

HomeTab:AddButton({
  Name = "Open Console",
  Callback = function()
    print("Hi you opened console, [" .. LocalPlayer.Name .. "]")
    pcall(function()
      StarterGui:SetCore("DevConsoleVisible", true)
    end)
  end,
})

local autoWalkEnabled = false
local autoWalkConn = nil
local nextWalkUpdate = 0
local walkSpeed = 40
local detectionRadius = 200
local safeGroundDistance = 35
local minChangeTime = 0.15
local maxChangeTime = 0.5
local safeBounds = 115
local edgeIgnoreRadius = 95
local pullThreshold = 85
local emergencyThreshold = 95
local currentTargetPlayer = nil
local targetLockUntil = 0

local function distFromCenter(pos)
  return math.sqrt(pos.X^2 + pos.Z^2)
end

local function isSafe(pos)
  local rayParams = RaycastParams.new()
  rayParams.FilterType = Enum.RaycastFilterType.Blacklist
  rayParams.FilterDescendantsInstances = {LocalPlayer.Character}
  local origin = pos + Vector3.new(0, 5, 0)
  local direction = Vector3.new(0, -safeGroundDistance, 0)
  local result = workspace:Raycast(origin, direction, rayParams)
  return result ~= nil
end

local function getTargetPosition()
  local now = tick()
  local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
  if not hrp then return nil end

  if distFromCenter(hrp.Position) > emergencyThreshold then
    return Vector3.new(0, hrp.Position.Y, 0)
  end

  local target
  if currentTargetPlayer and currentTargetPlayer.Parent and currentTargetPlayer.Character and currentTargetPlayer.Character:FindFirstChild("HumanoidRootPart") and now < targetLockUntil then
    local pos = currentTargetPlayer.Character.HumanoidRootPart.Position
    if distFromCenter(pos) <= edgeIgnoreRadius then
      target = pos + Vector3.new(math.random(-12,12), 0, math.random(-12,12))
    else
      currentTargetPlayer = nil
      targetLockUntil = 0
    end
  end

  if not target then
    local minDist = math.huge
    local closestPlr = nil
    for _, plr in pairs(Players:GetPlayers()) do
      if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
        local plrPos = plr.Character.HumanoidRootPart.Position
        if distFromCenter(plrPos) <= edgeIgnoreRadius then
          local dist = (hrp.Position - plrPos).Magnitude
          if dist < minDist and dist <= detectionRadius then
            minDist = dist
            closestPlr = plr
          end
        end
      end
    end

    if closestPlr then
      currentTargetPlayer = closestPlr
      targetLockUntil = now + 1
      local pos = closestPlr.Character.HumanoidRootPart.Position
      target = pos + Vector3.new(math.random(-12,12), 0, math.random(-12,12))
    else
      currentTargetPlayer = nil
      targetLockUntil = 0
      local angle = math.rad(math.random(360))
      local distance = 12 + math.random() * 15
      target = hrp.Position + Vector3.new(math.cos(angle) * distance, 0, math.sin(angle) * distance)
    end
  end

  if distFromCenter(hrp.Position) > pullThreshold then
    local toCenter = -hrp.Position.Unit * 30
    target = target + toCenter
  end

  return Vector3.new(target.X, hrp.Position.Y, target.Z)
end

local function autoWalkLoop()
  local char = LocalPlayer.Character
  local hum = char and char:FindFirstChild("Humanoid")
  local hrp = char and char:FindFirstChild("HumanoidRootPart")

  if not autoWalkEnabled or not char or not hrp or not hum or hum.Health <= 0 then
    if hum then hum.WalkSpeed = 16 end
    if autoWalkConn then autoWalkConn:Disconnect(); autoWalkConn = nil end
    return
  end

  hum.WalkSpeed = walkSpeed
  if hrp.AssemblyLinearVelocity.Magnitude < 10 then nextWalkUpdate = tick() end

  if tick() >= nextWalkUpdate then
    local target = getTargetPosition()
    if not target then return end

    local safeTarget = target
    local attempts = 0
    while not isSafe(safeTarget) and attempts < 80 do
      safeTarget = target + Vector3.new(math.random(-30,30), 0, math.random(-30,30))
      attempts = attempts + 1
    end

    if not isSafe(safeTarget) then
      for i = 0, 7 do
        local angle = i * (math.pi / 4)
        local fbTarget = hrp.Position + Vector3.new(math.cos(angle) * 25, 0, math.sin(angle) * 25)
        if isSafe(fbTarget) then safeTarget = fbTarget; break end
      end
    end

    safeTarget = Vector3.new(math.clamp(safeTarget.X, -safeBounds, safeBounds), safeTarget.Y, math.clamp(safeTarget.Z, -safeBounds, safeBounds))
    hum:MoveTo(safeTarget)
    nextWalkUpdate = tick() + (minChangeTime + math.random() * (maxChangeTime - minChangeTime))
  end
end

local showAuraAnim = false
local auraParts = {}
local auraAnimConn = nil

local function toggleAuraAnim(enable)
  showAuraAnim = enable
  if enable then
    if not auraAnimConn then
      local segments = 64
      local thickness = 0.5
      local animationSpeed = 2
      local maxRadius = detectionRadius

      for i = 1, segments do
        local part = Instance.new("Part")
        part.Size = Vector3.new(thickness, thickness, 0)
        part.Transparency = 0.3
        part.Color = Color3.fromRGB(255, 165, 0)
        part.Material = Enum.Material.Neon
        part.CanCollide = false
        part.Anchored = true
        part.Parent = workspace
        table.insert(auraParts, part)
      end

      local animTime = 0
      auraAnimConn = RunService.Heartbeat:Connect(function(dt)
        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        animTime = animTime + dt
        local progress = (animTime % animationSpeed) / animationSpeed
        local currentRadius = maxRadius * progress

        if currentRadius < 1 then
          for _, p in ipairs(auraParts) do p.Transparency = 1 end
          return
        end

        for i, part in ipairs(auraParts) do
          local angle = (i - 1) / segments * math.pi * 2
          local nextAngle = i / segments * math.pi * 2
          local midAngle = (angle + nextAngle) / 2
          local tangentAngle = midAngle + math.pi/2
          local arcLength = (currentRadius * math.pi * 2) / segments * 1.05
          local pos = Vector3.new(math.cos(midAngle) * currentRadius, 0, math.sin(midAngle) * currentRadius)
          part.Size = Vector3.new(thickness, thickness, arcLength)
          part.CFrame = CFrame.new(hrp.Position + pos) * CFrame.Angles(0, tangentAngle, 0)
          part.Transparency = 0.3
        end
      end)
    end
  else
    if auraAnimConn then auraAnimConn:Disconnect(); auraAnimConn = nil end
    for _, p in ipairs(auraParts) do if p and p.Parent then p:Destroy() end end
    auraParts = {}
  end
end

MovementTab:AddToggle({
  Name = "Auto-Farm Walk",
  Default = false,
  Callback = function(v)
    autoWalkEnabled = v
    if v then
      nextWalkUpdate = tick()
      autoWalkConn = RunService.Heartbeat:Connect(autoWalkLoop)
    else
      if autoWalkConn then autoWalkConn:Disconnect(); autoWalkConn = nil end
      local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
      if hum then hum.WalkSpeed = 16 end
    end
  end
})

MovementTab:AddToggle({
  Name = "Aura Animation (Orange Circle)",
  Default = false,
  Callback = function(v)
    toggleAuraAnim(v)
  end
})

MovementTab:AddButton({
  Name = "TP Island",
  Callback = function()
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then hrp.CFrame = CFrame.new(-7.40, -5.17, 2.60) end
  end
})

local FloatSection = MovementTab:AddSection({" Float Settings"})
local floatActive = false
local floatParts = {}
local function CreatePlatform(offset)
  local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
  if not hrp then return nil end
  local p = Instance.new("Part")
  p.Anchored = true
  p.CanCollide = true
  p.Transparency = 1
  p.Size = Vector3.new(6, 1, 6)
  p.CFrame = CFrame.new(hrp.Position.X, hrp.Position.Y - offset, hrp.Position.Z)
  p.Parent = workspace
  return p
end

task.spawn(function()
  while task.wait(0.05) do
    if floatActive then
      local p = CreatePlatform(3)
      if p then
        table.insert(floatParts, p)
        task.delay(0.5, function() if p and p.Parent then p:Destroy() end end)
      end
    end
  end
end)

UserInputService.JumpRequest:Connect(function()
end)

MovementTab:AddToggle({
  Name = "Float Bypass (Safe Method)",
  Default = false,
  Callback = function(v)
    floatActive = v
    if not v then
      for _, p in ipairs(floatParts) do if p and p.Parent then p:Destroy() end end
      table.clear(floatParts)
    end
  end
})

local autoParryEnabled = false
local auraRadius = 12
local parryAnimation = "rbxassetid://13526154547"

local function ShowGhostHighlight(player)
  if not player.Character then return end
  if player.Character:FindFirstChild("GhostHighlight") then return end
  local highlight = Instance.new("Highlight")
  highlight.Name = "GhostHighlight"
  highlight.FillColor = Color3.fromRGB(255, 0, 0)
  highlight.OutlineColor = Color3.fromRGB(255, 0, 0)
  highlight.FillTransparency = 0.5
  highlight.Parent = player.Character
  task.delay(1.5, function() if highlight then highlight:Destroy() end end)
end

RunService.Heartbeat:Connect(function()
  if not autoParryEnabled then return end
  local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
  if not hrp then return end

  for _, plr in pairs(Players:GetPlayers()) do
    if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
      if (hrp.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= auraRadius then
        local hum = plr.Character:FindFirstChild("Humanoid")
        local animator = hum and hum:FindFirstChildOfClass("Animator")
        if animator then
          for _, track in pairs(animator:GetPlayingAnimationTracks()) do
            if track.Animation and track.Animation.AnimationId == parryAnimation then
              ReplicatedStorage:WaitForChild("Counter"):FireServer()
              ShowGhostHighlight(plr)
              break
            end
          end
        end
      end
    end
  end
end)

local CombatSection = CombatTab:AddSection({" Auto Counter"})
CombatTab:AddToggle({
  Name = "Auto Parry Counter (meme)",
  Default = false,
  Callback = function(v) autoParryEnabled = v end
})

CombatTab:AddSlider({
  Name = "Active Studs Aura",
  Min = 1, Max = 50, Increase = 1, Default = 12,
  Callback = function(v) auraRadius = v end
})

CombatTab:AddButton({
  Name = "Get the glove For Use Aura",
  Callback = function()
    fireclickdetector(workspace:WaitForChild("Lobby"):WaitForChild("Counter"):WaitForChild("ClickDetector"))
  end
})

local BullSection = CombatTab:AddSection({" Aura Bull (Stone)"})
local bullAuraEnabled = false
local bullDelay = 2
local lastBullHit = 0

local function GetClosestPlayer()
  local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
  if not hrp then return nil end
  local closest = nil
  local dist = math.huge
  for _, plr in ipairs(Players:GetPlayers()) do
    if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
      local d = (plr.Character.HumanoidRootPart.Position - hrp.Position).Magnitude
      if d < dist then
        dist = d
        closest = plr
      end
    end
  end
  return closest
end

RunService.Heartbeat:Connect(function()
  if not bullAuraEnabled or (tick() - lastBullHit < bullDelay) then return end
  local target = GetClosestPlayer()
  if target and target.Character and target.Character:FindFirstChild("Left Arm") then
    ReplicatedStorage:WaitForChild("BullHit"):FireServer(target.Character:FindFirstChild("Left Arm"))
    lastBullHit = tick()
  end
end)

CombatTab:AddToggle({
  Name = "Aura Bull (Stone)",
  Default = false,
  Callback = function(v) bullAuraEnabled = v end
})

CombatTab:AddSlider({
  Name = "Delay From Aura ATACK (Careful)",
  Min = 1, Max = 10, Increase = 1, Default = 2,
  Callback = function(v) bullDelay = v end
})

CombatTab:AddButton({
  Name = "Get the glove For Use Aura",
  Callback = function()
    fireclickdetector(workspace:WaitForChild("Lobby"):WaitForChild("Bull"):WaitForChild("ClickDetector"))
  end
})

local UtilsSection = CombatTab:AddSection({" gloves you can spam SAFE"})
local spamBarrierEnabled = false
local spamBarrierFastEnabled = false
local lastBarrierSpam = 0

local function SpamBarrier()
  ReplicatedStorage:WaitForChild("Barrier"):FireServer(1)
end

RunService.Heartbeat:Connect(function()
  if spamBarrierEnabled and (tick() - lastBarrierSpam >= 1) then
    SpamBarrier()
    lastBarrierSpam = tick()
  elseif spamBarrierFastEnabled and (tick() - lastBarrierSpam >= 0.1) then
    SpamBarrier()
    lastBarrierSpam = tick()
  end
end)

CombatTab:AddToggle({
  Name = "Spam Bairry",
  Default = false,
  Callback = function(v)
    spamBarrierEnabled = v
    if v then spamBarrierFastEnabled = false end
  end
})

CombatTab:AddToggle({
  Name = "Spam Bairry Fast",
  Default = false,
  Callback = function(v)
    spamBarrierFastEnabled = v
    if v then spamBarrierEnabled = false end
  end
})

local spamSpoonEnabled = false
local spamSpoonFastEnabled = false
local lastSpoonSpam = 0

local function SpamSpoon()
  ReplicatedStorage.GeneralAbility:FireServer({
    state = "vfx",
    origin = CFrame.new(-65.91, -5.17, 46.16) * CFrame.Angles(0, -0.47, 0),
    vfx = "jumptween",
    sendplr = LocalPlayer
  })
end

RunService.Heartbeat:Connect(function()
  if spamSpoonEnabled and (tick() - lastSpoonSpam >= 1) then
    SpamSpoon()
    lastSpoonSpam = tick()
  elseif spamSpoonFastEnabled and (tick() - lastSpoonSpam >= 0.1) then
    SpamSpoon()
    lastSpoonSpam = tick()
  end
end)

CombatTab:AddToggle({
  Name = "Spam Sound Spoonfull",
  Default = false,
  Callback = function(v)
    spamSpoonEnabled = v
    if v then spamSpoonFastEnabled = false end
  end
})

CombatTab:AddToggle({
  Name = "Spam Sound Spoonfull Fast",
  Default = false,
  Callback = function(v)
    spamSpoonFastEnabled = v
    if v then spamSpoonEnabled = false end
  end
})

CombatTab:AddButton({
  Name = "get Fork",
  Callback = function()
    ReplicatedStorage.GeneralAbility:FireServer({state = "vfx", vfx = "fork"})
  end
})

CombatTab:AddButton({
  Name = "get Aura Vfx",
  Callback = function()
    ReplicatedStorage.GeneralAbility:FireServer({state = "vfx", vfx = "jumpvfx"})
  end
})

local BlindSection = CombatTab:AddSection({" aura Blind ( lol )"})
local blindAuraEnabled = false
local blindDelay = 1.5
local lastBlindHit = 0

RunService.Heartbeat:Connect(function()
  if not blindAuraEnabled or (tick() - lastBlindHit < blindDelay) then return end
  local target = GetClosestPlayer()
  local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
  if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") and hrp then
    ReplicatedStorage:WaitForChild("GeneralAbility"):FireServer("default", {
      goal = target.Character.HumanoidRootPart.CFrame,
      origin = hrp.CFrame
    })
    lastBlindHit = tick()
  end
end)

CombatTab:AddToggle({
  Name = "Aura Blind (MAKE THE PLAYER STOP LOL)",
  Default = false,
  Callback = function(v) blindAuraEnabled = v end
})

CombatTab:AddButton({
  Name = "Get the glove For Use Aura",
  Callback = function()
    fireclickdetector(workspace:WaitForChild("Lobby"):WaitForChild("Bind"):WaitForChild("ClickDetector"))
  end
})

local GoldenSection = CombatTab:AddSection({" aura Golden ( free Op )"})
local goldenAuraEnabled = false
local goldenDelay = 1
local lastGoldenHit = 0

RunService.Heartbeat:Connect(function()
  if not goldenAuraEnabled or (tick() - lastGoldenHit < goldenDelay) then return end
  local target = GetClosestPlayer()
  if target and target.Character and target.Character:FindFirstChild("Right Leg") then
    ReplicatedStorage:WaitForChild("GoldenHit"):FireServer(target.Character:FindFirstChild("Right Leg"), true)
    lastGoldenHit = tick()
  end
end)

CombatTab:AddToggle({
  Name = "Aura Hit Golden",
  Default = false,
  Callback = function(v) goldenAuraEnabled = v end
})

CombatTab:AddButton({
  Name = "Get the Golden Glove",
  Callback = function()
    fireclickdetector(workspace:WaitForChild("Lobby"):WaitForChild("Golden"):WaitForChild("ClickDetector"))
  end
})

local espEnabled = false
local espNames = true
local espDist = false
local espTool = true
local espNick = false
local espMaxDist = 400
local espObjects = {}

local function CreateDrawing(type, properties)
  local d = Drawing.new(type)
  for k, v in pairs(properties) do d[k] = v end
  return d
end

local function SetupEsp(player)
  if player == LocalPlayer or espObjects[player] then return end
  espObjects[player] = {
    box = CreateDrawing("Square", {Thickness = 2, Filled = false, Color = Color3.fromRGB(255, 80, 80), Visible = false}),
    name = CreateDrawing("Text", {Size = 16, Center = true, Outline = true, Color = Color3.fromRGB(255, 255, 255), Visible = false}),
    dist = CreateDrawing("Text", {Size = 16, Center = true, Outline = true, Color = Color3.fromRGB(255, 160, 160), Visible = false}),
    tool = CreateDrawing("Text", {Size = 16, Center = true, Outline = true, Color = Color3.fromRGB(255, 220, 120), Visible = false}),
    nick = CreateDrawing("Text", {Size = 16, Center = true, Outline = true, Color = Color3.fromRGB(150, 200, 255), Visible = false}),
    age = CreateDrawing("Text", {Size = 16, Center = true, Outline = true, Color = Color3.fromRGB(200, 200, 200), Visible = false}),
  }
end

local function RemoveEsp(player)
  if espObjects[player] then
    for _, d in pairs(espObjects[player]) do d:Remove() end
    espObjects[player] = nil
  end
end

RunService.RenderStepped:Connect(function()
  if not espEnabled then
    for _, objs in pairs(espObjects) do for _, d in pairs(objs) do d.Visible = false end end
    return
  end
  local cam = workspace.CurrentCamera
  for _, plr in pairs(Players:GetPlayers()) do
    if plr ~= LocalPlayer then
      SetupEsp(plr)
      local objs = espObjects[plr]
      local char = plr.Character
      local hrp = char and char:FindFirstChild("HumanoidRootPart")
      if hrp then
        local pos, onScreen = cam:WorldToViewportPoint(hrp.Position)
        local myHrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        local distance = myHrp and (myHrp.Position - hrp.Position).Magnitude or 0

        if onScreen and distance <= espMaxDist then
          local size = math.clamp(2000 / pos.Z, 20, 60)
          objs.box.Visible = true
          objs.box.Size = Vector2.new(size / 2, size)
          objs.box.Position = Vector2.new(pos.X - size / 4, pos.Y - size / 2)

          objs.name.Visible = espNames
          if espNames then
            objs.name.Text = plr.Name
            objs.name.Position = Vector2.new(pos.X, pos.Y - size / 1.2)
          end

          objs.dist.Visible = espDist
          if espDist then
            objs.dist.Text = string.format("%.1f", distance)
            objs.dist.Position = Vector2.new(pos.X, pos.Y + size / 1.2)
          end

          local toolName = nil
          for _, c in pairs(char:GetChildren()) do if c:IsA("Tool") then toolName = c.Name; break end end
          objs.tool.Visible = espTool and toolName ~= nil
          if espTool and toolName then
            objs.tool.Text = toolName
            objs.tool.Position = Vector2.new(pos.X, pos.Y + size / 1.8)
          end

          objs.nick.Visible = espNick
          objs.age.Visible = espNick
          if espNick then
            objs.nick.Text = plr.DisplayName
            objs.nick.Position = Vector2.new(pos.X, pos.Y - size / 1.5)
            objs.age.Text = plr.AccountAge .. "d"
            objs.age.Position = Vector2.new(pos.X, pos.Y + size / 1.4)
          end
        else
          for _, d in pairs(objs) do d.Visible = false end
        end
      else
        for _, d in pairs(objs) do d.Visible = false end
      end
    end
  end
end)

Players.PlayerAdded:Connect(SetupEsp)
Players.PlayerRemoving:Connect(RemoveEsp)
for _, plr in pairs(Players:GetPlayers()) do SetupEsp(plr) end

EspTab:AddToggle({ Name = "ESP Master", Default = false, Callback = function(v) espEnabled = v end })
EspTab:AddToggle({ Name = "ESP Name", Default = true, Callback = function(v) espNames = v end })
EspTab:AddToggle({ Name = "ESP Distance", Default = false, Callback = function(v) espDist = v end })
EspTab:AddToggle({ Name = "ESP Tool", Default = true, Callback = function(v) espTool = v end })
EspTab:AddToggle({ Name = "ESP Nickname + Age", Default = false, Callback = function(v) espNick = v end })

local autoClickTycoon = false
local autoClickTycoonFast = false
local destroyAllTycoons = false
local autoClickNearTycoon = false
local autoClickNearTycoonFast = false

local function GetTycoonByName(name)
  for _, obj in ipairs(workspace:GetChildren()) do
    if string.find(obj.Name, "Tycoon") and string.find(obj.Name, name) then return obj end
  end
  return nil
end

local function GetClosestTycoon()
  local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
  if not hrp then return nil end
  local closest = nil
  local dist = math.huge
  for _, obj in ipairs(workspace:GetChildren()) do
    if string.find(obj.Name, "Tycoon") and obj:FindFirstChild("Click") and obj.Click:FindFirstChild("ClickDetector") then
      local d = (hrp.Position - obj.Click.Position).Magnitude
      if d < dist then dist = d; closest = obj end
    end
  end
  return closest
end

task.spawn(function()
  while task.wait(0.5) do
    if autoClickTycoon then
      local t = GetTycoonByName(LocalPlayer.Name)
      if t and t:FindFirstChild("Click") and t.Click:FindFirstChild("ClickDetector") then fireclickdetector(t.Click.ClickDetector) end
    end
  end
end)

task.spawn(function()
  while task.wait(0.05) do
    if autoClickTycoonFast then
      local t = GetTycoonByName(LocalPlayer.Name)
      if t and t:FindFirstChild("Click") and t.Click:FindFirstChild("ClickDetector") then fireclickdetector(t.Click.ClickDetector) end
    end
  end
end)

task.spawn(function()
  while task.wait(0.02) do
    if destroyAllTycoons then
      for _, plr in pairs(Players:GetPlayers()) do
        local t = GetTycoonByName(plr.Name)
        if t and t:FindFirstChild("Destruct") and t.Destruct:FindFirstChild("ClickDetector") then fireclickdetector(t.Destruct.ClickDetector) end
      end
    end
  end
end)

task.spawn(function()
  while task.wait(0.5) do
    if autoClickNearTycoon then
      local t = GetClosestTycoon()
      if t and t:FindFirstChild("Click") and t.Click:FindFirstChild("ClickDetector") then fireclickdetector(t.Click.ClickDetector) end
    end
  end
end)

task.spawn(function()
  while task.wait(0.05) do
    if autoClickNearTycoonFast then
      local t = GetClosestTycoon()
      if t and t:FindFirstChild("Click") and t.Click:FindFirstChild("ClickDetector") then fireclickdetector(t.Click.ClickDetector) end
    end
  end
end)

TycoonTab:AddToggle({ Name = "Auto Click Tycoon", Default = false, Callback = function(v) autoClickTycoon = v end })
TycoonTab:AddToggle({ Name = "Auto Click Fast Tycoon", Default = false, Callback = function(v) autoClickTycoonFast = v end })
TycoonTab:AddToggle({ Name = "Auto Click (Near Tycoon Help)", Default = false, Callback = function(v) autoClickNearTycoon = v end })
TycoonTab:AddToggle({ Name = "Auto Click Fast (Near Tycoon Help)", Default = false, Callback = function(v) autoClickNearTycoonFast = v end })

local TrollSection = TycoonTab:AddSection({" Troll Players ( Tycoon )"})
TycoonTab:AddToggle({ Name = "Destroy All Tycoons", Default = false, Callback = function(v) destroyAllTycoons = v end })

TycoonTab:AddButton({
  Name = "Fake Destroy ALL Tycoon ( THIS KILL ALL TYCOON NOOB ! )",
  Callback = function()
    for _, obj in ipairs(workspace:GetChildren()) do
      if string.find(obj.Name, "Tycoon") and obj:FindFirstChild("Destruct") and obj.Destruct:FindFirstChild("ClickDetector") then
        for i = 1, 3 do fireclickdetector(obj.Destruct.ClickDetector) end
      end
    end
  end
})

TycoonTab:AddButton({
  Name = "Destroy My Tycoon",
  Callback = function()
    local t = GetTycoonByName(LocalPlayer.Name)
    if t and t:FindFirstChild("Destruct") and t.Destruct:FindFirstChild("ClickDetector") then fireclickdetector(t.Destruct.ClickDetector) end
  end
})

local SafeSection = TycoonTab:AddSection({" Safe Zone : THIS NOT PROTECTE YIU COMPLETD"})
local function TpToPos(pos)
  if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
    LocalPlayer.Character:MoveTo(pos)
  end
end

TycoonTab:AddButton({ Name = "TP : Safe Zone 1", Callback = function() TpToPos(Vector3.new(257, 34, 196)) end })
TycoonTab:AddButton({ Name = "TP : Safe Zone 2", Callback = function() TpToPos(Vector3.new(248, -16, -3)) end })
TycoonTab:AddButton({ Name = "TP : Safe Zone 3", Callback = function() TpToPos(Vector3.new(-5, -5, -216)) end })
TycoonTab:AddButton({ Name = "TP : Safe Zone 4", Callback = function() TpToPos(Vector3.new(-2, -5, 218)) end })
TycoonTab:AddButton({ Name = "TP : Safe Zone 5", Callback = function() TpToPos(Vector3.new(-393, 51, -17)) end })

local aura2xEnabled = false
local aura2xDelay = 2
local last2xHit = 0
local autoSlapplesEnabled = false

RunService.Heartbeat:Connect(function()
  if not aura2xEnabled or (tick() - last2xHit < aura2xDelay) then return end
  local target = GetClosestPlayer()
  if target and target.Character and target.Character:FindFirstChild("Right Arm") then
    ReplicatedStorage:WaitForChild("GeneralHit"):FireServer(target.Character:FindFirstChild("Right Arm"))
    last2xHit = tick()
  end
end)

local function CollectSlapples()
  local folder = workspace:FindFirstChild("Arena") and workspace.Arena:FindFirstChild("island5") and workspace.Arena.island5:FindFirstChild("Slapples")
  if not folder then return end
  for _, obj in ipairs(folder:GetChildren()) do
    local part = obj:IsA("Model") and obj:FindFirstChildWhichIsA("BasePart") or (obj:IsA("BasePart") and obj)
    if part and part.Transparency < 1 then
      LocalPlayer.Character:MoveTo(part.Position)
      task.wait(0.1)
    end
  end
end

task.spawn(function()
  while task.wait(0.1) do if autoSlapplesEnabled then CollectSlapples() end end
end)

FarmTab:AddToggle({ Name = "Aura 2x Slaps (needs Glove)", Default = false, Callback = function(v) aura2xEnabled = v end })
FarmTab:AddSlider({ Name = "Delay From Aura ATACK", Min = 0.1, Max = 10, Increase = 1, Default = 2, Callback = function(v) aura2xDelay = v end })
local SlapplesSection = FarmTab:AddSection({" Farm 2 auto colected slapples"})
FarmTab:AddToggle({ Name = "Auto TP All Slapples", Default = false, Callback = function(v) autoSlapplesEnabled = v end })

local ragdollFreezer = false
local ragdollLag = false
local ragdollReset = false

local function GetRagdollValue()
  local char = workspace:FindFirstChild(LocalPlayer.Name)
  return char and char:FindFirstChild("Ragdolled")
end

local function SetAnchored(v)
  local char = LocalPlayer.Character
  if not char then return end
  for _, p in ipairs(char:GetDescendants()) do if p:IsA("BasePart") then p.Anchored = v end end
end

RunService.Heartbeat:Connect(function()
  if not ragdollFreezer then return end
  local v = GetRagdollValue()
  SetAnchored(v and v.Value == true)
end)

task.spawn(function()
  while task.wait(0.3) do
    if ragdollLag then
      local v = GetRagdollValue()
      if v and v.Value == true then SetAnchored(true); task.wait(0.1); SetAnchored(false) end
    end
  end
end)

task.spawn(function()
  while task.wait(0.2) do
    if ragdollReset then
      local v = GetRagdollValue()
      if v and v.Value == true then LocalPlayer.Reset:FireServer() end
    end
  end
end)

ProtecTab:AddToggle({ Name = "Protection Ragdoll (Freezer)", Default = false, Callback = function(v) ragdollFreezer = v end })
ProtecTab:AddToggle({ Name = "Protection Ragdoll (Lag Legit)", Default = false, Callback = function(v) ragdollLag = v end })
ProtecTab:AddToggle({ Name = "Protection Ragdoll (Reset)", Default = false, Callback = function(v) ragdollReset = v end })

local mailContent = nil
local mailName = nil
ProtecTab:AddToggle({
  Name = "Protection Mail AHAHAHA",
  Default = false,
  Callback = function(v)
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local mail = char:FindFirstChild("YouHaveGotMail")
    if v and mail and mail:IsA("Script") then
      mailContent = mail.Source
      mailName = mail.Name
      mail:Destroy()
      print("Mail protection active.")
    elseif not v and mailContent and mailName then
      local s = Instance.new("Script")
      s.Name = mailName
      s.Source = mailContent
      s.Parent = char
      print("Mail script restored.")
    end
  end
})
