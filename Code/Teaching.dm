obj
	rep
		Click()
			var/list/teachperks=new
			var/tperk
			var/intcheck
			var/obj/pname
			var/row
			intcheck+=usr.int
			intcheck+=usr.addint
			if(usr.teachslot==usr.maxteachslot)
				alert("You can't teach right now.")
			if(intcheck<12)
				alert("You are not smart enough to pass on your knowledge")
			else
				for(var/mob/m in world)
					if(m.name == src.name)
						for(var/obj/perk/p in usr.contents)
							var/n = copyatom(p)
							teachperks+=n
						tperk = input("What perk would you like to teach this student?")as null|anything in teachperks
						if(!tperk)
							return
						if(usr.check_perk(tperk))
							alert("You cannot teach a skill they already know.")
						else
							m.contents+=tperk
							Checkspec(tperk,m)
							usr.teachslot++
							winset(usr,"Teachingwindow.Teachingstats","text=\"Teaching Slots:[usr.teachslot]/[usr.maxteachslot]\"")
							var/obj/historyobj/h = new /obj/historyobj
							h.name=m.name
							h.icon=m.icon
							h.overlays=m.overlays
							h.date = time2text(world.realtime,"MM/DD/YYYY")
							h.name+="/"
							pname=tperk
							h.name+=pname.name
							h.name+="/"
							h.name+=h.date
							usr.history+=h
							for(var/obj/o in usr.history)
								row++
								usr<< output(o,"History:1,[row]")
	historyobj
		var
			taught
			date


/**
 * Checks if we have a perk
 *
 * todo: id instead of name
 *
 * @params
 * * what - Perk instance, typepath, or name
 */
/mob/proc/check_perk(obj/perk/what)
	ASSERT(istype(what) || istext(what) || ispath(what))
	if(ispath(what))
		what = initial(what.name)
	var/target_name = istype(what)? what.name : what
	for(var/obj/perk/P in contents)
		if(P.name == target_name)
			return TRUE
	return FALSE

mob
	verb
		Openteachingwindow()
			winset(usr,"Teachingwindow","is-visible=true")
			winset(usr,"Teachingwindow.Teachingstats","text=\"Teaching Slots:[usr.teachslot]/[usr.maxteachslot]\"")
			winset(usr,"Students","cells=0x0")
			var/row
			for(var/obj/rep/T in usr.contents)
				del(T)
			for(var/mob/m in oview())
				row++
				var/obj/rep/R = new /obj/rep
				usr.contents+=R
				R.name = m.name
				R.icon = m.icon
				R.overlays = m.overlays
				src << output(R,"Students:1,[row]")
			row = 0
			for(var/obj/o in usr.history)
				row++
				src<< output(o,"History:1,[row]")
