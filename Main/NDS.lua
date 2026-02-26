local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local MarketplaceService = game:GetService("MarketplaceService")
local UserInputService = game:GetService("UserInputService")
local TextChatService = game:GetService("TextChatService")
local TeleportService = game:GetService("TeleportService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/FloppHub-Team/UIs/refs/heads/main/RedzLib%20Cracked"))()

local HubVersion = "2.1"
local LastDisaster = ""
local CurrentLanguage = "Spanish"
local SpamLooping = false
local SpamMessage = "Flopp Hub On Top"
local SpamDelay = 1
local AntiFlingEnabled = false
local AntiFallActive = false
local AntiFallConnection = nil
local LoopJump = false
local LoopSpeed = false
local RgbEffect = 0
local WaterColor = 0

local MainConfig = {
    infjump = false,
    tptool = false,
    China = 3696971654,
    DefaultServer = 189707,
    SafeTp = function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.PrimaryPart.Velocity = Vector3.new(0, 0, 0)
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-279, 163, 340)
        end
    end,
    VelocitySpoof = function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local oldVelocity = LocalPlayer.Character.HumanoidRootPart.AssemblyLinearVelocity
            LocalPlayer.Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
            RunService.RenderStepped:Wait()
            LocalPlayer.Character.HumanoidRootPart.AssemblyLinearVelocity = oldVelocity
        end
    end
}

local DisasterNames = {
    Portuguese = { ["Flash Flood"] = "Inundações rápidas", Tornado = "Tornado", ["Thunder Storm"] = "Tempestade eléctrica", Fire = "Fogo", ["Meteor Shower"] = "Chuva de meteoros", Tsunami = "Tsunami", Blizzard = "Tempestade de neve", Sandstorm = "Tempestade de areia", ["Acid Rain"] = "Chuva Ácida", ["Volcanic Eruption"] = "Erupção vulcânica", Earthquake = "Terremoto", ["Deadly Virus"] = "Vírus mortal", ["Next Disaster:"] = "Próximo desastre:" },
    English = { ["Flash Flood"] = "Flash flood", Tornado = "Tornado", ["Thunder Storm"] = "Thunder storm", Fire = "Fire", ["Meteor Shower"] = "Meteor shower", Tsunami = "Tsunami", Blizzard = "Blizzard", Sandstorm = "Sandstorm", ["Acid Rain"] = "Acid Rain", ["Volcanic Eruption"] = "Volcanic Eruption", Earthquake = "Earthquake", ["Deadly Virus"] = "Deadly Virus", ["Next Disaster:"] = "Next disaster:" },
    Spanish = { ["Flash Flood"] = "Inundación rápida", Tornado = "Tornado", ["Thunder Storm"] = "Tormenta eléctrica", Fire = "Fuego", ["Meteor Shower"] = "Lluvia de meteoritos", Tsunami = "Tsunami", Blizzard = "Tormenta de nieve", Sandstorm = "Tormenta de arena", ["Acid Rain"] = "Lluvia ácida", ["Volcanic Eruption"] = "Erupción volcánica", Earthquake = "Terremoto", ["Deadly Virus"] = "Virus mortal", ["Next Disaster:"] = "Próximo desastre:" },
    Russian = { ["Flash Flood"] = "Лавина", Tornado = "Торнадо", ["Thunder Storm"] = "Гроза", Fire = "Пожар", ["Meteor Shower"] = "Метеоритный дождь", Tsunami = "Цунами", Blizzard = "Снегопад", Sandstorm = "Песчаная буря", ["Acid Rain"] = "Кислотный дождь", ["Volcanic Eruption"] = "Вулканическое извержение", Earthquake = "Землетрясение", ["Deadly Virus"] = "Смертоносный вирус", ["Next Disaster:"] = "Следующий desastre:" }
}

