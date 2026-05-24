local coreGui = game:GetService("CoreGui")
local runService = game:GetService("RunService")
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer

local saldoFalso = 31606
local ultimoSaldoFalsoStr = "31.606"

local function formatearNumero(numero)
    local v = tostring(numero)
    return v:reverse():gsub("(%d%d%d)", "%1."):reverse():gsub("^%.", "")
end

local botonesConectados = {}

local function detectarCompra()
    local precio = 0
    for _, gui in ipairs({coreGui, localPlayer:FindFirstChild("PlayerGui")}) do
        if gui then
            for _, v in ipairs(gui:GetDescendants()) do
                if v:IsA("TextLabel") and not v.Text:find(ultimoSaldoFalsoStr) then
                    local numStr = v.Text:match("%d+")
                    if numStr then
                        local valor = tonumber(numStr)
                        if valor and valor > 0 and valor < 100000 and (v.Name:lower():find("price") or v.Text:find("R$") or string.len(numStr) == string.len(v.Text:gsub("%D", ""))) then
                            precio = valor
                        end
                    end
                end
            end
        end
    end

    if precio > 0 then
        saldoFalso = saldoFalso - precio
        if saldoFalso < 0 then saldoFalso = 0 end
    end
end

runService.RenderStepped:Connect(function()
    local strFalso = formatearNumero(saldoFalso)
    
    for _, gui in ipairs({coreGui, localPlayer:FindFirstChild("PlayerGui")}) do
        if gui then
            for _, v in ipairs(gui:GetDescendants()) do
                if v:IsA("TextLabel") then
                    local txt = v.Text
                    if txt:find("2%.606") then
                        v.Text = txt:gsub("2%.606", strFalso)
                    elseif txt:find("2,606") then
                        v.Text = txt:gsub("2,606", strFalso)
                    elseif txt:find(ultimoSaldoFalsoStr) and ultimoSaldoFalsoStr ~= strFalso then
                        v.Text = txt:gsub(ultimoSaldoFalsoStr, strFalso)
                    end
                end
                
                if v:IsA("TextButton") or v:IsA("ImageButton") then
                    local esBotonCompra = false
                    if v:IsA("TextButton") and (v.Text:lower():find("comprar") or v.Text:lower():find("buy")) then
                        esBotonCompra = true
                    elseif v.Name:lower():find("buy") or v.Name:lower():find("purchase") then
                        esBotonCompra = true
                    end

                    if esBotonCompra and not botonesConectados[v] then
                        botonesConectados[v] = v.MouseButton1Click:Connect(detectarCompra)
                    end
                end
            end
        end
    end
    
    ultimoSaldoFalsoStr = strFalso
end)
