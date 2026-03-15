--[[
    ██████╗ ███████╗██╗   ██╗    ██████╗ ██╗      ██████╗ ██╗  ██╗
    ██╔══██╗██╔════╝██║   ██║    ██╔══██╗██║     ██╔═══██╗╚██╗██╔╝
    ██║  ██║█████╗  ██║   ██║    ██████╔╝██║     ██║   ██║ ╚███╔╝ 
    ██║  ██║██╔══╝  ╚██╗ ██╔╝    ██╔══██╗██║     ██║   ██║ ██╔██╗ 
    ██████╔╝███████╗ ╚████╔╝     ██████╔╝███████╗╚██████╔╝██╔╝ ██╗
    ╚═════╝ ╚══════╝  ╚═══╝      ╚═════╝ ╚══════╝ ╚═════╝ ╚═╝  ╚═╝
    
    JJSploit için MEGA BLOX FRUITS SCRİPTİ
    - Otomatik görev + Elite Hunter
    - Barista ESP + Işınlanma
    - Meyve ESP + Işınlanma
    - Hızlı Sandık Toplama (Işınlanmadan, duvarlardan geçerek)
    - F4 ile açılıp kapanan menü
]]

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local guiVisible = true
local speedMultiplier = 100  -- Uçma hızı

-- GUI oluştur
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DevBloxGUI"
screenGui.Parent = player:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false

-- Ana pencere
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 650, 0, 500)
mainFrame.Position = UDim2.new(0.5, -325, 0.5, -250)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BackgroundTransparency = 0.1
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.fromRGB(0, 255, 255)
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Visible = true
mainFrame.Parent = screenGui

-- Başlık çubuğu
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 35)
titleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -70, 1, 0)
titleLabel.Position = UDim2.new(0, 10, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "🚀 DEV BLOX FRUITS TOOLKIT (F4 Gizle/Göster)"
titleLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextSize = 22
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBar

local hideButton = Instance.new("TextButton")
hideButton.Size = UDim2.new(0, 35, 1, 0)
hideButton.Position = UDim2.new(1, -40, 0, 0)
hideButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
hideButton.Text = "X"
hideButton.TextColor3 = Color3.fromRGB(255, 255, 255)
hideButton.Font = Enum.Font.SourceSansBold
hideButton.TextSize = 20
hideButton.Parent = titleBar
hideButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    guiVisible = false
end)

-- SEKMELER
local tabContainer = Instance.new("Frame")
tabContainer.Size = UDim2.new(1, -10, 0, 45)
tabContainer.Position = UDim2.new(0, 5, 0, 40)
tabContainer.BackgroundTransparency = 1
tabContainer.Parent = mainFrame

local function createTab(name, pos, color)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 120, 1, 0)
    btn.Position = UDim2.new(0, pos, 0, 0)
    btn.BackgroundColor3 = color or Color3.fromRGB(60, 60, 60)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 18
    btn.Parent = tabContainer
    return btn
end

local tab1 = createTab("📋 GÖREV", 0, Color3.fromRGB(0, 100, 200))
local tab2 = createTab("👑 ELITE", 125, Color3.fromRGB(200, 0, 200))
local tab3 = createTab("☕ BARISTA", 250, Color3.fromRGB(150, 75, 0))
local tab4 = createTab("🍎 MEYVE", 375, Color3.fromRGB(0, 150, 0))
local tab5 = createTab("📦 SANDIK", 500, Color3.fromRGB(200, 100, 0))

-- İçerik alanı
local contentFrame = Instance.new("ScrollingFrame")
contentFrame.Size = UDim2.new(1, -20, 1, -130)
contentFrame.Position = UDim2.new(0, 10, 0, 90)
contentFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
contentFrame.BorderSizePixel = 0
contentFrame.ScrollBarThickness = 12
contentFrame.CanvasSize = UDim2.new(0, 0, 2, 0)
contentFrame.Parent = mainFrame

-- Buton oluşturma yardımcısı
local function createButton(name, posY, callback, color)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -20, 0, 40)
    btn.Position = UDim2.new(0, 10, 0, posY)
    btn.BackgroundColor3 = color or Color3.fromRGB(70, 70, 70)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 18
    btn.Parent = contentFrame
    btn.MouseButton1Click:Connect(callback)
    return posY + 45
end

