local Players = game:GetService("Players")
local VirtualInputManager = game:GetService("VirtualInputManager")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer
local mouse = player:GetMouse()
local camera = workspace.CurrentCamera

local scriptActive = true
local cooldownTime = 0.1
local autoShootEnabled = false
local autoShootStartTime = 0
local speedEnabled = true
local zoomLimitEnabled = true
local autoFarmEnabled = false
local aimlockEnabled = false
local canShoot = true
local speedValue = 50

local farmPlatform = nil
local lastFarmState = "Off"
local isFarmInitialized = false
local isInitializingFarm = false

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TriggerbotUI"
screenGui.ResetOnSpawn = false

local success = pcall(function()
    screenGui.Parent = CoreGui
end)
if not success then
    screenGui.Parent = player:WaitForChild("PlayerGui")
end

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 180, 0, 220)
mainFrame.Position = UDim2.new(0.5, -90, 0.1, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = mainFrame

local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 25)
topBar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
topBar.BorderSizePixel = 0
topBar.Parent = mainFrame

local uiCornerTop = Instance.new("UICorner")
uiCornerTop.CornerRadius = UDim.new(0, 8)
uiCornerTop.Parent = topBar

local bottomFix = Instance.new("Frame")
bottomFix.Size = UDim2.new(1, 0, 0, 8)
bottomFix.Position = UDim2.new(0, 0, 1, -8)
bottomFix.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
bottomFix.BorderSizePixel = 0
bottomFix.Parent = topBar

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -50, 1, 0)
titleLabel.Position = UDim2.new(0, 10, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Script By TheRealBanHammer"
titleLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
titleLabel.TextSize = 12
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = topBar

local btnMinimize = Instance.new("TextButton")
btnMinimize.Size = UDim2.new(0, 25, 1, 0)
btnMinimize.Position = UDim2.new(1, -50, 0, 0)
btnMinimize.BackgroundTransparency = 1
btnMinimize.Text = "-"
btnMinimize.TextColor3 = Color3.fromRGB(255, 255, 255)
btnMinimize.TextSize = 18
btnMinimize.Font = Enum.Font.GothamBold
btnMinimize.Parent = topBar

local btnClose = Instance.new("TextButton")
btnClose.Size = UDim2.new(0, 25, 1, 0)
btnClose.Position = UDim2.new(1, -25, 0, 0)
btnClose.BackgroundTransparency = 1
btnClose.Text = "X"
btnClose.TextColor3 = Color3.fromRGB(255, 50, 50)
btnClose.TextSize = 14
btnClose.Font = Enum.Font.GothamBold
btnClose.Parent = topBar

local toggleShoot = Instance.new("TextButton")
toggleShoot.Size = UDim2.new(1, -20, 0, 25)
toggleShoot.Position = UDim2.new(0, 10, 0, 35)
toggleShoot.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
toggleShoot.Text = "Auto-Disparo: OFF"
toggleShoot.TextColor3 = Color3.fromRGB(255, 50, 50)
toggleShoot.TextSize = 14
toggleShoot.Font = Enum.Font.GothamBold
toggleShoot.Parent = mainFrame

local toggleCorner1 = Instance.new("UICorner")
toggleCorner1.CornerRadius = UDim.new(0, 4)
toggleCorner1.Parent = toggleShoot

local toggleSpeed = Instance.new("TextButton")
toggleSpeed.Size = UDim2.new(1, -20, 0, 25)
toggleSpeed.Position = UDim2.new(0, 10, 0, 65)
toggleSpeed.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
toggleSpeed.Text = "LoopSpeed: ON"
toggleSpeed.TextColor3 = Color3.fromRGB(0, 255, 0)
toggleSpeed.TextSize = 14
toggleSpeed.Font = Enum.Font.GothamBold
toggleSpeed.Parent = mainFrame

local toggleCorner2 = Instance.new("UICorner")
toggleCorner2.CornerRadius = UDim.new(0, 4)
toggleCorner2.Parent = toggleSpeed

local toggleZoom = Instance.new("TextButton")
toggleZoom.Size = UDim2.new(1, -20, 0, 25)
toggleZoom.Position = UDim2.new(0, 10, 0, 95)
toggleZoom.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
toggleZoom.Text = "NoLimitZoom: ON"
toggleZoom.TextColor3 = Color3.fromRGB(0, 255, 0)
toggleZoom.TextSize = 14
toggleZoom.Font = Enum.Font.GothamBold
toggleZoom.Parent = mainFrame

local toggleCorner3 = Instance.new("UICorner")
toggleCorner3.CornerRadius = UDim.new(0, 4)
toggleCorner3.Parent = toggleZoom

local toggleFarm = Instance.new("TextButton")
toggleFarm.Size = UDim2.new(1, -20, 0, 25)
toggleFarm.Position = UDim2.new(0, 10, 0, 125)
toggleFarm.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
toggleFarm.Text = "Auto Farm: OFF"
toggleFarm.TextColor3 = Color3.fromRGB(255, 50, 50)
toggleFarm.TextSize = 14
toggleFarm.Font = Enum.Font.GothamBold
toggleFarm.Parent = mainFrame

local toggleCorner4 = Instance.new("UICorner")
toggleCorner4.CornerRadius = UDim.new(0, 4)
toggleCorner4.Parent = toggleFarm

local btnInvisible = Instance.new("TextButton")
btnInvisible.Size = UDim2.new(1, -20, 0, 25)
btnInvisible.Position = UDim2.new(0, 10, 0, 155)
btnInvisible.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
btnInvisible.Text = "Hacerte Invisible"
btnInvisible.TextColor3 = Color3.fromRGB(255, 255, 255)
btnInvisible.TextSize = 14
btnInvisible.Font = Enum.Font.GothamBold
btnInvisible.Parent = mainFrame

local invisibleCorner = Instance.new("UICorner")
invisibleCorner.CornerRadius = UDim.new(0, 4)
invisibleCorner.Parent = btnInvisible

local toggleAimlock = Instance.new("TextButton")
toggleAimlock.Size = UDim2.new(1, -20, 0, 25)
toggleAimlock.Position = UDim2.new(0, 10, 0, 185)
toggleAimlock.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
toggleAimlock.Text = "Aimlock: OFF"
toggleAimlock.TextColor3 = Color3.fromRGB(255, 50, 50)
toggleAimlock.TextSize = 14
toggleAimlock.Font = Enum.Font.GothamBold
toggleAimlock.Parent = mainFrame

local toggleCorner5 = Instance.new("UICorner")
toggleCorner5.CornerRadius = UDim.new(0, 4)
toggleCorner5.Parent = toggleAimlock

local dragging
local dragInput
local dragStart
local startPos
local isMinimized = false

local function update(input)
    local delta = input.Position - dragStart
    mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

topBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

topBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

local function triggerInvisibility()
    if player.Character then
        local hrp = player.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            local posActual = hrp.CFrame
            hrp.CFrame = CFrame.new(-0.13, 65.42, 203.41)
            task.wait(1)
            hrp.CFrame = posActual
        end
    end
end

local function sendNotification(title, text, duration)
    if not scriptActive then return end
    StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = duration or 3
    })