local function SendChatMessage(Message)
    if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
        local ChatInput = TextChatService:FindFirstChildOfClass("ChatInputBarConfiguration")
        if ChatInput and ChatInput.TargetTextChannel then
            ChatInput.TargetTextChannel:SendAsync(Message)
        end
    else
        local ChatEvents = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
        if ChatEvents then
            local SayMessage = ChatEvents:FindFirstChild("SayMessageRequest")
            if SayMessage then
                SayMessage:FireServer(Message, "All")
            end
        end
    end
end

local TPTool = Instance.new("Tool")
TPTool.Name = "Teleport Tool"
TPTool.RequiresHandle = false
TPTool.Activated:Connect(function()
    if MainConfig.tptool and LocalPlayer.Character then
        local pos = LocalPlayer:GetMouse().Hit.p
        LocalPlayer.Character:MoveTo(pos + Vector3.new(0, 3, 0))
    end
end)

UserInputService.InputBegan:Connect(function(input, processed)
    if not processed and input.KeyCode == Enum.KeyCode.X and LocalPlayer.Character then
        local pos = LocalPlayer:GetMouse().Hit.p
        LocalPlayer.Character:MoveTo(pos + Vector3.new(0, 3, 0))
    end
end)

UserInputService.JumpRequest:Connect(function()
    if MainConfig.infjump and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid:ChangeState("Jumping")
    end
end)

local Window = Library:MakeWindow({
    Title = "Flopp Hub | Natural Disaster",
    SubTitle = "By Rtz_Andruuux",
    FolderName = "FloppHubOnTop"
})

Window:Notify({
    Title = "Bienvenid@",
    Content = "Script cargado exitosamente",
    Image = "rbxassetid://18503600329",
    Duration = 5
})

local Minimizer = Window:NewMinimizer({ KeyCode = Enum.KeyCode.LeftControl })
local MobileButton = Minimizer:CreateMobileMinimizer({
    Image = "rbxassetid://112586798808707",
    BackgroundColor3 = Color3.fromRGB(50, 50, 50)
})

local Tab_Home = Window:MakeTab({"Inicio", "rbxassetid://15841490359"})
local Tab_Main = Window:MakeTab({"Principal", "rbxassetid://4370336019"})
local Tab_Player = Window:MakeTab({"Jugador", "rbxassetid://4400695581"})
local Tab_Teleport = Window:MakeTab({"Teletransportes", "rbxassetid://15841341821"})
local Tab_Visual = Window:MakeTab({"Mapa/Visual", "rbxassetid://15885360708"})
local Tab_Misc = Window:MakeTab({"Otros", "rbxassetid://4370336704"})

Tab_Home:AddParagraph("¡Bienvenido a Flopp Hub NDS!", "Esta es una versión experimental.\nDiscord: discord.gg/J9dSv7hq55")
Tab_Home:AddButton({
    Name = "Copiar Discord",
    Callback = function()
        setclipboard("https://discord.gg/J9dSv7hq55")
        Window:Notify({ Title = "Aviso", Content = "Enlace copiado al portapapeles", Duration = 5 })
    end
})

Tab_Main:AddSection("Automatización")

Tab_Main:AddToggle({
    Name = "AutoFarme Victoria", Flag = "AutoFarmeVictoria", Save = true,
    Default = false,
    Callback = function(Value)
        if Value then
            getgenv().FarmConnection = game:GetService("RunService").RenderStepped:Connect(function()
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-233.8095703125, 179.83950805664063, 311.78717041015625)
                end
            end)
        elseif getgenv().FarmConnection then
            getgenv().FarmConnection:Disconnect()
            getgenv().FarmConnection = nil
        end
    end
})

Tab_Main:AddButton({
    Name = "Obtener Globo Verde",
    Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/ySixxNz/Scripts/https/balao"))() end
})

Tab_Main:AddToggle({
    Name = "Elegir Mapa (Parcheado)", Flag = "ElegirMapaParcheado", Save = true, Default = false,
    Callback = function(Value) pcall(function() LocalPlayer.PlayerGui.MainGui.MapVotePage.Visible = Value end) end
})

