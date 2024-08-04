/atom
	var/vehicletype

/obj
	var/vehicle = FALSE

/mob
	var/tmp/currentship

/obj/VehicleInterior/Shipoutside
	layer=2
	icon='Icons/Ship.png'

/obj/VehicleInterior/Airshipoutside
	layer=2
	icon='Icons/Airship.png'

/obj/map/Roverwindow
	icon='Roverwindow.dmi'

/obj/map/Roverwindow/WindowL
	icon_state="Left"

/obj/map/Roverwindow/WindowR
	icon_state="Right"

/obj/map/Roverwindow/WindowM
	icon_state="Middle"

/mob/Bump(obj/Special/A)
	if(istype(A,/obj/Special/Teleporter)&&!(istype(A, /obj/Special/SpecialTele)))
		var/obj/Special/Teleporter/_tp=A
		if(A.teltype=="mapY")
			transit_move(locate(_tp.gotoX,src.y,_tp.gotoZ))
			return
		if(A.teltype=="mapX")
			transit_move(locate(src.x,_tp.gotoY,_tp.gotoZ))
			return
		if(A.teltype=="normal")
			transit_move(locate(_tp.gotoX,_tp.gotoY,_tp.gotoZ))
			return
		if(A.teltype=="area")
			transit_move(locate(_tp.gotoX,_tp.gotoY,_tp.gotoZ))
			return

/obj/Bump(obj/Special/A)
	if(istype(A,/obj/Special/Teleporter)&&!(istype(A, /obj/Special/SpecialTele)))
		var/obj/Special/Teleporter/_tp=A
		if(A.teltype=="mapY")
			transit_move(locate(_tp.gotoX,src.y,_tp.gotoZ))
			return
		if(A.teltype=="mapX")
			transit_move(locate(src.x,_tp.gotoY,_tp.gotoZ))
			return
		if(A.teltype=="area")
			transit_move(locate(_tp.gotoX,_tp.gotoY,_tp.gotoZ))
			return

/obj/Special
	var/gotoX
	var/gotoY
	var/gotoZ
	var/teltype

/obj/Special/Teleporter
	density = TRUE

/obj/Special/Teleporter/Enter(atom/movable/AM, atom/oldloc)
	return FALSE

/obj/Special/Teleporter/MapwarperN
	teltype="mapX"
	gotoY=2

/obj/Special/Teleporter/MapwarperS
	teltype="mapX"
	gotoY=399

/obj/Special/Teleporter/MapwarperE
	teltype="mapY"
	gotoX=2

/obj/Special/Teleporter/MapwarperW
	teltype="mapY"
	gotoX=399

/obj/Special/Teleporter/Normalwarper
	teltype="normal"

/obj/Special/Teleporter/Areawarper
	teltype="area"


/obj/Special/SpecialTele

/obj/Special/SpecialTele/Housewarper

/obj/Special/SpecialTele/Townwarper

/obj/Vehicles
	Savable=0

/obj/Vehicles/Tech/Travel

/obj/Vehicles/Tech/Travel/Caravel
	var/pass = ""
	var/PodID
	var/tmp/obj/ShipConsole/TheConsole
	var/Recalled = 0
	password = "locked"
	pixel_x = -60
	pixel_y = -20
	name = "Caravel"
	icon='Icons/Ship.dmi'
	layer = 7
	density = TRUE
	vehicletype="ship"
	vehicle = TRUE

/obj/Vehicles/Tech/Travel/Caravel/verb/SetPassword()
	var/choice
	set src in view(4)
	if(usr.key != src.owner)
		alert(usr,"You are not the owner of this vehicle.")
		return
	else
		choice=input("What would you like to set the password to?","Vehicle")as text
		alert(usr,"Password set to [choice]")
		src.pass=choice

