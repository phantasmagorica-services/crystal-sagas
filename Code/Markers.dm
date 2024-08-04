obj/markers
	icon='Icons/Markers.dmi'
	layer=4
	var/position
	var/duration
	DblClick()
		var/list/choices=list("Remove Marker","Cancel")
		var/choice=input(usr,"[src.name]: [src.desc] | What would you like to do?") as anything in choices
		switch(choice)
			if("Remove Marker")
				for(var/mob/m in world)
					if(src in m.contents)
						m.contents-=src
						usr.ViewStatus(m)
						view(m) << output("[usr.name] has removed [src.name] from [m.name]!","icout")
						RefreshStatus(m, usr)
						del src
			if("Cancel")
				return
	poison
		name="Poison"
		icon_state="poison"
		desc="The afflicted is poisoned, and they take damage each turn, for five turns. -5 HP per turn."
	silence
		name="Silence"
		icon_state="silence"
		desc="A seal is placed on the afflicted's throat inhibiting their use of General Magic, White Magic, Black Magic, and speech. This lasts for four turns."
	wet
		name="Wet"
		icon_state="wet"
		desc="While 'Wet', a creature takes half damage from Fire based attacks, but Lightning based attacks deal 2d12 extra damage. Lasts for 3 turns. "
	paralysis
		name="Paralyze"
		icon_state="paralysis"
		desc="The afflicted has been inflicted with minor paralysis, and their nervous system does not work as well as normal. As a result, a Paralyzed individual has disadvantage on DEX based checks and Reflex saving throws, and their AC and to Hit are reduced by 2 for 3 turns."
	berserk
		name="Berserk"
		icon_state="berserk"
		desc="The afflicted is overcome with a blinding rage unable to make any thought that isn’t pure violence. In this state the afflicted is unable to use any abilities, but the rage grants them +6 to their Strength score. This lasts until the end of the battle unless treated."
	burn
		name="Burn"
		icon_state="burn"
		desc="Unless specified by a spell, a character with burn inflicted takes 5 Fire damage every round it is active, for 3 rounds. The 'Wet' status effect removes Burn."
	stun
		name="Stun"
		icon_state="stun"
		desc="The afflicted is stunned through some means, and as a result may not make a movement, reaction or dodge action. They can still use the attack or ability action, however. Lasts one turn. "
	stone
		name="Break"
		icon_state="break"
		desc="Someone who is undergoing the effects of break will slowly start to turn to stone. This lowers their speed by one tile per turn until they are unable to move. They fully turn to stone when they run out of tile movement unless they have additional resistance perks (Resistance adds 1 extra turn until fully turning to stone). The afflicted have one OOC day after fully being turned to stone to be restored either with a golden needle or spell or else they die."
	doom
		name="Doom"
		icon_state="doom"
		desc="The afflicted is marked by death itself set to die from a heart attack within seven turns if the effect is not treated. A spiritual clock is seen over the head of anyone afflicted alerting others of their certain demise. Slow, stop, and haste all effect the clock; haste and slow doubling and halving it respectively, and stop causing the counter to stop as long as the ailment is in effect. Resistance to Doom adds +5 turns to the clock."
	bleed
		name="Bleed"
		icon_state="bleed"
		desc="Unless specified by a spell, a character with bleed takes 5 true damage every round it is active, for 3 rounds."
	whorl
		name="Whorl"
		icon_state="whorl"
		desc="The afflicted is surrounded by enchanted rain clouds, which continually apply the 'Wet' status effect, and reduce their tile movement by half whilst affected. Lasts 5 rounds."
	blind
		name="Blind"
		icon_state="blind"
		desc="When under the effects of blind the afflicted's vision is severely impaired. Reduces AC by 2, and to hit by 3, lasts for 4 turns."
	curse
		name="Curse"
		icon_state="curse"
		desc="The afflicted have a curse put upon them that causes any kind of restorative magic, including items to cause them harm for the amount they would heal instead of restoring HP. 3 turn duration."
	squall
		name="Squall"
		icon_state="squall"
		desc="The afflicted is covered in enchanted winds, which constantly whirl around their form. They take 2d10 additional fire damage from any instance of fire damage dealt to them, and abilities that deal Wind damage have advantage against them. 4 round duration."
	frostbite
		name="Frostbite"
		icon_state="frostbite"
		desc="The afflicted suffers 4 true damage per turn, and suffers -1 to hit, AC, and saving throws. 4 round duration. "
	heavy
		name="Heavy"
		icon_state="heavy"
		desc="The afflicted suffers -2 AC, their movement is halved, suffers disadvantage on STR based checks, and they also deal 10 less physical damage on all attacks."
	weakness
		name="Weakness"
		icon_state="weakness"
		desc="The afflicted suffers a -2 to hit, and deals 10 less damage on all attacks for 2 turns. "
	slow
		name="Slow"
		icon_state="slow"
		desc="Minus 1 Tile speed per turn, -1 to hit. Lasts four turns"
	stop
		name="Stop"
		icon_state="stop"
		desc="Halts the afflicted in time they; are completely unaware of what is going on, and remain immobile till they re-enter time. Lasts one turn. "

