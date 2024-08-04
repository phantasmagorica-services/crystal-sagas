// placeholder file

/mob/proc/legacy_inventory_ingest(path, amount, msg)
	if(ispath(path, /obj/item/material))
		var/obj/item/material/casted = path
		adjust_material_amount(path, amount)
		if(msg)
			send_chat("[msg][amount] of [initial(casted.name)](s)", stream = "oocout")
	else if(ispath(path, /obj/Money))
		money += amount
		if(msg)
			send_chat("[msg][amount] Gil", stream = "oocout")
	else if(ispath(path, /obj))
		for(var/i in 1 to min(amount, 10))
			new path(loc)
		if(msg)
			send_chat("[msg][amount] of [path] (report this to coders)", stream = "oocout")
	else
		send_chat("Rejecting attempted spawn of [path], [amount], [msg] - report this to coders.", stream = "oocout")
