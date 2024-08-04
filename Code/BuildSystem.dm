mob
	verb
		Openbuild()
			var/row
			usr.buildmode=1
			winset(usr,"Build","is-visible=true")
			winset(usr,"Build.Buildgrid","cells=0x0")
			for(var/obj/Builds/Buildturf/Outside/A in Buildables)
				row++
				usr << output(A,"Buildgrid:1,[row]")
			if(usr.tempeventmin || usr.eventmin)
				winset(usr,"Build.Eventminbutton","is-visible=true")
		OpenEventObjects()
			var/row
			winset(usr,"Build","is-visible=true")
			winset(usr,"Build.Buildgrid","cells=0x0")
			for(var/obj/Builds/Event/A in Buildables)
				row++
				usr << output(A,"Buildgrid:1,[row]")
		Openoutside()
			usr.buildmode=1
			winset(usr,"Build","is-visible=true")
			winset(usr,"Build.Buildgrid","cells=0x0")
			var/row
			for(var/obj/Builds/Buildturf/Outside/A in Buildables)
				row++
				usr << output(A,"Buildgrid:1,[row]")
		Openinside()
			usr.buildmode=1
			winset(usr,"Build","is-visible=true")
			winset(usr,"Build.Buildgrid","cells=0x0")
			var/row
			for(var/obj/Builds/Buildturf/Inside/A in Buildables)
				row++
				usr << output(A,"Buildgrid:1,[row]")
		OpenMidgar()
			usr.buildmode=1
			winset(usr,"Build","is-visible=true")
			winset(usr,"Build.Buildgrid","cells=0x0")
			var/row
			for(var/obj/Builds/Buildturf/MidgarTiles/A in Buildables)
				row++
				usr << output(A,"Buildgrid:1,[row]")
		OpenInsomnia()
			usr.buildmode=1
			winset(usr,"Build","is-visible=true")
			winset(usr,"Build.Buildgrid","cells=0x0")
			var/row
			for(var/obj/Builds/Buildturf/InsomniaTiles/A in Buildables)
				row++
				usr << output(A,"Buildgrid:1,[row]")
		OpenYevon()
			usr.buildmode=1
			winset(usr,"Build","is-visible=true")
			winset(usr,"Build.Buildgrid","cells=0x0")
			var/row
			for(var/obj/Builds/Buildturf/YevonTiles/A in Buildables)
				row++
				usr << output(A,"Buildgrid:1,[row]")
		OpenInsideObjects()
			usr.buildmode=1
			winset(usr,"Build","is-visible=true")
			winset(usr,"Build.Buildgrid","cells=0x0")
			var/row
			for(var/obj/Builds/Buildobjects/Interior/A in Buildables)
				row++
				usr << output(A,"Buildgrid:1,[row]")
		OpenOutsideObjects()
			usr.buildmode=1
			winset(usr,"Build","is-visible=true")
			winset(usr,"Build.Buildgrid","cells=0x0")
			var/row
			for(var/obj/Builds/Buildobjects/Exterior/A in Buildables)
				row++
				usr << output(A,"Buildgrid:1,[row]")
		OpenEdges()
			usr.buildmode=1
			winset(usr,"Build","is-visible=true")
			winset(usr,"Build.Buildgrid","cells=0x0")
			var/row
			for(var/obj/Builds/Buildobjects/Edges/A in Buildables)
				row++
				usr << output(A,"Buildgrid:1,[row]")
		OpenDoors()
			usr.buildmode=1
			winset(usr,"Build","is-visible=true")
			winset(usr,"Build.Buildgrid","cells=0x0")
			var/row
			for(var/obj/Builds/Buildobjects/Door/A in Buildables)
				row++
				usr << output(A,"Buildgrid:1,[row]")
		OpenWater()
			usr.buildmode=1
			winset(usr,"Build","is-visible=true")
			winset(usr,"Build.Buildgrid","cells=0x0")
			var/row
			for(var/obj/Builds/Buildturf/Water/A in Buildables)
				row++
				usr << output(A,"Buildgrid:1,[row]")

