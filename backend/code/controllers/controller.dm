/**
 * base type of server controller singleton datums
 */
/datum/controller
	abstract_type = /datum/controller

	/// name
	var/name = "Controller"

/datum/controller/proc/pretty_identifier()
	return "[type]"

/**
 * announces init message
 */
/datum/controller/proc/init_announce_notice(msg)
	init_log_notice(msg)
	msg = "[pretty_identifier()]: [msg]"
	to_chat_immediate(world, SPAN_SERVER_NOTICE(msg))

/**
 * announces init issue
 */
/datum/controller/proc/init_announce_issue(msg)
	init_log_issue(msg)
	msg = "[pretty_identifier()]: [msg]"
	to_chat_immediate(world, SPAN_SERVER_WARNING(msg))

/**
 * announces init fatal failure
 */
/datum/controller/proc/init_announce_fatal(msg)
	init_log_fatal(msg)
	msg = "[pretty_identifier()]: [msg]"
	to_chat_immediate(world, SPAN_SERVER_DANGER(msg))

/**
 * logs init message
 */
/datum/controller/proc/init_log_notice(msg)
	Logger.log_subsystem(src, msg)

/**
 * logs issue in init
 */
/datum/controller/proc/init_log_issue(msg)
	Logger.log_subsystem(src, msg)

/**
 * logs fatal failure in init
 */
/datum/controller/proc/init_log_fatal(msg)
	Logger.log_subsystem(src, msg)

/datum/controller/proc/announce_notice(msg)
	log_notice(msg)
	msg = "[pretty_identifier()]: [msg]"
	to_chat_immediate(world, SPAN_SERVER_NOTICE(msg))

/datum/controller/proc/announce_issue(msg)
	log_issue(msg)
	msg = "[pretty_identifier()]: [msg]"
	to_chat_immediate(world, SPAN_SERVER_WARNING(msg))

/datum/controller/proc/announce_fatal(msg)
	log_fatal(msg)
	msg = "[pretty_identifier()]: [msg]"
	to_chat_immediate(world, SPAN_SERVER_DANGER(msg))

/datum/controller/proc/log_notice(msg)
	Logger.log_subsystem(src, msg)

/datum/controller/proc/log_issue(msg)
	Logger.log_subsystem(src, msg)

/datum/controller/proc/log_fatal(msg)
	Logger.log_subsystem(src, msg)
