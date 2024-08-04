/mob
	var/inbattle=0
	var/maxbattlers
	var/aoesetx
	var/aoesety
	var/aoesetmode
	var/aoenote
	var/list/cusaoe=new
	var/obj/Aoeind/setcus

/atom
	var/buildable = FALSE

/obj/Aoeind
	icon='AOEind.dmi'
	layer = 2
	var/setx
	var/sety

/obj/Aoeind/Click()
	if(usr.aoeclick)
		if(src.owner==usr.key)
			usr.aoetiles--
			del(src)
	else
		alert(usr,"[desc]")

/obj/Reaction
	icon='Icons/Reacting.dmi'
	layer=10
	pixel_x=-15

/obj/copyimg1
	var/batorder
	layer=2

mob
	verb
		AOE()
			usr.building=0
			usr.encountclick=0
			if(usr.intitlescreen)
				return
			if(!usr.aoeclick)
				var/list/optionslist=list("Single","AoE","Aura","Clear","Create")
				for(var/obj/Aoeind/ao in usr.cusaoe)
					optionslist+=ao.name
				var/choice=input("What do you wish to do?") as anything in optionslist
				switch(choice)
					if("Single")
						usr.aoenote=input("Set a note for the indicator when clicked or leave blank") as text
						usr.aoeclick = 1
						usr.aoesetmode="single"
						usr<<output("Click anywhere on the map to put an AOE indicater","oocout")
					if("AoE")
						usr.aoenote=input("Set a note for the indicator when clicked or leave blank") as text
						var/chx=input("How wide (in tiles) do you wish to set the indicator?") as num
						usr.aoesetx=chx
						var/chy=input("How tall (in tiles) do you wish to set the indicator?") as num
						usr.aoesety=chy
						usr.aoeclick=1
						usr.aoesetmode="aoe"
					if("Aura")
						usr.aoenote=input("Set a note for the indicator when clicked or leave blank") as text
						var/chx=input("How wide (in tiles) do you wish to set the indicator?") as num
						usr.aoesetx=chx
						var/chy=input("How tall (in tiles) do you wish to set the indicator?") as num
						usr.aoesety=chy
						usr.aoeclick=1
						usr.aoesetmode="aura"
					if("Clear")
						for(var/obj/Aoeind/o in world)
							if(o.owner==usr.key)
								del(o)
						usr.aoetiles=0
					if("Create")
						var/obj/Aoeind/a=new
						a.name=input("Choose a name for the AoE") as text
						a.setx=input("How wide? In tiles") as num
						a.sety=input("How tall? In tiles") as num
						switch(alert("Do you wish to set a custom icon?",,"Yes","No"))
							if("Yes")
								a.icon=input("Set a custom icon") as icon
						usr.cusaoe+=a
					else
						for(var/obj/Aoeind/a in usr.cusaoe)
							if(choice==a.name)
								usr.aoesetmode="cust"
								usr.setcus=a
								usr.aoeclick=1

			else
				usr.aoeclick = 0
				usr.aoesetx=null
				usr.aoesety=null
				usr.aoesetmode=null
				usr.aoenote=null
				usr.setcus=null
				usr<<output("You are no longer placing indicators.","oocout")
		Reacting()
			var/choice = alert(usr, "Would you like to indicate a reaction?", "Reaction!", "Yes", "No")
			if(choice == "No")
				return
			var/obj/Reaction/r = new /obj/Reaction
			r.loc=locate(usr.x,usr.y,usr.z)
			view()<<output("[usr.name] is preparing a reaction!","icout")
			animate(r, transform = matrix()*2,alpha=0, time = 10)
			spawn(50)
			del(r)


atom
	proc
		Checkownership(var/mob/m, var/atom/surc)
			var/owncheck=1
			for(var/obj/Fortress/a in range(15,surc))
				if(a.faction==m.faction || a.owner==m.key)
					owncheck=0
				if(a.faction != null)
					if(a.faction != m.faction)
						alert(m,"This area belongs to another Faction!")
						return 1
			for(var/obj/House/a in range(8,surc))
				if(a.owner==m.key)
					owncheck=0
				if(a.owner != null)
					if(a.owner != m.key)
						alert(m,"This area belongs to another Player!")
						return 1
			for(var/obj/Landclaim/a in range(20,surc))
				if(a.owner==m.key)
					owncheck=0
				if(a.faction==m.faction)
					owncheck=0
				if(a.owner != null)
					if(a.owner != m.key)
						alert(m,"This area belongs to another Player!")
						return 1
				if(a.faction != null)
					if(a.faction != m.faction)
						alert(m,"This area belongs to another Faction!")
						return 1
				if(a.owner==m.key)
					owncheck=0
				if(a.faction==m.faction)
					owncheck=0
			if(owncheck>=1)
				return 1
			else
				return 0

