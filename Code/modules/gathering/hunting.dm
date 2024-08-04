/obj/resource_node/hunting
	name="Hunter Node"
	icon = 'Icons/Nodes.dmi'
	icon_state = "trap"
	icon_state_full = "trap"
	icon_state_empty = "opentrap"
	density = TRUE

/obj/resource_node/hunting/Click()
	var/mob/user = usr
	if(!(usr in view(1, src)))
		return
	if(!can_harvest(user, FALSE))
		return
	if(!usr.check_perk("Hunter"))
		alert("You need to learn how to properly hunt first.")
		return
	var/roll
	roll=rand(1,100)
	if(usr.check_perk("Seasoned Hunter" && "Master of the Land"))
		roll+=20
	else if(usr.check_perk("Seasoned Hunter" || "Master of the Land"))
		roll+=10
	else
		roll+=0

	if(roll<11)
		if(usr.check_perk("Expert Hunter" && "Master Gatherer"))
			for(var/obj/item/material/leather/b in usr.contents)
				b.amount+=9
			use()
			usr<<output("You find a deer in your trap, and get manage to expertly skin 9 pieces of leather.","oocout")
			usr<<output("You find a deer in your trap, and get manage to expertly skin 9 pieces of leather.","alert")
		else if(usr.check_perk("Expert Hunter" || "Master Gatherer"))
			for(var/obj/item/material/leather/b in usr.contents)
				b.amount+=6
			use()
			usr<<output("You find a deer in your trap, and get manage to skin 6 pieces of leather.","oocout")
			usr<<output("You find a deer in your trap, and get manage to skin 6 pieces of leather.","alert")
		else
			for(var/obj/item/material/leather/b in usr.contents)
				b.amount+=3
			use()
			usr<<output("You find a deer in your trap, and get manage to skin 3 pieces of leather.","oocout")
			usr<<output("You find a deer in your trap, and get manage to skin 3 pieces of leather.","alert")
	if(roll>10&&roll<21)
		if(usr.check_perk("Expert Hunter" && "Master Gatherer"))
			for(var/obj/item/material/leather/b in usr.contents)
				b.amount+=15
			use()
			usr<<output("You find a deer in your trap, and get manage to expertly skin 15 pieces of leather.","oocout")
			usr<<output("You find a deer in your trap, and get manage to expertly skin 16 pieces of leather.","alert")
		else if(usr.check_perk("Expert Hunter" || "Master Gatherer"))
			for(var/obj/item/material/leather/b in usr.contents)
				b.amount+=10
			use()
			usr<<output("You find a deer in your trap, and get manage to skin 10 pieces of leather.","oocout")
			usr<<output("You find a deer in your trap, and get manage to skin 10 pieces of leather.","alert")
		else
			for(var/obj/item/material/leather/b in usr.contents)
				b.amount+=5
			use()
			usr<<output("You find a deer in your trap, and get manage to skin 5 pieces of leather.","oocout")
			usr<<output("You find a deer in your trap, and get manage to skin 5 pieces of leather.","alert")
	if(roll>20&&roll<31)
		if(usr.check_perk("Expert Hunter" && "Master Gatherer"))
			for(var/obj/item/material/wool/b in usr.contents)
				b.amount+=9
			use()
			usr<<output("You find a sheep in your trap, and get manage to expertly shave 9 pieces of wool.","oocout")
			usr<<output("You find a sheep in your trap, and get manage to expertly shave 9 pieces of wool.","alert")
		else if(usr.check_perk("Expert Hunter" || "Master Gatherer"))
			for(var/obj/item/material/wool/b in usr.contents)
				b.amount+=6
			use()
			usr<<output("You find a sheep in your trap, and get manage to expertly shave 6 pieces of wool.","oocout")
			usr<<output("You find a sheep in your trap, and get manage to expertly shave 6 pieces of wool.","alert")
		else
			for(var/obj/item/material/wool/b in usr.contents)
				b.amount+=3
			use()
			usr<<output("You find a sheep in your trap, and get manage to expertly shave 3 pieces of wool.","oocout")
			usr<<output("You find a sheep in your trap, and get manage to expertly shave 3 pieces of wool.","alert")
	if(roll>30&&roll<41)
		if(usr.check_perk("Expert Hunter" && "Master Gatherer"))
			for(var/obj/item/material/wool/b in usr.contents)
				b.amount+=15
			use()
			usr<<output("You find a sheep in your trap, and get manage to expertly shave 15 pieces of wool.","oocout")
			usr<<output("You find a sheep in your trap, and get manage to expertly shave 15 pieces of wool.","alert")
		else if(usr.check_perk("Expert Hunter" || "Master Gatherer"))
			for(var/obj/item/material/wool/b in usr.contents)
				b.amount+=10
			use()
			usr<<output("You find a sheep in your trap, and get manage to expertly shave 10 pieces of wool.","oocout")
			usr<<output("You find a sheep in your trap, and get manage to expertly shave 10 pieces of wool.","alert")
		else
			for(var/obj/item/material/wool/b in usr.contents)
				b.amount+=5
			use()
			usr<<output("You find a sheep in your trap, and get manage to expertly shave 5 pieces of wool.","oocout")
			usr<<output("You find a sheep in your trap, and get manage to expertly shave 5 pieces of wool.","alert")
	if(roll>40&&roll<51)
		if(usr.check_perk("Expert Hunter" && "Master Gatherer"))
			for(var/obj/item/material/flying_eyes_eye/b in usr.contents)
				b.amount+=4
			use()
			usr<<output("You find an ahriman in your trap, and get manage to expertly tear four eyes from it. (Don't ask from where)","oocout")
			usr<<output("You find an ahriman in your trap, and get manage to expertly tear four eyes from it. (Don't ask from where)","alert")
	else if(usr.check_perk("Expert Hunter" || "Master Gatherer"))
		for(var/obj/item/material/flying_eyes_eye/b in usr.contents)
			b.amount+=2
			use()
			usr<<output("You find a ahriman in your trap, and get manage to tear out two of its eyes.","oocout")
			usr<<output("You find a ahriman in your trap, and get manage to tear out two of its eyes.","alert")
	else
		for(var/obj/item/material/flying_eyes_eye/b in usr.contents)
			b.amount+=1
			use()
			usr<<output("You find a ahriman in your trap, and get manage to tear out its eye.","oocout")
			usr<<output("You find a ahriman in your trap, and get manage to tear out its eye.","alert")
	if(roll>50&&roll<61)
		if(usr.check_perk("Expert Hunter" && "Master Gatherer"))
			for(var/obj/item/material/flying_eyes_wing/b in usr.contents)
				b.amount+=4
			use()
			usr<<output("You find an ahriman in your trap, and get manage to expertly tear four wings from it. (Don't ask from where.)","oocout")
			usr<<output("You find an ahriman in your trap, and get manage to expertly tear four wings from it. (Don't ask from where.)","alert")
		else if(usr.check_perk("Expert Hunter" || "Master Gatherer"))
			for(var/obj/item/material/flying_eyes_wing/b in usr.contents)
				b.amount+=2
			use()
			usr<<output("You find a ahriman in your trap, and get manage to tear out two wings.","oocout")
			usr<<output("You find a ahriman in your trap, and get manage to tear out two wings.","alert")
		else
			for(var/obj/item/material/flying_eyes_wing/b in usr.contents)
				b.amount+=1
			use()
			usr<<output("You find a ahriman in your trap, and get manage to tear out a wing.","oocout")
			usr<<output("You find a ahriman in your trap, and get manage to tear out a wing.","alert")
	if(roll>60&&roll<71)
		if(usr.check_perk("Expert Hunter" && "Master Gatherer"))
			for(var/obj/item/material/zuu_feather/b in usr.contents)
				b.amount+=4
			use()
			usr<<output("You find a zuu in your trap, and get manage to expertly harvest four feathers from it.","oocout")
			usr<<output("You find a zuu in your trap, and get manage to expertly harvest four feathers from it.","alert")
		else if(usr.check_perk("Expert Hunter" || "Master Gatherer"))
			for(var/obj/item/material/zuu_feather/b in usr.contents)
				b.amount+=2
			use()
			usr<<output("You find a zuu in your trap, and get manage to harvest two feathers.","oocout")
			usr<<output("You find a zuu in your trap, and get manage to harvest two feathers.","alert")
		else
			for(var/obj/item/material/zuu_feather/b in usr.contents)
				b.amount+=1
			use()
			usr<<output("You find a zuu in your trap, and get manage to harvest a feather.","oocout")
			usr<<output("You find a zuu in your trap, and get manage to harvest a feather.","alert")
	if(roll>70&&roll<81)
		if(usr.check_perk("Expert Hunter" && "Master Gatherer"))
			for(var/obj/item/material/leather/b in usr.contents)
				b.amount+=18
			use()
			usr<<output("You find a behemoth in your trap, and get manage to expertly skin 18 pieces of leather.","oocout")
			usr<<output("You find a behemoth in your trap, and get manage to expertly skin 18 pieces of leather.","alert")
		else if(usr.check_perk("Expert Hunter" || "Master Gatherer"))
			for(var/obj/item/material/leather/b in usr.contents)
				b.amount+=12
			use()
			usr<<output("You find a behemoth in your trap, and get manage to skin 12 pieces of leather.","oocout")
			usr<<output("You find a behemoth in your trap, and get manage to skin 12 pieces of leather.","alert")
		else
			for(var/obj/item/material/leather/b in usr.contents)
				b.amount+=6
			use()
			usr<<output("You find a behemoth in your trap, and get manage to skin 6 pieces of leather.","oocout")
			usr<<output("You find a behemoth in your trap, and get manage to skin 6 pieces of leather.","alert")
	if(roll>80&&roll<91)
		if(usr.check_perk("Expert Hunter" && "Master Gatherer"))
			for(var/obj/item/material/wool/b in usr.contents)
				b.amount+=18
			use()
			usr<<output("You find a mutant sheep in your trap, and get manage to expertly shave 18 pieces of wool.","oocout")
			usr<<output("You find a mutant sheep in your trap, and get manage to expertly shave 18 pieces of wool.","alert")
		else if(usr.check_perk("Expert Hunter" || "Master Gatherer"))
			for(var/obj/item/material/wool/b in usr.contents)
				b.amount+=12
			use()
			usr<<output("You find a mutant sheep in your trap, and get manage to shave 12 pieces of wool.","oocout")
			usr<<output("You find a mutant sheep in your trap, and get manage to shave 12 pieces of wool.","alert")
		else
			for(var/obj/item/material/wool/b in usr.contents)
				b.amount+=6
			use()
			usr<<output("You find a mutant sheep in your trap, and get manage to shave 6 pieces of wool.","oocout")
			usr<<output("You find a mutant sheep in your trap, and get manage to shave 6 pieces of wool.","alert")
	if(roll>90)
		if(usr.check_perk("Expert Hunter" && "Master Gatherer"))
			for(var/obj/item/material/leather/b in usr.contents)
				b.amount+=45
			use()
			usr<<output("You find a shoat in your trap, and get manage to expertly skin 30 pieces of leather.","oocout")
			usr<<output("You find a shoat in your trap, and get manage to expertly skin 30 pieces of leather.","alert")
		else if(usr.check_perk("Expert Hunter" || "Master Gatherer"))
			for(var/obj/item/material/leather/b in usr.contents)
				b.amount+=30
			use()
			usr<<output("You find a shoat in your trap, and get manage to skin 15 pieces of leather.","oocout")
			usr<<output("You find a shoat in your trap, and get manage to skin 15 pieces of leather.","alert")
		else
			for(var/obj/item/material/leather/b in usr.contents)
				b.amount+=15
			use()
			usr<<output("You find a shoat in your trap, and get manage to skin 15 pieces of leather.","oocout")
			usr<<output("You find a shoat in your trap, and get manage to skin 15 pieces of leather.","alert")
	for(var/obj/item/material/wood/c in usr.contents)
		if(usr.check_perk("Nothing Wasted"))
			c.amount+=4
			usr<<output("You also find 3 Wood...Nothing Wasted earned you 1 more.","oocout")
			usr<<output("You also find 3 Wood...Nothing Wasted earned you 1 more.","alert")
		else
			c.amount+=3
			usr<<output("You also find 3 wood.","oocout")
			usr<<output("You also find 3 wood.","alert")
	UpdateCraft(usr)
	usr.minednodes+=1
	log_action("GATHER: [key_name(usr)] mined [src] [audit_coord(src)]")
