-- [[ PAINEL UNIVERSAL-HUB-V1.7 BERSERKER ]]
-- Codename: @ayuks78 & @GmAI
-- Objetivo: Mira Instantânea e Dano Real (Anti-Bala Falsa)

local Players = game:GetService("Players")
local RS = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local lp = Players.LocalPlayer
local camera = workspace.CurrentCamera

-- [[ CONFIGURAÇÕES DE ELITE ]]
getgenv().Aimbot = false
getgenv().Hitbox = false
getgenv().HitSize = 5
getgenv().Sensibilidade = 1 -- 1 = Instantâneo (Gruda na hora)

-- [[ INTERFACE SQUARED V2 ]]
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "UniversalSystem_v1.7"
ScreenGui.Parent = (gethui and gethui()) or game:GetService("CoreGui")

-- Botão Quadrado Preto
local OpenBtn = Instance.new("ImageButton", ScreenGui)
OpenBtn.Size = UDim2.new(0, 45, 0, 45)
OpenBtn.Position = UDim2.new(0, 10, 0.5, -22)
OpenBtn.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
OpenBtn.Image = "rbxassetid://6023454774"
Instance.new("UICorner", OpenBtn).CornerRadius = UDim.new(0, 6)
OpenBtn.Draggable = true

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 480, 0, 330)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 12, 14)
MainFrame.Visible = false
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

-- Título com Selo
local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, -20, 0, 40)
Title.Position = UDim2.new(0, 15, 0, 5)
Title.Text = "Universal-Hub v1.7 ✔️"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.BackgroundTransparency = 1
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Abas
local TabBar = Instance.new("Frame", MainFrame)
TabBar.Size = UDim2.new(1, -20, 0, 35)
TabBar.Position = UDim2.new(0, 10, 0, 45)
TabBar.BackgroundTransparency = 1
Instance.new("UIListLayout", TabBar).FillDirection = Enum.FillDirection.Horizontal
Instance.new("UIListLayout", TabBar).Padding = UDim.new(0, 8)

local PageFolder = Instance.new("Frame", MainFrame)
PageFolder.Size = UDim2.new(1, -20, 1, -100)
PageFolder.Position = UDim2.new(0, 10, 0, 90)
PageFolder.BackgroundTransparency = 1

local function CreatePage(name)
    local Page = Instance.new("ScrollingFrame", PageFolder)
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.Visible = false
    Page.ScrollBarThickness = 0
    Instance.new("UIListLayout", Page).Padding = UDim.new(0, 10)

    local Btn = Instance.new("TextButton", TabBar)
    Btn.Size = UDim2.new(0, 90, 1, 0)
    Btn.BackgroundColor3 = Color3.fromRGB(20, 22, 26)
    Btn.Text = name
    Btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    Btn.Font = Enum.Font.GothamBold
    Btn.TextSize = 12
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 4)

    Btn.MouseButton1Click:Connect(function()
        for _, p in pairs(PageFolder:GetChildren()) do if p:IsA("ScrollingFrame") then p.Visible = false end end
        Page.Visible = true
    end)
    return Page
end

local MainP = CreatePage("Main")
local VisualP = CreatePage("Visuals")
local MiscP = CreatePage("Misc")

-- [[ CARDS ESTILO FOTO ]]
local function NewCard(parent, title, var)
    local Card = Instance.new("Frame", parent)
    Card.Size = UDim2.new(1, 0, 0, 50)
    Card.BackgroundColor3 = Color3.fromRGB(15, 17, 20)
    Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 6)
    
    local L = Instance.new("TextLabel", Card)
    L.Size = UDim2.new(0.7, 0, 1, 0); L.Position = UDim2.new(0, 12, 0, 0)
    L.Text = title; L.TextColor3 = Color3.fromRGB(255,255,255); L.Font = Enum.Font.Gotham; L.TextXAlignment = 0; L.BackgroundTransparency = 1

    local B = Instance.new("TextButton", Card)
    B.Size = UDim2.new(0, 45, 0, 24); B.Position = UDim2.new(1, -55, 0.5, -12)
    B.BackgroundColor3 = Color3.fromRGB(30, 33, 37); B.Text = ""
    Instance.new("UICorner", B).CornerRadius = UDim.new(0, 12)

    B.MouseButton1Click:Connect(function()
        getgenv()[var] = not getgenv()[var]
        B.BackgroundColor3 = getgenv()[var] and Color3.fromRGB(0, 150, 255) or Color3.fromRGB(30, 33, 37)
    end)