atom
	Click()
		if(usr.aoeclick)
			if(usr.aoetiles<20)
				switch(usr.aoesetmode)
					if("single")
						var/obj/Aoeind/o = new /obj/Aoeind/
						if(usr.aoeicon)
							o.icon=usr.aoeicon
						o.desc=usr.aoenote
						o.loc=locate(src.x,src.y,src.z)
						o.owner=usr.key
						usr.aoetiles++
					if("aoe")
						var/obj/Aoeind/o=new
						if(usr.aoeicon)
							o.icon=usr.aoeicon
						o.desc=usr.aoenote
						var/matrix/M=matrix()
						M.Scale(usr.aoesetx,usr.aoesety)
						o.transform=M
						o.loc=locate(src.x,src.y,src.z)
						o.owner=usr.key
						usr.aoetiles=usr.aoesetx+usr.aoesety
					if("aura")
						var/obj/Aoeind/o=new
						if(usr.aoeicon)
							o.icon=usr.aoeicon
						o.desc=usr.aoenote
						var/matrix/M=matrix()
						M.Scale(usr.aoesetx,usr.aoesety)
						o.transform=M
						o.owner=usr.key
						if(istype(src,/mob))
							var/mob/m=src
							if(m==usr)
								m.vis_contents+=o
							else
								switch(input(m,"[usr] wishes to apply an aura on you. Accept?") in list("Yes","No"))
									if("Yes")
										m.vis_contents+=o
									if("No")
										alert(usr,"[m.name] has declined the aura.")
						if(istype(src,/obj/npc))
							var/obj/npc/n=src
							if(n.owner==usr.ckey)
								n.vis_contents+=o
					if("cust")
						var/obj/Aoeind/o=copyatom(usr.setcus)
						var/matrix/M=matrix()
						M.Scale(o.setx,o.sety)
						o.transform=M
						o.owner=usr.key
						o.loc=locate(src.x,src.y,src.z)
						usr.aoetiles=o.setx+o.sety

			else
				alert("You have too many tiles already.")
		if(usr.building)
			if(Checkownership(usr,src))
				if(usr.adminlv<2)
					alert(usr,"There is no ownership object with your ID in this area!")
					return
				else
			if(usr.adminlv<2)
				if(Checkarea(usr,src))
					for(var/obj/Builds/o in usr.contents)
						if(o.bprice>usr.money)
							usr<<output("You don't have enough money to build that.","oocout")
							return
						else
							if(o.isdoor==1)
								var/obj/Builds/Buildobjects/Door/A = new
								A.density=o.density
								A.opacity=o.opacity
								A.name=o.name
								A.bprice=o.bprice
								A.layer=2
								A.icon=o.icon
								A.icon_state=o.icon_state
								A.owner=o.owner
								A.faction=o.faction
								A.loc=locate(src.x,src.y,src.z)
								A.closedstate=o.closedstate
								A.openstate=o.openstate
								usr.money-=A.bprice
								A.built=1
								A.Savable=1
								A.mouse_opacity=0
							else
								var/obj/A = copyatom(o)
								A.density=o.density
								A.opacity=o.opacity
								A.name=o.name
								A.bprice=o.bprice
								A.layer=o.layer
								A.icon=o.icon
								A.icon_state=o.icon_state
								A.loc=locate(src.x,src.y,src.z)
								A.owner=o.owner
								A.faction=o.faction
								A.builder="([usr.key])[usr.name]"
								usr.money-=A.bprice
								A.built=1
								A.Savable=1
								A.mouse_opacity=0
				else
					usr<<output("You can't build here.","oocout")
			else
				for(var/obj/Builds/o in usr.contents)
					if(o.isdoor==1)
						var/obj/Builds/Buildobjects/Door/A = new
						A.density=o.density
						A.opacity=o.opacity
						A.name=o.name
						A.bprice=o.bprice
						A.layer=2
						A.icon=o.icon
						A.icon_state=o.icon_state
						A.owner=o.owner
						A.faction=o.faction
						A.loc=locate(src.x,src.y,src.z)
						A.closedstate=o.closedstate
						A.openstate=o.openstate
						usr.money-=A.bprice
						A.built=1
						A.Savable=1
						A.mouse_opacity=0
					else
						var/obj/Builds/A = copyatom(o)
						A.density=o.density
						A.opacity=o.opacity
						A.name=o.name
						A.bprice=o.bprice
						A.layer=o.layer
						A.icon=o.icon
						A.icon_state=o.icon_state
						A.loc=locate(src.x,src.y,src.z)
						A.loc=locate(src.x,src.y,src.z)
						A.owner=o.owner
						A.faction=o.faction
						A.builder="([usr.key])[usr.name]"
						A.built=1
						A.Savable=1
						A.mouse_opacity=0
	DblClick()
		if(usr.deploynpc)
			var/matrix/M = matrix()
			M.Scale(2,2)
			var/matrix/M2 = matrix()
			M2.Scale(0.5,0.5)
			var/obj/npc/n = usr.deploynpc
			usr.contents-=n
			n.loc = locate(src.x,src.y,src.z)
			view()<<output("[n.name] has appeared!","icout")
			n.overlays=null
			usr.deploynpc = null
			n.owner=usr.key
			n.Savable=1


proc
	Checkarea(t as turf)
		for(var/area/A in view(0,t))
			if(istype(A,/area/Buildarea))
				return 1
	Applyglobalmod(var/mob/m, var/obj/globalmod/g)
		if(!istype(g))
			return
		m.addstr += g.mstr
		m.adddex += g.mdex
		m.addcon += g.mcon
		m.addint += g.mint
		m.addwis += g.mwis
		m.addcha += g.mcha
		m.baseac += g.mac
		m.basedr += g.mdr
		//m.pab+=g.mpab
		//m.pdb+=g.mpdb
		//m.mdb+=g.mmdb
		//m.mab+=g.mmab
		m.pabadd+=g.mpab
		m.pdbadd+=g.mpdb
		m.mdbadd+=g.mmdb
		m.mabadd+=g.mmab
		m.baserflx += g.mrflx
		m.basewill += g.mwill
		m.basefort += g.mfort
		//m.speed+=g.mspd
		m.speedadd+=g.mspd
		m.baseacro+=g.macro
		m.baseath+=g.mathl
		m.basearc+=g.march
		m.basedec+=g.mdec
		m.basedung+=g.mdung
		m.baseenchant+=g.menc
		m.basein+=g.minsi
		m.baseinv+=g.minv
		m.basemagic+=g.mmag
		m.basemagio+=g.mmagi
		m.basemed+=g.mmed
		m.basenat+=g.mnat
		m.baseper+=g.mperc
		m.basepers+=g.mpers
		m.basestl+=g.msth
		m.basethv+=g.mthv
		m.basesurv+=g.msurv
		m.Checkmod(1,m.str,m.addstr,m)
		m.Checkmod(2,m.dex,m.adddex,m)
		m.Checkmod(3,m.con,m.addcon,m)
		m.Checkmod(4,m.int,m.addint,m)
		m.Checkmod(5,m.wis,m.addwis,m)
		m.Checkmod(6,m.cha,m.addcha,m)
		m.Skillcheck(m)
		m.Carrycheck(m)
		m.Savecheck(m)
		m.ACcheck(m)

	Removeglobalmod(var/mob/m, var/obj/globalmod/g)
		m.addstr -= g.mstr
		m.adddex -= g.mdex
		m.addcon -= g.mcon
		m.addint -= g.mint
		m.addwis -= g.mwis
		m.addcha -= g.mcha
		m.baseac -= g.mac
		m.basedr -= g.mdr
		m.baserflx -= g.mrflx
		m.basewill -= g.mwill
		m.basefort -= g.mfort
		//m.pab-=g.mpab
		//m.pdb-=g.mpdb
		//m.mdb-=g.mmdb
		//m.mab-=g.mmab
		m.pabadd-=g.mpab
		m.pdbadd-=g.mpdb
		m.mdbadd-=g.mmdb
		m.mabadd-=g.mmab
		//m.speed-=g.mspd
		m.speedadd-=g.mspd
		m.baseacro-=g.macro
		m.baseath-=g.mathl
		m.basearc-=g.march
		m.basedec-=g.mdec
		m.basedung-=g.mdung
		m.baseenchant-=g.menc
		m.basein-=g.minsi
		m.baseinv-=g.minv
		m.basemagic-=g.mmag
		m.basemagio-=g.mmagi
		m.basemed-=g.mmed
		m.basenat-=g.mnat
		m.baseper-=g.mperc
		m.basepers-=g.mpers
		m.basestl-=g.msth
		m.basethv-=g.mthv
		m.basesurv-=g.msurv
		m.Checkmod(1,m.str,m.addstr,m)
		m.Checkmod(2,m.dex,m.adddex,m)
		m.Checkmod(3,m.con,m.addcon,m)
		m.Checkmod(4,m.int,m.addint,m)
		m.Checkmod(5,m.wis,m.addwis,m)
		m.Checkmod(6,m.cha,m.addcha,m)
		m.Skillcheck(m)
		m.Carrycheck(m)
		m.Savecheck(m)
		m.ACcheck(m)

