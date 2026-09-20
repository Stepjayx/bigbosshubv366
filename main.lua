-- BIGBOSS HUB PV3
-- UI ONLY

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "BIGBOSS_HUB_PV3"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local BLACK = Color3.fromRGB(7, 9, 14)
local PANEL = Color3.fromRGB(15, 20, 32)
local PANEL2 = Color3.fromRGB(24, 31, 47)
local ORANGE = Color3.fromRGB(255, 166, 0)
local WHITE = Color3.fromRGB(235, 235, 235)
local GREY = Color3.fromRGB(130, 140, 155)

-- MAIN WINDOW
local main = Instance.new("Frame")
main.Size = UDim2.fromOffset(750, 570)
main.Position = UDim2.new(.5, -375, .5, -285)
main.BackgroundColor3 = BLACK
main.BorderSizePixel = 0
main.Parent = gui

Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)

-- SCALE EVERYTHING TO 85%
local uiScale = Instance.new("UIScale")
uiScale.Scale = 0.60
uiScale.Parent = main

-- HEADER
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 72)
header.BackgroundColor3 = BLACK
header.BorderSizePixel = 0
header.Parent = main

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -30, 0, 34)
title.Position = UDim2.fromOffset(18, 7)
title.BackgroundTransparency = 1
title.Text = "BIGBOSS HUB PV3"
title.TextColor3 = ORANGE
title.TextSize = 21
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

local owner = Instance.new("TextLabel")
owner.Size = UDim2.new(1, -30, 0, 20)
owner.Position = UDim2.fromOffset(18, 42)
owner.BackgroundTransparency = 1
owner.Text = "OWNER: CHRISTIAN LUDRIPAS  •  STRICTLY NOT FOR SALE"
owner.TextColor3 = WHITE
owner.TextSize = 11
owner.Font = Enum.Font.GothamBold
owner.TextXAlignment = Enum.TextXAlignment.Left
owner.Parent = header

-- CLOSE
local close = Instance.new("TextButton")
close.Size = UDim2.fromOffset(40, 40)
close.Position = UDim2.new(1, -50, 0, 16)
close.BackgroundColor3 = PANEL2
close.Text = "X"
close.TextColor3 = WHITE
close.TextSize = 15
close.Font = Enum.Font.GothamBold
close.Parent = header

Instance.new("UICorner", close).CornerRadius = UDim.new(0, 7)

close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- SIDEBAR
local side = Instance.new("Frame")
side.Size = UDim2.new(0, 105, 1, -72)
side.Position = UDim2.fromOffset(0, 72)
side.BackgroundColor3 = Color3.fromRGB(9, 12, 19)
side.BorderSizePixel = 0
side.Parent = main

local function tab(text, y, active)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -12, 0, 48)
    b.Position = UDim2.fromOffset(6, y)
    b.BackgroundColor3 = active and ORANGE or PANEL
    b.Text = text
    b.TextColor3 = active and Color3.new(0,0,0) or WHITE
    b.TextSize = 12
    b.Font = Enum.Font.GothamBold
    b.Parent = side

    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 7)
    return b
end

tab("EGG", 10, true)
tab("SCRIPT", 65, false)
tab("PET", 120, false)
tab("MISC", 175, false)

-- CONTENT
local content = Instance.new("Frame")
content.Size = UDim2.new(1, -115, 1, -82)
content.Position = UDim2.fromOffset(110, 77)
content.BackgroundTransparency = 1
content.Parent = main

-- CHANNEL BUTTON
local channel = Instance.new("TextButton")
channel.Size = UDim2.fromOffset(270, 40)
channel.BackgroundColor3 = ORANGE
channel.Text = "LINK SALURAN WA (COPY)"
channel.TextColor3 = Color3.new(0,0,0)
channel.TextSize = 12
channel.Font = Enum.Font.GothamBold
channel.Parent = content

Instance.new("UICorner", channel).CornerRadius = UDim.new(0, 7)

-- CATEGORY BUTTONS
local cats = {"ALL", "KEY", "NO KEY", "RECOMMEND"}

for i, text in ipairs(cats) do
    local b = Instance.new("TextButton")
    b.Size = UDim2.fromOffset(112, 36)
    b.Position = UDim2.fromOffset((i-1)*118, 48)
    b.BackgroundColor3 = i == 1 and ORANGE or PANEL2
    b.Text = text
    b.TextColor3 = i == 1 and Color3.new(0,0,0) or WHITE
    b.TextSize = 11
    b.Font = Enum.Font.GothamBold
    b.Parent = content

    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 7)
end