end

local function getKeeperPlayer()
    for _, p in pairs(Players:GetPlayers()) do
        if p.Team and p.Team.Name == "Keeper" then
            return p
        end
    end
    return nil
end

local function isKeeperLookingAtMe(keeper)
    if not keeper or not keeper.Character then return false end
    local head = keeper.Character:FindFirstChild("Head")
    if not head then return false end
    if not player.Character then return false end
    local myHrp = player.Character:FindFirstChild("HumanoidRootPart")
    if not myHrp then return false end
    
    local dir = (myHrp.Position - head.Position).Unit
    local look = head.CFrame.LookVector
    return look:Dot(dir) > 0.85
end

local function getClosestAnimal()
    local closest = nil
    local minDistance = math.huge
    
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
        return nil
    end
    
    local myPos = player.Character.HumanoidRootPart.Position
    
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= player and p.Team and p.Team.Name == "Animal" and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (p.Character.HumanoidRootPart.Position - myPos).Magnitude
            if dist < minDistance then
                minDistance = dist
                closest = p
            end
        end
    end
    
    return closest
end

local function removeOldTools()
    local backpack = player:FindFirstChildOfClass("Backpack")
    local character = player.Character

    if backpack and backpack:FindFirstChild("TP Mouse Tool") then
        backpack["TP Mouse Tool"]:Destroy()
    end

    if character and character:FindFirstChild("TP Mouse Tool") then
        character["TP Mouse Tool"]:Destroy()
    end
