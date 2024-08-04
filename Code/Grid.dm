obj
	var
		difter=0

mob/verb/Grid()
	if(!usr.grid)
		for(var/turf/t in view(usr))
			if(t.owner!=null && t.owner!=usr.key)
				var/image/r3 = image('Icons/grid.dmi',t,"p",5)
				usr.client.images += r3
			if(t.owner==usr.key)
				var/image/r3 = image('Icons/grid.dmi',t,"g",5)
				usr.client.images += r3
			if(t.density==1)
				if(istype(t,/turf/map/Water))
					var/image/b = image('Icons/grid.dmi',t,"b")
					usr.client.images += b
				else
					var/image/r2 = image('Icons/grid.dmi',t,"r")
					usr.client.images += r2
			else
				for(var/obj/o in t.contents)
					if(o.owner==usr.key)
						var/image/r3 = image('Icons/grid.dmi',t,"g",5)
						usr.client.images += r3
					if(o.density==1)
						var/image/r = image('Icons/grid.dmi',t,"r",6)
						usr.client.images += r
					else if(o.difter==1)
						var/image/y = image('Icons/grid.dmi',t,"y")
						usr.client.images += y
				var/image/w = image('Icons/grid.dmi',t,"w")
				usr.client.images += w
		usr.grid=1
	else
		for(var/image/g in usr.client.images)
			if(g.icon=='Icons/grid.dmi')
				del(g)
		usr.grid=0
