local Webhook = require(script.Parent.Parent.Webhook)

local url = "your-webhook-url"

local reports = Webhook.new(url)
reports:Embed("@everyone", "New report", "bla bla bla"):andThen(function()
	print("Yay, embed")
end)
