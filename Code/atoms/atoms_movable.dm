T/**
 * root define for atom/movable
 */
/atom/movable

//? Movement

/**
 * default BYOND Move() wrapper
 */
/atom/movable/Move(NewLoc, Dir, step_x, step_y)
	var/atom/oldloc = loc
	. = ..()
	if(!.)	// movement failed
		return
	Moved(oldloc, Dir, FALSE)

/**
 * Called after a move of *ANY* kind, regular or forced
 *
 * @params
 * * oldloc - where we were
 * * dir - direction of movement (forcemoves are NONE in genera)
 * * forced - was it a forced/transit movement or a normal movement
 */
/atom/movable/proc/Moved(atom/oldloc, dir, forced)
	return

/**
 * managed wrapper: forcefully moves us to another place
 *
 * allows us to override for behavior, like dropping grabs
 */
/atom/movable/proc/force_move(atom/newloc)
	return _hard_move(newloc)

/**
 * transit forcemove: used if we're transiting maps or otherwise force-moving through some logical
 *	 transition that requires us to carry stuff through
 *
 * @params
 * * newloc - where to move them to
 * * recursed - what we already recursed, so probably don't do it again
 * * recurse_pull - how many levels of pulling to recurse
 * * recurse_follow - how many levels of followers to recurse
 */
/atom/movable/proc/transit_move(atom/newloc, list/recursed = list(), recurse_pull = 3, recurse_follow = 1)
	if(recursed[src])
		return FALSE
	recursed[src] = TRUE
	_hard_move(newloc)
	return TRUE

/**
 * moves us to a new location, emulating BYOND movement procs as best as possible
 *
 * * AREA SUPPORT IS FLAKY AT BEST.      *
 * * AREA CALLS ARE NOT BYOND-COMPLIANT. *
 */
/atom/movable/proc/_hard_move(atom/newloc)
	// first exit our whereever we are - we called the -ed procs, as we are *not* checking for exit.
	var/atom/oldloc = loc
	var/area/oldarea = get_area(src)
	if(oldloc)
		// contents
		for(var/atom/movable/AM as anything in oldloc)
			AM.Uncrossed(src)
		// self
		if(isturf(oldloc))
			oldloc.Uncrossed(src)
		oldloc.Exited(src)
		// area
		oldarea.Exited(src)
	// set loc
	loc = newloc
	// then enter new loc if any
	if(newloc)
		var/area/newarea = get_area(newloc)
		// contents
		for(var/atom/movable/AM as anything in newloc)
			AM.Crossed(src)
		// self
		newloc.Entered(src)
		if(isturf(newloc))
			newloc.Crossed(src)
		// area
		newarea.Entered(src)
	// finish
	Moved(oldloc, NONE, TRUE)
	return TRUE
