obj
	FATEs
		/// loot pack path
		var/loot_pack
		var
			locationarea
			FATEID
			FATEtype
			FATErank
			FATEnode
			Reward1
			Reward2
			Reward3
			tmp/bossfate //This determines whether or not the Fate is a World Boss or not, to give World Boss fate rewards.
			Gilreward
			Target
			CoordX
			CoordY
			CoordZ
		Del()
			for(var/obj/FATECrystal/crystal in fate_crystals)
				if(crystal.FATEID == FATEID)
					crystal.occupied = FALSE
					crystal.icon_state = "inactive"
					crystal.FATEID = null
			return ..()
		SlayerFATE
			FATEtype="Slayer"
		CaptureFATE
			FATEtype="Capture"
		ArtifactFATE
			FATEtype="Artifact"
		DeliveryFATE
			FATEtype="Delivery"

obj
	Artifact
obj
	Deliveryitem

obj
	FateReseter
		name="FATES Mission Cooldown Manager"
		icon='Icons/Cooldownreseter.png'
		density=1
	FATEGiver
		name="FATES Mission Manager"
		icon='Icons/Missiongiver.png'
		desc="An individual who is capable of assigning FATE missions to a Party."
		density=1
		DblClick()
			if(usr.usingfate==1)
				return
			if(usr.inparty==0)
				alert(usr,"You can only take on FATEs in a party.")
				usr.usingfate=0
				return
			else
				usr.usingfate=1
				for(var/obj/Partyholder/pholder in world)
					for(var/obj/Party/part in pholder.contents)
						if("[part.leader]"!="[usr.name]")
							alert(usr,"Only the party leader can generate a FATE.")//This message currently always appears even if you are the party leader, for some reason. Until that is fixed we should keep the break line.
							usr.usingfate=0
							break //Replace this with 'return' instead of 'break' once this doesn't always get called.
				for(var/obj/Party/p in world)
					if("[p.leader]"=="[usr.name]")
						for(var/mob/checkmem in world)
							if("[p.partyID]"=="[checkmem.partyID]")
								if(checkmem.FATEcooldown>=1)
									alert(usr,"[checkmem.name] is on FATE cooldown, and thus the party cannot accept a FATE!")
									usr.usingfate=0
									return
						if(p.FATEcooldown==1)
							alert(usr,"Your party is on FATE cooldown!")
							usr.usingfate=0
							return
						if("[p.partyID]"=="[usr.partyID]")
							if(p.currentFATE!=null)
								alert(usr,"Your party is already on a FATE mission!")
								usr.usingfate=0
								return
						else
							usr.usingfate=0
						if("[p.partyID]"=="[usr.partyID]")
							var/list/yesno = list("Yes","No")
							var/yeschoice=input("Would you like to take a FATE quest for your party?") as anything in yesno
							switch(yeschoice)
								if("Yes")
									if(p.currentFATE!=null)return
									p.currentFATE=1 //Sanity checks. Stops you from clicking yes repeatedly and stacking FATES
									var/obj/FATEs/newfate=new
									var/obj/npc/fightmob=new
									var/obj/Artifact/artifact=new
									var/obj/Client/client=new
									// var/list/ftype=list("Slayer","Artifact","Delivery","World Boss")
									//! disabled rest pending rework
									var/list/ftype=list("Artifact")
									var/list/frank=list("D","C","B","A")
									var/tchoice=input("Which type of FATE would you like to take?") as anything in ftype
									if(tchoice=="World Boss")
										frank-="D"
										frank-="C"
										frank-="B"
									if(tchoice=="Artifact")
										frank-="A"
										frank-="B"
										frank-="D"
									if(tchoice=="Delivery")
										frank-="A"
										frank-="B"
										frank-="D"
									var/trank=input("Which rank of FATE would you like?") as anything in frank
									newfate.FATEtype=tchoice
									newfate.FATErank=trank
									var/obj/npc/target
									var/mtype
									var/typeage
									var/list/slaylist=new
									var/list/slayerrewardsD=list("Wool","Leather","Bronze Ingot","iron Ingot","Flying Eye's Wing","Flying Eye's Eye")
									var/list/slayerrewardsC=list("Wool","Leather","Bronze Ingot","iron Ingot","steel Ingot","Flying Eye's Wing","Flying Eye's Eye","Bomb Core","Sahaugin Scale")
									var/list/slayerrewardsB=list("Mythril Ingot","Silver Ingot","Esper Soul","Gigantoad Slime","Tonberry Knife","Coeurl Whisker")
									var/list/deliveryrewards=list("Stone","Wood","Bronze Ingot","iron Ingot","Raw Mako","Wool","Leather")
									var/list/bossrewards=list("Mythril Ingot","Adamantine Ingot","Raw Mako","Esper Soul","Silver Ingot","Gold Ingot")
									switch(tchoice)
										if("Slayer")
											mtype="Slayer"
											newfate.icon='Icons/Slayerfate.png'
											typeage="Slay"
										if("World Boss")
											mtype="World Boss"
											newfate.icon='Icons/Bossfate.png'
											typeage="Slay"
											newfate.Gilreward=1000
										if("Artifact")
											mtype="Artifact"
											newfate.icon='Icons/Artifactfate.png'
											typeage="Artifact"
											newfate.Gilreward=100
										if("Delivery")
											mtype="Delivery"
											newfate.icon='Icons/Deliveryfate.png'
											typeage="Delivery"
											newfate.Gilreward=50
									switch(trank)
										if("D")
											newfate.Gilreward=50
											if(mtype=="Slayer")
												for(var/obj/npc/Monsters/DRank/a in global.stable_holder.monsters)
													if(a.unroot==1)
														slaylist+=a
												target = pick(slaylist)
												fightmob = copyatom(target)
												fightmob.FATENpc=1
												newfate.Reward1=pick(slayerrewardsD)
												newfate.Reward2=pick(slayerrewardsD)
												newfate.Reward3=pick(slayerrewardsD)
										if("C")
											newfate.Gilreward=100
											if(mtype=="Slayer")
												for(var/obj/npc/Monsters/CRank/a in global.stable_holder.monsters)
													if(a.unroot==1)
														slaylist+=a
												target = pick(slaylist)
												fightmob = copyatom(target)
												fightmob.FATENpc=1
												newfate.Reward1=pick(slayerrewardsC)
												newfate.Reward2=pick(slayerrewardsC)
												newfate.Reward3=pick(slayerrewardsC)
											if(mtype=="Artifact")
												var/obj/Artifact/fateartifact = new
												fateartifact.FATEID=newfate.FATEID
												newfate.loot_pack = /datum/prototype/struct/loot_pack/fate_artifact
												artifact=fateartifact
											if(mtype=="Delivery")
												var/obj/Client/cli=new
												var/obj/Client/FATEClient=copyatom(cli)
												FATEClient.FATEID=newfate.FATEID
												newfate.Reward1=pick(deliveryrewards)
												newfate.Reward2=pick(deliveryrewards)
												newfate.Reward3=pick(deliveryrewards)
												newfate.Gilreward=100
												client=FATEClient
										if("B")
											newfate.Gilreward=400
											if(mtype=="Slayer")
												for(var/obj/npc/Monsters/BRank/a in global.stable_holder.monsters)
													if(a.unroot==1)
														slaylist+=a
												target = pick(slaylist)
												fightmob = copyatom(target)
												newfate.Target=target
												fightmob.FATENpc=1
												newfate.Reward1=pick(slayerrewardsC)
												newfate.Reward2=pick(slayerrewardsB)
												newfate.Reward3=pick(slayerrewardsC)
											if(mtype=="Capture")
												alert(usr,"There are no A Rank Capture tasks!")
												return
											if(mtype=="Artifact")
												alert(usr,"There are no A Rank Artifact tasks!")
												return
											if(mtype=="Delivery")
												alert(usr,"There are no A Rank Delivery tasks!")
												return
										if("A")
											newfate.Gilreward=750
											if(mtype=="Slayer")
												for(var/obj/npc/Monsters/ARank/a in global.stable_holder.monsters)
													if(a.unroot==1)
														slaylist+=a
												target = pick(slaylist)
												fightmob = copyatom(target)
												fightmob.FATENpc=1
												fightmob.archived=0
												newfate.Reward1=pick(slayerrewardsB)
												newfate.Reward2=pick(slayerrewardsC)
												newfate.Reward3=pick(slayerrewardsB)
											if(mtype=="World Boss")
												for(var/obj/npc/Monsters/FateBoss/a in global.npc_archive.npcs)
													if(a.unroot==1)
														slaylist+=a
												target = pick(slaylist)
												fightmob = copyatom(target)
												fightmob.FATENpc=1
												fightmob.archived=0
												newfate.Reward1=pick(slayerrewardsB)
												newfate.Reward2=pick(slayerrewardsB)
												newfate.Reward3=pick(slayerrewardsB)
												newfate.bossfate=pick(bossrewards)
											if(mtype=="Capture")
												alert(usr,"There are no A Rank Capture tasks!")
												return
											if(mtype=="Artifact")
												alert(usr,"There are no A Rank Artifact tasks!")
												return
											if(mtype=="Delivery")
												alert(usr,"There are no A Rank Delivery tasks!")
												return
									newfate.name="[newfate.FATErank] rank [newfate.FATEtype] FATE : [typeage] [newfate.Target] ([p.name]) "
									p.contents+=newfate
									p.currentFATE=newfate
									usr.usingfate=0
									var/list/Location=new
									for(var/obj/FATECrystal/a in global.fate_crystals)
										if(newfate.FATEtype=="Capture" && a.occupied==1)
											Location+=a
										else
											if(a.occupied==1)
												Location-=a
										if(a.occupied==0)
											Location+=a
									var/obj/FATECrystal/fatelocation=pick(Location)
									if(fatelocation.occupied==1)
										Location-=fatelocation
										fatelocation=pick(Location)
										if(Location==null)
											alert(usr,"There are no available FATEs presently.")
											p.currentFATE=null
											usr.usingfate=0
											del newfate
											return
									fatelocation.party1=p
									newfate.FATEID=newfate.name
									fatelocation.occupied=1
									fightmob.FATEID=newfate.name
									newfate.CoordX=fatelocation.x
									fatelocation.contents+=fightmob
									newfate.CoordY=fatelocation.y
									newfate.CoordZ=fatelocation.z
									fatelocation.FATEID=newfate.name
									fatelocation.icon_state="active"
									p.FATEID=newfate.name
									for(var/area/ara in range(1,fatelocation))
										newfate.locationarea=ara.locid
									if(newfate.FATEtype=="Slayer")
										fightmob.New(fightmob)
										var/fightx=fatelocation.x-4
										fightmob.x=fightx
										fightmob.y=fatelocation.y
										fightmob.z=fatelocation.z
									if(newfate.FATEtype=="World Boss")
										fightmob.New(fightmob)
										var/fightx=fatelocation.x-4
										fightmob.x=fightx
										fightmob.y=fatelocation.y
										fightmob.z=fatelocation.z
									if(newfate.FATEtype=="Delivery")
										var/clientx=fatelocation.x-4
										client.x=clientx
										client.y=fatelocation.y
										client.z=fatelocation.z
										client.FATEID=newfate.FATEID
										client.layer=999
									if(newfate.FATEtype=="Artifact")
										var/turf/where_to_place = pick(range(7, fatelocation))
										artifact.force_move(where_to_place)
										artifact.layer=999
										artifact.FATEID=newfate.FATEID
									usr.usingfate=0
								if("No")
									usr.usingfate=0
									return
					else
						usr.usingfate=0

