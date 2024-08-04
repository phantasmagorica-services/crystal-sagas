/**
 * Server bootup happens like this:
 *
 * * 1. /datum/server_initialization is ran by the boot delegate that's defined last - this brings up the auxtools debugger first-thing
 * * 2. all /static variables in procs and prototypes (type variables) init in reverse order of compile
 * * 3. all /global variables in global scope init in order of compile
 * * 4. the System service is created by server initialization during that
 * * 5. during New(), the System service creates the Configuration service, and the managed GLOB service
 * * 6. the managed GLOB service inits managed globals as part of this during its New()
 * * 7. the System service creates the Database service and attempts to connect it
 * * 8. the System service, still in New(), creates all subsystems
 * * 9. each subsystem being created calls their own PreInit()
 * * 10. repositories and entity mappers are created and linked to their databases as necessary from the Configuration service
 * * 11. the compiled in map is created, New() is called as necessary on everything
 * * 12. /world/New() runs and schedules the System service's initialization
 * * 13. the System service initialize()s, booting up the Ticker, Watchdog, and then initializing all Subsystems
 * * 14. the System service finalizes initialization and readies the world for joining
 *
 * how we hook ourselves to run first is by defining __boot_delegate as a static last in the compile order.
 */

/// real global
GLOBAL_REAL_DATUM(Initialization, /datum/server_initialization)

/**
 * Holds server boot data
 */
/datum/server_initialization

/datum/server_initialization/proc/Boot()
	// init auxtools
	first_thing_to_run()
	// start debug ticker
	forever_loop()
	// boot System
	global.System = new(src)

/**
 * This runs before **anything** else.
 */
/datum/server_initialization/proc/first_thing_to_run()
	//? https://github.com/SpaceManiac/SpacemanDMM/blob/master/crates/dm-langserver/src/debugger/launched.rs#L76
	//? https://github.com/willox/auxtools/blob/master/debug_server/src/lib.rs
	/// enable auxtools debugging
	var/debug_server = world.GetConfig("env", "AUXTOOLS_DEBUG_DLL")
	if (debug_server)
		DYLIB_CALL(debug_server, "auxtools_init")()
		enable_debugging()

//? FUNNY THING
//? After we fixed the infinite loops, this game is so costless to run,
//? That there is **NOTHING TO HOOK** for the auxtools debugger.
//? Thus we need to SYNTHETICALLY GENERATE AN ALWAYS-RUNNING LOOP,
//? so it can "attach" to that instead.
//? Otherwise the debugger just fucking breaks.
//? We can remove this if we ever get a proper managed master-ticker loop.
/datum/server_initialization/proc/forever_loop()
	set waitfor = FALSE
	do_forever_loop()

/datum/server_initialization/proc/do_forever_loop()
	while(TRUE)
		sleep(world.tick_lag)
