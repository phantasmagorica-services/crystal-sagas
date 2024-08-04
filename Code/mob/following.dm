
/mob/verb/follow_us_verb()
	set name = "Follow / Unfollow"
	set desc = "Follow someone"
	set category = "IC"
	set src in oview(2)

	if(usr.following == src)
		usr.stop_following(src)
	else
		usr.start_following(src)

/**
 * makes all mobs stop following us, and stops following
 */
/mob/proc/terminate_follows()
	for(var/mob/M as anything in followers)
		M.stop_following(TRUE)
	stop_following(TRUE)

/**
 * stops following whoever we're following
 */
/mob/proc/stop_following(silent)
	if(!following)
		return
	if(!silent)
		following.send_chat("[src] stops following you.")
		send_chat("You stop following [following].")
	LAZYLIST_REMOVE(following.followers, src)
	following = null

/**
 * makes sure we're not trying to follow someone that is already following us
 */
/mob/proc/follow_closure_check(mob/other)
	if(other in followers)
		return FALSE
	for(var/mob/M as anything in followers)
		if(!M._follow_closure_check(other, src))
			return FALSE
	return TRUE

/mob/proc/_follow_closure_check(mob/other, mob/_original)
	PRIVATE_PROC(TRUE)
	if(_original == src)
		CRASH("intercept: self loop in follow_closure_check")
	if(other in followers)
		return FALSE
	for(var/mob/M as anything in followers)
		if(!M._follow_closure_check(other, src))
			return FALSE
	return TRUE

/**
 * starts following someone
 */
/mob/proc/start_following(mob/M, silent)
	if(M == src)
		return
	if(following == M)
		return
	// stop following first so closure check doesn't false positive
	if(following)
		stop_following()
	if(!follow_closure_check(M))
		if(!silent)
			send_chat("You cannot follow someone that's directly or indirectly following you.")
		return
	if(!silent)
		M.send_chat("[src] starts following you.")
		send_chat("You start following [M].")
	following = M
	LAZYLIST_ADD(M.followers, src)
	pulledby?.stop_pulling(break_grip = TRUE)

/**
 * check & move followers towards us
 */
/mob/proc/process_followers()
	for(var/mob/M as anything in followers)
		if(!isturf(M.loc))
			M.stop_following(TRUE)
			continue
		if(get_dist(M, src) >= FOLLOW_BREAK_DIST)
			M.stop_following()
			continue
		step_to(M, src, FOLLOW_DIST)
		// allow one catchup
		if(get_dist(M, src) > FOLLOW_DIST)
			step_to(M, src, FOLLOW_DIST)