/obj/Vehicles/Tech/Travel/Caravel/verb/EnterVehicle()
	set name="Enter"
	var/choice
	choice = input("What is the password?","Vehicle")as text
	if(choice == src.pass)
		set src in view(4)
		if(!src.PodID)
			var/list/already=new
			usr<<"Assigning Ship ID..."
			for(var/obj/Vehicles/Tech/Travel/Caravel/W in world)
				already.Add(W.PodID)
			for(var/i=1, i<30, i++)
				if(already.Find(i))
					continue
				else
					src.PodID=i
					usr<<"ID assigned! ID is [i]."
					break
		if(src.TheConsole)
			usr.transit_move(get_turf(TheConsole), recurse_follow = 0)
			UpdateArea(usr)
			return
		else
			for(var/obj/ShipConsole/S in world)
				if(S.PodID == src.PodID)
					src.TheConsole = S
					usr.transit_move(get_turf(src.TheConsole), recurse_follow = 0)
					return
				usr << "Error! No ship consoles were found!"
	else
		alert(usr,"The password is incorrect.")

/obj/Vehicles/Tech/Travel/Caravel/Click()
	if(usr.client.eye == src)
		usr.client.perspective = MOB_PERSPECTIVE
		usr.client.eye = usr.client.mob
		if(usr.Control)
			src.TheConsole.Driver = null
			usr.Control = null

/obj/Vehicles/Tech/Travel/Airship
	var/pass=""
	var/AirshipID
	var/tmp/obj/AirshipConsole/TheConsole
	var/Recalled = 0
	password = "locked"
	pixel_x = -48
	pixel_y = -42
	name = "Airship"
	icon='Icons/Airship.dmi'
	layer = 7
	density = FALSE
	vehicletype="airship"
	vehicle = TRUE

/obj/Vehicles/Tech/Travel/Airship/verb/SetPassword()
	var/choice
	set src in view(4)
	if(usr.key != src.owner)
		alert(usr,"You are not the owner of this vehicle.")
		return
	else
		choice=input("What would you like to set the password to?","Vehicle")as text
		alert(usr,"Password set to [choice]")
		src.pass=choice

/obj/Vehicles/Tech/Travel/Airship/verb/EnterVehicle()
	set name="Enter"
	var/choice
	choice = input("What is the password?","Vehicle")as text
	if(choice == src.pass)
		set src in view(4)
		if(!src.AirshipID)
			var/list/already=new
			usr<<"Assigning Ship ID..."
			for(var/obj/Vehicles/Tech/Travel/Airship/W in world)
				already.Add(W.AirshipID)
			for(var/i=1, i<30, i++)
				if(already.Find(i))
					continue
				else
					src.AirshipID=i
					usr<<"ID assigned! ID is [i]."
					break
		if(src.TheConsole)
			usr.transit_move(get_turf(src.TheConsole), recurse_follow = 0)
			UpdateArea(usr)
			return
		else
			for(var/obj/AirshipConsole/S in world)
				if(S.AirshipID == src.AirshipID)
					src.TheConsole = S
					usr.transit_move(get_turf(src.TheConsole), recurse_follow = 0)
					return
				usr << "Error! No ship consoles were found!"
	else
		alert(usr,"The password is incorrect.")

/obj/Vehicles/Tech/Travel/Airship/Click()
	if(usr.client.eye == src)
		usr.client.perspective = MOB_PERSPECTIVE
		usr.client.eye = usr.client.mob
		if(usr.Control)
			src.TheConsole.Driver = null
			usr.Control = null
	winset(usr,"aircontrol","is-visible=false")

/obj/Vehicles/Tech/Travel/Balamb
	var/pass=""
	var/AirshipID="Balamb"
	var/tmp/obj/BalambConsole/TheConsole
	var/tmp/obj/BalambDoor/TheDoor
	var/Recalled = 0
	password = "locked"
	pixel_x = -48
	pixel_y = -42
	name = "Balamb Garden"
	icon='Icons/Balamb.dmi'
	layer=7
	density=1
	vehicletype="airship"
	vehicle = TRUE

/obj/Vehicles/Tech/Travel/Balamb/verb/SetPassword()
	var/choice
	set src in view(4)
	if(usr.key != src.owner)
		alert(usr,"You are not the owner of this vehicle.")
		return
	else
		choice=input("What would you like to set the password to?","Vehicle")as text
		alert(usr,"Password set to [choice]")
		src.pass=choice

