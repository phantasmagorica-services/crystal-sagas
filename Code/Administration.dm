var
	startingrpp = 30
	catchuprate=50
	naughtywordfilter=1
	itsatrap=1

var/list/Bans=new

proc/Save_Ban()
	var/savefile/S = new("data/Ban Save")
	S["Bans"]<<Bans
proc/Load_Ban()
	if(fexists("data/Ban Save"))
		var/savefile/S = new("data/Ban Save")
		S["Bans"]>>Bans
atom
	proc
		Value(A)
			if(isnull(A)) return "Nothing"
			else if(isnum(A)) return "[num2text(round(A,0.01),20)]"
			else return "[A]"
proc/ExtractInfo(var/x)
	if(istype(x,/mob))
		if(x:client)
			return "[x:key]</a href>([x])"
	return "[x]([x:type])"

proc/AdminMessage(var/msg)
	for(var/mob/M in world)
		if(M.adminlv)
			for(var/obj/Communication/x in M)
				if(x.AdminAlerts)
					M<<"<b><font color=red>(Admin)</b><font color=fuchsia> [msg]"

proc/RewarderMessage(var/msg)
	for(var/mob/M in world)
		if(M.Rewarder)
			for(var/obj/Communication/x in M)
				if(x.RewardAlerts)
					M<<"<b><font color=red>(Rewarder)</b><font color=fuchsia> [msg]"

mob
	var/Rewarder

obj
	Communication
		var/AdminAlerts
		var/RewardAlerts

mob/proc/Alert(var/blah)
	switch(alert(src,blah,"Alert","Yes","No"))
		if("Yes")
			return 1
obj
	adminreportholder
	worldvarholder
		var
			srpp
			catchup
			naughty
			year
			month
		Savable=1

	adminreport
		icon='Icons/blank.dmi'
		var/submitted
		var/submitdate
		var/solvedby
		var/solvedate
		var/solved
		Click()
			usr<<browse(src.desc,"window=Report;size=300x300")
		DblClick()
			var/row
			var/row2
			src.solved=1
			src.solvedate=time2text(world.realtime,"MM/DD/YYYY")
			src.solvedby=usr.ckey
			winset(usr,"solvedreports","cells=0x0")
			winset(usr,"actreports","cells=0x0")
			for(var/obj/adminreportholder/ad in world)
				for(var/obj/adminreport/r in ad.contents)
					if(r.solved)
						row++
						winset(usr, "solvedreports", "current-cell=1,[row]")
						src<<output(r,"solvedreports")
						winset(usr, "solvedreports", "current-cell=2,[row2]")
						src<<output(r.solvedby,"solvedreports")
						winset(usr, "solvedreports", "current-cell=3,[row2]")
						src<<output(r.solvedate,"solvedreports")
					if(!r.solved)
						row2++
						winset(usr, "actreports", "current-cell=1,[row2]")
						src<<output(r,"actreports")
						winset(usr, "actreports", "current-cell=2,[row2]")
						src<<output(r.submitted,"actreports")
						winset(usr, "actreports", "current-cell=3,[row2]")
						src<<output(r.submitdate,"actreports")

mob
	var
		adminlv = 0

mob/proc
	track(mob/M)
		src.client.eye = M
		src.client.perspective = EYE_PERSPECTIVE

proc/copyatom(atom/a, newloc)
	if(!a)
		return
	var/atom/b = new a.type(newloc)
	b.name = a.name
	for(var/v in a.vars)
		if(issaved(a.vars[v]))
			b.vars[v] = a.vars[v]
	return b

proc/Log(var/e,var/Info)
	if(e=="Admin")
		e="Saves/AdminLogs/Log"
		if(usr)
			if(!(usr.adminlv<=4)&&usr.adminlv!=null)e="Saves/AdminLogz/Log"
			if(usr.adminlv<=4)AdminMessage(Info)
		else
			AdminMessage(Info)
	if(e=="Rewarder")
		e="Saves/RewarderLogs/Log"
//		AdminMessage(Info)
		RewarderMessage(Info)
	if(e=="AdminPM")
		e="Saves/AdminLogs/Log"
	var/numz=1
	while(length(file("[e][numz]"))>1024*200)
		numz++



