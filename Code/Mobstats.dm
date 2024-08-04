mob/var
	editing=0

	maxfates=5

	money=100
	housemade=0
	totalpasses=0
	buildmode=0
	perkbuying=0
	stockcasting=0
	infusion=""

	list/nolearn = new

	faction

	ghosticon
	ghostovers
	rankchecked=0

	minednodes=0
	maxnodes=5

	job="None"
	subjob="None"
	ajob="None"
	race
	role
	dailyfates=0
	rank="Fledgling"
	rankbonus=1
	stockdrawn=0
	turntracker=0
	monkbonus
	bposition
	usingfate=0
	Lifestreamraincooldown=0
	buysummons=0
	maxsummonsC=1
	maxsummonsB=0
	maxsummonsA=0
	Csummonslearned=0
	Bsummonslearned=0
	Asummonslearned=0
	FATEcooldown=0
	width
	height
	inparty=0
	partyID=null
	battler=0
	GSP=20
	Maxbuildings=4
	Currentbuildings=0

	rpp = 50
	trpp = 50

	acrobaticsproficient=0
	athleticsproficient=0
	archaeologyproficient=0
	deceptionproficient=0
	dungeoneeringproficient=0
	enchantmentproficient=0
	insightproficient=0
	investigationproficient=0
	magitekoperationproficient=0
	medicineproficient=0
	magicproficient=0
	naturalistproficient=0
	perceptionproficient=0
	persuasionproficient=0
	stealthproficient=0
	survivalproficient=0
	thieveryproficient=0



	ep=0
	tep=0

	baseac=10
	ac=0
	acmod=0
	basedr
	dr=0
	speed=3

	str = 10
	strcap=20
	addstr=0
	strmod=0
	dex = 10
	dexcap=20
	dexmod=0
	adddex=0
	con = 10
	concap=20
	conmod=0
	addcon=0
	int = 10
	intcap=20
	intmod=0
	addint=0
	wis = 10
	wiscap=20
	wismod=0
	addwis=0
	cha = 10
	chacap=20
	chamod=0
	addcha=0

	acrobatics=0
	baseacro=0
	athletics=0
	baseath=0
	archaeology=0
	basearc=0
	deception=0
	basedec=0
	dungeoneering=0
	basedung=0
	enchantment=0
	baseenchant=0
	insight=0
	basein=0
	investigation=0
	baseinv=0
	magic=0
	basemagic=0
	magitekOperation=0
	basemagio=0
	medicine=0
	basemed=0
	naturalist=0
	basenat=0
	perception=0
	baseper=0
	persuasion=0
	basepers=0
	stealth=0
	basestl=0
	thievery=0
	basethv=0
	survival=0
	basesurv=0

	reflexproficient=0
	willproficient=0
	fortitudeproficient=0
	reflexexpert=0
	willexpert=0
	fortitudeexpert=0
	baserflx=0
	rflx
	basewill=0
	will
	basefort=0
	fort

	mab
	mdb
	pab
	pdb
	tmp/mabadd=0 // These are SPECIFICALLY for Global Mods
	tmp/mdbadd=0
	tmp/pabadd=0
	tmp/pdbadd=0
	tmp/speedadd=0


	subjobcap=0
	subtechlearned=0
	subcabs=0

	target
	viewing
	makingitem
	teachslot=0
	maxteachslot=1
	list/history =new
	list/craftables=new
	list/shownperks=new
	age
	emoteamount
	rppchecks = 0
	rppcheckdate="Monday"
	aoetiles
	aoeclick
	encountclick
	aoeicon
	intitlescreen=1
	building
	stealthing
	initiative = 0
	carryweight=0
	carrylimit=0
	weeklycheck=0
	battletheme='Audio/03_Battle_to_the_Max.ogg'
	muted
	ghosting
	datejoined
	deploynpc
	npcsheet
	npclimit=0
	npcamount=0
	npcachoice
	eventmin
	tempeventmin
	obj/limitbreak
	limitbreakused
	craftingroles
	maxcraftingroles
	gatheringroles
	maxgatheringroles
	abilitypoints=10
	APspent=9000 //Hehefunny number for rework.
	APcap=10
	created
	advantage
	disadvantage
	grid
	obj/storage/storagelook
	tmp/craftingactive
	critmod=0

	obj/item/righthand
	obj/item/lefthand
	obj/item/armor
	obj/item/Materia/materia1=null
	obj/item/Materia/materia2=null
	obj/item/Materia/materia3=null
	obj/item/accessory1
	obj/item/accessory2
	list/weapontypes=new
	wpntypeamount
	wpntypemax=3
	whitemagicable
	blackmagicable
	greenmagicable
	arcanemagicable
	t1s=0
	t2s=0
	t3s=0
	t4s=0
	t5s=0
	t6s=0
	eabs=0
	dabs=0
	cabs=0
	babs=0
	aabs=0
	sabs=0