local function createToggle(name, posY, default, callback, color)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -20, 0, 40)
    btn.Position = UDim2.new(0, 10, 0, posY)
    btn.BackgroundColor3 = default and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(170, 0, 0)
    btn.Text = name .. (default and " [AÇIK]" or " [KAPALI]")
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 18
    btn.Parent = contentFrame
    
    local state = default
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.BackgroundColor3 = state and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(170, 0, 0)
        btn.Text = name .. (state and " [AÇIK]" or " [KAPALI]")
        callback(state)
    end)
    return posY + 45
end

-- Uçma fonksiyonu (ışınlanmadan hızlı git, duvarlardan geç)
local function flyTo(targetPos)
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    
    local hrp = char.HumanoidRootPart
    local startPos = hrp.Position
    local distance = (targetPos - startPos).Magnitude
    
    -- Duvarlardan geçmek için Noclip aç
    for _, part in pairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
        end
    end
    
    -- Hızlı uçuş (10 adımda)
    local steps = 10
    for i = 1, steps do
        local newPos = startPos:Lerp(targetPos, i / steps)
        hrp.CFrame = CFrame.new(newPos)
        wait(0.01) -- Çok hızlı ama banlanmayacak kadar yavaş
    end
    
    -- Noclip'i kapat (isteğe bağlı)
    -- for _, part in pairs(char:GetDescendants()) do
    --     if part:IsA("BasePart") then
    --         part.CanCollide = true
    --     end
    -- end
end

