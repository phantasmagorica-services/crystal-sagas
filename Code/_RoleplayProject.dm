/*
	These are simple defaults for your project.
 */
atom
	var/savedx
	var/savedy
	var/savedz
	var/waterwalking=0
	var/retaliate=0

var/maxrovers=40
var/maxships=30
var/maxairships=30
var/totalships
var/totalrovers
var/totalairships
var/totalhouses
var/totalfortresses
var/maxhouses=100
var/maxfortresses=36

mob
	vehicletype="player"
	dummy
		icon='Icons/WhiteMaleBase.dmi'
		profile = "A dummy"
		rpp = 9001
		initiative=9
	dummy2
		icon = 'Icons/WhiteFemaleBase.dmi'
	dummy3
		icon='Rock.dmi'
	dummy4
		icon='Coin.dmi'
	dummy5
		icon='Zantetsuken.dmi'
	Mog
		icon='Icons/Moogle.dmi'
		density=1
		Click()
			Charcreate(usr)

LEGACY_GLOBAL_DATUM_INIT(perk_shop, /datum/global_perk_shop, new)
/**
 * global perk holder datum
 */
/datum/global_perk_shop
	/// holds perk /obj's
	var/list/perks = list()

LEGACY_GLOBAL_DATUM_INIT(recipe_shop, /datum/global_recipe_shop, new)
/**
 * global recipe holder datum
 */
/datum/global_recipe_shop
	/// holds recipe /obj's
	var/list/recipes = list()

LEGACY_GLOBAL_DATUM_INIT(stable_holder, /datum/global_stable_holder, new)
/**
 * global stable holder datum
 */
/datum/global_stable_holder
	/// holds monster /obj's
	var/list/monsters = list()

area
	default
		luminosity = 1
	Buildarea
		buildable=1
		luminosity=1

mob
	step_size = 32
	verb
		Checktime()
			usr<<output("[world.realtime]","output1")
			usr<<output("[time2text(world.realtime,"Day")]","output1")

var/list/Admin4= list("neogeo123","limb","mimikyuu","cenamderi3","nanaris","amlynn24","kyro17", "ragesaiyan")
var/list/Guado=list()
var/list/Cyborg=list()
var/list/Gnath=list()
var/list/Namazu=list()
var/list/Albhed=list()
var/list/Moogle=list()
var/list/Cetra=list("PurplePatoot","","")
var/list/Genome=list()
var/list/Golem=list("")
var/list/Timemage=list("silicons")
var/list/Lcie=list("","","")
var/list/Oracle=list("Da Boi Kyro","","","","")


obj
	Eye
		var/loops
		var/eye=1
		Wareye
		vehicletype="airship"
		density=0

	PlayGame
		icon='Playgame.png'
		screen_loc = "CENTER-7,CENTER-2"
		Click()
			usr.Play()
		MouseEntered()
			usr<<'Audio/Cursor Move.ogg'
			var/obj/Cursor/C = new /obj/Cursor
			C.screen_loc = screen_loc
			var/matrix/M = matrix()
			M.Translate(196, 0)
			C.transform = M
			spawn()
			usr.client.screen+=C
		MouseExited()
			for(var/obj/Cursor/C in usr.client.screen)
				del(C)
	Load
		icon='Loadgame.png'
		icon_state="load"
		screen_loc="CENTER+3,CENTER-2"
		Click()
			if(usr.intitlescreen!=1)
				return
			usr.Load()
		MouseEntered()
			usr<<'Audio/Cursor Move.ogg'
			var/obj/Cursor/C = new /obj/Cursor
			usr.client.screen+=C
			var/matrix/M = matrix()
			M.Translate(196, 0)
			C.transform = M
		MouseExited()
			for(var/obj/Cursor/C in usr.client.screen)
				del(C)
	Cursor
		icon='Icons/Cursor.dmi'

mob
	proc
		Play()
			if(load_mutex)
				return
			if(load_complete)
				return
			var/list/choices=list("Yes","No")
			var/choose=input(usr,"Are you sure you wish to make a new character?") as anything in choices
			switch(choose)
				if("Yes")
				if("No")
					return
			if(load_complete)
				return
			if(load_mutex)
				return
			client.images -= __lobby_image
			src.loc = locate(219,229,2)
			src.density=1
			src.icon = 'Icons/Ghostflame.dmi'
			src<<sound(null)
			sleep()
			src<< 'Audio/Cursor Ready.ogg'
			Giveperk()
			addLightPlane()
			setLightOverlay(outside_light)
			src.client.eye = src
			src.client.perspective = EYE_PERSPECTIVE
			src.intitlescreen=0
			for(var/obj/Eye/e in world)
				if(e.owner==usr.ckey)
					del(e)
			if(Admin4.Find(ckey) || client.is_localhost())
				adminlv = 4
				winset(src, "default.Adminbut", "is-visible=true")
				verbs += typesof(/mob/Admin/verb/)
			for(var/obj/o in usr.client.screen)
				del(o)
			for(var/image/i in usr.client.screen)
				del(i)
			src.rpp=startingrpp
			src.trpp=startingrpp
			Checkreward(usr)
			src.see_invisible=1
			src.datejoined = time2text(world.realtime,"MM-DD-YYYY")
			alert("Thank you for playing. The first step is to create your character. Before you do so it would be best to read over the systems in the ingame Encyclopedia, or the game's Discord server. Click the Moogle when you are ready to begin, but for now lets start with the basics.")
			src.name = input("What is your character's name?") as text
			if(src.name==null)
				src.name="Nobody"
			var/obj/recipes/Buildings/House/build1=new
			var/obj/recipes/Buildings/Fortress/build2=new
			usr.contents+=build1
			usr.contents+=build2
			RefreshCharsheet(usr)
			RefreshAll(usr)
			usr.rankchecked=1
			for(var/obj/item/b in materiallist)
				var/obj/item/a=copyatom(b)
				usr.contents+=a
			load_complete = TRUE
			AutoSave()
		Load()
			if(!fexists("data/save/character/[src.ckey]"))
				alert("You do not have a save file.")
				return
			if(load_complete)
				return
			if(load_mutex)
				return
			load_mutex = TRUE
			client.images -= __lobby_image
			src<<sound(null)
			sleep()
			src<< 'Audio/Cursor Ready.ogg'
			var/savefile/F = new("data/save/character/[src.ckey]")
			Read(F)
			F["x"]>>src.x
			F["y"]>>src.y
			F["z"]>>src.z
			src.loc = locate(src.x,src.y,src.z)
			src.density=1
			addLightPlane()
			setLightOverlay(outside_light)
			src.client.eye = src
			src.client.perspective = EYE_PERSPECTIVE
			src.intitlescreen=0
			for(var/obj/Eye/e in world)
				if(e.owner==usr.ckey)
					del(e)
			if(usr.adminlv >0)
				winset(src,"default.Adminbut","is-visible=true")
				winset(usr,"default.Nar","is-visible=true")
				usr.verbs+=typesof(/mob/Admin/verb/)
			if(usr.eventmin)
				usr.verbs+=typesof(/mob/eventmin/verb/)
			for(var/obj/o in usr.client.screen)
				del(o)
			for(var/image/i in usr.client.screen)
				del(i)
			src.aoetiles=0
			src.aoeclick=0
			src.building=0
			for(var/obj/Builds/b in usr.contents)
				del(b)
			usr.bposition=null
			usr.battler=0
			var/obj/cooldownchecker/chk = global.day_checker
			if(usr.totalpasses<chk.totalpasses)
				usr.stockdrawn=0
				usr.Lifestreamraincooldown=0
				usr.FATEcooldown=0
				usr.dailyfates=0
				usr.limitbreakused=0
				usr.tempeventmin=0
				usr.totalpasses=chk.totalpasses
				usr.minednodes=0
				//alert(usr,"You were logged out during a cooldown reset, so your cooldowns are now reset.")
			if(usr.eventmin || usr.tempeventmin)
				winset(usr,"default.Eventmin","is-visible=true")
			if(usr.rankchecked==0)
				if(usr.rank=="Fledgling")
					usr.rankchecked=1
				else
					if(usr.rank=="Rookie")
						usr.rankchecked=1
						usr.mhp+=40
						usr.hp+=40
						usr.msp+=40
						usr.sp+=40
						usr.mmp+=40
						usr.mp+=40
						usr.APcap=14
					if(usr.rank=="Adept")
						usr.mhp+=70
						usr.hp+=70
						usr.msp+=70
						usr.sp+=70
						usr.mmp+=70
						usr.mp+=70
						usr.APcap=18
					if(usr.rank=="Veteran")
						usr.mhp+=100
						usr.hp+=100
						usr.msp+=100
						usr.sp+=100
						usr.mmp+=100
						usr.mp+=100
						usr.APcap=22
						usr.strcap=22
						usr.dexcap=22
						usr.concap=22
						usr.intcap=22
						usr.wiscap=22
						usr.chacap=22
					if(usr.rank=="Hero")
						usr.mhp+=135
						usr.hp+=135
						usr.msp+=135
						usr.sp+=135
						usr.mmp+=135
						usr.mp+=135
						usr.APcap=26
						usr.strcap=24
						usr.dexcap=24
						usr.concap=24
						usr.intcap=24
						usr.wiscap=24
						usr.chacap=24
					if(usr.rank=="Master")
						usr.mhp+=180
						usr.hp+=180
						usr.msp+=180
						usr.sp+=180
						usr.mmp+=180
						usr.mp+=180
						usr.APcap=30
						usr.strcap=26
						usr.dexcap=26
						usr.concap=26
						usr.intcap=26
						usr.wiscap=26
						usr.chacap=26
					usr.rankchecked=1
					alert(usr,"You have been granted your HP, MP, and SP bonus for your current rank.")
			RefreshCharsheet(usr)
			usr.Refreshinventoryscreen()
			RefreshAll(usr)
			UpdateArea(usr)
			load_complete = TRUE
			load_mutex = FALSE
			AutoSave()
		Save()
			//? DO NOT REMOVE THIS CHECK UNDER ANY CIRCUMSTANCES.
			//  Explanation:
			//  If someone's in lobby and this triggers, due to the horrific
			//  lack of abstraction between player mobs and new players and
			//  the saving system, it will overwrite their save with their
			//  uninitialized mob.
			if(intitlescreen)
				return
			//? END
			if(!load_complete)
				return
			if(load_mutex)
				return
			load_mutex = TRUE
			if(key)
				if(!src.loc)
					load_mutex = FALSE
					return
				if(src.loc==locate(37,239,28))
					load_mutex = FALSE
					return
				var/savefile/F = new("data/save/character/[src.ckey]")
				F["x"]<<src.x
				F["y"]<<src.y
				F["z"]<<src.z
				Write(F)
			load_mutex = FALSE
		AutoSave()
			Save()
			spawn(6000)
				AutoSave()

