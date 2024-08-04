obj
	Pilot
		icon='Factiongiver.png'
		density=1
		Savable=0
		Click()
			var/list/destinations = new
			for(var/obj/Destinationflag/D in world)
				destinations+=D
			var/obj/Destinationflag/place = input("Aye, where you wishing to go?") as null|anything in destinations
			if(place==null)
				return
			if(place.travelprice>usr.money)
				alert(usr,"You don't have enough Gil!")
				return
			var/turf/dest_turf = get_turf(place)
			if(!dest_turf)
				alert(usr, "no destination turf found; THIS IS A BUG. Please report this: [place.name]")
				CRASH("couldn't find dest turf for fast travel")
			usr.force_move(dest_turf)
			usr.money-=place.travelprice

	Destinationflag
		var/travelprice
		icon=null
		Savable=0
		Insomnia
			travelprice=50
			name="Insomnia"
		Midgar
			travelprice=50
			name="Midgar"
		Yevon
			travelprice=50
			name="Yevon"
		Baron
			travelprice=10
			name="Baron"
		Tycoon
			travelprice=10
			name="Tycoon"
		Zanarkand
			travelprice=10
			name="Zanarkand"
		CostaDelSol
			travelprice=10
			name="Costa Del Sol"
