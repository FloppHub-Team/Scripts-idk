
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/FloppHub-Team/UIs/refs/heads/main/RedzLib%20Cracked"))()

local Window = Library:MakeWindow({
    Title = "Flopp Hub | Desastre Natural",
    SubTitle = "by FloppHub Team",
    SaveFolder = "FloppHub"
})

Window:Notify({
    Title = "Bienvenido a Flopp Hub",
    Content = "Script cargado exitosamente",
    Image = "rbxassetid://18503600329",
    Duration = 5
})

local Minimizer = Window:NewMinimizer({
    KeyCode = Enum.KeyCode.LeftControl
})

local MobileButton = Minimizer:CreateMobileMinimizer({
    Image = "rbxassetid://112586798808707",
    BackgroundColor3 = Color3.fromRGB(50, 50, 50)
})

-- TABS
local Tab_Home = Window:MakeTab({"Inicio", "rbxassetid://15841490359"})
local Tab_Main = Window:MakeTab({"Principal", "rbxassetid://4370336019"})
local Tab_Visual = Window:MakeTab({"Mapa/Visual", "rbxassetid://15885360708"})
local Tab_Teleport = Window:MakeTab({"Teletransportes", "rbxassetid://15841341821"})
local Tab_Humanoid = Window:MakeTab({"Humanoide", "rbxassetid://4400695581"})
local Tab_Misc = Window:MakeTab({"Otros", "rbxassetid://4370336704"})

-- HOME TAB
-- Tab_Home:AddSection("Créditos")
Tab_Home:AddParagraph("¡Bienvenido a Flopp Hub!", "Explora las funciones en las pestañas de arriba.\nSi alguna función deja de funcionar, avísame en Discord: RTZ_ANDRUUX")

-- Tab_Home:AddSection("Mi servidor de Discord")
Tab_Home:AddButton({
    Name = "Enlace al Servidor",
    Callback = function()
        setclipboard("https://discord.gg/J9dSv7hq55")
        Window:Notify({
            Title = "Aviso",
            Content = "Enlace copiado al portapapeles",
            Duration = 5
        })
    end
})

-- MAIN TAB
-- Tab_Main:AddSection("Troll")

