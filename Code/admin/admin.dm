/**
 * checks if someone is an admin of some kind
 */
/proc/is_admin(client/clientlike)
	var/mob/M
	if(ismob(clientlike))
		M = clientlike
	else if(istype(clientlike))
		M = clientlike.mob
	else
		CRASH("invalid: [clientlike]")
	. = !!M.adminlv

/**
 * checks if someone should be allowed debug info
 */
/proc/is_dev(client/clientlike)
	var/mob/M
	if(ismob(clientlike))
		M = clientlike
	else if(istype(clientlike))
		M = clientlike.mob
	else
		CRASH("invalid: [clientlike]")
	. = !!M.adminlv || M.client?.is_dev()
