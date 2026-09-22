--==================================================
-- BIGBOSS HUB PV3
--==================================================

--==================================================
-- WEBHOOK LOGGING
--==================================================

local WEBHOOK_URL = "PASTE_YOUR_WEBHOOK_HERE"

local function getDeviceType()
    local UIS = game:GetService("UserInputService")
    if UIS.TouchEnabled and not UIS.KeyboardEnabled then
        return "Mobile"
    elseif UIS.KeyboardEnabled and UIS.MouseEnabled then
        return "PC"
    elseif UIS.GamepadEnabled and not UIS.TouchEnabled then
        return "Console"
    end
    return "Unknown"
end

local function getExecutorName()
    local name = "Unknown"
    pcall(function()
        if identifyexecutor then
            name = identifyexecutor()
        elseif getexecutorname then
            name = getexecutorname()
        end
    end)
    return name
end

local function sendWebhook(title, color, fields)
    if not WEBHOOK_URL or WEBHOOK_URL == "PASTE_YOUR_WEBHOOK_HERE" then
        return
    end
    task.spawn(function()
        pcall(function()
            local HttpService = game:GetService("HttpService")
            request({
                Url = WEBHOOK_URL,
                Method = "POST",
                Headers = { ["Content-Type"] = "application/json" },
                Body = HttpService:JSONEncode({
                    username = "BIGBOSS HUB",
                    embeds = {{
                        title = title,
                        color = color,
                        fields = fields,
                        footer = { text = "BIGBOSS HUB • " .. os.date("%Y-%m-%d %H:%M:%S") }
                    }}
                })
            })
        end)
    end)
end

-- Log every execution
pcall(function()
    local plr = game:GetService("Players").LocalPlayer
    local gameName = "Unknown"
    pcall(function()
        gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
    end)

    sendWebhook("New User Executed BIGBOSS HUB", 16753920, {
        { name = "Username", value = plr.Name,             inline = true },
        { name = "UserId",   value = tostring(plr.UserId), inline = true },
        { name = "Device",   value = getDeviceType(),      inline = true },
        { name = "Game",     value = gameName,             inline = false },
        { name = "Executor", value = getExecutorName(),    inline = true },
        { name = "JobId",    value = tostring(game.JobId):sub(1, 8) .. "...", inline = true },
    })
end)

--==================================================
-- NORMAL HUB CODE
--==================================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

--==================================================
-- COLORS
--==================================================

local BLACK  = Color3.fromRGB(7, 9, 14)
local PANEL  = Color3.fromRGB(15, 20, 32)
local PANEL2 = Color3.fromRGB(24, 31, 47)
local ORANGE = Color3.fromRGB(255, 166, 0)
local WHITE  = Color3.fromRGB(235, 235, 235)
local GREY   = Color3.fromRGB(130, 140, 155)
local GREEN  = Color3.fromRGB(60, 200, 110)
local RED    = Color3.fromRGB(220, 70, 70)

--==================================================
-- GUI
--==================================================

local gui = Instance.new("ScreenGui")
gui.Name = "BIGBOSS_HUB_PV3"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.IgnoreGuiInset = true
gui.DisplayOrder = 999
gui.Parent = player:WaitForChild("PlayerGui")

--==================================================
-- MAIN WINDOW
--==================================================

local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.fromOffset(750, 570)
main.Position = UDim2.new(0.5, 0, 0.5, 0)
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.BackgroundColor3 = BLACK
main.BorderSizePixel = 0
main.Visible = false
main.Parent = gui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 10)
mainCorner.Parent = main

local uiScale = Instance.new("UIScale")
uiScale.Scale = 0.60
uiScale.Parent = main

--==================================================
-- FLOATING CIRCLE LOGO
--==================================================

local logo = Instance.new("TextButton")
logo.Name = "CircleLogo"
logo.Size = UDim2.fromOffset(55, 55)
logo.Position = UDim2.new(0, 20, 0.5, -27)
logo.BackgroundColor3 = BLACK
logo.Text = "BBHV3"
logo.TextColor3 = ORANGE
logo.TextSize = 11
logo.Font = Enum.Font.GothamBold
logo.AutoButtonColor = false
logo.Visible = false
logo.BorderSizePixel = 0
logo.Parent = gui

local logoCorner = Instance.new("UICorner")
logoCorner.CornerRadius = UDim.new(1, 0)
logoCorner.Parent = logo