end

local espFolder = Instance.new("Folder")
espFolder.Name = "UniversalESP"
local successFolder = pcall(function()
    espFolder.Parent = CoreGui
end)
if not successFolder then
    espFolder.Parent = player:WaitForChild("PlayerGui")
end

btnMinimize.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        mainFrame.Size = UDim2.new(0, 180, 0, 25)
    else
        mainFrame.Size = UDim2.new(0, 180, 0, 220)
    end
end)

btnClose.MouseButton1Click:Connect(function()
    scriptActive = false
    autoShootEnabled = false
    speedEnabled = false
    zoomLimitEnabled = false
    autoFarmEnabled = false
    aimlockEnabled = false
    
    if farmPlatform then
        farmPlatform:Destroy()
    end
    
    if espFolder then
        espFolder:Destroy()
    end
    
    if player.Character then
        local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = 16
        end
    end
    player.CameraMaxZoomDistance = 400
    
    removeOldTools()
    screenGui:Destroy()
end)

toggleShoot.MouseButton1Click:Connect(function()
    autoShootEnabled = not autoShootEnabled
    if autoShootEnabled then
        autoShootStartTime = tick() + 2
        toggleShoot.Text = "Auto-Disparo: (2s)"
        toggleShoot.TextColor3 = Color3.fromRGB(255, 255, 0)
        
        task.delay(2, function()
            if autoShootEnabled and scriptActive then
                toggleShoot.Text = "Auto-Disparo: ON"
                toggleShoot.TextColor3 = Color3.fromRGB(0, 255, 0)
            end
        end)
    else
        toggleShoot.Text = "Auto-Disparo: OFF"
        toggleShoot.TextColor3 = Color3.fromRGB(255, 50, 50)
    end
end)

toggleSpeed.MouseButton1Click:Connect(function()
    speedEnabled = not speedEnabled
    if speedEnabled then
        toggleSpeed.Text = "LoopSpeed: ON"
        toggleSpeed.TextColor3 = Color3.fromRGB(0, 255, 0)
    else
        toggleSpeed.Text = "LoopSpeed: OFF"
        toggleSpeed.TextColor3 = Color3.fromRGB(255, 50, 50)
    end
end)

toggleZoom.MouseButton1Click:Connect(function()
    zoomLimitEnabled = not zoomLimitEnabled
    if zoomLimitEnabled then
        toggleZoom.Text = "NoLimitZoom: ON"
        toggleZoom.TextColor3 = Color3.fromRGB(0, 255, 0)
    else
        toggleZoom.Text = "NoLimitZoom: OFF"
        toggleZoom.TextColor3 = Color3.fromRGB(255, 50, 50)
    end
end)

toggleFarm.MouseButton1Click:Connect(function()
    autoFarmEnabled = not autoFarmEnabled
    if autoFarmEnabled then
        toggleFarm.Text = "Auto Farm: ON"
        toggleFarm.TextColor3 = Color3.fromRGB(0, 255, 0)
        
        if not farmPlatform then
            farmPlatform = Instance.new("Part")
            farmPlatform.Size = Vector3.new(4, 1, 4)
            farmPlatform.Anchored = true
            farmPlatform.CanCollide = true
            farmPlatform.Transparency = 1
            farmPlatform.Parent = workspace
        end
        lastFarmState = "Starting"
    else
        toggleFarm.Text = "Auto Farm: OFF"
        toggleFarm.TextColor3 = Color3.fromRGB(255, 50, 50)
        
        isFarmInitialized = false
        isInitializingFarm = false
        
        if farmPlatform then
            farmPlatform:Destroy()
            farmPlatform = nil
        end
        lastFarmState = "Off"
    end
end)

toggleAimlock.MouseButton1Click:Connect(function()
    aimlockEnabled = not aimlockEnabled
    if aimlockEnabled then
        toggleAimlock.Text = "Aimlock: ON"
        toggleAimlock.TextColor3 = Color3.fromRGB(0, 255, 0)
    else
        toggleAimlock.Text = "Aimlock: OFF"
        toggleAimlock.TextColor3 = Color3.fromRGB(255, 50, 50)
    end
end)

