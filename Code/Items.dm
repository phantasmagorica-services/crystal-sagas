obj/item/var
	weight
	selected
	usable
	equipable
	equipped
	usetext
	forsale=0
	cat
	cprice=0
	nprice
	craftable
	price
	rank
	weapon
	range1
	range2
	adddam
	addhit
	Materia=0
	altrange1
	altrange2
	damsource
	altdamsource
	equiptype
	weapontype
	instorage=0
	range
	critrange=20
	enchantment
	lore
	lored=0
	materials
	enchanted=0
	cusprice
	instore=0
	shopprice=0


obj/Tech/var
	weight
	selected
	usable
	equipable
	equipped
	usetext
	forsale=0
	cat
	cprice=0
	nprice
	craftable
	price
	rank
	weapon
	range1
	range2
	adddam
	addhit
	altrange1
	altrange2
	damsource
	altdamsource
	equiptype
	weapontype
	instorage=0
	range
	critrange=20
	enchantment

	materials
	ngyshal
	nsharug
	nazouph
	nsandorian
	nvomp
	nzegham
	ngausebit
	ngaridav
	ntokopekko
	nbronze
	niron
	nsteel
	nmythril
	nadamantine
	nplatinum
	ngold
	nsilver
	nrawmako
	netherpowder
	naetherpowder
	nleather
	nwool
	nwhitegem
	nblackgem
	nespersoul
	nthundergem
	nfiregem
	nwatergem
	nbiogem
	nicegem
	nwindgem
	nholygem
	ndarkgem
	nbombcore
	ndragonscale
	nflyingeye
	nflyingwing
	ntonknife
	ngigantoadslime
	nzuufeather
	npixiesand
	ncoeurlwhisker
	nsahauginscale
	ndiamond

obj
	item
		var/stockgem=0
		Click()
			if(istype(loc, /obj/playershops/shoptable))
				winset(usr,"playershop.selected","text=\"Selected: [src.name]\"")
				winset(usr,"playershop.desc","text=\"[src.desc]\"")
				winset(usr,"playershop.enchant","text=\"[src.enchantment]\"")
				winset(usr,"playershop.lore","text=\"[src.lore]\"")
				return
			if(src.bolted==1)
				return
			if(src in usr.contents)
				return
			if(src.craftingmaterialtrue==1)
				var/Materiallode=src.name
				var/Transfer=src.amount
				if(Materiallode in usr.contents)
					for(var/obj/item/material/a in usr.contents)
						if(a.name==src.name)
							a.amount+=Transfer
							UpdateCraft(usr)
							log_action("PICKUP: [key_name(usr)] picked up [Transfer] of [src]")
							view(usr) << output("[usr.name] has picked up [src]!","icout")
							del src
						UpdateCraft(usr)
				else
					usr.contents+=src
					UpdateCraft(usr)
				log_action("PICKUP: [key_name(usr)] picked up [src]")
				view(usr) << output("[usr.name] has picked up [src]!","icout")
			if(src.instorage==1)
				var/obj/storage/s=usr.storagelook
				if(src.amount>0)
					var/amo=input("How many do you wish to take?") as num
					if(amo>src.amount)
						alert("You can't take that many")
					else if(amo==src.amount)
						for(var/obj/item/o in usr.contents)
							if(o.name==src.name)
								usr.carryweight+=src.weight+=amo
								o.amount+=amo
								s.slots--
								usr.RefreshStorage()
								log_action("PICKUP: [key_name(usr)] picked up [amo] of [src] at [audit_coord(src)]")
								view(usr) << output("[usr.name] has picked up [amo] of [src]!","icout")
								del(src)
								return
						usr.carryweight+=src.weight*src.amount
						src.instorage=0
						log_action("PICKUP: [key_name(usr)] picked up [amo] of [src] at [audit_coord(src)]")
						src.Move(usr)
						s.slots--
						usr.UpdateCraft()
						view(usr) << output("[usr.name] has picked up [amo] of [src]!","icout")
					else if(amo<src.amount)
						for(var/obj/item/o in usr.contents)
							if(o.name==src.name)
								usr.carryweight+=src.weight+=amo
								o.amount+=amo
								src.amount-=amo
								usr.RefreshStorage()
								return
						usr.carryweight+=src.weight*src.amount
						var/obj/item/o=copyatom(src)
						o.instorage=0
						usr.contents+=o
						UpdateCraft(usr)
						log_action("PICKUP: [key_name(usr)] picked up [amo] of [src] at [audit_coord(src)]")
						view(usr) << output("[usr.name] has picked up [amo] of [src]!","icout")
				else
					src.instorage=0
					s.slots--
					log_action("PICKUP: [key_name(usr)] picked up [src] at [audit_coord(src)]")
					src.Move(usr)
				usr.RefreshStorage()
				UpdateCraft(usr)
				view(usr) << output("[usr.name] has picked up [src]!","icout")
			if(src.instore)
				switch(alert(usr,"[src.desc] Cost:[src.shopprice]",,"Buy","Cancel"))
					if("Buy")
						if(src.amount>=1)
							var/amocho=input("How many?") as num|null
							if(isnull(amocho))
								return
							if(amocho<0)
								alert(usr,"You need a positive number here.")
							var/adjprice=(amocho*src.shopprice)
							if(usr.money>=adjprice)
								usr.money-=adjprice
								log_action("BUY: [key_name(usr)] [audit_coord(usr)] bought [amocho] of [src] for [adjprice] from a NPC vendor")
								for(var/obj/item/stock/Stockgem/i in usr.contents)
									if(i.name==src.name)
										i.stock+=amocho
										usr<<output("You purchased [amocho] [src.name]/s","oocout")
										return
								for(var/obj/item/i in usr.contents)
									if(i.name==src.name)
										i.amount+=amocho
										usr<<output("You purchased [amocho] [src.name]/s","oocout")
										return
								var/obj/item/i=copyatom(src)
								i.amount=amocho
								i.instore=0
								usr.contents+=i
								usr<<output("You purchased [amocho] [src.name]/s","oocout")
							else
								alert(usr,"You don't enough for that many.")
								return
						else
							if(usr.money>=src.shopprice)
								usr.money-=src.shopprice
								var/obj/item/i=copyatom(src)
								i.instore=0
								usr.contents+=i
								log_action("BUY: [key_name(usr)] [audit_coord(usr)] bought [src] for [shopprice] from a NPC vendor")
								usr<<output("You purchased [src.name]","oocout")

							else
								alert(usr,"You don't have enough for that")
								return
					if("Cancel")
						return
			else
				if(src.bolted==1)
					return
				log_action("PICKUP: [key_name(usr)] picked up [src] at [audit_coord(src)]")
				view(usr) << output("[usr.name] has picked up [src.name]!","icout")
				usr.contents+=src
				usr.Refreshinventoryscreen()


