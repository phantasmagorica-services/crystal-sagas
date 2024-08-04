LEGACY_GLOBAL_LIST_BOILERPLATE(resource_nodes, /obj/resource_node)

/**
 * base type of resource nodes
 *
 * todo: repath to /obj/resource_node
 */
/obj/resource_node
	/// icon state when available. tmp because prototype-only def
	var/tmp/icon_state_full
	/// icon state when used. tmp because prototype-only def
	var/tmp/icon_state_empty
	/// are we used up already? tmp because world reboots refresh anyways
	var/tmp/used = FALSE
	// todo: evaluate; seems to be used for moogle retainers.
	var/cooldown = FALSE

/obj/resource_node/update_icon()
	icon_state = used? icon_state_empty : icon_state_full

/**
 * called to check if someone can harvest.
 *
 * @params
 * * user - person harvesting
 * * silent - should we give them an alert with the reason of failure?
 *
 * @return TRUE / FALSE based on success / failure
 */
/obj/resource_node/proc/can_harvest(mob/user, silent)
	if(is_used())
		if(!silent)
			user.alert_interaction_fail("This node is already used for the day.", src)
		return FALSE
	if(user.minednodes >= user.maxnodes)
		if(!silent)
			user.alert_interaction_fail("You already have mined the [user.maxnodes] nodes you can mine, for today.", src)
		return FALSE
	return TRUE

/**
 * refreshes and preps us for usage again.
 */
/obj/resource_node/proc/refresh()
	used = FALSE
	update_icon()

/**
 * uses us up
 */
/obj/resource_node/proc/use()
	used = TRUE
	update_icon()

/**
 * checks if we're used
 */
/obj/resource_node/proc/is_used()
	return used