obj
	proc
		RefreshAll(var/mob/a)
			a.Checkmod(1,usr.str,usr.addstr,a)
			a.Checkmod(2,usr.dex,usr.adddex,a)
			a.Checkmod(3,usr.con,usr.addcon,a)
			a.Checkmod(4,usr.int,usr.addint,a)
			a.Checkmod(5,usr.wis,usr.addwis,a)
			a.Checkmod(6,usr.cha,usr.addcha, a)
			a.Skillcheck(a)
			a.Carrycheck(a)
			a.Savecheck(a)
			a.ACcheck(a)
mob
	proc
		RefreshAll(var/mob/a)
			a.Checkmod(1,usr.str,usr.addstr,a)
			a.Checkmod(2,usr.dex,usr.adddex,a)
			a.Checkmod(3,usr.con,usr.addcon,a)
			a.Checkmod(4,usr.int,usr.addint,a)
			a.Checkmod(5,usr.wis,usr.addwis,a)
			a.Checkmod(6,usr.cha,usr.addcha, a)
			a.Skillcheck(a)
			a.Carrycheck(a)
			a.Savecheck(a)
			a.ACcheck(a)
obj
	proc
		RefreshGPM(var/mob/a)
			var/row
			winset(a,"GMandperk","is-visible=true")
			winset(a,"GMandperk.c","is-visible=true")
			winset(a,"GMandperk.gm","cells=0x0")
			for(var/obj/globalmod/g in a.contents)
				row++
				winset(a, "Gmandperk.gm", "current-cell=1,[row]")
				usr << output(g,"GMandperk.gm")
				winset(a, "GMandperk.gm", "current-cell=2,[row]")
				usr<<output(g.desc,"GMandperk.gm")
				winset(a,"GMandperk.gm","current-cell=3,[row]")
				if(g.applied==1)
					a<<output("Equipped","GMandperk.gm")
				else
					a<<output("Unequipped","GMandperk.gm")

obj
	globalmod
		icon='AbilityScore.png'
		var
			selected
			fromequip
			applied
			approved
			mstr=0
			mdex
			mcon
			mint
			mwis
			mcha
			mrflx
			mfort
			mwill
			mcritmod

			mpab
			mpdb
			mmab
			mmdb

			mac
			mdr
			mspd

			macro
			mathl
			march
			mdec
			mdung
			menc
			minsi
			minv
			mmag
			mmagi
			mmed
			mnat
			mperc
			mpers
			msth
			mthv
			msurv
		Click()
			var/list/deleteoption=list("Equip","Delete","Cancel")
			var/doption=input("Would you like to Equip, or Delete this global mod?") as anything in deleteoption
			switch(doption)
				if("Equip")

				if("Delete")
					if(src.applied)
						alert(usr,"This global mod is equipped, and can not be deleted!")
						return
					var/list/yesno=list("Yes","No")
					var/yoption=input("Are you sure you wish to delete this global mod?") as anything in yesno
					switch(yoption)
						if("Yes")
							del src
						if("No")
							return
				if("Cancel")
					return
			if(src in usr.contents)
			else
				return
			if(!src.applied)
				src.applied=1
				usr.addstr += src.mstr
				usr.adddex += src.mdex
				usr.addcon += src.mcon
				usr.addint += src.mint
				usr.addwis += src.mwis
				usr.addcha += src.mcha
				usr.baseac += src.mac
				usr.basedr += src.mdr
				usr.critmod+=src.mcritmod
				//usr.speed+=src.mspd
				usr.speedadd+=src.mspd
				usr.baserflx += src.mrflx
				usr.basewill += src.mwill
				usr.basefort += src.mfort
				//usr.pab+=src.mpab
				//usr.pdb+=src.mpdb
				//usr.mdb+=src.mmdb
				//usr.mab+=src.mmab
				usr.pabadd+=src.mpab
				usr.pdbadd+=src.mpdb
				usr.mdbadd+=src.mmdb
				usr.mabadd+=src.mmab
				usr.baseacro+=src.macro
				usr.baseath+=src.mathl
				usr.basearc+=src.march
				usr.basedec+=src.mdec
				usr.basedung+=src.mdung
				usr.baseenchant+=src.menc
				usr.basein+=src.minsi
				usr.baseinv+=src.minv
				usr.basemagic+=src.mmag
				usr.basemagio+=src.mmagi
				usr.basemed+=src.mmed
				usr.basenat+=src.mnat
				usr.baseper+=src.mperc
				usr.basepers+=src.mpers
				usr.basestl+=src.msth
				usr.basethv+=src.mthv
				usr.basesurv+=msurv
				usr.Checkmod(1,usr.str,usr.addstr,usr)
				usr.Checkmod(2,usr.dex,usr.adddex,usr)
				usr.Checkmod(3,usr.con,usr.addcon,usr)
				usr.Checkmod(4,usr.int,usr.addint,usr)
				usr.Checkmod(5,usr.wis,usr.addwis,usr)
				usr.Checkmod(6,usr.cha,usr.addcha,usr)
				usr.Skillcheck(usr)
				usr.Carrycheck(usr)
				usr.Savecheck(usr)
				usr.ACcheck(usr)
				RefreshGPM(usr)
				view()<<output("<b><font color=[usr.textcolor]>[usr.name]</font> has applied a <b>globalmod</b>:<font color=yellow><b>[src.name]</b>","icout")
			else
				if(!fromequip)
					src.applied=0
					usr.addstr -= src.mstr
					usr.adddex -= src.mdex
					usr.addcon -= src.mcon
					usr.addint -= src.mint
					usr.addwis -= src.mwis
					usr.addcha -= src.mcha
					usr.baseac -= src.mac
					usr.basedr -= src.mdr
					usr.critmod-=src.mcritmod
					//usr.speed-=src.mspd
					usr.speedadd-=src.mspd
					usr.baserflx -= src.mrflx
					usr.basewill -= src.mwill
					usr.basefort -= src.mfort
					//usr.pab-=src.mpab
					//usr.pdb-=src.mpdb
					//usr.mdb-=src.mmdb
					//usr.mab-=src.mmab
					usr.pabadd-=src.mpab
					usr.pdbadd-=src.mpdb
					usr.mdbadd-=src.mmdb
					usr.mabadd-=src.mmab
					usr.baseacro-=src.macro
					usr.baseath-=src.mathl
					usr.basearc-=src.march
					usr.basedec-=src.mdec
					usr.basedung-=src.mdung
					usr.baseenchant-=src.menc
					usr.basein-=src.minsi
					usr.baseinv-=src.minv
					usr.basemagic-=src.mmag
					usr.basemagio-=src.mmagi
					usr.basemed-=src.mmed
					usr.basenat-=src.mnat
					usr.baseper-=src.mperc
					usr.basepers-=src.mpers
					usr.basestl-=src.msth
					usr.basethv-=src.mthv
					usr.basesurv-=msurv
					usr.Checkmod(1,usr.str,usr.addstr,usr)
					usr.Checkmod(2,usr.dex,usr.adddex,usr)
					usr.Checkmod(3,usr.con,usr.addcon,usr)
					usr.Checkmod(4,usr.int,usr.addint,usr)
					usr.Checkmod(5,usr.wis,usr.addwis,usr)
					usr.Checkmod(6,usr.cha,usr.addcha,usr)
					usr.Skillcheck(usr)
					usr.Carrycheck(usr)
					usr.Savecheck(usr)
					usr.ACcheck(usr)
					RefreshGPM(usr)
					view()<<output("<b><font color=[usr.textcolor]>[usr.name]</font> has removed a <b>globalmod</b>:<font color=yellow><b>[src.name]</b>","icout")
			usr.ACcheck(usr)