Tab_Main:AddToggle({
    Name = "Auto Notify Disaster", Flag = "AutoNotifyDisaster", Save = true,
    Default = false,
    Callback = function(Value)
        getgenv().AutoNotify = Value
        task.spawn(function()
            while getgenv().AutoNotify do
                if LocalPlayer.Character then
                    local SurvivalTag = LocalPlayer.Character:FindFirstChild("SurvivalTag")
                    if SurvivalTag and SurvivalTag.Value then
                        local Disaster = DisasterNames[CurrentLanguage][SurvivalTag.Value] or SurvivalTag.Value
                        local FullMessage = DisasterNames[CurrentLanguage]["Next Disaster:"] .. " " .. Disaster
                        if Disaster ~= LastDisaster then
                            Window:Notify({ Title = "¡Desastre Detectado!", Content = FullMessage, Duration = 5 })
                            LastDisaster = Disaster
                        end
                    end
                end
                task.wait(5)
            end
        end)
    end
})

Tab_Main:AddDropdown({
    Name = "Idioma Notificación", Flag = "IdiomaNotificacin", Save = true,
    Default = "Spanish",
    Options = {"Portuguese", "English", "Spanish", "Russian"},
    Callback = function(Value) CurrentLanguage = Value end
})

Tab_Main:AddButton({
    Name = "Exponer Desastre (Chat)",
    Callback = function()
        if LocalPlayer.Character then
            local SurvivalTag = LocalPlayer.Character:FindFirstChild("SurvivalTag")
            if SurvivalTag and SurvivalTag.Value then
                local Message = DisasterNames[CurrentLanguage]["Next Disaster:"] .. " " .. (DisasterNames[CurrentLanguage][SurvivalTag.Value] or SurvivalTag.Value)
                SendChatMessage(Message)
            else
                Window:Notify({ Title = "Error", Content = "No se encontró SurvivalTag", Duration = 3 })
            end
        end
    end
})

Tab_Main:AddSection("Chat Spam")
Tab_Main:AddTextBox({
    Name = "Mensaje", Default = "Flopp Hub en la Cima",
    Callback = function(Value) SpamMessage = Value end
})
Tab_Main:AddTextBox({
    Name = "Retraso (Segundos)", Default = "1",
    Callback = function(Value) SpamDelay = tonumber(Value) or 1 end
})
Tab_Main:AddToggle({
    Name = "Loop de Mensajes", Flag = "LoopdeMensajes", Save = true, Default = false,
    Callback = function(Value)
        SpamLooping = Value
        if Value then
            task.spawn(function()
                while SpamLooping do
                    SendChatMessage(SpamMessage)
                    task.wait(SpamDelay)
                end
            end)
        end
    end
})

Tab_Player:AddSection("Atributos")

Tab_Player:AddSlider({
    Name = "FOV", Flag = "FOV", Save = true, Min = 70, Max = 120, Default = 70, Increment = 1,
    Callback = function(Value) workspace.CurrentCamera.FieldOfView = Value end
})

Tab_Player:AddSlider({
    Name = "Velocidad", Flag = "Velocidad", Save = true, Min = 16, Max = 500, Default = 16, Increment = 1,
    Callback = function(Value)
        getgenv().Walkspeed = Value
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = Value
        end
    end
})

Tab_Player:AddSlider({
    Name = "Salto", Flag = "Salto", Save = true, Min = 50, Max = 500, Default = 50, Increment = 1,
    Callback = function(Value)
        getgenv().Jumppower = Value
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.JumpPower = Value
        end
    end
})

Tab_Player:AddToggle({
    Name = "Loop de Velocidad", Flag = "LoopdeVelocidad", Save = true, Default = false,
    Callback = function(Value)
        LoopSpeed = Value
        task.spawn(function()
            while LoopSpeed do
                pcall(function() LocalPlayer.Character.Humanoid.WalkSpeed = getgenv().Walkspeed or 16 end)
                task.wait()
            end
        end)
    end
})