// todo: refactor
/mob/var/tmp/image/__lobby_image
/proc/__init_lobby_logo()
	RETURN_TYPE(/image)
	var/image/I = image('PNG/FFTCSlogo2.png')
	I.layer = 99
	I.pixel_x=-115
	I.pixel_y=70
	return I

mob
	Login()
		sleep()
		src.step_size=32
		src<< 'Audio/Prelude.ogg'
		var/matrix/M = matrix()
		M.Scale(2,2)
		src.intitlescreen=1
		src.density=0
		src.loc=locate(245,17,8)
		var/obj/Eye/E = new /obj/Eye
		E.loc = src.loc
		E.owner = src.ckey
		src.client.eye = E
		src.client.perspective = EYE_PERSPECTIVE
		var/obj/PlayGame/G = new /obj/PlayGame
		var/obj/Load/L = new /obj/Load
		__lobby_image = __init_lobby_logo()
		__lobby_image.alpha = 0
		client.images += __lobby_image
		animate(__lobby_image,alpha=255,time=50)
		animate(__lobby_image,transform=M ,time=50)
		src.client.screen+=G
		src.client.screen+=L
		..()
	Logout()
		if(src.tempeventmin)
			src.tempeventmin=0
			src.verbs-=typesof(/mob/eventmin/verb/)
		Unequipglobalmods(src)
		for(var/obj/Aoeind/o in world)
			if(o.owner==src.ckey)
				del(o)
		for(var/obj/status/HPBar/a in usr.contents)
			usr.overlays-=a
		for(var/obj/status/MPBar/a in usr.contents)
			usr.overlays-=a
		for(var/obj/status/SPBar/a in usr.contents)
			usr.overlays-=a
		src.usingfate=0
		for(var/obj/Party/a in world)
			if(a.partyID==usr.partyID)
				a.members-=usr
				a.totalmembers-=1
				usr.partyID=null
				usr.inparty=0
				if(a.totalmembers==0)
					del a
		usr.bposition=null
		usr.battler=0
		usr.turntracker=0
		usr.overlays-='Exclamation.dmi'
		usr.overlays-='Rping.dmi'
		usr.aoesetx=null
		usr.aoesety=null
		usr.aoesetmode=null
		usr.aoenote=null
		for(var/obj/item/Chemist/C in usr.contents)
			if(C.chemistused==1)
				del C
		for(var/obj/ency/a in usr.contents)
			del a
		if(!usr.intitlescreen)
			usr.Save()
		del src
		..()

var/global/world_saving = FALSE