Tab_Main:AddButton({
    Name = "Fling All",
    Callback = function()
        -- Original Fling Logic
        local Targets = {"All"}
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local FlingAll = false
        
        local function GetPlayer(name)
            name = name:lower()
            if name == "all" or name == "others" then
                FlingAll = true
                return
            end
            if name == "random" then
                local playerList = Players:GetPlayers()
                if table.find(playerList, LocalPlayer) then
                    table.remove(playerList, table.find(playerList, LocalPlayer))
                end
                return playerList[math.random(#playerList)]
            end
            if name ~= "random" and name ~= "all" and name ~= "others" then
                for _, player in pairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer then
                        if player.Name:lower():match("^" .. name) then
                            return player
                        end
                        if player.DisplayName:lower():match("^" .. name) then
                            return player
                        end
                    end
                end
            end
        end
        
        local function FlingPlayer(targetPlayer)
            local MyChar = LocalPlayer.Character
            local MyHumanoid = MyChar and MyChar:FindFirstChildOfClass("Humanoid")
            local MyRoot = MyHumanoid and MyHumanoid.RootPart
            
            local TargetChar = targetPlayer.Character
            local TargetHumanoid = TargetChar and TargetChar:FindFirstChildOfClass("Humanoid")
            local TargetRoot = TargetHumanoid and TargetHumanoid.RootPart
            local TargetHead = TargetChar and TargetChar:FindFirstChild("Head")
            
            if not MyRoot or not TargetRoot then return end
            
            if MyRoot.Velocity.Magnitude < 50 then
                getgenv().OldPos = MyRoot.CFrame
            end
            
            if TargetHumanoid and TargetHumanoid.Sit and not FlingAll then
               return
            end
            
            if TargetHead then
                workspace.CurrentCamera.CameraSubject = TargetHead
            elseif TargetHumanoid then
                workspace.CurrentCamera.CameraSubject = TargetHumanoid
            end
            
            local function SetFlingVelocity(root, displacement, rotation)
                 MyRoot.CFrame = CFrame.new(root.Position) * displacement * rotation
                 MyChar:SetPrimaryPartCFrame(CFrame.new(root.Position) * displacement * rotation)
                 MyRoot.Velocity = Vector3.new(90000000, 900000000, 90000000)
                 MyRoot.RotVelocity = Vector3.new(900000000, 900000000, 900000000)
            end
            
            local function FlingAttack(targetRoot)
                local angle = 0
                local startTime = tick()
                
                while MyRoot do
                     if not TargetRoot then break end
                     
                     local vel = targetRoot.Velocity.Magnitude
                     if vel < 50 then
                         angle = angle + 100
                         SetFlingVelocity(targetRoot, CFrame.new(0, 1.5, 0) + TargetHumanoid.MoveDirection * targetRoot.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(angle), 0, 0))
                         task.wait()
                         SetFlingVelocity(targetRoot, CFrame.new(0, -1.5, 0) + TargetHumanoid.MoveDirection * targetRoot.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(angle), 0, 0))
                         task.wait()
                         SetFlingVelocity(targetRoot, CFrame.new(2.25, 1.5, -2.25) + TargetHumanoid.MoveDirection * targetRoot.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(angle), 0, 0))
                         task.wait()
                         SetFlingVelocity(targetRoot, CFrame.new(-2.25, -1.5, 2.25) + TargetHumanoid.MoveDirection * targetRoot.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(angle), 0, 0))
                         task.wait()
                         SetFlingVelocity(targetRoot, CFrame.new(0, 1.5, 0) + TargetHumanoid.MoveDirection, CFrame.Angles(math.rad(angle), 0, 0))
                         task.wait()
                         SetFlingVelocity(targetRoot, CFrame.new(0, -1.5, 0) + TargetHumanoid.MoveDirection, CFrame.Angles(math.rad(angle), 0, 0))
                         task.wait()
                     else
                         SetFlingVelocity(targetRoot, CFrame.new(0, 1.5, TargetHumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                         task.wait()
                         SetFlingVelocity(targetRoot, CFrame.new(0, -1.5, -TargetHumanoid.WalkSpeed), CFrame.Angles(0, 0, 0))
                         task.wait() 
                          SetFlingVelocity(targetRoot, CFrame.new(0, 1.5, TargetHumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
                          task.wait()
                          SetFlingVelocity(targetRoot, CFrame.new(0, 1.5, TargetRoot.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
                          task.wait()
                          SetFlingVelocity(targetRoot, CFrame.new(0, -1.5, -TargetRoot.Velocity.Magnitude / 1.25), CFrame.Angles(0, 0, 0))
                          task.wait()
                          SetFlingVelocity(targetRoot, CFrame.new(0, 1.5, TargetRoot.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
                          task.wait()
                          SetFlingVelocity(targetRoot, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0))
                          task.wait()
                          SetFlingVelocity(targetRoot, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                          task.wait()
                          SetFlingVelocity(targetRoot, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(-90), 0, 0))
                          task.wait()
                          SetFlingVelocity(targetRoot, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                          task.wait()
                     end
                     
                     if targetRoot.Velocity.Magnitude > 500 then break end
                     if not TargetChar.Parent then break end
                     if TargetChar ~= targetPlayer.Character then break end
                     if MyHumanoid.Health <= 0 then break end
                     if startTime + 2 < tick() then break end
                end
            end

            workspace.FallenPartsDestroyHeight = 0/0
            
            local BodyVel = Instance.new("BodyVelocity")
            BodyVel.Name = "EpixVel"
            BodyVel.Parent = MyRoot
            BodyVel.Velocity = Vector3.new(900000000, 900000000, 900000000)
            BodyVel.MaxForce = Vector3.new(1/0, 1/0, 1/0)
            
            MyHumanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
            
            if TargetRoot then
                FlingAttack(TargetRoot)
            end
            
            BodyVel:Destroy()
            MyHumanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
            workspace.CurrentCamera.CameraSubject = MyHumanoid
            
            repeat
                MyRoot.CFrame = getgenv().OldPos * CFrame.new(0, 0.5, 0)
                MyChar:SetPrimaryPartCFrame(getgenv().OldPos * CFrame.new(0, 0.5, 0))
                MyHumanoid:ChangeState("GettingUp")
                for _, part in pairs(MyChar:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.RotVelocity = Vector3.new()
                        part.Velocity = Vector3.new()
                    end
                end
                task.wait()
            until (MyRoot.Position - getgenv().OldPos.p).Magnitude < 25
            workspace.FallenPartsDestroyHeight = getgenv().FPDH
        end
        
        getgenv().Welcome = true
        if Targets[1] then
             for _, name in pairs(Targets) do
                 GetPlayer(name)
             end
        else
            return
        end
        
        if FlingAll then
            for _, player in pairs(Players:GetPlayers()) do
                FlingPlayer(player)
            end
        end
        
        for _, name in pairs(Targets) do
            local target = GetPlayer(name)
            if target and target ~= LocalPlayer then
                 if target.UserId ~= 1414978355 then
                     FlingPlayer(target)
                 end
            end
        end
    end
})

-- Tab_Main:AddSection("AutoFarme")
local FarmConnection = nil
Tab_Main:AddToggle({
    Name = "AutoFarme Victoria",
    Default = false,
    Callback = function(Value)
        if Value then
            FarmConnection = game:GetService("RunService").RenderStepped:Connect(function()
                if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-233.8095703125, 179.83950805664063, 311.78717041015625)
                end
            end)
        elseif FarmConnection then
            FarmConnection:Disconnect()
            FarmConnection = nil
        end
    end
})

-- Tab_Main:AddSection("Gamepass")
Tab_Main:AddParagraph("Nota", "Si 'Obtener el globo verde' no funciona, sigue intentándolo hasta que lo hagas. Sólo funciona si otro jugador tiene el globo en la mano.")
Tab_Main:AddButton({
    Name = "Obtener Globo Verde",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ySixxNz/Scripts/https/balao"))()
    end
})
Tab_Main:AddToggle({
    Name = "Elegir Mapa (Parcheado)",
    Default = false,
    Callback = function(Value)
        pcall(function()
            game.Players.LocalPlayer.PlayerGui.MainGui.MapVotePage.Visible = Value
        end)
    end
})

-- Tab_Main:AddSection("Desastre")
local DisasterNames = {
    Portuguese = {
        ["Flash Flood"] = "Inundações rápidas", Tornado = "Tornado", ["Thunder Storm"] = "Tempestade elétrica", Fire = "Fogo",
        ["Meteor Shower"] = "Chuva de meteoros", Tsunami = "Tsunami", Blizzard = "Tempestade de neve", Sandstorm = "Tempestade de areia",
        ["Acid Rain"] = "Chuva Ácida", ["Volcanic Eruption"] = "Erupção vulcânica", Earthquake = "Terremoto", ["Deadly Virus"] = "Vírus mortal",
        ["Next Disaster:"] = "Próximo desastre:",
    },
    English = {
        ["Flash Flood"] = "Flash flood", Tornado = "Tornado", ["Thunder Storm"] = "Thunder storm", Fire = "Fire",
        ["Meteor Shower"] = "Meteor shower", Tsunami = "Tsunami", Blizzard = "Blizzard", Sandstorm = "Sandstorm",
        ["Acid Rain"] = "Acid Rain", ["Volcanic Eruption"] = "Volcanic Eruption", Earthquake = "Earthquake", ["Deadly Virus"] = "Deadly Virus",
        ["Next Disaster:"] = "Next disaster:",
    },
    Spanish = {
        ["Flash Flood"] = "Inundación rápida", Tornado = "Tornado", ["Thunder Storm"] = "Tormenta eléctrica", Fire = "Fuego",
        ["Meteor Shower"] = "Lluvia de meteoritos", Tsunami = "Tsunami", Blizzard = "Tormenta de nieve", Sandstorm = "Tormenta de arena",
        ["Acid Rain"] = "Lluvia ácida", ["Volcanic Eruption"] = "Erupción volcánica", Earthquake = "Terremoto", ["Deadly Virus"] = "Virus mortal",
        ["Next Disaster:"] = "Próximo desastre:",
    },
    Russian = {
        ["Flash Flood"] = "Лавина", Tornado = "Торнадо", ["Thunder Storm"] = "Гроза", Fire = "Пожар",
        ["Meteor Shower"] = "Метеоритный дождь", Tsunami = "Цунами", Blizzard = "Снегопад", Sandstorm = "Песчаная буря",
        ["Acid Rain"] = "Кислотный дождь", ["Volcanic Eruption"] = "Вулканическое извержение", Earthquake = "Землетрясение", ["Deadly Virus"] = "Смертоносный вирус",
        ["Next Disaster:"] = "Следующий desastre:",
    },
}
local CurrentLanguage = "Spanish"
local LastDisaster = ""

Tab_Main:AddDropdown({
    Name = "Idioma Desastre",
    Default = "Spanish",
    Options = {"Portuguese", "English", "Spanish", "Russian"},
    Callback = function(Value)
        CurrentLanguage = Value
    end
})

Tab_Main:AddButton({
    Name = "Exponer Desastre (Chat)",
    Callback = function()
        local Character = game.Players.LocalPlayer.Character
        if Character then
            local SurvivalTag = Character:FindFirstChild("SurvivalTag")
            if SurvivalTag and SurvivalTag.Value then
                local Message = DisasterNames[CurrentLanguage]["Next Disaster:"] .. " " .. (DisasterNames[CurrentLanguage][SurvivalTag.Value] or SurvivalTag.Value)
                Window:Notify({ Title = "¡Desastre Detectado!", Content = Message, Duration = 5 })
                
                local TextChatService = game:GetService("TextChatService")
                if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
                     local ChatInput = TextChatService:FindFirstChildOfClass("ChatInputBarConfiguration")
                     if ChatInput and ChatInput.TargetTextChannel then
                         ChatInput.TargetTextChannel:SendAsync(Message)
                     end
                else
                     local ReplicatedStorage = game:GetService("ReplicatedStorage")
                     local ChatEvents = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
                     if ChatEvents then
                         local SayMessage = ChatEvents:FindFirstChild("SayMessageRequest")
                         if SayMessage then
                             SayMessage:FireServer(Message, "All")
                         end
                     end
                end
            else
                Window:Notify({ Title = "Error", Content = "No se encontró SurvivalTag (¿Estás en partida?)", Duration = 3 })
            end
        else
             Window:Notify({ Title = "Error", Content = "No se encontró el Personaje", Duration = 3 })
        end
    end
})

Tab_Main:AddButton({
    Name = "Notificar Desastre (Local)",
    Callback = function()
        local Character = game.Players.LocalPlayer.Character
        if Character then
            local SurvivalTag = Character:FindFirstChild("SurvivalTag")
            if SurvivalTag and SurvivalTag.Value then
                Window:Notify({
                    Title = "¡Desastre Detectado!",
                    Content = DisasterNames[CurrentLanguage]["Next Disaster:"] .. " " .. (DisasterNames[CurrentLanguage][SurvivalTag.Value] or SurvivalTag.Value),
                    Duration = 5
                })
            else
                Window:Notify({ Title = "Error", Content = "No se encontró SurvivalTag (¿Estás en partida?)", Duration = 3 })
            end
        end
    end
})

Tab_Main:AddToggle({
    Name = "Auto Notify Disaster",
    Default = false,
    Callback = function(Value)
        local Active = Value
        task.spawn(function()
            while Active and Value do
                local Character = game.Players.LocalPlayer.Character
                if Character then
                    local SurvivalTag = Character:FindFirstChild("SurvivalTag")
                    if SurvivalTag and SurvivalTag.Value then
                        local Disaster = DisasterNames[CurrentLanguage][SurvivalTag.Value] or SurvivalTag.Value
                        local FullMessage = DisasterNames[CurrentLanguage]["Next Disaster:"] .. " " .. Disaster
                        
                        if Disaster ~= LastDisaster then
                            Window:Notify({ Title = "Disaster Detected!", Content = FullMessage, Duration = 5 })
                            LastDisaster = Disaster
                        end
                    end
                end
                task.wait(5)
                if not Active then break end
            end
        end)
        if not Value then Active = false end
    end
})

-- Tab_Main:AddSection("Spam Mensaje")
local SpamLooping = false
local SpamMessage = "Six Hub en la Cima"
local SpamDelay = 1

Tab_Main:AddTextBox({
    Name = "Mensaje",
    Default = "Flopp Hub en la Cima",
    Callback = function(Value)
        SpamMessage = Value
    end
})
Tab_Main:AddTextBox({
    Name = "Retraso (Segundos)",
    Default = "1",
    Callback = function(Value)
        SpamDelay = tonumber(Value) or 1
    end
})
Tab_Main:AddToggle({
    Name = "Loop de Mensajes",
    Default = false,
    Callback = function(Value)
        SpamLooping = Value
        if Value then
            task.spawn(function()
                while SpamLooping do
                    local TextChatService = game:GetService("TextChatService")
                    if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
                         local ChatInput = TextChatService:FindFirstChildOfClass("ChatInputBarConfiguration")
                         if ChatInput and ChatInput.TargetTextChannel then
                             ChatInput.TargetTextChannel:SendAsync(SpamMessage)
                         end
                    else
                         local ReplicatedStorage = game:GetService("ReplicatedStorage")
                         local ChatEvents = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
                         if ChatEvents then
                             local SayMessage = ChatEvents:FindFirstChild("SayMessageRequest")
                             if SayMessage then
                                 SayMessage:FireServer(SpamMessage, "All")
                             end
                         end
                    end
                    task.wait(SpamDelay)
                end
            end)
        end
    end
})

-- Tab_Main:AddSection("Otros")
local AntiFlingEnabled = false
Tab_Main:AddToggle({
    Name = "Anti Fling",
    Default = false,
    Callback = function(Value)
        AntiFlingEnabled = Value
    end
})

local AntiFallActive = false
local AntiFallConnection = nil
Tab_Main:AddToggle({
    Name = "Sin daño por caída",
    Default = false,
    Callback = function(Value)
        AntiFallActive = Value
        if Value then
            local function ConnectAntiFall(char)
                local root = char:WaitForChild("HumanoidRootPart", 5)
                if root then
                    AntiFallConnection = game:GetService("RunService").Heartbeat:Connect(function()
                        if not root.Parent then
                            if AntiFallConnection then AntiFallConnection:Disconnect() end
                            return
                        end
                        if AntiFallActive then
                            local oldVel = root.AssemblyLinearVelocity
                            root.AssemblyLinearVelocity = Vector3.zero
                            game:GetService("RunService").RenderStepped:Wait()
                            root.AssemblyLinearVelocity = oldVel
                        end
                    end)
                end
            end
            if game.Players.LocalPlayer.Character then
                ConnectAntiFall(game.Players.LocalPlayer.Character)
            end
            game.Players.LocalPlayer.CharacterAdded:Connect(ConnectAntiFall)
        elseif AntiFallConnection then
            AntiFallConnection:Disconnect()
            AntiFallConnection = nil
        end
    end
})

Tab_Main:AddToggle({
    Name = "Caminar sobre el Agua",
    Default = false,
    Callback = function(Value)
        local Water = workspace:FindFirstChild("WaterLevel")
        if Water then
            if not Value then
                Water.CanCollide = false
                Water.Size = Vector3.new(10, 1, 10)
            else
                Water.CanCollide = true
                Water.Size = Vector3.new(1000, 1, 1000)
            end
        end
    end
})


-- VISUAL TAB
-- Tab_Visual:AddSection("Isla")
Tab_Visual:AddToggle({
    Name = "Isla Sólida",
    Default = false,
    Callback = function(Value)
         for _, descendant in pairs(game.workspace:GetDescendants()) do
             if descendant.Name == "LowerRocks" then
                 descendant.CanCollide = Value
             end
         end
    end
})

-- Tab_Visual:AddSection("Ciclo día y noche")
Tab_Visual:AddButton({
    Name = "Día (Visual)",
    Callback = function()
         game.Lighting.ClockTime = 12
         game.Lighting.Brightness = 2
         game.Lighting.FogEnd = 1000
    end
})
Tab_Visual:AddButton({
    Name = "Noche (Visual)",
    Callback = function()
         game.Lighting.ClockTime = 0
         game.Lighting.Brightness = 0.2
         game.Lighting.FogEnd = 300
    end
})

-- Tab_Visual:AddSection("UI")
Tab_Visual:AddButton({
    Name = "Eliminar UI Tormenta Arena",
    Callback = function()
        pcall(function() game.Players.LocalPlayer.PlayerGui.SandStormGui:Destroy() end)
    end
})
Tab_Visual:AddButton({
    Name = "Eliminar UI Ventisca",
    Callback = function()
        pcall(function() game.Players.LocalPlayer.PlayerGui.BlizzardGui:Destroy() end)
    end
})
Tab_Visual:AddButton({
    Name = "Eliminar Anuncios",
    Callback = function()
         local Workplace = game:GetService("Workspace")
         pcall(function() Workplace.BillboardAd:Destroy() end)
         pcall(function() Workplace["Main Portal Template "]:Destroy() end)
         pcall(function() Workplace.ReturnPortal:Destroy() end)
         pcall(function() Workplace.ForwardPortal:Destroy() end)
    end
})

-- TELEPORT TAB
-- Tab_Teleport:AddSection("Teletransportarse al jugador")
local SelectedPlayer = nil
local PlayerList = {}
for _, player in pairs(game.Players:GetPlayers()) do
    table.insert(PlayerList, player.Name)
end

local PlayerDropdown = Tab_Teleport:AddDropdown({
    Name = "Seleccionar Jugador",
    Options = PlayerList,
    Callback = function(Value)
        SelectedPlayer = Value
    end
})

game.Players.PlayerAdded:Connect(function(player)
    table.insert(PlayerList, player.Name)
    PlayerDropdown:SetOptions(PlayerList) 
end)
game.Players.PlayerRemoving:Connect(function(player)
    for i, v in ipairs(PlayerList) do
        if v == player.Name then
            table.remove(PlayerList, i)
            break
        end
    end
    PlayerDropdown:SetOptions(PlayerList)
end)

Tab_Teleport:AddButton({
    Name = "TP a Jugador Sleccionado",
    Callback = function()
         local Target = game.Players:FindFirstChild(SelectedPlayer)
         if Target and Target.Character and game.Players.LocalPlayer.Character then
             game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(Target.Character:WaitForChild("HumanoidRootPart").CFrame)
         end
    end
})
Tab_Teleport:AddButton({
    Name = "TP a Jugador Aleatorio",
    Callback = function()
        local players = game.Players:GetPlayers()
        local randomPlayer = players[math.random(1, #players)]
        if randomPlayer and randomPlayer.Character and randomPlayer.Character:FindFirstChild("HumanoidRootPart") and game.Players.LocalPlayer.Character then
            game.Players.LocalPlayer.Character:MoveTo(randomPlayer.Character.HumanoidRootPart.Position)
        end
    end
})

-- Tab_Teleport:AddSection("Lugares")
Tab_Teleport:AddButton({
    Name = "TP Isla",
    Callback = function()
        if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
             game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-108, 49, 0)
        end
    end
})
Tab_Teleport:AddButton({
    Name = "TP Torre",
    Callback = function()
        if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
             game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-264, 196, 288)
        end
    end
})

-- HUMANOID TAB
-- Tab_Humanoid:AddSection("Humanoide")

Tab_Humanoid:AddSlider({
    Name = "Velocidad",
    Min = 16,
    Max = 500,
    Default = 16,
    Increment = 1,
    Callback = function(Value)
        getgenv().Walkspeed = Value
        pcall(function()
             game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
        end)
    end
})

Tab_Humanoid:AddSlider({
    Name = "Salto",
    Min = 50,
    Max = 500,
    Default = 50,
    Increment = 1,
    Callback = function(Value)
        getgenv().Jumppower = Value
        pcall(function()
             game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
        end)
    end
})

-- Tab_Humanoid:AddSection("Loops")
local LoopJump = false
Tab_Humanoid:AddToggle({
    Name = "Loop de Salto",
    Default = false,
    Callback = function(Value)
         LoopJump = Value
         task.spawn(function()
             while LoopJump do
                 pcall(function()
                     game.Players.LocalPlayer.Character.Humanoid.JumpPower = getgenv().Jumppower or 50
                 end)
                 task.wait()
             end
         end)
    end
})

local LoopSpeed = false
Tab_Humanoid:AddToggle({
    Name = "Loop de Velocidad",
    Default = false,
    Callback = function(Value)
         LoopSpeed = Value
         task.spawn(function()
             while LoopSpeed do
                 pcall(function()
                     game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = getgenv().Walkspeed or 16
                 end)
                 task.wait()
             end
         end)
    end
})

-- Tab_Humanoid:AddSection("Cámara")
Tab_Humanoid:AddSlider({
    Name = "FOV",
    Min = 70,
    Max = 120,
    Default = 70,
    Increment = 1,
    Callback = function(Value)
        workspace.CurrentCamera.FieldOfView = Value
    end
})

-- MISC TAB
-- Tab_Misc:AddSection("Opciones")
Tab_Misc:AddButton({
    Name = "Reconectar",
    Callback = function()
         loadstring(game:HttpGet("https://pastebin.com/raw/1gtVMUz3"))()
    end
})
Tab_Misc:AddButton({
    Name = "Destruir Hub",
    Callback = function()
         Library:Destroy()
    end
})

-- Tab_Misc:AddSection("Otros Scripts")
Tab_Misc:AddButton({
    Name = "Infinite Yield",
    Callback = function()
         loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
    end
})
Tab_Misc:AddButton({
    Name = "Fly Gui V3",
    Callback = function()
         loadstring(game:HttpGet("https://raw.githubusercontent.com/ySixxNz/projects-.lua/https/Fly%20Gui"))()
    end
})
Tab_Misc:AddButton({
    Name = "Coche volador",
    Callback = function()
         loadstring(game:HttpGet("https://pastebin.com/raw/MHE1cbWF"))()
    end
})

-- Safe Service Proxy & Anti Fling Logic
local SafeServices = setmetatable({}, {
    __index = function(self, serviceName)
        local service = game:GetService(serviceName)
        if service then
            self[serviceName] = service
        end
        return service
    end,
})

local LocalPlayer = SafeServices.Players.LocalPlayer
local LastFlingPos = nil

local function AntiFlingCheck(player)
    local flingDetected = false
    local character = nil
    local rootPart = nil
    
    task.spawn(function()
         character = player.Character or player.CharacterAdded:Wait()
         repeat
             task.wait()
             rootPart = character:FindFirstChild("HumanoidRootPart")
         until rootPart
         flingDetected = false
    end)
    
    player.CharacterAdded:Connect(function(newChar)
          character = newChar
          repeat
              task.wait()
              rootPart = character:FindFirstChild("HumanoidRootPart")
          until rootPart
          flingDetected = false
    end)
    
    SafeServices.RunService.Heartbeat:Connect(function()
         if not AntiFlingEnabled then return end
         
         if character and character:IsDescendantOf(workspace) and rootPart and rootPart:IsDescendantOf(character) and (rootPart.AssemblyAngularVelocity.Magnitude > 50 or rootPart.AssemblyLinearVelocity.Magnitude > 100) then
             if not flingDetected then
                 game.StarterGui:SetCore("ChatMakeSystemMessage", {
                     Text = "Exploit de Fling detectado, Jugador: " .. tostring(player),
                     Color = Color3.fromRGB(255, 200, 0),
                 })
             end
             flingDetected = true
             
             for _, part in ipairs(character:GetDescendants()) do
                 if part:IsA("BasePart") then
                     part.CanCollide = false
                     part.AssemblyAngularVelocity = Vector3.zero
                     part.AssemblyLinearVelocity = Vector3.zero
                     part.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0)
                 end
             end
             
             rootPart.CanCollide = false
             rootPart.AssemblyAngularVelocity = Vector3.zero
             rootPart.AssemblyLinearVelocity = Vector3.zero
             rootPart.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0)
         end
    end)
end

for _, player in ipairs(SafeServices.Players:GetPlayers()) do
    if player ~= LocalPlayer then
        AntiFlingCheck(player)
    end
end

SafeServices.Players.PlayerAdded:Connect(AntiFlingCheck)

SafeServices.RunService.Heartbeat:Connect(function()
    if not AntiFlingEnabled then return end
    
    pcall(function()
         local primaryPart = LocalPlayer.Character and LocalPlayer.Character.PrimaryPart
         if primaryPart then
             if primaryPart.AssemblyLinearVelocity.Magnitude > 250 or primaryPart.AssemblyAngularVelocity.Magnitude > 250 then
                 primaryPart.AssemblyAngularVelocity = Vector3.zero
                 primaryPart.AssemblyLinearVelocity = Vector3.zero
                 primaryPart.CFrame = LastFlingPos
                 
                 game.StarterGui:SetCore("ChatMakeSystemMessage", {
                     Text = "Has sido lanzado. Neutralizando velocidad.",
                     Color = Color3.fromRGB(255, 0, 0),
                 })
             elseif primaryPart.AssemblyLinearVelocity.Magnitude < 50 or primaryPart.AssemblyAngularVelocity.Magnitude < 50 then
                 LastFlingPos = primaryPart.CFrame
             end
         end
    end)
end)