atom
	proc
		Applystatmark(var/atom/a, var/atom/b)
			switch(input("Apply a status marker") in list("Poison","Silence","Wet","Paralyze","Berserk","Burn","Stun","Break","Doom","Bleed","Whorl","Squall","Frostbite","Heavy","Weakness","Blind","Slow","Stop"))
				if("Poison")
					for(var/obj/markers/poison/p in a.contents)
						alert("Poison is already applied")
						return
					var/obj/markers/poison/p2=new
					a.contents+=p2
					view(a) << output("[b.name] has applied [p2.name] to [a.name]!","icout")
				if("Silence")
					for(var/obj/markers/silence/s in a.contents)
						alert("Silence is already applied")
						return
					var/obj/markers/silence/p2=new
					a.contents+=p2
					view(a) << output("[b.name] has applied [p2.name] to [a.name]!","icout")
				if("Wet")
					for(var/obj/markers/wet/s in a.contents)
						alert("Wet is already applied")
						return
					var/obj/markers/wet/p2=new
					a.contents+=p2
					view(a) << output("[b.name] has applied [p2.name] to [a.name]!","icout")
				if("Paralyze")
					for(var/obj/markers/paralysis/s in a.contents)
						alert("Paralysis is already applied")
						return
					var/obj/markers/paralysis/p2=new
					a.contents+=p2
					view(a) << output("[b.name] has applied [p2.name] to [a.name]!","icout")
				if("Berserk")
					for(var/obj/markers/berserk/s in a.contents)
						alert("Berserk is already applied")
						return
					var/obj/markers/berserk/p2=new
					a.contents+=p2
					view(a) << output("[b.name] has applied [p2.name] to [a.name]!","icout")
				if("Burn")
					for(var/obj/markers/burn/s in a.contents)
						alert("Burn is already applied")
						return
					var/obj/markers/burn/p2=new
					a.contents+=p2
					view(a) << output("[b.name] has applied [p2.name] to [a.name]!","icout")
				if("Stun")
					for(var/obj/markers/stun/s in a.contents)
						alert("Stun is already applied")
						return
					var/obj/markers/stun/p2=new
					a.contents+=p2
					view(a) << output("[b.name] has applied [p2.name] to [a.name]!","icout")
				if("Break")
					for(var/obj/markers/stone/s in a.contents)
						alert("Break is already applied")
						return
					var/obj/markers/stone/p2=new
					a.contents+=p2
					view(a) << output("[b.name] has applied [p2.name] to [a.name]!","icout")
				if("Doom")
					for(var/obj/markers/doom/s in a.contents)
						alert("Doom is already applied")
						return
					var/obj/markers/doom/p2=new
					a.contents+=p2
					view(a) << output("[b.name] has applied [p2.name] to [a.name]!","icout")
				if("Bleed")
					for(var/obj/markers/bleed/s in a.contents)
						alert("Bleed is already applied")
						return
					var/obj/markers/bleed/p2=new
					a.contents+=p2
					view(a) << output("[b.name] has applied [p2.name] to [a.name]!","icout")
				if("Whorl")
					for(var/obj/markers/whorl/s in a.contents)
						alert("Whorl is already applied")
						return
					var/obj/markers/whorl/p2=new
					a.contents+=p2
					view(a) << output("[b.name] has applied [p2.name] to [a.name]!","icout")
				if("Squall")
					for(var/obj/markers/squall/s in a.contents)
						alert("Squall is already applied")
						return
					var/obj/markers/squall/p2=new
					a.contents+=p2
					view(a) << output("[b.name] has applied [p2.name] to [a.name]!","icout")
				if("Frostbite")
					for(var/obj/markers/frostbite/s in a.contents)
						alert("Frostbite is already applied")
						return
					var/obj/markers/frostbite/p2=new
					a.contents+=p2
					view(a) << output("[b.name] has applied [p2.name] to [a.name]!","icout")
				if("Weakness")
					for(var/obj/markers/weakness/s in a.contents)
						alert("Weakness is already applied")
						return
					var/obj/markers/weakness/p2=new
					a.contents+=p2
					view(a) << output("[b.name] has applied [p2.name] to [a.name]!","icout")
				if("Blind")
					for(var/obj/markers/blind/s in a.contents)
						alert("Blind is already applied")
						return
					var/obj/markers/blind/p2=new
					a.contents+=p2
					view(a) << output("[b.name] has applied [p2.name] to [a.name]!","icout")
				if("Slow")
					for(var/obj/markers/slow/s in a.contents)
						alert("Slow is already applied")
						return
					var/obj/markers/slow/p2=new
					a.contents+=p2
					view(a) << output("[b.name] has applied [p2.name] to [a.name]!","icout")
				if("Stop")
					for(var/obj/markers/stop/s in a.contents)
						alert("Stop is already applied")
						return
					var/obj/markers/stop/p2=new
					a.contents+=p2
					view(a) << output("[b.name] has applied [p2.name] to [a.name]!","icout")
			RefreshStatus(a)

		Positionadj(var/atom/movable/a)
			var/count
			for(var/obj/markers/m in a.vis_contents)
				m.pixel_x=0
				m.pixel_y=0
				m.invisibility=0
			for(var/obj/markers/ma in a.vis_contents)
				count++
				switch(count)
					if(1)

					if(2)
						ma.pixel_y=-8
					if(3)
						ma.pixel_y=-16
					if(4)
						ma.pixel_y=-24
					if(5)
						ma.pixel_x=8
					if(6)
						ma.pixel_x=8
						ma.pixel_y=-8
					if(7)
						ma.pixel_x=8
						ma.pixel_y=-16
					if(8)
						ma.pixel_x=8
						ma.pixel_y=-24
		RemoveMarker(var/atom/a, var/atom/b)
			var/list/choice=list("Cancel")
			for(var/obj/markers/m in a.contents)
				choice+=m
			while(choice!=null)
				var/obj/markers/choose=input("What status marker do you want to delete?") as anything in choice
				if(choose=="Cancel")
					return
				else
					a.contents-=choose
					choose.x=a.x
					choose.y=a.y
					choose.z=1
					view(a) << output("[b.name] has removed [choose.name] from [a.name]!","icout")
					sleep(1)
					del(choose)
		RefreshStatus(var/atom/a, var/atom/b)
			set name="View Status"
			var/row
			if(a.name==b.name)
				winset(b,"statusscreen.owner","text=\"<font size=4><b>[a.name]'s Status</b>\"")
				winset(b,"statusscreen.grid","cells=0x0")
				for(var/obj/markers/g in a.contents)
					row++
					winset(a, "statusscreen.grid", "current-cell=1,[row]")
					a << output(g,"statusscreen.grid")
				return
			else
				winset(a,"statusscreen.owner","text=\"<font size=4><b>[a.name]'s Status</b>\"")
				winset(a,"statusscreen.grid","cells=0x0")
				for(var/obj/markers/g in a.contents)
					row++
					winset(a, "statusscreen.grid", "current-cell=1,[row]")
					a << output(g,"statusscreen.grid")
				winset(b,"statusscreen.owner","text=\"<font size=4><b>[a.name]'s Status</b>\"")
				winset(b,"statusscreen.grid","cells=0x0")
				for(var/obj/markers/g in a.contents)
					row++
					winset(b, "statusscreen.grid", "current-cell=1,[row]")
					b << output(g,"statusscreen.grid")


