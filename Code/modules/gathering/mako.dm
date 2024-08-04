/obj/resource_node/mako
	name="Materia Node"
	icon = 'Icons/Nodes.dmi'
	icon_state = "activemako"
	icon_state_empty = "inactivemako"
	icon_state_full = "activemako"
	density = TRUE

/obj/resource_node/mako/Click()
	var/mob/user = usr
	if(!(usr in view(1,src)))
		return
	if(!can_harvest(user, FALSE))
		return
	if(!usr.check_perk("Materia Melder"))
		alert("You need to learn how to mine properly first.")
		return
	if(usr.check_perk("Expert Miner" && "Master Gatherer"))
		use()
		usr<<output("You have gathered 3 Raw Mako from the Lifestream.","oocout")
		for(var/obj/item/material/raw_mako/b in usr.contents)
			b.amount+=3
	else if(usr.check_perk("Expert Miner" || "Master Gatherer"))
		for(var/obj/item/material/raw_mako/b in usr.contents)
			b.amount+=2
		use()
		usr<<output("You have gathered 2 Raw Mako from the Lifestream.","oocout")
	else
		for(var/obj/item/material/raw_mako/b in usr.contents)
			b.amount+=1
		use()
		usr<<output("You have gathered 1 Raw Mako from the Lifestream.","oocout")
	for(var/obj/item/material/stone/c in usr.contents)
		if(usr.check_perk("Nothing Wasted"))
			c.amount+=4
			usr<<output("You also find 3 stone...Nothing Wasted earned you 1 more.","oocout")
			usr<<output("You also find 3 stone...Nothing Wasted earned you 1 more.","alert")
		else
			c.amount+=3
			usr<<output("You also find 3 stone.","oocout")
			usr<<output("You also find 3 stone.","alert")
	UpdateCraft(usr)
	usr.minednodes+=1
	log_action("GATHER: [key_name(usr)] mined [src] [audit_coord(src)]")
