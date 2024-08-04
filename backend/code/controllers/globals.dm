/**
 * # Global variable controller
 *
 * We're stealing TG's GLOB naming.
 */
CONTROLLER_DEF(globals, GLOB)
	name = "Globals"

/datum/controller/globals/New()
	construct()

/datum/controller/globals/proc/construct()
	var/list/procpaths = global_init_procs()
	for(var/procpath in procpaths)
		call(src, procpath)()