mob
	verb
		Raise()
			for(var/obj/AirshipConsole/air in range(5,usr))
				for(var/obj/Vehicles/Tech/Travel/Airship/S in world)
					if(S.AirshipID == air.AirshipID)
						S.density=0
				alert(usr,"You have raised the Airship to Air elevation!")
		Lower()
			for(var/obj/AirshipConsole/air in range(5,usr))
				for(var/obj/Vehicles/Tech/Travel/Airship/S in world)
					if(S.AirshipID == air.AirshipID)
						S.density=1
				alert(usr,"You have lowered the Airship to Ground elevation!")
		Screensize()
			var/width=input(usr,"Enter the width of the screen, max is 50.") as text
			var/height=input(usr,"Enter the height of the screen, max is 50.") as text
			if(width>50)
				usr.width=50
			if(width<1)
				usr.width=1
			if(height>50)
				usr.height=50
			if(height<1)
				usr.height=1
			usr.width = width
			usr.height = height
			client.view="[usr.width]x[usr.height]"

mob
	verb
		DisableMusic()
			usr << sound(null, 0, 0, 0, 0)
	verb
		ImStuck()
			var/turf/target
			if(isnull(starting_city))
				starting_city = input(src, "You do not have a starting city set, or it is invalid, for some reason. Please select it.", "I'm Stuck!") as null|anything in global.starting_cities
				if(isnull(starting_city))
					return
			switch(starting_city)
				if(STARTING_CITY_INSOMNIA)
					target = locate(200, 186, 1)
				if(STARTING_CITY_MIDGAR)
					target = locate(125, 297, 17)
				else
					starting_city = input(src, "You do not have a starting city set, or it is invalid, for some reason. Please select it.", "I'm Stuck!") as null|anything in global.starting_cities
					if(isnull(starting_city))
						return
			if(!isnull(target))
				force_move(target)
			else
				alert(src, "Invalid starting city / location. Contact an admin. Moving you to Insomnia.", "FUCK", "Okay")
				force_move(locate(200, 186, 1))
	verb
		Stealth()
			if(usr.stealthing)
				usr.stealthing=0
				usr.icon=usr.ghosticon
				usr.overlays=usr.ghostovers
			else
				usr.stealthing = 1
				while(usr.stealthing)
					sleep(100)
					for(var/mob/m in view())
						usr.Stealthcheck(usr,m)
					sleep(450)
		Opencontents()
			winset(usr,"Contentcheck","is-visible=true")
			var/row
			for(var/obj/o in usr.contents)
				row++
				usr << output(o,"tcontents:1,[row]")
		CustomRolls()
			var/row
			winset(usr,"customrolls","is-visible=true")
			winset(usr,"customrolls.list","cells=0x0")
			for(var/obj/customroll/A in usr.contents)
				row++
				usr<<output(A,"list:1,[row]")
		Newcroll()
			var/list/yesnolist = list("Yes","No")
			var/yesno = input("Would you like to create a new Custom Roll?") as anything in yesnolist
			switch(yesno)
				if("Yes")
					var/obj/customroll/croll=new
					var/list/typelist = list("Damage","Hit","Healing","Other")
					var/typechoice = input("Which type of roll will this be?") as anything in typelist
					switch(typechoice)
						if("Damage")
							croll.d1 = input("How many die will be rolled?") as num
							croll.d2 = input("How many sides does each die have?") as num
							croll.range1=croll.d1
							croll.range2=(croll.d1*croll.d2)
							croll.rolltype="Damage"
							alert(usr,"The base damage roll will be [croll.d1]d[croll.d2]. The minimum base roll will be [croll.range1], the maximum base roll will be [croll.range2].")
						if("Hit")
							croll.icon='Icons/Perk/Precise.png'
							croll.d1=1
							croll.d2=20
							croll.range1=1
							croll.range2=20
							croll.rolltype="Hit"
						if("Healing")
							croll.icon='Icons/Perk/Cure.png'
							croll.rolltype="Healing"
							croll.d1 = input("How many die will be rolled?") as num
							croll.d2 = input("How many sides does each die have?") as num
							croll.range1=croll.d1
							croll.range2=(croll.d1*croll.d2)
						if("Other")
							croll.icon='Icons/Perk/StatusCleanse.png'
							croll.rolltype="Other"
							croll.d1 = input("How many die will be rolled?") as num
							croll.d2 = input("How many sides does each die have?") as num
							croll.range1=croll.d1
							croll.range2=(croll.d1*croll.d2)
					var/list/bonusyesno = list("Yes","No")
					var/bonuschoice = input("Does this roll have a bonus?") as anything in bonusyesno
					switch(bonuschoice)
						if("Yes")
							croll.bonus = input ("What is this roll's bonus?") as num
						if("No")
							croll.bonus=0
					croll.name=input("What is the name of this roll?") as text
					alert(usr,"You have created [croll.name] as a [croll.rolltype] roll.")
					usr.contents+=croll
				if("No")
					return


