/* Demonstrates using a Discord Webhook to forward chat messages from your game to a Discord text channel.

	Discord's Intro to Webhooks:
		https://support.discordapp.com/hc/en-us/articles/228383668-Intro-to-Webhooks

	Discord's dev docs for webhooks:
		https://discordapp.com/developers/docs/resources/webhook

	* Discord rate-limits webhooks, so messages will fail to send if used too frequently.
		This can be worked around; you can modify HttpPost to get the response which includes
		rate limit info when it occurs. But I won't be doing that here.

		Rate limits doc:
			https://discordapp.com/developers/docs/topics/rate-limits
*/

client
	// I made key_info literally just to grab your member icon URL from the hub.
	var/key_info/key_info

	New()
		key_info = new(key)
		return ..()