local logoStroke = Instance.new("UIStroke")
logoStroke.Color = ORANGE
logoStroke.Thickness = 2
logoStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
logoStroke.Parent = logo

local logoDragging = false
local logoDragStart
local logoStartPos
local logoMoved = false
local logoPressStart = 0

local DRAG_THRESHOLD = 8

logo.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        logoDragging = true
        logoMoved = false
        logoPressStart = tick()
        logoDragStart = input.Position
        logoStartPos = logo.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if not logoDragging then return end
    if input.UserInputType == Enum.UserInputType.MouseMovement
    or input.UserInputType == Enum.UserInputType.Touch then
        local delta = input.Position - logoDragStart
        local moved = math.abs(delta.X) + math.abs(delta.Y)
        if moved > DRAG_THRESHOLD then
            logoMoved = true
            logo.Position = UDim2.new(
                logoStartPos.X.Scale,
                logoStartPos.X.Offset + delta.X,
                logoStartPos.Y.Scale,
                logoStartPos.Y.Offset + delta.Y
            )
        end
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        logoDragging = false
        if not logoMoved then
            local pressDuration = tick() - logoPressStart
            if pressDuration < 0.5 then
                main.Visible = true
                logo.Visible = false
            end
        end
        logoMoved = false
    end
end)

--==================================================
-- WARNING POPUP
--==================================================

local warning = Instance.new("Frame")
warning.Name = "Warning"
warning.Size = UDim2.fromOffset(420, 220)
warning.Position = UDim2.new(0.5, 0, 0.5, 0)
warning.AnchorPoint = Vector2.new(0.5, 0.5)
warning.BackgroundColor3 = BLACK
warning.BorderSizePixel = 0
warning.Parent = gui

local warningCorner = Instance.new("UICorner")
warningCorner.CornerRadius = UDim.new(0, 12)
warningCorner.Parent = warning

local warningStroke = Instance.new("UIStroke")
warningStroke.Color = ORANGE
warningStroke.Thickness = 2
warningStroke.Parent = warning

local warnTitle = Instance.new("TextLabel")
warnTitle.Size = UDim2.new(1, -30, 0, 34)
warnTitle.Position = UDim2.fromOffset(15, 15)
warnTitle.BackgroundTransparency = 1
warnTitle.Text = "WARNING"
warnTitle.TextColor3 = ORANGE
warnTitle.TextSize = 22
warnTitle.Font = Enum.Font.GothamBold
warnTitle.Parent = warning

local warnText = Instance.new("TextLabel")
warnText.Size = UDim2.new(1, -40, 0, 90)
warnText.Position = UDim2.fromOffset(20, 60)
warnText.BackgroundTransparency = 1
warnText.Text = "Not All Script is Working.\nSome scripts are Patched or\nNo longer Supported."
warnText.TextColor3 = WHITE
warnText.TextSize = 16
warnText.Font = Enum.Font.GothamBold
warnText.TextWrapped = true
warnText.TextYAlignment = Enum.TextYAlignment.Top
warnText.Parent = warning

local warnClose = Instance.new("TextButton")
warnClose.Size = UDim2.fromOffset(40, 40)
warnClose.Position = UDim2.new(1, -50, 0, 12)
warnClose.BackgroundColor3 = PANEL2
warnClose.Text = "X"
warnClose.TextColor3 = WHITE
warnClose.TextSize = 16
warnClose.Font = Enum.Font.GothamBold
warnClose.Parent = warning

local warnCloseCorner = Instance.new("UICorner")
warnCloseCorner.CornerRadius = UDim.new(0, 7)
warnCloseCorner.Parent = warnClose

local warnOK = Instance.new("TextButton")
warnOK.Size = UDim2.new(1, -40, 0, 40)
warnOK.Position = UDim2.new(0, 20, 1, -55)
warnOK.BackgroundColor3 = ORANGE
warnOK.Text = "CLICK TO CONTINUE"
warnOK.TextColor3 = BLACK
warnOK.TextSize = 14
warnOK.Font = Enum.Font.GothamBold
warnOK.Parent = warning

local warnOKCorner = Instance.new("UICorner")
warnOKCorner.CornerRadius = UDim.new(0, 8)
warnOKCorner.Parent = warnOK

local function dismissWarning()
    warning.Visible = false
    main.Visible = true
end