btnInvisible.MouseButton1Click:Connect(function()
    triggerInvisibility()
end)

task.spawn(function()
    while scriptActive do
        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
        task.wait()
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
        task.wait(0.1)
    end
end)

local function getHRP()
    local character = player.Character or player.CharacterAdded:Wait()
    if not scriptActive then return end
    return character:WaitForChild("HumanoidRootPart", 10)
end

local function createTool()
    if not scriptActive then return end
    removeOldTools()

    local backpack = player:WaitForChild("Backpack")

    local tool = Instance.new("Tool")
    tool.Name = "TP Mouse Tool"
    tool.RequiresHandle = false
    tool.CanBeDropped = false

    tool.Activated:Connect(function()
        if not scriptActive then return end
        local hrp = getHRP()
        if hrp and mouse and mouse.Hit then
            hrp.CFrame = CFrame.new(mouse.Hit.Position + Vector3.new(0, 3, 0))
        end
    end)

    tool.Parent = backpack
end

createTool()

player.CharacterAdded:Connect(function()
    if not scriptActive then return end
    task.wait(1)
    if not scriptActive then return end
    createTool()
    isFarmInitialized = false
    isInitializingFarm = false
end)

RunService.RenderStepped:Connect(function()
    if not scriptActive then return end
    
    if autoShootEnabled and tick() >= autoShootStartTime and canShoot and player.Character then
        local rayOrigin = camera.CFrame.Position
        local rayDirection = camera.CFrame.LookVector * 1000

        local animalCharacters = {}
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= player and p.Team and p.Team.Name == "Animal" and p.Character then
                table.insert(animalCharacters, p.Character)
            end
        end

        local raycastParams = RaycastParams.new()
        raycastParams.FilterDescendantsInstances = animalCharacters
        raycastParams.FilterType = Enum.RaycastFilterType.Include

        local hitResult = workspace:Raycast(rayOrigin, rayDirection, raycastParams)

        if hitResult and hitResult.Instance then
            canShoot = false
            
            if mouse1click then
                mouse1click()
            else
                VirtualInputManager:SendMouseButtonEvent(mouse.X, mouse.Y, 0, true, game, 0)
                task.wait(0.05)
                VirtualInputManager:SendMouseButtonEvent(mouse.X, mouse.Y, 0, false, game, 0)
            end
            
            task.spawn(function()
                task.wait(cooldownTime)
                canShoot = true
            end)
        end
    end

    if aimlockEnabled then
        local target = getClosestAnimal()
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            camera.CFrame = CFrame.new(camera.CFrame.Position, target.Character.HumanoidRootPart.Position)
        end
    end
end)

RunService.Heartbeat:Connect(function()
    if not scriptActive then return end

    if speedEnabled and player.Character then
        local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = speedValue
        end
    end
    
    if zoomLimitEnabled then
        player.CameraMaxZoomDistance = 100000
    end
    
    if autoFarmEnabled then
        if player.Team then
            if player.Team.Name == "Not in game" or player.Team.Name == "Jugando" then
                if lastFarmState ~= "NotInMatch" then
                    lastFarmState = "NotInMatch"
                    sendNotification("Auto Farm", "Partida en curso...", 3)
                end
                isFarmInitialized = false
                isInitializingFarm = false
                return
            elseif player.Team.Name == "Keeper" then
                if lastFarmState ~= "IsKeeper" then
                    lastFarmState = "IsKeeper"
                    sendNotification("Auto Farm", "Tú eres el Keeper: Buena suerte", 3)
                end
                isFarmInitialized = false
                isInitializingFarm = false
                return
            elseif player.Team.Name ~= "Animal" then
                isFarmInitialized = false
                isInitializingFarm = false
                return
            end
        else
            isFarmInitialized = false
            isInitializingFarm = false
            return
        end

        local keeper = getKeeperPlayer()
        if not keeper or not keeper.Character or not keeper.Character:FindFirstChild("HumanoidRootPart") then
            if lastFarmState ~= "Waiting" then
                lastFarmState = "Waiting"
                sendNotification("Auto Farm", "Esperando Keeper: Auto Farm en pausa...", 3)
            end
            isFarmInitialized = false
            isInitializingFarm = false
            return
        end

        if not isFarmInitialized then
            if not isInitializingFarm then
                isInitializingFarm = true
                task.spawn(function()
                    for i = 10, 1, -1 do
                        if not autoFarmEnabled or not player.Team or player.Team.Name ~= "Animal" or not scriptActive then
                            isInitializingFarm = false
                            return
                        end
                        sendNotification("Iniciando Farmeo", tostring(i) .. "...", 1)
                        task.wait(1)
                    end
                    
                    if autoFarmEnabled and player.Team and player.Team.Name == "Animal" and scriptActive then
                        triggerInvisibility()
                        isFarmInitialized = true
                    end
                    isInitializingFarm = false
                end)
            end
            return
        end

        lastFarmState = "Farming"
        if farmPlatform and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local currentHeight = 15
            if isKeeperLookingAtMe(keeper) then
                currentHeight = 200
            end
            
            local targetCFrame = keeper.Character.HumanoidRootPart.CFrame + Vector3.new(0, currentHeight, 0)
            farmPlatform.CFrame = targetCFrame - Vector3.new(0, 3.5, 0)
            
            local myHrp = player.Character.HumanoidRootPart
            myHrp.CFrame = targetCFrame
            myHrp.Velocity = Vector3.new(0, 0, 0)
        end
    end
end)

