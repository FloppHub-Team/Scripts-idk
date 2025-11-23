-- Lokales Skript in StarterGui
local player = game.Players.LocalPlayer
local backpack = player:WaitForChild("Backpack")
local playerGui = player:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BenutzerInventar"
screenGui.Parent = playerGui

-- Rucksack-Button (beweglich)
local backpackButton = Instance.new("TextButton")
backpackButton.Size = UDim2.new(0, 60, 0, 60)
backpackButton.Position = UDim2.new(0, 20, 0, 100)
backpackButton.Text = "🎒"
backpackButton.TextScaled = true
backpackButton.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
backpackButton.TextColor3 = Color3.fromRGB(0, 0, 0)
backpackButton.Active = true
backpackButton.Draggable = true
backpackButton.Parent = screenGui

-- Inventar-Fenster
local inventoryFrame = Instance.new("Frame")
inventoryFrame.Size = UDim2.new(0, 320, 0, 400)
inventoryFrame.Position = UDim2.new(0.5, -160, 0.5, -200)
inventoryFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
inventoryFrame.BorderSizePixel = 0
inventoryFrame.Visible = false
inventoryFrame.Parent = screenGui

-- Feste Anordnung
local layout = Instance.new("UIGridLayout")
layout.CellSize = UDim2.new(0, 90, 0, 90)
layout.CellPadding = UDim2.new(0, 10, 0, 10)
layout.Parent = inventoryFrame

-- Animation Inventar öffnen/schließen
local function toggleInventory()
    if inventoryFrame.Visible then
        local tween = TweenService:Create(inventoryFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 0, 0, 0)})
        tween:Play()
        tween.Completed:Connect(function()
            inventoryFrame.Visible = false
            inventoryFrame.Size = UDim2.new(0, 320, 0, 400)
        end)
    else
        inventoryFrame.Visible = true
        inventoryFrame.Size = UDim2.new(0, 0, 0, 0)
        local tween = TweenService:Create(inventoryFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 320, 0, 400)})
        tween:Play()
    end
end
backpackButton.MouseButton1Click:Connect(toggleInventory)

-- Inventar mit Animationen aktualisieren
local function refreshInventory()
    -- Lösche nur die Buttons
    for _, child in ipairs(inventoryFrame:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end

    for _, tool in ipairs(backpack:GetChildren()) do
        if tool:IsA("Tool") then
            local button = Instance.new("TextButton")
            button.Size = UDim2.new(0, 90, 0, 90)
            button.Text = tool.Name
            button.TextScaled = true
            button.BackgroundColor3 = Color3.fromRGB(255, 80, 0)
            button.TextColor3 = Color3.fromRGB(0, 0, 0)
            button.Parent = inventoryFrame

            -- Erscheinungs-Animation
            button.BackgroundTransparency = 1
            local appearTween = TweenService:Create(button, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {BackgroundTransparency = 0})
            appearTween:Play()

            -- Hover-Animation
            button.MouseEnter:Connect(function()
                TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 120, 40)}):Play()
            end)
            button.MouseLeave:Connect(function()
                TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 80, 0)}):Play()
            end)

            -- Objekt korrekt ausrüsten
            button.MouseButton1Click:Connect(function()
                local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid:EquipTool(tool) -- setzt es in die offizielle Leiste
                else
                    tool.Parent = player.Character -- Notlösung
                end
            end)
        end
    end
end

-- Ereignisse für Echtzeit-Aktualisierung
backpack.ChildAdded:Connect(refreshInventory)
backpack.ChildRemoved:Connect(refreshInventory)
refreshInventory()
