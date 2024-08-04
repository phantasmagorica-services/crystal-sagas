/datum/tgs_chat_command/dev_save
	name = "dev-save"
	help_text = "Save the world."
	admin_only = TRUE

/datum/tgs_chat_command/dev_save/Run(datum/tgs_chat_user/sender, params)
	if(world_saving)
		return "World save currently in progress!"
	var/start = REAL_TIME
	Saveworld()
	var/end = REAL_TIME
	var/seconds = round((end - start) / 10, 0.01)
	return "World save complete in [seconds] seconds."

// todo: lock this to dev discord ids via config

/datum/tgs_chat_command/dev_announcement
	name = "dev-announce"
	help_text = "Announce something to the world."
	admin_only = TRUE

/datum/tgs_chat_command/dev_announcement/Run(datum/tgs_chat_user/sender, params)
	world.send_chat("Server: [params]", stream = "oocout")
	return "Broadcasted '[params]' to [length(GLOB.clients)] players."

/datum/tgs_chat_command/dev_status
	name = "dev-status"
	help_text = "Check server status."
	admin_only = TRUE

/datum/tgs_chat_command/dev_status/Run(datum/tgs_chat_user/sender, params)
	return "Server online for [time2text(world.time, "hh-mm-ss")] (world.time) with [length(GLOB.clients)] players."

/datum/tgs_chat_command/dev_republish
	name = "dev-republish"
	help_text = "dev-republish hub hub_password"
	admin_only = TRUE

/datum/tgs_chat_command/dev_republish/Run(datum/tgs_chat_user/sender, params)
	var/list/split = splittext(params, " ")
	if(length(split) != 2)
		return "Invalid format; use 'dev-republish <hub> <password>'"
	world.hub = split[1]
	world.hub_password = split[2]
	return "Changed hub publication to [world.hub_password]@[world.hub]; [world.visibility]-[world.status]-[world.game_state]-[world.name]-[world.host]-[world.url]"
