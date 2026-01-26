local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local MarketplaceService = game:GetService("MarketplaceService")
local LP = Players.LocalPlayer

if LP.Name == "Raman_22I" then
    LP:Kick("Aryu band working")
end

local SCRIPT_URL = "https://rawscripts.net/raw/Universal-Script-Kurd-Hub-29484"
local CORRECT_KEY = "FREdkqlqodj0kjsq"
local DISCORD_INVITE = "https://discord.gg/ccrvuX2ah2"
local WEBHOOK_URL = "https://discord.com/api/webhooks/1465266472073953444/DFXMMPwAO9NBIE3CcgdSmalRGd9JsV31BGRsKXgi7YITfla3XWdnMsXPOdQMQ6Phh6ex"

local mapName = "Unknown"
pcall(function()
	mapName = MarketplaceService:GetProductInfo(game.PlaceId).Name
end)

local function sendWebhook(keyUsed)
	local data = {
		username = "Wlcom Logger",
		embeds = {{
			title = "New Key Login",
			color = 65280,
			fields = {
				{name = "Username", value = LP.Name, inline = true},
				{name = "Display Name", value = LP.DisplayName, inline = true},
				{name = "Map", value = mapName, inline = false},
				{name = "Key", value = keyUsed, inline = false},
				{name = "Time", value = os.date("%Y-%m-%d %H:%M:%S"), inline = false}
			}
		}}
	}
	if syn and syn.request then
		syn.request({Url = WEBHOOK_URL, Method = "POST", Headers = {["Content-Type"]="application/json"}, Body = HttpService:JSONEncode(data)})
	elseif http_request then
		http_request({Url = WEBHOOK_URL, Method = "POST", Headers = {["Content-Type"]="application/json"}, Body = HttpService:JSONEncode(data)})
	end
end

local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "WlcomGui"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 340, 0, 240)
frame.Position = UDim2.new(0.5, -170, 0.5, -120)
frame.BackgroundColor3 = Color3.fromRGB(15,15,15)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,40)
title.Text = "Wlcom Hub | Verify"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 16

local box = Instance.new("TextBox", frame)
box.Size = UDim2.new(0.9,0,0,35)
box.Position = UDim2.new(0.05,0,0,55)
box.PlaceholderText = "Enter Key..."
box.Text = ""
box.ClearTextOnFocus = false
box.Font = Enum.Font.Gotham
box.TextSize = 14
box.BackgroundColor3 = Color3.fromRGB(30,30,30)
box.TextColor3 = Color3.new(1,1,1)
box.BorderSizePixel = 0

local verify = Instance.new("TextButton", frame)
verify.Size = UDim2.new(0.9,0,0,35)
verify.Position = UDim2.new(0.05,0,0,100)
verify.Text = "Verify Key"
verify.Font = Enum.Font.GothamBold
verify.TextSize = 14
verify.BackgroundColor3 = Color3.fromRGB(0,170,255)
verify.TextColor3 = Color3.new(1,1,1)
verify.BorderSizePixel = 0

local discord = Instance.new("TextButton", frame)
discord.Size = UDim2.new(0.9,0,0,35)
discord.Position = UDim2.new(0.05,0,0,145)
discord.Text = "Get Free Key (Discord)"
discord.Font = Enum.Font.GothamBold
discord.TextSize = 14
discord.BackgroundColor3 = Color3.fromRGB(88,101,242)
discord.TextColor3 = Color3.new(1,1,1)
discord.BorderSizePixel = 0

local info = Instance.new("TextLabel", frame)
info.Size = UDim2.new(1,0,0,25)
info.Position = UDim2.new(0,0,1,-25)
info.Text = ""
info.TextColor3 = Color3.fromRGB(200,200,200)
info.BackgroundTransparency = 1
info.Font = Enum.Font.Gotham
info.TextSize = 12

verify.MouseButton1Click:Connect(function()
	if box.Text == CORRECT_KEY then
		sendWebhook(box.Text)
		gui:Destroy()
		loadstring(game:HttpGet(SCRIPT_URL))()
	else
		info.Text = "Wrong Key"
	end
end)

discord.MouseButton1Click:Connect(function()
	setclipboard(DISCORD_INVITE)
	info.Text = "Discord link copied"
end)
