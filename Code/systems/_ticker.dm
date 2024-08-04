LEGACY_GLOBAL_DATUM_INIT(ticker, /datum/ticker, new)
/**
 * master game ticker in charge of everything
 */
/datum/ticker
	/// all systems
	var/list/datum/system/systems

	// todo: ticking

/datum/ticker/New()
	make_systems()

/datum/ticker/proc/make_systems()
	systems = list()
	for(var/path in subtypes_of(/datum/system))
		if(is_typepath_abstract(path))
			continue
		var/datum/system/sys = new path
		systems += sys

/datum/ticker/proc/Construct(delay)
	spawn(delay)
		construct_systems()
		Ready()

/datum/ticker/proc/Ready()
	//? do not sleep offline, let TGS handle that
	world.sleep_offline = FALSE
	//? TGS init complete
	world.TgsInitializationComplete()

/datum/ticker/proc/Shutdown()
	shutdown_systems()

/datum/ticker/proc/construct_systems(silent)
	// todo: sort order
	var/start = REAL_TIME
	init_log("Starting up subsystems...", TRUE)
	for(var/datum/system/sys in systems)
		var/sys_start = REAL_TIME
		sys.Construct()
		init_log("[sys.type] startup in [round((REAL_TIME - sys_start) * 0.1, 0.1)] seconds.", TRUE)
	init_log("Systems startup completed in [round((REAL_TIME - start) * 0.1, 0.1)] seconds.", !silent)
	load_systems(silent)

/datum/ticker/proc/shutdown_systems(silent)
	// todo: sort order
	init_log("Shutting down subsystems...", TRUE)
	save_systems(silent)
	var/start = REAL_TIME
	for(var/datum/system/sys in systems)
		var/sys_start = REAL_TIME
		sys.Construct()
		init_log("[sys.type] shutdown in [round((REAL_TIME - sys_start) * 0.1, 0.1)] seconds.", TRUE)
	init_log("Systems shutdown completed in [round((REAL_TIME - start) * 0.1, 0.1)] seconds.", !silent)

/datum/ticker/proc/load_systems(silent)
	var/start = REAL_TIME
	for(var/datum/system/sys in systems)
		var/sys_start = REAL_TIME
		if(!load_system(sys))
			continue
		init_log("[sys.type] load in [round((REAL_TIME - sys_start) * 0.1, 0.1)] seconds.", TRUE)
	init_log("System state loaded in [round((REAL_TIME - start) * 0.1, 0.1)] seconds.", !silent)

/datum/ticker/proc/save_systems(silent)
	var/start = REAL_TIME
	for(var/datum/system/sys in systems)
		var/sys_start = REAL_TIME
		if(!save_system(sys))
			continue
		init_log("[sys.type] save in [round((REAL_TIME - sys_start) * 0.1, 0.1)] seconds.", TRUE)
	init_log("System state saved in [round((REAL_TIME - start) * 0.1, 0.1)] seconds.", !silent)

/datum/ticker/proc/init_log(msg, public)
	if(public)
		world.send_chat("[msg]")
	log_system("TICKER: [msg]")

/datum/ticker/proc/load_system(datum/system/sys)
	var/fpath = sys.savefile_path()
	if(!fpath)
		return FALSE
	if(!fexists(fpath))
		sys.Load(null)
		return TRUE
	var/savefile/S = new /savefile(fpath)
	if(!S)
		. = FALSE
		CRASH("failed to open savefile")
	S.cd = "/"
	var/list/data
	var/version
	S["version"] >> version
	S["data"] >> data
	if(version < sys.save_version)
		sys.Migrate(data, version)
	if(!sys.Load(data))
		. = FALSE
		CRASH("failed to load system")
	return TRUE

/datum/ticker/proc/save_system(datum/system/sys)
	var/fpath = sys.savefile_path()
	if(!fpath)
		return FALSE
	var/savefile/S = new /savefile(fpath)
	if(!S)
		. = FALSE
		CRASH("failed to open savefile")
	S.cd = "/"
	var/list/data = sys.Save()
	var/version = sys.save_version
	if(!data)
		. = FALSE
		CRASH("failed to save system")
	S["data"] << data
	S["version"] << version
	return TRUE
