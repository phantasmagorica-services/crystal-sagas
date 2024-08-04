/datum/asset
	/// original filename
	var/name
	/// file name
	var/fname
	/// file extension
	var/ext
	/// resource file
	var/rsc
	/// grouping
	var/grouping
	/// cached hash
	var/hash

/datum/asset/New(fname, rsc, grouping)
	src.name = fname
	src.rsc = rsc
	src.grouping = grouping
	var/dot_loc = findlasttext_char(fname, ".")
	if(dot_loc)
		ext = copytext(fname, dot_loc + 1)
		fname = copytext(fname, 1, dot_loc)
	// todo: impl grouping

/**
 * sends to a client
 *
 * blocks until complete
 *
 * @return TRUE / FALSE on success / failure
 */
/datum/asset/proc/send(client/C)
	return C.load_asset(src)

/**
 * actually transmits to a client
 */
/datum/asset/proc/transmit(client/C)
	C << browse_rsc(rsc, rsc_name())
	LAZYLIST_SET(C.assets_loaded, src, TRUE)

/**
 * get rsc name to use in browse rsc
 */
/datum/asset/proc/rsc_name()
	return ext? "[hash || hash()].[ext]" : (hash || hash())

/**
 * get url to use in browser / caches
 */
/datum/asset/proc/url()
	return rsc_name()

/**
 * computes, caches, and returns hash
 */
/datum/asset/proc/hash()
	var/path = "[world.data_directory()]asset_hashing.tmp"
	fcopy(rsc, path)
	. = md5(file(path))
	fdel(path)