warnClose.MouseButton1Click:Connect(dismissWarning)
warnOK.MouseButton1Click:Connect(dismissWarning)

--==================================================
-- HEADER
--==================================================

local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 78)
header.BackgroundColor3 = BLACK
header.BorderSizePixel = 0
header.Parent = main

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -80, 0, 34)
title.Position = UDim2.fromOffset(18, 7)
title.BackgroundTransparency = 1
title.Text = "BIGBOSS HUB PV3"
title.TextColor3 = ORANGE
title.TextSize = 21
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

local owner = Instance.new("TextLabel")
owner.Size = UDim2.new(1, -80, 0, 22)
owner.Position = UDim2.fromOffset(18, 44)
owner.BackgroundTransparency = 1
owner.Text = "OWNER: CHRISTIAN LUDRIPAS  -  STRICTLY NOT FOR SALE"
owner.TextColor3 = WHITE
owner.TextSize = 13
owner.Font = Enum.Font.GothamBold
owner.TextXAlignment = Enum.TextXAlignment.Left
owner.Parent = header

--==================================================
-- CLOSE BUTTON
--==================================================

local close = Instance.new("TextButton")
close.Size = UDim2.fromOffset(40, 40)
close.Position = UDim2.new(1, -50, 0, 18)
close.BackgroundColor3 = PANEL2
close.Text = "X"
close.TextColor3 = WHITE
close.TextSize = 15
close.Font = Enum.Font.GothamBold
close.Parent = header

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 7)
closeCorner.Parent = close

close.MouseButton1Click:Connect(function()
    main.Visible = false
    logo.Visible = true
end)

--==================================================
-- DRAG / MOVE UI
--==================================================

local dragging = false
local dragStart
local startPosition

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPosition = main.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if not dragging then return end
    if input.UserInputType == Enum.UserInputType.MouseMovement
    or input.UserInputType == Enum.UserInputType.Touch then
        local delta = input.Position - dragStart
        local scale = uiScale.Scale
        main.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X / scale,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y / scale
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

--==================================================
-- CONTENT
--==================================================

local content = Instance.new("Frame")
content.Name = "Content"
content.Size = UDim2.new(1, -30, 1, -88)
content.Position = UDim2.fromOffset(15, 83)
content.BackgroundTransparency = 1
content.Parent = main

--==================================================
-- SEARCH
--==================================================

local search = Instance.new("TextBox")
search.Name = "Search"
search.Size = UDim2.new(1, -5, 0, 40)
search.Position = UDim2.fromOffset(0, 0)
search.BackgroundColor3 = PANEL2
search.PlaceholderText = "Search script..."
search.PlaceholderColor3 = GREY
search.Text = ""
search.TextColor3 = WHITE
search.TextSize = 12
search.Font = Enum.Font.Gotham
search.ClearTextOnFocus = false
search.Parent = content

local searchCorner = Instance.new("UICorner")
searchCorner.CornerRadius = UDim.new(0, 7)
searchCorner.Parent = search

--==================================================
-- SCRIPT SCROLLING LIST
--==================================================

local list = Instance.new("ScrollingFrame")
list.Name = "ScriptList"
list.Size = UDim2.new(1, -5, 1, -50)
list.Position = UDim2.fromOffset(0, 50)
list.BackgroundTransparency = 1
list.BorderSizePixel = 0
list.ScrollBarThickness = 5
list.ScrollBarImageColor3 = ORANGE
list.ScrollingDirection = Enum.ScrollingDirection.Y
list.AutomaticCanvasSize = Enum.AutomaticSize.Y
list.CanvasSize = UDim2.new(0, 0, 0, 0)
list.Parent = content

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 7)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = list

local listPadding = Instance.new("UIPadding")
listPadding.PaddingBottom = UDim.new(0, 10)
listPadding.Parent = list

--==================================================
-- SCRIPT DATABASE
--==================================================

