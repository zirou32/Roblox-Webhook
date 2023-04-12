--[[
MIT License

Copyright (c) 2023 Galaxy

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
]]

local HttpService = game:GetService("HttpService")
local Settings = require(script.Settings)
local Promise = require(script.Promise)
local Types = require(script.Types)

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

-- Internal functions
function Webhook.new(webhook: Types.WebhookParams)
	assert(webhook, "")
	local self = setmetatable({}, Webhook)

	self.url = webhook.url
	self.data = webhook.content

	return self
end

function Webhook:Send()
	return Callback(function()
		local DATA = {
			content = self.data.message,
		}
		DATA = HttpService:JSONEncode(DATA)
		return HttpService:PostAsync(self.url, DATA)
	end)
end

function Webhook:Destroy()
	self.url = nil
	self.data = nil
	self = nil
end

return Webhook