-- SEARCH
local search = Instance.new("TextBox")
search.Size = UDim2.new(1, -5, 0, 40)
search.Position = UDim2.fromOffset(0, 92)
search.BackgroundColor3 = PANEL2
search.PlaceholderText = "Search script..."
search.PlaceholderColor3 = GREY
search.Text = ""
search.TextColor3 = WHITE
search.TextSize = 12
search.Font = Enum.Font.Gotham
search.Parent = content

Instance.new("UICorner", search).CornerRadius = UDim.new(0, 7)

-- SCRIPT LIST
local list = Instance.new("ScrollingFrame")
list.Size = UDim2.new(1, -5, 1, -140)
list.Position = UDim2.fromOffset(0, 140)
list.BackgroundTransparency = 1
list.BorderSizePixel = 0
list.ScrollBarThickness = 5
list.ScrollBarImageColor3 = ORANGE
list.CanvasSize = UDim2.new()
list.Parent = content

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 7)
layout.Parent = list

local names = {
    "LUCID HUB",
    "FISHY",
    "SCRIPTFARMER",
    "VIVID LUA",
    "BERRI HUB",
    "NOCTRUNHUB",
    "YARHM HUB",
    "MONARCHH",
    "RBX LIFE / DIVINE EGG",
    "TOKINU",
    "NEVA HUB",
    "LEVON HUB",
    "OXIDE HUB",
    "PULSE HUB",
    "AXURS",
    "WIS HUB",
    "SOFTKILLZ",
    "VOIDHUB",
    "LIMBO HUB",
    "HORIZON HUB ANTI HIT",
    "CHILLI HUB",
    "TSUO HUB",
    "LKZ HUB",
    "VSN",
    "BK HUB",
    "SENA V3",
    "TOOLBOX",
    "SPEED BYPASS",
    "PET/EGG SPAWNER",
    "CITRA HUB",
    "VINCI HUB",
    "NIGHT HUB",
    "LUMIN HUB",
    "CIAO HUB",
    "DECODEX",
    "CRZ HUB",
    "FOXNAME",
    "FYY HUB",
    "ZERO POINT HUB",
    "UB HUB",
    "VALINC HUB",
    "OUROBOROS HUB",
    "HOSHI HUB",
    "DUPE EGG + DUPE PET",
    "RONNEI HUB",
    "LENNON V3",
    "MIRANDA HUB V2",
    "PROJECT-MADARA",
    "BLYXO HUB"
}

local rows = {}

for _, name in ipairs(names) do

    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, -6, 0, 47)
    row.BackgroundColor3 = PANEL
    row.BorderSizePixel = 0
    row.Parent = list

    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 7)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -220, 1, 0)
    label.Position = UDim2.fromOffset(15, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = WHITE
    label.TextSize = 13
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = row

    local star = Instance.new("TextButton")
    star.Size = UDim2.fromOffset(38, 34)
    star.Position = UDim2.new(1, -158, 0, 6)
    star.BackgroundColor3 = PANEL2
    star.Text = "☆"
    star.TextColor3 = GREY
    star.TextSize = 20
    star.Parent = row

    Instance.new("UICorner", star).CornerRadius = UDim.new(0, 6)

    local key = Instance.new("TextButton")
    key.Size = UDim2.fromOffset(72, 34)
    key.Position = UDim2.new(1, -113, 0, 6)
    key.BackgroundColor3 = ORANGE
    key.Text = "KEY"
    key.TextColor3 = Color3.new(0,0,0)
    key.TextSize = 11
    key.Font = Enum.Font.GothamBold
    key.Parent = row

    Instance.new("UICorner", key).CornerRadius = UDim.new(0, 6)

    local run = Instance.new("TextButton")
    run.Size = UDim2.fromOffset(60, 34)
    run.Position = UDim2.new(1, -70, 0, 6)
    run.BackgroundColor3 = PANEL2
    run.Text = "RUN"
    run.TextColor3 = ORANGE
    run.TextSize = 11
    run.Font = Enum.Font.GothamBold
    run.Parent = row

    Instance.new("UICorner", run).CornerRadius = UDim.new(0, 6)

    table.insert(rows, {
        row = row,
        name = string.lower(name)
    })
end

local function resize()
    list.CanvasSize = UDim2.fromOffset(
        0,
        layout.AbsoluteContentSize.Y + 8
    )
end

layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(resize)
resize()

-- SEARCH
search:GetPropertyChangedSignal("Text"):Connect(function()

    local q = string.lower(search.Text)

    for _, data in ipairs(rows) do
        data.row.Visible =
            q == "" or
            string.find(data.name, q, 1, true) ~= nil
    end

    task.defer(resize)
end)