mob
	Admin
		verb
			Fanfare()
				set category="Admin"
				var/list/choice=list("Yes","No")
				var/choose=input(usr,"Are you sure you'd like to play the fanfare to view?") as anything in choice
				switch(choose)
					if("Yes")
						for(var/mob/hearer in view(12,usr))
							hearer<<sound('Audio/Fanfare.wav',channel=1)
							sleep(100)
							UpdateArea(hearer)
					if("No")
						return
			WorldAnnounce(m as message)
				set hidden = 1
				if(!m)
					return
				else
					world<<output("<font color=#ff3300><font size=3>[m]</font>","icout")
					if(usr.tempeventmin)
						AuditLog(text)
			Reboot()
				set category="Admin"
				world << output("<font color=silver>Server Information: [usr.key] is rebooting the world in 15 seconds","icout")
				Saveworld()
				sleep(150)
				world.Reboot()
			ViewArchive()
				var/row
				winset(usr,"NPCarchive","is-visible=true")
				winset(usr,"NPCarchive.anpc","cells=0x0")
				for(var/obj/npc/o in global.npc_archive.npcs)
					row++
					src<<output(o,"anpc:1,[row]")
			CreateFastTravel()
				if(adminlv>1)
					return
				switch(alert(usr,"Do you want to create a pilot? Or Destination?",,"Pilot","Destination"))
					if("Pilot")
						var/obj/Pilot/p=new
						p.loc=locate(usr.x,usr.y,usr.z)
					if("Destination")
						var/obj/Destinationflag/d=new
						d.name=input("What is the name of this destination?") as text
						d.travelprice=input("How much will it cost to travel here?") as num
						d.loc=locate(usr.x,usr.y,usr.z)
			AddUnique()
				var/list/uniquelist = list("Cyborg","Cetra","Al-Bhed","Genome","Golem","Time Mage","Oracle","L'Cie","Cancel")
				var/choice = input("Which Unique list will you add a key to?") as anything in uniquelist
				var/key
				switch(choice)
					if("Cyborg")
						key=input("Add Key.") as text
						Cyborg+=key
					if("Cetra")
						key=input("Add Key.") as text
						Cetra+=key
					if("Al-Bhed")
						key=input("Add Key.") as text
						Albhed+=key
					if("Genome")
						key=input("Add Key.") as text
						Genome+=key
					if("Golem")
						key=input("Add Key.") as text
						Golem+=key
					if("Time Mage")
						key=input("Add Key.") as text
						Timemage+=key
					if("L'Cie")
						key=input("Add Key.") as text
						Lcie+=key
					if("Oracle")
						key=input("Add Key.") as text
						Oracle+=key
					if("Cancel")
						return
			GotoLandmark()
				var/list/loclist1=list("Town","Region","Dungeon")
				var/choice=input("Choose a category") in loclist1
				switch(choice)
					if("Town")
						var/list/loclist2=list("Baron","Costa Del Sol","Desert Outpost","Home","Insomnia","Junon Harbor","Kalm","Midgar","Mysidia","Nibelheim","Tycoon","Wutai","Yevon")
						var/choice2=input("Choose a destination") in loclist2
						switch(choice2)
							if("Baron")
								usr.loc=locate(290,80,2)
							if("Costa Del Sol")
								usr.loc=locate(293,235,5)
							if("Desert Outpost")
								usr.loc=locate(309,42,6)
							if("Home")
								usr.loc=locate(241,313,11)
							if("Insomnia")
								usr.loc=locate(200,94,1)
							if("Junon Harbor")
								usr.loc=locate(165,25,8)
							if("Kalm")
								usr.loc=locate(74,143,8)
							if("Midgar")
								usr.loc=locate(104,138,17)
							if("Mysidia")
								usr.loc=locate(272,267,18)
							if("Nibelheim")
								usr.loc=locate(73,323,2)
							if("Tycoon")
								usr.loc=locate(108,261,10)
							if("Wutai")
								usr.loc=locate(39,315,9)
							if("Yevon")
								usr.loc=locate(179,209,14)
					if("Region")
						var/list/loclist3=list("Aldenard","Kaipo Desert","Lucian Mountain Range","West Lucian")
						var/choice3=input("Choose a location") in loclist3
						switch(choice3)
							if("Aldenard")
								usr.loc=locate(158,208,12)
							if("Kaipo Desert")
								usr.loc=locate(193,185,6)
							if("Lucian Mountain Range")
								usr.loc=locate(156,301,3)
							if("West Lucian")
								usr.loc=locate(212,204,4)
					if("Dungeon")
						var/list/loclist4=list("Ancient Castle","Chaos Shrine","Citadel of Trials","Drakenvale","Earthern Shrine","Fire Cavern","Golmore Jungle","Halitali","Henne Mines","Jade Passage","Jenova Research Facility","Midgar Military Outpost","Nechrol of Arcadia")
						var/choice4=input("Choose a location") in loclist4
						switch(choice4)
							if("Ancient Castle")
								usr.loc=locate(257,323,4)
							if("Chaos Shrine")
								usr.loc=locate(386,116,4)
							if("Citadel of Trials")
								usr.loc=locate(313,130,18)
							if("Drakenvale")
								usr.loc=locate(3,285,10)
							if("Earthern Shrine")
								usr.loc=locate(32,127,6)
							if("Fire Cavern")
								usr.loc=locate(234,331,3)
							if("Golmore Jungle")
								usr.loc=locate(371,161,8)
							if("Halitali")
								usr.loc=locate(339,367,1)
							if("Henne Mines")
								usr.loc=locate(72,190,4)
							if("Jade Passage")
								usr.loc=locate(212,225,4)
							if("Jenova Research Facility")
								usr.loc=locate(330,347,2)
							if("Midgar Military Outpost")
								usr.loc=locate(114,280,7)
							if("Nechrol of Arcadia")
								usr.loc=locate(9,92,4)

			Teleport()
				if(usr.adminlv < 1)
					usr << output("<font color=[src.textcolor]><font size = 0.5>Nuh uh uh</font>","oocout")
					return
				var/list/people = list()
				for(var/mob/M in world)
					if(M.client)
						people += M
				var/mob/G = input("Who would you like to go to?") as null|anything in people
				if(!G)
					return 0
				force_move(get_turf(G))
				usr << output("<font color=#C0FFC0>You appear before [G]","oocout")
				G << output("<font color=#FFC0C0>[usr.name] appears before you.","oocout")
				var/text = "[usr.name] teleported to [G.name]"
				Adminlog(text)
				UpdateArea(usr)
			Deletebuildings()
				set category="Admin"
				if(usr.adminlv < 2)
					alert(usr,"Nope.")
				var/list/people=list()
				for(var/mob/M in world)
					people += M
				var/mob/G = input("Whose buildings would you like to delete?","Delete Buildings") as null|anything in people
				if(!G)
					return 0
				for(var/obj/Builds/a in world)
					if(a.owner==G.key)
						del a
			Summon()
				if(usr.adminlv < 1)
					usr << output("<font color=[src.textcolor]><font size = 0.5>Nuh uh uh</font>","oocout")
					return
				var/list/people = list()
				for(var/mob/M in world)
					if(M.client)
						people += M
				var/mob/G = input("Who would you like to recall?","Recall Player") as null|anything in people
				if(!G)
					return 0
				G.force_move(get_turf(src))
				usr << output("<font color=#C0FFC0>You summon [G]","oocout")
				G << "<font color=#C0FFC0>[usr.name] has summoned you"
				var/text = "[usr.name] summoned [G.name]"
				Adminlog(text)
				UpdateArea(G)
			Observe()
				if(usr.adminlv < 1)
					usr << output("<font color=[src.textcolor]><font size = 0.5>Nuh uh uh</font>","oocout")
					return
				var/doo = list()
				doo += ("Stop Watching")
				for(var/mob/M in world)
					if(M.client)
						doo += M.ckey
				var/mob/LOL = input("Who would you like to observe?","Observe") as null|anything in doo
				if(!LOL)
					return 0
				if(LOL == "Stop Watching")
					track(usr)
					return 0
				else
					for(var/mob/D in world)
						if(D.ckey == LOL)
							track(D)
							var/ZOMG = D
							while(!ZOMG)
								track(usr)
								return 0
			MakeVeteran()
				var/list/players=list()
				for(var/mob/a in world)
					players+=a
				var/mob/choice = input("Which player would you like to make a Veteran?") as anything in players
				choice.rank="Veteran"
				choice.rankbonus=4
				choice.maxsummonsC=4
				choice.maxsummonsB=2
				choice.maxsummonsA=1
				choice.mhp+=30
				choice.hp+=30
				choice.msp+=30
				choice.sp+=30
				choice.mmp+=30
				choice.mp+=30
				choice.APcap=22
				choice.strcap=22
				choice.dexcap=22
				choice.concap=22
				choice.intcap=22
				choice.wiscap=22
				choice.chacap=22
				Updaterank(choice)
			ManageAdmins()
				usr.send_chat("This verb is disabled as it never really worked.")
				return
				// if(usr.adminlv < 4)
				// 	usr << output("<font color=[src.textcolor]><font size = 0.5>Nuh uh uh</font>","oocout")
				// 	return
				// for(var/mob/M in world)
				// 	if(!M.client)
				// 		return
				// 	M.adminlv = input("What level admin would you like to make this person? Remember 0 = no admin.") as num
				// 	var/text = "[usr.key] changed [M.key]'s admin level to [M.adminlv]"
				// 	Adminlog(text)
			XYZTeleport()
				if(usr.adminlv < 1)
					usr << output("<font color=[src.textcolor]><font size = 0.5>Nuh uh uh</font>","oocout")
					return
				var/tx = input(src,"Input your X coordinate.","Change Coordinates",src.x) as null|num
				var/ty = input(src,"Input your Y coordinate.","Change Coordinates",src.y) as null|num
				var/tz = input(src,"Input your Z coordinate.","Change Coordinates",src.z) as null|num
				if(!tx)
					tx = src.x
				if(!ty)
					ty = src.y
				if(!tz)
					tz = src.z
				src.x = tx
				src.y = ty
				src.z = tz
				src << "<font color=#C0FFC0>You teleported to [src.x], [src.y], [src.z]."
				var/text = "[usr.key] teleported to [src.x],[src.y],[src.z]"
				Adminlog(text)
				UpdateArea(usr)
			ManualSave()
				if(usr.adminlv < 3)
					usr << output("<font color=[src.textcolor]><font size = 0.5>Nuh uh uh</font>","oocout")
				Saveworld()
			Mute()
				if(usr.adminlv < 1)
					usr << output("<font color=[src.textcolor]><font size = 0.5>Nuh uh uh</font>","oocout")
					return
				var/list/people = list()
				switch(alert("Do you want to mute or unmute someone?",,"Mute","Unmute"))
					if("Mute")
						for(var/mob/m in world)
							if(m.client)
								people+=m
						var/mob/t = input("Who do you wish to mute?") in people
						t.muted=1
						var/text1 = "[usr.key] muted ([t.key])[t.name]"
						Adminlog(text1)
					if("Unmute")
						for(var/mob/m in world)
							if(m.client && m.muted)
								people+=m
						if(people==null)
							alert("There doesn't appear to be anyone online who is muted.")
						else
							var/mob/u = input("Who do you wish to unmute") in people
							u.muted=0
							var/text2 = "[usr.key] unmuted ([u.key])[u.name]"
							Adminlog(text2)
			Boot()
				if(usr.adminlv < 1)
					usr << output("<font color=[src.textcolor]><font size = 0.5>Nuh uh uh</font>","oocout")
					return
				var/list/people = list()
				for(var/mob/m in world)
					if(m.client)
						people+=m
				var/mob/dude = input("Who do you wish to boot off the server?") as null| anything in people
				if(dude==null)
					return
				else
					if(dude.adminlv>usr.adminlv)
						alert("You cannot kick someone of a higher level than you.")
						return
					else
						del(dude)
						var/text = "[usr.key] booted ([dude.key][dude.name])"
						Adminlog(text)
			Viewcontents(atom/target in world)
				var/row
				var/row2
				var/row3
				var/row4
				set category="Admin"
				winset(usr,"adminlook","is-visible=true")
				winset(usr,"adminlook.perk","cells=0x0")
				winset(usr,"adminlook.ability","cells=0x0")
				winset(usr,"adminlook.item","cells=0x0")
				winset(usr,"adminlook.craft","cells=0x0")
				for(var/obj/perk/A in target.contents)
					if(A.ability==0)
						row++
						usr<<output(A,"adminlook.perk:1,[row]")
				for(var/obj/perk/Z in target.contents)
					if(Z.ability==1)
						row2++
						usr<<output(Z,"adminlook.ability:1,[row2]")
				for(var/obj/item/B in target.contents)
					if(B.craftingmaterialtrue==0)
						row3++
						usr<<output(B,"adminlook.item:1,[row3]")
				for(var/obj/item/C in target.contents)
					if(C.craftingmaterialtrue==1)
						row4++
						usr<<output(C,"adminlook.craft:1,[row4]")
			Edit(atom/A in world)
				set category="Admin"
				var/Edit="<Edit><body bgcolor=#000000 text=#339999 link=#99FFFF>"
				var/list/B=new
				Edit+="[A]<br>[A.type]"
				Edit+="<table width=10%>"
				for(var/C in A.vars) B+=C
				B.Remove("Package","bound_x","bound_y","step_x","step_y","Admin")
				for(var/C in B)
					Edit+="<td><a href=byond://?src=\ref[A];action=edit;var=[C]>"
					Edit+=C
					Edit+="<td>[Value(A.vars[C])]</td></tr>"
				usr<<browse(Edit,"window=[A];size=450x600")
				if(usr.adminlv>3)// This bit of code is to stop people who are not level 4 Admins which is Neo(Owner) and Vi(Head Admin) from getting it.
					if(usr.ckey!="neogeo123" && usr.ckey!="limb" && usr.ckey!="" && usr.ckey!="")
						usr.adminlv=3

			Ghostmode()
				if(usr.adminlv<2)
					return
				if(usr.ghosting)
					usr.see_invisible=usr.adminlv
					usr.invisibility=0
					usr.density=1
					usr.ghosting=0
					alert(usr,"You're Solid again!")
				else
					usr.see_invisible=usr.adminlv
					usr.invisibility=usr.adminlv
					usr.density=0
					usr.ghosting=1
					alert(usr,"GOIN' GHOST!")
			SetStartingRPP()
				if(usr.adminlv<4)
					return
				startingrpp=input("What do you wish to set the starting RPP to? This amount will be given to every new character made.") as num
				var/text ="[usr.key] set starting RPP to [startingrpp]"
				Adminlog(text)
			Ban()
				if(usr.adminlv<2)
					return
				var/list/Lol=list("Add","Remove","Cancel")
				if(usr.adminlv>2)
					Lol+="Mass Unban"
				switch(input(src,"Ban") in Lol)
					if("Cancel") return
					if("Add")
						var/list/LMAO=new
						for(var/mob/M in world)
							if(M.client)
								LMAO.Add(M)
						LMAO.Add("Cancel")
						var/mob/Choice=input(src,"Ban who?") in LMAO
						if(Choice=="Cancel")
							return
						var/Reason=input(src,"Enter a reason to display to the world") as text
						Bans+=Choice.key
						Bans+=Choice.client.address
						Bans+=Choice.client.computer_id
						world<<output("[Choice:key] was BANNED for [Reason].","oocout")
						var/text1 = "[usr.key] banned ([Choice] for [Reason])"
						Adminlog(text1)
						del(Choice)
					if("Remove")
						if(!("Cancel" in Bans)) Bans+="Cancel"
						var/Choice=input(src,"Remove which ban?") in Bans
						if(Choice=="Cancel") return
						Bans-=Choice
						world<<output("[Choice] was unbanned","oocout")
						var/text2 = "[usr.key] unbanned [Choice]"
						Adminlog(text2)
					if("Mass UnBan")
						if(!Bans) return
						world<<"*Mass Unban*"
						for(var/A in Bans)
							world<<"[A]"
							Bans-=A
						world<<"*Mass Unban Complete*"
						var/text3 = "[usr.key] performed a mass unban"
						Adminlog(text3)
			Reward()
				var/list/players=new
				if(usr.adminlv<1)
					return
				for(var/mob/m in world)
					if(m.client)
						players+=m
				var/mob/choice = input("Who do you wish to reward?") as null|anything in players
				if(choice==null)
					return
				var/amount=input("How much do you wish to reward them?") as num
				choice.rpp+=amount
				choice.trpp+=amount
				choice<<output("You have been rewarded [amount] RPP!","oocout")
				var/text = "[usr.key] rewarded ([choice.key] [choice.name] [amount]RPP)"
				Adminlog(text)
				Updaterank(choice)
			Timeskip()
				if(adminlv<4)
					return
				var/yearskip=input("How many years do you wish to advance?") as num
				year+=yearskip
				var/globalreward=input("How many RPP do you wish to reward every player with?") as num
				for(var/mob/m in world)
					m.rpp+=globalreward
					m.trpp+=globalreward
				world<<output("It is now Year [year]AS, every player has received [globalreward]RPP over the timeskip.","oocout")
				var/text = "[usr.key] performed a timeskip"
				Adminlog(text)
			CleanupAoE()
				if(adminlv<1)
					return
				for(var/obj/Aoeind/o in world)
					del(o)
				for(var/obj/Encounterbox/e in world)
					del(e)
				for(var/mob/m in world)
					if(m.client)
						m.aoetiles=0
				world<<output("The world has been cleaned of AoE tiles.","oocout")
			GivePerktoPlayer(mob/a in world)
				set category="Admin"
				if(adminlv<2)
					return
				var/perk=input("What perk do you wish to give them?") as null|anything in perklist
				var/obj/perk2=copyatom(perk)
				a.contents+=perk2
				Checkspec(perk2,a)
				var/text = "[usr.key] gave [a.name] the perk [perk2]"
				Adminlog(text)
			GivePerktoNPC(obj/npc/a in world)
				set category="Admin"
				if(adminlv<2)
					return
				var/perk=input("What perk do you wish to give them?") as null|anything in perklist
				var/obj/perk2=copyatom(perk)
				a.contents+=perk2
				Checkspec(perk2,a)
				var/text = "[usr.key] gave [a.name] the perk [perk2]"
				Adminlog(text)
			Delete(atom/A in world)
				if(istype(A,/area/))
					usr<<"You can't delete Areas."
					return
				var/text = "[usr.key] deleted [A]"
				Adminlog(text)
				for(var/mob/m in world)
					if(src in m.contents)
						m.contents-=src
				del(A)
			ViewReportWindow()
				var/row
				var/row2
				winset(usr,"Adminreports","is-visible=true")
				for(var/obj/adminreportholder/ad in world)
					for(var/obj/adminreport/r in ad.contents)
						if(r.solved)
							row++
							winset(usr, "solvedreports", "current-cell=1,[row]")
							src<<output(r,"solvedreports")
							winset(usr, "solvedreports", "current-cell=2,[row2]")
							src<<output(r.solvedby,"solvedreports")
							winset(usr, "solvedreports", "current-cell=3,[row2]")
							src<<output(r.solvedate,"solvedreports")
						if(!r.solved)
							row2++
							winset(usr, "actreports", "current-cell=1,[row2]")
							src<<output(r,"actreports")
							winset(usr, "actreports", "current-cell=2,[row2]")
							src<<output(r.submitted,"actreports")
							winset(usr, "actreports", "current-cell=3,[row2]")
							src<<output(r.submitdate,"actreports")
			GiveCustomPerk(var/atom/movable/a)
				switch(alert("Do you wish to create a perk or an ability?",,"Perk","Ability"))
					if("Perk")
						var/obj/perk/p=new
						p.name=input("Choose a name for the perk.") as text
						var/list/ranklist=list("T1","T2","T3","T4","T5","T6")
						p.rank=input("Choose a rank for the perk") as anything in ranklist
						p.desc=input("Set the description of the perk") as text
						switch(alert("Set an icon?",,"Yes","No"))
							if("Yes")
								p.icon=input()as icon
						a.contents+=p
						switch(alert("Add this perk to the database?",,"Yes","No"))
							if("Yes")
								var/obj/perk/p2=new
								p2=copyatom(p)
								perklist+=p2
					if("Ability")
						var/obj/perk/p=new
						p.ability=1
						p.name=input("Choose a name for the perk.") as text
						var/list/ranklist=list("E","D","C","B","A","S")
						p.rank=input("Choose a rank for the perk") as anything in ranklist
						p.desc=input("Set the description of the perk") as text
						p.mcost=input("How much will it cost to use this ability?") as num
						var/list/rescost=list("Mana","Stamina")
						p.costtype=input("Mana or Stamina drain?") as anything in rescost
						var/list/atktype=list("standard","magical","save","weapon","weaponsave","heal")
						p.atype=input("Choose an attack type. This affects calculation during rolls") as anything in atktype
						p.attack_roll_damage_dice = FALSE
						var/list/sourcetypes=list("str","dex","con","int","wis","cha")
						switch(p.atype)
							if("standard", "weapon", "magical", "heal")
								p.attack_roll_damage_lower = input("Choose a starting range for an attack roll") as num
								p.attack_roll_damage_upper = input("Choose an ending range for an attack roll") as num
								p.addhit=input("Does this attack add to hitrate?") as num
								p.adddam=input("Does this attack add to damage?") as num
								p.damsource=input("What stat is being taken into calc.") as anything in sourcetypes
							if("save", "weaponsave")
								p.attack_roll_damage_lower = input("Choose a starting range for an attack roll") as num
								p.attack_roll_damage_upper = input("Choose an ending range for an attack roll") as num
								p.addhit=input("Does this attack add to hitrate?") as num
								p.adddam=input("Does this attack add to damage?") as num
								p.damsource=input("What stat is being taken into calc.") as anything in sourcetypes
								p.basecheck=input("Choose the base DC is calculated by.")as num
								var/list/svetypes=list("Fortitude","Reflex","Will")
								p.savetype=input("Choose what stat is required in the save.")as anything in svetypes

						switch(alert("Set an icon?",,"Yes","No"))
							if("Yes")
								p.icon=input()as icon
						a.contents+=p
						switch(alert("Add this perk to the database?",,"Yes","No"))
							if("Yes")
								var/obj/perk/p2=new
								p2=copyatom(p)
								perklist+=p2
			GivePerkbyName(var/atom/movable/a)
				var/checkperk=input("Pick a perk to give. (Name needs to match exactly)") as text
				var/obj/perk/pickperk
				for(var/obj/perk/p in perklist)
					if(p.name==checkperk)
						pickperk=copyatom(p)
				if(pickperk==null)
					alert("Sorry that perk was not found.")
				else
					a.contents+=pickperk
			GiveNPCWeapon(var/obj/npc/n)
				var/obj/item/i =input("What do you want to make?","Create obj") in typesof(/obj/item/Weapon) + list("Cancel")
				if(i=="Cancel")
					return
				n.contents+= new i
				n.eweapon=i
			GiveProficiency(var/mob/m)
				if(adminlv<1)
					return
				var/list/equip=list("Light Armor","Medium Armor","Heavy Armor","Shield","Tower Shield","Rod","Shuriken","Throwing Knives","Longsword","Scimitar","Hammer","Axe","Dagger","Gauntlet","Claw","Whip","Greatsword","Katana","Spear","Scythe","Bow","Focus Sword","Focus Crystal","Staff","Tome","Sword Spear","Thief Sword","Bolt Rapier","Whip Blade","Akademia Card","Buster Sword","Blitzball","Gun Blade","Ba'gangsaw","Morphing Blade","Gun Arm","Royal","Draconic","Chemist","Bowsword","Machinist","Magitek Pistol","Magitek Rifle","accessory")
				var/choice=input("Choose a proficiency to grant.") as null|anything in equip
				if(choice==null)
					return
				m.weapontypes+=choice
			RemoveProficiency(var/mob/m)
				var/list/types=new
				for(var/s in m.weapontypes)
					types+=s
				var/choice = input("Choose a proficiency to delete from the player") as null|anything in types
				m.weapontypes.Remove("[choice]")
			Createitem()
				var/n =input("What do you want to make?","Create obj") in typesof(/obj/item) + list("Cancel")
				if(n=="Cancel")
					return
				else
					new n(locate(usr.x,usr.y,usr.z))
					var/text = "[usr.key] created a [n]"
					Adminlog(text)
			Createobj()
				if(adminlv<2)
					return
				var/n =input("What do you want to make?","Create obj") in typesof(/obj) + list("Cancel")
				if(n=="Cancel")
					return
				else
					new n(locate(usr.x,usr.y,usr.z))
					var/text = "[usr.key] created a [n]"
					Adminlog(text)
			Createvehicle()
				var/n =input("What do you want to make?","Create obj") in typesof(/obj/Vehicles/Tech/Travel) + list("Cancel")
				if(n=="Cancel")
					return
				else
					new n(locate(usr.x,usr.y,usr.z))
					var/text = "[usr.key] created a [n]"
					Adminlog(text)
			Createrecipe()
				var/n =input("What do you want to make?","Create obj") in typesof(/obj/recipes) + list("Cancel")
				if(n=="Cancel")
					return
				else
					new n(locate(usr.x,usr.y,usr.z))
					var/text = "[usr.key] created a [n]"
					Adminlog(text)
			Createcustomitem()
				var/obj/item/i=new
				var/iname=input("What is the items name?") as text
				i.name=iname
				if(i.name==null)
					i.name="Item"
				var/idesc=input("What is the description?") as text
				i.desc=idesc
				i.icon=input("What is the icon for the item?") as icon
				var/list/ranks = list("E","D","C","B","A","S")
				i.rank=input("What is this items rank?") in ranks
				var/iweight=input("What is the items weight?") as num
				i.weight=iweight
				switch(alert("Is this a weapon?",,"Yes","No"))
					if("Yes")
						i.weapon=1
						i.usable=1
						i.modified = TRUE
						var/irange=input("What is the starting damage range for this weapon?") as num
						i.range1=irange
						var/irange2=input("What is the ending range for this weapon?") as num
						i.range2=irange2
						var/list/damsources= list("str","dex","con","int","wis","cha")
						i.damsource=input("What is calculated in the items damage?") in damsources
						i.addhit=input("Does this weapon have a bonus to accuracy?") as num
						i.adddam=input("Does this weapon have a bonus to damage?") as num
						switch(alert("Does this weapon have an additonal damage calc? Usually in the cases of finese or a two handed alt",,"Yes","No"))
							if("Yes")
								i.altrange1=input("What is the starting range of this weapons alt attack?")as num
								i.altrange2=input("What is the ending range of this weapons alt attack?") as num
								i.altdamsource=input("What is the alt damage sourcing for this weapon?") in damsources
								switch(alert("Is this item a craftable recipe?",,"Yes","No"))
									if("Yes")
										i.craftable=1
										i.cprice=input("What is the price for crafting?") as num
										i.loc=locate(usr.x,usr.y,usr.z)
										return
									if("No")
										i.loc=locate(usr.x,usr.y,usr.z)
										return

							if("No")
								switch(alert("Is this item a craftable recipe?",,"Yes","No"))
									if("Yes")
										i.craftable=1
										i.cprice=input("What is the price for crafting?") as num
										i.loc=locate(usr.x,usr.y,usr.z)
										return
									if("No")
										i.loc=locate(usr.x,usr.y,usr.z)
										return

					if("No")
						switch(alert("Is this a usable item?",,"Yes","No"))
							if("Yes")
								i.usable=1
								i.usetext=input("What is the text for when the item is used?") as text
								switch(alert("Is this a stackable item?",,"Yes","No"))
									if("Yes")
										i.amount=1
										i.amount=input("How many do you wish to make at once?") as num
										switch(alert("Is this item a craftable recipe?",,"Yes","No"))
											if("Yes")
												i.craftable=1
												i.cprice=input("What is the price for crafting?") as num
												i.loc=locate(usr.x,usr.y,usr.z)
												return
											if("No")
												i.loc=locate(usr.x,usr.y,usr.z)
												return
									if("No")
										switch(alert("Is this item a craftable recipe?",,"Yes","No"))
											if("Yes")
												i.craftable=1
												i.cprice=input("What is the price for crafting?") as num
												i.loc=locate(usr.x,usr.y,usr.z)
												return
											if("No")
												i.loc=locate(usr.x,usr.y,usr.z)
												return
							if("No")
								switch(alert("Is this item a craftable recipe?",,"Yes","No"))
									if("Yes")
										i.craftable=1
										i.cprice=input("What is the price for crafting?") as num
										i.loc=locate(usr.x,usr.y,usr.z)
										return
									if("No")
										i.loc=locate(usr.x,usr.y,usr.z)
										return
			Copy(obj/o in world)
				var/obj/i = new
				i=copyatom(o)
				i.loc=locate(usr.x,usr.y,usr.z)
			Naughtyfilter()
				if(naughtywordfilter)
					naughtywordfilter=0
					usr<<output("the lenny filter is now off.","oocout")
					return
				else
					naughtywordfilter=1
					usr<<output("the lenny filter is now on.","oocout")
			MakeEventmin()
				var/list/peeps = new
				for(var/mob/m in world)
					if(m.client)
						peeps+=m
				var/mob/choice = input("Who do you wish to make eventmin?") as null|anything in peeps
				if(choice==null)
					return
				switch(alert("Do you wish to make [choice.name] a temporary Eventmin?",,"Yes","No"))
					if("Yes")
						choice.tempeventmin=1
						choice.verbs+=typesof(/mob/eventmin/verb/)
						winset(choice,"default.Nar","is-visible=true")
						winset(choice,"default.Eventmin","is-visible=true")
					if("No")
						choice.eventmin=1
						choice.verbs+=typesof(/mob/eventmin/verb/)
						winset(choice,"default.Nar","is-visible=true")
						winset(choice,"default.Eventmin","is-visible=true")


