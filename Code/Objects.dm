obj
	proc
		CheckKey(var/mob/m,var/obj/Builds/Buildobjects/Door/a)
			for(var/obj/item/Key/k in m.contents)
				if(k.password==a.password)
					return 1
				else
					return 0


obj
	Builds
		var/closedstate
		var/openstate
		var/inside=0
		Buildobjects
			Door
				isdoor=1
				root=0
				density=1
				opacity=1
				layer=5
				var/lockid
				var/locked=1
				var/open
				verb
					Lock()
						set src in view(10,usr)
						if(src.locked)
							if(src.CheckKey(usr,src))
								src.locked=0
								view()<<output("[usr.name] unlocks the door.","icout")
							else
								alert("You don't have the key to this door.")
						else
							if(src.CheckKey(usr))
								src.locked=1
								view()<<output("[usr.name] locks the door.","icout")
							else
								alert("You don't have the key to this door.")
					Open()
						set src in view(10,usr)
						if(src.locked)
							alert("This door is currently locked.")
							return
						if(src.open)
							src.open=0
							src.icon_state=closedstate
							src.density=1
							if(src.inside==1)
								src.opacity=1
						else
							src.open=1
							src.icon_state=openstate
							src.density=0
							src.opacity=0

				Door1
					name="Inside Door"
					icon='Map Icons/Doors.dmi'
					icon_state="Closed1"
					closedstate="Closed1"
					openstate="Open1"
					inside=1
				DoorOutside
					name="Outside Door"
					icon='Map Icons/Doors.dmi'
					icon_state="Closed1"
					closedstate="Closed1"
					openstate="Open1"
					inside=0
obj
	Effects
		ForceField
			density=1
			var/Password
			var/Health
			var/LogPEndurance
			var/FieldPassword
			icon='Tech.dmi'
			icon_state="ForceField"