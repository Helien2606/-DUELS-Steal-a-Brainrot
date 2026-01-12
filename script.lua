-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

local LP = Players.LocalPlayer

-- SETTINGS
local correctKey = "FRE1dyes kdbaa$A"
local discordLink = "https://discord.gg/A8Bpcrxx7P"
local WEBHOOK_URL = "https://discord.com/api/webhooks/1460148937452425370/ZkGJUrhfkaNHgs512LKdUmXHwIFinWdU75Eqg25pwDpXNnIEfdLG-s3ayFHcJOBdtcjH"

local jumpEnabled = false
local espEnabled = false
local scaleEnabled = false
local JUMP_POWER = 20
local SCALE_SIZE = 50

-- GUI
local gui = Instance.new("ScreenGui", LP:WaitForChild("PlayerGui"))
gui.ResetOnSpawn = false

-- KEY MENU
local keyFrame = Instance.new("Frame", gui)
keyFrame.Size = UDim2.new(0,360,0,180)
keyFrame.Position = UDim2.new(0.5,-180,0.5,-90)
keyFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
keyFrame.Active = true
keyFrame.Draggable = true
Instance.new("UICorner", keyFrame).CornerRadius = UDim.new(0,12)

local keyTitle = Instance.new("TextLabel", keyFrame)
keyTitle.Size = UDim2.new(1,0,0,40)
keyTitle.BackgroundTransparency = 1
keyTitle.Text = "VALCON KEY SYSTEM"
keyTitle.TextColor3 = Color3.new(1,1,1)
keyTitle.Font = Enum.Font.GothamBold
keyTitle.TextSize = 18

local keyBox = Instance.new("TextBox", keyFrame)
keyBox.Size = UDim2.new(0.85,0,0,40)
keyBox.Position = UDim2.new(0.075,0,0.35,0)
keyBox.PlaceholderText = "Enter Key"
keyBox.Text = ""
keyBox.ClearTextOnFocus = false
keyBox.TextColor3 = Color3.new(1,1,1)
keyBox.BackgroundColor3 = Color3.fromRGB(45,45,45)
Instance.new("UICorner", keyBox).CornerRadius = UDim.new(0,8)

local submitBtn = Instance.new("TextButton", keyFrame)
submitBtn.Size = UDim2.new(0.4,0,0,40)
submitBtn.Position = UDim2.new(0.08,0,0.7,0)
submitBtn.Text = "Submit"
submitBtn.TextColor3 = Color3.new(1,1,1)
submitBtn.BackgroundColor3 = Color3.fromRGB(60,120,60)
Instance.new("UICorner", submitBtn).CornerRadius = UDim.new(0,8)

local getKeyBtn = Instance.new("TextButton", keyFrame)
getKeyBtn.Size = UDim2.new(0.4,0,0,40)
getKeyBtn.Position = UDim2.new(0.52,0,0.7,0)
getKeyBtn.Text = "Get Key"
getKeyBtn.TextColor3 = Color3.new(1,1,1)
getKeyBtn.BackgroundColor3 = Color3.fromRGB(90,60,150)
Instance.new("UICorner", getKeyBtn).CornerRadius = UDim.new(0,8)

-- MAIN MENU
local menu = Instance.new("Frame", gui)
menu.Size = UDim2.new(0,320,0,420)
menu.Position = UDim2.new(0.7,0,0.25,0)
menu.BackgroundColor3 = Color3.fromRGB(20,20,20)
menu.Visible = false
menu.Active = true
menu.Draggable = true
Instance.new("UICorner", menu).CornerRadius = UDim.new(0,12)

local title = Instance.new("TextLabel", menu)
title.Size = UDim2.new(1,0,0,50)
title.BackgroundTransparency = 1
title.Text = "mnu VALCON"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 22

local function makeBtn(text,y)
    local b = Instance.new("TextButton", menu)
    b.Size = UDim2.new(0.85,0,0,50)
    b.Position = UDim2.new(0.075,0,y,0)
    b.Text = text
    b.TextScaled = true
    b.BackgroundColor3 = Color3.fromRGB(45,45,45)
    b.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,10)
    return b
