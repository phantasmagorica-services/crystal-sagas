/**
 * logs /datum/system and /datum/ticker status
 */
/proc/log_system(msg)
	world.log << "\[[timestamp()]\] [msg]"

/**
 * log runtime errors
 */
/proc/log_error(msg)
	world.log << "\[[timestamp()]\] [msg]"

/proc/log_world(msg)
	world.log << "\[[timestamp()]\] [msg]"

/// key-message list of warnings
LEGACY_GLOBAL_LIST_EMPTY(logged_warnings)

/**
 * warn once and never again
 */
/proc/logged_warning(message, key)
	ASSERT(message && key)
	if(global.logged_warnings[key])
		return
	// todo: message admins
	world.log << "keyed-warning: [key] -> [message]"

/proc/tgs_info_log(msg)
	log_system("TGS-Info: [msg]")

/proc/tgs_warning_log(msg)
	log_system("TGS-Warning: [msg]")

/proc/tgs_error_log(msg)
	log_system("TGS-Error: [msg]")

/proc/log_say(mob/M, msg)
	log_action("SAY: [key_name(M)]: [msg]")

/proc/log_ooc(mob/M, msg)
	log_action("OOC: [key_name(M)]: [msg]")

/proc/log_emote(mob/M, msg)
	log_action("EMOTE: [key_name(M)]: [msg]")

/proc/key_name(mob/M)
	return "([M.ckey]/[M.name])"

/proc/audit_coord(atom/M)
	M = get_turf(M)
	if(isnull(M))
		return "(nullspace?)"
	return "([M.x], [M.y], [M.z])"

/proc/log_action(msg)
	if(isnull(global.action_log_file))
		return
	global.action_log_file << "\[[timestamp()]\] [msg]"