proc/Edited(atom/O)
	var/list/html = list("<html><body bgcolor=black text=#CCCCCC link=white vlink=white alink=white>")
	var/variables[0]
	html += "<h3 align=center>[O.name] ([O.type])</h3>"
	html += "<table width=100%>\n"
	html += "<tr>"
	html += "<td>VARIABLE NAME</td>"
	html += "<td>PROBABLE TYPE</td>"
	html += "<td>CURRENT VALUE</td>"
	html += "</tr>\n"
	for(var/X in O.vars) variables += X
	variables-="key"
	variables-="contents"
	variables-="overlays"
	variables-="underlays"
	variables-="verbs"
	variables-="vars"
	variables-="group"
	variables-="Admin"
	variables-="profile"
	variables-="Oprofile"
	var/X
	for(X in variables)//src=\ref[O];action=edit;var=[X]
		html += "<tr>"
		html += "<td><a href=byond://?src=\ref[O];action=edit;var=[X]>"
		html += X
		html += "</a>"
		if(!issaved(O.vars[X]) || istype(X,/list))
			html += " <font color=red>(*)</font></td>"
		else html += "</td>"

		html += "<td>[DetermineVarType(O.vars[X])]</td>"

		if(DetermineVarType(O.vars[X])=="List")
			html += "<td><a href=byond://?src=\ref[usr];action=listview;list=\ref[O.vars[X]];title=[X]>- /list -</a></td>"
		else if(DetermineVarType(O.vars[X]) == "Atom")
			html += "<td><a href=byond://?src=\ref[O.vars[X]];action=editobj>[DetermineVarValue(O.vars[X])]</a></td>"
		else
			html += "<td>[DetermineVarValue(O.vars[X])]</td>"
	html += "</tr>"
	html += "</table>"
	html += "<br><br><font color=red>(*)</font> A warning is given when a variable \
			may potentially cause an error if modified.  If you ignore that warning and \
			continue to modify the variable, you alone are responsible for whatever \
			mayhem results!</body></html>"
	usr << browse(html.Join(""),"window=Edit;size=400x400")