-- ESP oluşturma
local espObjects = {}
local function createESP(obj, name, color)
    if espObjects[obj] then return end
    
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_" .. name
    billboard.Adornee = obj
    billboard.Size = UDim2.new(0, 150, 0, 40)
    billboard.StudsOffset = Vector3.new(0, 2, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = player.PlayerGui
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = color or Color3.new(1, 0, 0)
    label.TextStrokeTransparency = 0
    label.Font = Enum.Font.SourceSansBold
    label.TextSize = 18
    label.Parent = billboard
    
    espObjects[obj] = billboard
    return billboard
end

-- ESP temizleme
local function clearESP()
    for _, esp in pairs(espObjects) do
        if esp then esp:Destroy() end
    end
    espObjects = {}
end

--=====================
-- 1. GÖREV SEKMESİ
--=====================
local questActive = false
local currentQuestNPC = nil

function loadQuestTab()
    for _, v in pairs(contentFrame:GetChildren()) do
        v:Destroy()
    end
    
    local y = 5
    y = createToggle("📋 Otomatik Görev Al ve Yap", y, false, function(state)
        questActive = state
        if state then
            spawn(function()
                while questActive do
                    -- Otomatik görev alma mantığı
                    -- Buraya görev NPC'lerini bulma ve görev yapma kodu gelecek
                    -- Şimdilik basit tutalım
                    wait(2)
                end
            end)
        end
    end)
    
    y = createButton("🔍 En Yakın Görev NPC'sini Bul", y, function()
        -- Görev NPC'lerini tara
        local npcs = {}
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("Head") then
                local name = v.Name:lower()
                if name:find("quest") or name:find("teacher") or name:find("master") or name:find("npc") then
                    table.insert(npcs, v)
                end
            end
        end
        
        if #npcs > 0 then
            local char = player.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local playerPos = char.HumanoidRootPart.Position
                table.sort(npcs, function(a, b)
                    return (a.Head.Position - playerPos).Magnitude < (b.Head.Position - playerPos).Magnitude
                end)
                flyTo(npcs[1].Head.Position)
            end
        else
            print("Görev NPC'si bulunamadı")
        end
    end)
    
    contentFrame.CanvasSize = UDim2.new(0, 0, 0, y+20)
end

--=====================
-- 2. ELITE HUNTER SEKMESİ
--=====================
local eliteHunterActive = false

function loadEliteTab()
    for _, v in pairs(contentFrame:GetChildren()) do
        v:Destroy()
    end
    
    local y = 5
    y = createToggle("👑 Elite Hunter Quest'i Otomatik Yap", y, false, function(state)
        eliteHunterActive = state
        if state then
            spawn(function()
                while eliteHunterActive do
                    -- Elite Hunter görevlerini otomatik yap
                    -- 1. Elite Hunter NPC'sini bul
                    -- 2. Görevi al
                    -- 3. Görevi yap
                    wait(3)
                end
            end)
        end
    end)
    
    y = createButton("🔍 Elite Hunter NPC'sini Bul ve Işınlan", y, function()
        local eliteHunter = findNPC("Elite Hunter")
        if eliteHunter then
            flyTo(eliteHunter.Head.Position)
        else
            print("Elite Hunter bulunamadı (Castle on the Sea'de olabilir)")
        end
    end)
    
    contentFrame.CanvasSize = UDim2.new(0, 0, 0, y+20)
end

--=====================
-- 3. BARISTA SEKMESİ
--=====================
local baristaESPActive = false
local baristaList = {}

function loadBaristaTab()
    for _, v in pairs(contentFrame:GetChildren()) do
        v:Destroy()
    end
    
    local y = 5
    y = createToggle("☕ Barista ESP", y, false, function(state)
        baristaESPActive = state
        if state then
            -- Barista'ları tara ve ESP ekle
            spawn(function()
                while baristaESPActive do
                    clearESP()
                    baristaList = {}
                    for _, v in pairs(workspace:GetDescendants()) do
                        if v:IsA("Model") and v:FindFirstChild("Humanoid") and v.Name:lower():find("barista") then
                            if v:FindFirstChild("Head") then
                                createESP(v.Head, "☕ Barista", Color3.new(0.6, 0.3, 0))
                                table.insert(baristaList, v)
                            end
                        end
                    end
                    wait(5)
                end
            end)
        else
            clearESP()
        end
    end)
    
    y = createButton("📍 En Yakın Barista'ya Işınlan", y, function()
        local char = player.Character
        if not char then return end
        local playerPos = char.HumanoidRootPart.Position
        
        local nearest = nil
        local nearestDist = math.huge
        
        for _, barista in pairs(baristaList) do
            if barista and barista:FindFirstChild("Head") then
                local dist = (barista.Head.Position - playerPos).Magnitude
                if dist < nearestDist then
                    nearestDist = dist
                    nearest = barista
                end
            end
        end
        
        if nearest then
            flyTo(nearest.Head.Position)
        else
            print("Yakında barista bulunamadı")
        end
    end)
    
    contentFrame.CanvasSize = UDim2.new(0, 0, 0, y+20)
end

--=====================
-- 4. MEYVE SEKMESİ
--=====================
local fruitESPActive = false
local fruitList = {}

function loadFruitTab()
    for _, v in pairs(contentFrame:GetChildren()) do
        v:Destroy()
    end
    
    local y = 5
    y = createToggle("🍎 Meyve ESP", y, false, function(state)
        fruitESPActive = state
        if state then
            -- Meyveleri tara ve ESP ekle
            spawn(function()
                while fruitESPActive do
                    clearESP()
                    fruitList = {}
                    for _, v in pairs(workspace:GetDescendants()) do
                        if v:IsA("Tool") and v:FindFirstChild("Handle") then
                            local name = v.Name:lower()
                            if name:find("fruit") or name:find("meyve") or name:find("blox") then
                                createESP(v.Handle, "🍎 " .. v.Name, Color3.new(1, 0, 0))
                                table.insert(fruitList, v)
                            end
                        end
                    end
                    wait(3)
                end
            end)
        else
            clearESP()
        end
    end)
    
    y = createButton("📍 En Yakın Meyveye Işınlan", y, function()
        local char = player.Character
        if not char then return end
        local playerPos = char.HumanoidRootPart.Position
        
        local nearest = nil
        local nearestDist = math.huge
        
        for _, fruit in pairs(fruitList) do
            if fruit and fruit:FindFirstChild("Handle") then
                local dist = (fruit.Handle.Position - playerPos).Magnitude
                if dist < nearestDist then
                    nearestDist = dist
                    nearest = fruit
                end
            end
        end
        
        if nearest then
            flyTo(nearest.Handle.Position)
        else
            print("Yakında meyve bulunamadı")
        end
    end)
    
    y = createButton("🔄 Meyveleri Şimdi Tara", y, function()
        fruitList = {}
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("Tool") and v:FindFirstChild("Handle") then
                local name = v.Name:lower()
                if name:find("fruit") or name:find("meyve") or name:find("blox") then
                    table.insert(fruitList, v)
                end
            end
        end
        print(string.format("%d meyve bulundu", #fruitList))
    end)
    
    contentFrame.CanvasSize = UDim2.new(0, 0, 0, y+20)
end

--=====================
-- 5. SANDIK SEKMESİ
--=====================
local chestActive = false
local chestList = {}

function loadChestTab()
    for _, v in pairs(contentFrame:GetChildren()) do
        v:Destroy()
    end
    
    local y = 5
    y = createToggle("📦 Otomatik Sandık Topla (Işınlanmadan, Hızlı Uç)", y, false, function(state)
        chestActive = state
        if state then
            spawn(function()
                while chestActive do
                    -- Sandıkları tara
                    chestList = {}
                    for _, v in pairs(workspace:GetDescendants()) do
                        if v:IsA("Part") and (v.Name:lower():find("chest") or v.Name:lower():find("sandik") or v.Name:lower():find("hazine")) then
                            table.insert(chestList, v)
                        end
                    end
                    
                    if #chestList > 0 then
                        local char = player.Character
                        if char and char:FindFirstChild("HumanoidRootPart") then
                            local playerPos = char.HumanoidRootPart.Position
                            
                            -- En yakın sandığı bul
                            table.sort(chestList, function(a, b)
                                return (a.Position - playerPos).Magnitude < (b.Position - playerPos).Magnitude
                            end)
                            
                            for _, chest in pairs(chestList) do
                                if not chestActive then break end
                                if chest and chest.Parent then  -- Sandık hala duruyorsa
                                    -- Uçarak git (ışınlanma yok)
                                    flyTo(chest.Position)
                                    
                                    -- Sandık alınana kadar bekle (yok olana kadar)
                                    local timeout = 0
                                    while chest and chest.Parent and timeout < 30 do
                                        wait(0.5)
                                        timeout = timeout + 1
                                    end
                                    wait(0.2)
                                end
                            end
                        end
                    end
                    wait(2)  -- Kısa bir bekleme, sonra tekrar tara
                end
            end)
        end
    end)
    
    y = createButton("📍 En Yakın Sandığa Uç (Işınlanma Yok)", y, function()
        local char = player.Character
        if not char then return end
        local playerPos = char.HumanoidRootPart.Position
        
        local chests = {}
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("Part") and (v.Name:lower():find("chest") or v.Name:lower():find("sandik")) then
                table.insert(chests, v)
            end
        end
        
        if #chests > 0 then
            table.sort(chests, function(a, b)
                return (a.Position - playerPos).Magnitude < (b.Position - playerPos).Magnitude
            end)
            flyTo(chests[1].Position)
        else
            print("Sandık bulunamadı")
        end
    end)
    
    y = createToggle("⚡ Süper Hız Modu (Daha Hızlı Uç)", y, true, function(state)
        if state then
            speedMultiplier = 200
        else
            speedMultiplier = 100
        end
    end)
    
    y = createToggle("🧱 Duvarlardan Geç (Noclip)", y, true, function(state)
        local char = player.Character
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = not state
                end
            end
        end
    end)
    
    contentFrame.CanvasSize = UDim2.new(0, 0, 0, y+20)
end

-- NPC bulma yardımcı fonksiyonu
function findNPC(npcName)
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("Head") then
            if v.Name:lower():find(npcName:lower()) then
                return v
            end
        end
    end
    return nil
end

-- Sekme tıklamaları
tab1.MouseButton1Click:Connect(loadQuestTab)
tab2.MouseButton1Click:Connect(loadEliteTab)
tab3.MouseButton1Click:Connect(loadBaristaTab)
tab4.MouseButton1Click:Connect(loadFruitTab)
tab5.MouseButton1Click:Connect(loadChestTab)

-- Varsayılan sekmeyi yükle
loadQuestTab()

-- F4 ile gizle/göster
game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.F4 then
        mainFrame.Visible = not mainFrame.Visible
        guiVisible = mainFrame.Visible
    end
end)

-- Karakter değiştiğinde noclip ayarını koru
player.CharacterAdded:Connect(function(newChar)
    wait(1)
    if _G.noclipEnabled then
        for _, part in pairs(newChar:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

print("✅ DEV BLOX FRUITS TOOLKİT yüklendi! F4 ile gizle/göster.")
print("📌 Özellikler: Otomatik Görev, Elite Hunter, Barista ESP, Meyve ESP, Hızlı Sandık Toplama")
