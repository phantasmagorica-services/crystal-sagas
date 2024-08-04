/**
 * # Logging System
 *
 * This is special in that it's initialized early.
 */
CONTROLLER_DEF(logging, Logger)
	name = "Logger"

	var/root_dir

	var/logfile_access
	var/logfile_admin
	var/logfile_asset
	var/logfile_config
	var/logfile_inventory
	var/logfile_mechanics
	var/logfile_roleplay
	var/logfile_subsystem
	var/logfile_tgui
	var/logfile_world

	var/dd_log

// most of the code is in /code/modules/logging

/datum/controller/logging/proc/setup_logging()
	var/realtime = world.realtime
	var/year = time2text(realtime, "YYYY")
	var/month = time2text(realtime, "MM")
	var/day = time2text(realtime, "DD")
	// when we do 'round' IDs, we use 'round-' instead
	var/discriminator = "stamp-[time2text(realtime, "hh-mm-ss")]"
	var/directory = "data/logs/[year]/[month]/[day]/[discriminator]"

	root_dir = directory
	dd_log = "[directory]/dd.log"

	#define SETUP_LOG(VAR, FNAME) VAR = "[directory]/[FNAME]"; WRITE_LOG(VAR, "Server setup at REALTIME-[num2text(realtime, 32)].");
	SETUP_LOG(logfile_access, "access.log")
	SETUP_LOG(logfile_admin, "admin.log")
	SETUP_LOG(logfile_asset, "asset.log")
	SETUP_LOG(logfile_config, "config.log")
	SETUP_LOG(logfile_inventory, "inventory.log")
	SETUP_LOG(logfile_mechanics, "mechanics.log")
	SETUP_LOG(logfile_roleplay, "roleplay.log")
	SETUP_LOG(logfile_subsystem, "subsystem.log")
	SETUP_LOG(logfile_tgui, "tgui.log")
	SETUP_LOG(logfile_world, "world.log")
	#undef SETUP_LOG

/datum/controller/logging/proc/shutdown_logging()
	rustg_log_close_all()