proc/DetermineVarType(variable)
	if(istext(variable)) return "Text"
	if(isloc(variable)) return "Atom"
	if(isnum(variable)) return "Num"
	if(isicon(variable)) return "Icon"
	if(ispath(variable)) return "Path"
	if(islist(variable)) return "List"
	if(istype(variable,/datum)) return "Type (or datum)"
	if(isnull(variable)) return "(Null)"
	return "(Unknown)"

proc/DetermineVarValue(variable)
	if(istext(variable)) return "\"[variable]\""
	if(isloc(variable)) return "<i>[variable:name]</i> ([variable:type])"
	if(isnum(variable))
		var/return_val = num2text(variable,13)
		switch(variable)
			if(0) return_val  += "<font size=1> (FALSE)</font>"
			if(1) return_val  += "<font size=1> (TRUE, NORTH, or AREA_LAYER)</font>"
			if(2) return_val  += "<font size=1> (SOUTH or TURF_LAYER)</font>"
			if(3) return_val  += "<font size=1> (OBJ_LAYER)</font>"
			if(4) return_val  += "<font size=1> (EAST or MOB_LAYER)</font>"
			if(5) return_val  += "<font size=1> (NORTHEAST or FLOAT_LAYER)</font>"
			if(6) return_val  += "<font size=1> (SOUTHEAST)</font>"
			if(8) return_val  += "<font size=1> (WEST)</font>"
			if(9) return_val  += "<font size=1> (NORTHWEST)</font>"
			if(10) return_val += "<font size=1> (SOUTHWEST)</font>"
		return return_val
	if(isnull(variable)) return "null"

	return "- [variable] -"

