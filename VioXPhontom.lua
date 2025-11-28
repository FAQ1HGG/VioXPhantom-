--[[
    VioX Phantom Hub  •  v1.0
-- AUTO-SAVE CONFIG SYSTEM -----------------------------------------------------
local HttpService = game:GetService("HttpService")
local SaveFile = "fishit_config.json"
local Config = {}

local function LoadConfig()
    if isfile(SaveFile) then
        local data = readfile(SaveFile)
        Config = HttpService:JSONDecode(data)
    else
        Config = {}
    end
end

local function SaveConfig()
    writefile(SaveFile, HttpService:JSONEncode(Config))
end

LoadConfig()

-------------------------------------------------------------------------------
-- PURPLE UI LIBRARY (smoothed & lightweight) --------------------------------
-------------------------------------------------------------------------------
local Library = {}
Library.Theme = {
    Main = Color3.fromRGB(120, 0, 255),
    Secondary = Color3.fromRGB(80, 0, 170),
    Text = Color3.fromRGB(255, 255, 255)
}

function Library:CreateWindow(title)
    local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
    ScreenGui.Name = title
    
    local Main = Instance.new("Frame", ScreenGui)
    Main.Size = UDim2.new(0, 500, 0, 350)
    Main.Position = UDim2.new(0.5, -250, 0.5, -175)
    Main.BackgroundColor3 = self.Theme.Main
    Main.Active = true
    Main.Draggable = true
    Main.BorderSizePixel = 0
    Main.Name = "MainWindow"
    
    local UIStroke = Instance.new("UIStroke", Main)
    UIStroke.Thickness = 2
    UIStroke.Color = Color3.fromRGB(255, 255, 255)

    local TitleLabel = Instance.new("TextLabel", Main)
    TitleLabel.Size = UDim2.new(1, 0, 0, 40)
    TitleLabel.Text = title
    TitleLabel.TextColor3 = self.Theme.Text
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextSize = 22

    local Tabs = Instance.new("Frame", Main)
    Tabs.Size = UDim2.new(0, 120, 1, -40)
    Tabs.Position = UDim2.new(0, 0, 0, 40)
    Tabs.BackgroundColor3 = self.Theme.Secondary
    Tabs.BorderSizePixel = 0

    local TabButtons = Instance.new("UIListLayout", Tabs)
    TabButtons.Padding = UDim.new(0, 5)
    TabButtons.SortOrder = Enum.SortOrder.LayoutOrder

    local Pages = Instance.new("Frame", Main)
    Pages.Size = UDim2.new(1, -120, 1, -40)
    Pages.Position = UDim2.new(0, 120, 0, 40)
    Pages.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Pages.BorderSizePixel = 0

    local PageFolder = Instance.new("Folder", Pages)
    PageFolder.Name = "Pages"

    local Window = {}
    Window.PageFolder = PageFolder
    Window.Tabs = Tabs

    function Window:CreateTab(tabname)
        local Button = Instance.new("TextButton", Tabs)
        Button.Size = UDim2.new(1, -10, 0, 35)
        Button.Text = tabname
        Button.BackgroundColor3 = Library.Theme.Main
        Button.TextColor3 = Library.Theme.Text
        Button.Font = Enum.Font.Gotham
        Button.TextSize = 18
        Button.BorderSizePixel = 0

        local Page = Instance.new("ScrollingFrame", PageFolder)
        Page.Size = UDim2.new(1, 0, 1, 0)
        Page.CanvasSize = UDim2.new(0, 0, 3, 0)
        Page.ScrollBarThickness = 4
        Page.BackgroundTransparency = 1
        Page.Visible = false

        local Layout = Instance.new("UIListLayout", Page)
        Layout.SortOrder = Enum.SortOrder.LayoutOrder
        Layout.Padding = UDim.new(0, 10)

        Button.MouseButton1Click:Connect(function()
            for _, p in ipairs(PageFolder:GetChildren()) do
                p.Visible = false
            end
            Page.Visible = true
        end)

        local TabObj = {}
        TabObj.Page = Page

        function TabObj:AddToggle(text, default, callback)
            local Toggle = Instance.new("TextButton", Page)
            Toggle.Size = UDim2.new(1, -10, 0, 35)
            Toggle.Text = text .. " (" .. (default and "ON" or "OFF") .. ")"
            Toggle.BackgroundColor3 = Color3.fromRGB(50, 0, 80)
            Toggle.TextColor3 = Library.Theme.Text
            Toggle.Font = Enum.Font.Gotham
            Toggle.TextSize = 18
            Toggle.BorderSizePixel = 0

            local state = default

            Toggle.MouseButton1Click:Connect(function()
                state = not state
                Toggle.Text = text .. " (" .. (state and "ON" or "OFF") .. ")"
                callback(state)
                SaveConfig()
            end)
        end

        return TabObj
    end

    return Window
end

-------------------------------------------------------------------------------
-- BUILD WINDOW ---------------------------------------------------------------
-------------------------------------------------------------------------------
local Win = Library:CreateWindow("Fish It HUB - Purple UI")

-- Example Tabs ----------------------------------------------------------------
local FishingTab = Win:CreateTab("Fishing")
local TeleportTab = Win:CreateTab("Teleport")
local QuestTab = Win:CreateTab("Quest")
local CharacterTab = Win:CreateTab("Character")
local ShopTab = Win:CreateTab("Shop")
local AutoTradeTab = Win:CreateTab("Trade")
local EventTab = Win:CreateTab("Event")
local MiscTab = Win:CreateTab("Misc")
local ServerTab = Win:CreateTab("Server")

-- Example Toggle --------------------------------------------------------------
FishingTab:AddToggle("Auto Fishing (Legit)", Config.AutoFish or false, function(v)
    Config.AutoFish = v
end)

-- More features can be added here similarly using Tab:AddToggle(), AddSlider(), etc.

-------------------------------------------------------------------------------
-- WATERMARK + UI ANIMATION ----------------------------------------------------
local Watermark = Instance.new("TextLabel")
Watermark.Parent = game.CoreGui:FindFirstChild("Fish It HUB - Purple UI") or game.CoreGui
Watermark.Text = "VioX Phantom Hub | FaqihGG"
Watermark.Size = UDim2.new(0,300,0,30)
Watermark.Position = UDim2.new(1,-310,0,10)
Watermark.BackgroundTransparency = 1
Watermark.TextColor3 = Color3.fromRGB(200,120,255)
Watermark.Font = Enum.Font.GothamBold
Watermark.TextSize = 20
Watermark.TextStrokeTransparency = 0.5

-- FADE-IN UI ANIMATION
spawn(function()
    for i = 1, 20 do
        task.wait(0.02)
        for _, gui in pairs((game.CoreGui:FindFirstChild("Fish It HUB - Purple UI") or game.CoreGui):GetDescendants()) do
            if gui:IsA("Frame") or gui:IsA("TextLabel") or gui:IsA("TextButton") then
                pcall(function()
                    gui.BackgroundTransparency = math.clamp(gui.BackgroundTransparency - 0.05, 0, 1)
                    if gui:IsA("TextLabel") or gui:IsA("TextButton") then
                        gui.TextTransparency = math.clamp(gui.TextTransparency - 0.05, 0, 1)
                    end
                end)
            end
        end
    end
end)

---------------------------------------------------------------------
-- LEVEL 3 ANTI-DETECT SYSTEM (Executor Spoof + Trace Block + Hidden Instances)
---------------------------------------------------------------------
local AntiDetect = {}

-- Spoof identity
getgenv().IdentiySpoof = {
    Executor = "VioX Phantom | FaqihGG",
    Version = "v1.0",
    Device = "Shadow-Client"
}

-- Fake executor identity
pcall(function()
    hookfunction(identifyexecutor, function()
        return getgenv().IdentiySpoof.Executor, getgenv().IdentiySpoof.Version
    end)
end)

-- Block suspicious remote calls
local mt = getrawmetatable(game)
setreadonly(mt, false)
local old = mt.__namecall
mt.__namecall = function(self, ...)
    local args = {...}
    local method = getnamecallmethod()
    if (method == "FireServer" or method == "InvokeServer") then
        if tostring(self):lower():match("log") or tostring(self):lower():match("staff") then
            return nil
        end
    end
    return old(self, ...)
end
setreadonly(mt, true)

-- Hide UI Names
spawn(function()
    for _, v in ipairs(game.CoreGui:GetDescendants()) do
        pcall(function()
            v.Name = "SystemCore_" .. math.random(1000, 9999)
        end)
    end
end)

-- Auto-clean exploit traces
spawn(function()
    while task.wait(2) do
        pcall(function()
            for _, obj in ipairs(game.CoreGui:GetChildren()) do
                if obj.Name:lower():match("exploit") or obj.Name:lower():match("cheat") then
                    obj:Destroy()
                end
            end
        end)
    end
end)

---------------------------------------------------------------------
-- AUTO-UPDATE SYSTEM (VioX Phantom Hub)
---------------------------------------------------------------------
local UpdateURL = "https://raw.githubusercontent.com/PhantomVioX/FishItHub/main/version.txt"
local ScriptURL = "https://raw.githubusercontent.com/PhantomVioX/FishItHub/main/script.lua"

spawn(function()
    pcall(function()
        local currentVersion = "1.0"
        local newVersion = game:HttpGet(UpdateURL)
        if newVersion and newVersion ~= currentVersion then
            warn("[VioX Phantom] Update found! Applying...")
            local newScript = game:HttpGet(ScriptURL)
            writefile("VioXPhantom_Update.lua", newScript)
            loadstring(newScript)()
            return
        end
    end)
end)

---------------------------------------------------------------------
-- GRADIENT ULTRA-PURPLE UI EFFECT
---------------------------------------------------------------------
local function ApplyGradient(object)
    local UIGradient = Instance.new("UIGradient", object)
    UIGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(180,0,255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(90,0,160))
    }
    UIGradient.Rotation = 45
end

for _,gui in ipairs((game.CoreGui:FindFirstChild("Fish It HUB - Purple UI") or game.CoreGui):GetDescendants()) do
    if gui:IsA("Frame") then
        pcall(function() ApplyGradient(gui) end)
    end
end