mob/verb
	ViewStatus(mob/m)
		set name="View Status"
		var/row
		winset(usr,"statusscreen","is-visible=true")
		winset(usr,"statusscreen.owner","text=\"<font size=4><b>[m.name]'s Status</b>\"")
		winset(usr,"statusscreen.grid","cells=0x0")
		for(var/obj/markers/g in m.contents)
			row++
			winset(usr, "statusscreen.grid", "current-cell=1,[row]")
			usr << output(g,"statusscreen.grid")
	ViewMobStatus(obj/npc/m)
		set name="View NPC Status"
		var/row
		winset(usr,"statusscreen","is-visible=true")
		winset(usr,"statusscreen.owner","text=\"<font size=4><b>[m.name]'s Status</b>\"")
		winset(usr,"statusscreen.grid","cells=0x0")
		for(var/obj/markers/g in m.contents)
			row++
			winset(usr, "statusscreen.grid", "current-cell=1,[row]")
			usr << output(g,"statusscreen.grid")
	Applymarker(mob/a)
		set name="Add Status"
		Applystatmark(a, usr)
		RefreshStatus(a, usr)
	Removemarker(mob/a)
		set name="Remove Status"
		RemoveMarker(a, usr)
		RefreshStatus(a, usr)
	Applymobmarker(obj/npc/a)
		set name="Apply Status Marker"
		Applystatmark(a, usr)
		RefreshStatus(a, usr)
	Removemobmarker(obj/npc/a)
		set name="Remove Status Marker"
		RemoveMarker(a, usr)
		RefreshStatus(a, usr)
	Lettermarker(obj/npc/m)
		set name="Apply Letter Marker"
		if(usr.adminlv<1)
			return
		Designateletter(m)


