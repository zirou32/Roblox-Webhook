local HttpService = game:GetService("HttpService")
local Settings = require(script.Settings)
local Promise = require(script.Promise)

local Webhook = {}
Webhook.__index = Webhook

-- Local functions
local function Callback(fn: () -> ())
	if Settings.webhook_promises then
		return Promise.new(function(resolve, reject)
			local success, result = pcall(fn)
			if success then
				resolve(result)
			end
			reject(result)
		end)
	end
	return pcall(fn)
end

--[[
	Create a new instance of Webhook

	@param webhookUrl	string	the url of the webhook you will use
	@returns Webhook

	```lua
	local myWebhook = Webhook.new("your-webhook-url")
	```
]]
function Webhook.new(webhookUrl: string)
	local self = setmetatable({}, Webhook)
	self.webhook = webhookUrl
	return self
end

--[[
	Send a simple message using your webhook url

	@param message	string	message you wish to send
	@returns promise

	```lua
	local myWebhook = Webhook.new("webhook-url")
	myWebhook:Message("Hello!")
	```
]]
function Webhook:Message(message: string)
	return Callback(function()
		local data = HttpService:JSONEncode({ content = message })
		return HttpService:PostAsync(self.webhook, data)
	end)
end

--[[
	Send an embed message

	@param content	string	The message that will be displayed above the embed
	@param title	string	The embed title
	@param message	string	The embed message
]]
function Webhook:Embed(content: string, title: string, message: string)
	return Callback(function()
		local data = {
			["content"] = content,
			["embeds"] = {
				{ ["title"] = title, ["description"] = message },
			},
		}
		local jsonData = HttpService:JSONEncode(data)
		return HttpService:PostAsync(self.webhook, jsonData)
	end)
end

return Webhook