mob
	proc
		FlashWeapon(var/obj/item/a, var/mob/m)
			var/description ={"<font color=#EC2323>[m.name] has flashed a weapon: <a href="byond://?src=\ref[usr]&action2=lookwep&value=\ref[a]"><font color=#FFFFFF>[a]</a>!!"}
			if(a in m.contents)
				switch(alert("[a.desc] (Rank:[a.rank])","[a.name]","Reveal","Cancel"))
					if("Reveal")
						view() << output("[description]","icout")
					if("Cancel")
						return
mob
	proc
		DisplayMateria(var/obj/item/Materia/a, var/mob/m)
			if(m.materia1==a || m.materia2==a || m.materia3==a)
				if(a in usr.contents)
					var/players={"<font color=#60F560>[m.name] has flashed a Materia: <a href="byond://?src=\ref[usr]&action4=lookmat&value=\ref[a]"><font color=#FFFFFF>[a]</a>!!"}
					switch(alert(m,"[a.desc] (Rank:[a.rank])","[a.name]","Reveal","Cancel"))
						if("Reveal")
							view() << output("[players]","icout")
						if("Cancel")
							return
				else
					alert(usr,"You can only display Materia you have equipped to one of your three Materia slots.")
					return

mob
	verb
		Display()
			set hidden=1
			for(var/obj/item/o in usr.contents)
				if(o.selected)
					if(o.weapon==1)
						FlashWeapon(src,usr)
					if(o.Materia==1)
						DisplayMateria(src,usr)







proc
	Checkdamtype(t as text,var/mob/m)
		var/result
		if(t=="str")
			result=m.strmod
		if(t=="dex")
			result=m.dexmod
		if(t=="con")
			result=m.conmod
		if(t=="int")
			result=m.intmod
		if(t=="wis")
			result=m.wismod
		if(t=="cha")
			result=m.chamod
		return result


obj/item
	Weapon
		var/players
		verb
			Flash()
				if(src.equiptype=="accessory")
				else if(src.equipped!=1)
					alert(usr,"You cannot flash a piece of equipment that isn't equipped!")
					return
				players ={"<font color=#EC2323>[usr.name] has flashed a piece of equipment: <a href="byond://?src=\ref[usr]&action2=lookwep&value=\ref[src]"><font color=#FFFFFF>[src]</a>!!"}
				if(src in usr.contents)
					switch(alert("[src.desc] (Rank:[src.rank])","[src.name]","Reveal","Cancel"))
						if("Reveal")
							view() << output("[players]","icout")
						if("Cancel")
							return

			Attack()
				var/aoresult
				var/aresult
				var/amod
				var/doresult
				var/dmod
				var/dresult
				var/critdam
				var/truecrit=src.critrange-usr.critmod
				if(src.equipped!=1)
					alert(usr,"You cannot attack with a weapon that isn't equipped!")
					return
				if(src.jewelery==1)
					return
				if(src.armor==1)
					return
				aoresult=rand(1,20)
				amod=Checkdamtype(src.damsource,usr)
				if(src.typing=="magical")
					aresult=aoresult+src.addhit+usr.rankbonus+usr.mab+amod
					aresult += usr.mabadd
				else
					aresult=aoresult+src.addhit+usr.rankbonus+usr.pab+amod
					aresult += usr.pabadd
				doresult=rand(src.range1,src.range2)
				dmod=Checkdamtype(src.damsource,usr)
				if(src.typing=="magical")
					dresult=doresult+src.adddam+usr.mdb+dmod
					dresult += usr.mdbadd
				else
					dresult=doresult+src.adddam+usr.pdb+dmod
					dresult += usr.pdbadd
				critdam=dresult+doresult
				if(aoresult>=truecrit)
					view()<<output("<font size=1><font color=[usr.textcolor]>[usr] <font color=white>rolled a <b><font color=#3CF82C>CRITICAL</b> <font color=white>attack roll, using their <font color=[usr.textcolor]>[src.name]<font color=white>! Result: <font color=#3CF82C><b>[aresult] to hit</b><font color=white>, dealing <b><font color=#FFA852>[critdam] damage</b><font color=white>, as an automatic hit!","icout")
				else
					view()<<output("<font size=1><font color=[usr.textcolor]>[usr] <font color=white>rolled an attack roll, using their <font color=[usr.textcolor]>[src.name]<font color=white>!  Result: <font color=#8EF5DE><b>[aresult] to hit</b><font color=white>, dealing <b><font color=#FFA852>[dresult] damage</b><font color=white> if successful!<br>Tile Range:[src.range]","output1")
					view()<<output("<font size=1><font color=[usr.textcolor]>[usr] <font color=white>rolled an attack roll, using their <font color=[usr.textcolor]>[src.name]<font color=white>! Result: <font color=#8EF5DE><b>[aresult] to hit</b><font color=white>, dealing <b><font color=#FFA852>[dresult] damage</b><font color=white> if successful!<br>Tile Range:[src.range]","icout")

	antinquecoin
		icon = 'Coin.dmi'
		dir = NORTH
		desc = "Bruh"
		weight=0.1
obj
	item
		var/chemistry
		var/chemistused=0
		Chemist
			chemistry=1
			verb
				Use()
					if(src in usr.contents)
						switch(alert("[src.desc] (Rank:[src.rank])","[src.name] | Using this will consume it.","Reveal","Cancel"))
							if("Reveal")
								view() << output("[usr.name] used [src.name]:[src.desc]","icout")
								src.amount-=1
								if(src.amount<=0)
									del(src)
							if("Cancel")
								return
			Potion
				icon='Icons/Items/Potion.dmi'
				rank="D"
				usable=1
				amount=1
				desc = " Restores 55 HP."
				cat="Chemist"
				materials = "Gyshal Green x1, Vomp Carrot x1"
			HiPotion
				name="Hi-Potion"
				craftable=1
				icon='Icons/Items/hipotion.dmi'
				rank="C"
				usable=1
				amount=1
				desc = " Restores 85 HP."
				cat="Chemist"
				materials = "Sharug Green x4, San d'Orian Carrots x2"
			XPotion
				name="X-Potion"
				craftable=1
				icon='Icons/Items/Xpotion.dmi'
				rank="C"
				usable=1
				amount=1
				desc = " Restores 200 HP"
				cat="Chemist"
				materials = " Garidav Wildgrass x6, San d'Orian Carrots x2, Vomp Carrots x1, White Gem"
			Ether
				name="Ether"
				craftable=1
				icon='Potion.dmi'
				rank="C"
				usable=1
				amount=1
				desc = "Restores 35 MP and Stamina."
				cat="Chemist"
				materials = "Sharug Greens x2, Aether Powder x2"
			MaxEther
				name="Max Ether"
				craftable=1
				icon='Potion.dmi'
				rank="C"
				usable=1
				amount=1
				desc = "Restores 60 MP and Stamina."
				cat="Chemist"
				materials = "Sharug Greens x5, Garidav Wildgrass x1, Aether Powder x3"
			Poison
				name="Poison"
				craftable=1
				icon='Potion.dmi'
				rank="C"
				usable=1
				amount=1
				desc = "Can be applied to a weapon. Once applied the next succesful attack on a living creature applies poison on a failed fortitude save. (DC:14)"
				usetext = "Can be applied to a weapon. Once applied the next succesful attack on a living creature applies poison on a failed fortitude save. (DC:14)"
				cat="Chemist"
				materials = "Gigantoad Slime x1, Bio gem x1"
			SilencePoison
				name="Silence Poison"
				craftable=1
				icon='Potion.dmi'
				rank="C"
				usable=1
				amount=1
				desc = "Can be applied to a weapon. Once applied the next succesful attack on a living creature applies silence on a failed fortitude save. (DC:14)"
				usetext = "Can be applied to a weapon. Once applied the next succesful attack on a living creature applies silence on a failed fortitude save. (DC:14)"
				cat="Chemist"
				materials = "Gigantoad Slime x1, Pixie Sand x1"
			BlindPoison
				name="Blind Poison"
				craftable=1
				icon='Potion.dmi'
				rank="C"
				usable=1
				amount=1
				desc = "Can be applied to a weapon. Once applied the next succesful attack on a living creature applies blind on a failed fortitude save. (DC:14)"
				usetext = "Can be applied to a weapon. Once applied the next succesful attack on a living creature applies blind on a failed fortitude save. (DC:14)"
				cat="Chemist"
				materials = "Gigantoad Slime x1, Flying Eye's Eye x1"
			FrogPoison
				name="Frog Poison"
				craftable=1
				icon='Potion.dmi'
				rank="C"
				usable=1
				amount=1
				desc = "Can be applied to a weapon. Once applied the next succesful attack on a living creature applies frog on a failed fortitude save. (DC:14)"
				usetext = "Can be applied to a weapon. Once applied the next succesful attack on a living creature applies frog on a failed fortitude save. (DC:14)"
				cat="Chemist"
				materials = "Gigantoad Slime x3"
			BerserkPoison
				name="Berserk Poison"
				craftable=1
				icon='Potion.dmi'
				rank="C"
				usable=1
				amount=1
				desc = "Can be applied to a weapon. Once applied the next succesful attack on a living creature applies berserk on a failed fortitude save. (DC:14)"
				usetext = "Can be applied to a weapon. Once applied the next succesful attack on a living creature applies berserk on a failed fortitude save. (DC:14)"
				cat="Chemist"
				materials = "Gigantoad Slime x2, Sahaugin Scale x1"
			Antidote
				name="Antidote"
				craftable=1
				icon='Potion.dmi'
				rank="C"
				usable=1
				amount=1
				desc = "Removes poison status effect when consumed"
				usetext = "Removes poison status effect when consumed"
				cat="Chemist"
				materials = "Gigantoad Slime x3"
			Echoherbs
				name="Echo Herbs"
				craftable=1
				icon='Potion.dmi'
				rank="C"
				usable=1
				amount=1
				desc = "Removes silence status effect when consumed"
				usetext = "Removes silence status effect when consumed"
				cat="Chemist"
				materials = "Gysahl Greens x2, Pixie Sand x1"
			Eyedrops
				name="Eye Drops"
				craftable=1
				icon='Potion.dmi'
				rank="C"
				usable=1
				amount=1
				desc = "Removes blind status effect when consumed"
				usetext = "Removes blind status effect when consumed"
				cat="Chemist"
				materials = "Gysahl Greens x2, Flying Eye's Eye x1"
			Maidenskiss
				name="Maiden's Kiss"
				craftable=1
				icon='Potion.dmi'
				rank="C"
				usable=1
				amount=1
				desc = "Removes frog status effect when consumed"
				usetext = "Removes frog status effect when consumed"
				cat="Chemist"
				materials = "Gysahl Greens x2, Gigantoad Slime x1"
			RegenOrb
				name="Regen Orb"
				craftable=1
				icon='Icons/Materia.dmi'
				icon_state="green"
				rank="C"
				usable=1
				amount=1
				desc = "Applies the Regen status when consumed."
				usetext = "Applies the Regen status when consumed."
				cat="Chemist"
				materials = "Gysahl Greens x2, Gigantoad Slime x1, White Gem x1."
			RefreshOrb
				name="Refresh Orb"
				craftable=1
				icon='Icons/Materia.dmi'
				icon_state="blue"
				rank="C"
				usable=1
				amount=1
				desc = "Applies the Refresh status when consumed."
				usetext = "Applies the Refresh status when consumed."
				cat="Chemist"
				materials = "Zegham Carrots x2, Gigantoad Slime x1, White Gem x1."
			Goldneedle
				name="Gold Needle"
				craftable=1
				icon='Potion.dmi'
				rank="C"
				usable=1
				amount=1
				desc = "Removes break status effect when consumed"
				usetext = "Removes break status effect when consumed"
				cat="Chemist"
				materials = "1x Coerul's Whisker, 1x, Gigantoad Slime, 1x Gold Ore"
			Tranquilizer
				name="Tranquilizer"
				craftable=1
				icon='Potion.dmi'
				rank="C"
				usable=1
				amount=1
				desc = "Removes berserk status effect when consumed"
				usetext = "Removes berserk status effect when consumed"
				cat="Chemist"
				materials = "Pixie Sand x1, Sahaugin Scale x1, Gigantoad Slime x1"
			Remedy
				name="Remedy"
				craftable=1
				icon='Potion.dmi'
				rank="C"
				usable=1
				amount=1
				desc = "Removes all negative status effects when consumed"
				usetext = "Removes all negative status effects when consumed"
				cat="Chemist"
				materials = "Gysahl Greens x5, Sahaugin Scale x1, Gigantoad Slime x1, Coeurl's Whisker x1, Gold Ore x1, Flying Eye's Eye x1, Pixie Sand x1, 1x Holy Gem."
			PhoenixDown
				name="Phoenix Down"
				craftable=1
				icon='Potion.dmi'
				rank="S"
				usable=1
				amount=1
				desc = "Is capable of reviving a character from death within 2 OOC Days of that death."
				usetext = "Phoenix Down: Removes all negative status effects when consumed"
				cat="Chemist"
				materials = "Phoenix Feather."
			ElixirofYouth
				name="Elixir of Youth"
				craftable=1
				icon='Potion.dmi'
				rank="S"
				usable=1
				amount=1
				desc = "Puts the consumer to the prime age of their life, makes them unaging, and makes them immortal."
				usetext = "Removes all negative status effects when consumed"
				cat="Chemist"
				materials = "Gysahl Greens x5, Sahaugin Scale x1, Gigantoad Slime x1, Coeurl's Whisker x1, Gold Ore x1, Flying Eye's Eye x1, Pixie Sand x1, 1x Holy Gem."
obj
	item
		Key
			var/keyid
			icon='Icons/key.dmi'
			weight=0.1

obj/perk/itemperk
	Zantetsuken
		desc="Every time an attack made with this weapon is succesful before damage is rolled the target must make a fortitude saving throw. (DC:14) on a failed saving throw the attack becomes an automatic crit, and on a nat one the attack is instantly fatal."

obj/item/customitem
	var
		Istr = 0
		Idex=0
		Icon=0
		Iint=0
		Iwis=0
		Icha=0
		Irflx=0
		Iwil=0
		Ifor=0
		list/perks=new
		CP
		finished = 1
	equipable = 1

/*mob/verb
	Opencustomitem()
		winset(usr,"Customitem","is-visible=true")
	Createitem()
		if(usr.getPerk("Weaponsmithing"))
			usr.makingitem = 1
			var/obj/item/customitem/o = new /obj/item/customitem
			var/row
			o.CP = 10
			winset(usr,"Customitem.Itemicon","image=[o.icon]")
			winset(usr,"Customitem.CP","text=\"[o.CP]\"")
			winset(usr,"Customitem.Strplus","is-visible=true")
			winset(usr,"Customitem.Addperk","is-visible=true")
			winset(usr,"Customitem.Finish","is-visible=true")
			winset(usr,"Customitem.Str","text=\"[o.Istr]\"")
			winset(usr,"Customize.Customizegrid","cells=0x0")
			for(var/A in o.perks)
				row++
				src << output(A,"Itemperks:1,[row]")
			o.finished = 0
			usr.contents+=o
		else
			alert("Sorry, you don't have any perks to make items with.")
	Closecustomitem()
		usr.makingitem = 0
		winset(usr,"Customitem.Strplus","is-visible=false")
		winset(usr,"Customitem.Addperk","is-visible=false")
		winset(usr,"Customitem.Finish","is-visible=false")
		for(var/obj/item/customitem/o in usr.contents)
			if(!o.finished)
				del(o)
	Itemaddperk()
		var/list/choices=new
		if(!usr.makingitem)
			return
		else
			for(var/obj/perk/p in usr.contents)
				choices+=p
			var/newperk = input("Please Select a perk to add.") in choices
			for(var/obj/item/customitem/o in usr.contents)
				if(!o.finished)
					o.perks+=newperk
					var/row
					for(var/A in o.perks)
						row++
						src << output(A,"Itemperks:1,[row]")
	Itemstrplus()
		if(!usr.makingitem)
			return
		else
			for(var/obj/item/customitem/o in usr.contents)
				if(!o.finished)
					if(o.CP <1)
						alert("You don't have enough CP")
						return
					else
						o.CP--
						o.Istr++
						winset(usr,"Customitem.CP","text=\"[o.CP]\"")
						winset(usr,"Customitem.Str","text=\"[o.Istr]\"")
	Finishcustomitem()
		if(!usr.makingitem)
			return
		else
			usr.makingitem=0
			for(var/obj/item/customitem/o in usr.contents)
				if(!o.finished)
					o.finished=1
					winset(usr,"Customitem","is-visible=false")
*/

mob/proc/getPerk(var/path)
	for(var/obj/perk/P in contents)
		if(P.name == path) return 1
	return 0


obj
	var/bolted=0
	shoptable
		Savable=1
		layer=2
		icon='Shoptable.dmi'
		density=1
		var/obj/item/itemon
		var/storedmon
		var/samount
		Click()
			var/list/itemlist=new
			if(!itemon && owner==usr.name)
				if(storedmon>0)
					usr.money+=storedmon
					usr<<output("You collected [storedmon]","output1")
					storedmon=0
				for(var/obj/item/i in usr.contents)
					itemlist+=i
				itemon=input("Which item do you wish to put up for sale.") as null| anything in itemlist
				if(itemon==null)
					return
				itemon.price=input("How much do you want to sell this for?")as num
				if(itemon.amount>0)
					var/obj/item/N = new
					N.amount=input("How many do you wish to sell?")as num
					if(N.amount>itemon.amount)
						del(N)
						return
					else if(N.amount>itemon.amount)
						usr.contents-=itemon
						itemon.mouse_opacity=0
						itemon.loc=locate(src.x,src.y,src.z)
						del(N)
					else
						itemon.amount-=N.amount
						N.name = itemon.name
						N.icon = itemon.icon
						N.usetext = itemon.usetext
						N.desc = itemon.desc
						N.usable = itemon.usable
						N.weight=itemon.weight
						N.price=itemon.price
						N.loc=locate(src.x,src.y,src.z)
						itemon=N
				else
					usr.contents-=itemon
					itemon.mouse_opacity=0
					itemon.loc=locate(src.x,src.y,src.z)
			else if(itemon && owner==usr.name)
				switch(alert("What do you wish to do?",,"Remove Item","Adjust Price","Collect Money"))
					if("Remove Item")
						itemon.mouse_opacity=1
						usr.contents+=itemon
						itemon=null
						if(storedmon>0)
							usr.money+=storedmon
							storedmon=0
					if("Adjust Price")
						itemon.price=input("Current price [itemon.price]") as num
					if("Collect Money")
						if(storedmon)
							usr.money+=storedmon
							usr<<output("You collected [storedmon].","output1")
							storedmon=0
						else
							alert("There is no money stored. Wait for something to sell.")
			else if(itemon && owner!=usr)
				var/purchamount
				var/tprice
				switch(alert("A [itemon.name] is for sale for [itemon.price] Do you wish to purchase it?",,"Yes","No","More Info"))
					if("Yes")
						if(itemon.amount>0)
							purchamount=input("How many would you like to buy?") as num
							if(purchamount>itemon.amount)
								alert("There are not that many items for sale.")
								return
							else if(purchamount<=0)
								alert("You cannot buy zero or negative items!")
								return
							else
								tprice=itemon.price*purchamount
								if(usr.money<tprice)
									alert("You cannot afford this much.")
								else
									if(purchamount==itemon.amount)
										usr.contents+=itemon
										itemon=null
										usr.money-=tprice
										storedmon+=tprice
										return
									else
										var/obj/item/N=new
										N.name = itemon.name
										N.icon = itemon.icon
										N.usetext = itemon.usetext
										N.desc = itemon.desc
										N.usable = itemon.usable
										N.weight=itemon.weight
										N.amount=purchamount
										itemon.amount-=purchamount
										usr.contents+=N
										usr.money-=tprice
										storedmon+=tprice
										return
						else
							if(usr.money>=itemon.price)
								usr.money-=itemon.price
								storedmon+=itemon.price
								usr.contents+=itemon
								itemon=null
								return
							else
								alert("You do not have enough money.")
								return
					if("No")
						return

					if("More Info")
						alert("[itemon.desc]")

obj
	item
		Machinist
			ForceFieldRemote
				icon='Icons/Tech.dmi'
				icon_state="FFRemote"
				desc="Used to toggle Force Fields. You can input broad or specific passwords."
				verb/ToggleSeperate()
		//			var/Choice=alert(usr,"Choose password type.","","Broad","Specific","Cancel")
		//			switch(Choice)
					var/Passcheck=input("Input specific password.")as text
					for(var/obj/item/Machinist/ForceFieldEmitter/X in world)
						if(X.FieldPassword==Passcheck)
							if(X.Active)
								for(var/obj/Effects/ForceField/A in world)
									if(A.FieldPassword==Passcheck)
										del(A)
								X.Active=0
							else
								X.FFOn("Specific")
								X.Active=1
				verb/ToggleBroad()
					var/Passcheck=input("Input broad password.")as text
					for(var/obj/item/Machinist/ForceFieldEmitter/X in world)
						if(X.Password==Passcheck)
							if(X.Active)
								for(var/obj/Effects/ForceField/A in world)
									if(A.Password==Passcheck)
										del(A)
								X.Active=0
							else
								X.FFOn("Broad")
								X.Active=1
obj
	item
		Machinist
			ForceFieldEmitter
				Savable=1
				Click()
					for(var/obj/playershops/shoptable/shop in world)
						if(src in shop.contents)
							winset(usr,"playershop.desc","text=\"[src.desc]\"")
							return
					if(src in usr.contents)
						return
					var/Passcheck=input("Input password.")as text
					if(src.Password==Passcheck)
						if(src.Active==1)
							alert("You cannot pick up a Force Field while it's active!")
							return
						else
							alert("You may pick this up.")
							usr.contents+=src
					else
						alert("Incorrect password.")
						return
				var/Password
				var/Range=3
				var/Direction="North"
				var/FieldPassword
				var/FieldColor=rgb(0,0,0)
				var/Protection=0
				var/Active=0
				desc="A force field emitter. You can adjust the direction it will project a force field in a straight line, as well as the range, based on its level. You can also password lock them with two passwords: One as a broad password, and one as a specific to that field password."
				name="Force Field Emitter"
				icon='Tech.dmi'
				icon_state="FFE"
				Del()
					. = ..()
					src.FFOff("Specific")
				verb/FFColor()
					set src in oview(1)
					set name="Field Color"
					var/rred=input("How much red?") as num
					var/ggreen=input("How much green?") as num
					var/bblue=input("How much blue?") as num
					src.FieldColor=rgb(rred,ggreen,bblue)
				verb/SetPasswords()
					set src in oview(1)
					var/Choice=alert(usr,"Choose Option","","Broad Password","Field Password","Cancel")
					switch(Choice)
						if("Broad Password")
							if(src.Password)
								var/Passcheck=input("Input password to reset.")as text|null
								if(Passcheck==null||Passcheck!=src.Password)
									usr<<"Incorrect password."
									return
								else
									src.Password=null
									usr<<"Broad Password reset!"
							else
								src.Password=input("Input password.")as text|null
								if(src.Password!=null)
									usr<<"Password accepted. Broad Password is [src.Password]"
						if("Field Password")
							if(src.FieldPassword)
								var/Passcheck=input("Input emitter password to reset.")as text|null
								if(Passcheck==null||Passcheck!=src.FieldPassword)
									usr<<"Incorrect password."
									return
								else
									src.FieldPassword=null
									usr<<"Field Password reset!"
							else
								var/FieldPasswordCheck=input("Input emitter password.")as text|null
								if(FieldPasswordCheck!=null)
		/*							for(var/obj/Items/Tech/ForceFieldEmitter/X in world)
										if(X.FieldPassword==FieldPasswordCheck)
											usr<<"This password is already in use by another emitter. Field Passwords must be unique."
											return*/
									src.FieldPassword=FieldPasswordCheck
									usr<<"Password accepted. Emitter Password is [src.FieldPassword]"
				verb/Toggle()
					set src in oview(1)
					if(src.FieldPassword==null)
						usr<<"You must set a Field Password at minimum."
						return
					var/Choice=alert(usr,"Choose Option","","Broad Password","Field Password","Cancel")
					switch(Choice)
						if("Broad Password")
							var/Passcheck=input("Input the activation password.")
							if(Passcheck==src.Password)
								if(src.Active==0)
									src.FFOn()
									src.Active=1
								else if(src.Active==1)
									src.FFOff("Broad")
									src.Active=0
						if("Field Password")
							var/Passcheck=input("Input the specific field password.")
							if(Passcheck==src.FieldPassword)
								if(src.Active==0)
									src.FFOn()
									src.Active=1
								else if(src.Active==1)
									src.FFOff("Specific")
									src.Active=0
				verb/Settings()
					set src in oview(1)
					if(src.Password)
						var/Passcheck=input("Input the password to adjust settings.")
						if(Passcheck==src.Password)
							src.FFSettings()
					else if(src.FieldPassword)
						var/Passcheck=input("Input the specific field password to adjust settings.")
						if(Passcheck==src.FieldPassword)
							src.FFSettings()
					else
						src.FFSettings()

				proc/FFSettings()
					var/Choice=alert(usr,"Choose Option","","Range","Direction","Protection")
					switch(Choice)
						if("Range")
		//					var/RangeCalc=round((src.Lvl/10)+3)
							var/RangeCalc=8
							if(RangeCalc>8)
								RangeCalc=8
							src.Range=input("Input a range. Minimum 3, max [RangeCalc].")as num|null
							if(src.Range==null||src.Range<3)
								src.Range=3
							if(src.Range>=RangeCalc)
								src.Range=RangeCalc
						if("Direction")
							src.Direction=input("Pick Direction.") in list("North", "South", "East", "West")
						if("Protection")
							if(src.Protection==0)
								src.Protection=1
								usr<<"Emitter will surround itself in force fields."
							else if(src.Protection==1)
								src.Protection=0
								usr<<"Emitter will not surround itself in force fields."

				proc/FFOn()
		/*			var/HealthCalc=src.Lvl*src.Lvl*1000000
					var/EnduranceCalc=src.Lvl*20*/
					var/HealthCalc=50*50*1000000
					var/EnduranceCalc=50*20
					if(src.Protection==1)
						var/obj/Effects/ForceField/p1=new
						p1.x=src.x
						p1.y=src.y+1
						p1.z=src.z
						p1.Password=src.Password
						p1.FieldPassword=src.FieldPassword
						p1.icon+=src.FieldColor
						var/obj/Effects/ForceField/p2=new
						p2.x=src.x+1
						p2.y=src.y+1
						p2.z=src.z
						p2.Password=src.Password
						p2.FieldPassword=src.FieldPassword
						p2.icon+=src.FieldColor
						var/obj/Effects/ForceField/p3=new
						p3.x=src.x+1
						p3.y=src.y
						p3.z=src.z
						p3.Password=src.Password
						p3.FieldPassword=src.FieldPassword
						p3.icon+=src.FieldColor
						var/obj/Effects/ForceField/p4=new
						p4.x=src.x+1
						p4.y=src.y-1
						p4.z=src.z
						p4.Password=src.Password
						p4.FieldPassword=src.FieldPassword
						p4.icon+=src.FieldColor
						var/obj/Effects/ForceField/p5=new
						p5.x=src.x
						p5.y=src.y-1
						p5.z=src.z
						p5.Password=src.Password
						p5.FieldPassword=src.FieldPassword
						p5.icon+=src.FieldColor
						var/obj/Effects/ForceField/p6=new
						p6.x=src.x-1
						p6.y=src.y-1
						p6.z=src.z
						p6.Password=src.Password
						p6.FieldPassword=src.FieldPassword
						p6.icon+=src.FieldColor
						var/obj/Effects/ForceField/p7=new
						p7.x=src.x-1
						p7.y=src.y
						p7.z=src.z
						p7.Password=src.Password
						p7.FieldPassword=src.FieldPassword
						p7.icon+=src.FieldColor
						var/obj/Effects/ForceField/p8=new
						p8.x=src.x-1
						p8.y=src.y+1
						p8.z=src.z
						p8.Password=src.Password
						p8.FieldPassword=src.FieldPassword
						p8.icon+=src.FieldColor
					if(src.Direction=="North")
						if(src.Protection==0)
							var/obj/Effects/ForceField/n1=new
							n1.x=src.x
							n1.y=src.y+1
							n1.z=src.z
							n1.Password=src.Password
							n1.FieldPassword=src.FieldPassword
							n1.icon+=src.FieldColor
						var/obj/Effects/ForceField/n2=new
						n2.x=src.x
						n2.y=src.y+2
						n2.z=src.z
						n2.Password=src.Password
						n2.FieldPassword=src.FieldPassword
						n2.icon+=src.FieldColor
						n2.Health=HealthCalc
						n2.LogPEndurance=EnduranceCalc
						var/obj/Effects/ForceField/n3=new
						n3.x=src.x
						n3.y=src.y+3
						n3.z=src.z
						n3.Password=src.Password
						n3.FieldPassword=src.FieldPassword
						n3.icon+=src.FieldColor
						if(src.Range>=4)
							var/obj/Effects/ForceField/n4=new
							n4.x=src.x
							n4.y=src.y+4
							n4.z=src.z
							n4.Password=src.Password
							n4.FieldPassword=src.FieldPassword
							n4.icon+=src.FieldColor
						if(src.Range>=5)
							var/obj/Effects/ForceField/n5=new
							n5.x=src.x
							n5.y=src.y+5
							n5.z=src.z
							n5.Password=src.Password
							n5.FieldPassword=src.FieldPassword
							n5.icon+=src.FieldColor
						if(src.Range>=6)
							var/obj/Effects/ForceField/n6=new
							n6.x=src.x
							n6.y=src.y+6
							n6.z=src.z
							n6.Password=src.Password
							n6.FieldPassword=src.FieldPassword
							n6.icon+=src.FieldColor
						if(src.Range>=7)
							var/obj/Effects/ForceField/n7=new
							n7.x=src.x
							n7.y=src.y+7
							n7.z=src.z
							n7.Password=src.Password
							n7.FieldPassword=src.FieldPassword
							n7.icon+=src.FieldColor
						if(src.Range>=8)
							var/obj/Effects/ForceField/n8=new
							n8.x=src.x
							n8.y=src.y+8
							n8.z=src.z
							n8.Password=src.Password
							n8.FieldPassword=src.FieldPassword
							n8.icon+=src.FieldColor

					if(src.Direction=="East")
						if(src.Protection==0)
							var/obj/Effects/ForceField/e1=new
							e1.x=src.x+1
							e1.y=src.y
							e1.z=src.z
							e1.Password=src.Password
							e1.FieldPassword=src.FieldPassword
							e1.icon+=src.FieldColor
						var/obj/Effects/ForceField/e2=new
						e2.x=src.x+2
						e2.y=src.y
						e2.z=src.z
						e2.Password=src.Password
						e2.FieldPassword=src.FieldPassword
						e2.icon+=src.FieldColor
						e2.Health=HealthCalc
						e2.LogPEndurance=EnduranceCalc
						var/obj/Effects/ForceField/e3=new
						e3.x=src.x+3
						e3.y=src.y
						e3.z=src.z
						e3.Password=src.Password
						if(src.Range>=4)
							var/obj/Effects/ForceField/e4=new
							e4.x=src.x+4
							e4.y=src.y
							e4.z=src.z
							e4.Password=src.Password
							e4.FieldPassword=src.FieldPassword
							e4.icon+=src.FieldColor
						if(src.Range>=5)
							var/obj/Effects/ForceField/e5=new
							e5.x=src.x+5
							e5.y=src.y
							e5.z=src.z
							e5.Password=src.Password
							e5.FieldPassword=src.FieldPassword
							e5.icon+=src.FieldColor
						if(src.Range>=6)
							var/obj/Effects/ForceField/e6=new
							e6.x=src.x+6
							e6.y=src.y
							e6.z=src.z
							e6.Password=src.Password
							e6.FieldPassword=src.FieldPassword
							e6.icon+=src.FieldColor
						if(src.Range>=7)
							var/obj/Effects/ForceField/e7=new
							e7.x=src.x+7
							e7.y=src.y
							e7.z=src.z
							e7.Password=src.Password
							e7.FieldPassword=src.FieldPassword
							e7.icon+=src.FieldColor
						if(src.Range>=8)
							var/obj/Effects/ForceField/e8=new
							e8.x=src.x+8
							e8.y=src.y
							e8.z=src.z
							e8.Password=src.Password
							e8.FieldPassword=src.FieldPassword
							e8.icon+=src.FieldColor

					if(src.Direction=="South")
						if(src.Protection==0)
							var/obj/Effects/ForceField/s1=new
							s1.x=src.x
							s1.y=src.y-1
							s1.z=src.z
							s1.Password=src.Password
							s1.FieldPassword=src.FieldPassword
							s1.icon+=src.FieldColor
						var/obj/Effects/ForceField/s2=new
						s2.x=src.x
						s2.y=src.y-2
						s2.z=src.z
						s2.Password=src.Password
						s2.FieldPassword=src.FieldPassword
						s2.icon+=src.FieldColor
						s2.Health=HealthCalc
						s2.LogPEndurance=EnduranceCalc
						var/obj/Effects/ForceField/s3=new
						s3.x=src.x
						s3.y=src.y-3
						s3.z=src.z
						s3.Password=src.Password
						s3.FieldPassword=src.FieldPassword
						s3.icon+=src.FieldColor
						if(src.Range>=4)
							var/obj/Effects/ForceField/s4=new
							s4.x=src.x
							s4.y=src.y-4
							s4.z=src.z
							s4.Password=src.Password
							s4.FieldPassword=src.FieldPassword
							s4.icon+=src.FieldColor
						if(src.Range>=5)
							var/obj/Effects/ForceField/s5=new
							s5.x=src.x
							s5.y=src.y-5
							s5.z=src.z
							s5.Password=src.Password
							s5.FieldPassword=src.FieldPassword
							s5.icon+=src.FieldColor
						if(src.Range>=6)
							var/obj/Effects/ForceField/s6=new
							s6.x=src.x
							s6.y=src.y-6
							s6.z=src.z
							s6.Password=src.Password
							s6.FieldPassword=src.FieldPassword
							s6.icon+=src.FieldColor
						if(src.Range>=7)
							var/obj/Effects/ForceField/s7=new
							s7.x=src.x
							s7.y=src.y-7
							s7.z=src.z
							s7.Password=src.Password
							s7.FieldPassword=src.FieldPassword
							s7.icon+=src.FieldColor
						if(src.Range>=8)
							var/obj/Effects/ForceField/s8=new
							s8.x=src.x
							s8.y=src.y-8
							s8.z=src.z
							s8.Password=src.Password
							s8.FieldPassword=src.FieldPassword
							s8.icon+=src.FieldColor

					if(src.Direction=="West")
						if(src.Protection==0)
							var/obj/Effects/ForceField/w1=new
							w1.x=src.x-1
							w1.y=src.y
							w1.z=src.z
							w1.Password=src.Password
							w1.FieldPassword=src.FieldPassword
							w1.icon+=src.FieldColor
						var/obj/Effects/ForceField/w2=new
						w2.x=src.x-2
						w2.y=src.y
						w2.z=src.z
						w2.Password=src.Password
						w2.FieldPassword=src.FieldPassword
						w2.icon+=src.FieldColor
						var/obj/Effects/ForceField/w3=new
						w3.x=src.x-3
						w3.y=src.y
						w3.z=src.z
						w3.Password=src.Password
						w3.FieldPassword=src.FieldPassword
						w3.icon+=src.FieldColor
						if(src.Range>=4)
							var/obj/Effects/ForceField/w4=new
							w4.x=src.x-4
							w4.y=src.y
							w4.z=src.z
							w4.Password=src.Password
							w4.FieldPassword=src.FieldPassword
							w4.icon+=src.FieldColor
						if(src.Range>=5)
							var/obj/Effects/ForceField/w5=new
							w5.x=src.x-5
							w5.y=src.y
							w5.z=src.z
							w5.Password=src.Password
							w5.FieldPassword=src.FieldPassword
							w5.icon+=src.FieldColor
						if(src.Range>=6)
							var/obj/Effects/ForceField/w6=new
							w6.x=src.x-6
							w6.y=src.y
							w6.z=src.z
							w6.Password=src.Password
							w6.FieldPassword=src.FieldPassword
							w6.icon+=src.FieldColor
						if(src.Range>=7)
							var/obj/Effects/ForceField/w7=new
							w7.x=src.x-7
							w7.y=src.y
							w7.z=src.z
							w7.Password=src.Password
							w7.FieldPassword=src.FieldPassword
							w7.icon+=src.FieldColor

						if(src.Range>=8)
							var/obj/Effects/ForceField/w8=new
							w8.x=src.x-8
							w8.y=src.y
							w8.z=src.z
							w8.Password=src.Password
							w8.FieldPassword=src.FieldPassword
							w8.icon+=src.FieldColor


				proc/FFOff(var/ShutdownType)
					set background = TRUE
					for(var/obj/Effects/ForceField/A in world)
						if(A.disposing)
							continue
						if(ShutdownType=="Broad")
							if(A.Password==src.Password)
								del(A)
						else if(ShutdownType=="Specific")
							if(A.FieldPassword==src.FieldPassword)
								del(A)

/**
 * Verb to drop something from inventory.
 */
/obj/item/verb/Drop()
	set name = "Drop"
	set category = "IC"
	set src in usr

	// cast it away from usr because usr is a sin
	var/mob/user = usr

	// first check equipped
	if(equipped)
		alert(user, "This item is currently equipped.")
		return
	// first, check if it's a stack
	if(!craftingmaterialtrue)
		// if not, proceed with just dropping
		force_move(get_turf(user))
		user.carryweight -= weight
		log_action("DROP: [key_name(user)] [audit_coord(user)] [src]")
		user.visible_message("[user] has dropped [src]!", stream = "icout")
		// just refresh inventory because SURELY THIS ISNT A CRAFTING MATERIAL IF IT ISNT A STACK, RIGHT?
		user.Refreshinventoryscreen()
		return
	// if it is, ask for amount
	if(amount <= 0)
		alert(user, "You do not have any to drop.")
		return
	var/amt = input(user, "How many of [src] to drop? \[0-[amount]\]", "Amount", 0) as num|null
	if(isnull(amt) || (amt <= 0) || (amount <= 0))
		return
	amt = clamp(amt, 0, amount)
	// todo: copyatom() is pretty awful and shouldn't be used for stacks if at all possible.
	// create new & set amount
	var/obj/item/dropped = copyatom(src, get_turf(user))
	dropped.amount = amt
	// subtract amount & weight
	amount -= amt
	user.carryweight -= weight * amt
	// feedback
	log_action("DROP: [key_name(user)] [audit_coord(user)] dropped [amt] of [src]")
	user.visible_message("[user] has dropped [amt] of [src]!", stream ="icout")
	// just refresh crafting screen because surely this is a crafting material and not a normal item right??
	UpdateCraft(user)