////////////////////////////////////////////////////////////////////Letter Markers


obj/npc/var
	let

obj/lettermarkers
	icon='Icons/lettermarkers.dmi'
	pixel_x=-32
	pixel_y=32
	layer=5
	A
		icon_state="a"
	B
		icon_state="b"
	C
		icon_state="c"
	D
		icon_state="d"
	E
		icon_state="e"
	F
		icon_state="f"

proc
	Designateletter(var/obj/npc/n)
		for(var/obj/lettermarkers/l in n.vis_contents)
			del(l)
		n.let=null
		var/list/alphabet=list("A","B","C","D","E","F")
		var/choice=input("Choose the letter you wish to designate this NPC as.") as anything in alphabet
		switch(choice)
			if("A")
				var/obj/lettermarkers/A/AR=new
				n.vis_contents+=AR
				n.let="A"
			if("B")
				var/obj/lettermarkers/B/BR=new
				n.vis_contents+=BR
				n.let="B"
			if("C")
				var/obj/lettermarkers/C/CR=new
				n.vis_contents+=CR
				n.let="C"
			if("D")
				var/obj/lettermarkers/D/DR=new
				n.vis_contents+=DR
				n.let="D"
			if("E")
				var/obj/lettermarkers/E/ER=new
				n.vis_contents+=ER
				n.let="E"
			if("F")
				var/obj/lettermarkers/F/FR=new
				n.vis_contents+=FR
				n.let="F"