proc
	Saveworld()
		if(world_saving)
			return
		world_saving = TRUE
		Save_Ban()
		SavePerk()
		world<<output("<small>Server: Saving Objects...","icout")
		var/Amount=0
		var/E=1
		var/savefile/F = new("data/save/world/fragment[E]")
		var/list/Types=new
		for(var/obj/A in world) if(A.Savable==1)
			A.savedx=A.x
			A.savedy=A.y
			A.savedz=A.z
			Types+=A
			Amount+=1
			if(Amount % 250 == 0)
				F["Types"]<<Types
				E++
				F=new("data/save/world/fragment[E]")
				Types=new
		if(Amount % 250 != 0)
			F["Types"]<<Types
		hacklol:
			if(fexists("data/save/world/fragment[E++]"))
				fdel("data/save/world/fragment[E++]")
				world<<"<small>Server: Objects DEBUG system check: extra objects file deleted!"
				E++
				goto hacklol
		world<<output("<small>Server: Objects Saved([Amount]).","icout")
		world<<output("World has been succesfully saved :)","oocout")
		world_saving = FALSE

	Loadworld()
		world<<output("<small>Server: Loading Items...","icout")
		var/amount=0
		var/filenum=0
		wowza:
			filenum++
			if(fexists("data/save/world/fragment[filenum]"))
				var/savefile/F = new("data/save/world/fragment[filenum]")
				var/list/L=new
				F["Types"]>>L
				for(var/obj/A in L)
					amount+=1
					A.loc=locate(A.savedx,A.savedy,A.savedz)
				goto wowza
		world<<output("<small>Server: Items Loaded ([amount]).","icout")

	Charcreate(var/mob/m)
		if(m.created)
			return
		m.created=1
		var/list/races = list("Human","Guado","Cyborg","Ronso","Namazu","Gnath","Miqo'te","Moogle","Viera","Elezen","Lalafell","Roegadyn","Au Ra","Gria")
		if(Cyborg.Find(m.key))
			races+="Cyborg"
		if(Albhed.Find(m.key))
			races+="Al-Bhed"
		if(Cetra.Find(m.key))
			races+="Cetra"
		if(Genome.Find(m.key))
			races+="Genome"
		if(Golem.Find(m.key))
			races+="Golem"
		alert(m,"Hmm what race are you, kupo?")
		var/racechoice = input(m,"Pick your race.") as anything in races
		switch(racechoice)
			if("Human")
				m.race="Human"
				var/obj/perk/Raceperks/Human/Willtoovercome/p1 = new
				var/obj/perk/Raceperks/Human/Humandetermination/p2 = new
				m.contents+=p1
				m.contents+=p2
			if("Genome")
				var/obj/perk/Raceperks/Genome/Lifestreamconnection/p1 = new
				m.contents+=p1
				m.str+=2
				m.dex+=2
				m.con+=2
				m.Checkmod(1,m.str,m.addstr,m)
				m.Checkmod(2,m.dex,m.adddex,m)
				m.Checkmod(3,m.con,m.addcon,m)
				m.Checkmod(4,m.int,m.addint,m)
				m.Checkmod(5,m.wis,m.addwis,m)
				m.Checkmod(6,m.cha,m.addcha,m)
			if("Golem")
				var/obj/perk/Raceperks/Golem/Aetherconnection/p1 = new
				m.contents+=p1
				m.wis+=2
				m.int+=2
				m.cha+=2
				m.Checkmod(1,m.str,m.addstr,m)
				m.Checkmod(2,m.dex,m.adddex,m)
				m.Checkmod(3,m.con,m.addcon,m)
				m.Checkmod(4,m.int,m.addint,m)
				m.Checkmod(5,m.wis,m.addwis,m)
				m.Checkmod(6,m.cha,m.addcha,m)
			if("Guado")
				m.race="Guado"
				var/obj/perk/Raceperks/Guado/Guadophysiology/p1 = new
				var/obj/perk/Raceperks/Guado/Connectiontodeath/p2=new
				var/obj/perk/Raceperks/Guado/GuadoRend/p3=new
				m.contents+=p1
				m.contents+=p2
				m.contents+=p3
				m.wis+=2
				m.Checkmod(1,m.str,m.addstr,m)
				m.Checkmod(2,m.dex,m.adddex,m)
				m.Checkmod(3,m.con,m.addcon,m)
				m.Checkmod(4,m.int,m.addint,m)
				m.Checkmod(5,m.wis,m.addwis,m)
				m.Checkmod(6,m.cha,m.addcha,m)
			if("Ronso")
				m.race="Ronso"
				var/obj/perk/Raceperks/Ronso/NatureLore/p1 = new
				var/obj/perk/Raceperks/Ronso/RonsoResilience/p2 = new
				m.contents+=p1
				m.contents+=p2
				Bluemageint(m)
			if("Cyborg")
				m.race="Cyborg"
				var/obj/perk/Raceperks/Cyborg/Manacore/p1=new
				var/obj/perk/Raceperks/Cyborg/Cyberneticresilience/p2=new
				m.contents+=p1
				m.contents+=p2
				m.mp+=50
				m.mmp+=50
				m.dr+=3
				m.baseac+=3
			if("Miqo'te")
				m.race="Miqo'te"
				var/obj/perk/Raceperks/Miqote/Felinegrace/p1=new
				var/obj/perk/Raceperks/Miqote/Miqoteagility/p2=new
				m.contents+=p1
				m.contents+=p2
			if("Gnath")
				m.race="Gnath"
				var/obj/perk/Raceperks/Gnath/Layeredmuscle/p1=new
				var/obj/perk/Raceperks/Gnath/Exoskeleton/p2=new
				var/obj/perk/Raceperks/Gnath/Carapaceofravana/p3=new
				m.contents+=p1
				m.contents+=p2
				m.contents+=p3
				m.hp+=20
				m.mhp+=20
				m.str+=2
				m.Checkmod(1,m.str,m.addstr,m)
				m.Checkmod(2,m.dex,m.adddex,m)
				m.Checkmod(3,m.con,m.addcon,m)
				m.Checkmod(4,m.int,m.addint,m)
				m.Checkmod(5,m.wis,m.addwis,m)
				m.Checkmod(6,m.cha,m.addcha,m)
			if("Namazu")
				m.race="Namazu"
				var/obj/perk/Raceperks/Namazu/Thebigoneswisdom/p1=new
				var/obj/perk/Raceperks/Namazu/Craftergatherer/p2=new
				m.contents+=p1
				m.contents+=p2
				m.wis+=2
				m.mp+=20
				m.mmp+=20
				m.maxcraftingroles+=1
				m.maxgatheringroles+=1
				m.maxnodes+=5
				m.Checkmod(1,m.str,m.addstr,m)
				m.Checkmod(2,m.dex,m.adddex,m)
				m.Checkmod(3,m.con,m.addcon,m)
				m.Checkmod(4,m.int,m.addint,m)
				m.Checkmod(5,m.wis,m.addwis,m)
				m.Checkmod(6,m.cha,m.addcha,m)
			if("Viera")
				m.race="Viera"
				var/obj/perk/Raceperks/Viera/Bunnyears/p1=new
				var/obj/perk/Raceperks/Viera/Rabbitlegs/p2=new
				m.contents+=p1
				m.contents+=p2
			if("Lalafell")
				m.race="Lalafell"
				var/obj/perk/Raceperks/Lalafell/Naturalenchanters/p1=new
				var/obj/perk/Raceperks/Lalafell/Pintsize/p2=new
				var/obj/perk/Crafting/Enchanter/p3=new
				m.contents+=p1
				m.contents+=p2
				m.contents+=p3
				m.wis+=2
				m.Checkmod(1,m.str,m.addstr,m)
				m.Checkmod(2,m.dex,m.adddex,m)
				m.Checkmod(3,m.con,m.addcon,m)
				m.Checkmod(4,m.int,m.addint,m)
				m.Checkmod(5,m.wis,m.addwis,m)
				m.Checkmod(6,m.cha,m.addcha,m)
			if("Elezen")
				m.race="Elezen"
				var/obj/perk/Raceperks/Elezen/ElezenPhysiology/p1=new
				var/obj/perk/Raceperks/Elezen/LifestreamsGift/p2=new
				var/obj/perk/Crafting/MateriaMelder/p3=new
				m.contents+=p1
				m.contents+=p2
				m.contents+=p3
				m.dex+=2
				m.Checkmod(1,m.str,m.addstr,m)
				m.Checkmod(2,m.dex,m.adddex,m)
				m.Checkmod(3,m.con,m.addcon,m)
				m.Checkmod(4,m.int,m.addint,m)
				m.Checkmod(5,m.wis,m.addwis,m)
				m.Checkmod(6,m.cha,m.addcha,m)
			if("Roegadyn")
				m.race="Roegadyn"
				var/obj/perk/Raceperks/Roegadyn/Naturalsmithy/p1=new
				var/obj/perk/Raceperks/Roegadyn/Roegadynstrength/p2=new
				m.contents+=p1
				m.contents+=p2
				m.str+=2
				m.Checkmod(1,m.str,m.addstr,m)
				m.Checkmod(2,m.dex,m.adddex,m)
				m.Checkmod(3,m.con,m.addcon,m)
				m.Checkmod(4,m.int,m.addint,m)
				m.Checkmod(5,m.wis,m.addwis,m)
				m.Checkmod(6,m.cha,m.addcha,m)
				switch(alert("Do you wish to start with weaponsmithing or armorsmithing?",,"Weapon","Armor"))
					if("Weapon")
						var/obj/perk/Crafting/Weapons/Weapons2/p4=new
						m.contents+=p4
						Checkspec(p4,usr)
					if("Armor")
						var/obj/perk/Crafting/Armor/Armor2/p4=new
						m.contents+=p4
						Checkspec(p4,usr)
			if("Au Ra")
				m.race="Au Ra"
				var/obj/perk/Raceperks/AuRa/CranialProjections/p1=new
				var/obj/perk/Raceperks/AuRa/PreemptiveInstincts/p2=new
				m.contents+=p1
				m.contents+=p2
			if("Al-Bhed")
				m.race="Al-Bhed"
				var/obj/perk/Raceperks/Albhed/MasterMachinist/p1=new
				var/obj/perk/Raceperks/Albhed/CriticalThinker/p2=new
				var/obj/perk/Raceperks/Albhed/Pilot/p3=new
				m.contents+=p1
				m.contents+=p2
				m.contents+=p3
				m.weapontypes+="Machinist"
				var/obj/perk/Jobperks/Machinist/InitiateRobiticist/p4=new
				var/obj/perk/Jobperks/Machinist/BasicMachinaWeaponsmith/p5=new
				m.contents+=p4
				m.contents+=p5
				m.int+=2
				m.hp+=30
				m.mhp+=30
				m.mp+=30
				m.mmp+=30
				m.Checkmod(1,m.str,m.addstr,m)
				m.Checkmod(2,m.dex,m.adddex,m)
				m.Checkmod(3,m.con,m.addcon,m)
				m.Checkmod(4,m.int,m.addint,m)
				m.Checkmod(5,m.wis,m.addwis,m)
				m.Checkmod(6,m.cha,m.addcha,m)
			if("Moogle")
				m.race="Moogle"
				var/obj/perk/Raceperks/Moogle/Mooglepower/p1=new
				var/obj/perk/Raceperks/Moogle/Cutething/p2=new
				m.contents+=p1
				m.contents+=p2
				m.mp+=50
				m.mmp+=50
				m.maxnodes+=5
			if("Gria")
				m.race="Gria"
				var/obj/perk/Raceperks/Gria/Innerstrength/p1=new
				var/obj/perk/Raceperks/Gria/Griastamina/p2=new
				m.contents+=p1
				m.contents+=p2
				m.dr+=1
				m.hp+=10
				m.mhp+=10
			if("Cetra")
				m.race="Cetra"
				var/obj/perk/Raceperks/Cetra/AncientPower/p1=new
				var/obj/perk/Raceperks/Cetra/VoiceofAncients/p2=new
				var/obj/perk/Raceperks/Cetra/PrayerofPower/p3=new
				m.contents+=p1
				m.contents+=p2
				m.contents+=p3
				m.mab+=2
				m.hp+=20
				m.mhp+=20
				m.mp+=20
				m.mmp+=20
		usr.ChangeBase()
		var/list/jobs = list("Merchant","Scholar","Mystic Knight",/*"Chocobo Knight","Pirate","Gladiator"*/,"Astrologian","Viking","Bard","Dancer","Black Mage","White Mage","Red Mage","Blue Mage","Ranger","Monk","Beast Master","Samurai","Spellblade","Rogue","Paladin","Knight","Dark Knight","Dragoon","Machinist","Summoner","Chemist","Geomancer")
		if(Timemage.Find(m.key))
			jobs+="Time Mage"
		if(Oracle.Find(m.key))
			jobs+="Oracle"
		if(Lcie.Find(m.key))
			jobs+="L'cie"
		alert("A [m.race] kupo? I should have figured you for one. What job are you kupo?")
		if(m.race=="Al-Bhed")

		else
			var/jobchoice = input(m,"What job kupo?") as anything in jobs
			switch(jobchoice)
				/*if("Chocobo Knight")
					m.job="Chocobo Knight"
					var/obj/perk/Jobperks/ChocoboKnight/ChocoboKnight/p1=new
					var/obj/npc/Summons/CRank/ChocoSteed/p2=new
					/*m.contents+=p1
					m.contents+=p2*/
					m.mhp+=80
					m.msp+=70
					m.mmp+=40
					m.hp+=80
					m.sp+=70
					m.mp+=40
					m.reflexproficient=1
					m.fortitudeproficient=1
					m.reflexexpert=0
					m.willexpert=0
					m.fortitudeexpert=0
					m.acrobaticsproficient=1
					m.athleticsproficient=1
					m.archaeologyproficient=0
					m.deceptionproficient=1
					m.dungeoneeringproficient=1
					m.enchantmentproficient=0
					m.insightproficient=0
					m.investigationproficient=0
					m.magitekoperationproficient=0
					m.medicineproficient=0
					m.magicproficient=1
					m.naturalistproficient=0
					m.perceptionproficient=0
					m.persuasionproficient=1
					m.stealthproficient=1
					m.survivalproficient=1
					m.thieveryproficient=1*/
				if("Pirate")
					m.job="Pirate"
					var/obj/perk/Jobperks/Pirate/Pirate/p1=new
					m.contents+=p1
					m.mhp+=40
					m.msp+=70
					m.mmp+=70
					m.hp+=40
					m.sp+=70
					m.mp+=70
					m.reflexproficient=1
					m.fortitudeproficient=1
					m.reflexexpert=0
					m.willexpert=0
					m.fortitudeexpert=0
					m.acrobaticsproficient=0
					m.athleticsproficient=0
					m.archaeologyproficient=0
					m.deceptionproficient=1
					m.dungeoneeringproficient=1
					m.enchantmentproficient=0
					m.insightproficient=0
					m.investigationproficient=0
					m.magitekoperationproficient=0
					m.medicineproficient=0
					m.magicproficient=1
					m.naturalistproficient=0
					m.perceptionproficient=0
					m.persuasionproficient=1
					m.stealthproficient=1
					m.survivalproficient=1
					m.thieveryproficient=1
				if("Gladiator")
					m.job="Gladiator"
					var/obj/perk/Jobperks/Gladiator/Gladiator/p1=new
					m.contents+=p1
					m.mhp+=50
					m.msp+=80
					m.mmp+=40
					m.hp+=50
					m.sp+=80
					m.mp+=40
					m.willproficient=1
					m.fortitudeproficient=1
					m.reflexexpert=0
					m.willexpert=0
					m.fortitudeexpert=0
					m.acrobaticsproficient=0
					m.athleticsproficient=1
					m.archaeologyproficient=1
					m.deceptionproficient=0
					m.dungeoneeringproficient=0
					m.enchantmentproficient=0
					m.insightproficient=1
					m.investigationproficient=0
					m.magitekoperationproficient=0
					m.medicineproficient=0
					m.magicproficient=0
					m.naturalistproficient=0
					m.perceptionproficient=1
					m.persuasionproficient=1
					m.stealthproficient=0
					m.survivalproficient=0
					m.thieveryproficient=0
				if("L'cie")
					m.job="L'cie"
					m.subjob="L'cie"
					var/obj/perk/Jobperks/Lcies/Lcie/p1=new
					m.contents+=p1
					Checkspec(p1,m)
					m.reflexproficient=1
					m.willproficient=1
					m.fortitudeproficient=1
					m.reflexexpert=0
					m.willexpert=0
					m.fortitudeexpert=0
					m.acrobaticsproficient=0
					m.athleticsproficient=0
					m.archaeologyproficient=0
					m.deceptionproficient=0
					m.dungeoneeringproficient=0
					m.enchantmentproficient=0
					m.insightproficient=1
					m.investigationproficient=0
					m.magitekoperationproficient=0
					m.medicineproficient=0
					m.magicproficient=1
					m.naturalistproficient=0
					m.perceptionproficient=0
					m.persuasionproficient=1
					m.stealthproficient=0
					m.survivalproficient=0
					m.thieveryproficient=0
				if("Oracle")
					m.job="Oracle"
					var/obj/perk/Jobperks/Oracle/p1=new
					m.contents+=p1
					m.mhp+=20
					m.mmp+=60
					m.msp+=60
					m.mp+=60
					m.sp+=60
					m.hp+=20
					m.whitemagicable=4
					m.reflexproficient=1
					m.willproficient=0
					m.fortitudeproficient=0
					m.reflexexpert=0
					m.willexpert=1
					m.fortitudeexpert=0
					m.acrobaticsproficient=0
					m.athleticsproficient=0
					m.archaeologyproficient=0
					m.deceptionproficient=0
					m.dungeoneeringproficient=0
					m.enchantmentproficient=0
					m.insightproficient=1
					m.investigationproficient=0
					m.magitekoperationproficient=0
					m.medicineproficient=1
					m.magicproficient=0
					m.naturalistproficient=0
					m.perceptionproficient=1
					m.persuasionproficient=0
					m.stealthproficient=0
					m.survivalproficient=0
					m.thieveryproficient=0
				if("Mystic Knight")
					m.job="Mystic Knight"
					m.mhp+=55
					m.hp+=55
					m.mmp+=55
					m.mp+=55
					m.msp+=55
					m.sp+=55
					var/obj/perk/Jobperks/MysticKnight/MysticKnight/p1=new
					m.contents+=p1
					Magicuseincrease(m,2,3)
					Magicuseincrease(m,4,2)
					m.reflexproficient=1
					m.willproficient=0
					m.fortitudeproficient=0
					m.reflexexpert=0
					m.willexpert=1
					m.fortitudeexpert=0
					m.acrobaticsproficient=1
					m.athleticsproficient=0
					m.archaeologyproficient=0
					m.deceptionproficient=0
					m.dungeoneeringproficient=0
					m.enchantmentproficient=0
					m.insightproficient=1
					m.investigationproficient=0
					m.magitekoperationproficient=0
					m.medicineproficient=0
					m.magicproficient=1
					m.naturalistproficient=0
					m.perceptionproficient=0
					m.persuasionproficient=0
					m.stealthproficient=0
					m.survivalproficient=0
					m.thieveryproficient=0
				if("Astrologian")
					m.job="Astrologian"
					var/obj/perk/Jobperks/Astrologian/Astrologian/p1=new
					m.contents+=p1
					m.hp+=30
					m.mhp+=30
					m.mp+=70
					m.mmp+=70
					m.msp+=20
					m.sp+=20
					m.greenmagicable=5
					m.whitemagicable=3
					m.reflexproficient=0
					m.willproficient=0
					m.fortitudeproficient=1
					m.reflexexpert=0
					m.willexpert=1
					m.fortitudeexpert=0
					m.acrobaticsproficient=0
					m.athleticsproficient=0
					m.archaeologyproficient=1
					m.deceptionproficient=0
					m.dungeoneeringproficient=0
					m.enchantmentproficient=0
					m.insightproficient=0
					m.investigationproficient=0
					m.magitekoperationproficient=0
					m.medicineproficient=0
					m.magicproficient=1
					m.naturalistproficient=1
					m.perceptionproficient=0
					m.persuasionproficient=0
					m.stealthproficient=0
					m.survivalproficient=0
					m.thieveryproficient=0
				if("Scholar")
					m.job="Scholar"
					var/obj/perk/Jobperks/Scholar/Scholar/p1=new
					m.contents+=p1
					m.hp+=10
					m.mhp+=10
					m.mp+=70
					m.mmp+=70
					m.msp+=20
					m.sp+=20
					m.whitemagicable=4
					m.arcanemagicable=3
					m.blackmagicable=2
					m.greenmagicable=2
					m.reflexproficient=1
					m.willproficient=1
					m.fortitudeproficient=1
					m.reflexexpert=0
					m.willexpert=0
					m.fortitudeexpert=0
					m.acrobaticsproficient=0
					m.athleticsproficient=0
					m.archaeologyproficient=0
					m.deceptionproficient=0
					m.dungeoneeringproficient=0
					m.enchantmentproficient=0
					m.insightproficient=0
					m.investigationproficient=1
					m.magitekoperationproficient=0
					m.medicineproficient=1
					m.magicproficient=1
					m.naturalistproficient=0
					m.perceptionproficient=0
					m.persuasionproficient=0
					m.stealthproficient=0
					m.survivalproficient=0
					m.thieveryproficient=0
					Scholarint()
				if("Merchant")
					m.job="Merchant"
					var/obj/perk/Jobperks/Merchant/Merchant/p1=new
					m.contents+=p1
					m.hp+=25
					m.mhp+=25
					m.mp+=60
					m.mmp+=60
					m.msp+=60
					m.sp+=60
					m.money+=6000
					m.reflexproficient=1
					m.willproficient=1
					m.fortitudeproficient=1
					m.reflexexpert=0
					m.willexpert=0
					m.fortitudeexpert=0
					m.acrobaticsproficient=0
					m.athleticsproficient=0
					m.archaeologyproficient=0
					m.deceptionproficient=1
					m.dungeoneeringproficient=0
					m.enchantmentproficient=0
					m.insightproficient=1
					m.investigationproficient=0
					m.magitekoperationproficient=0
					m.medicineproficient=0
					m.magicproficient=0
					m.naturalistproficient=0
					m.perceptionproficient=0
					m.persuasionproficient=1
					m.stealthproficient=0
					m.survivalproficient=0
					m.thieveryproficient=0
					m.maxnodes+=10
				if("Viking")
					m.job="Viking"
					var/obj/perk/Jobperks/Viking/Viking/p1=new
					m.contents+=p1
					m.hp+=70
					m.mhp+=70
					m.mp+=10
					m.mmp+=10
					m.msp+=60
					m.sp+=60
					m.reflexproficient=1
					m.willproficient=0
					m.fortitudeproficient=0
					m.reflexexpert=0
					m.willexpert=0
					m.fortitudeexpert=1
					m.acrobaticsproficient=0
					m.athleticsproficient=1
					m.archaeologyproficient=0
					m.deceptionproficient=0
					m.dungeoneeringproficient=0
					m.enchantmentproficient=0
					m.insightproficient=0
					m.investigationproficient=1
					m.magitekoperationproficient=0
					m.medicineproficient=0
					m.magicproficient=0
					m.naturalistproficient=0
					m.perceptionproficient=0
					m.persuasionproficient=0
					m.stealthproficient=0
					m.survivalproficient=1
					m.thieveryproficient=0
				if("Bard")
					m.job="Bard"
					var/obj/perk/Jobperks/Bard/Bard/p1=new
					m.contents+=p1
					m.hp+=25
					m.mhp+=25
					m.mp+=60
					m.mmp+=60
					m.msp+=20
					m.sp+=20
					m.reflexproficient=1
					m.willproficient=1
					m.fortitudeproficient=1
					m.reflexexpert=0
					m.willexpert=0
					m.fortitudeexpert=0
					m.acrobaticsproficient=0
					m.athleticsproficient=0
					m.archaeologyproficient=0
					m.deceptionproficient=1
					m.dungeoneeringproficient=0
					m.enchantmentproficient=0
					m.insightproficient=0
					m.investigationproficient=0
					m.magitekoperationproficient=0
					m.medicineproficient=0
					m.magicproficient=1
					m.naturalistproficient=0
					m.perceptionproficient=0
					m.persuasionproficient=1
					m.stealthproficient=0
					m.survivalproficient=0
					m.thieveryproficient=0
				if("Dancer")
					m.job="Dancer"
					var/obj/perk/Jobperks/Dancer/Dancer/p1=new
					m.contents+=p1
					m.hp+=20
					m.mhp+=20
					m.mp+=80
					m.mmp+=80
					m.msp+=20
					m.sp+=20
					m.reflexproficient=0
					m.willproficient=1
					m.fortitudeproficient=0
					m.reflexexpert=1
					m.willexpert=0
					m.fortitudeexpert=0
					m.acrobaticsproficient=0
					m.athleticsproficient=0
					m.archaeologyproficient=0
					m.deceptionproficient=0
					m.dungeoneeringproficient=0
					m.enchantmentproficient=0
					m.insightproficient=0
					m.investigationproficient=0
					m.magitekoperationproficient=0
					m.medicineproficient=0
					m.magicproficient=0
					m.naturalistproficient=0
					m.perceptionproficient=1
					m.persuasionproficient=1
					m.stealthproficient=1
					m.survivalproficient=0
					m.thieveryproficient=0
				if("Black Mage")
					m.job="Black Mage"
					var/obj/perk/Jobperks/BlackMage/BlackMage/p1=new
					m.contents+=p1
					m.hp+=15
					m.mhp+=15
					m.mp+=60
					m.mmp+=60
					m.blackmagicable=6
					m.arcanemagicable=2
					m.msp+=20
					m.sp+=20
					m.reflexproficient=1
					m.willproficient=0
					m.fortitudeproficient=0
					m.reflexexpert=0
					m.willexpert=1
					m.fortitudeexpert=0
					m.acrobaticsproficient=0
					m.athleticsproficient=0
					m.archaeologyproficient=0
					m.deceptionproficient=0
					m.dungeoneeringproficient=0
					m.enchantmentproficient=0
					m.insightproficient=0
					m.investigationproficient=1
					m.magitekoperationproficient=0
					m.medicineproficient=0
					m.magicproficient=1
					m.naturalistproficient=0
					m.perceptionproficient=1
					m.persuasionproficient=0
					m.stealthproficient=0
					m.survivalproficient=0
					m.thieveryproficient=0
				if("White Mage")
					m.job="White Mage"
					var/obj/perk/Jobperks/WhiteMage/WhiteMage/p1=new
					m.contents+=p1
					m.hp+=10
					m.mhp+=10
					m.mp+=80
					m.mmp+=80
					m.msp+=20
					m.sp+=20
					m.whitemagicable=6
					m.greenmagicable=3
					m.reflexproficient=1
					m.willproficient=0
					m.fortitudeproficient=0
					m.reflexexpert=0
					m.willexpert=1
					m.fortitudeexpert=0
					m.acrobaticsproficient=0
					m.athleticsproficient=0
					m.archaeologyproficient=0
					m.deceptionproficient=0
					m.dungeoneeringproficient=0
					m.enchantmentproficient=0
					m.insightproficient=0
					m.investigationproficient=0
					m.magitekoperationproficient=0
					m.medicineproficient=1
					m.magicproficient=1
					m.naturalistproficient=0
					m.perceptionproficient=0
					m.persuasionproficient=1
					m.stealthproficient=0
					m.survivalproficient=0
					m.thieveryproficient=0
				if("Red Mage")
					m.job="Red Mage"
					var/obj/perk/Jobperks/RedMage/RedMage/p1=new
					m.contents+=p1
					m.hp+=60
					m.mhp+=60
					m.mp+=50
					m.mmp+=50
					m.msp+=50
					m.sp+=50
					m.whitemagicable=3
					m.blackmagicable=3
					m.greenmagicable=3
					m.arcanemagicable=3
					m.reflexproficient=1
					m.willproficient=0
					m.fortitudeproficient=0
					m.reflexexpert=0
					m.willexpert=1
					m.fortitudeexpert=0
					m.acrobaticsproficient=1
					m.athleticsproficient=0
					m.archaeologyproficient=0
					m.deceptionproficient=0
					m.dungeoneeringproficient=0
					m.enchantmentproficient=1
					m.insightproficient=0
					m.investigationproficient=0
					m.magitekoperationproficient=0
					m.medicineproficient=0
					m.magicproficient=1
					m.naturalistproficient=0
					m.perceptionproficient=0
					m.persuasionproficient=0
					m.stealthproficient=0
					m.survivalproficient=0
					m.thieveryproficient=0
				if("Blue Mage")
					m.job="Blue Mage"
					var/obj/perk/Jobperks/BlueMage/BlueMage/p1=new
					m.contents+=p1
					m.hp+=30
					m.mhp+=30
					m.mp+=50
					m.mmp+=50
					m.msp+=30
					m.sp+=30
					Bluemageint(m)
					m.reflexproficient=1
					m.willproficient=0
					m.fortitudeproficient=0
					m.reflexexpert=0
					m.willexpert=1
					m.fortitudeexpert=0
					m.acrobaticsproficient=0
					m.athleticsproficient=0
					m.archaeologyproficient=0
					m.deceptionproficient=0
					m.dungeoneeringproficient=0
					m.enchantmentproficient=0
					m.insightproficient=1
					m.investigationproficient=0
					m.magitekoperationproficient=0
					m.medicineproficient=0
					m.magicproficient=0
					m.naturalistproficient=1
					m.perceptionproficient=1
					m.persuasionproficient=0
					m.stealthproficient=0
					m.survivalproficient=0
					m.thieveryproficient=0
				if("Ranger")
					m.job="Ranger"
					var/obj/perk/Jobperks/Ranger/Ranger/p1=new
					m.contents+=p1
					m.hp+=30
					m.mhp+=30
					m.mp+=30
					m.mmp+=30
					m.msp+=70
					m.sp+=70
					m.reflexproficient=0
					m.willproficient=1
					m.fortitudeproficient=1
					m.reflexexpert=1
					m.willexpert=0
					m.fortitudeexpert=0
					m.acrobaticsproficient=0
					m.athleticsproficient=0
					m.archaeologyproficient=0
					m.deceptionproficient=0
					m.dungeoneeringproficient=0
					m.enchantmentproficient=0
					m.insightproficient=0
					m.investigationproficient=0
					m.magitekoperationproficient=0
					m.medicineproficient=0
					m.magicproficient=0
					m.naturalistproficient=1
					m.perceptionproficient=1
					m.persuasionproficient=0
					m.stealthproficient=0
					m.survivalproficient=1
					m.thieveryproficient=0
				if("Monk")
					m.job="Monk"
					var/obj/perk/Jobperks/Monk/Monk/p1=new
					m.contents+=p1
					m.hp+=60
					m.mhp+=60
					m.mp+=40
					m.mmp+=40
					m.msp+=50
					m.sp+=50
					m.reflexproficient=1
					m.willproficient=1
					m.fortitudeproficient=0
					m.reflexexpert=0
					m.willexpert=0
					m.fortitudeexpert=1
					m.acrobaticsproficient=0
					m.athleticsproficient=1
					m.archaeologyproficient=0
					m.deceptionproficient=0
					m.dungeoneeringproficient=0
					m.enchantmentproficient=0
					m.insightproficient=1
					m.investigationproficient=0
					m.magitekoperationproficient=0
					m.medicineproficient=1
					m.magicproficient=0
					m.naturalistproficient=0
					m.perceptionproficient=0
					m.persuasionproficient=0
					m.stealthproficient=0
					m.survivalproficient=0
					m.thieveryproficient=0
				if("Beast Master")
					m.job="Beast Master"
					var/obj/perk/Jobperks/BeastMaster/BeastMaster/p1=new
					m.contents+=p1
					m.hp+=40
					m.mhp+=40
					m.mp+=30
					m.mmp+=30
					m.msp+=30
					m.sp+=30
					m.reflexproficient=0
					m.willproficient=1
					m.fortitudeproficient=1
					m.reflexexpert=0
					m.willexpert=0
					m.fortitudeexpert=0
					m.acrobaticsproficient=0
					m.athleticsproficient=0
					m.archaeologyproficient=0
					m.deceptionproficient=0
					m.dungeoneeringproficient=0
					m.enchantmentproficient=0
					m.insightproficient=0
					m.investigationproficient=0
					m.magitekoperationproficient=0
					m.medicineproficient=0
					m.magicproficient=0
					m.naturalistproficient=0
					m.perceptionproficient=0
					m.persuasionproficient=1
					m.stealthproficient=1
					m.survivalproficient=1
					m.thieveryproficient=0
				if("Samurai")
					m.job="Samurai"
					var/obj/perk/Jobperks/Samurai/Samurai/p1=new
					m.contents+=p1
					m.hp+=65
					m.mhp+=65
					m.mp+=30
					m.mmp+=30
					m.msp+=70
					m.sp+=70
					m.reflexproficient=1
					m.willproficient=1
					m.fortitudeproficient=0
					m.reflexexpert=0
					m.willexpert=0
					m.fortitudeexpert=1
					m.acrobaticsproficient=0
					m.athleticsproficient=1
					m.archaeologyproficient=0
					m.deceptionproficient=0
					m.dungeoneeringproficient=1
					m.enchantmentproficient=0
					m.insightproficient=0
					m.investigationproficient=0
					m.magitekoperationproficient=0
					m.medicineproficient=0
					m.magicproficient=0
					m.naturalistproficient=0
					m.perceptionproficient=1
					m.persuasionproficient=0
					m.stealthproficient=0
					m.survivalproficient=0
					m.thieveryproficient=0
				if("Spellblade")
					m.job="Spellblade"
					var/obj/perk/Jobperks/Spellblade/Spellblade/p1=new
					m.contents+=p1
					m.hp+=30
					m.mhp+=30
					m.mp+=70
					m.mmp+=70
					m.msp+=30
					m.sp+=30
					m.reflexproficient=1
					m.willproficient=0
					m.fortitudeproficient=1
					m.reflexexpert=0
					m.willexpert=1
					m.fortitudeexpert=0
					m.acrobaticsproficient=1
					m.athleticsproficient=0
					m.archaeologyproficient=0
					m.deceptionproficient=0
					m.dungeoneeringproficient=0
					m.enchantmentproficient=1
					m.insightproficient=0
					m.investigationproficient=0
					m.magitekoperationproficient=0
					m.medicineproficient=0
					m.magicproficient=1
					m.naturalistproficient=0
					m.perceptionproficient=0
					m.persuasionproficient=0
					m.stealthproficient=0
					m.survivalproficient=0
					m.thieveryproficient=0
				if("Rogue")
					m.job="Rogue"
					var/obj/perk/Jobperks/Rogue/Rogue/p1=new
					m.contents+=p1
					m.hp+=20
					m.mhp+=20
					m.mp+=30
					m.mmp+=30
					m.msp+=50
					m.sp+=50
					m.reflexproficient=0
					m.willproficient=1
					m.fortitudeproficient=1
					m.reflexexpert=1
					m.willexpert=0
					m.fortitudeexpert=0
					m.acrobaticsproficient=0
					m.athleticsproficient=0
					m.archaeologyproficient=0
					m.deceptionproficient=0
					m.dungeoneeringproficient=1
					m.enchantmentproficient=0
					m.insightproficient=0
					m.investigationproficient=0
					m.magitekoperationproficient=0
					m.medicineproficient=0
					m.magicproficient=0
					m.naturalistproficient=0
					m.perceptionproficient=0
					m.persuasionproficient=0
					m.stealthproficient=1
					m.survivalproficient=0
					m.thieveryproficient=1
				if("Paladin")
					m.job="Paladin"
					var/obj/perk/Jobperks/Paladin/Paladin/p1=new
					m.contents+=p1
					m.hp+=90
					m.mhp+=90
					m.mp+=40
					m.mmp+=40
					m.msp+=30
					m.sp+=30
					m.whitemagicable=3
					m.greenmagicable=2
					m.reflexproficient=0
					m.willproficient=1
					m.fortitudeproficient=0
					m.reflexexpert=0
					m.willexpert=0
					m.fortitudeexpert=1
					m.acrobaticsproficient=0
					m.athleticsproficient=0
					m.archaeologyproficient=0
					m.deceptionproficient=0
					m.dungeoneeringproficient=0
					m.enchantmentproficient=1
					m.insightproficient=1
					m.investigationproficient=0
					m.magitekoperationproficient=0
					m.medicineproficient=0
					m.magicproficient=0
					m.naturalistproficient=0
					m.perceptionproficient=0
					m.persuasionproficient=1
					m.stealthproficient=0
					m.survivalproficient=0
					m.thieveryproficient=0
				if("Knight")
					m.job="Knight"
					var/obj/perk/Jobperks/Knight/Knight/p1=new
					m.contents+=p1
					m.hp+=100
					m.mhp+=100
					m.mp+=20
					m.mmp+=20
					m.msp+=50
					m.sp+=50
					m.reflexproficient=0
					m.willproficient=1
					m.fortitudeproficient=0
					m.reflexexpert=0
					m.willexpert=0
					m.fortitudeexpert=1
					m.acrobaticsproficient=0
					m.athleticsproficient=1
					m.archaeologyproficient=0
					m.deceptionproficient=0
					m.dungeoneeringproficient=0
					m.enchantmentproficient=0
					m.insightproficient=0
					m.investigationproficient=0
					m.magitekoperationproficient=0
					m.medicineproficient=0
					m.magicproficient=0
					m.naturalistproficient=0
					m.perceptionproficient=1
					m.persuasionproficient=1
					m.stealthproficient=0
					m.survivalproficient=0
					m.thieveryproficient=0
				if("Dark Knight")
					m.job="Dark Knight"
					var/obj/perk/Jobperks/DarkKnight/DarkKnight/p1=new
					m.contents+=p1
					m.hp+=80
					m.mhp+=80
					m.mp+=35
					m.mmp+=35
					m.msp+=40
					m.sp+=40
					m.reflexproficient=0
					m.willproficient=0
					m.fortitudeproficient=1
					m.reflexexpert=0
					m.willexpert=1
					m.fortitudeexpert=0
					m.acrobaticsproficient=0
					m.athleticsproficient=1
					m.archaeologyproficient=0
					m.deceptionproficient=1
					m.dungeoneeringproficient=0
					m.enchantmentproficient=1
					m.insightproficient=0
					m.investigationproficient=0
					m.magitekoperationproficient=0
					m.medicineproficient=0
					m.magicproficient=0
					m.naturalistproficient=0
					m.perceptionproficient=0
					m.persuasionproficient=0
					m.stealthproficient=0
					m.survivalproficient=0
					m.thieveryproficient=0
				if("Dragoon")
					m.job="Dragoon"
					var/obj/perk/Jobperks/Dragoon/Dragoon/p1=new
					m.contents+=p1
					m.hp+=40
					m.mhp+=40
					m.mp+=30
					m.mmp+=30
					m.msp+=70
					m.sp+=70
					m.reflexproficient=0
					m.willproficient=1
					m.fortitudeproficient=1
					m.reflexexpert=1
					m.willexpert=0
					m.fortitudeexpert=0
					m.acrobaticsproficient=1
					m.athleticsproficient=0
					m.archaeologyproficient=0
					m.deceptionproficient=0
					m.dungeoneeringproficient=0
					m.enchantmentproficient=0
					m.insightproficient=1
					m.investigationproficient=0
					m.magitekoperationproficient=0
					m.medicineproficient=0
					m.magicproficient=0
					m.naturalistproficient=0
					m.perceptionproficient=1
					m.persuasionproficient=0
					m.stealthproficient=0
					m.survivalproficient=0
					m.thieveryproficient=0
					m.weapontypes+="Draconic"
				if("Machinist")
					m.job="Machinist"
					var/obj/perk/Jobperks/Machinist/Machinist/p1=new
					m.contents+=p1
					m.weapontypes+="Machinist"
					m.hp+=30
					m.mhp+=30
					m.mp+=30
					m.mmp+=30
					m.msp+=30
					m.sp+=30
					m.int+=2
					m.Checkmod(4,m.int,m.addint,m)
					m.reflexproficient=1
					m.willproficient=1
					m.fortitudeproficient=1
					m.reflexexpert=0
					m.willexpert=0
					m.fortitudeexpert=0
					m.acrobaticsproficient=0
					m.athleticsproficient=0
					m.archaeologyproficient=1
					m.deceptionproficient=0
					m.dungeoneeringproficient=0
					m.enchantmentproficient=0
					m.insightproficient=0
					m.investigationproficient=1
					m.magitekoperationproficient=1
					m.medicineproficient=0
					m.magicproficient=0
					m.naturalistproficient=0
					m.perceptionproficient=0
					m.persuasionproficient=0
					m.stealthproficient=0
					m.survivalproficient=0
					m.thieveryproficient=0
					m.maxnodes+=10
					m.weapontypes+="Machinist"
				if("Summoner")
					m.job="Summoner"
					var/obj/perk/Jobperks/Summoner/Summoner/p1=new
					m.contents+=p1
					m.hp+=10
					m.mhp+=10
					m.mp+=90
					m.mmp+=90
					m.msp+=10
					m.sp+=10
					m.buysummons=1
					m.greenmagicable=3
					m.arcanemagicable=3
					Summonerint()
					m.reflexproficient=1
					m.willproficient=1
					m.fortitudeproficient=1
					m.reflexexpert=0
					m.willexpert=0
					m.fortitudeexpert=0
					m.acrobaticsproficient=0
					m.athleticsproficient=0
					m.archaeologyproficient=0
					m.deceptionproficient=0
					m.dungeoneeringproficient=0
					m.enchantmentproficient=0
					m.insightproficient=1
					m.investigationproficient=0
					m.magitekoperationproficient=0
					m.medicineproficient=0
					m.magicproficient=1
					m.naturalistproficient=0
					m.perceptionproficient=0
					m.persuasionproficient=0
					m.stealthproficient=0
					m.survivalproficient=1
					m.thieveryproficient=0
				if("Chemist")
					m.job="Chemist"
					m.weapontypes+="Chemist"
					var/obj/perk/Jobperks/Chemist/Chemist/p1=new
					m.contents+=p1
					m.hp+=30
					m.mhp+=30
					m.mp+=30
					m.mmp+=30
					m.msp+=30
					m.sp+=30
					m.reflexproficient=1
					m.willproficient=1
					m.fortitudeproficient=1
					m.reflexexpert=0
					m.willexpert=0
					m.fortitudeexpert=0
					m.acrobaticsproficient=0
					m.athleticsproficient=0
					m.archaeologyproficient=0
					m.deceptionproficient=0
					m.dungeoneeringproficient=0
					m.enchantmentproficient=0
					m.insightproficient=0
					m.investigationproficient=1
					m.magitekoperationproficient=0
					m.medicineproficient=1
					m.magicproficient=0
					m.naturalistproficient=1
					m.perceptionproficient=0
					m.persuasionproficient=0
					m.stealthproficient=0
					m.survivalproficient=0
					m.thieveryproficient=0
					m.maxnodes+=10
					m.weapontypes+="Chemist"
				if("Geomancer")
					m.job="Geomancer"
					var/obj/perk/Jobperks/Geomancer/Geomancer/p1=new
					m.contents+=p1
					m.hp+=40
					m.mhp+=40
					m.mp+=60
					m.mmp+=60
					m.msp+=30
					m.sp+=30
					m.reflexproficient=1
					m.willproficient=1
					m.fortitudeproficient=1
					m.reflexexpert=0
					m.willexpert=0
					m.fortitudeexpert=0
					m.acrobaticsproficient=0
					m.athleticsproficient=0
					m.archaeologyproficient=0
					m.deceptionproficient=0
					m.dungeoneeringproficient=0
					m.enchantmentproficient=0
					m.insightproficient=0
					m.investigationproficient=0
					m.magitekoperationproficient=0
					m.medicineproficient=1
					m.magicproficient=1
					m.naturalistproficient=1
					m.perceptionproficient=0
					m.persuasionproficient=0
					m.stealthproficient=0
					m.survivalproficient=0
					m.thieveryproficient=0
				if("Time Mage")
					m.job="Time Mage"
					var/obj/perk/Jobperks/TimeMage/TimeMage/p1=new
					m.contents+=p1
					m.hp+=10
					m.mhp+=10
					m.mp+=100
					m.mmp+=100
					m.msp+=10
					m.sp+=10
					m.whitemagicable=2
					m.blackmagicable=2
					m.arcanemagicable=2
					m.greenmagicable=2
					m.reflexproficient=1
					m.willproficient=0
					m.fortitudeproficient=1
					m.reflexexpert=0
					m.willexpert=1
					m.fortitudeexpert=0
					m.acrobaticsproficient=0
					m.athleticsproficient=0
					m.archaeologyproficient=1
					m.deceptionproficient=0
					m.dungeoneeringproficient=0
					m.enchantmentproficient=1
					m.insightproficient=0
					m.investigationproficient=0
					m.magitekoperationproficient=0
					m.medicineproficient=0
					m.magicproficient=1
					m.naturalistproficient=0
					m.perceptionproficient=0
					m.persuasionproficient=0
					m.stealthproficient=0
					m.survivalproficient=0
					m.thieveryproficient=0
		alert("A [m.job] kupo? Ok ok next, pick your role.")
		var/list/roles=list("Melee Tank","Tank Caster","Physical DPS","Magical DPS","Magical Support","Physical Support","Generalist")
		var/rolechoice=input(m,"What role do you wish kupo") as anything in roles
		var/hproll
		var/mproll
		var/sproll
		switch(rolechoice)
			if("Melee Tank")
				m.role="Melee Tank"
				hproll=rand(130,130)
				mproll=rand(60,60)
				sproll=rand(100,100)
				m.mhp+=hproll
				m.hp+=hproll
				m.mmp+=mproll
				m.mp+=mproll
				m.msp+=sproll
				m.sp+=sproll
				m.baseac+=2
				m.basedr+=4
				var/obj/perk/Roleperks/MeleeTank/k = new
				m.contents+=k
				alert("You rolled [hproll] for HP, [mproll] for MP, and [sproll] for SP!")
			if("Tank Caster")
				m.role="Tank Caster"
				hproll=rand(120,120)
				mproll=rand(100,100)
				sproll=rand(50,50)
				m.mhp+=hproll
				m.hp+=hproll
				m.mmp+=mproll
				m.mp+=mproll
				m.msp+=sproll
				m.sp+=sproll
				m.baseac+=2
				m.basedr+=4
				var/obj/perk/Roleperks/CasterTank/k = new
				m.contents+=k
				alert("You rolled [hproll] for HP, [mproll] for MP, and [sproll] for SP!")
			if("Physical DPS")
				m.role="Physical DPS"
				hproll=rand(90,90)
				mproll=rand(80,80)
				sproll=rand(120,120)
				m.mhp+=hproll
				m.hp+=hproll
				m.mmp+=mproll
				m.mp+=mproll
				m.msp+=sproll
				m.sp+=sproll
				m.pab+=3
				m.pdb+=8
				var/obj/perk/Roleperks/PhysicalDPS/k = new
				m.contents+=k
				alert("You rolled [hproll] for HP, [mproll] for MP, and [sproll] for SP!")
			if("Magical DPS")
				m.role="Magical DPS"
				hproll=rand(90,90)
				mproll=rand(120,120)
				sproll=rand(60,60)
				m.mhp+=hproll
				m.hp+=hproll
				m.mmp+=mproll
				m.mp+=mproll
				m.msp+=sproll
				m.sp+=sproll
				m.mab+=3
				m.mdb+=8
				var/obj/perk/Roleperks/MagicalDPS/k = new
				m.contents+=k
				alert("You rolled [hproll] for HP, [mproll] for MP, and [sproll] for SP!")
			if("Magical Support")
				m.role="Magical Support"
				hproll=rand(60,60)
				mproll=rand(130,130)
				sproll=rand(60,60)
				m.mhp+=hproll
				m.hp+=hproll
				m.mmp+=mproll
				m.mp+=mproll
				m.msp+=sproll
				m.sp+=sproll
				m.mab+=1
				var/obj/perk/Roleperks/MagicalSupport/k = new
				m.contents+=k
				alert("You rolled [hproll] for HP, [mproll] for MP, and [sproll] for SP!")
			if("Physical Support")
				m.role="Physical Support"
				hproll=rand(70,70)
				mproll=rand(70,70)
				sproll=rand(120,120)
				m.mhp+=hproll
				m.hp+=hproll
				m.mmp+=mproll
				m.mp+=mproll
				m.msp+=sproll
				m.sp+=sproll
				m.pab+=1
				var/obj/perk/Roleperks/PhysicalSupport/k = new
				m.contents+=k
				alert("You rolled [hproll] for HP, [mproll] for MP, and [sproll] for SP!")
			if("Generalist")
				m.role="Generalist"
				hproll=rand(60,60)
				mproll=rand(60,60)
				sproll=rand(60,60)
				m.mhp+=hproll
				m.hp+=hproll
				m.mmp+=mproll
				m.mp+=mproll
				m.msp+=sproll
				m.sp+=sproll
				m.baseac+=2
				m.basedr+=2
				m.mab+=2
				m.pab+=2
				m.mdb+=5
				m.pdb+=5
				m.rpp+=5
				var/obj/perk/Roleperks/Generalist/k = new
				m.contents+=k
				alert("You rolled [hproll] for HP, [mproll] for MP, and [sproll] for SP!")
		alert(m,"Hmm finally what equipment do you wish to use? You only get three slots for now.")
		var/list/equip=list("Light Armor","Medium Armor","Heavy Armor","Shield","Tower Shield","Shuriken","Rod","Throwing Knives","Longsword","Scimitar","Hammer","Axe","Dagger","Claw","Gauntlet","Whip","Greatsword","Katana","Spear","Scythe","Bow","Bow Sword","Focus Sword","Staff","Tome","Sword Spear","Thief Sword","Bolt Rapier","Whip Blade","Akademia Card","Buster Sword","Blitzball","Gun Blade","Ba'gangsaw","Gun Arm", "Magitek Pistol","Magitek Rifle")
		var/loop=1
		m.weapontypes+="accessory"
		while(loop)
			if(m.wpntypeamount<3)
				if(m.wpntypeamount==2)
					equip-="Sword Spear"
					equip-="Thief Sword"
					equip-="Bolt Rapier"
					equip-="Whip Blade"
					equip-="Akademia Card"
					equip-="Blitzball"
					equip-="Gun Blade"
					equip-="Ba'gangsaw"
					equip-="Buster Sword"
					equip-="Morphing Blade"
					equip-="Gun Arm"
				var/equipchoice=input(m,"Make your choices.") as anything in equip
				equip-=equipchoice
				switch(equipchoice)
					if("Light Armor")
						m.weapontypes+="Light Armor"
						m.wpntypeamount+=1
						var/obj/item/Weapon/Armor/LightArmor/Bronze/i=new
						m.contents+=i
					if("Medium Armor")
						m.weapontypes+="Medium Armor"
						m.wpntypeamount+=1
						var/obj/item/Weapon/Armor/MediumArmor/Bronze/i=new
						m.contents+=i
					if("Heavy Armor")
						m.weapontypes+="Heavy Armor"
						m.wpntypeamount+=1
						var/obj/item/Weapon/Armor/HeavyArmor/Bronze/i=new
						m.contents+=i
					if("Shield")
						m.weapontypes+="Shield"
						m.wpntypeamount+=1
						var/obj/item/Weapon/Armor/Shield/Bronze/i=new
						m.contents+=i
					if("Tower Shield")
						m.weapontypes+="Tower Shield"
						m.wpntypeamount+=1
						var/obj/item/Weapon/Armor/TowerShield/Bronze/i=new
						m.contents+=i
					if("Throwing Knives")
						m.weapontypes+="Throwing Knives"
						m.wpntypeamount+=1
						var/obj/item/Weapon/Ranged/ThrowingWeapons/ThrowingKnives/Bronze/i=new
						m.contents+=i
					if("Shuriken")
						m.weapontypes+="Shuriken"
						m.wpntypeamount+=1
						var/obj/item/Weapon/Ranged/ThrowingWeapons/Shuriken/Bronze/i=new
						m.contents+=i
					if("Scimitar")
						m.weapontypes+="Scimitar"
						m.wpntypeamount+=1
						var/obj/item/Weapon/Melee/Scimitar/Bronze/i=new
						m.contents+=i
					if("Rod")
						m.weapontypes+="Rod"
						m.wpntypeamount+=1
						var/obj/item/Weapon/Magical/Rod/Bronze/i=new
						m.contents+=i
					if("Longsword")
						m.weapontypes+="Longsword"
						m.wpntypeamount+=1
						var/obj/item/Weapon/Melee/Longsword/Bronze/i=new
						m.contents+=i
					if("Hammer")
						m.weapontypes+="Hammer"
						m.wpntypeamount+=1
						var/obj/item/Weapon/Melee/Hammer/Bronze/i=new
						m.contents+=i
					if("Axe")
						m.weapontypes+="Axe"
						m.wpntypeamount+=1
						var/obj/item/Weapon/Melee/Axe/Bronze/i=new
						m.contents+=i
					if("Dagger")
						m.weapontypes+="Dagger"
						m.wpntypeamount+=1
						var/obj/item/Weapon/Melee/Dagger/Bronze/i=new
						m.contents+=i
					if("Claw")
						m.weapontypes+="Claw"
						m.wpntypeamount+=1
						var/obj/item/Weapon/Melee/Claw/Bronze/i=new
						m.contents+=i
					if("Gauntlet")
						m.weapontypes+="Gauntlet"
						m.wpntypeamount+=1
						var/obj/item/Weapon/Melee/Gauntlet/Bronze/i=new
						m.contents+=i
					if("Whip")
						m.weapontypes+="Whip"
						m.wpntypeamount+=1
						var/obj/item/Weapon/Melee/Whip/Bronze/i=new
						m.contents+=i
					if("Greatsword")
						m.weapontypes+="Greatsword"
						m.wpntypeamount+=1
						var/obj/item/Weapon/Melee/Greatsword/Bronze/i=new
						m.contents+=i
					if("Katana")
						m.weapontypes+="Katana"
						m.wpntypeamount+=1
						var/obj/item/Weapon/Melee/Katana/Bronze/i=new
						m.contents+=i
					if("Spear")
						m.weapontypes+="Spear"
						m.wpntypeamount+=1
						var/obj/item/Weapon/Melee/Spear/Bronze/i=new
						m.contents+=i
					if("Scythe")
						m.weapontypes+="Scythe"
						m.wpntypeamount+=1
						var/obj/item/Weapon/Melee/Scythe/Bronze/i=new
						m.contents+=i
					if("Bow")
						m.weapontypes+="Bow"
						m.wpntypeamount+=1
						var/obj/item/Weapon/Ranged/Bow/Bronze/i=new
						m.contents+=i
					if("Focus Sword")
						m.weapontypes+="Focus Sword"
						m.weapontypes+="Focus Crystal"
						m.wpntypeamount+=1
						var/obj/item/Weapon/Special/FocusSword/Bronze/i=new
						var/obj/item/Weapon/Magical/FocusCrystal/Bronze/t=new
						m.contents+=i
						m.contents+=t
					if("Staff")
						m.weapontypes+="Staff"
						m.wpntypeamount+=1
						var/obj/item/Weapon/Magical/Staff/Bronze/i=new
						m.contents+=i
					if("Tome")
						m.weapontypes+="Tome"
						m.wpntypeamount+=1
						var/obj/item/Weapon/Magical/Tome/Bronze/i=new
						m.contents+=i
					if("Bow Sword")
						m.weapontypes+="Bowsword"
						m.wpntypeamount+=1
						var/obj/item/Weapon/Special/Bowsword/Bronze/i=new
						m.contents+=i
					if("Sword Spear")
						m.weapontypes+="Sword Spear"
						m.wpntypeamount+=2
						var/obj/item/Weapon/Special/SwordSpear/Bronze/i=new
						m.contents+=i
					if("Thief Sword")
						m.weapontypes+="Thief Sword"
						m.wpntypeamount+=2
						var/obj/item/Weapon/Special/ThiefSword/Bronze/i=new
						m.contents+=i
					if("Bolt Rapier")
						m.weapontypes+="Bolt Rapier"
						m.wpntypeamount+=2
						var/obj/item/Weapon/Special/BoltRapier/Bronze/i=new
						m.contents+=i
					if("Whip Blade")
						m.weapontypes+="Whip Blade"
						m.wpntypeamount+=2
						var/obj/item/Weapon/Special/WhipBlade/Bronze/i=new
						m.contents+=i
					if("Akademia Card")
						m.weapontypes+="Akademia Cards"
						m.wpntypeamount+=2
						var/obj/item/Weapon/Ranged/ThrowingWeapons/AkademiaCards/Bronze/i=new
						m.contents+=i
					if("Blitzball")
						m.weapontypes+="Blitz Ball"
						m.wpntypeamount+=2
						var/obj/item/Weapon/Special/BlitzBall/Bronze/i=new
						m.contents+=i
					if("Gun Blade")
						m.weapontypes+="Gun Blade"
						m.wpntypeamount+=2
						var/obj/item/Weapon/Special/Gunblade/Bronze/i=new
						m.contents+=i
					if("Ba'gangsaw")
						m.weapontypes+="Bagangsaw"
						m.wpntypeamount+=2
						var/obj/item/Weapon/Special/Bagangsaw/Bronze/i=new
						m.contents+=i
					if("Buster Sword")
						m.weapontypes+="Buster Sword"
						m.wpntypeamount+=2
						var/obj/item/Weapon/Special/BusterSword/Bronze/i=new
						m.contents+=i
					if("Morphing Blade")
						m.weapontypes+="Morphing Blade"
						m.wpntypeamount+=2
						var/obj/item/Weapon/Special/MorphingBlade/Bronze/i=new
						m.contents+=i
					if("Gun Arm")
						m.weapontypes+="Gun Arm"
						m.wpntypeamount+=2
						var/obj/item/Weapon/Special/GunArm/Bronze/i=new
						m.contents+=i
					if("Magitek Pistol")
						m.weapontypes+="Magitek Pistol"
						m.wpntypeamount+=1
						var/obj/item/Weapon/Special/MagitekPistol/Bronze/i=new
						m.contents+=i
					if("Magitek Rifle")
						m.weapontypes+="Magitek Rifle"
						m.wpntypeamount+=1
						var/obj/item/Weapon/Special/MagitekRifle/Bronze/i=new
						m.contents+=i
			else if(m.wpntypeamount>=3)
				loop=0
		var/list/startingtown=list("Insomnia","Midgar",/*"Tycoon","Garden"*/)
		var/chosen=input(m,"Where would you like to originate from?") as anything in startingtown
		switch(chosen)
			if("Insomnia")
				alert(m,"Almost done, kupo. There is nothing more I can help you with here, but make sure to spend your starting AP on raising your ability scores, and talk to my friends to learn more about the game. Enjoy, kupo.")
				m.loc = locate(200, 186, 1)
				m.starting_city = STARTING_CITY_INSOMNIA
			if("Midgar")
				alert(m,"Almost done, kupo. There is nothing more I can help you with here, but make sure to spend your starting AP on raising your ability scores, and talk to my friends to learn more about the game. Enjoy, kupo.")
				m.loc = locate(125, 297, 17)
				m.starting_city = STARTING_CITY_MIDGAR
			if("Tycoon")
				alert(m,"Almost done, kupo. There is nothing more I can help you with here, but make sure to spend your starting AP on raising your ability scores, and talk to my friends to learn more about the game. Enjoy, kupo.")
				m.loc = locate(97, 238, 10)
			if("Garden")
				alert(m,"Almost done, kupo. There is nothing more I can help you with here, but make sure to spend your starting AP on raising your ability scores, and talk to my friends to learn more about the game. Enjoy, kupo.")
				m.loc = locate(98, 354, 18)
	Bluemageint(var/mob/m)
		alert("As a blue mage you get a choice of up to three blue mages abilities from the start.")
		var/list/choices=list("Photosynthetic Wave","Shrapnel Seed","Geezard Claw","Goblin Strike","Poison Powder","Silver Fang","Mu Claw","Gelantinous Lake","Water Gun","Mesma Blade")
		var/loop=1
		var/a
		while(loop)
			if(m.rpp==0)
				alert("Hmm it appears you don't have any points to spend. Oh well.")
				return
			else
				for(var/obj/perk/p in m.contents)
					if(choices.Find(p.name))
						choices-=p.name
				redostuff:
					var/choice = input(m,"Which ability do you wish? [a]/3") as null|anything in choices
					if(choices!=null)
						choices-=choice
					switch(choice)
						if("Photosynthetic Wave")
							var/obj/perk/MonsterAbilities/BLU/PhotosyntheticWave/p1=new
							m.contents+=p1
							m.rpp--
							a++
							if(a==3)
								loop=0
						if("Shrapnel Seed")
							var/obj/perk/MonsterAbilities/BLU/ShrapnelSeed/p1=new
							m.contents+=p1
							m.rpp--
							a++
							if(a==3)
								loop=0
						if("Geezard Claw")
							var/obj/perk/MonsterAbilities/BLU/GeezardClaw/p1=new
							m.contents+=p1
							m.rpp--
							a++
							if(a==3)
								loop=0
						if("Goblin Strike")
							var/obj/perk/MonsterAbilities/BLU/GoblinStrike/p1=new
							m.contents+=p1
							m.rpp--
							a++
							if(a==3)
								loop=0
						if("Poison Powder")
							var/obj/perk/MonsterAbilities/BLU/PoisonPowder/p1=new
							m.contents+=p1
							m.rpp--
							a++
							if(a==3)
								loop=0
						if("Silver Fang")
							var/obj/perk/MonsterAbilities/BLU/SilverFang/p1=new
							m.contents+=p1
							m.rpp--
							a++
							if(a==3)
								loop=0
						if("Mu Claw")
							var/obj/perk/MonsterAbilities/BLU/MuClaw/p1=new
							m.contents+=p1
							m.rpp--
							a++
							if(a==3)
								loop=0
						if("Gelantinous Lake")
							var/obj/perk/MonsterAbilities/BLU/GelatinousLake/p1=new
							m.contents+=p1
							m.rpp--
							a++
							if(a==3)
								loop=0
						if("Water Gun")
							var/obj/perk/MonsterAbilities/BLU/WaterGun/p1=new
							m.contents+=p1
							m.rpp--
							a++
							if(a==3)
								loop=0
						if("Mesma Blade")
							var/obj/perk/MonsterAbilities/BLU/MesmaBlade/p1=new
							m.contents+=p1
							m.rpp--
							a++
							if(a==3)
								loop=0
						if(null)
							switch(alert("You sure you are finished?",,"Yes","No"))
								if("Yes")
									return
								if("No")
									goto redostuff
	Subjobint(var/mob/m)
		var/list/jobs = list("Merchant","Mystic Knight",/*"Chocobo Knight","Pirate","Gladiator"*/,"Astrologian","Viking","Bard","Dancer","Black Mage","White Mage","Red Mage","Blue Mage","Ranger","Monk","Beast Master","Samurai","Spellblade","Rogue","Paladin","Knight","Dark Knight","Dragoon","Machinist","Summoner","Chemist","Geomancer", "Scholar")
		if(Oracle.Find(m.key))
			jobs+="Oracle"
		if(Timemage.Find(m.key))
			jobs+="Time Mage"
		jobs-=m.job
		m.subjobcap=2
		var/jobchoice = input(m,"What job kupo?") as anything in jobs
		switch(jobchoice)
			/*if("Chocobo Knight")
				m.subjob="Chocobo Knight"
				var/obj/perk/Jobperks/ChocoboKnight/ChocoboKnight/p1=new
				var/obj/npc/Summons/CRank/ChocoSteed/p2=new
				m.contents+=p1
				m.contents+=p2*/
			if("Pirate")
				m.subjob="Pirate"
				var/obj/perk/Jobperks/Pirate/Pirate/p1=new
				m.contents+=p1
			if("Gladiator")
				m.subjob="Gladiator"
				var/obj/perk/Jobperks/Gladiator/Gladiator/p1=new
				m.contents+=p1
			if("Gladiator")
			if("Mystic Knight")
				m.subjob="Mystic Knight"
				var/obj/perk/Jobperks/MysticKnight/MysticKnight/p1=new
				m.contents+=p1
				Magicuseincrease(m,2,3)
				Magicuseincrease(m,4,2)
			if("Time Mage")
				m.subjob="Time Mage"
				var/obj/perk/Jobperks/TimeMage/TimeMage/p1=new
				m.contents+=p1
				Magicuseincrease(m,1,2)
				Magicuseincrease(m,2,2)
				Magicuseincrease(m,3,2)
				Magicuseincrease(m,4,2)
			if("Oracle")
				m.subjob="Oracle"
				var/obj/perk/Jobperks/Oracle/p1=new
				m.contents+=p1
				Magicuseincrease(m,1,4)
			if("Astrologian")
				m.subjob="Astrologian"
				var/obj/perk/Jobperks/Astrologian/Astrologian/p1=new
				m.contents+=p1
				Magicuseincrease(m,3,6)
				Magicuseincrease(m,1,3)
			if("Scholar")
				m.subjob="Scholar"
				var/obj/perk/Jobperks/Scholar/Scholar/p1=new
				m.contents+=p1
				Magicuseincrease(m,1,3)
				Magicuseincrease(m,4,3)
				Scholarint()
			if("Merchant")
				m.subjob="Merchant"
				var/obj/perk/Jobperks/Merchant/Merchant/p1=new
				m.contents+=p1
			if("Viking")
				m.subjob="Viking"
				var/obj/perk/Jobperks/Viking/Viking/p1=new
				m.contents+=p1
			if("Bard")
				m.subjob="Bard"
				var/obj/perk/Jobperks/Bard/Bard/p1=new
				m.contents+=p1
			if("Dancer")
				m.subjob="Dancer"
				var/obj/perk/Jobperks/Dancer/Dancer/p1=new
				m.contents+=p1
			if("Black Mage")
				m.subjob="Black Mage"
				var/obj/perk/Jobperks/BlackMage/BlackMage/p1=new
				m.contents+=p1
				Magicuseincrease(m,2,6)
				Magicuseincrease(m,4,3)
			if("White Mage")
				m.subjob="White Mage"
				var/obj/perk/Jobperks/WhiteMage/WhiteMage/p1=new
				m.contents+=p1
				Magicuseincrease(m,1,6)
				Magicuseincrease(m,3,3)
			if("Red Mage")
				m.subjob="Red Mage"
				var/obj/perk/Jobperks/RedMage/RedMage/p1=new
				m.contents+=p1
				Magicuseincrease(m,1,3)
				Magicuseincrease(m,2,3)
				Magicuseincrease(m,3,3)
				Magicuseincrease(m,4,3)
			if("Blue Mage")
				m.subjob="Blue Mage"
				var/obj/perk/Jobperks/BlueMage/BlueMage/p1=new
				m.contents+=p1
				Bluemageint(m)
			if("Ranger")
				m.subjob="Ranger"
				var/obj/perk/Jobperks/Ranger/Ranger/p1=new
				m.contents+=p1
			if("Monk")
				m.subjob="Monk"
				var/obj/perk/Jobperks/Monk/Monk/p1=new
				m.contents+=p1
			if("Beast Master")
				m.subjob="Beast Master"
				var/obj/perk/Jobperks/BeastMaster/BeastMaster/p1=new
				m.contents+=p1
			if("Samurai")
				m.subjob="Samurai"
				var/obj/perk/Jobperks/Samurai/Samurai/p1=new
				m.contents+=p1
			if("Spellblade")
				m.subjob="Spellblade"
				var/obj/perk/Jobperks/Spellblade/Spellblade/p1=new
				m.contents+=p1
			if("Rogue")
				m.subjob="Rogue"
				var/obj/perk/Jobperks/Rogue/Rogue/p1=new
				m.contents+=p1
			if("Paladin")
				m.subjob="Paladin"
				var/obj/perk/Jobperks/Paladin/Paladin/p1=new
				m.contents+=p1
				Magicuseincrease(m,3,2)
				Magicuseincrease(m,1,3)
			if("Knight")
				m.subjob="Knight"
				var/obj/perk/Jobperks/Knight/Knight/p1=new
				m.contents+=p1
			if("Dark Knight")
				m.subjob="Dark Knight"
				var/obj/perk/Jobperks/DarkKnight/DarkKnight/p1=new
				m.contents+=p1
			if("Dragoon")
				m.subjob="Dragoon"
				var/obj/perk/Jobperks/Dragoon/Dragoon/p1=new
				m.contents+=p1
				m.weapontypes+="Draconic"

			if("Machinist")
				m.subjob="Machinist"
				var/obj/perk/Jobperks/Machinist/Machinist/p1=new
				m.contents+=p1
				m.weapontypes+="Machinist"
			if("Summoner")
				m.subjob="Summoner"
				var/obj/perk/Jobperks/Summoner/Summoner/p1=new
				m.contents+=p1
				m.buysummons=1
				Magicuseincrease(m,3,3)
				Magicuseincrease(m,4,3)
				Summonerint()
			if("Chemist")
				m.subjob="Chemist"
				m.weapontypes+="Chemist"
				var/obj/perk/Jobperks/Chemist/Chemist/p1=new
				m.contents+=p1
				m.weapontypes+="Chemist"
			if("Geomancer")
				m.subjob="Geomancer"
				var/obj/perk/Jobperks/Geomancer/Geomancer/p1=new
				m.contents+=p1
	Magicuseincrease(var/mob/m,var/d,var/a)
		switch(d)
			if(1)
				if(m.whitemagicable>a)
					return
				else
					m.whitemagicable=a
			if(2)
				if(m.blackmagicable>a)
					return
				else
					m.blackmagicable=a
			if(3)
				if(m.greenmagicable>a)
					return
				else
					m.greenmagicable=a
			if(4)
				if(m.arcanemagicable>a)
					return
				else
					m.arcanemagicable=a
