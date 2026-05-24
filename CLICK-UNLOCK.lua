local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local camera = workspace.CurrentCamera

local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local sg = Instance.new("ScreenGui")
sg.Name = "FreeMouseGui"
sg.ResetOnSpawn = false

local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0, 1, 0, 1)
btn.BackgroundTransparency = 1
btn.Text = ""
btn.Modal = false
btn.Parent = sg
sg.Parent = playerGui

local holding = false

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.LeftControl then
        holding = true
        camera.CameraType = Enum.CameraType.Scriptable
        btn.Modal = true
        UserInputService.MouseBehavior = Enum.MouseBehavior.None
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.LeftControl then
        holding = false
        btn.Modal = false
        camera.CameraType = Enum.CameraType.Custom
        UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
    end
end)

RunService.RenderStepped:Connect(function()
    if holding then
        UserInputService.MouseBehavior = Enum.MouseBehavior.None
    end
end)
