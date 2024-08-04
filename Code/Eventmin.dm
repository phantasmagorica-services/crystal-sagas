obj
	Encounterbox
		icon='Icons/Encounterbox.dmi'
		density=1
		opacity=1

mob
	eventmin
		verb
			EventminMenu()
				if(usr.eventmin || usr.tempeventmin)
					winset(usr,"EventminPanel","is-visible=true")
				else
					return
			Eteleport()
				var/list/people = list()
				for(var/mob/M in world)
					if(M.client)
						people += M
				var/mob/G = input("Who would you like to go to?") as null|anything in people
				if(!G)
					return 0
				force_move(get_turf(G))
				usr << output("<font color=#C0FFC0>You appear before [G]","oocout")
				G << output("<font color=#FFC0C0>[usr.name] appears before you.","oocout")
				var/text = "[usr.name] teleported to [G.name]<br>"
				Adminlog(text)
				if(usr.tempeventmin)
					AuditLog(text)
			GiveWeapontoNPC(obj/npc/a in world)
				var/obj/item/Weapon/n
				set category="Admin"
				if(adminlv<2)
					return
				n =input("What do you want to give this NPC??","Create obj") in typesof(/obj/item/Weapon) + list("Cancel")
				var/obj/item/Weapon/wep=copyatom(n)
				a.contents+=wep
				var/text = "[usr.key] gave [a.name] a [wep].<br>"
				Adminlog(text)
			Esummon()
				var/list/people = list()
				for(var/mob/M in world)
					if(M.client)
						people += M
				var/mob/G = input("Who would you like to recall?","Recall Player") as null|anything in people
				if(!G)
					return 0
				G.force_move(get_turf(src))
				usr << output("<font color=#C0FFC0>You summon [G]","oocout")
				G << "<font color=#C0FFC0>[usr.name] has summoned you"
				var/text = "[usr.name] summoned [G.name]<br>"
				Adminlog(text)
				if(usr.tempeventmin)
					AuditLog(text)
			EXYZTeleport()
				var/tx = input(src,"Input your X coordinate.","Change Coordinates",src.x) as null|num
				var/ty = input(src,"Input your Y coordinate.","Change Coordinates",src.y) as null|num
				var/tz = input(src,"Input your Z coordinate.","Change Coordinates",src.z) as null|num
				if(!tx)
					tx = src.x
				if(!ty)
					ty = src.y
				if(!tz)
					tz = src.z
				src.x = tx
				src.y = ty
				src.z = tz
				src << "<font color=#C0FFC0>You teleported to [src.x], [src.y], [src.z]."
				var/text = "[usr.key] teleported to [src.x],[src.y],[src.z]<br>"
				Adminlog(text)
				if(usr.tempeventmin)
					AuditLog(text)
			RCreateitem()
				var/n =input("What do you want to make?","Create obj") in typesof(/obj/item) + list("Cancel")
				if(n=="Cancel")
					return
				else
					new n(locate(usr.x,usr.y,usr.z))
					var/text = "[usr.key] created a [n]<br>"
					Adminlog(text)
					if(usr.tempeventmin)
						AuditLog(text)
			Encountertiles()
				usr.aoeclick=0
				usr.building=0
				if(usr.encountclick==0)
					usr.encountclick=1
					usr<<output("Click anywhere on the map to put an encounter indicater","oocout")
					usr<<output("Click anywhere on the map to put an encounter indicater","Alert")
				else
					usr.encountclick=0
					usr<<output("You are no longer placing encounters.","oocout")
					usr<<output("You are no longer placing encounters","Alert")
			Banimation()
				var/list/target=new
				var/atom/movable/targ
				for(var/obj/npc/n in view())
					if(n in usr.contents)

					else
						target+=n
				for(var/mob/m in view())
					target+=m
				targ=input("Choose a target") as anything in target
				var/list/choice=list("Miss","Physical","Magic","Heal","Fire","Water","Thunder","Ice","Wind","Earth","Dark","Holy","Bio","Laser","Robot","Comet","Flare","Nature","Metal","Monk","Ultima","Drain","Osmose")
				var/ani=input("Choose an animation to play") as null|anything in choice
				var/obj/aniobj
				var/anitime
				if(ani==null)
					return
				switch(ani)
					if("Miss")
						aniobj=new/obj/prop/Evade
						anitime=10
					if("Physical")
						aniobj=new/obj/prop/Target/Physical
						anitime=10
					if("Heal")
						aniobj=new/obj/prop/Target/Heal
						anitime=10
					if("Fire")
						aniobj=new/obj/prop/Target/Fire
						anitime=10
					if("Water")
						aniobj=new/obj/prop/Target/Water
						anitime=10
					if("Thunder")
						aniobj=new/obj/prop/Target/Thunder
						anitime=10
					if("Ice")
						aniobj=new/obj/prop/Target/Ice
						anitime=10
					if("Wind")
						aniobj=new/obj/prop/Target/Wind
						anitime=10
					if("Earth")
						aniobj=new/obj/prop/Target/Earth
						anitime=10
					if("Dark")
						aniobj=new/obj/prop/Target/Dark
						anitime=10
					if("Holy")
						aniobj=new/obj/prop/Target/Holy
						anitime=10
					if("Bio")
						aniobj=new/obj/prop/Target/Bio
						anitime=10
					if("Laser")
						aniobj=new/obj/prop/Target/Laser
						anitime=10
					if("Robot")
						aniobj=new/obj/prop/Target/Robot
						anitime=10
					if("Comet")
						aniobj=new/obj/prop/Target/Comet
						anitime=10
					if("Flare")
						aniobj=new/obj/prop/Target/Flare
						anitime=10
					if("Nature")
						aniobj=new/obj/prop/Target/Nature
						anitime=10
					if("Metal")
						aniobj=new/obj/prop/Target/Metal
						anitime=10
					if("Monk")
						aniobj=new/obj/prop/Target/Monk
						anitime=10
					if("Ultima")
						aniobj=new/obj/prop/Target/Ultima
						anitime=10
					if("Drain")
						aniobj=new/obj/prop/Target/Drain
						anitime=10
					if("Osmose")
						aniobj=new/obj/prop/Target/Osmose
						anitime=10
				targ.vis_contents+=aniobj
				sleep(anitime)
				del(aniobj)


			EFanfare()
				var/list/choice=list("Yes","No")
				var/choose=input(usr,"Are you sure you'd like to play the fanfare to view?") as anything in choice
				switch(choose)
					if("Yes")
						for(var/mob/hearer in view(12,usr))
							hearer<<sound('Fanfare.wav',channel=1)
							sleep(100)
							UpdateArea(hearer)
					if("No")
						return

			EViewArchive()
				var/row
				winset(usr,"NPCarchive","is-visible=true")
				winset(usr,"NPCarchive.anpc","cells=0x0")
				for(var/obj/npc/o in global.npc_archive.npcs)
					row++
					src<<output(o,"anpc:1,[row]")

			EGotoLandmark()
				var/list/loclist1=list("Town","Region","Dungeon")
				var/choice=input("Choose a category") in loclist1
				switch(choice)
					if("Town")
						var/list/loclist2=list("Baron","Costa Del Sol","Desert Outpost","Home","Insomnia","Junon Harbor","Kalm","Midgar","Mysidia","Nibelheim","Tycoon","Wutai","Yevon")
						var/choice2=input("Choose a destination") in loclist2
						switch(choice2)
							if("Baron")
								usr.loc=locate(290,80,2)
							if("Costa Del Sol")
								usr.loc=locate(293,235,5)
							if("Desert Outpost")
								usr.loc=locate(309,42,6)
							if("Home")
								usr.loc=locate(241,313,11)
							if("Insomnia")
								usr.loc=locate(200,94,1)
							if("Junon Harbor")
								usr.loc=locate(165,25,8)
							if("Kalm")
								usr.loc=locate(74,143,8)
							if("Midgar")
								usr.loc=locate(104,138,17)
							if("Mysidia")
								usr.loc=locate(272,267,18)
							if("Nibelheim")
								usr.loc=locate(73,323,2)
							if("Tycoon")
								usr.loc=locate(108,261,10)
							if("Wutai")
								usr.loc=locate(39,315,9)
							if("Yevon")
								usr.loc=locate(179,209,14)
					if("Region")
						var/list/loclist3=list("Aldenard","Kaipo Desert","Lucian Mountain Range","West Lucian")
						var/choice3=input("Choose a location") in loclist3
						switch(choice3)
							if("Aldenard")
								usr.loc=locate(158,208,12)
							if("Kaipo Desert")
								usr.loc=locate(193,185,6)
							if("Lucian Mountain Range")
								usr.loc=locate(156,301,3)
							if("West Lucian")
								usr.loc=locate(212,204,4)
					if("Dungeon")
						var/list/loclist4=list("Ancient Castle","Chaos Shrine","Citadel of Trials","Drakenvale","Earthern Shrine","Fire Cavern","Golmore Jungle","Halitali","Henne Mines","Jade Passage","Jenova Research Facility","Midgar Military Outpost","Nechrol of Arcadia")
						var/choice4=input("Choose a location") in loclist4
						switch(choice4)
							if("Ancient Castle")
								usr.loc=locate(257,323,4)
							if("Chaos Shrine")
								usr.loc=locate(386,116,4)
							if("Citadel of Trials")
								usr.loc=locate(313,130,18)
							if("Drakenvale")
								usr.loc=locate(3,285,10)
							if("Earthern Shrine")
								usr.loc=locate(32,127,6)
							if("Fire Cavern")
								usr.loc=locate(234,331,3)
							if("Golmore Jungle")
								usr.loc=locate(371,161,8)
							if("Halitali")
								usr.loc=locate(339,367,1)
							if("Henne Mines")
								usr.loc=locate(72,190,4)
							if("Jade Passage")
								usr.loc=locate(212,225,4)
							if("Jenova Research Facility")
								usr.loc=locate(330,347,2)
							if("Midgar Military Outpost")
								usr.loc=locate(114,280,7)
							if("Nechrol of Arcadia")
								usr.loc=locate(9,92,4)

			EGivePerktoNPC(obj/npc/a in world)
				set category="Admin"
				if(adminlv<2)
					return
				var/perk=input("What perk do you wish to give them?") as null|anything in perklist
				var/obj/perk2=copyatom(perk)
				a.contents+=perk2
				Checkspec(perk2,a)
				var/text = "[usr.key] gave [a.name] the perk [perk2]"
				Adminlog(text)
			EDelete(atom/A in world)
				if(istype(A,/area/))
					usr<<"You can't delete Areas."
					return
				var/text = "[usr.key] deleted [A]"
				Adminlog(text)
				for(var/mob/m in world)
					if(src in m.contents)
						m.contents-=src
				del(A)

			EGiveCustomPerk(var/obj/npc/a)
				switch(alert("Do you wish to create a perk or an ability?",,"Perk","Ability"))
					if("Perk")
						var/obj/perk/p=new
						p.name=input("Choose a name for the perk.") as text
						var/list/ranklist=list("T1","T2","T3","T4","T5","T6")
						p.rank=input("Choose a rank for the perk") as anything in ranklist
						p.desc=input("Set the description of the perk") as text
						switch(alert("Set an icon?",,"Yes","No"))
							if("Yes")
								p.icon=input()as icon
						a.contents+=p
						switch(alert("Add this perk to the database?",,"Yes","No"))
							if("Yes")
								var/obj/perk/p2=new
								p2=copyatom(p)
								perklist+=p2
					if("Ability")
						var/obj/perk/p=new
						p.ability=1
						p.name=input("Choose a name for the perk.") as text
						var/list/ranklist=list("E","D","C","B","A","S")
						p.rank=input("Choose a rank for the perk") as anything in ranklist
						p.desc=input("Set the description of the perk") as text
						p.mcost=input("How much will it cost to use this ability?") as num
						var/list/rescost=list("Mana","Stamina")
						p.costtype=input("Mana or Stamina drain?") as anything in rescost
						var/list/atktype=list("standard","magical","save","weapon","weaponsave","heal")
						p.atype=input("Choose an attack type. This affects calculation during rolls") as anything in atktype
						p.attack_roll_damage_dice = FALSE
						var/list/sourcetypes=list("str","dex","con","int","wis","cha")
						switch(p.atype)
							if("standard", "weapon", "magical", "heal")
								p.attack_roll_damage_lower=input("Choose a starting range for an attack roll") as num
								p.attack_roll_damage_upper=input("Choose an ending range for an attack roll") as num
								p.addhit=input("Does this attack add to hitrate?") as num
								p.adddam=input("Does this attack add to damage?") as num
								p.damsource=input("What stat is being taken into calc.") as anything in sourcetypes
							if("save", "weaponsave")
								p.attack_roll_damage_lower=input("Choose a starting range for an attack roll") as num
								p.attack_roll_damage_upper=input("Choose an ending range for an attack roll") as num
								p.addhit=input("Does this attack add to hitrate?") as num
								p.adddam=input("Does this attack add to damage?") as num
								p.damsource=input("What stat is being taken into calc.") as anything in sourcetypes
								p.basecheck=input("Choose the base DC is calculated by.")as num
								var/list/svetypes=list("Fortitude","Reflex","Will")
								p.savetype=input("Choose what stat is required in the save.")as anything in svetypes

						switch(alert("Set an icon?",,"Yes","No"))
							if("Yes")
								p.icon=input()as icon
						a.contents+=p
						switch(alert("Add this perk to the database?",,"Yes","No"))
							if("Yes")
								var/obj/perk/p2=new
								p2=copyatom(p)
								perklist+=p2

			EGiveNPCWeapon(var/obj/npc/n)
				var/obj/item/i =input("What do you want to make?","Create obj") in typesof(/obj/item/Weapon) + list("Cancel")
				if(i=="Cancel")
					return
				n.contents+= new i
				n.eweapon=i

			NPCEdit(obj/npc/A in world)
				set category="Admin"
				var/Edit="<Edit><body bgcolor=#000000 text=#339999 link=#99FFFF>"
				var/list/B=new
				Edit+="[A]<br>[A.type]"
				Edit+="<table width=10%>"
				for(var/C in A.vars) B+=C
				B.Remove("Package","bound_x","bound_y","step_x","step_y","Admin")
				for(var/C in B)
					Edit+="<td><a href=byond://?src=\ref[A];action=edit;var=[C]>"
					Edit+=C
					Edit+="<td>[Value(A.vars[C])]</td></tr>"
				usr<<browse(Edit,"window=[A];size=450x600")