/obj/Vehicles/Tech/Travel/Balamb/verb/EnterVehicle()
	set name="Enter"
	var/choice
	choice = input("What is the password?","Vehicle")as text
	if(choice == src.pass)
		set src in view(30)
		if(!src.AirshipID)
			var/list/already=new
			usr<<"Assigning Ship ID..."
			for(var/obj/Vehicles/Tech/Travel/Balamb/W in world)
				already.Add(W.AirshipID)
			for(var/i=1, i<30, i++)
				if(already.Find(i))
					continue
				else
					src.AirshipID=i
					usr<<"ID assigned! ID is [i]."
					break
		if(src.TheDoor)
			usr.transit_move(get_turf(src.TheDoor), recurse_follow = 0)
			return
		else
			for(var/obj/BalambDoor/S in world)
				if(S.AirshipID == src.AirshipID)
					src.TheDoor = S
					usr.transit_move(get_turf(src.TheDoor), recurse_follow = 0)
					UpdateArea(usr)
					return
				usr << "Error! No ship consoles were found!"
	else
		alert(usr,"The password is incorrect.")

/obj/Vehicles/Tech/Travel/Balamb/Click()
	if(usr.client.eye == src)
		usr.client.perspective = MOB_PERSPECTIVE
		usr.client.eye = usr.client.mob
		if(usr.Control)
			src.TheConsole.Driver = null
			usr.Control = null
	winset(usr,"aircontrol","is-visible=false")

/obj/Vehicles/Tech/Travel/Rover
	var/pass=""
	var/RoverID
	var/tmp/obj/RoverConsole/TheConsole
	var/Recalled = 0
	password = "locked"
	pixel_x =  -92
	pixel_y = -64
	name = "Rover"
	icon='Icons/Landrover.dmi'
	layer=7
	density=1
	vehicletype="player"
	vehicle=1
	waterwalking=0

/obj/Vehicles/Tech/Travel/Rover/verb/SetPassword()
	var/choice
	set src in view(4)
	if(usr.key != src.owner)
		alert(usr,"You are not the owner of this vehicle.")
		return
	else
		choice=input("What would you like to set the password to?","Vehicle")as text
		alert(usr,"Password set to [choice]")
		src.pass=choice

/obj/Vehicles/Tech/Travel/Rover/verb/EnterVehicle()
	set name="Enter"
	var/choice
	choice = input("What is the password?","Vehicle")as text
	if(choice == src.pass)
		set src in view(4)
		if(!src.RoverID)
			var/list/already=new
			usr<<"Assigning Ship ID..."
			for(var/obj/Vehicles/Tech/Travel/Rover/W in world)
				already.Add(W.RoverID)
			for(var/i=1, i<40, i++)
				if(already.Find(i))
					continue
				else
					src.RoverID=i
					usr<<"ID assigned! ID is [i]."
					break
		if(src.TheConsole)
			usr.transit_move(get_turf(src.TheConsole), recurse_follow = 0)
			UpdateArea(usr)
			return
		else
			for(var/obj/RoverConsole/S in world)
				if(S.RoverID == src.RoverID)
					src.TheConsole = S
					usr.transit_move(get_turf(src.TheConsole), recurse_follow = 0)
					UpdateArea(usr)
					return
				usr << "Error! No ship consoles were found!"
	else
		alert(usr,"The password is incorrect.")

/obj/Vehicles/Tech/Travel/Rover/Click()
	if(usr.client.eye == src)
		usr.client.perspective = MOB_PERSPECTIVE
		usr.client.eye = usr.client.mob
		if(usr.Control)
			src.TheConsole.Driver = null
			usr.Control = null

/obj/ShipConsole
	name = "Steering Wheel"
	density = TRUE
	layer = 3
	var/Launching
	var/SpeakerToggle=0
	var/PodID
	var/tmp/obj/Vehicles/Tech/Travel/Caravel/ThePod
	var/tmp/mob/Driver

