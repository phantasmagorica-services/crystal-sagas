/**
 * root definition for client
 */
/client
	view = "35x20"

	//? Assets
	/// assets loaded - datums
	var/list/datum/asset/assets_loaded
	/// assets awaiting send
	var/list/datum/asset/assets_queued
	/// currently sending assets
	var/asset_sending = FALSE

	//? Viewport
	/// what we *think* their current viewport size is in pixels
	var/assumed_viewport_spx
	/// what we *think* their current viewport size is in pixels
	var/assumed_viewport_spy
	/// if things are manipulating the viewport we don't want other things to touch it
	/// this starts blocked so we can release it during init_viewport
	var/viewport_rwlock = TRUE

	//? Admin
	// TODO: remove when proper admin system
	/// for now, hardcode keys with profiler access
	var/static/list/debug_access = list(
		// neopoke
		"neogeo123",,
		// silicons
		"silicons",
		"scvi",
		"iops",
		// vi
		"giantrobotsintokyo",
		"poisoncupcake",
		"pureflower",
		//Delphonse
		"limb",
	)

/client/New()
	// grant profiler access; world/Reboot is patched to not allow rebooting with app admin
	if((ckey in debug_access) || is_localhost())
		world.SetConfig("APP/admin", ckey, "role=admin")
	// calls mob.Login()
	. = ..()
	// setup viewport
	async_call(src, SELF_PROC_REF(init_viewport_blocking))
	world.log << "Client [ckey] connected from IP [address] with CID [computer_id]"

/client/Del()
	world.log << "Client [ckey] disconnected from IP [address] with CID [computer_id]"
	return ..()

/**
 * loads asset; blocks until done.
 *
 * @return TRUE / FALSE on success / failure
 */
/client/proc/load_asset(datum/asset/A)
	if(LAZYLIST_ACCESS(assets_loaded, A))
		return TRUE
	LAZYLIST_DISTINCTADD(assets_queued, A)
	async_call(src, SELF_PROC_REF(transmit_assets))
	BLOCK_ON(LAZYLIST_ACCESS(assets_loaded, A))
	return TRUE

/**
 * transmit assets
 *
 * @return number loaded
 */
/client/proc/transmit_assets()
	. = 0
	if(asset_sending)
		return
	asset_sending = TRUE
	while(LAZYLIST_LENGTH(assets_queued))
		var/datum/asset/A = assets_queued[1]
		A.transmit(src)
		++.
		sleep(1)
	asset_sending = FALSE

// TODO: REMOVE - temporary dev check
/client/proc/is_dev()
	return (ckey in debug_access)
