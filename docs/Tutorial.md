# Tutorial

---

# Introduction

First of all, it is important that you put the ModuleScript inside the `ServerScriptService`, this is done for security and to not give the client easy access to the ModuleScript.

It is also important to know that this ModuleScript uses `Promises`, which makes it asynchronous and allows you to catch possible errors without destroying your entire script. If you don't want to use them, you can set the `webhook_promises` property of `Settings.lua` to false, this way the code will run synchronously!

## Installation

If you are using ROJO in your project, you must download the repository at [Webhook Releases](https://github.com/zirou32/Roblox-Webhook/releases), once you have done it, you will have to find the "Webhook" folder inside `src/server` and put it inside your project

In case you are using Roblox Studio, you can download the `.rbxm` file from [Webhook Releases](https://github.com/zirou32/Roblox-Webhook/releases), you can also get it from the Roblox `Marketplace` with this link: [Webhook - Roblox](https://www.roblox.com/library/13088224276/Webhook)

> :warning: Remember to place ModuleScript inside `ServerScriptService` :warning:

<br><br><br>

# Learning to use Webhook

I recommend creating a Webhook instance for each webhook you have in use in your game, so you can have a better order and avoid having to copy and paste the same link for each function you use.

Since we are talking about instances, let's learn how to create Webhook instances!

## Create Webhook instances

First and most obvious of all, you need to call the module script in your code like this:

```lua linenums="1"
local Webhook = require(game.ServerScriptService.Webhook)
```

Once you do this, you must create an instance like this:

```lua linenums="1"
local reportWebhook = Webhook.new("your-webhook-url")
```

> The `.new` constructor receives 1 parameter -> `webhookUrl: string`: The URL of the webhook you want to use

<br>

## Sending simple messages to your webhook

Congratulations! You have created your first Webhook instance, now it's time to send a message using this instance!

It is important that from now on, you must call the methods using the colon to call each method, here is an example: `Instance:Method(parameters)`

### Sending a simple message to your webhook

To do this, you need to call the `:Message()` method, here is an example of how to use it:

```lua linenums="1"
local reportWebhook = Webhook.new("your-webhook-url")
reportWebhook:Message("@everyone, new report received!"):andThen(function()
    print("report received") -- This will be displayed in the console once the code is successfully executed
end)
```

### Sending a message in Embed

To do this, you need to call the `:Embed()` method, here is an example of how to use it:

```lua linenums="1"
local reportWebhook = Webhook.new("your-webhook-url")
reportWebhook:Embed("@everyone", "New report!", "bla bla bla"):andThen(function()
    print("report received")
end)
```

This method receives 3 parameters, which are as follows:

> content: string, title: string, message: string

**Content**: The message that will be displayed outside the Embed message.

**Title**: Title of the embed message

**Message**: Description of the embed message

<br><br><br>

#### Thank you very much for reading and learning everything seen in this page, I hope you can give it a usefulness, if you find something wrongly written or badly written, I apologize, I will try to fix it as soon as possible!

As the modulescript progresses, I will update this page more and more, so stay tuned!