/obj/ShipConsole/verb/Pilot()
	set src in oview(5)
	if(src.PodID==0)
		src.PodID=usr.currentship
	if(src.Driver)
		if(src.Driver == usr)
			usr.Control = null
			usr.client.perspective = MOB_PERSPECTIVE//Returns your perspective back to the player
			usr.client.eye = usr.client.mob
			src.Driver = null
			return
		else
			usr << "Someone else is driving!"
	else
		if(src.ThePod)
			usr.Control=src.ThePod
			usr.client.perspective=EYE_PERSPECTIVE
			usr.client.eye=src.ThePod
			src.Driver = usr
		else
			for(var/obj/Vehicles/Tech/Travel/Caravel/S in world)
				if(S.PodID == src.PodID)
					src.ThePod = S
					usr.Control = S
					usr.client.perspective = EYE_PERSPECTIVE
					usr.client.eye = S
					src.Driver = usr
					return

/obj/ShipConsole/proc/shitcode_detect_vehicle()
	RETURN_TYPE(/obj/Vehicle)
	if(src.ThePod)
		return ThePod
	for(var/obj/Vehicles/Tech/Travel/Caravel/S in world)
		if(S.PodID == PodID)
			src.ThePod = S

/obj/ShipConsole/verb/Leave()
	set src in oview(5)
	shitcode_detect_vehicle()
	if(src.ThePod)
		view(10,usr)<<"[usr] leaves the ship."
		usr.transit_move(get_turf(ThePod), recurse_follow = 0)
		return
//	usr.SendToSpawn() // If the pod has been deleted, sends user to spawn instead of a void.//

/obj/ShipConsole/verb/View()
	set src in oview(5)
	if(src.ThePod)
		if(usr.client.eye == src.ThePod)
			usr.client.perspective = MOB_PERSPECTIVE
			usr.client.eye = usr.client.mob
		else
			usr.client.perspective=EYE_PERSPECTIVE
			usr.client.eye=src.ThePod

/obj/RoverConsole
	name = "Steering Wheel"
	icon='Lab.dmi'
	icon_state="scan1"
	density = TRUE
	layer = 3
	var/Launching
	var/SpeakerToggle=0
	var/RoverID
	var/tmp/obj/Vehicles/Tech/Travel/Rover/ThePod
	var/tmp/mob/Driver

/obj/RoverConsole/verb/Pilot()
	set src in oview(5)
	if(src.RoverID==0)
		src.RoverID=usr.currentship
	if(src.Driver)
		if(src.Driver == usr)
			usr.Control = null
			usr.client.perspective = MOB_PERSPECTIVE//Returns your perspective back to the player
			usr.client.eye = usr.client.mob
			src.Driver = null
			return
		else
			usr << "Someone else is driving!"
	else
		if(src.ThePod)
			usr.Control=src.ThePod
			usr.client.perspective=EYE_PERSPECTIVE
			usr.client.eye=src.ThePod
			src.Driver = usr
		else
			for(var/obj/Vehicles/Tech/Travel/Rover/S in world)
				if(S.RoverID == src.RoverID)
					src.ThePod = S
					usr.Control = S
					usr.client.perspective = EYE_PERSPECTIVE
					usr.client.eye = S
					src.Driver = usr
					return

/obj/RoverConsole/proc/shitcode_detect_vehicle()
	RETURN_TYPE(/obj/Vehicle)
	if(src.ThePod)
		return ThePod
	for(var/obj/Vehicles/Tech/Travel/Rover/S in world)
		if(S.RoverID == RoverID)
			src.ThePod = S

/obj/RoverConsole/verb/Leave()
	set src in oview(5)
	shitcode_detect_vehicle()
	if(src.ThePod)
		view(10,usr)<<"[usr] leaves the ship."
		usr.transit_move(get_turf(ThePod), recurse_follow = 0)
		return
//	usr.SendToSpawn() // If the pod has been deleted, sends user to spawn instead of a void.//

/obj/RoverConsole/verb/View()
	set src in oview(5)
	if(src.ThePod)
		if(usr.client.eye == src.ThePod)
			usr.client.perspective = MOB_PERSPECTIVE
			usr.client.eye = usr.client.mob
		else
			usr.client.perspective=EYE_PERSPECTIVE
			usr.client.eye=src.ThePod