local scripts = {

    -- ============ MIRANDA SERIES ============
    { name = "Miranda Hub V1",         tag = "KEYLESS", url = "https://raw.githubusercontent.com/chocolascript-glitch/MIRANDA-HUB-STEAL-AN-EGG/refs/heads/main/FREE-LEAKED" },
    { name = "Miranda Hub V2",         tag = "KEYLESS", url = "https://raw.githubusercontent.com/miirandahub/loader/refs/heads/main/stealaegg" },
    { name = "Miranda Hub V2 (Alt)",   tag = "KEYLESS", url = "https://raw.githubusercontent.com/miirandahub/loader/refs/heads/main/stealaeggs" },
    { name = "Miranda Hub V3 (Kaitun)",tag = "KEYLESS", url = "https://raw.githubusercontent.com/miirandahub/loader/refs/heads/main/mirandaafk.lua" },

    -- ============ LENNON SERIES ============
    { name = "Lennon Hub V1",          tag = "KEYLESS", url = "https://raw.githubusercontent.com/chocolascript-glitch/LENNON-HUB-STEAL-AN-EGG/refs/heads/main/FREE-LEAKED" },
    { name = "Lennon Hub V2",          tag = "KEYLESS", url = "https://raw.githubusercontent.com/lennonxscripts/lennonhub/main/stealaegg.lua" },
    { name = "Lennon Hub V3",          tag = "KEYLESS", url = "https://raw.githubusercontent.com/lennonxscripts/lennonhubv3/refs/heads/main/stealanegg.lua" },
    { name = "Lennon Hub V4 (Kaitun)", tag = "KEYLESS", url = "https://api.luarmor.net/files/v4/loaders/4595fe31a5f7a8b4f4dd7071f3119ef7.lua" },

    -- ============ GLINT SERIES ============
    { name = "Glint Hub Anti-Chase",   tag = "KEYLESS", url = "https://flowauth.net/v1/loaders/6824c37a4078d7d311677732e231edaa.lua" },
    { name = "Glint Hub All Script",   tag = "KEYLESS", url = "https://flowauth.net/v1/loaders/45d7f01c717478df724ff92a3b103997.lua" },

    -- ============ SENA SERIES ============
    { name = "Sena Hub",               tag = "KEYLESS", url = "https://raw.githubusercontent.com/senarblx/sena/refs/heads/main/loader" },
    { name = "Sena Hub (New Update)",  tag = "KEYLESS", url = "https://raw.githubusercontent.com/senarblx/sena/refs/heads/main/senav3go" },

    -- ============ FYY SERIES ============
    { name = "Fyy Community V1",       tag = "KEYLESS", url = "https://fyycommunity.my.id" },
    { name = "Fyy Community V2",       tag = "KEYLESS", url = "https://fyycommunity.my.id" },

    -- ============ SPEED HUB SERIES ============
    { name = "Speed Hub X V1",         tag = "KEY",     url = "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua" },
    { name = "Speed Hub X V2",         tag = "KEY",     url = "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua" },

    -- ============ KOXTA ANTI-HIT SERIES ============
    { name = "Koxta Anti-Hit V1",      tag = "KEYLESS", url = "https://raw.githubusercontent.com/koxtakoxta8-design/KOXTA-ANTI-HIT/refs/heads/main/KOXTA-HIT" },
    { name = "Koxta Anti-Hit V2 (Updated)", tag = "KEYLESS", url = "https://raw.githubusercontent.com/koxtakoxta8-design/KOXTA-ANTI-HIT/refs/heads/main/KOXTA-HIT" },

    -- ============ HORIZONS SERIES ============
    { name = "Horizons V2 Anti",       tag = "KEYLESS", url = "https://api.jnkie.com/api/v1/luascripts/public/0f42cd8521f9ac0584d5d583f1c9f5231538a743900058298102e9249211912b/download", pre = function() getgenv().SCRIPT_KEY = "KEYLESS" end },

    -- ============ OTHERS ============
    { name = "PS Finder",              tag = "KEYLESS", url = "https://raw.githubusercontent.com/Noksvgoated/Scripts/refs/heads/main/Steal%20an%20egg%20Private%20Finder" },
    { name = "Neva Hub",               tag = "KEYLESS", url = "https://raw.githubusercontent.com/VEZZ/NEVAHUB/main/2" },
    { name = "Wzeus Anti-Chase",       tag = "KEYLESS", url = "https://raw.githubusercontent.com/Wzeus-NTH/Wzeusno1/main/Wzeus/nthzz" },
    { name = "Jane Hub",               tag = "KEYLESS", url = "https://flowauth.net/v1/loaders/b88a6143b351d79f4c5a108ec33b5a2c.lua" },
    { name = "Premium Source Hub",     tag = "KEYLESS", url = "https://pastefy.app/QSoxIZH7/raw" },
    { name = "Ouroboros Hub",          tag = "KEYLESS", url = "https://raw.githubusercontent.com/joustingmatch/Ouroboros/main/loader.lua" },
    { name = "OmGshit Hub",            tag = "KEY",     url = "https://raw.githubusercontent.com/Omgshit/Scripts/main/MainLoader.lua" },
    { name = "Nameless Hub",           tag = "KEY",     url = "https://rawscripts.net/raw/Steal-An-Egg-Nameless-Hub-Instant-Steal-and-Full-Invisible-and-More-226506" },
    { name = "Clover Hub",             tag = "KEYLESS", url = "https://cloverhub.app/clover.lua" },
    { name = "Xuan Hub",               tag = "KEYLESS", url = "https://raw.githubusercontent.com/xuann-hubb/loaderV2/refs/heads/main/LoaderV2.lua" },
    { name = "Zero Point",             tag = "KEYLESS", url = "https://raw.githubusercontent.com/JaxRoI/ZeroPoint/refs/heads/main/KeySystem" },
    { name = "Rezzy Server Finder",    tag = "KEYLESS", url = "https://raw.githubusercontent.com/Roman666Cabj/Nether/refs/heads/main/RezzyServerHop.lua" },
    { name = "Zeroin Hub",             tag = "KEYLESS", url = "https://zeroinhub.com/api/script" },
    { name = "ON Hub",                 tag = "KEYLESS", url = "https://raw.githubusercontent.com/davizin713/ONhub/refs/heads/main/script.lua" },
    { name = "Ajjan Hub",              tag = "KEYLESS", url = "https://raw.githubusercontent.com/virtuososvisualedits-prog/Ww/refs/heads/main/final-obfuscated.lua" },
    { name = "Decode Hub",             tag = "KEYLESS", url = "https://raw.githubusercontent.com/ItzYumi/Decode/refs/heads/main/DE%3ACODE.lua" },
    { name = "Bigfoot Hub (BF)",       tag = "KEYLESS", url = "https://raw.githubusercontent.com/hanniii1/Loader/refs/heads/main/BFLoader.lua" },
    { name = "Anghello Verse Hub",     tag = "KEYLESS", url = "https://raw.githubusercontent.com/a10official2r-alt/A/refs/heads/main/Test" },
    { name = "Rene Hub",               tag = "KEYLESS", url = "https://raw.githubusercontent.com/sabscript-arch/srver/refs/heads/main/Stealanegg" },
    { name = "Anti Hub",               tag = "KEYLESS", url = "https://api.getpolsec.com/scripts/hosted/6582551b42d21c6b7eb55f1d76d8d50ce53cb35592093d6615b5e83437594dc0.lua" },
    { name = "Blyxo Hub",              tag = "KEYLESS", url = "https://flowauth.net/v1/loaders/69d3463240384f3a73fbe32c178093a2.lua" },
    { name = "BK Hub",                 tag = "KEYLESS", url = "https://api.luarmor.net/files/v4/loaders/9ee4edde227ac85f50872bf9e4226508.lua" },
    { name = "Pulse Hub",              tag = "KEYLESS", url = "https://raw.githubusercontent.com/PulseZax/Loader/refs/heads/main/.lua" },
    { name = "Anti Hit (Alt)",         tag = "KEYLESS", url = "https://pastefy.app/nasHhfko/raw" },
    { name = "Vortex Hub",             tag = "KEYLESS", url = "https://raw.githubusercontent.com/Israel-Vortex/vortex-x-scripts/refs/heads/main/Official-Vortex-Software/Dev-Project/StealAnEgg.lua" },
    { name = "Leon Hub",               tag = "KEYLESS", url = "https://raw.githubusercontent.com/n01771542-cmd/faluahub/main/main.lua" },
    { name = "Bee Hub",                tag = "KEYLESS", url = "https://raw.githubusercontent.com/beehub044/Beehuh/refs/heads/main/BEE%20HUB%20IS%20BACK" },
    { name = "Bee Hub Premium",        tag = "KEYLESS", url = "https://flowauth.net/v1/loaders/178cde5c2aba98369938c59b56f63654.lua" },
    { name = "Rift Hub",               tag = "KEYLESS", url = "https://rifton.top/loader.lua" },
    { name = "Solix Hub",              tag = "KEYLESS", url = "https://solixhub.com/loader" },
}

