
/obj
	var/craftingmaterialtrue=0

/obj/item/material
	craftable=1
	craftingmaterialtrue=1
	price=1
	amount=0
	weight=0
	New(loc, amt)
		if(!isnull(amt))
			src.amount = amt
	Click()
		if(src.instore)
			switch(alert(usr,"[src.desc] Cost:[src.shopprice]",,"Buy","Cancel"))
				if("Buy")
					var/amocho=input("How many?") as num|null
					if(isnull(amocho) || amocho < 0)
						return
					var/adjprice=(amocho*src.shopprice)
					if(usr.money>=adjprice)
						usr.money-=adjprice
						for(var/obj/item/i in usr.contents)
							if(i.name==src.name)
								i.amount+=amocho
								usr<<output("You purchased [amocho] [src.name]/s","oocout")
								return
						usr<<output("You purchased [amocho] [src.name]/s","oocout")
					else
						alert(usr,"You don't enough for that many.")
						return
				if("Cancel")
					return
		if(istype(loc, /obj/playershops/shoptable))
			winset(usr,"playershop.selected","text=\"Selected: [src.name]\"")
			winset(usr,"playershop.desc","text=\"[src.desc]\"")
			winset(usr,"playershop.lore","text=\"[src.lore]\"")
			winset(usr,"playershop.enchant","text=\"[src.enchantment]\"")
			return
		if(src in usr.contents)
			return
		var/Transfer=src.amount
		for(var/obj/item/material/a in usr.contents)
			if(a.name==src.name)
				a.amount+=Transfer
				log_action("[usr] picked up [Transfer] of [src]")
				UpdateCraft(usr)
				del src
