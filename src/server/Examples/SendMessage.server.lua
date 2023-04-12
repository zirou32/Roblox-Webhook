local Webhook = require(script.Parent.Parent.Webhook)
local url = ""
local reports = Webhook.new({ url = url, content = { message = "Message from Roblox Studio" } })
reports:Send():andThen(function(data)
	print(data)
end)
