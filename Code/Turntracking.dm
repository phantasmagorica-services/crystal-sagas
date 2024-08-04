atom/var/turnid
atom/var/initroll

atom/proc/Initroll()
	var/roll1
	if(istype(src,/mob))
		var/mob/m=src
		roll1=rand(1,20)
		roll1+=m.dexmod
		m.initroll=roll1
	if(istype(src,/obj/npc))
		var/obj/npc/n=src
		roll1=rand(1,20)
		roll1+=n.dexmod
		n.initroll=roll1


obj
	trackerind
		icon='Icons/Turntracker.dmi'
		layer=5
		pixel_y=15

obj
	Turntracker
		name="Turn Tracker"
		icon='Icons/Turntracker.dmi'
		icon_state="tracker"
		var/battlers
		var/round=1
		var/atom/movable/currentbat
		var/list/battlelist=new
		var/list/organizedbattler=new
		var/started=0
		Click()
			var/list/options=list("Register","Register NPC","View Battlers","Pass Turn","Unregister","Cancel")
			if(usr.key==src.owner)
				options+="Start"
				options+="End Battle"
			if(src.started==1)
				options-="Start"
			switch(input("Register for this battle?") as anything in options)
				if("Register")
					if(src.currentbat!=null)
						usr.turnid=src.battlers+1
						src.battlers++
						src.organizedbattler+=usr
						view()<<output("<font color=[usr.textcolor]><b>[usr.name]</font> has joined the battle late...they have been added to the bottom of the round list. ","oocout")
					src.battlelist+=usr
					usr.Initroll()
					view()<<output("<font color=[usr.textcolor]><b>[usr.name]</font> has joined the fray and rolled <font color=#8ED69A><b>[usr.initroll]</font>","oocout")
				if("Register NPC")
					var/list/nchoice=new
					for(var/obj/npc/n in view())
						if(n.owner==usr.key)
							nchoice+=n
					var/loop=1
					var/atom/choice
					while(loop)
						choice=null
						choice=input("Which NPC's do you wish to add?") as null|anything in nchoice
						if(choice==null)
							loop=0
						if(choice!=null)
							src.battlelist+=choice
							nchoice-=choice
							choice.Initroll()
							view()<<output("<b><font color=#8ED6CA>[choice.name]</font> has joined the fray and rolled <font color=#8ED69A><b>[choice.initroll]</font>","oocout")
				if("View Battlers")
					if(src.currentbat==null)
						alert(usr,"The battle has not started yet.")
						return
					usr<<output("Round: [src.round]","oocout")
					for(var/atom/a in src.organizedbattler)
						usr<<output("[a.name]","oocout")
				if("Cancel")
					return
				if("Unregister")
					var/savedid
					switch(alert(usr,"Yourself or NPC's?",,"Myself","NPCs"))
						if("Myself")
							savedid=usr.turnid
							src.battlers--
							usr.turnid=null
							src.organizedbattler-=usr
							for(var/atom/a in src.organizedbattler)
								if(a.turnid>savedid)
									a.turnid--
						if("NPCs")
							var/list/nlist=new
							var/loop=1
							var/atom/choice
							for(var/obj/npc/n in src.organizedbattler)
								if(n.owner==usr.key)
									nlist+=n
							while(loop)
								choice=null
								choice=input("Which NPCs do you wish to remove?") as null|anything in nlist
								if(choice==null)
									loop=0
								else
									savedid=choice.turnid
									src.battlers--
									choice.turnid=null
									src.organizedbattler-=choice
									for(var/atom/a in src.organizedbattler)
										if(a.turnid>savedid)
											a.turnid--
				if("Pass Turn")
					var/prevturn=currentbat
					var/atom/movable/a3=ObjtoFighter(currentbat)
					if(a3==usr|src.owner==usr.key)
						var/turn
						for(var/obj/trackerind/t in a3.vis_contents)
							del(t)
						turn=currentbat.turnid+1
						if(turn>src.battlers)
							turn=1
							src.round++
						var/atom/movable/f
						var/atom/a2
						while(!f && length(organizedbattler))
							for(var/atom/a in src.organizedbattler)
								if(a.turnid==turn)
									f=ObjtoFighter(a)
									a2=a
							if(!f)
								turn++
						src.currentbat=a2
						var/obj/trackerind/t=new
						f.vis_contents+=t
						view(25) << output("<b><font color=[usr.textcolor]>[prevturn]</b> has finished their turn, it is now <b>[src.currentbat]'s</b> turn. Let's see what they can do!","icout")
						winset(src.currentbat,"default", "flash=-1")
					else
						alert("It's not your turn")
						return
				if("Start")
					var/starter
					src.started=1
					src.Organizebattlers()
					for(var/atom/movable/a in src.organizedbattler)
						if(a.turnid==1)
							var/atom/movable/f=ObjtoFighter(a)
							src.currentbat=a
							var/obj/trackerind/t=new
							f.vis_contents+=t
							starter=f.name
					view(25) << output("<b>The battle has started!</b> The first to battle will be <b><font color=#8ED69A>[starter]</font>!","icout")

				if("End Battle")
					for(var/atom/a in src.battlelist)
						a.turnid=0
					usr.turntracker=0
					for(var/atom/movable/a in view())
						for(var/obj/trackerind/t in a.vis_contents)
							del(t)
					view(25) << output("<b>The battle has ended.</b>","icout")
					del(src)
		proc
			Organizebattlers()
				var/atom/h
				var/batlist=1
				while(batlist)
					for(var/atom/a in src.battlelist)
						if(a==null)
							batlist=0
						if(h==null)
							h=a
						else
							if(a.initroll>=h.initroll)
								h=a
					src.battlelist-=h
					var/obj/o=new
					o.name=h.name
					src.organizedbattler+=o
					if(src.battlers==0)
						o.turnid=1
						src.battlers++
					else
						o.turnid=src.battlers+1
						battlers++
					h=null
			ObjtoFighter(var/obj/o)
				for(var/atom/a in view(src))
					if(o.name==a.name)
						return a