mob
	verb
		OpenGMP()
			var/row
			winset(usr,"GMandperk","is-visible=true")
			winset(usr,"GMandperk.c","is-visible=true")
			winset(usr,"GMandperk.gm","cells=0x0")
			for(var/obj/globalmod/g in usr.contents)
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

		CreateNewGM()
			var/obj/globalmod/g = new
			usr.contents+=g
			g.selected=1
			g.name=input("What do you wish to call this modifier?") as text
			usr.makingitem=1
			winset(usr,"GM.Gname","text=\"[g.name]\"")
			winset(usr,"GM.crit","is-visible=true")
			winset(usr,"GM.critminus","is-visible=true")
			winset(usr,"GM.critadd","is-visible=true")
			winset(usr,"GM.conf","is-visible=true")
			winset(usr,"GM.astr","is-visible=true")
			winset(usr,"GM.mstr","is-visible=true")
			winset(usr,"GM.adex","is-visible=true")
			winset(usr,"GM.mdex","is-visible=true")
			winset(usr,"GM.acon","is-visible=true")
			winset(usr,"GM.mcon","is-visible=true")
			winset(usr,"GM.aint","is-visible=true")
			winset(usr,"GM.mint","is-visible=true")
			winset(usr,"GM.awis","is-visible=true")
			winset(usr,"GM.mwis","is-visible=true")
			winset(usr,"GM.acha","is-visible=true")
			winset(usr,"GM.mcha","is-visible=true")
			winset(usr,"GM.aac","is-visible=true")
			winset(usr,"GM.mac","is-visible=true")
			winset(usr,"GM.adr","is-visible=true")
			winset(usr,"GM.mdr","is-visible=true")
			winset(usr,"GM.aspd","is-visible=true")
			winset(usr,"GM.mspd","is-visible=true")
			winset(usr,"GM.pbadd","is-visible=true")
			winset(usr,"GM.mbadd","is-visible=true")
			winset(usr,"GM.mdadd","is-visible=true")
			winset(usr,"GM.pdadd","is-visible=true")
			winset(usr,"GM.pbminus","is-visible=true")
			winset(usr,"GM.mbminus","is-visible=true")
			winset(usr,"GM.mdminus","is-visible=true")
			winset(usr,"GM.pdminus","is-visible=true")
			winset(usr,"GM.arflx","is-visible=true")
			winset(usr,"GM.mrflx","is-visible=true")
			winset(usr,"GM.afort","is-visible=true")
			winset(usr,"GM.mfort","is-visible=true")
			winset(usr,"GM.awill","is-visible=true")
			winset(usr,"GM.mwill","is-visible=true")
			winset(usr,"GM.aac","is-visible=true")
			winset(usr,"GM.mac","is-visible=true")
			winset(usr,"GM.adr","is-visible=true")
			winset(usr,"GM.mdr","is-visible=true")
			winset(usr,"GM.aspd","is-visible=true")
			winset(usr,"GM.mspd","is-visible=true")
			winset(usr,"GM.arflx","is-visible=true")
			winset(usr,"GM.mrflx","is-visible=true")
			winset(usr,"GM.afort","is-visible=true")
			winset(usr,"GM.mfort","is-visible=true")
			winset(usr,"GM.awill","is-visible=true")
			winset(usr,"GM.mwill","is-visible=true")
			winset(usr,"GM.aacro","is-visible=true")
			winset(usr,"GM.macro","is-visible=true")
			winset(usr,"GM.aath","is-visible=true")
			winset(usr,"GM.math","is-visible=true")
			winset(usr,"GM.aarch","is-visible=true")
			winset(usr,"GM.march","is-visible=true")
			winset(usr,"GM.adec","is-visible=true")
			winset(usr,"GM.mdec","is-visible=true")
			winset(usr,"GM.adung","is-visible=true")
			winset(usr,"GM.mdung","is-visible=true")
			winset(usr,"GM.aenc","is-visible=true")
			winset(usr,"GM.menc","is-visible=true")
			winset(usr,"GM.ains","is-visible=true")
			winset(usr,"GM.mins","is-visible=true")
			winset(usr,"GM.ainv","is-visible=true")
			winset(usr,"GM.minv","is-visible=true")
			winset(usr,"GM.amag","is-visible=true")
			winset(usr,"GM.mmag","is-visible=true")
			winset(usr,"GM.amagi","is-visible=true")
			winset(usr,"GM.mmagi","is-visible=true")
			winset(usr,"GM.amed","is-visible=true")
			winset(usr,"GM.mmed","is-visible=true")
			winset(usr,"GM.anat","is-visible=true")
			winset(usr,"GM.mnat","is-visible=true")
			winset(usr,"GM.aper","is-visible=true")
			winset(usr,"GM.mper","is-visible=true")
			winset(usr,"GM.apers","is-visible=true")
			winset(usr,"GM.mpers","is-visible=true")
			winset(usr,"GM.asth","is-visible=true")
			winset(usr,"GM.msth","is-visible=true")
			winset(usr,"GM.athv","is-visible=true")
			winset(usr,"GM.mthv","is-visible=true")
			winset(usr,"GM.asur","is-visible=true")
			winset(usr,"GM.msur","is-visible=true")
		OpenGM()
			winset(usr,"GM","is-visible=true")
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					del(g)
		CloseGM()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					del(g)
			winset(usr,"GM.gname","text=\"\"")
			winset(usr,"GM.conf","is-visible=false")
			winset(usr,"GM.critminus","is-visible=false")
			winset(usr,"GM.critadd","is-visible=false")
			winset(usr,"GM.pbadd","is-visible=false")
			winset(usr,"GM.mbadd","is-visible=false")
			winset(usr,"GM.mdadd","is-visible=false")
			winset(usr,"GM.pdadd","is-visible=false")
			winset(usr,"GM.pbminus","is-visible=false")
			winset(usr,"GM.mbminus","is-visible=false")
			winset(usr,"GM.mdminus","is-visible=false")
			winset(usr,"GM.pdminus","is-visible=false")
			winset(usr,"GM.str","text=\"STR:\"")
			winset(usr,"GM.dex","text=\"DEX:\"")
			winset(usr,"GM.con","text=\"CON:\"")
			winset(usr,"GM.int","text=\"INT:\"")
			winset(usr,"GM.wis","text=\"WIS:\"")
			winset(usr,"GM.cha","text=\"CHA:\"")
			winset(usr,"GM.ac","text=\"AC:\"")
			winset(usr,"GM.dr","text=\"DR:\"")
			winset(usr,"GM.spd","text=\"Speed:\"")
			winset(usr,"GM.rflx","text=\"Reflex:\"")
			winset(usr,"GM.fort","text=\"Fortitude:\"")
			winset(usr,"GM.will","text=\"Will:\"")
			winset(usr,"GM.acro","text=\"Acrobatics:\"")
			winset(usr,"GM.athl","text=\"/Athletics:\"")
			winset(usr,"GM.arch","text=\"Archaeology:\"")
			winset(usr,"GM.dec","text=\"Deception:\"")
			winset(usr,"GM.dung","text=\"Dungeoneering:\"")
			winset(usr,"GM.enc","text=\"Enchantment:\"")
			winset(usr,"GM.ins","text=\"Insight:\"")
			winset(usr,"GM.inv","text=\"Investigation:\"")
			winset(usr,"GM.mag","text=\"Magic:\"")
			winset(usr,"GM.magi","text=\"Magi Op.:\"")
			winset(usr,"GM.med","text=\"Medicine:\"")
			winset(usr,"GM.nat","text=\"Naturalist:\"")
			winset(usr,"GM.per","text=\"Perception:\"")
			winset(usr,"GM.pers","text=\"Persuasion:\"")
			winset(usr,"GM.sth","text=\"Stealth:\"")
			winset(usr,"GM.thv","text=\"Thievery:\"")
			winset(usr,"GM.sur","text=\"Survival:\"")
			usr.makingitem=0
		ConfirmGM()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.selected=0
					winset(usr,"GM.gname","text=\"\"")
					winset(usr,"GM.critminus","is-visible=false")
					winset(usr,"GM.critadd","is-visible=false")
					winset(usr,"GM.pbadd","is-visible=false")
					winset(usr,"GM.mbadd","is-visible=false")
					winset(usr,"GM.mdadd","is-visible=false")
					winset(usr,"GM.pdadd","is-visible=false")
					winset(usr,"GM.pbminus","is-visible=false")
					winset(usr,"GM.mbminus","is-visible=false")
					winset(usr,"GM.mdminus","is-visible=false")
					winset(usr,"GM.pdminus","is-visible=false")
					winset(usr,"GM.conf","is-visible=false")
					winset(usr,"GM.astr","is-visible=false")
					winset(usr,"GM.mstr","is-visible=false")
					winset(usr,"GM.adex","is-visible=false")
					winset(usr,"GM.mdex","is-visible=false")
					winset(usr,"GM.acon","is-visible=false")
					winset(usr,"GM.mcon","is-visible=false")
					winset(usr,"GM.aint","is-visible=false")
					winset(usr,"GM.mint","is-visible=false")
					winset(usr,"GM.awis","is-visible=false")
					winset(usr,"GM.mwis","is-visible=false")
					winset(usr,"GM.acha","is-visible=false")
					winset(usr,"GM.mcha","is-visible=false")
					winset(usr,"GM.aac","is-visible=false")
					winset(usr,"GM.mac","is-visible=false")
					winset(usr,"GM.adr","is-visible=false")
					winset(usr,"GM.mdr","is-visible=false")
					winset(usr,"GM.aspd","is-visible=false")
					winset(usr,"GM.mspd","is-visible=false")
					winset(usr,"GM.arflx","is-visible=false")
					winset(usr,"GM.mrflx","is-visible=false")
					winset(usr,"GM.afort","is-visible=false")
					winset(usr,"GM.mfort","is-visible=false")
					winset(usr,"GM.awill","is-visible=false")
					winset(usr,"GM.mwill","is-visible=false")
					winset(usr,"GM.aac","is-visible=true")
					winset(usr,"GM.mac","is-visible=true")
					winset(usr,"GM.adr","is-visible=true")
					winset(usr,"GM.mdr","is-visible=true")
					winset(usr,"GM.aspd","is-visible=true")
					winset(usr,"GM.mspd","is-visible=true")
					winset(usr,"GM.arflx","is-visible=true")
					winset(usr,"GM.mrflx","is-visible=true")
					winset(usr,"GM.afort","is-visible=true")
					winset(usr,"GM.mfort","is-visible=true")
					winset(usr,"GM.awill","is-visible=true")
					winset(usr,"GM.mwill","is-visible=true")
					winset(usr,"GM.aacro","is-visible=true")
					winset(usr,"GM.macro","is-visible=true")
					winset(usr,"GM.aath","is-visible=true")
					winset(usr,"GM.math","is-visible=true")
					winset(usr,"GM.aarch","is-visible=true")
					winset(usr,"GM.march","is-visible=true")
					winset(usr,"GM.adec","is-visible=true")
					winset(usr,"GM.mdec","is-visible=true")
					winset(usr,"GM.adung","is-visible=true")
					winset(usr,"GM.mdung","is-visible=true")
					winset(usr,"GM.aenc","is-visible=true")
					winset(usr,"GM.menc","is-visible=true")
					winset(usr,"GM.ains","is-visible=true")
					winset(usr,"GM.mins","is-visible=true")
					winset(usr,"GM.ainv","is-visible=true")
					winset(usr,"GM.minv","is-visible=true")
					winset(usr,"GM.amag","is-visible=true")
					winset(usr,"GM.mmag","is-visible=true")
					winset(usr,"GM.amagi","is-visible=true")
					winset(usr,"GM.mmagi","is-visible=true")
					winset(usr,"GM.amed","is-visible=true")
					winset(usr,"GM.mmed","is-visible=true")
					winset(usr,"GM.anat","is-visible=true")
					winset(usr,"GM.mnat","is-visible=true")
					winset(usr,"GM.aper","is-visible=true")
					winset(usr,"GM.mper","is-visible=true")
					winset(usr,"GM.apers","is-visible=true")
					winset(usr,"GM.mpers","is-visible=true")
					winset(usr,"GM.asth","is-visible=true")
					winset(usr,"GM.msth","is-visible=true")
					winset(usr,"GM.athv","is-visible=true")
					winset(usr,"GM.mthv","is-visible=true")
					winset(usr,"GM.asur","is-visible=true")
					winset(usr,"GM.msur","is-visible=true")
					winset(usr,"GM.str","text=\"STR:\"")
					winset(usr,"GM.dex","text=\"DEX:\"")
					winset(usr,"GM.con","text=\"CON:\"")
					winset(usr,"GM.int","text=\"INT:\"")
					winset(usr,"GM.wis","text=\"WIS:\"")
					winset(usr,"GM.cha","text=\"CHA:\"")
					winset(usr,"GM.ac","text=\"AC:\"")
					winset(usr,"GM.dr","text=\"DR:\"")
					winset(usr,"GM.spd","text=\"Speed:\"")
					winset(usr,"GM.rflx","text=\"Reflex:\"")
					winset(usr,"GM.fort","text=\"Fortitude:\"")
					winset(usr,"GM.will","text=\"Will:\"")
					winset(usr,"GM.acro","text=\"Acrobatics:\"")
					winset(usr,"GM.athl","text=\"/Athletics:\"")
					winset(usr,"GM.arch","text=\"Archaeology:\"")
					winset(usr,"GM.dec","text=\"Deception:\"")
					winset(usr,"GM.ins","text=\"Insight:\"")
					winset(usr,"GM.inv","text=\"Investigation:\"")
					winset(usr,"GM.magi","text=\"Magi Op.:\"")
					winset(usr,"GM.med","text=\"Medicine:\"")
					winset(usr,"GM.per","text=\"Perception:\"")
					winset(usr,"GM.sth","text=\"Stealth:\"")
					winset(usr,"GM.thv","text=\"Thievery:\"")
					winset(usr,"GM.sur","text=\"Survival:\"")
					if(!g.mcritmod==0)
						g.desc+="Crit: [g.mcritmod] "
					if(!g.mpab==0)
						g.desc+="PAB: [g.mpab] "
					if(!g.mpdb==0)
						g.desc+="PDB: [g.mpdb] "
					if(!g.mmab==0)
						g.desc+="MAB: [g.mmab] "
					if(!g.mmdb==0)
						g.desc+="MDB: [g.mmdb] "
					if(!g.mdex==0)
						g.desc+="DEX: [g.mdex] "
					if(!g.mcon==0)
						g.desc+="CON: [g.mcon] "
					if(!g.mint==0)
						g.desc+="INT: [g.mint] "
					if(!g.mwis==0)
						g.desc+="WIS: [g.mwis] "
					if(!g.mcha==0)
						g.desc+="CHA: [g.mcha] "
					if(!g.mac==0)
						g.desc+="AC: [g.mac] "
					if(!g.mdr==0)
						g.desc+="DR: [g.mdr] "
					if(!g.mspd==0)
						g.desc+="Speed: [g.mspd] "
					if(!g.mrflx==0)
						g.desc+="RFLX: [g.mrflx] "
					if(!g.mfort==0)
						g.desc+="FORT: [g.mfort] "
					if(!g.mwill==0)
						g.desc+="WILL: [g.mwill] "
					if(!g.macro==0)
						g.desc+="Acro.[g.macro] "
					if(!g.mathl==0)
						g.desc+="Athl.[g.mathl] "
					if(!g.macro==0)
						g.desc+="Arch.[g.macro] "
					if(!g.mdec==0)
						g.desc+="Dec.[g.mdec] "
					if(!g.minsi==0)
						g.desc+="Insi.[g.minsi] "
					if(!g.minv==0)
						g.desc+="Inv.[g.minv] "
					if(!g.mmagi==0)
						g.desc+="Magi.[g.mmagi] "
					if(!g.mmed==0)
						g.desc+="Med.[g.mmed] "
					if(!g.mperc==0)
						g.desc+="Per.[g.mperc] "
					if(!g.msth==0)
						g.desc+="Sth.[g.msth] "
					if(!g.mthv==0)
						g.desc+="Thv.[g.mthv] "
					if(!g.msurv==0)
						g.desc+="Surv.[g.msurv] "
					usr.makingitem=0
		EditGM()
			var/list/gms=new
			var/obj/globalmod/selection
			if(usr.makingitem)
				alert("Please finish editing your current GM")
				return
			for(var/obj/globalmod/g in usr.contents)
				gms+=g
			selection=input("Which GM do you wish to edit?") as null|anything in gms
			if(selection==null)
				return
			if(selection.applied)
				alert("Please remove this GM before editing it.")
				return
			selection.selected=1
			selection.desc=null
			winset(usr,"GM.Gname","text=\"[selection.name]\"")
			winset(usr,"GM.crit","is-visible=true")
			winset(usr,"GM.critminus","is-visible=true")
			winset(usr,"GM.critadd","is-visible=true")
			winset(usr,"GM.conf","is-visible=true")
			winset(usr,"GM.conf","is-visible=true")
			winset(usr,"GM.critminus","is-visible=true")
			winset(usr,"GM.critadd","is-visible=true")
			winset(usr,"GM.pbadd","is-visible=true")
			winset(usr,"GM.mbadd","is-visible=true")
			winset(usr,"GM.mdadd","is-visible=true")
			winset(usr,"GM.pdadd","is-visible=true")
			winset(usr,"GM.pbminus","is-visible=false")
			winset(usr,"GM.mbminus","is-visible=false")
			winset(usr,"GM.mdminus","is-visible=false")
			winset(usr,"GM.pdminus","is-visible=false")
			winset(usr,"GM.astr","is-visible=true")
			winset(usr,"GM.mstr","is-visible=true")
			winset(usr,"GM.adex","is-visible=true")
			winset(usr,"GM.mdex","is-visible=true")
			winset(usr,"GM.acon","is-visible=true")
			winset(usr,"GM.mcon","is-visible=true")
			winset(usr,"GM.aint","is-visible=true")
			winset(usr,"GM.mint","is-visible=true")
			winset(usr,"GM.awis","is-visible=true")
			winset(usr,"GM.mwis","is-visible=true")
			winset(usr,"GM.acha","is-visible=true")
			winset(usr,"GM.mcha","is-visible=true")
			winset(usr,"GM.aac","is-visible=true")
			winset(usr,"GM.mac","is-visible=true")
			winset(usr,"GM.adr","is-visible=true")
			winset(usr,"GM.mdr","is-visible=true")
			winset(usr,"GM.aspd","is-visible=true")
			winset(usr,"GM.mspd","is-visible=true")
			winset(usr,"GM.arflx","is-visible=true")
			winset(usr,"GM.mrflx","is-visible=true")
			winset(usr,"GM.afort","is-visible=true")
			winset(usr,"GM.mfort","is-visible=true")
			winset(usr,"GM.awill","is-visible=true")
			winset(usr,"GM.mwill","is-visible=true")
			winset(usr,"GM.aacro","is-visible=true")
			winset(usr,"GM.macro","is-visible=true")
			winset(usr,"GM.aath","is-visible=true")
			winset(usr,"GM.math","is-visible=true")
			winset(usr,"GM.aarch","is-visible=true")
			winset(usr,"GM.march","is-visible=true")
			winset(usr,"GM.adec","is-visible=true")
			winset(usr,"GM.mdec","is-visible=true")
			winset(usr,"GM.adung","is-visible=true")
			winset(usr,"GM.mdung","is-visible=true")
			winset(usr,"GM.aenc","is-visible=true")
			winset(usr,"GM.menc","is-visible=true")
			winset(usr,"GM.ains","is-visible=true")
			winset(usr,"GM.mins","is-visible=true")
			winset(usr,"GM.ainv","is-visible=true")
			winset(usr,"GM.minv","is-visible=true")
			winset(usr,"GM.amag","is-visible=true")
			winset(usr,"GM.mmag","is-visible=true")
			winset(usr,"GM.amagi","is-visible=true")
			winset(usr,"GM.mmagi","is-visible=true")
			winset(usr,"GM.amed","is-visible=true")
			winset(usr,"GM.mmed","is-visible=true")
			winset(usr,"GM.anat","is-visible=true")
			winset(usr,"GM.mnat","is-visible=true")
			winset(usr,"GM.aper","is-visible=true")
			winset(usr,"GM.mper","is-visible=true")
			winset(usr,"GM.apers","is-visible=true")
			winset(usr,"GM.mpers","is-visible=true")
			winset(usr,"GM.asth","is-visible=true")
			winset(usr,"GM.msth","is-visible=true")
			winset(usr,"GM.athv","is-visible=true")
			winset(usr,"GM.mthv","is-visible=true")
			winset(usr,"GM.asur","is-visible=true")
			winset(usr,"GM.msur","is-visible=true")
			winset(usr,"GM.str","text=\"STR:[selection.mstr]\"")
			winset(usr,"GM.dex","text=\"DEX:[selection.mdex]\"")
			winset(usr,"GM.con","text=\"CON:[selection.mcon]\"")
			winset(usr,"GM.int","text=\"INT:[selection.mint]\"")
			winset(usr,"GM.wis","text=\"WIS:[selection.mwis]\"")
			winset(usr,"GM.cha","text=\"CHA:[selection.mcha]\"")
			winset(usr,"GM.ac","text=\"AC:[selection.mac]\"")
			winset(usr,"GM.dr","text=\"DR:[selection.mdr]\"")
			winset(usr,"GM.spd","text=\"Speed:[selection.mspd]\"")
			winset(usr,"GM.rflx","text=\"Reflex:[selection.mrflx]\"")
			winset(usr,"GM.fort","text=\"Fortitude:[selection.mfort]\"")
			winset(usr,"GM.will","text=\"Will:[selection.mwill]\"")
			winset(usr,"GM.acro","text=\"Acrobatics:[selection.macro]\"")
			winset(usr,"GM.athl","text=\"Athletics:[selection.mathl]\"")
			winset(usr,"GM.arch","text=\"Archaeology:[selection.march]\"")
			winset(usr,"GM.dec","text=\"Deception:[selection.mdec]\"")
			winset(usr,"GM.ins","text=\"Insight:[selection.minsi]\"")
			winset(usr,"GM.inv","text=\"Investigation:[selection.minv]\"")
			winset(usr,"GM.magi","text=\"Magi Op.:[selection.mmagi]\"")
			winset(usr,"GM.med","text=\"Medicine:[selection.mmed]\"")
			winset(usr,"GM.per","text=\"Perception:[selection.mperc]\"")
			winset(usr,"GM.sth","text=\"Stealth:[selection.msth]\"")
			winset(usr,"GM.thv","text=\"Thievery:[selection.mthv]\"")
			winset(usr,"GM.sur","text=\"Survival:[selection.msurv]\"")
		Addstr()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.mstr++
					winset(usr,"GM.str","text=\"STR:[g.mstr]\"")
		Minusstr()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.mstr--
					winset(usr,"GM.str","text=\"STR:[g.mstr]\"")
		Adddex()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.mdex++
					winset(usr,"GM.dex","text=\"DEX:[g.mdex]\"")
		Minusdex()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.mdex--
					winset(usr,"GM.dex","text=\"DEX:[g.mdex]\"")
		Addcon()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.mcon++
					winset(usr,"GM.con","text=\"CON:[g.mcon]\"")
		Minuscon()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.mcon--
					winset(usr,"GM.con","text=\"CON:[g.mcon]\"")
		Addint()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.mint++
					winset(usr,"GM.int","text=\"INT:[g.mint]\"")
		Minusint()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.mint--
					winset(usr,"GM.int","text=\"INT:[g.mint]\"")
		Addwis()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.mwis++
					winset(usr,"GM.wis","text=\"WIS:[g.mwis]\"")
		Minuswis()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.mwis--
					winset(usr,"GM.wis","text=\"WIS:[g.mwis]\"")
		Addcha()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.mcha++
					winset(usr,"GM.cha","text=\"CHA:[g.mcha]\"")
		Minuscha()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.mcha--
					winset(usr,"GM.cha","text=\"CHA:[g.mcha]\"")

		Addac()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.mac++
					winset(usr,"GM.ac","text=\"AC:[g.mac]\"")
		Minusac()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.mac--
					winset(usr,"GM.ac","text=\"AC:[g.mac]\"")
		Adddr()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.mdr++
					winset(usr,"GM.dr","text=\"DR:[g.mdr]\"")
		Minusdr()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.mdr--
					winset(usr,"GM.dr","text=\"DR:[g.mdr]\"")
		Addspd()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.mspd++
					winset(usr,"GM.spd","text=\"Speed:[g.mspd]\"")
		Minusspd()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.mspd--
					winset(usr,"GM.spd","text=\"Speed:[g.mspd]\"")
		Addrflx()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.mrflx++
					winset(usr,"GM.rflx","text=\"Reflex:[g.mrflx]\"")
		Minusrflx()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.mrflx--
					winset(usr,"GM.rflx","text=\"Reflex:[g.mrflx]\"")
		Addfort()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.mfort++
					winset(usr,"GM.fort","text=\"Fortitude:[g.mfort]\"")
		Minusfort()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.mfort--
					winset(usr,"GM.fort","text=\"Fortitude:[g.mfort]\"")
		MinusPAB()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.mpab--
					winset(usr,"GM.pab","text=\"PAB: :[g.mpab]\"")
		MinusPDB()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.mpdb--
					winset(usr,"GM.pdb","text=\"PDB: :[g.mpdb]\"")
		Minuscrit()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.mcritmod--
					winset(usr,"GM.crit","text=\"Crit Bonus: :[g.mcritmod]\"")
		Addcrit()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.mcritmod++
					winset(usr,"GM.crit","text=\"Crit Bonus: :[g.mcritmod]\"")
		MinusMAB()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.mmab--
					winset(usr,"GM.mab","text=\"MAB: :[g.mmab]\"")
		MinusMDB()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.mmdb--
					winset(usr,"GM.mdb","text=\"MDB: :[g.mmdb]\"")
