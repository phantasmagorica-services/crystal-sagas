/**
 * singleton soon-to-be-tickable system datums
 *
 * init:
 * - Construct() is called before Load()
 *
 * shutdown:
 * - Save() is called before Shutdown()
 *
 * restore:
 * - Restore() is called without Load()
 *
 * This may take getting used to.
 */
/datum/system
	abstract_type = /datum/system
	/// name
	var/name = "System"
	/// save id - DO NOT CHANGE THIS
	var/save_id
	/// savefile version - TICK UP BY 1 DURING UPDATES.
	var/save_version = 1
	// todo: init order
	// todo: ticking
	// todo: inits
	// todo: naming scheme for system globalvars (sys_name? name_system?)
	// todo: timsort

/**
 * build from scratch
 *
 * called before Load()
 *
 * @return TRUE / FALSE for success / failure
 */
/datum/system/proc/Construct()
	return TRUE

/**
 * restore if we're recovering after a system needs to be rebuilt.
 *
 * @params
 * * overwriting - what was in the global variable before us
 *
 * @return TRUE / FALSE for success / failure
 */
/datum/system/proc/Restore(datum/system/overwriting)
	return TRUE

/**
 * saves data; called during:
 * * world/Reboot()
 *
 * called before Shutdown()
 *
 * todo: call this every x minutes?
 *
 * @return list() of data on success. null on failure.
 */
/datum/system/proc/Save()
	return list()

/**
 * loads data; ONLY called during init.
 * List is NULL if not found.
 *
 * called after Construct()
 *
 * @return TRUE / FALSE on success / failure.
 */
/datum/system/proc/Load(list/data)
	return TRUE

/**
 * migrates data if version is lower than self
 *
 * this is a data *transformer*, modify the data *IN PLACE*.
 */
/datum/system/proc/Migrate(list/blackboard, from_version)
	return

/**
 * shuts down
 *
 * called after Save()
 *
 * @return TRUE / FALSE on success / failure.
 */
/datum/system/proc/Shutdown()
	return TRUE

/**
 * get savefile path
 */
/datum/system/proc/savefile_path()
	if(!save_id)
		return null
	return "[world.data_directory()]world/systems/[save_id].sav"

/**
 * log
 */
/datum/system/proc/system_log(msg)
	log_system("[name]: [msg]")
