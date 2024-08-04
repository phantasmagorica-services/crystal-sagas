/mob/proc/send_chat(msg, stream)
	client?.send_chat(msg, stream)

/client/proc/send_chat(msg, stream = "icout")
	src << output(msg, stream)

/world/proc/send_chat(msg, stream)
	for(var/client/C as anything in GLOB.clients)
		C.send_chat(msg, stream)
