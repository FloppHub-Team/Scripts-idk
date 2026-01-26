if game.PlaceId ~= 124311897657957 then game.Players.LocalPlayer:Kick("Game Not Supported 🖕🖕") return end
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield '))()

local Window = Rayfield:CreateWindow({
   Name = "FloppHub Team | By Felicia",
   LoadingTitle = "Loading...",
   LoadingSubtitle = "by Felicia",
   ConfigurationSaving = { Enabled = false }
})

local MainTab = Window:CreateTab("Main Op", 4483362458)
local FarmTab = Window:CreateTab("Farming & TP", 4483362458)

local autoBreak = false
local breakDist = 50
local noclip = false
local autoFarm = false
local autoHoldE = false
local damageRemote = game:GetService("ReplicatedStorage").Remotes.DamageBlockEvent

local function Optimize()
    local char = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
    local hum = char:WaitForChild("Humanoid")
    hum.AnimationPlayed:Connect(function(track) track:Stop(0) end)
    hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
    hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
end
task.spawn(Optimize)
game.Players.LocalPlayer.CharacterAdded:Connect(Optimize)

game:GetService("RunService").Stepped:Connect(function()
    if noclip or autoFarm then
        local char = game.Players.LocalPlayer.Character
        if char then
            for _, v in pairs(char:GetDescendants()) do
                if v:IsA("BasePart") and v.CanCollide then
                    v.CanCollide = false
                end
            end
        end
    end
end)

MainTab:CreateToggle({
   Name = "Ultimate Fast Attack (Hold Pickaxe)",
   CurrentValue = false,
   Callback = function(Value)
       autoBreak = Value
       if Value then
           task.spawn(function()
               while autoBreak do
                   local char = game.Players.LocalPlayer.Character
                   local root = char and char:FindFirstChild("HumanoidRootPart")
                   
                   local tool = char:FindFirstChildOfClass("Tool")
                   if not tool then
                       local bp = game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
                       if bp then bp.Parent = char end
                   end

                   if root then
                       for _, block in pairs(workspace.LuckyBlocks:GetChildren()) do
                           if block:IsA("BasePart") or block:IsA("Model") then
                               local p = block:IsA("Model") and block:GetModelCFrame().p or block.Position
                               if (root.Position - p).Magnitude <= breakDist then
                                   for i = 1, 5 do
                                       damageRemote:FireServer(block)
                                   end
                                   game:GetService("VirtualUser"):ClickButton1(Vector2.new(0,0))
                               end
                           end
                       end
                   end
                   task.wait(0.1) 
               end
           end)
       end
   end,
})

MainTab:CreateToggle({
   Name = "Anchor Position",
   CurrentValue = false,
   Callback = function(Value)
       _G.isAnchored = Value
       local root = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
       if root and Value then
           local pos = root.CFrame
           task.spawn(function()
               while _G.isAnchored do
                   if not autoFarm then
                       root.CFrame = pos
                       root.AssemblyLinearVelocity = Vector3.new(0,0,0)
                   end
                   game:GetService("RunService").Heartbeat:Wait()
               end
           end)
       end
   end,
})

task.spawn(function()
    while true do
        if autoHoldE then
            game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.E, false, game)
            task.wait(0.1)
        else
            task.wait(0.5)
        end
    end
end)

MainTab:CreateToggle({
    Name = "Auto Hold E",
    CurrentValue = false,
    Callback = function(Value)
        autoHoldE = Value
    end
})

MainTab:CreateSection("Anti-Toxic")

MainTab:CreateToggle({
    Name = "Noclip",
    CurrentValue = false,
    Callback = function(v)
        noclip = v
    end
})

MainTab:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Callback = function(v)
        _G.InfJump = v
        game:GetService("UserInputService").JumpRequest:Connect(function()
            if _G.InfJump then
                local char = game.Players.LocalPlayer.Character
                if char and char:FindFirstChildOfClass("Humanoid") then
                    char:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
                end
            end
        end)
    end
})

FarmTab:CreateButton({
   Name = "Teleport to Base",
   Callback = function()
       local char = game.Players.LocalPlayer.Character
       if char and char:FindFirstChild("HumanoidRootPart") then
           char.HumanoidRootPart.CFrame = CFrame.new(-86.45, 11.86, -206.48)
       end
   end,
})

FarmTab:CreateToggle({
    Name = "Random Fly Autofarm",
    CurrentValue = false,
    Callback = function(Value)
        autoFarm = Value
        if Value then
            task.spawn(function()
                local baseFarmPos = Vector3.new(-64.86, 11.50, -14.38)
                while autoFarm do
                    local char = game.Players.LocalPlayer.Character
                    local root = char and char:FindFirstChild("HumanoidRootPart")
                    if root then
                        local randomOffset = Vector3.new(
                            math.random(-50, 50),
                            math.random(0, 10),
                            math.random(-50, 50)
                        )
                        local targetPos = baseFarmPos + randomOffset
                        
                        root.CFrame = CFrame.new(root.Position, targetPos)
                        root.CFrame = CFrame.new(targetPos) * CFrame.Angles(0, math.rad(math.random(0, 360)), 0)
                        
                        root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                    end
                    task.wait(0.2)
                end
            end)
        end
    end
})

MainTab:CreateButton({
   Name = "Kill Animations",
   Callback = function()
       for _, v in pairs(game.Workspace:GetDescendants()) do
           if v:IsA("ParticleEmitter") or v:IsA("Explosion") or v:IsA("Trail") then
               v:Destroy()
           end
       end
       Rayfield:Notify({Title = "Optimized", Content = "Laggy effects cleared!", Duration = 2})
   end,
})

Rayfield:Notify({
   Title = "FeliciaXxxTop",
   Content = "Welcome! Script Loaded.",
   Duration = 3
})