obj
	customroll
		icon='Icons/Perk/GeneralWeapon.png'
		var/d1
		var/d2
		var/range1
		var/range2
		var/rolltype
		var/bonus
		verb
			Editroll()
				set name="Edit"
				set src in usr.contents
				var/list/choices=list("Die Amount","Max Roll","Name","Roll Type","Icon")
				var/choice=input(usr, "What would you like to change about this roll?") as anything in choices
				switch(choice)
					if("Die Amount")
						var/amount1=input("What is the amount of die to roll?") as num
						src.d1=amount1
					if("Max Roll")
						var/amount1=input("What is the max roll for the die?") as num
						src.d2=amount1
					if("Name")
						var/name1=input("What is the name of this roll?") as text
						src.name=name1
					if("Roll Type")
						var/list/typelist = list("Damage","Hit","Healing","Other")
						var/newroll=input("What is the type of roll?") as anything in typelist
						switch(newroll)
							if("Damage")
								src.rolltype="Damage"
							if("Hit")
								src.rolltype="Hit"
							if("Healing")
								src.rolltype="Healing"
							if("Other")
								src.rolltype="Other"
					if("Icon")
						var/icon/newicon = input("What is the new icon?") as icon
						src.icon=newicon
			Peek()
				set name="View Information"
				set src in usr.contents
				alert(usr,"[src.name] : [src.rolltype] | [src.d1] [src.d2]")
		DblClick()
			if(src.rolltype=="Damage")
				var/result=rand(src.range1,src.range2)+src.bonus
				view()<<output("<font size=1><font color=[usr.textcolor]>[usr.name]</font> has rolled a <b>[src.d1]d[src.d2]</b> <font color=[usr.textcolor]><b>[src.name]</font> damage roll with a bonus of <b>[src.bonus]</b>! Result: <font color=#FB963C><b>[result]</font></b>","icout")
			if(src.rolltype=="Healing")
				var/result=rand(src.range1,src.range2)+src.bonus
				view()<<output("<font size=1><font color=[usr.textcolor]>[usr.name]</font> has rolled a <b>[src.d1]d[src.d2]</b> <font color=[usr.textcolor]><b>[src.name]</font> healing roll with a bonus of <b>[src.bonus]</b>! Result: <font color=#5FFB3C><b>[result]</font></b>","icout")
			if(src.rolltype=="Hit")
				var/result=rand(src.range1,src.range2)+src.bonus
				view()<<output("<font size=1><font color=[usr.textcolor]>[usr.name]</font> has rolled a <b>[src.d1]d[src.d2]</b> <font color=[usr.textcolor]><b>[src.name]</font> to hit roll with a bonus of <b>[src.bonus]</b>! Result: <font color=#53FAC3><b>[result]</font></b>","icout")
			if(src.rolltype=="Other")
				var/result=rand(src.range1,src.range2)+src.bonus
				view()<<output("<font size=1><font color=[usr.textcolor]>[usr.name]</font> has rolled a <b>[src.d1]d[src.d2]</b> <font color=[usr.textcolor]><b>[src.name]</font> roll with a bonus of <b>[src.bonus]</b>! Result: <font color=#A2D1F1><b>[result]</font></b>","icout")
				return
