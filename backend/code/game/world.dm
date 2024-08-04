/world
	name = "Phantasmagorica"
	fps = 40
	icon_size = 32
	// mob = /mob/lobby
	turf = /turf/unallocated
	area = /area/unallocated
	visibility = FALSE
	view = 34

// /world/New()
// 	TgsNew()
// 	return ..()

/world/Reboot(reason)
	Logger.shutdown_logging()
	return ..()