Tab_Player:AddToggle({
    Name = "Loop de Salto", Flag = "LoopdeSalto", Save = true, Default = false,
    Callback = function(Value)
        LoopJump = Value
        task.spawn(function()
            while LoopJump do
                pcall(function() LocalPlayer.Character.Humanoid.JumpPower = getgenv().Jumppower or 50 end)
                task.wait()
            end
        end)
    end
})

Tab_Player:AddSection("Características")

Tab_Player:AddToggle({
    Name = "Sin daño por caída", Flag = "Sindaoporcada", Save = true, Default = false,
    Callback = function(Value)
        AntiFallActive = Value
        if Value then
            local function ConnectAntiFall(char)
                local root = char:WaitForChild("HumanoidRootPart", 5)
                if root then
                    getgenv().AntiFallConnection = RunService.Heartbeat:Connect(function()
                        if not root.Parent then if getgenv().AntiFallConnection then getgenv().AntiFallConnection:Disconnect() end return end
                        if AntiFallActive then MainConfig.VelocitySpoof() end
                    end)
                end
            end
            if LocalPlayer.Character then ConnectAntiFall(LocalPlayer.Character) end
            LocalPlayer.CharacterAdded:Connect(ConnectAntiFall)
        elseif getgenv().AntiFallConnection then
            getgenv().AntiFallConnection:Disconnect()
            getgenv().AntiFallConnection = nil
        end
    end
})

Tab_Player:AddToggle({
    Name = "Infinite Jump", Flag = "InfiniteJump", Save = true, Default = false,
    Callback = function(Value) MainConfig.infjump = Value end
})

Tab_Player:AddToggle({
    Name = "NoPlayer Collision", Flag = "NoPlayerCollision", Save = true, Default = false,
    Callback = function(state)
        local partsToNoClip = { "HumanoidRootPart", "UpperTorso", "LowerTorso", "Torso" }
        if state then
            getgenv().NoColConnection = RunService.Heartbeat:Connect(function()
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Character then
                        for _, part in pairs(player.Character:GetChildren()) do
                            if part:IsA("BasePart") and table.find(partsToNoClip, part.Name) then
                                part.CanCollide = false
                            end
                        end
                    end
                end
            end)
        elseif getgenv().NoColConnection then
            getgenv().NoColConnection:Disconnect()
            getgenv().NoColConnection = nil
        end
    end
})

Tab_Player:AddToggle({
    Name = "Caminar sobre el Agua", Flag = "CaminarsobreelAgua", Save = true, Default = false,
    Callback = function(Value)
        local Water = workspace:FindFirstChild("WaterLevel")
        if not Water then Water = workspace.Structure:FindFirstChild("FloodLevel") end
        if Water then
            Water.CanCollide = Value
            Water.Size = Value and Vector3.new(1000, 1, 1000) or Vector3.new(10, 1, 10)
        end
    end
})

Tab_Player:AddToggle({
    Name = "Disable Void (FallenParts)", Flag = "DisableVoidFallenParts", Save = true, Default = false,
    Callback = function(state)
        workspace.FallenPartsDestroyHeight = state and (0/0) or -500
    end
})

Tab_Player:AddToggle({
    Name = "Toggle TP Tool", Flag = "ToggleTPTool", Save = true, Default = false,
    Callback = function(state)
        MainConfig.tptool = state
        if state then TPTool.Parent = LocalPlayer.Backpack else TPTool.Parent = nil end
    end
})