/obj/AirshipConsole
	name = "Steering Wheel"
	density = TRUE
	layer = 3
	var/Launching
	var/SpeakerToggle=0
	var/AirshipID
	var/tmp/obj/Vehicles/Tech/Travel/Airship/ThePod
	var/tmp/mob/Driver

/obj/AirshipConsole/verb/Raise()
	set src in range(5,usr)
	for(var/obj/Vehicles/Tech/Travel/Airship/S in world)
		if(S.AirshipID == src.AirshipID)
			S.density=0
	alert(usr,"You have raised the Airship to Air elevation!")

/obj/AirshipConsole/verb/Lower()
	set src in range(5,usr)
	for(var/obj/Vehicles/Tech/Travel/Airship/S in world)
		if(S.AirshipID == src.AirshipID)
			S.density=1
	alert(usr,"You have lowered the Airship to ground elevation!")

/obj/AirshipConsole/verb/Pilot()
	set src in oview(5)
	if(src.AirshipID==0)
		src.AirshipID=usr.currentship
	winset(usr,"aircontrol","is-visible=true")
	if(src.Driver)
		if(src.Driver == usr)
			usr.Control = null
			usr.client.perspective = MOB_PERSPECTIVE//Returns your perspective back to the player
			usr.client.eye = usr.client.mob
			src.Driver = null
			return
		else
			usr << "Someone else is driving!"
	else
		if(src.ThePod)
			usr.Control=src.ThePod
			usr.client.perspective=EYE_PERSPECTIVE
			usr.client.eye=src.ThePod
			src.Driver = usr
		else
			for(var/obj/Vehicles/Tech/Travel/Airship/S in world)
				if(S.AirshipID == src.AirshipID)
					src.ThePod = S
					usr.Control = S
					usr.client.perspective = EYE_PERSPECTIVE
					usr.client.eye = S
					src.Driver = usr
					return

/obj/AirshipConsole/proc/shitcode_detect_vehicle()
	RETURN_TYPE(/obj/Vehicle)
	if(src.ThePod)
		return ThePod
	for(var/obj/Vehicles/Tech/Travel/Airship/S in world)
		if(S.AirshipID == AirshipID)
			src.ThePod = S

/obj/AirshipConsole/verb/Leave()
	set src in oview(5)
	shitcode_detect_vehicle()
	if(src.ThePod)
		view(10,usr)<<"[usr] leaves the ship."
		usr.transit_move(get_turf(ThePod), recurse_follow = 0)
		return
//	usr.SendToSpawn() // If the pod has been deleted, sends user to spawn instead of a void.//

/obj/AirshipConsole/verb/View()
	set src in oview(5)
	if(src.ThePod)
		if(usr.client.eye == src.ThePod)
			usr.client.perspective = MOB_PERSPECTIVE
			usr.client.eye = usr.client.mob
		else
			usr.client.perspective=EYE_PERSPECTIVE
			usr.client.eye=src.ThePod

/obj/BalambDoor
	name="Garden Door"
	icon='Map Icons/Doors.dmi'
	icon_state="Closed1"
	density=1
	var/AirshipID="Balamb"
	var/tmp/obj/Vehicles/Tech/Travel/Airship/ThePod

/obj/BalambDoor/Click()
	for(var/obj/Vehicles/Tech/Travel/Balamb/S in world)
		if(S.AirshipID == src.AirshipID)
			src.ThePod = S
	usr.x=ThePod.x
	usr.y=ThePod.y
	usr.z=ThePod.z

/obj/BalambConsole
	name = "Steering Wheel"
	icon='Lab.dmi'
	icon_state="scan1"
	var/Launching
	var/SpeakerToggle=0
	var/AirshipID="Balamb"
	var/tmp/obj/Vehicles/Tech/Travel/Balamb/ThePod
	var/tmp/mob/Driver
	density = TRUE
	layer = 3

