/mob/Moved(atom/oldloc, dir, forced)
	. = ..()
	UpdateArea(src)
	if(verify_pulling(TRUE))
		move_pulled(oldloc)
	process_followers()

/mob/transit_move(atom/newloc, list/recursed = list(), recurse_pull = 3, recurse_follow = 1)
	var/list/follows_brought_along
	for(var/mob/M as anything in followers)
		if(get_dist(M, src) > FOLLOW_TRANSIT_DIST)
			continue
		LAZYLIST_ADD(follows_brought_along, M)
		M.stop_following(TRUE)
	var/mob/old_pulled = pulling
	if(old_pulled)
		stop_pulling(TRUE)
	. = ..()
	if(!.)
		CRASH("transit move failed; likely detected a loop.")
	if(old_pulled)
		old_pulled.transit_move(newloc, recursed, recurse_pull - 1, recurse_follow)
		start_pulling(old_pulled, TRUE)
	if(LAZYLIST_LENGTH(follows_brought_along))
		for(var/mob/M as anything in follows_brought_along)
			M.transit_move(newloc, recursed, recurse_pull, recurse_follow - 1)
			M.start_following(src, TRUE)

/mob/force_move(atom/newloc)
	// break anything necessary
	terminate_pulls()
	terminate_follows()
	. = ..()