obj
	var/bprice
	var/builder
	var/built=0
	Builds
		Savable=0
		var/eventobject=0
		var/isturf=0
		verb
			Deleteobject()
				set name="Delete Built Object"
				set src in view(usr)
				if(usr.key==src.owner)
					var/list/choices=list("Yes","No")
					var/choose=input(usr,"Would you like to delete this built object?") as anything in choices
					switch(choose)
						if("Yes")
							if(src.eventobject==1)
								var/list/choices2=list("Yes","No")
								var/choose2=input(usr,"Would you like to delete all Event objects that you own?") as anything in choices2
								switch(choose2)
									if("Yes")
										for(var/obj/Builds/a in world)
											if(a.eventobject==1)
												if(a.owner==usr.key)
													del (a)
									if("No")
										del(src)
							else
								del(src)
						if("No")
							return
				else
					return
		DblClick()
			if(src.built==1)
				return
			usr.aoeclick=0
			usr.encountclick=0
			if(usr.building)
				usr.building=0
				for(var/obj/Builds/o in usr.contents)
					del(o)
				usr<<output("You are no longer building","oocout")
				return
			else
				for(var/obj/Builds/o in usr.contents)
					del(o)
				sleep()
				var/obj/Builds/Buildobjects/Door/doorio = new
				var/obj/Builds/B = new()
				if(src.isdoor==1)
					usr.building=1
					var/obj/Builds/Buildobjects/Door/copied = copyatom(doorio)
					copied.password=input(usr,"What would you like this Door's password to be?") as text
					copied.density=src.density
					copied.opacity=src.opacity
					copied.bprice=src.bprice
					copied.layer=src.layer
					copied.icon=src.icon
					copied.icon_state=src.icon_state
					copied.name="Door"
					copied.owner=usr.key
					copied.faction=usr.faction
					copied.closedstate=src.closedstate
					copied.openstate=src.openstate
					usr.contents+=copied
				else
					usr.building=1
					B.density=src.density
					B.opacity=src.opacity
					B.name=src.name
					B.bprice=src.bprice
					B.layer=src.layer
					B.icon=src.icon
					B.icon_state=src.icon_state
					B.isturf=src.isturf
					B.owner=usr.key
					B.faction=usr.faction
					usr.contents+=B
				usr<<output("Click in designated/owned building areas to set down the tile.","oocout")
var/list/Buildables=new

proc
	Addbuildables()
	//	for(var/A in typesof(/obj/Builds/Buildturf/))
		//	if(A!=/obj/Builds/Buildturf)
			//	Buildables+=new A
		//for(var/A in typesof(/obj/Builds/Buildobject/))
		//	if(A!=/obj/Builds/Buildobject)
			//	Buildables+=new A
		for(var/A in typesof(/obj/Builds/Buildturf/Outside/))
			if(A!=/obj/Builds/Buildturf/Outside)
				Buildables+=new A
		for(var/A in typesof(/obj/Builds/Event/))
			if(A!=/obj/Builds/Event)
				Buildables+=new A
		for(var/A in typesof(/obj/Builds/Buildturf/Inside/))
			if(A!=/obj/Builds/Buildturf/Inside)
				Buildables+=new A
		for(var/A in typesof(/obj/Builds/Buildturf/MidgarTiles/))
			if(A!=/obj/Builds/Buildturf/MidgarTiles)
				Buildables+=new A
		for(var/A in typesof(/obj/Builds/Buildturf/InsomniaTiles/))
			if(A!=/obj/Builds/Buildturf/InsomniaTiles)
				Buildables+=new A
		for(var/A in typesof(/obj/Builds/Buildturf/YevonTiles/))
			if(A!=/obj/Builds/Buildturf/YevonTiles)
				Buildables+=new A
		for(var/A in typesof(/obj/Builds/Buildturf/Water/))
			if(A!=/obj/Builds/Buildturf/Water)
				Buildables+=new A
		for(var/A in typesof(/obj/Builds/Buildobjects/Interior/))
			if(A!=/obj/Builds/Buildobjects/Interior)
				Buildables+=new A
		for(var/A in typesof(/obj/Builds/Buildobjects/Exterior/))
			if(A!=/obj/Builds/Buildobjects/Exterior)
				Buildables+=new A
		for(var/A in typesof(/obj/Builds/Buildobjects/Edges/))
			if(A!=/obj/Builds/Buildobjects/Edges)
				Buildables+=new A
		for(var/A in typesof(/obj/Builds/Buildobjects/Door/))
			if(A!=/obj/Builds/Buildobjects/Door)
				Buildables+=new A