Tab_Teleport:AddSection("Lugares")
Tab_Teleport:AddButton({ Name = "TP Isla", Callback = function() if LocalPlayer.Character then LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-108, 49, 0) end end})
Tab_Teleport:AddButton({ Name = "TP Torre", Callback = function() if LocalPlayer.Character then LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-264, 196, 288) end end})
Tab_Teleport:AddButton({ Name = "TP Rocket (Launch Land)", Callback = function()
    local mapModel = workspace.Structure:FindFirstChild("Launch Land")
    if mapModel and mapModel:FindFirstChild("SPACESHIP!!") then
        local shuttle = mapModel["SPACESHIP!!"].Shuttle
        if shuttle:FindFirstChild("Interiour") and shuttle.Interiour:FindFirstChild("Seat") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = shuttle.Interiour.Seat.Seat.CFrame
        end
    end
end})
Tab_Teleport:AddButton({ Name = "Teleport Safe Spot", Callback = MainConfig.SafeTp })

Tab_Teleport:AddSection("Jugadores")
local SelectedPlayer = nil
local PlayerList = {}
local function UpdatePlayerList()
    PlayerList = {}
    for _, p in pairs(Players:GetPlayers()) do table.insert(PlayerList, p.Name) end
end
UpdatePlayerList()

local PlayerDropdown = Tab_Teleport:AddDropdown({
    Name = "Seleccionar Jugador", Flag = "SeleccionarJugador", Save = true, Options = PlayerList,
    Callback = function(Value) SelectedPlayer = Value end
})

Players.PlayerAdded:Connect(function() UpdatePlayerList(); PlayerDropdown:SetOptions(PlayerList) end)
Players.PlayerRemoving:Connect(function() UpdatePlayerList(); PlayerDropdown:SetOptions(PlayerList) end)

Tab_Teleport:AddButton({
    Name = "TP a Jugador",
    Callback = function()
        local Target = Players:FindFirstChild(SelectedPlayer)
        if Target and Target.Character and LocalPlayer.Character then
            LocalPlayer.Character:SetPrimaryPartCFrame(Target.Character.HumanoidRootPart.CFrame)
        end
    end
})

Tab_Teleport:AddSection("Especiales Mapa")
Tab_Teleport:AddButton({
    Name = "Launch Rocket (Launch Land)",
    Callback = function()
        local mapModel = workspace.Structure:FindFirstChild("Launch Land")
        if mapModel then
            if mapModel:FindFirstChild("LoadingTower") then
                local console = mapModel.LoadingTower:FindFirstChild("Console")
                if console and console:FindFirstChild("ReleaseEntryBridge") and console.ReleaseEntryBridge:FindFirstChildWhichIsA("ClickDetector") then
                    fireclickdetector(console.ReleaseEntryBridge:FindFirstChildWhichIsA("ClickDetector"))
                end
            end
            if mapModel:FindFirstChild("SPACESHIP!!") and mapModel["SPACESHIP!!"]:FindFirstChild("Shuttle") and mapModel["SPACESHIP!!"].Shuttle:FindFirstChild("IgnitionButton") then
                fireclickdetector(mapModel["SPACESHIP!!"].Shuttle.IgnitionButton:FindFirstChildWhichIsA("ClickDetector"))
            end
            if mapModel:FindFirstChild("RocketStand") then
                if mapModel.RocketStand:FindFirstChild("ConsoleLower") and mapModel.RocketStand.ConsoleLower:FindFirstChild("ReleaseButtonLower") then
                    fireclickdetector(mapModel.RocketStand.ConsoleLower.ReleaseButtonLower:FindFirstChildWhichIsA("ClickDetector"))
                end
                if mapModel.RocketStand:FindFirstChild("ConsoleUpper") and mapModel.RocketStand.ConsoleUpper:FindFirstChild("ReleaseButtonUpper") then
                    fireclickdetector(mapModel.RocketStand.ConsoleUpper.ReleaseButtonUpper:FindFirstChildWhichIsA("ClickDetector"))
                end
            end
        end
    end
})

