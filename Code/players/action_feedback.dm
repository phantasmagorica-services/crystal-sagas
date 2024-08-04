/**
 * sends a message of an interaction failing
 *
 * @params
 * * msg - message
 * * target - atom we interacted with (optional)
 */
/mob/proc/alert_interaction_fail(msg, atom/target)
	alert(msg)
