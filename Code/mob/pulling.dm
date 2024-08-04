/mob/verb/grab_verb()
	set name = "Grab / Release"
	set desc = "Grab someone"
	set category = "IC"
	set src in oview(1)

	if(usr.pulling == src)
		usr.stop_pulling()
	else
		usr.start_pulling(src)

/**
 * start pulling a mob
 */
/mob/proc/start_pulling(mob/other, silent)
	if(other == src)
		return
	if(other == pulling)
		return
	// stop pulling first so the pull limit check doesn't stop you from swapping to another person in your chain
	if(pulling)
		stop_pulling()
	if(!pull_conga_check(other))
		if(!silent)
			send_chat("You are already pulling the maximum number of pepole you can, or are trying to pull someone who is already in your chain of pulls.")
		return
	if(other.pulledby)
		other.pulledby.stop_pulling()
	if(!silent)
		other.send_chat("[src] grabs you!")
		send_chat("You grab [other].")
	pulling = other
	other.pulledby = src
	other.stop_following()

/**
 * traverses pull chain and ensures that
 * 1. the mob that's about to be pulled isn't already in our chain somewhere
 * 2. there's not too many people being pulled
 */
/mob/proc/pull_conga_check(mob/other)
	var/amt = 1
	// traverse backwards
	var/mob/current = pulling
	while(current)
		++amt
		if(amt > PULL_CONGA_LIMIT)
			return FALSE
		if(current == src)
			return FALSE
		if(current == other)
			return FALSE
		current = current.pulling
	// traverse forwards
	current = pulledby
	while(current)
		++amt
		if(amt > PULL_CONGA_LIMIT)
			return FALSE
		if(current == src)
			return FALSE
		if(current == other)
			return FALSE
		current = current.pulledby
	return TRUE

/**
 * stop pulling whoever we're pulling
 */
/mob/proc/stop_pulling(silent, break_grip = FALSE)
	if(!pulling)
		return
	if(!silent)
		if(break_grip)
			pulling.send_chat("You break away from [src]'s grip.")
			send_chat("[pulling] breaks away from your grip.")
		else
			pulling.send_chat("[src] lets go of you.")
			send_chat("You let go of [pulling].")
	pulling.pulledby = null
	pulling = null

/**
 * stop pulling and stop being pulled immediately
 */
/mob/proc/terminate_pulls()
	stop_pulling(TRUE)
	pulledby?.stop_pulling(TRUE)

/**
 * checks that we are 1. pulling and 2. should keep the pull, 3. terminating the pull if not
 */
/mob/proc/verify_pulling(moving)
	if(!pulling || !isturf(pulling.loc))
		stop_pulling(TRUE)
		return FALSE
	if(get_dist(src, pulling) > (moving? 2 : 1))
		stop_pulling()
		return FALSE
	return TRUE

/**
 * move pulled towards us
 */
/mob/proc/move_pulled(atom/oldloc)
	pulling.Move(oldloc, get_dir(pulling, oldloc))