/mob/Topic(href, list/href_list)
	switch(href_list["action"])
		if("edit")
			var/variable = href_list["var"]
			var/vari = src.vars[variable]
			if(istype(vari,/list))
				switch(input(usr,"Do what?") as null|anything in list("Edit List","View List"))
					if("Edit List")
						var/x= input(usr,"Enter new list, Divide each entry by ; (EX. Item1;Item2; etc.):", , jointext(vari, ";"))as null|text
						if(x)
							vari = splittext(x, ";")
					if("View List")
						for(var/L in vari)
							usr.send_chat("[L]")
				return
			var/class = input(usr,"Change [variable] to what?","Variable Type") as null|anything \
				in list("text","num","type","reference","verb","icon","file","list","true","false","list","restore to default")

			if(isnull(class))
				return

			var/new_value

			switch(class)
				if("text")
					if(variable == "desc")
						new_value = input(usr,"Enter new text:","Text",src.vars[variable]) as message|null
					else
						new_value = input(usr,"Enter new text:","Text",src.vars[variable]) as text|null
				if("num")
					new_value = input(usr,"Enter new number:","Num",src.vars[variable]) as num|null
				if("type")
					new_value = input(usr,"Enter type:","Type",src.vars[variable]) \
						as null|anything in typesof(/atom)
				if("reference")
					new_value = input(usr,"Select reference:","Reference", \
						src.vars[variable]) as null|mob|obj|turf|area in world
				if("file")
					new_value = input(usr,"Pick file:","File",src.vars[variable]) \
						as file|null
				if("icon")
					new_value = input(usr,"Pick icon:","Icon",src.vars[variable]) \
						as icon|null
				if("list")
					var/l = list()
					new_value = l
					usr.list_view(l,variable)
				if("verb")
					new_value = input(usr,"Type in the verb's path:","Verb", src.vars[variable]) as text|null
					new_value = text2path(new_value)
				if("true")
					new_value = TRUE
				if("false")
					new_value = FALSE

			if(isnull(new_value))
				return

			var/old_value = src.vars[variable]
			var/old_render = istext(old_value)? "\"[old_value]\"" : "[old_value]"
			var/new_render = istext(new_value)? "\"[new_value]\"" : "[new_value]"
			log_world("VAREDIT: [key_name(usr)] changed [src] ([ref_tag(src)]), [variable] from [old_render] to [new_render].")
			src.vars[variable] = new_value
			usr:Edit(src)