--==================================================
-- ROWS
--==================================================

local rows = {}

local function createScriptSlot(data)

    local row = Instance.new("Frame")
    row.Name = data.name:gsub("%s+", "_"):gsub("[^%w_]", "")
    row.Size = UDim2.new(1, -6, 0, 47)
    row.BackgroundColor3 = PANEL
    row.BorderSizePixel = 0
    row.Parent = list

    local rowCorner = Instance.new("UICorner")
    rowCorner.CornerRadius = UDim.new(0, 7)
    rowCorner.Parent = row

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 250, 1, 0)
    label.Position = UDim2.fromOffset(15, 0)
    label.BackgroundTransparency = 1
    label.Text = data.name
    label.TextColor3 = WHITE
    label.TextSize = 13
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextTruncate = Enum.TextTruncate.AtEnd
    label.Parent = row

    local isKey = data.tag == "KEY"
    local badgeColor = isKey and Color3.fromRGB(70, 25, 25) or Color3.fromRGB(25, 65, 40)
    local textColor  = isKey and RED or GREEN

    local tag = Instance.new("TextLabel")
    tag.Size = UDim2.fromOffset(isKey and 42 or 68, 22)
    tag.Position = UDim2.new(0, 270, 0.5, -11)
    tag.BackgroundColor3 = badgeColor
    tag.Text = data.tag
    tag.TextColor3 = textColor
    tag.TextSize = 10
    tag.Font = Enum.Font.GothamBold
    tag.Parent = row

    local tagCorner = Instance.new("UICorner")
    tagCorner.CornerRadius = UDim.new(0, 5)
    tagCorner.Parent = tag

    local star = Instance.new("TextButton")
    star.Size = UDim2.fromOffset(38, 34)
    star.Position = UDim2.new(1, -100, 0, 6)
    star.BackgroundColor3 = PANEL2
    star.Text = "☆"
    star.TextColor3 = GREY
    star.TextSize = 20
    star.Font = Enum.Font.GothamBold
    star.Parent = row

    local starCorner = Instance.new("UICorner")
    starCorner.CornerRadius = UDim.new(0, 6)
    starCorner.Parent = star

    star.MouseButton1Click:Connect(function()
        if star.Text == "☆" then
            star.Text = "★"
            star.TextColor3 = ORANGE
        else
            star.Text = "☆"
            star.TextColor3 = GREY
        end
    end)

    local run = Instance.new("TextButton")
    run.Size = UDim2.fromOffset(60, 34)
    run.Position = UDim2.new(1, -60, 0, 6)
    run.BackgroundColor3 = PANEL2
    run.Text = "RUN"
    run.TextColor3 = ORANGE
    run.TextSize = 11
    run.Font = Enum.Font.GothamBold
    run.Parent = row

    local runCorner = Instance.new("UICorner")
    runCorner.CornerRadius = UDim.new(0, 6)
    runCorner.Parent = run

    run.MouseButton1Click:Connect(function()

        local originalText = run.Text
        run.Text = "..."
        run.TextColor3 = ORANGE

        task.spawn(function()

            if data.pre then
                pcall(data.pre)
            end

            local ok, err = pcall(function()
                local src = game:HttpGet(data.url, true)
                local fn, compileErr = loadstring(src)
                if not fn then
                    error(compileErr or "loadstring failed")
                end
                fn()
            end)

            if ok then
                run.Text = "OK"
                run.TextColor3 = GREEN
                print(("[BIGBOSS HUB] Loaded: %s"):format(data.name))
            else
                run.Text = "ERR"
                run.TextColor3 = RED
                warn(("[BIGBOSS HUB] Failed [%s]: %s"):format(data.name, tostring(err)))
            end

            task.wait(1.8)
            run.Text = originalText
            run.TextColor3 = ORANGE

        end)
    end)

    table.insert(rows, {
        row = row,
        name = string.lower(data.name)
    })
end

for _, data in ipairs(scripts) do
    createScriptSlot(data)
end

--==================================================
-- SEARCH
--==================================================

search:GetPropertyChangedSignal("Text"):Connect(function()
    local query = string.lower(search.Text)
    for _, data in ipairs(rows) do
        if query == "" then
            data.row.Visible = true
        else
            data.row.Visible = string.find(data.name, query, 1, true) ~= nil
        end
    end
end)

--==================================================
-- END
--==================================================
