local Webhook = require(script.Parent.Parent.Webhook)

local url = "your-webhook-url-here"

local reports = Webhook.new(url)
reports:Message("New report!"):andThen(function()
	print("report received!")
end)
