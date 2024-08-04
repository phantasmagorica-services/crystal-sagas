/obj/resource_node/foraging
	name="Herb Node"
	icon = 'Icons/Nodes.dmi'
	icon_state = "Herb"
	icon_state_empty = "Sprout"
	icon_state_full = "Herb"

/obj/resource_node/foraging/Click()
	var/mob/user = usr
	if(!(usr in view(1,src)))
		return
	if(!can_harvest(user, FALSE))
		return
	if(!user.check_perk(/obj/perk/Gathering/Gatherer/Gatherer1))
		alert("You need to learn how to pick the proper herbs first.")
		return
	var/roll
	roll=rand(1,100)
	if(usr.check_perk("Seasoned Gatherer" && "Master of the Land"))
		roll+=20
	else if(usr.check_perk("Seasoned Gatherer" || "Master of the Land"))
		roll+=10
	else
		roll+=0
	if(roll>1&&roll<21)
		if(usr.check_perk("Expert Gatherer" && "Master Gatherer"))
			for(var/obj/item/material/herbs/gysahl_greens/b in usr.contents)
				b.amount+=3
			use()
			usr<<output("You have expertly picked 3 bunches of Gysahl Greens","oocout")
		else if(usr.check_perk("Expert Gatherer" || "Master Gatherer"))
			for(var/obj/item/material/herbs/gysahl_greens/b in usr.contents)
				b.amount+=2
			use()
			usr<<output("You have picked 2 bunch of Gysahl Greens","oocout")
		else
			for(var/obj/item/material/herbs/gysahl_greens/b in usr.contents)
				b.amount+=1
			use()
			usr<<output("You have picked 1 bunch of Gysahl Greens","oocout")
	if(roll>20&&roll<29)
		if(usr.check_perk("Expert Gatherer" && "Master Gatherer"))
			for(var/obj/item/material/herbs/sharug_greens/b in usr.contents)
				b.amount+=3
			use()
			usr<<output("You have expertly picked 3 bunches of Sharug Greens","oocout")
		else if(usr.check_perk("Expert Gatherer" || "Master Gatherer"))
			for(var/obj/item/material/herbs/sharug_greens/b in usr.contents)
				b.amount+=2
			use()
			usr<<output("You have picked 2 bunch of Sharug Greens","oocout")
		else
			for(var/obj/item/material/herbs/sharug_greens/b in usr.contents)
				b.amount+=1
			use()
			usr<<output("You have picked 1 bunch of Sharug Greens","oocout")
	if(roll>28&&roll<36)
		if(usr.check_perk("Expert Gatherer" && "Master Gatherer"))
			for(var/obj/item/material/herbs/azouph_greens/b in usr.contents)
				b.amount+=3
			use()
			usr<<output("You have expertly picked 3 bunches of Azouph Greens","oocout")
		else if(usr.check_perk("Expert Gatherer" || "Master Gatherer"))
			for(var/obj/item/material/herbs/azouph_greens/b in usr.contents)
				b.amount+=2
			use()
			usr<<output("You have picked 2 bunch of Azouph Greens","oocout")
		else
			for(var/obj/item/material/herbs/azouph_greens/b in usr.contents)
				b.amount+=1
			use()
			usr<<output("You have picked 1 bunch of Azouph Greens","oocout")
	if(roll>35&&roll<41)
		if(usr.check_perk("Expert Gatherer" && "Master Gatherer"))
			for(var/obj/item/material/herbs/sandorian_carrots/b in usr.contents)
				b.amount+=3
			use()
			usr<<output("You have expertly picked 3 bunches of Sandorian Carrots","oocout")
		else if(usr.check_perk("Expert Gatherer" || "Master Gatherer"))
			for(var/obj/item/material/herbs/sandorian_carrots/b in usr.contents)
				b.amount+=2
			use()
			usr<<output("You have picked 2 bunch of Sandorian Carrots","oocout")
		else
			for(var/obj/item/material/herbs/sandorian_carrots/b in usr.contents)
				b.amount+=1
			use()
			usr<<output("You have picked 1 bunch of Sandorian Carrots","oocout")
	if(roll>40&&roll<49)
		if(usr.check_perk("Expert Gatherer" && "Master Gatherer"))
			for(var/obj/item/material/herbs/vomp_carrots/b in usr.contents)
				b.amount+=3
			use()
			usr<<output("You have expertly picked 3 bunches of Vomp Carrots","oocout")
		else if(usr.check_perk("Expert Gatherer" || "Master Gatherer"))
			for(var/obj/item/material/herbs/vomp_carrots/b in usr.contents)
				b.amount+=2
			use()
			usr<<output("You have picked 2 bunch of Vomp Carrots","oocout")
		else
			for(var/obj/item/material/herbs/vomp_carrots/b in usr.contents)
				b.amount+=1
			use()
			usr<<output("You have picked 1 bunch of Vomp Carrots","oocout")
	if(roll>48&&roll<56)
		if(usr.check_perk("Expert Gatherer" && "Master Gatherer"))
			for(var/obj/item/material/herbs/zegham_carrots/b in usr.contents)
				b.amount+=3
			use()
			usr<<output("You have expertly picked 3 bunches of Zegham Carrots","oocout")
		else if(usr.check_perk("Expert Gatherer" || "Master Gatherer"))
			for(var/obj/item/material/herbs/zegham_carrots/b in usr.contents)
				b.amount+=2
			use()
			usr<<output("You have picked 2 bunch of Zegham Carrots","oocout")
		else
			for(var/obj/item/material/herbs/zegham_carrots/b in usr.contents)
				b.amount+=1
			use()
			usr<<output("You have picked 1 bunch of Zegham Carrots","oocout")
	if(roll>55&&roll<61)
		if(usr.check_perk("Expert Gatherer" && "Master Gatherer"))
			for(var/obj/item/material/herbs/gausebit_grass/b in usr.contents)
				b.amount+=3
			use()
			usr<<output("You have expertly picked 3 bunches of Gause bit Grass","oocout")
		else if(usr.check_perk("Expert Gatherer" || "Master Gatherer"))
			for(var/obj/item/material/herbs/gausebit_grass/b in usr.contents)
				b.amount+=2
			use()
			usr<<output("You have picked 2 bunch of Gause bit Grass","oocout")
		else
			for(var/obj/item/material/herbs/gausebit_grass/b in usr.contents)
				b.amount+=1
			use()
			usr<<output("You have picked 1 bunch of Gause bit Grass","oocout")
	if(roll>60&&roll<69)
		if(usr.check_perk("Expert Gatherer" && "Master Gatherer"))
			for(var/obj/item/material/herbs/garidav_wildgrass/b in usr.contents)
				b.amount+=3
			use()
			usr<<output("You have expertly picked 3 bunches of Garidav Wild Grass","oocout")
		else if(usr.check_perk("Expert Gatherer" || "Master Gatherer"))
			for(var/obj/item/material/herbs/garidav_wildgrass/b in usr.contents)
				b.amount+=2
			use()
			usr<<output("You have picked 2 bunch of Garidav Wild Grass","oocout")
		else
			for(var/obj/item/material/herbs/garidav_wildgrass/b in usr.contents)
				b.amount+=1
			use()
			usr<<output("You have picked 1 bunch of Garidav Wild Grass","oocout")
	if(roll>61&&roll<71)
		if(usr.check_perk("Expert Gatherer" && "Master Gatherer"))
			for(var/obj/item/material/herbs/topkekko_wildgrass/b in usr.contents)
				b.amount+=3
			use()
			usr<<output("You have expertly picked 3 bunches of Topkekko Wild Grass","oocout")
		else if(usr.check_perk("Expert Gatherer" || "Master Gatherer"))
			for(var/obj/item/material/herbs/topkekko_wildgrass/b in usr.contents)
				b.amount+=2
			use()
			usr<<output("You have picked 2 bunch of Topkekko Wild Grass","oocout")
		else
			for(var/obj/item/material/herbs/topkekko_wildgrass/b in usr.contents)
				b.amount+=1
			use()
			usr<<output("You have picked 1 bunch of Topkekko Wild Grass","oocout")
	if(roll>70&&roll<76)
		if(usr.check_perk("Expert Gatherer" && "Master Gatherer"))
			for(var/obj/item/material/AetherPowder/b in usr.contents)
				b.amount+=3
			use()
			usr<<output("You have picked 3 pinches of Aether Powder","oocout")
		else if(usr.check_perk("Expert Gatherer" || "Master Gatherer"))
			for(var/obj/item/material/AetherPowder/b in usr.contents)
				b.amount+=2
			use()
			usr<<output("You have picked 2 pinches of Aether Powder","oocout")
		else
			for(var/obj/item/material/AetherPowder/b in usr.contents)
				b.amount+=1
			use()
			usr<<output("You have picked 1 pinch of Aether Powder","oocout")
	if(roll>75&&roll<81)
		if(usr.check_perk("Expert Gatherer" && "Master Gatherer"))
			for(var/obj/item/material/gigantoad_slime/b in usr.contents)
				b.amount+=3
			use()
			usr<<output("You have picked 3 viles of Gigan Toad Slime","oocout")
		else if(usr.check_perk("Expert Gatherer" || "Master Gatherer"))
			for(var/obj/item/material/gigantoad_slime/b in usr.contents)
				b.amount+=2
			use()
			usr<<output("You have picked up 2 vles of Gigan Toad Slime","oocout")
		else
			for(var/obj/item/material/gigantoad_slime/b in usr.contents)
				b.amount+=1
			use()
			usr<<output("You have picked 1 vile of Gigan Toad Slime","oocout")
	if(roll>80&&roll<86)
		if(usr.check_perk("Expert Gatherer" && "Master Gatherer"))
			for(var/obj/item/material/pixe_sand/b in usr.contents)
				b.amount+=3
			use()
			usr<<output("You have picked 3 pinches of Pixie Sand","oocout")
		else if(usr.check_perk("Expert Gatherer" || "Master Gatherer"))
			for(var/obj/item/material/pixe_sand/b in usr.contents)
				b.amount+=2
			use()
			usr<<output("You have picked 2 pinches of Pixie Sand","oocout")
		else
			for(var/obj/item/material/pixe_sand/b in usr.contents)
				b.amount+=1
			use()
			usr<<output("You have picked 1 pinch of Pixie Sand","oocout")
	if(roll>85&&roll<96)
		if(usr.check_perk("Expert Gatherer" && "Master Gatherer"))
			for(var/obj/item/material/coeurl_whsker/b in usr.contents)
				b.amount+=3
			use()
			usr<<output("You have picked 3 Coeurl Whiskers","oocout")
		else if(usr.check_perk("Expert Gatherer" || "Master Gatherer"))
			for(var/obj/item/material/coeurl_whsker/b in usr.contents)
				b.amount+=2
			use()
			usr<<output("You have picked 2 Coeurl Whiskers","oocout")
		else
			for(var/obj/item/material/coeurl_whsker/b in usr.contents)
				b.amount+=1
			use()
			usr<<output("You have picked 1 Coeurl Whsker","oocout")
	if(roll>96)
		if(usr.check_perk("Expert Gatherer" && "Master Gatherer"))
			for(var/obj/item/material/EtherPowder/b in usr.contents)
				b.amount+=3
			use()
			usr<<output("You have picked 3 pinches of Ether Powder","oocout")
		else if(usr.check_perk("Expert Gatherer" || "Master Gatherer"))
			for(var/obj/item/material/EtherPowder/b in usr.contents)
				b.amount+=2
			use()
			usr<<output("You have picked 2 pinches of Ether Powder","oocout")
		else
			for(var/obj/item/material/EtherPowder/b in usr.contents)
				b.amount+=1
			use()
			usr<<output("You have picked 1 pinch of Ether Powder","oocout")
	for(var/obj/item/material/wood/c in usr.contents)
		if(usr.check_perk("Nothing Wasted"))
			c.amount+=6
			usr<<output("You also find 5 Wood...Nothing Wasted earned you 1 more.","oocout")
			usr<<output("You also find 5 Wood...Nothing Wasted earned you 1 more.","alert")
		else
			c.amount+=5
			usr<<output("You also find 5 wood.","oocout")
			usr<<output("You also find 5 wood.","alert")
	UpdateCraft(usr)
	usr.minednodes+=1
	log_action("GATHER: [key_name(usr)] mined [src] [audit_coord(src)]")
