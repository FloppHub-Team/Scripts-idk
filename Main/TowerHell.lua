local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GameValues = ReplicatedStorage:WaitForChild("GameValues")

local globalJumps = GameValues:WaitForChild("globalJumps")
local globalSpeed = GameValues:WaitForChild("globalSpeed")
local killbricksDisabled = GameValues:WaitForChild("killbricksDisabled")

local function ev()
    globalJumps.Value = 999999999999
    globalSpeed.Value = 18
    killbricksDisabled.Value = true
end

ev()

globalJumps.Changed:Connect(function()
    globalJumps.Value = 999999999999
end)

globalSpeed.Changed:Connect(function()
    globalSpeed.Value = 18
end)

killbricksDisabled.Changed:Connect(function()
    killbricksDisabled.Value = true
end)