/obj/BalambConsole/verb/Raise()
	set src in range(5,usr)
	for(var/obj/Vehicles/Tech/Travel/Balamb/S in world)
		if(S.AirshipID == src.AirshipID)
			S.density=0
	alert(usr,"You have raised the Airship to Air elevation!")

/obj/BalambConsole/verb/Lower()
	set src in range(5,usr)
	for(var/obj/Vehicles/Tech/Travel/Balamb/S in world)
		if(S.AirshipID == src.AirshipID)
			S.density=1
	alert(usr,"You have lowered the Airship to ground elevation!")

/obj/BalambConsole/verb/Pilot()
	set src in oview(5)
	if(src.AirshipID==0)
		src.AirshipID=usr.currentship
	winset(usr,"aircontrol","is-visible=true")
	if(src.Driver)
		if(src.Driver == usr)
			usr.Control = null
			usr.client.perspective = MOB_PERSPECTIVE//Returns your perspective back to the player
			usr.client.eye = usr.client.mob
			src.Driver = null
			return
		else
			usr << "Someone else is driving!"
	else
		if(src.ThePod)
			usr.Control=src.ThePod
			usr.client.perspective=EYE_PERSPECTIVE
			usr.client.eye=src.ThePod
			src.Driver = usr
		else
			for(var/obj/Vehicles/Tech/Travel/Airship/S in world)
				if(S.AirshipID == src.AirshipID)
					src.ThePod = S
					usr.Control = S
					usr.client.perspective = EYE_PERSPECTIVE
					usr.client.eye = S
					src.Driver = usr
					return

/obj/BalambConsole/proc/shitcode_detect_vehicle()
	RETURN_TYPE(/obj/Vehicle)
	if(src.ThePod)
		return ThePod
	for(var/obj/Vehicles/Tech/Travel/Airship/S in world)
		if(S.AirshipID == AirshipID)
			src.ThePod = S

/obj/BalambConsole/verb/Leave()
	set src in oview(5)
	shitcode_detect_vehicle()
	if(src.ThePod)
		view(10,usr)<<"[usr] leaves the ship."
		usr.transit_move(get_turf(ThePod), recurse_follow = 0)
		return
//	usr.SendToSpawn() // If the pod has been deleted, sends user to spawn instead of a void.//

/obj/BalambConsole/verb/View()
	set src in oview(5)
	if(src.ThePod)
		if(usr.client.eye == src.ThePod)
			usr.client.perspective = MOB_PERSPECTIVE
			usr.client.eye = usr.client.mob
		else
			usr.client.perspective=EYE_PERSPECTIVE
			usr.client.eye=src.ThePod

/client/North()
	if(mob.Control && isobj(mob.Control))
		step(mob.Control, NORTH)
		return 0
	..()

/client/South()
	if(mob.Control && isobj(mob.Control))
		step(mob.Control, SOUTH)
		return 0
	..()

/client/East()
	if(mob.Control && isobj(mob.Control))
		step(mob.Control, EAST)
		return 0
	..()

/client/West()
	if(mob.Control && isobj(mob.Control))
		step(mob.Control, WEST)
		return 0
	..()

/client/Northeast()
	if(mob.Control && isobj(mob.Control))
		step(mob.Control, NORTHEAST)
		return 0
	..()

/client/Northwest()
	if(mob.Control && isobj(mob.Control))
		step(mob.Control, NORTHWEST)
		return 0
	..()

/client/Southeast()
	if(mob.Control && isobj(mob.Control))
		step(mob.Control, SOUTHEAST)
		return 0
	..()

/client/Southwest()
	if(mob.Control && isobj(mob.Control))
		step(mob.Control, SOUTHWEST)
		return 0
	..()

/mob
	var/tmp/obj/Control

/mob/ImStuck()
	if(Control)
		alert_interaction_fail("You're controlling something. We can't let you ImStuck or you'll break something important. Reconnect if you need to get out of here.")
		return
	. = ..()

/mob/transit_move(atom/newloc, list/recursed, recurse_pull, recurse_follow)
	if(Control)
		return FALSE	// nope
	. = ..()

