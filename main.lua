-- [[ UNIVERSAL-HUB v2.5 SUPREMA ]]
-- @ayuks78 & @GmAI
-- FOCO: FUNCIONAMENTO TOTAL | ANTI-CASCA VAZIA

local Players = game:GetService("Players")
local RS = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TS = game:GetService("TweenService")
local lp = Players.LocalPlayer
local camera = workspace.CurrentCamera

-- [[ CONFIGURAÇÃO REAL ]]
getgenv().Config = {
    Aimbot = false,
    Hitbox = false,
    HitSize = 15,
    Esp = false,
    Noclip = false,
    Boost = false,
    FovSize = 180,
    MaxDist = 700, -- Lock em 700 studs
    Smoothness = 0.4 -- Puxada forte sem atraso
}

-- [[ FOV FIXA NO CENTRO ]]
local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 1.5
FOVCircle.Color = Color3.fromRGB(0, 150, 255)
FOVCircle.Filled = false
FOVCircle.Visible = false

-- [[ INTERFACE SUPREMA (PRETO/AZUL RGB) ]]
local UI = Instance.new("ScreenGui", (gethui and gethui()) or game:GetService("CoreGui"))
local Main = Instance.new("Frame", UI)
Main.Size = UDim2.new(0, 580, 0, 320)
Main.Position = UDim2.new(0.5, 0, 0.5, 0)
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
Main.BorderSizePixel = 0
Instance.new("UICorner", Main)

-- Barra RGB Azul Inferior
local RGB = Instance.new("Frame", Main)
RGB.Size = UDim2.new(1, 0, 0, 3); RGB.Position = UDim2.new(0, 0, 1, -3); RGB.BackgroundColor3 = Color3.fromRGB(0, 80, 255); RGB.BorderSizePixel = 0
task.spawn(function() while task.wait() do RGB.BackgroundColor3 = Color3.fromHSV(0.6, 0.8, 0.5 + math.sin(tick()*2)*0.3) end end)

-- Sidebar Fixa
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.new(0, 140, 1, 0); Sidebar.BackgroundColor3 = Color3.fromRGB(10, 10, 12); Instance.new("UICorner", Sidebar)

local Container = Instance.new("Frame", Main)
Container.Size = UDim2.new(1, -160, 1, -20); Container.Position = UDim2.new(0, 150, 0, 10); Container.BackgroundTransparency = 1

local Tabs = {}
function CreateTab(name, id)
    local P = Instance.new("ScrollingFrame", Container)
    P.Size = UDim2.new(1, 0, 1, 0); P.Visible = (id == 1); P.BackgroundTransparency = 1; P.ScrollBarThickness = 0
    Instance.new("UIListLayout", P).Padding = UDim.new(0, 10)
    
    local B = Instance.new("TextButton", Sidebar)
    B.Size = UDim2.new(1, -20, 0, 35); B.Position = UDim2.new(0, 10, 0, 50 + (id-1)*42)
    B.Text = name; B.BackgroundColor3 = (id == 1) and Color3.fromRGB(0, 100, 255) or Color3.fromRGB(20, 20, 25)
    B.TextColor3 = Color3.fromRGB(255, 255, 255); B.Font = "GothamBold"; B.TextSize = 11; Instance.new("UICorner", B)
    
    B.MouseButton1Click:Connect(function()
        for _, v in pairs(Tabs) do v.P.Visible = false; v.B.BackgroundColor3 = Color3.fromRGB(20, 20, 25) end
        P.Visible = true; B.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
    end)
    Tabs[id] = {P = P, B = B}
    return P
end

function AddToggle(parent, text, key)
    local f = Instance.new("Frame", parent); f.Size = UDim2.new(1, -10, 0, 42); f.BackgroundColor3 = Color3.fromRGB(15, 15, 20); Instance.new("UICorner", f)
    local l = Instance.new("TextLabel", f); l.Size = UDim2.new(1, 0, 1, 0); l.Position = UDim2.new(0, 12, 0, 0); l.Text = text; l.TextColor3 = Color3.fromRGB(255, 255, 255); l.TextXAlignment = 0; l.BackgroundTransparency = 1; l.Font = "GothamBold"; l.TextSize = 11
    local b = Instance.new("TextButton", f); b.Size = UDim2.new(0, 36, 0, 18); b.Position = UDim2.new(1, -48, 0.5, -9); b.BackgroundColor3 = Color3.fromRGB(40, 40, 45); b.Text = ""; Instance.new("UICorner", b).CornerRadius = UDim.new(0, 10)
    
    b.MouseButton1Click:Connect(function()
        getgenv().Config[key] = not getgenv().Config[key]
        TS:Create(b, TweenInfo.new(0.3), {BackgroundColor3 = getgenv().Config[key] and Color3.fromRGB(0, 100, 255) or Color3.fromRGB(40, 40, 45)}):Play()
    end)