end

local jumpBtn = makeBtn("Jump : OFF",0.15)
local espBtn = makeBtn("ESP : OFF",0.32)
local scaleBtn = makeBtn("Scale Players : OFF",0.49)

-- BUTTON ACTIONS
getKeyBtn.MouseButton1Click:Connect(function()
    setclipboard(discordLink)
    keyBox.PlaceholderText = "Discord link copied!"
end)

-- FUNCTION TO SEND WEBHOOK WITH CUSTOM CONTENT
local function SendWebhook(key)
    pcall(function()
        local content = "✅ **Key Used**\n" ..
            "👤 Player: **"..LP.Name.."**\n" ..
            "🆔 UserId: **"..LP.UserId.."**\n" ..
            "🎮 Game: **"..game.PlaceId.."**\n" ..
            "🕒 Time: **"..os.date("%Y-%m-%d | %H:%M:%S").."**\n" ..
            "🔑 Key: ```"..key.."```"

        request({
            Url = WEBHOOK_URL,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = HttpService:JSONEncode({content = content})
        })
    end)
end

submitBtn.MouseButton1Click:Connect(function()
    if keyBox.Text == correctKey then
        keyFrame.Visible = false
        menu.Visible = true
        SendWebhook(keyBox.Text)
    end
end)

jumpBtn.MouseButton1Click:Connect(function()
    jumpEnabled = not jumpEnabled
    jumpBtn.Text = jumpEnabled and "Jump : ON" or "Jump : OFF"
end)

espBtn.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    espBtn.Text = espEnabled and "ESP : ON" or "ESP : OFF"
end)

scaleBtn.MouseButton1Click:Connect(function()
    scaleEnabled = not scaleEnabled
    scaleBtn.Text = scaleEnabled and "Scale Players : ON" or "Scale Players : OFF"
end)

-- ESP SYSTEM WITHOUT LOCALPLAYER
local ESPs = {}
local function addESP(plr)
    if plr == LP then return end -- LocalPlayer لا يظهر
    local function onCharacter(char)
        local hrp = char:WaitForChild("HumanoidRootPart",5)
        if not hrp then return end
        local bb = Instance.new("BillboardGui")
        bb.Adornee = hrp
        bb.Size = UDim2.new(0,200,0,50)
        bb.StudsOffset = Vector3.new(0,3,0)
        bb.AlwaysOnTop = true
        local t = Instance.new("TextLabel", bb)
        t.Size = UDim2.new(1,0,1,0)
        t.BackgroundTransparency = 1
        t.TextColor3 = Color3.new(1,1,1)
        t.TextScaled = true
        t.Text = plr.Name
        bb.Parent = workspace
        ESPs[plr] = bb
    end
    if plr.Character then onCharacter(plr.Character) end
    plr.CharacterAdded:Connect(onCharacter)
end

for _,p in pairs(Players:GetPlayers()) do addESP(p) end
Players.PlayerAdded:Connect(addESP)

-- MAIN LOOP
RunService.RenderStepped:Connect(function()
    if LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = LP.Character.HumanoidRootPart
        if jumpEnabled then
            if hrp.Velocity.Y <= 0.1 then
                hrp.Velocity = Vector3.new(hrp.Velocity.X,JUMP_POWER,hrp.Velocity.Z)
            end
        end
    end

    if scaleEnabled then
        for _,p in pairs(Players:GetPlayers()) do
            if p.Character then
                local h = p.Character:FindFirstChildOfClass("Humanoid")
                if h then pcall(function() h:Resize(SCALE_SIZE) end) end
            end
        end
    end

    for p, bb in pairs(ESPs) do
        if espEnabled and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = p.Character.HumanoidRootPart
            local d = (LP.Character.HumanoidRootPart.Position - hrp.Position).Magnitude
            bb.TextLabel.Text = p.Name.." | "..math.floor(d).."m"
            bb.Enabled = true
        else
            bb.Enabled = false
        end
    end
end)