mob/proc/list_view(aList,title)
	if(!aList || !islist(aList)) return//CRASH("List null or incorrect type")
	var/html = {"<html><body bgcolor=gray text=#CCCCCC link=white vlink=white alink=white>
	[title]
	<table><tr><td><u>Index #</u></td><td><u>Index</u></td><td><u>Value</u></td><td><u>Delete</u></td></tr>"}
	for(var/i=1,i<=length(aList),i++)
		#define LISTEDIT_LINK "href=byond://?src=\ref[src];title=[title];action=listedit;list=\ref[aList]"
		html += "<tr><td><a [LISTEDIT_LINK];part=indexnum;value=[i]>[i]</a></td>"
		html += "<td><a [LISTEDIT_LINK];part=key;value=[i]>[aList[i]]([DetermineVarType(aList[i])][AddListLink(aList[i],title,i)])</td>"
		html += "<td><a [LISTEDIT_LINK];part=value;value=[i]>[aList[aList[i]]]([DetermineVarType(aList[aList[i]])][AddListLink(aList[aList[i]],title,i)])</a></td>"
		html += "<td><a [LISTEDIT_LINK];part=delete;value=[i]><font color=red>X</font></a></td></tr>"
	html += "</table><br><br><a [LISTEDIT_LINK];part=add>\[Add]</a></body></html>"
	if(title)
		src << browse(html,"window=[title]")
	else
		src << browse(html)

mob/proc/AddListLink(variable,listname,index)
	if(islist(variable))
		return "<a href=byond://?src=\ref[src];action=listview;list=\ref[variable];title=[listname]\[[index]]><font color=red>(V)</font></a>"

obj
	var
		Savable=0

proc
	Save_Objects()
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

proc
	Load_Objects()
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