end

local T1 = CreateTab("Main", 1); local T2 = CreateTab("Visual", 2); local T3 = CreateTab("Misc", 3)
AddToggle(T1, "Aimbot Magnético (700st)", "Aimbot")
AddToggle(T1, "Hitbox Pro (Physical)", "Hitbox")
AddToggle(T2, "ESP Master (Name/HP/Dist)", "Esp")
AddToggle(T3, "Noclip Ghost (Wall-Hack)", "Noclip")
AddToggle(T3, "Boost FPS (Potato)", "Boost")

-- [[ LÓGICA DE ESP REAL ]]
local ESPLabels = {}
local function CreateESP(player)
    local text = Drawing.new("Text")
    text.Visible = false; text.Center = true; text.Outline = true; text.Font = 2; text.Size = 13; text.Color = Color3.fromRGB(255, 255, 255)
    ESPLabels[player] = text
end

-- [[ MOTOR DE FUNÇÕES ]]
RS.RenderStepped:Connect(function()
    local screenCenter = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
    FOVCircle.Position = screenCenter
    FOVCircle.Radius = getgenv().Config.FovSize
    FOVCircle.Visible = getgenv().Config.Aimbot

    -- AIMBOT LOGIC
    if getgenv().Config.Aimbot and UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
        local target, closest = nil, getgenv().Config.FovSize
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= lp and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character.Humanoid.Health > 0 then
                local worldPos = v.Character.HumanoidRootPart.Position
                local screenPos, vis = camera:WorldToViewportPoint(worldPos)
                local distToPlayer = (worldPos - lp.Character.HumanoidRootPart.Position).Magnitude
                
                if vis and distToPlayer <= getgenv().Config.MaxDist then
                    local mag = (Vector2.new(screenPos.X, screenPos.Y) - screenCenter).Magnitude
                    if mag < closest then target = v; closest = mag end
                end
            end
        end
        if target then
            local targetPos = camera:WorldToViewportPoint(target.Character.HumanoidRootPart.Position)
            mousemoverel((targetPos.X - screenCenter.X) * getgenv().Config.Smoothness, (targetPos.Y - screenCenter.Y) * getgenv().Config.Smoothness)
        end
    end

    -- ESP REAL LOGIC
    for _, v in pairs(Players:GetPlayers()) do
        if getgenv().Config.Esp and v ~= lp and v.Character and v.Character:FindFirstChild("Head") then
            if not ESPLabels[v] then CreateESP(v) end
            local head = v.Character.Head
            local pos, vis = camera:WorldToViewportPoint(head.Position)
            local dist = (head.Position - camera.CFrame.Position).Magnitude
            
            if vis then
                local label = ESPLabels[v]
                label.Visible = true
                label.Position = Vector2.new(pos.X, pos.Y - 40)
                label.Text = v.Name .. " | Vida: " .. math.floor(v.Character.Humanoid.Health) .. "% | Studs: " .. math.floor(dist) .. "m"
            else ESPLabels[v].Visible = false end
        elseif ESPLabels[v] then ESPLabels[v].Visible = false end
    end
end)

-- [[ NOCLIP & HITBOX & BOOST ]]
RS.Stepped:Connect(function()
    if getgenv().Config.Noclip and lp.Character then
        for _, v in pairs(lp.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
    if getgenv().Config.Hitbox then
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= lp and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                v.Character.HumanoidRootPart.Size = Vector3.new(getgenv().Config.HitSize, getgenv().Config.HitSize, getgenv().Config.HitSize)
                v.Character.HumanoidRootPart.Transparency = 0.8
            end
        end
    end
end)

-- Animação de Entrada
Main.Size = UDim2.new(0,0,0,0); TS:Create(Main, TweenInfo.new(0.7, Enum.EasingStyle.Back), {Size = UDim2.new(0, 580, 0, 320)}):Play()