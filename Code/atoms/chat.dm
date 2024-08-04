/**
 * sends a chat visible message to anything that can see us
 */
/atom/proc/visible_message(msg, range = world.view, stream, color = FALSE)
	if(color)
		if(istext(color))
			msg = "<font color='[color]'>[msg]</font>"
		if(ismob(src))
			var/mob/M = src
			msg = "<font color='[M.textcolor]'>[msg]</font>"
	for(var/mob/M in hearers(range, src))
		M.send_chat(msg, stream)