local espCache = {}

RunService.RenderStepped:Connect(function()
    if not scriptActive then return end
    if not espFolder or not espFolder.Parent then return end

    for _, p in pairs(Players:GetPlayers()) do
        if p ~= player then
            local char = p.Character
            if char then
                local root = char.PrimaryPart or char:FindFirstChild("HumanoidRootPart") or char:FindFirstChildWhichIsA("BasePart")
                if root then
                    if not espCache[p] then
                        local box = Instance.new("BoxHandleAdornment")
                        box.AlwaysOnTop = true
                        box.ZIndex = 10
                        box.Transparency = 0.25
                        box.Parent = espFolder
                        
                        local bg = Instance.new("BillboardGui")
                        bg.Size = UDim2.new(0, 100, 0, 40)
                        bg.StudsOffset = Vector3.new(0, 2, 0)
                        bg.AlwaysOnTop = true
                        bg.Parent = espFolder
                        
                        local tl = Instance.new("TextLabel")
                        tl.Size = UDim2.new(1, 0, 1, 0)
                        tl.BackgroundTransparency = 1
                        tl.TextStrokeTransparency = 0
                        tl.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
                        tl.TextSize = 12
                        tl.Font = Enum.Font.GothamBlack
                        tl.Parent = bg
                        
                        espCache[p] = {Box = box, Billboard = bg, Label = tl}
                    end
                    
                    local esp = espCache[p]
                    local cframe, size = char:GetBoundingBox()
                    
                    esp.Box.Adornee = root
                    esp.Box.Size = size
                    esp.Box.CFrame = root.CFrame:ToObjectSpace(cframe)
                    esp.Billboard.Adornee = root
                    
                    local teamColor = p.Team and p.TeamColor.Color or Color3.fromRGB(255, 0, 0)
                    local h, s, v = teamColor:ToHSV()
                    local neonColor = Color3.fromHSV(h, s > 0.1 and 1 or 0, 1)
                    
                    local rawTeamName = p.Team and p.Team.Name or "Sin Equipo"
                    
                    local displayTeamName = rawTeamName
                    if displayTeamName == "Not in game" then
                        displayTeamName = "Jugando"
                    end
                    
                    esp.Box.Color3 = neonColor
                    esp.Label.TextColor3 = neonColor
                    esp.Label.Text = p.Name .. "\n[" .. displayTeamName .. "]"
                    
                    esp.Box.Visible = true
                    esp.Billboard.Enabled = true
                    
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    if hum then
                        hum.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
                    end
                else
                    if espCache[p] then
                        espCache[p].Box.Visible = false
                        espCache[p].Billboard.Enabled = false
                    end
                end
            else
                if espCache[p] then
                    espCache[p].Box.Visible = false
                    espCache[p].Billboard.Enabled = false
                end
            end
        end
    end
end)

Players.PlayerRemoving:Connect(function(p)
    if not scriptActive then return end
    if espCache[p] then
        espCache[p].Box:Destroy()
        espCache[p].Billboard:Destroy()
        espCache[p] = nil
    end
end)
