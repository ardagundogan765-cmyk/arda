--Find Lua scripts online and paste them here!
-- JJSploit için Basit Blox Fruits Otomatik Meyve Bulucu
-- Kullanım: Scripti çalıştır, ekranda butonlar çıkacak

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local fruitESP = {}
local autoTP = false
local autoScan = false

-- GUI oluştur
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FruitFinder"
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Ana çerçeve
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 150)
frame.Position = UDim2.new(0, 10, 0, 10)
frame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
frame.BackgroundTransparency = 0.3
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

-- Başlık
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
title.Text = "Meyve Bulucu"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 20
title.Parent = frame

-- Tarama butonu
local scanButton = Instance.new("TextButton")
scanButton.Size = UDim2.new(1, -20, 0, 30)
scanButton.Position = UDim2.new(0, 10, 0, 40)
scanButton.BackgroundColor3 = Color3.new(0.3, 0.6, 1)
scanButton.Text = "Meyveleri Tara"
scanButton.TextColor3 = Color3.new(1, 1, 1)
scanButton.Font = Enum.Font.SourceSans
scanButton.TextSize = 18
scanButton.Parent = frame

-- Otomatik Işınlanma butonu
local tpButton = Instance.new("TextButton")
tpButton.Size = UDim2.new(1, -20, 0, 30)
tpButton.Position = UDim2.new(0, 10, 0, 75)
tpButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
tpButton.Text = "Otomatik Işınlanma: Kapalı"
tpButton.TextColor3 = Color3.new(1, 1, 1)
tpButton.Font = Enum.Font.SourceSans
tpButton.TextSize = 16
tpButton.Parent = frame

-- Otomatik Tarama butonu
local autoScanButton = Instance.new("TextButton")
autoScanButton.Size = UDim2.new(1, -20, 0, 30)
autoScanButton.Position = UDim2.new(0, 10, 0, 110)
autoScanButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
autoScanButton.Text = "Otomatik Tarama: Kapalı"
autoScanButton.TextColor3 = Color3.new(1, 1, 1)
autoScanButton.Font = Enum.Font.SourceSans
autoScanButton.TextSize = 16
autoScanButton.Parent = frame

-- ESP temizleme fonksiyonu
local function clearESP()
    for _, esp in pairs(fruitESP) do
        if esp then esp:Destroy() end
    end
    fruitESP = {}
end

-- Meyve bulma fonksiyonu
local function findFruits()
    clearESP()
    local fruits = {}
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("Tool") and v:FindFirstChild("Handle") and (v.Name:lower():find("fruit") or v.Name:find("Meyve")) then
            table.insert(fruits, v)
            -- ESP oluştur
            local billboard = Instance.new("BillboardGui")
            billboard.Name = "FruitESP"
            billboard.Adornee = v.Handle
            billboard.Size = UDim2.new(0, 150, 0, 40)
            billboard.StudsOffset = Vector3.new(0, 2, 0)
            billboard.AlwaysOnTop = true
            billboard.Parent = player.PlayerGui
            
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, 0, 1, 0)
            label.BackgroundTransparency = 1
            label.Text = v.Name
            label.TextColor3 = Color3.new(1, 0, 0)
            label.TextStrokeTransparency = 0
            label.Font = Enum.Font.SourceSansBold
            label.TextSize = 18
            label.Parent = billboard
            
            table.insert(fruitESP, billboard)
            
            -- Otomatik ışınlanma aktifse
            if autoTP then
                local fruitPos = v.Handle.Position
                character:MoveTo(fruitPos)
                wait(0.5)
            end
        end
    end
    return fruits
end

-- Tarama butonu işlevi
scanButton.MouseButton1Click:Connect(function()
    local fruits = findFruits()
    scanButton.Text = #fruits .. " meyve bulundu!"
    wait(1)
    scanButton.Text = "Meyveleri Tara"
end)

-- Otomatik ışınlanma butonu işlevi
tpButton.MouseButton1Click:Connect(function()
    autoTP = not autoTP
    if autoTP then
        tpButton.BackgroundColor3 = Color3.new(0, 1, 0)
        tpButton.Text = "Otomatik Işınlanma: Açık"
    else
        tpButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
        tpButton.Text = "Otomatik Işınlanma: Kapalı"
    end
end)

-- Otomatik tarama butonu işlevi
autoScanButton.MouseButton1Click:Connect(function()
    autoScan = not autoScan
    if autoScan then
        autoScanButton.BackgroundColor3 = Color3.new(0, 1, 0)
        autoScanButton.Text = "Otomatik Tarama: Açık"
        -- Otomatik tarama döngüsü
        spawn(function()
            while autoScan do
                findFruits()
                wait(3)
            end
        end)
    else
        autoScanButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
        autoScanButton.Text = "Otomatik Tarama: Kapalı"
    end
end)

-- Script çalıştığında mesaj
print("Meyve Bulucu yüklendi! JJSploit ile kullanım için tasarlandı.")