//
		AddPAB()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.mpab++
					winset(usr,"GM.pab","text=\"PAB: :[g.mpab]\"")
		AddPDB()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.mpdb++
					winset(usr,"GM.pdb","text=\"PDB: :[g.mpdb]\"")
		AddMAB()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.mmab++
					winset(usr,"GM.mab","text=\"MAB: :[g.mmab]\"")
		AddMDB()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.mmdb++
					winset(usr,"GM.mdb","text=\"MDB: :[g.mmdb]\"")
		Addwill()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.mwill++
					winset(usr,"GM.will","text=\"Will:[g.mwill]\"")
		Minuswill()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.mwill--
					winset(usr,"GM.will","text=\"Will:[g.mwill]\"")
		Addacro()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.macro++
					winset(usr,"GM.acro","text=\"Acrobatics:[g.macro]\"")
		Minusacro()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.macro--
					winset(usr,"GM.acro","text=\"Acrobatics:[g.macro]\"")
		Addath()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.mathl++
					winset(usr,"GM.athl","text=\"Athletics:[g.mathl]\"")
		Minusath()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.mathl--
					winset(usr,"GM.athl","text=\"Athletics:[g.mathl]\"")
		Addarch()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.march++
					winset(usr,"GM.arch","text=\"Archaeology:[g.march]\"")
		Minusarch()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.march--
					winset(usr,"GM.arch","text=\"Archaeology:[g.march]\"")
		Adddec()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.mdec++
					winset(usr,"GM.dec","text=\"Deception:[g.mdec]\"")
		Minusdec()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.mdec--
					winset(usr,"GM.dec","text=\"Deception:[g.mdec]\"")
		Adddung()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.mdung++
					winset(usr,"GM.dung","text=\"Dungeoneering:[g.mdung]\"")
		Minusdung()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.mdung--
					winset(usr,"GM.dung","text=\"Dungeoneering:[g.mdung]\"")
		Addenc()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.menc++
					winset(usr,"GM.enc","text=\"Enchantment:[g.menc]\"")
		Minusenc()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.menc--
					winset(usr,"GM.enc","text=\"Enchantment:[g.menc]\"")
		Addins()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.minsi++
					winset(usr,"GM.ins","text=\"Insight:[g.minsi]\"")
		Minusins()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.minsi--
					winset(usr,"GM.ins","text=\"Insight:[g.minsi]\"")
		Addinv()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.minv++
					winset(usr,"GM.inv","text=\"Investigation:[g.minv]\"")
		Minusinv()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.minv--
					winset(usr,"GM.inv","text=\"Investigation:[g.minv]\"")
		Addmag()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.mmag++
					winset(usr,"GM.mag","text=\"Magic.:[g.mmag]\"")
		Minusmag()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.mmag--
					winset(usr,"GM.mag","text=\"Magic.:[g.mmag]\"")
		Addmagi()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.mmagi++
					winset(usr,"GM.magi","text=\"Magi Op.:[g.mmagi]\"")
		Minusmagi()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.mmagi--
					winset(usr,"GM.magi","text=\"Magi Op.:[g.mmagi]\"")
		Addmed()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.mmed++
					winset(usr,"GM.med","text=\"Medicine:[g.mmed]\"")
		Minusmed()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.mmed--
					winset(usr,"GM.med","text=\"Medicine:[g.mmed]\"")
		Addnat()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.mnat++
					winset(usr,"GM.nat","text=\"Naturalist:[g.mnat]\"")
		Minusnat()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.mnat--
					winset(usr,"GM.nat","text=\"Naturalist:[g.mnat]\"")
		Addper()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.mperc++
					winset(usr,"GM.per","text=\"Perception:[g.mperc]\"")
		Minusper()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.mperc--
					winset(usr,"GM.per","text=\"Perception:[g.mperc]\"")
		Addpers()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.mpers++
					winset(usr,"GM.pers","text=\"Perception:[g.mpers]\"")
		Minuspers()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.mpers--
					winset(usr,"GM.pers","text=\"Perception:[g.mpers]\"")
		Addsth()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.msth++
					winset(usr,"GM.sth","text=\"Stealth:[g.msth]\"")
		Minussth()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.msth--
					winset(usr,"GM.sth","text=\"Stealth:[g.msth]\"")
		Addthv()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.mthv++
					winset(usr,"GM.thv","text=\"Thievery:[g.mthv]\"")
		Minusthv()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.mthv--
					winset(usr,"GM.thv","text=\"Thievery:[g.mthv]\"")
		Addsur()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.msurv++
					winset(usr,"GM.sur","text=\"Survival:[g.msurv]\"")
		Minussur()
			for(var/obj/globalmod/g in usr.contents)
				if(g.selected)
					g.msurv--
					winset(usr,"GM.sur","text=\"Survival:[g.msurv]\"")