obj
	Artifact
		var
			FATEID
			party1=0
			used = FALSE
		icon='Icons/Artifact.png'
		Click()// I'll break down why this is broke. IDK how to fix it yet tho. But I'm wrinkling my brain over it. ---Vi
			if(used)
				return
			for(var/obj/Party/c in world) //This calls all party objects... IN THE WORLD.
				if("[usr.partyID]"=="[c.partyID]")//If it encounters a Party object, is will search this object for it's ID.
					for(var/obj/FATECrystal/b in global.fate_crystals)
						if("[b.FATEID]"=="[c.FATEID]")
							if(used)
								return
							used = TRUE
							view(usr)<<output("You've found the Artifact! Mog will return it to the researchers! (<b>FATE</b> complete!!)","icout")
							Victory(c,b)
							sleep(4)
							del src
							return
				//else
				//	alert(usr,"This is not your FATE to acquire!")
				//	return

				//the 'return' line being commented out is necessary for the game to cycle through all parties in world to find a matching party otherwise...
				//If it encounters a party that isn't the ID of the usr's party before encounteirng the user's party, it will fail.
				//We may need to rework the party system entirely to fix these. Make it easier for the game to narrow down which party's it searches. perhaps put the obj in the player? But that's dangerous.
				//IDK if this will cause Runtime ERRORS but we need to fix the Party style and Fate system overall. This entire DM prob needs recoded from the ground up. For now.. this works.
obj
	Client
		var
			FATEID
			party1=0
			party2=0
			used = FALSE
		icon='Icons/Client.png'
		Click()
			if(used)
				return
			for(var/obj/Party/c in world)
				if("[usr.partyID]"=="[c.partyID]")
					for(var/obj/FATECrystal/b in global.fate_crystals)
						if("[b.FATEID]"=="[c.FATEID]")
							if(used)
								return
							used = TRUE
							view(usr)<<output("Client: Thank you for the package, here's your pay. (<b>FATE</b> complete!!)","icout")
							Victory(c,b)
							sleep(2)
							sleep(4)
							del src
							return
				//else
				//	alert(usr,"This is not your FATE to deliver!")
				//	return