Tab_Teleport:AddButton({
    Name = "Go to Prison (Prison Panic)",
    Callback = function()
        local mapModel = workspace.Structure:FindFirstChild("Prison Panic")
        if mapModel and mapModel:FindFirstChild("PrisonerAdmissionPart") and LocalPlayer.Character then
            LocalPlayer.Character.PrimaryPart.Velocity = Vector3.new(0,0,0)
            LocalPlayer.Character.HumanoidRootPart.CFrame = mapModel.PrisonerAdmissionPart.CFrame
        end
    end
})

Tab_Teleport:AddButton({
    Name = "TP to Basketball (Prison Panic)",
    Callback = function()
        local mapModel = workspace.Structure:FindFirstChild("Prison Panic")
        if mapModel and mapModel:FindFirstChild("Basketball") and LocalPlayer.Character then
            LocalPlayer.Character.PrimaryPart.Velocity = Vector3.new(0,0,0)
            LocalPlayer.Character.HumanoidRootPart.CFrame = mapModel.Basketball.CFrame
        end
    end
})

Tab_Teleport:AddButton({
    Name = "TP a Jugador Aleatorio",
    Callback = function()
        local players = Players:GetPlayers()
        local randomPlayer = players[math.random(1, #players)]
        if randomPlayer and randomPlayer ~= LocalPlayer and randomPlayer.Character then
            LocalPlayer.Character:MoveTo(randomPlayer.Character.HumanoidRootPart.Position)
        end
    end
})

Tab_Visual:AddSection("Mapa")
Tab_Visual:AddToggle({
    Name = "Isla Sólida (Rocks)", Flag = "IslaSlidaRocks", Save = true, Default = false,
    Callback = function(Value)
        for _, descendant in pairs(workspace:GetDescendants()) do
            if descendant.Name == "LowerRocks" then descendant.CanCollide = Value end
        end
    end
})

Tab_Visual:AddToggle({
    Name = "Reduce Earthquake", Flag = "ReduceEarthquake", Save = true, Default = false,
    Callback = function(state)
        getgenv().EarthquakeReducer = state
        if state then
            getgenv().EarthquakeConnection = RunService.Heartbeat:Connect(function()
                for _, part in pairs(workspace.Island:GetChildren()) do
                    if part:IsA("BasePart") or part:IsA("Part") then
                        part.Velocity = Vector3.new(0, 0, 0)
                    end
                end
            end)
        elseif getgenv().EarthquakeConnection then
            getgenv().EarthquakeConnection:Disconnect(); getgenv().EarthquakeConnection = nil
        end
    end
})

Tab_Visual:AddButton({ Name = "Día (Visual)", Callback = function() Lighting.ClockTime = 12; Lighting.Brightness = 2; Lighting.FogEnd = 1000 end })
Tab_Visual:AddButton({ Name = "Noche (Visual)", Callback = function() Lighting.ClockTime = 0; Lighting.Brightness = 0.2; Lighting.FogEnd = 300 end })

Tab_Visual:AddToggle({
    Name = "Forcefield Island", Flag = "ForcefieldIsland", Save = true, Default = false,
    Callback = function(state)
        for _, part in pairs(workspace.Island:GetDescendants()) do
            if part:IsA("BasePart") then part.Material = state and Enum.Material.ForceField or Enum.Material.Plastic end
        end
    end
})

Tab_Visual:AddButton({
    Name = "Reset Fog/Cloud",
    Callback = function()
        Lighting.FogEnd = 4000; Lighting.FogStart = 500
        if workspace.Structure:FindFirstChild("Cloud") then workspace.Structure.Cloud:Destroy() end
    end
})

Tab_Visual:AddSection("Limpieza UI/Efectos")
Tab_Visual:AddButton({ Name = "Eliminar Sandstorm/Blizzard GUI", Callback = function()
    pcall(function() LocalPlayer.PlayerGui.SandStormGui:Destroy() end)
    pcall(function() LocalPlayer.PlayerGui.BlizzardGui:Destroy() end)
end})

Tab_Visual:AddButton({
    Name = "Eliminar Anuncios",
    Callback = function()
        pcall(function() workspace.BillboardAd:Destroy() end)
        pcall(function() workspace["Main Portal Template "]:Destroy() end)
        pcall(function() workspace.ReturnPortal:Destroy() end)
        pcall(function() workspace.ForwardPortal:Destroy() end)
    end
})

Tab_Visual:AddToggle({
    Name = "Disable Virus Orbs", Flag = "DisableVirusOrbs", Save = true, Default = false,
    Callback = function(state)
        getgenv().VirusRemover = state
        if state then
            getgenv().VirusConnection = RunService.Heartbeat:Connect(function()
                if workspace.Structure:FindFirstChild("VirusParticles") then
                    for _, v in pairs(workspace.Structure.VirusParticles:GetChildren()) do
                        if v:IsA("Part") and v:FindFirstChild("TouchInterest") then v.TouchInterest:Destroy() end
                    end
                end
            end)
        elseif getgenv().VirusConnection then
            getgenv().VirusConnection:Disconnect(); getgenv().VirusConnection = nil
        end
    end
})

Tab_Visual:AddSection("Efectos RGB")
Tab_Visual:AddToggle({
    Name = "RGB Disaster Effects", Flag = "RGBDisasterEffects", Save = true, Default = false,
    Callback = function(state)
        getgenv().RgbDisaster = state
        if state then
            getgenv().RgbDisasterConn = RunService.Heartbeat:Connect(function()
                for _, part in pairs(workspace.Structure:GetDescendants()) do
                    if part:IsA("BasePart") then
                        if (part.Material == Enum.Material.Neon and part:FindFirstChild("Fire")) or table.find({"Dust","AcidRain","AvalanchePart","Cloud","Smoke","Lava","Virus"}, part.Name) then
                            part.Color = Color3.fromHSV(RgbEffect, 1, 1)
                        end
                    end
                end
                RgbEffect = (RgbEffect + 0.0039) % 1
            end)
        elseif getgenv().RgbDisasterConn then
            getgenv().RgbDisasterConn:Disconnect(); getgenv().RgbDisasterConn = nil
        end
    end
})

Tab_Visual:AddToggle({
    Name = "RGB Water", Flag = "RGBWater", Save = true, Default = false,
    Callback = function(state)
        getgenv().RgbWater = state
        if state then
            getgenv().RgbWaterConn = RunService.Heartbeat:Connect(function()
                local w = workspace:FindFirstChild("WaterLevel") or workspace.Structure:FindFirstChild("FloodLevel")
                if w then w.Color = Color3.fromHSV(WaterColor, 1, 1) end
                WaterColor = (WaterColor + 0.0039) % 1
            end)
        elseif getgenv().RgbWaterConn then
            getgenv().RgbWaterConn:Disconnect(); getgenv().RgbWaterConn = nil
        end
    end
})

Tab_Misc:AddSection("Herramientas")
Tab_Misc:AddButton({
    Name = "Go to China Server",
    Callback = function() TeleportService:Teleport(MainConfig.China, LocalPlayer) end
})
Tab_Misc:AddButton({ Name = "Reconectar", Callback = function() TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer) end })
Tab_Misc:AddButton({ Name = "Infinite Yield", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))() end })
Tab_Misc:AddButton({ Name = "Fly Gui V3", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/ySixxNz/projects-.lua/https/Fly%20Gui"))() end })
Tab_Misc:AddButton({ Name = "Coche volador", Callback = function() loadstring(game:HttpGet("https://pastebin.com/raw/MHE1cbWF"))() end })
Tab_Misc:AddButton({ Name = "Fling All", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/FloppHub-Team/Scripts/main/FlingAll"))() end })
Tab_Misc:AddToggle({ Name = "Anti Fling", Flag = "AntiFling", Save = true, Default = false, Callback = function(v) getgenv().AntiFling = v end })
Tab_Misc:AddButton({ Name = "Destruir Hub", Callback = function() Library:Destroy() end })