end

NewCard(MainP, "Aimbot Lock (Right Click)", "Aimbot")
NewCard(MainP, "Hitbox Expander (Anti-Bala Falsa)", "Hitbox")

-- Slider de Studs (Card Separado)
local SCard = Instance.new("Frame", MainP); SCard.Size = UDim2.new(1, 0, 0, 60); SCard.BackgroundColor3 = Color3.fromRGB(15, 17, 20)
Instance.new("UICorner", SCard).CornerRadius = UDim.new(0, 6)
local SLab = Instance.new("TextLabel", SCard); SLab.Size = UDim2.new(1, 0, 0, 25); SLab.Position = UDim2.new(0, 12, 0, 5); SLab.Text = "Hitbox Size: 5 studs"; SLab.TextColor3 = Color3.fromRGB(150, 150, 150); SLab.BackgroundTransparency = 1; SLab.TextXAlignment = 0
local SBar = Instance.new("Frame", SCard); SBar.Size = UDim2.new(1, -30, 0, 4); SBar.Position = UDim2.new(0, 15, 0, 40); SBar.BackgroundColor3 = Color3.fromRGB(25, 28, 32)
local SFil = Instance.new("Frame", SBar); SFil.Size = UDim2.new(0, 0, 1, 0); SFil.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
local SDot = Instance.new("TextButton", SBar); SDot.Size = UDim2.new(0, 14, 0, 14); SDot.Position = UDim2.new(0, -7, 0.5, -7); SDot.BackgroundColor3 = Color3.fromRGB(255, 255, 255); SDot.Text = ""
Instance.new("UICorner", SDot).CornerRadius = UDim.new(1, 0)

local dragging = false
SDot.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dragging = true end end)
UIS.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dragging = false end end)
UIS.InputChanged:Connect(function(i)
    if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        local p = math.clamp((i.Position.X - SBar.AbsolutePosition.X) / SBar.AbsoluteSize.X, 0, 1)
        SDot.Position = UDim2.new(p, -7, 0.5, -7); SFil.Size = UDim2.new(p, 0, 1, 0)
        getgenv().HitSize = math.floor(5 + (p * 45))
        SLab.Text = "Hitbox Size: " .. getgenv().HitSize .. " studs"
    end
end)

-- [[ LÓGICA DE COMBATE AGRESSIVA ]]
local function GetClosest()
    local target, dist = nil, 500
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= lp and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            local hum = v.Character:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then
                local pos, vis = camera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
                if vis then
                    local mag = (Vector2.new(pos.X, pos.Y) - UIS:GetMouseLocation()).Magnitude
                    if mag < dist then target = v.Character.HumanoidRootPart; dist = mag end
                end
            end
        end
    end
    return target
end

RS.RenderStepped:Connect(function()
    if getgenv().Aimbot and UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
        local t = GetClosest()
        if t then
            -- Mira direta sem suavização para grudar no inimigo correndo
            camera.CFrame = CFrame.new(camera.CFrame.Position, t.Position)
        end
    end
end)

RS.Heartbeat:Connect(function()
    if getgenv().Hitbox then
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= lp and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = v.Character.HumanoidRootPart
                hrp.Size = Vector3.new(getgenv().HitSize, getgenv().HitSize, getgenv().HitSize)
                hrp.Transparency = 0.7
                hrp.CanCollide = false -- ESSENCIAL: Permite que a bala atravesse a caixa e bata no corpo
                hrp.Massless = true
            end
        end
    end
end)

OpenBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)
MainP.Visible = true