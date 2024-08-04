mob
	var/areain

atom
	proc
		UpdateArea(var/mob/user)
			for(var/area/a in view(1,user))
				if(user.areain!=a.locid)
					user.areain=a.locid
				if(user.areain==a.locid)
					return

obj
	loccard
		screen_loc="NORTHWEST"
		alpha=0
		Baron
			icon='Icons/Plaques/Baron.png'

area
	layer=99
	var/outside=1
	var/locid
	var/obj/loccard/card
	var/theme
	mouse_opacity=0
	Entered(mob/a)
		if(a.areain!=src.locid)
			a.areain=src.locid
			Flashplaque(a,src)
		return 1
	Baron
		name="Baron"
		locid="Baron"
		card= new /obj/loccard/Baron

	Insomnia
		name="Insomnia"
		locid="Insomnia"


	MidgarField
		name="Midgar Field"
		locid="Midgar Field"

	BigBridge
		name="The Big Bridge"
		locid="The Big Bridge"

	Reactor
		name="Nibel Reactor"
		locid="Nibel Reactor"

	Nibelvillage
		name="Nibel Village"
		locid="Nibel Village"

	MtNibel
		name="Mt Nibel"
		locid="Mt Nibel"

	PortJunon
		name="Junon"
		locid="Junon"

	Kaipo
		name="Kaipo"
		locid="Kaipo"

	WestLucia
		name="West Lucia"
		locid="West Lucia"
	MountMysidia
		name="Mount Mysidia"
		locid="Mount Mysidia"
	Wutai
		name="Wutai"
		locid="Wutai"
	HuanGao
		name="Huan Gao"
		locid="Huan Gao"

	SpiraWest
		name="Spira West"
		locid="Spira West"

	SpiraEast
		name="Spira East"
		locid="Spira East"
	SpiraSouth
		name="Spira South"
		locid="Spira South"
	MtLucis
		name="Mt Lucis"
		locid="Mt Lucis"

	ManderWest
		name="Mander Desert West"
		locid="Mander Desert West"

	ManderEast
		name="Mander Desert East"
		locid="Mander Desert East"

	Tycoon
		name="Tycoon"
		locid="Tycoon"

	MtMysidia
		name="Mt Mysidia"
		locid="Mt Mysidia"

	Mysidia
		name="Mysidia"
		locid="Mysidia"

	Zanarkand
		name="Zanarkand"
		locid="Zanarkand"

	Yevon
		name="Sovereign of Yevon"
		locid="Sovereign of Yevon"

	CostaDelSol
		name="Costa Del Sol"
		locid="Costa Del Sol"

	MidgarCity
		name="Midgar City"
		locid="Midgar City"
	Bastok
		name="Port Bastok"
		locid="Port Bastok"

	Airship
		outside=0
		name="Airship"
		locid="Airship"
	Ship
		outside=0
		name="Ship"
		locid="Ship"
	Rover
		outside=0
		name="Rover"
		locid="Rover"
	House
		outside=0
		name="House"
		locid="House"
	Fortress
		outside=0
		name="Fortress"
		locid="Fortress"
	Dungeon
		outside=0
		name="Dungeon"
		locid="Dungeon"



proc
	Flashplaque(var/mob/m,var/area/a)
		var/obj/loccard/ncard=copyatom(a.card)
		if(!ncard)
			return
		animate(ncard,alpha=255,time=30)
		m.client.screen+=ncard
		sleep(50)
		del(ncard)
