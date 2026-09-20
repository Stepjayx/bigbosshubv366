--==================================================
-- BIGBOSS HUB PV3
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
gui.Parent = player:WaitForChild("PlayerGui")

--==================================================
-- MAIN WINDOW
--==================================================

local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.fromOffset(750, 570)
main.Position = UDim2.new(0.5, -375, 0.5, -285)
main.BackgroundColor3 = BLACK
main.BorderSizePixel = 0
main.Parent = gui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 10)
mainCorner.Parent = main

local uiScale = Instance.new("UIScale")
uiScale.Scale = 0.60
uiScale.Parent = main

--==================================================
-- HEADER
--==================================================

local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 72)
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
owner.Size = UDim2.new(1, -80, 0, 20)
owner.Position = UDim2.fromOffset(18, 42)
owner.BackgroundTransparency = 1
owner.Text = "OWNER: CHRISTIAN LUDRIPAS  •  STRICTLY NOT FOR SALE"
owner.TextColor3 = WHITE
owner.TextSize = 11
owner.Font = Enum.Font.GothamBold
owner.TextXAlignment = Enum.TextXAlignment.Left
owner.Parent = header

--==================================================
-- CLOSE BUTTON
--==================================================

local close = Instance.new("TextButton")
close.Size = UDim2.fromOffset(40, 40)
close.Position = UDim2.new(1, -50, 0, 16)
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
    gui:Destroy()
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
content.Size = UDim2.new(1, -30, 1, -82)
content.Position = UDim2.fromOffset(15, 77)
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

    { name = "Night Hub",              url = "https://raw.githubusercontent.com/WhiteX1208/Scripts/refs/heads/main/StealAnEggs.luau" },
    { name = "CloverHub",              url = "https://cloverhub.app/clover.lua" },
    { name = "Ajans Hub",              url = "https://api.luarmor.net/files/v4/loaders/359e97f8618e9008afe5f496184ebb7c.lua" },
    { name = "Potato Hub",             url = "https://raw.githubusercontent.com/potatohub67/potatoscripts/refs/heads/main/stealegg.lua" },
    { name = "Spiritual Gaming Hub",   url = "https://gist.githubusercontent.com/spiritualgaming1123-beep/f2c8c4009b2c4d4dda1b305fbc263e3f/raw/121ff8c9059476a7a362b543edc61499e5832937/gistfile1.lua" },
    { name = "Ouroboros Hub",          url = "https://raw.githubusercontent.com/joustingmatch/Ouroboros/main/loader.lua" },
    { name = "Decode Hub",             url = "https://raw.githubusercontent.com/ItzYumi/Decode/refs/heads/main/DEK3ACODE.lua" },
    { name = "Fyy Community",          url = "https://FyyCommunity.my.id" },
    { name = "Foxname",                url = "https://raw.githubusercontent.com/caomod2077/Script/refs/heads/main/Fn-stealanegg.lua" },
    { name = "Zerion Hub",             url = "https://zerionhub.com/api/script" },
    { name = "Sena Hub",               url = "https://raw.githubusercontent.com/senarblx/sena/refs/heads/main/senav3go" },
    { name = "BlyxoHub",               url = "https://flowauth.net/v1/loaders/69d3463240384f3a73fbe32c178093a2.lua" },
    { name = "UB Hub",                 url = "https://raw.githubusercontent.com/TeamUBHub/UBLoader/refs/heads/main/Loader.lua" },
    { name = "Rene Baterbonia",        url = "https://raw.githubusercontent.com/JuaINasiRendang/loader/refs/heads/main/main.lua" },
    { name = "Toolbox Hub",            url = "https://raw.githubusercontent.com/Abdullahking20/loader_lua/main/loader" },
    { name = "Glint Hub",              url = "https://flowauth.net/v1/loaders/6824c37a4078d7d311677732e231edaa.lua" },
    { name = "ONhub",                  url = "https://raw.githubusercontent.com/davizin713/ONhub/refs/heads/main/script.lua" },
    { name = "BK Hub",                 url = "https://api.luarmor.net/files/v4/loaders/9ee4edde227ac85f50872bf9e4226508.lua" },
    { name = "Nexa Hub",               url = "https://raw.githubusercontent.com/VEZZ/NEVAHUB/main/2" },
    { name = "Probost Hub",            url = "https://api.jnkie.com/api/v1/luascripts/public/0199b576f5c2d5a34159f0f9f4e1de0a566b4d1da5b1cfa5d2f71ade9bdcaa24/download" },
    { name = "SoftKillz",              url = "https://pastebin.com/raw/ZuE8Wb5K" },
    { name = "Yuri Hub",               url = "https://raw.githubusercontent.com/iLove-yuri/leeeeebian/refs/heads/main/homumado.lua", pre = function() _G.autoExec = false end },
    { name = "Airflow Hub",            url = "https://airflowscripts.com/loader" },
    { name = "SaiOps Hub",             url = "https://api.saiops.cc/scripts/Steal-An-Egg-Script.lua" },
    { name = "SportsClub Hub",         url = "https://loader.sportsclub.fun/loader.luau" },
    { name = "BigFroot Hub",           url = "https://raw.githubusercontent.com/hanniii/Loader/refs/heads/main/BFLoader.lua" },
    { name = "Chiyo Hub",              url = "https://raw.githubusercontent.com/kaisenlimao/loader/refs/heads/main/chiyo.lua" },
    { name = "Asvra Hub",              url = "https://raw.githubusercontent.com/asvraRoblox/stealegg/refs/heads/main/main" },
    { name = "UlamHUB",                url = "https://api.jnkie.com/api/v1/luascripts/public/4fa5547b587bf3110ad121fd9650a8256ed00c073ae49ecf07d2130a206125/download" },
    { name = "Steal an Egg Mobile Hub",url = "https://rscripts.net/raw/auto-steal-egg-auto-go-back-to-base-auto-place-eggs-and-more_1786067954070_r3UahDdqbt.txt" },
    { name = "Lumin Hub",              url = "http://luminon.top/loader.lua" },
    { name = "Wis Hub",                url = "https://api.wishub.cloud/files/loader.lua" },
    { name = "Open Source Steal an Egg Script", url = "https://rscripts.net/raw/auto-steal-auto-hatch-upgrade-treadmill-auto-sell_1786088210969_Gtt85kSqk1.txt" },
    { name = "Axurs Games Hub",        url = "https://raw.githubusercontent.com/XE3Scripts/Axur-sGamesHub/refs/heads/main/StealAnEgg" },
    { name = "Clout Hub",              url = "https://raw.githubusercontent.com/CloutHubOnTop/Loader/main/main.lua" },
    { name = "Miranda Hub",            url = "https://raw.githubusercontent.com/miirandahub/loader/refs/heads/main/stealegg" },
    { name = "Chilli Hub",             url = "https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua" },
    { name = "Neva Hub",               url = "https://raw.githubusercontent.com/VEZZ/NEVAHUB/main/2" },
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
    label.Size = UDim2.new(1, -105, 1, 0)
    label.Position = UDim2.fromOffset(15, 0)
    label.BackgroundTransparency = 1
    label.Text = data.name
    label.TextColor3 = WHITE
    label.TextSize = 13
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextTruncate = Enum.TextTruncate.AtEnd
    label.Parent = row

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