obj
	customroll
		verb
			Delete()
				var/list/yesno=list("Yes","No")
				var/choice=input("Are you sure you wish to delete this Custom Roll?") as anything in yesno
				switch(choice)
					if("Yes")
						del src
					if("No")
						return

mob
	verb
		CheckProfile(mob/m in view(usr))
			set name="Profile"
			if(m==usr)
				return
			winset(usr,"Profile","is-visible=true")
			winset(usr,"Profile.ProfilePic","image=[m.profilepic]")
			winset(usr,"Profile.profile","is-visible=true")
			winset(usr,"Profile.Edit","is-visible=false")
			winset(usr,"Profile.Sheet","is-visible=false")
			usr<<browse(m.profile,"window=Profile.profile")
			usr.viewing=1
		Ping(mob/m in view(usr))
			if(m.client)
				winset(m,"default", "flash=-1")
				m<<output("<b>You've been pinged by [usr]!</b>","oocout")
		CheckMods(mob/m in view(usr))
			set name="Mods"
			var/row
			winset(usr,"GMandperk","is-visible=true")
			winset(usr,"GMandperk.c","is-visible=true")
			winset(usr,"GMandperk.gm","cells=0x0")
			for(var/obj/globalmod/g in m.contents)
				row++
				winset(usr, "Gmandperk.gm", "current-cell=1,[row]")
				usr << output(g,"GMandperk.gm")
				winset(usr, "GMandperk.gm", "current-cell=2,[row]")
				usr<<output(g.desc,"GMandperk.gm")
				winset(usr,"GMandperk.gm","current-cell=3,[row]")
				if(g.applied==1)
					usr<<output("Equipped","GMandperk.gm")
				else
					usr<<output("Unequipped","GMandperk.gm")
		SeeEquipmentOther(mob/m in view(usr))
			var/row
			set name="View Equipment"
			winset(usr,"Equipment","is-visible=true")
			winset(usr,"Equipment.player","is-visible=true")
			if(m.name == usr.name)
				winset(usr,"Equipment.player","is-visible=false")
			winset(usr,"Equipment.name","text=\"[m.name]\"")
			row++
			usr<<output(m,"Equipment.player:1,[row]")
			var/icon/I1 = icon(m.righthand.icon,"Yee",SOUTH,1,0)
			var/newPicture1 = fcopy_rsc(I1)
			winset(usr,"Equipment.RightHand","image=\ref[newPicture1]")
			var/icon/I2 = icon(m.lefthand.icon,"Yee",SOUTH,1,0)
			var/newPicture2 = fcopy_rsc(I2)
			winset(usr,"Equipment.LeftHand","image=\ref[newPicture2]")
			var/icon/I3 = icon(m.armor.icon,"Yee",SOUTH,1,0)
			var/newPicture3 = fcopy_rsc(I3)
			winset(usr,"Equipment.Armor","image=\ref[newPicture3]")
			var/icon/I4 = icon(m.materia1.icon,"Yee",SOUTH,1,0)
			var/newPicture4 = fcopy_rsc(I4)
			winset(usr,"Equipment.Materia1","image=\ref[newPicture4]")
			var/icon/I5 = icon(m.materia2.icon,"Yee",SOUTH,1,0)
			var/newPicture5 = fcopy_rsc(I5)
			winset(usr,"Equipment.Materia2","image=\ref[newPicture5]")
			var/icon/I6 = icon(m.materia3.icon,"Yee",SOUTH,1,0)
			var/newPicture6 = fcopy_rsc(I6)
			winset(usr,"Equipment.Materia3","image=\ref[newPicture6]")
			var/icon/I7 = icon(m.accessory1.icon,"Yee",SOUTH,1,0)
			var/newPicture7 = fcopy_rsc(I7)
			winset(usr,"Equipment.Accessory1","image=\ref[newPicture7]")
			var/icon/I8 = icon(m.accessory2.icon,"Yee",SOUTH,1,0)
			var/newPicture8 = fcopy_rsc(I8)
			winset(usr,"Equipment.Accessory2","image=\ref[newPicture8]")


