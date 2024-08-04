LEGACY_GLOBAL_DATUM(stablemaster_obj, /obj/Stablemaster)

obj
	Stablemaster
		density=1
		icon='Icons/Stablemaster.png'
		New()
			global.stablemaster_obj = src
		Click()
			winset(usr,"stablemaster","is-visible=true")
			winset(usr,"stablemaster.beast","cells=0x0")
			var/row
			var/row2
			for(var/obj/npc/Monsters/DRank/A in src.contents)
				if(A.unroot==1)
					row++
					usr << output(A,"stablemaster.beast:1,[row]")
			for(var/obj/npc/Monsters/CRank/A in src.contents)
				if(A.worldboss==0)
					if(A.unroot==1)
						row2++
						usr << output(A,"stablemaster.beast:1,[row2]")
