
obj
	RPflag
		icon='RPflag.dmi'
		Savable=1
		layer=5
		Click()
			usr<<output("<font color=#00FFFF> <b> [src.desc]</font>","oocout")
			if(src.owner==usr.key)
				switch(alert(usr,"Do you wish to edit or delete this flag?",,"Edit","Delete","Cancel"))
					if("Edit")
						var/newdesc=input("") as message
						src.desc=newdesc
					if("Delete")
						usr.rpflags--
						del(src)
					if("Cancel")
						return
	RPobject
		New()
			.=..()
			spawn()
				var/obj/RPflag/R =new
				R.loc=locate(src.x,src.y,src.z)
				R.mouse_opacity=0
		var
			list/attempts=new
			goal
		Rock
			icon='Rock.dmi'
			density = 1
			goal=10
			Click()
				for(var/obj/RPobject/R in view(1))
					if(usr.ckey in R.attempts)
						alert("You need to wait to try this again.")
						return
					switch(alert("Do you wish to try and push this rock?",,"Yes","No"))
						if("Yes")
							var/result =rand(1,20)
							if(result==20)
								usr << output("<font color=#ff3333>WOW A NAT 20!!!</font>","output1")
							if(result==1)
								usr << output("<font color=#ff3333>Curses...a nat 1</font>","output1")
							var/oresult=result
							result+=usr.strmod
							usr << output("<font color=#ffff99>([usr])Strength Roll:[oresult]+[usr.strmod]=[result]</font>","output1")
							if(result>R.goal||oresult==20)
								usr<<output("You muster up the strength to push the rock.","output1")
								R.loc=locate(R.x-1,R.y,R.z)
							else
								usr<<output("You were unable to move the rock..","output1")
								R.attempts+=usr.ckey
								spawn(100)
								R.attempts-=usr.ckey
						if("No")
							return

mob/var/rpflags
mob/verb
	SetRPFlag()
		if(usr.adminlv<1)
			if(usr.rpflags>=10)
				alert("You have too many flags in the world already.")
				return
		var/obj/RPflag/r=new
		var/inpu=input("Set the description for the flag") as message
		r.desc=inpu
		r.loc=locate(usr.x,usr.y,usr.z)
		r.owner=usr.key
		usr.rpflags++
		if(usr.adminlv>=1)
			r.icon_state="admin"
		else
			r.icon_state="player"



///Mog Dungeon Objects