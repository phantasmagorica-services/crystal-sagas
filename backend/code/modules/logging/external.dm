//* Raw Message Logging *//

/**
 * authentication / authorization / connect / disconnect logs
 */
/datum/controller/logging/proc/to_access_log(msg)
	WRITE_LOG(logfile_access, msg)

/datum/controller/logging/proc/to_admin_log(msg)
	WRITE_LOG(logfile_admin, msg)

/datum/controller/logging/proc/to_asset_log(msg)
	WRITE_LOG(logfile_asset, msg)


/datum/controller/logging/proc/to_config_log(msg)
	WRITE_LOG(logfile_config, msg)

/datum/controller/logging/proc/to_inventory_log(msg)
	WRITE_LOG(logfile_inventory, msg)

/**
 * mechanical combat logging
 */
/datum/controller/logging/proc/to_mechanics_log(msg)
	WRITE_LOG(logfile_mechanics, msg)

/**
 * rp action log
 */
/datum/controller/logging/proc/to_roleplay_log(msg)
	WRITE_LOG(logfile_roleplay, msg)

/datum/controller/logging/proc/to_subsystem_log(msg)
	WRITE_LOG(logfile_subsystem, msg)

/datum/controller/logging/proc/to_tgui_log(msg)
	WRITE_LOG(logfile_tgui, msg)

/datum/controller/logging/proc/to_world_log(msg)
	WRITE_LOG(logfile_world, msg)

//* Managed Logging Procs *//

/datum/controller/logging/proc/log_config(msg)
	to_config_log(msg)

/datum/controller/logging/proc/log_subsystem(datum/controller/source, msg)
	to_subsystem_log("[source.pretty_identifier()]: [msg]")

/*

/**
 * Appends a tgui-related log entry.
 * All arguments are optional.
 *
 * This function is stolen from /tg/station's TGUI client code, which is licensed under MIT.
 */
/datum/controller/logging/proc/log_tgui(user, message, context,
		datum/tgui_window/window,
		datum/src_object)
	var/entry = ""
	// Insert user info
	if(!user)
		entry += "<nobody>"
	else if(istype(user, /mob))
		var/mob/mob = user
		entry += "[mob.ckey] (as [mob] at [mob.x],[mob.y],[mob.z])"
	else if(istype(user, /client))
		var/client/client = user
		entry += "[client.ckey]"
	// Insert context
	if(context)
		entry += " in [context]"
	else if(window)
		entry += " in [window.id]"
	// Resolve src_object
	if(!src_object && window && window.locked_by)
		src_object = window.locked_by.src_object
	// Insert src_object info
	if(src_object)
		entry += "\nUsing: [src_object.type] [AUTO_REF(src_object)]"
	// Insert message
	if(message)
		entry += "\n[message]"
	to_tgui_log(entry)

*/
