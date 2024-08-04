atom
	var
		weptier
		smithing
obj
	var
		stattype
		stattypedisplay

mob
	proc
		Giveperk()
			src.carryweight=23.1
			var/obj/overlaydummy/d= new /obj/overlaydummy
			src.contents+=d
			var/obj/overlaydummy2/d2= new /obj/overlaydummy2
			src.contents+=d2
			var/obj/overlaydummy3/d3= new /obj/overlaydummy3
			src.contents+=d3
			var/obj/status/HPBar/hpb = new
			src.contents+=hpb
			var/obj/status/SPBar/spb = new
			src.contents+=spb
			var/obj/status/MPBar/mpb = new
			src.contents+=mpb
			var/obj/recipes/Machinist/Linkshell/ls=new
			var/obj/recipes/Machinist/Speaker/sp=new
			var/obj/recipes/Buildings/PersonalShop/pers=new
			src.contents+=pers
			src.contents+=ls
			src.contents+=sp


proc
	Summonerint()
		var/list/choices=list("Carbuncle","Sylph","Boko",/*"Remora","Cait Sith"*/)
		var/loop=1
		var/chosen=0
		while(loop)
			if(chosen<3)
				var/summonchoice = input(usr,"Pick 3 D Rank summons.") as anything in choices
				switch(summonchoice)
					if("Carbuncle")
						choices-=summonchoice
						var/obj/npc/Summons/DRank/Carbuncle/i=new
						usr.contents+=i
						chosen+=1
					if("Sylph")
						choices-=summonchoice
						var/obj/npc/Summons/DRank/Sylph/i=new
						usr.contents+=i
						chosen+=1
					if("Boko")
						choices-=summonchoice
						var/obj/npc/Summons/DRank/Boko/i=new
						usr.contents+=i
						chosen+=1
					if("Remora")
						choices-=summonchoice
						var/obj/npc/Summons/DRank/Remora/i=new
						usr.contents+=i
						chosen+=1
					if("Cait Sith")
						choices-=summonchoice
						var/obj/npc/Summons/DRank/CaitSith/i=new
						usr.contents+=i
						chosen+=1
			else if(chosen>=3)
				loop=0
				return



proc
	Scholarint()
		alert(usr,"Choose one C or B rank summon as your attuned Scholar summon.")
		var/list/scholarsummons = list()
		for(var/obj/npc/Summons/a in summonlist)
			if(a.rank=="C" && a.summon==1)
				scholarsummons+=a
			if(a.rank=="B" && a.summon==1)
				scholarsummons+=a
			if(a.name=="CRank")
				scholarsummons-=a
			if(a.name=="BRank")
				scholarsummons-=a
		var/obj/npc/choice = input ("Which summon will you attune to?") as anything in scholarsummons
		var/obj/npc/Summons/initsummon = choice
		var/obj/npc/Summons/scholsummon = copyatom(initsummon)
		usr.contents+=scholsummon
		scholsummon.scholarsum=1
		scholsummon.archived=0
		scholsummon.owner=usr.key
		if(scholsummon.rank=="C")
			scholsummon.mhp+=50
			scholsummon.hp+=50
			scholsummon.mmp+=50
			scholsummon.mp+=50
			scholsummon.msp+=50
			scholsummon.sp+=50
			scholsummon.baseac+=3
			scholsummon.pab+=2
			scholsummon.mab+=2
			scholsummon.mdb+=3
			scholsummon.pdb+=3
			if(scholsummon.basedr>0)
				scholsummon.basedr+=3
mob
	verb
		Summons()
			if(usr.buysummons==0)
				alert(usr,"You do not have access to Summoning.")
				return
			else
				var/list/CSummons = list()
				var/list/BSummons = list()
				var/list/ASummons = list()
				for(var/obj/npc/Summons/CRank/b in global.npc_archive.npcs)
					if(b.summon==1)
						CSummons+=b
					if(b.name in usr.contents)
						CSummons-=b
					if(b.name=="CRank")
						CSummons-=b
					for(var/obj/npc/q in usr.contents)
						if(b.name==q.name)
							CSummons-=b
				for(var/obj/npc/Summons/BRank/c in global.npc_archive.npcs)
					if(c.summon==1)
						BSummons+=c
					if(c.name in usr.contents)
						BSummons-=c
					if(c.name=="BRank")
						BSummons-=c
					for(var/obj/npc/q in usr.contents)
						if(c.name==q.name)
							CSummons-=c
				for(var/obj/npc/Summons/ARank/d in global.npc_archive.npcs)
					if(d.summon==1)
						ASummons+=d
					if(d.name in usr.contents)
						ASummons-=d
					if(d.name=="ARank")
						ASummons-=d
					for(var/obj/npc/q in usr.contents)
						if(d.name==q.name)
							CSummons-=d
				for(var/obj/npc/Summons/q in usr.contents)
					CSummons-=q
					BSummons-=q
					ASummons-=q
				var/list/summontier = list("C","B","A","Cancel")
				var/choice = input("Which tier of Summon would you like to buy?") as anything in summontier
				switch(choice)
					if("C")
						if(usr.Csummonslearned>=usr.maxsummonsC)
							alert(usr,"You have reached your maximum amount of C Rank summons!")
							return
						else
							var/picksummonC = input ("Which C Rank would you like to learn?") as anything in CSummons
							var/obj/npc/Summons/picksummoncopyC = copyatom(picksummonC)
							usr.contents+=picksummoncopyC
							usr.Csummonslearned+=1
							picksummoncopyC.archived=0
							picksummoncopyC.owner=usr.ckey
							RefreshNPC(usr)
							return
					if("B")
						if(usr.Bsummonslearned>=usr.maxsummonsB)
							alert(usr,"You have reached your maximum amount of B Rank summons!")
							return
						else
							var/picksummonB = input ("Which B Rank would you like to learn?") as anything in BSummons
							var/obj/npc/Summons/picksummoncopyB = copyatom(picksummonB)
							usr.contents+=picksummoncopyB
							usr.Bsummonslearned+=1
							picksummoncopyB.archived=0
							picksummoncopyB.owner=usr.ckey
							RefreshNPC(usr)
							return
					if("A")
						if(usr.Asummonslearned>=usr.maxsummonsA)
							alert(usr,"You have reached your maximum amount of A Rank summons!")
							return
						else
							var/picksummonA = input ("Which A Rank would you like to learn?") as anything in ASummons
							var/obj/npc/Summons/picksummoncopyA = copyatom(picksummonA)
							usr.contents+=picksummoncopyA
							usr.Asummonslearned+=1
							picksummoncopyA.archived=0
							picksummoncopyA.owner=usr.ckey
							RefreshNPC(usr)
							return
					if("Cancel")
						return



proc
	Checkspec(var/obj/o,var/mob/m)
		if(o.name=="Harbinger of Chaos")
			m.mhp+=50
			m.hp+=50
			m.msp+=30
			m.sp+=30
			m.mmp+=30
			m.mp+=30
			m.str+=2
			m.dex+=2
			m.wis+=2
			m.con+=2
			m.int+=2
			m.cha+=2
		if(o.name=="LoneWolf")
			m.nolearn+="PackLeader"
		if(o.name=="PackLeader")
			m.nolearn+="LoneWolf"
//OnionKnight
		if(o.name=="Onion Knight")
			m.ajob="Onion Knight"
			m.nolearn+="Pure Red Mage"
			m.mmp+=60
			m.mp+=60
			m.mhp+=60
			m.hp+=60
//scholar boosts
		if(o.name=="Shared Precision")
			for(var/obj/npc/Summons/a in m.contents)
				if(a.scholarsum==1)
					a.pab += 2
					a.mab += 2
		if(o.name=="Shared Defense")
			for(var/obj/npc/Summons/a in m.contents)
				if(a.scholarsum==1)
					a.baseac += 2
		if(o.name=="Shared Power")
			for(var/obj/npc/Summons/a in m.contents)
				if(a.scholarsum==1)
					a.pdb += 5
					a.mdb += 5
		if(o.name=="Shared Fortitude")
			for(var/obj/npc/Summons/a in m.contents)
				if(a.scholarsum==1)
					a.basedr += 5
		if(o.name=="Refined Fortitude")
			for(var/obj/npc/Summons/a in m.contents)
				if(a.scholarsum==1)
					a.mhp += 150
					a.hp += 150
					a.basedr += 10
		if(o.name=="Refined Mana Pool")
			for(var/obj/npc/Summons/a in m.contents)
				if(a.scholarsum==1)
					a.mmp += 200
					a.mp += 200
					a.msp += 50
					a.sp += 50
		if(o.name=="Ultimate Connection")
			for(var/obj/npc/Summons/a in m.contents)
				if(a.scholarsum==1)
					a.mmp+=100
					a.mp+=100
					a.mhp+=100
					a.msp+=100
					a.hp+=100
					a.sp+=100
					a.pab+=2
					a.mab+=2
					a.pdb+=2
					a.mdb+=2
					a.basedr+=5
					a.baseac+=2
///summoning specifics
		if(o.name=="Scholar")
			Scholarint()
		if(o.name=="Spirited Tree")
			var/obj/npc/Summons/Geomancer/SpiritedTree/a=new
			m.contents+=a
		if(o.name=="Summoner")
			m.buysummons=1
			Summonerint()
		if(o.name=="Necromancer")
			m.buysummons=0
			for(var/obj/npc/Summons/b in m.contents)
				if(b.summon==1 && b.scholarsum==0)
					del b
			for(var/obj/npc/Summons/Necromancer/c in global.npc_archive.npcs)
				if(c.summon==1)
					var/obj/npc/p = copyatom(c)
					p.archived=0
					usr.contents+=p
			alert(usr,"You have lost access to all normal Summons (except Scholar attunement Summons) ; and gained access to all Necromancer summons.")
///crafting specs
		if(o.name=="Heir of Lucis")
			m.mhp+=70
			m.hp+=70
			m.mmp+=50
			m.mp+=50
			m.msp+=50
			m.sp+=50
			m.pab+=2
			m.mab+=2
			m.pdb+=4
			m.mdb+=4
			m.baseac+=1
//		Machinist
		if(o.name=="Documentation")
			var/obj/recipes/Machinist/Manual/a=new
			m.contents+=a
		if(o.name=="Vehicle Mechanic")
			var/obj/recipes/Machinist/Vehicles/Landrover/a=new
			m.contents+=a
		if(o.name=="Shipwright")
			var/obj/recipes/Machinist/Vehicles/Ship/a=new
			m.contents+=a
		if(o.name=="Airship Engineer")
			var/obj/recipes/Machinist/Vehicles/Airship/a=new
			m.contents+=a
		if(o.name=="Basic Machina Weaponsmith")
			var/obj/recipes/Weapons/MagitekPistol/Bronze/a=new
			var/obj/recipes/Weapons/MagitekRifle/Bronze/b=new
			var/obj/recipes/Machinist/Weapons/T1/BallisticPistol/c=new
			var/obj/recipes/Machinist/Weapons/T1/Wrench/d=new
			var/obj/recipes/Machinist/Weapons/T1/Chainsaw/e=new
			var/obj/recipes/Machinist/Weapons/T1/Drillsword/f=new
			var/obj/recipes/Machinist/Weapons/T1/Drillspear/g=new
			var/obj/recipes/Machinist/Weapons/T1/RocketLauncher/h=new
			m.contents+=a
			m.contents+=b
			m.contents+=c
			m.contents+=d
			m.contents+=e
			m.contents+=f
			m.contents+=g
			m.contents+=h
			var/obj/recipes/Weapons/MagitekPistol/Iron/a1=new
			var/obj/recipes/Weapons/MagitekRifle/Iron/b1=new
			var/obj/recipes/Weapons/MagitekPistol/Steel/c1=new
			var/obj/recipes/Weapons/MagitekRifle/Steel/d1=new
			m.contents+=a1
			m.contents+=b1
			m.contents+=c1
			m.contents+=d1
		if(o.name=="Basic Ammosmith")
			var/obj/recipes/Machinist/Weapons/T1/Ammo/Basic/FireBullet/a=new
			var/obj/recipes/Machinist/Weapons/T1/Ammo/Basic/ThunderBullet/b=new
			var/obj/recipes/Machinist/Weapons/T1/Ammo/Basic/EarthBullet/c=new
			var/obj/recipes/Machinist/Weapons/T1/Ammo/Basic/WaterBullet/d=new
			var/obj/recipes/Machinist/Weapons/T1/Ammo/Basic/LowAPRound/e=new
			m.contents+=a
			m.contents+=b
			m.contents+=c
			m.contents+=d
			m.contents+=e
		if(o.name=="Advanced Machina Weaponsmith")
			var/obj/recipes/Machinist/Weapons/T3/LaserOffenseOrb/a=new
			var/obj/recipes/Machinist/Weapons/T3/LaserDefenseOrb/b=new
			var/obj/recipes/Machinist/Weapons/T3/Taser/c=new
			var/obj/recipes/Machinist/Weapons/T3/WreckingBall/d=new
			var/obj/recipes/Machinist/Weapons/T3/BeamCannon/e=new
			var/obj/recipes/Machinist/Weapons/T3/EnergySword/f=new
			var/obj/recipes/Machinist/Weapons/T3/Flamethrower/g=new
			var/obj/recipes/Machinist/Weapons/T3/BioBlaster/h=new
			var/obj/recipes/Weapons/MagitekPistol/Mythril/e1=new
			var/obj/recipes/Weapons/MagitekRifle/Mythril/f1=new
			var/obj/recipes/Weapons/MagitekPistol/Adamantine/g1=new
			var/obj/recipes/Weapons/MagitekRifle/Adamantine/h1=new
			var/obj/recipes/Weapons/MagitekPistol/Orichalcum/i1=new
			var/obj/recipes/Weapons/MagitekRifle/Orichalcum/j1=new
			m.contents+=a
			m.contents+=b
			m.contents+=c
			m.contents+=d
			m.contents+=e
			m.contents+=f
			m.contents+=g
			m.contents+=h
			m.contents+=e1
			m.contents+=f1
			m.contents+=g1
			m.contents+=h1
			m.contents+=i1
			m.contents+=j1
		if(o.name=="Terraformer")
			var/obj/recipes/Machinist/Terraformer/a=new
			m.contents+=a
		if(o.name=="Advanced Machina Ammosmith")
			var/obj/recipes/Machinist/Weapons/T3/Ammo/Advanced/AeroBullet/a=new
			var/obj/recipes/Machinist/Weapons/T3/Ammo/Advanced/IceBullet/b=new
			var/obj/recipes/Machinist/Weapons/T3/Ammo/Advanced/BioBullet/c=new
			var/obj/recipes/Machinist/Weapons/T3/Ammo/Advanced/DarkBullet/d=new
			var/obj/recipes/Machinist/Weapons/T3/Ammo/Advanced/HolyBullet/e=new
			var/obj/recipes/Machinist/Weapons/T3/Ammo/Advanced/HighAPRound/f=new
			m.contents+=a
			m.contents+=b
			m.contents+=c
			m.contents+=d
			m.contents+=e
			m.contents+=f
		if(o.name=="Nethicite Ammosmith")
			var/obj/recipes/Machinist/Weapons/T3/Ammo/Nethicite/a=new
			m.contents+=a
		if(o.name=="Initiate Roboticist")
			var/obj/recipes/Machinist/Robots/T2/Striker/a=new
			var/obj/recipes/Machinist/Robots/T2/Defender/b=new
			var/obj/recipes/Machinist/Upgrades/T2/Cores/PowerCore/c=new
			var/obj/recipes/Machinist/Upgrades/T2/Cores/DefenseCore/d=new
			var/obj/recipes/Machinist/Upgrades/T2/Cores/SpeedCore/e=new
			var/obj/recipes/Machinist/Upgrades/T2/Modules/Strength/f=new
			var/obj/recipes/Machinist/Upgrades/T2/Modules/Wisdom/g=new
			m.contents+=a
			m.contents+=b
			m.contents+=c
			m.contents+=d
			m.contents+=e
			m.contents+=f
			m.contents+=g
		if(o.name=="Experienced Roboticist")
			var/obj/recipes/Machinist/Robots/T3/Blitzer/a=new
			var/obj/recipes/Machinist/Robots/T3/Guardian/b=new
			var/obj/recipes/Machinist/Upgrades/T3/Cores/ElementalCore/c=new
			var/obj/recipes/Machinist/Upgrades/T3/Cores/HPCore/d=new
			var/obj/recipes/Machinist/Upgrades/T3/Modules/Dexterity/e=new
			var/obj/recipes/Machinist/Upgrades/T3/Modules/Constitution/f=new
			var/obj/recipes/Machinist/Upgrades/T3/Modules/Intelligence/g=new
			var/obj/recipes/Machinist/Upgrades/T3/Modules/Charisma/h=new
			var/obj/recipes/Machinist/Misc/T3/ForceFieldEmitter/i=new
			var/obj/recipes/Machinist/Misc/T3/ForceFieldRemote/j=new
			m.contents+=a
			m.contents+=b
			m.contents+=c
			m.contents+=d
			m.contents+=e
			m.contents+=f
			m.contents+=g
			m.contents+=h
			m.contents+=i
			m.contents+=j
		if(o.name=="Armor Engineer")
			var/obj/recipes/Machinist/Magitek/T4/MagitekArmor/a=new
			var/obj/recipes/Machinist/Upgrades/T4/Augment/b=new
			m.contents+=a
			m.contents+=b
		if(o.name=="Mecha Engineer")
			var/obj/recipes/Machinist/Magitek/T5/MagitekMecha/a=new
			m.contents+=a
		//Weaponsmith
		if(o.name=="Weaponsmith II")
			m.smithing=1
/*Chocobo Knight
		if(o.name=="Rookie Rider")
			var/list/choices=list("Adult Drake","Mesmerize","Blaze Beetle","Ankheg")
			var/chosen=input(m,"Which companion would you like to bond with?") as anything in choices
			switch(chosen)
				if("Adult Drake")
					var/obj/npc/Summons/CRank/AdultDrake/a=new
					m.contents+=a
				if("Mesmerize")
					var/obj/npc/Monsters/CRank/Mesmerize/a=new
					var/obj/perk/MonsterPassives/Rideable/b=new
					m.contents+=a
					a.contents+=b
				if("Blaze Beetle")
					var/obj/npc/Monsters/CRank/BlazeBeetle/a=new
					var/obj/perk/MonsterPassives/Rideable/b=new
					m.contents+=a
					a.contents+=b
				if("Ankheg")
					var/obj/npc/Monsters/CRank/Ankheg/a=new
					var/obj/perk/MonsterPassives/Rideable/b=new
					m.contents+=a
					a.contents+=b
		if(o.name=="Adept Rider")
			var/list/choices=list("Alpha Drake","Gigantoad","Woolly Croc","Shoopuff","Black Chocobo","Red Chocobo","Fat Chocobo")
			var/chosen=input(m,"Which companion would you like to bond with?") as anything in choices
			switch(chosen)
				if("Alpha Drake")
					var/obj/npc/Summons/BRank/AlphaDrake/a=new
					m.contents+=a
				if("Gigantoad")
					var/obj/npc/Monsters/BRank/Gigantoad/a=new
					var/obj/perk/MonsterPassives/Rideable/b=new
					m.contents+=a
					a.contents+=b
				if("Woolly Croc")
					var/obj/npc/Monsters/BRank/WoollyCroc/a=new
					var/obj/perk/MonsterPassives/Rideable/b=new
					m.contents+=a
					a.contents+=b
				if("Shoopuff")
					var/obj/npc/Monsters/BRank/Shoopuff/a=new
					var/obj/perk/MonsterPassives/Rideable/b=new
					m.contents+=a
					a.contents+=b
				if("Black Chocobo")
					var/obj/npc/Summons/BRank/BlackChocobo/a=new
					m.contents+=a
				if("Red Chocobo")
					var/obj/npc/Summons/BRank/RedChocobo/a=new
					m.contents+=a
				if("Fat Chocobo")
					var/obj/npc/Summons/BRank/FatChocobo/a=new
					m.contents+=a*/
//Dragoon
		if(o.name=="Wyvern Trainer")
			var/obj/npc/Monsters/Dragoon/Wyvern/wyv=new
			m.contents+=wyv
			wyv.owner=m.key
			wyv.archived=0
		if(o.name=="Deep Draconic Connection")
			for(var/obj/npc/Monsters/Dragoon/Wyvern/wyv in m.contents)
				wyv.mhp+=150
				wyv.hp+=150
				wyv.mmp+=150
				wyv.mp+=150
				wyv.msp+=150
				wyv.sp+=150
				wyv.str+=4
				wyv.dex+=4
				wyv.con+=4
				wyv.wis+=2
				wyv.strmod+=2
				wyv.dexmod+=2
				wyv.conmod+=2
				wyv.wismod+=1
				wyv.pab+=3
				wyv.mab+=3
				wyv.pdb+=5
				wyv.mdb+=5
				wyv.baseac+=5
				wyv.basedr+=5
				wyv.name="Great Drake"
				wyv.icon='Icons/Monsters/Drake.png'
				var/obj/perk/MonsterAbilities/BLU/BioSphere/df=new
				var/obj/perk/MonsterAbilities/BLU/MysticWing/mw=new
				wyv.contents+=df
				wyv.contents+=mw


//Steel

//Add to contents
		if(o.name=="Weaponsmith III")
			m.smithing=2
//Mythril

//Add to contents
		if(o.name=="Weaponsmith IV")
			m.smithing=3
//Adamantine

//Orichalcum

//Add to contents
		//armorsmith
		if(o.name=="Armorsmith II")
			var/obj/recipes/Armor/LightArmor/Bronze/a=new
			var/obj/recipes/Armor/MediumArmor/Bronze/b=new
			var/obj/recipes/Armor/HeavyArmor/Bronze/c=new
			var/obj/recipes/Armor/LightArmor/Iron/d=new
			var/obj/recipes/Armor/MediumArmor/Iron/e=new
			var/obj/recipes/Armor/HeavyArmor/Iron/f=new
			var/obj/recipes/Armor/LightArmor/Steel/g=new
			var/obj/recipes/Armor/MediumArmor/Steel/h=new
			var/obj/recipes/Armor/HeavyArmor/Steel/i=new
			var/obj/recipes/Armor/Shield/Bronze/j=new
			var/obj/recipes/Armor/Shield/Iron/k=new
			var/obj/recipes/Armor/Shield/Steel/l=new
			var/obj/recipes/Armor/TowerShield/Bronze/y=new
			var/obj/recipes/Armor/TowerShield/Iron/n=new
			var/obj/recipes/Armor/TowerShield/Steel/z=new
			m.contents+=a
			m.contents+=b
			m.contents+=c
			m.contents+=d
			m.contents+=e
			m.contents+=f
			m.contents+=g
			m.contents+=h
			m.contents+=i
			m.contents+=j
			m.contents+=k
			m.contents+=l
			m.contents+=y
			m.contents+=n
			m.contents+=z
		if(o.name=="Armorsmith III")
			var/obj/recipes/Armor/LightArmor/Mythril/a=new
			var/obj/recipes/Armor/MediumArmor/Mythril/b=new
			var/obj/recipes/Armor/HeavyArmor/Mythril/c=new
			var/obj/recipes/Armor/Shield/Mythril/d=new
			var/obj/recipes/Armor/TowerShield/Mythril/e=new
			m.contents+=a
			m.contents+=b
			m.contents+=c
			m.contents+=d
			m.contents+=e
		if(o.name=="Armorsmith IV")
			var/obj/recipes/Armor/LightArmor/Adamantine/a=new
			var/obj/recipes/Armor/MediumArmor/Adamantine/b=new
			var/obj/recipes/Armor/HeavyArmor/Adamantine/c=new
			var/obj/recipes/Armor/LightArmor/Orichalcum/d=new
			var/obj/recipes/Armor/MediumArmor/Orichalcum/e=new
			var/obj/recipes/Armor/HeavyArmor/Orichalcum/f=new
			var/obj/recipes/Armor/Shield/Adamantine/g=new
			var/obj/recipes/Armor/TowerShield/Adamantine/h=new
			var/obj/recipes/Armor/Shield/Adamantine/i=new
			var/obj/recipes/Armor/TowerShield/Orichalcum/j=new
			m.contents+=a
			m.contents+=b
			m.contents+=c
			m.contents+=d
			m.contents+=e
			m.contents+=f
			m.contents+=g
			m.contents+=h
			m.contents+=i
			m.contents+=j
		//chemist
		if(o.name=="Potion Lore")
			var/obj/recipes/Chemist/Potions/Potion/a=new
			m.contents+=a
			return
		if(o.name=="Potion Lore II")
			var/obj/recipes/Chemist/Potions/HiPotion/a=new
			m.contents+=a
			return
		if(o.name=="Potion Lore III")
			var/obj/recipes/Chemist/Potions/XPotion/a=new
			m.contents+=a
			return
		if(o.name=="Ether Lore")
			var/obj/recipes/Chemist/Potions/Ether/a=new
			m.contents+=a
			return
		if(o.name=="Ether Lore II")
			var/obj/recipes/Chemist/Potions/MaxEther/a=new
			m.contents+=a
			return
		if(o.name=="Bomb Craft")
			var/obj/recipes/Chemist/Bombs/FireBomb/a=new
			var/obj/recipes/Chemist/Bombs/WaterBomb/b=new
			var/obj/recipes/Chemist/Bombs/ThunderBomb/c=new
			var/obj/recipes/Chemist/Bombs/EarthBomb/d=new
			var/obj/recipes/Chemist/Bombs/IceBomb/e=new
			var/obj/recipes/Chemist/Bombs/BioBomb/f=new
			var/obj/recipes/Chemist/Bombs/WindBomb/g=new
			var/obj/recipes/Chemist/Bombs/DarkBomb/h=new
			var/obj/recipes/Chemist/Bombs/HolyBomb/i=new
			m.contents+=a
			m.contents+=b
			m.contents+=c
			m.contents+=d
			m.contents+=e
			m.contents+=f
			m.contents+=g
			m.contents+=h
			m.contents+=i
		if(o.name=="Silence Lore")
			var/obj/recipes/Chemist/Potions/EchoHerbs/a=new
			var/obj/recipes/Chemist/Potions/SilencePoison/b=new
			m.contents+=a
			m.contents+=b
		if(o.name=="Blind Lore")
			var/obj/recipes/Chemist/Potions/Eyedrops/a=new
			m.contents+=a
			var/obj/recipes/Chemist/Potions/BlindPoison/b=new
			m.contents+=b
			return
		if(o.name=="Stone Lore")
			var/obj/recipes/Chemist/Potions/GoldNeedle/a=new
			m.contents+=a
			return
		if(o.name=="Frog Lore")
			var/obj/recipes/Chemist/Potions/MaidensKiss/a=new
			m.contents+=a
			var/obj/recipes/Chemist/Potions/FrogPoison/b=new
			m.contents+=b
			return
		if(o.name=="Poison Lore")
			var/obj/recipes/Chemist/Potions/Poison/a=new
			m.contents+=a
			var/obj/recipes/Chemist/Potions/Antidote/b=new
			m.contents+=b
			return
		if(o.name=="Berserk Lore")
			var/obj/recipes/Chemist/Potions/BerserkPoison/a=new
			m.contents+=a
			var/obj/recipes/Chemist/Potions/Tranquilizer/b=new
			m.contents+=b
			return
		if(o.name=="Remedy Lore")
			var/obj/recipes/Chemist/Potions/Remedy/a=new
			m.contents+=a
			return
		if(o.name=="Phoenix Lore")
			var/obj/recipes/Chemist/Potions/PhoenixDown/a=new
			m.contents+=a
			return
		if(o.name=="Fountain of Youth")
			var/obj/recipes/Chemist/Potions/ElixirofYouth/a=new
			m.contents+=a
			return

		//jeweler
		if(o.name=="Jeweler")
			var/obj/recipes/Jeweler/SilverRing/a=new
			var/obj/recipes/Jeweler/GoldRing/b=new
			var/obj/recipes/Jeweler/SilverNecklace/c=new
			var/obj/recipes/Jeweler/GoldNecklace/d=new
			var/obj/recipes/Jeweler/SilverBracelet/e=new
			var/obj/recipes/Jeweler/GoldBracelet/f=new
			var/obj/recipes/Jeweler/SilverEarring/g=new
			var/obj/recipes/Jeweler/GoldEarring/h=new
			var/obj/recipes/Jeweler/SilverEarring/i=new
			var/obj/recipes/Jeweler/BronzeBangle/k=new
			var/obj/recipes/Jeweler/MythrilBangle/l=new
			var/obj/recipes/Jeweler/AdamantineBangle/z=new
			m.contents+=a
			m.contents+=b
			m.contents+=c
			m.contents+=d
			m.contents+=e
			m.contents+=f
			m.contents+=g
			m.contents+=h
			m.contents+=i
			m.contents+=k
			m.contents+=l
			m.contents+=z
			return

///
		if(o.name=="Forge A New Path")
			m.str+=2
			m.dex+=2
			m.con+=2
			m.int+=2
			m.wis+=2
			m.cha+=2
			m.mhp+=10
			m.hp+=10
			m.mmp+=10
			m.mp+=10
			m.msp+=10
			m.sp+=10
			m.Checkmod(1,m.str,m.addstr,m)
			m.Checkmod(2,m.dex,m.adddex,m)
			m.Checkmod(3,m.con,m.addcon,m)
			m.Checkmod(4,m.int,m.addint,m)
			m.Checkmod(5,m.wis,m.addwis,m)
			m.Checkmod(6,m.cha,m.addcha,m)
		if(o.name=="Templar")// These should all give the appropriate magic if they are lower than what these perks say they would give. They may be a proc to simplify these but these will work.
			if(m.whitemagicable<4)
				m.whitemagicable=4
			if(m.greenmagicable<3)
				m.greenmagicable=3
		if(o.name=="Support Specialist")
			if(m.greenmagicable<4)
				m.greenmagicable=4
		if(o.name=="Learned Mind")
			if(m.whitemagicable<4)
				m.whitemagicable=4
		if(o.name=="Dark Arts")
			if(m.blackmagicable<2)
				m.blackmagicable=2
			if(m.arcanemagicable<2)
				m.arcanemagicable=2
		if(o.name=="Dark Magus")
			Magicuseincrease(m,2,5)
		if(o.name=="Counter Meteor")
			var/obj/perk/Jobperks/TimeMage/CounterMeteor/CMeteor/a = new /obj/perk/Jobperks/TimeMage/CounterMeteor/CMeteor
			m.contents+=a
		//Advanced Jobs
		if(o.name=="Ninja Arts")
			m.ajob="Ninja"
			m.mhp+=20
			m.hp+=20
			m.mmp+=20
			m.mp+=20
			m.msp+=20
			m.sp+=20
			m.pab+=1
		if(o.name=="Sword Saint")
			m.ajob="Sword Saint"
			m.mhp+=65
			m.hp+=65
			m.mmp+=65
			m.mp+=65
			m.msp+=65
			m.sp+=65
			m.str+=2
			m.wis+=2
			m.cha+=2
			m.Checkmod(1,m.str,m.addstr,m)
			m.Checkmod(2,m.dex,m.adddex,m)
			m.Checkmod(3,m.con,m.addcon,m)
			m.Checkmod(4,m.int,m.addint,m)
			m.Checkmod(5,m.wis,m.addwis,m)
			m.Checkmod(6,m.cha,m.addcha,m)
		if(o.name=="Reaper")
			m.ajob="Reaper"
			m.mmp+=80
			m.mp+=80
			m.mhp+=80
			m.hp+=80
		if(o.name=="Gambler")
			m.ajob="Gambler"
		if(o.name=="Holy Dragoon")
			m.ajob="Holy Dragoon"
			m.mmp+=80
			m.mp+=80
			m.msp+=80
			m.sp+=80
			Magicuseincrease(m,1,3)
		if(o.name=="Necromancer")
			m.ajob="Necromancer"
			m.msp+=80
			m.sp+=80
			m.mmp+=80
			m.mp+=80
		if(o.name=="Defying Fate")
			m.ajob="Hope"
			m.nolearn+="Fear of Failure"
			m.mhp+=10
			m.hp+=10
			m.basedr+=4
		if(o.name=="Fear of Failure")
			m.ajob="Despair"
			m.nolearn+="Defying Fate"
			m.mhp+=20
			m.hp+=20
			m.mmp+=20
			m.mp+=20
			m.msp+=20
			m.sp+=20
			m.cha+=2
			m.Checkmod(1,m.str,m.addstr,m)
			m.Checkmod(2,m.dex,m.adddex,m)
			m.Checkmod(3,m.con,m.addcon,m)
			m.Checkmod(4,m.int,m.addint,m)
			m.Checkmod(5,m.wis,m.addwis,m)
			m.Checkmod(6,m.cha,m.addcha,m)
		if(o.name=="Crystal Puppet")
			m.str+=2
			m.dex+=2
			m.con+=2
			m.int+=2
			m.wis+=2
			m.cha+=2
			m.Checkmod(1,m.str,m.addstr,m)
			m.Checkmod(2,m.dex,m.adddex,m)
			m.Checkmod(3,m.con,m.addcon,m)
			m.Checkmod(4,m.int,m.addint,m)
			m.Checkmod(5,m.wis,m.addwis,m)
			m.Checkmod(6,m.cha,m.addcha,m)
		if(o.name=="Favored Puppet")
			m.mhp+=10
			m.hp+=10
			m.mmp+=10
			m.mp+=10
			m.msp+=10
			m.sp+=10
			m.pab+=2
			m.pdb+=2
			m.mab+=2
			m.mdb+=2
		if(o.name=="Berserker")
			m.mhp+=20
			m.hp+=20
			m.mmp+=20
			m.mp+=20
			m.msp+=20
			m.sp+=20
			m.str+=2
			m.dex+=2
			m.con+=2
			m.Checkmod(1,m.str,m.addstr,m)
			m.Checkmod(2,m.dex,m.adddex,m)
			m.Checkmod(3,m.con,m.addcon,m)
			m.Checkmod(4,m.int,m.addint,m)
			m.Checkmod(5,m.wis,m.addwis,m)
			m.Checkmod(6,m.cha,m.addcha,m)
			m.ajob="Berserker"
		if(o.name=="Sage")
			m.ajob="Sage"
			m.mmp+=100
			m.mp+=100
			m.hp+=100
			m.mhp+=100
			Magicuseincrease(m,1,6)
			Magicuseincrease(m,2,6)
			Magicuseincrease(m,3,6)
			Magicuseincrease(m,4,6)
			m.int+=4
			m.wis+=4
			m.cha+=4
			m.Checkmod(1,m.str,m.addstr,m)
			m.Checkmod(2,m.dex,m.adddex,m)
			m.Checkmod(3,m.con,m.addcon,m)
			m.Checkmod(4,m.int,m.addint,m)
			m.Checkmod(5,m.wis,m.addwis,m)
			m.Checkmod(6,m.cha,m.addcha,m)
		if(o.name=="Bushido")
			m.ajob="Bushido"
		if(o.name=="Bastion of Magic")
			m.mhp+=15
			m.hp+=15
			m.mmp+=15
			m.mp+=15
			m.basedr+=4
			Magicuseincrease(m,2,4)
			Magicuseincrease(m,4,4)
		if(o.name=="Tier 1 HP")
			m.hp+=50
			m.mhp+=50
		if(o.name=="Tier 2 HP")
			m.hp+=20
			m.mhp+=20
		if(o.name=="Tier 3 HP")
			m.hp+=20
			m.mhp+=20
		if(o.name=="Tier 4 HP")
			m.hp+=50
			m.mhp+=50
		if(o.name=="Tier 5 HP")
			m.hp+=40
			m.mhp+=40
		if(o.name=="Tier 6 HP")
			m.hp+=100
			m.mhp+=100
		if(o.name=="Tier 1 MP")
			m.mp+=40
			m.mmp+=40
		if(o.name=="Tier 2 MP")
			m.mp+=20
			m.mmp+=20
		if(o.name=="Tier 3 MP")
			m.mp+=20
			m.mmp+=20
		if(o.name=="Tier 4 MP")
			m.mp+=80
			m.mmp+=80
		if(o.name=="Tier 5 MP")
			m.mp+=60
			m.mmp+=60
		if(o.name=="Tier 6 MP")
			m.mp+=100
			m.mmp+=100
		if(o.name=="Tier 1 SP")
			m.sp+=40
			m.msp+=40
		if(o.name=="Tier 2 SP")
			m.sp+=20
			m.msp+=20
		if(o.name=="Tier 3 SP")
			m.sp+=20
			m.msp+=20
		if(o.name=="Tier 4 SP")
			m.sp+=80
			m.msp+=80
		if(o.name=="Tier 5 SP")
			m.sp+=60
			m.msp+=60
		if(o.name=="Tier 6 SP")
			m.sp+=100
			m.msp+=100
		if(o.name=="Speed(T1)")
			m.speed+=1
		if(o.name=="Speed(T2)")
			m.speed+=1
		if(o.name=="Speed(T3)")
			m.speed+=1
		if(o.name=="Speed(T4)")
			m.speed+=1
		if(o.name=="Speed(T5)")
			m.speed+=1
		if(o.name=="Speed(T6)")
			m.speed+=1
		if(o.name=="Ability Score Improvement T1")
			m.abilitypoints+=2
		if(o.name=="Ability Score Improvement T2")
			m.abilitypoints+=2
		if(o.name=="Ability Score Improvement T3")
			m.abilitypoints+=2
		if(o.name=="Ability Score Improvement T4")
			m.abilitypoints+=2
		if(o.name=="Strong")
			m.pdb+=5
		if(o.name=="Potent")
			m.mdb+=5
		if(o.name=="Durable")
			m.baseac+=1
		if(o.name=="Precise")
			m.pab+=1
		if(o.name=="Accurate")
			m.mab+=1
		if(o.name=="Sub Job")
			Subjobint(m)
		if(o.name=="Dual Job")
			m.subjobcap=5
			m.subcabs=5
		if(o.name=="Throwing Weapon Proficiency")
			m.weapontypes+="Throwing Weapon"
		if(o.name=="Geo Vibrations")
			m.baseac+=1
		if(o.name=="Aero Vibrations")
			m.baseac+=1
		if(o.name=="Life Stream Vibrations")
			m.baseac+=1
		if(o.name=="Water Walking")
			m.waterwalking=1
		if(o.name=="Suimen")
			m.waterwalking=1
		if(o.name=="Appointed Guardian")
			m.hp+=20
			m.mhp+=20
			m.mp+=20
			m.mmp+=20
			m.sp+=20
			m.msp+=20
			m.abilitypoints+=2
		if(o.name=="Warrior of Light")
			m.hp+=100
			m.mhp+=100
			m.mp+=100
			m.mmp+=100
		if(o.name=="Mako Poisoning")
			m.con-=0
			m.str+=0
			m.dex+=0
			m.mp+=0
			m.mmp+=0
			m.Checkmod(1,m.str,m.addstr,m)
			m.Checkmod(2,m.dex,m.adddex,m)
			m.Checkmod(3,m.con,m.addcon,m)
			m.Checkmod(4,m.int,m.addint,m)
			m.Checkmod(5,m.wis,m.addwis,m)
			m.Checkmod(6,m.cha,m.addcha,m)
		if(o.name=="Mako Affected")
			m.mhp+=30
			m.hp+=30
			m.mp+=30
			m.mmp+=30
			m.str+=2
			m.con+=2
			m.dex+=2
			m.Checkmod(1,m.str,m.addstr,m)
			m.Checkmod(2,m.dex,m.adddex,m)
			m.Checkmod(3,m.con,m.addcon,m)
			m.Checkmod(4,m.int,m.addint,m)
			m.Checkmod(5,m.wis,m.addwis,m)
			m.Checkmod(6,m.cha,m.addcha,m)
		if(o.name=="Imperfect Jenova Cells")
			m.hp+=50
			m.mhp+=50
			m.msp+=50
			m.sp+=50
			m.mmp+=50
			m.mp+=50
			m.str+=4
			m.dex+=4
			m.con+=2
			m.Checkmod(1,m.str,m.addstr,m)
			m.Checkmod(2,m.dex,m.adddex,m)
			m.Checkmod(3,m.con,m.addcon,m)
			m.Checkmod(4,m.int,m.addint,m)
			m.Checkmod(5,m.wis,m.addwis,m)
			m.Checkmod(6,m.cha,m.addcha,m)
		if(o.name=="Perfect Jenova Cells")
			m.hp+=100
			m.mhp+=100
			m.mp+=50
			m.mmp+=50
			m.msp+=50
			m.sp+=50
			m.str+=4
			m.con+=4
			m.dex+=4
			m.Checkmod(1,m.str,m.addstr,m)
			m.Checkmod(2,m.dex,m.adddex,m)
			m.Checkmod(3,m.con,m.addcon,m)
			m.Checkmod(4,m.int,m.addint,m)
			m.Checkmod(5,m.wis,m.addwis,m)
			m.Checkmod(6,m.cha,m.addcha,m)
		if(o.name=="L'cie (Job)")
			m.hp+=80
			m.mhp+=80
			m.mp+=80
			m.mmp+=80
			m.sp+=80
			m.msp+=80
			m.str+=2
			m.dex+=2
			m.con+=2
			m.int+=2
			m.wis+=2
			m.cha+=2
			Magicuseincrease(m,1,5)
			Magicuseincrease(m,2,5)
			Magicuseincrease(m,3,5)
			Magicuseincrease(m,4,5)
			m.job="L'cie"
			m.subjob=null
			m.Checkmod(1,m.str,m.addstr,m)
			m.Checkmod(2,m.dex,m.adddex,m)
			m.Checkmod(3,m.con,m.addcon,m)
			m.Checkmod(4,m.int,m.addint,m)
			m.Checkmod(5,m.wis,m.addwis,m)
			m.Checkmod(6,m.cha,m.addcha,m)
		if(o.name=="Fal'Cie")
			m.hp+=60
			m.mhp+=60
			m.mp+=30
			m.mmp+=30
			m.str+=4
			m.dex+=4
			m.con+=4
			m.int+=4
			m.wis+=4
			m.cha+=4
			m.Checkmod(1,m.str,m.addstr,m)
			m.Checkmod(2,m.dex,m.adddex,m)
			m.Checkmod(3,m.con,m.addcon,m)
			m.Checkmod(4,m.int,m.addint,m)
			m.Checkmod(5,m.wis,m.addwis,m)
			m.Checkmod(6,m.cha,m.addcha,m)
		if(o.name=="Aether Affected")
			m.hp+=30
			m.mhp+=30
			m.mp+=30
			m.mmp+=30
			m.wis+=2
			m.int+=2
			m.cha+=2
			m.Checkmod(1,m.str,m.addstr,m)
			m.Checkmod(2,m.dex,m.adddex,m)
			m.Checkmod(3,m.con,m.addcon,m)
			m.Checkmod(4,m.int,m.addint,m)
			m.Checkmod(5,m.wis,m.addwis,m)
			m.Checkmod(6,m.cha,m.addcha,m)
		if(o.name=="Unsent")
			m.hp+=20
			m.mhp+=20
			m.mp+=20
			m.mmp+=20
		if(o.name=="Appointed Guardian")
			m.hp+=20
			m.mhp+=20
			m.mp+=20
			m.mmp+=20
			m.abilitypoints+=2
		if(o.name=="Grand Summoner")
			m.hp+=50
			m.mhp+=50
			m.mmp+=50
			m.mp+=50
			m.str+=2
			m.dex+=2
			m.con+=2
			m.int+=2
			m.wis+=2
			m.cha+=2
		if(o.name=="Embodiment of Sin")
			m.hp+=50
			m.mhp+=50
			m.mp+=50
			m.mmp+=50
			m.str+=2
			m.dex+=2
			m.con+=2
			m.int+=2
			m.wis+=2
			m.cha+=2
		if(o.name=="Body of Sin")
			m.hp+=100
			m.mhp+=100
			m.mp+=100
			m.mmp+=100
			m.str+=4
			m.dex+=4
			m.con+=4
			m.int+=4
			m.wis+=4
			m.cha+=4
			m.Checkmod(1,m.str,m.addstr,m)
			m.Checkmod(2,m.dex,m.adddex,m)
			m.Checkmod(3,m.con,m.addcon,m)
			m.Checkmod(4,m.int,m.addint,m)
			m.Checkmod(5,m.wis,m.addwis,m)
			m.Checkmod(6,m.cha,m.addcha,m)
		if(o.name=="Ravager")
			m.mdb+=5
			m.pdb+=5
		if(o.name=="Stock Casting")
			var/obj/item/stock/Stockgem/Firegem/a = new /obj/item/stock/Stockgem/Firegem
			m.contents+=a
			var/obj/item/stock/Stockgem/Watergem/b = new /obj/item/stock/Stockgem/Watergem
			m.contents+=b
			var/obj/item/stock/Stockgem/Thundergem/c = new /obj/item/stock/Stockgem/Thundergem
			m.contents+=c
			var/obj/item/stock/Stockgem/Earthgem/d = new /obj/item/stock/Stockgem/Earthgem
			m.contents+=d
			var/obj/item/stock/Stockgem/Icegem/e = new /obj/item/stock/Stockgem/Icegem
			m.contents+=e
			var/obj/item/stock/Stockgem/Protectiongem/f = new /obj/item/stock/Stockgem/Protectiongem
			m.contents+=f
			var/obj/item/stock/Stockgem/Curegem/g = new /obj/item/stock/Stockgem/Curegem
			m.contents+=g
			var/obj/item/stock/Stockgem/Diagem/h = new /obj/item/stock/Stockgem/Diagem
			m.contents+=h
			var/obj/item/stock/Stockgem/Biogem/i = new /obj/item/stock/Stockgem/Biogem
			m.contents+=i
			var/obj/item/stock/Stockgem/Flaregem/j = new /obj/item/stock/Stockgem/Flaregem
			m.contents+=j
			var/obj/item/stock/Stockgem/Osmosegem/k = new /obj/item/stock/Stockgem/Osmosegem
			m.contents+=k
			var/obj/item/stock/Stockgem/Draingem/l = new /obj/item/stock/Stockgem/Draingem
			m.contents+=l
			m.stockcasting=1
		if(o.name=="Learned Mind")
			Magicuseincrease(m,1,4)
		if(o.name=="Arcane Warlock")
			Magicuseincrease(m,2,6)
		if(o.name=="Red Mage Adept")
			Magicuseincrease(m,1,4)
			Magicuseincrease(m,2,4)
		if(o.name=="Craftsmanship")
			m.maxcraftingroles+=1
			m.maxgatheringroles+=1
		if(o.name=="Red Empowerment")
			m.mhp+=20
			m.hp+=20
			m.mmp+=20
			m.mp+=20
			m.msp+=20
			m.sp+=20
			m.abilitypoints+=2
			m.APspent-=2
		if(o.name=="Tempered Fists I")
			var/obj/perk/Jobperks/Monk/TemperedFists1/Tempered1/a = new /obj/perk/Jobperks/Monk/TemperedFists1/Tempered1
			m.contents+=a
			m.monkbonus=2
		if(o.name=="Tempered Fists II")
			var/obj/perk/Jobperks/Monk/TemperedFists2/Tempered2/a = new /obj/perk/Jobperks/Monk/TemperedFists2/Tempered2
			m.contents+=a
			m.monkbonus=3
		if(o.name=="Tempered Fists III")
			var/obj/perk/Jobperks/Monk/TemperedFists3/Tempered3/a = new /obj/perk/Jobperks/Monk/TemperedFists3/Tempered3
			m.contents+=a
			m.monkbonus=4
		if(o.name=="Tempered Fists IV")
			var/obj/perk/Jobperks/Monk/TemperedFists4/Tempered4/a = new /obj/perk/Jobperks/Monk/TemperedFists4/Tempered4
			m.contents+=a
			m.monkbonus=5
		if(o.name=="Tempered Fists V")
			var/obj/perk/Jobperks/Monk/TemperedFists5/Tempered5/a = new /obj/perk/Jobperks/Monk/TemperedFists5/Tempered5
			m.contents+=a
			m.monkbonus=10
		if(o.name=="Tempered Body I")
			m.baserflx+=1
			m.basewill+=1
			m.basefort+=1
		if(o.name=="Tempered Body II")
			m.baserflx+=1
			m.basewill+=1
			m.basefort+=1
		if(o.name=="Tempered Body III")
			m.baserflx+=1
			m.basewill+=1
			m.basefort+=1
		if(o.name=="Tempered Body IV")
			m.baserflx+=1
			m.basewill+=1
			m.basefort+=1
		if(o.name=="Tempered Body V")
			m.baserflx+=1
			m.basewill+=1
			m.basefort+=1
		if(o.name=="Pure Red Mage") //Del redmage test
			m.mmp+=20
			m.mp+=20
			m.msp+=20
			m.sp+=20
			m.abilitypoints+=2
			m.nolearn+="Sub Job"
		if(o.name=="Synchronicity")
			m.mmp+=30
			m.mp+=30
			m.mab+=1
			m.mdb+=8
		if(o.name=="L'Cie")
			m.nolearn+="Sub Job"
			m.nolearn+="Dual Job"
		if(o.name=="Sub Job")
			m.nolearn+="Pure Red Mage"// All the Sage-Path Red mage perks should be added as well to be not compatible.
			m.nolearn+="Synchronicity"
			m.nolearn+="Red Mage Adept"
			m.nolearn+="Going it Alone"
			m.nolearn+="Jack of All Mages"
			m.nolearn+="Red Empowerment"
		if(o.name=="Juuinjutsu")
			m.nolearn+="Senjutsu"
		if(o.name=="Senjutsu")
			m.nolearn+="Juuinjutsu"
		if(o.name=="Hikigaeru")
			m.nolearn+="Hebi"
			m.nolearn+="Namekuji"
			m.mhp+=50
			m.hp+=50
			m.str+=2
			var/obj/perk/MonsterAbilities/BLU/ToadKata/a = new /obj/perk/MonsterAbilities/BLU/ToadKata
			var/obj/perk/MonsterAbilities/BLU/MagicTongue/b = new /obj/perk/MonsterAbilities/BLU/MagicTongue
			var/obj/perk/MonsterAbilities/BLU/OilBullet/c = new /obj/perk/MonsterAbilities/BLU/OilBullet
			var/obj/npc/Summons/Ninja/NinjaToad/d=new
			m.contents+=d
			d.owner=m
			m.contents+=a
			m.contents+=b
			m.contents+=c

		if(o.name=="Hebi")
			m.nolearn+="Hikigaeru"
			m.nolearn+="Namekuji"
			m.dex+=2
			Magicuseincrease(m,4,3)
			m.pab+=1
			var/obj/npc/Summons/Ninja/NinjaSnake/d=new
			d.owner=m
			m.contents+=d

		if(o.name=="Namekuji")
			m.nolearn+="Hikigaeru"
			m.nolearn+="Hebi"
			Magicuseincrease(m,3,3)
			m.mmp+=50
			m.msp+=50
			m.mp+=50
			m.sp+=50
			var/obj/npc/Summons/Ninja/NinjaSlug/d=new
			m.contents+=d
			d.owner=m
		m.Refreshinventoryscreen(m)
		m.UpdateCraft(m)
		m.Savecheck(m)
	SavePerk()
		var/savefile/S = new("data/Perks")
		S["Perks"]<<perklist
	LoadPerk()
		if(fexists("data/Perks"))
			var/savefile/S = new("data/Perks")
			S["Perks"]>>perklist
	Saveweps()
		var/savefile/S = new("data/Weapons")
		S["Weapons"]<<weplist
	Savematerials()
		var/savefile/S = new("data/Materials")
		S["Items"]<<materiallist
	Saverecipes()
		var/savefile/S = new("data/Recipes")
		S["Recipes"]<<recipelist
	Savesummons()
		var/savefile/S = new("data/Summons")
		S["Summons"]<<summonlist
	Savebestiary()
		var/savefile/S = new("data/Bestiary")
		S["Bestiary"]<<bestiary
	Loadrecipes()
		if(fexists("data/Recipes"))
			var/savefile/S = new("data/Recipes")
			S["Recipes"]<<recipelist
	Loadmaterials()
		if(fexists("data/Materials"))
			var/savefile/S = new("data/Materials")
			S["Materials"]<<materiallist
	LoadWeps()
		if(fexists("data/Weapons"))
			var/savefile/S = new("data/Weapons")
			S["Weapons"]>>weplist
	Loadsummons()
		if(fexists("data/Summons"))
			var/savefile/S = new("data/Summons")
			S["Summons"]>>summonlist
	Loadbestiary()
		if(fexists("data/Bestiary"))
			var/savefile/S = new("data/Bestiary")
			S["Bestiary"]>>bestiary
	Initperk()
		for(var/A in typesof(/obj/perk)) if(A!=/obj/perk) perklist+=new A
	Initcraft()
		for(var/C in subtypes_of_non_abstract(/obj/item/material))
			materiallist +=new C
	Initwep()
		for(var/B in typesof(/obj/item/Weapon)) if(B!=/obj/item/Weapon) weplist+=new B
	Initrecipes()
		for(var/B in typesof(/obj/recipes)) if(B!=/obj/recipes) recipelist+=new B
	Initsummons()
		for(var/B in typesof(/obj/npc/Summons)) if (B!=/obj/npc/Summons) summonlist+= new B
	Initbestiary()
		for(var/B in typesof(/obj/npc/Monsters)) if (B!=/obj/npc/Monsters) bestiary+=new B
	Checkmag(var/obj/perk/p,var/mob/m)
		if(p.magicneed==null)
			return 0
		else
			var/rankno
			if(p.rank=="D")
				rankno=1
			if(p.rank=="C")
				rankno=2
			if(p.rank=="B")
				rankno=3
			if(p.rank=="A")
				rankno=4
			if(p.rank=="S")
				rankno=5
			switch(p.magicneed)
				if("White Magic")
					if(m.whitemagicable>=rankno)
						return 0
					else
						return 1
				if("Black Magic")
					if(m.blackmagicable>=rankno)
						return 0
					else
						return 1
				if("Green Magic")
					if(m.greenmagicable>=rankno)
						return 0
					else
						return 1
				if("Arcane Magic")
					if(m.arcanemagicable>=rankno)
						return 0
					else
						return 1
	Checkjob(var/obj/perk/p,var/mob/m)
		if(p.jobneed==null)
			return 0
		else
			if(m.job==p.jobneed)
				return 0
			else if(m.subjob==p.jobneed)
				return 0
			else
				return 1
	Checkrank(var/obj/perk/p,var/mob/m)
		if(m.rank=="Fledgling")
			if(p.rank=="B"|p.rank=="A"|p.rank=="S"|p.rank=="T3"|p.rank=="T4"|p.rank=="T5"|p.rank=="T6")
				return 1
			if(p.rank=="T2")
				if(m.t2s>=2)
					return 1
				else
					return 0
			else
				return 0
		if(m.rank=="Rookie")
			if(p.rank=="A"|p.rank=="S"|p.rank=="T4"|p.rank=="T5"|p.rank=="T6")
				return 1
			if(p.rank=="T3")
				if(m.t3s>=2)
					return 1
				else
					return 0
			if(p.rank=="B")
				if(m.babs>=3)
					return 1
				else
					return 0
			else
				return 0
		if(m.rank=="Adept")
			if(p.rank=="A"|p.rank=="S"|p.rank=="T4"|p.rank=="T5"|p.rank=="T6")
				return 1
			if(p.rank=="T3")
				if(m.t3s>=4)
					return 1
				else
					return 0
		if(m.rank=="Veteran")
			if(p.rank=="S"|p.rank=="T5"|p.rank=="T6")
				return 1
			if(p.rank=="T4")
				if(m.t4s>=2)
					return 1
				else
					return 0
			if(p.rank=="A")
				if(m.aabs>=3)
					return 1
				else
					return 0
		if(m.rank=="Hero")
			if(p.rank=="T6")
				return 1
			if(p.rank=="T4")
				if(m.t4s>=4)
					return 1
				else
					return 0
			if(p.rank=="T5")
				if(m.t5s>=1)
					return 1
				else
					return 0
			if(p.rank=="S")
				if(m.sabs>=1)
					return 1
				else
					return 0
		if(m.rank=="Master")
			if(p.rank=="T4")
				if(m.t4s>=6)
					return 1
				else
					return 0
			if(p.rank=="T5")
				if(m.t5s>=2)
					return 1
				else
					return 0
			if(p.rank=="T6")
				if(m.t6s>=1)
					return 1
				else
					return 0
			if(p.rank=="S")
				if(m.sabs>=3)
					return 1
				else
					return 0
	Updateranktrac(var/obj/perk/p,var/mob/m)
		if(p.rank=="T1")
			m.t1s++
		if(p.rank=="T2")
			m.t2s++
		if(p.rank=="T3")
			m.t3s++
		if(p.rank=="T4")
			m.t4s++
		if(p.rank=="T5")
			m.t5s++
		if(p.rank=="T6")
			m.t6s++
		if(p.rank=="D")
			m.dabs++
		if(p.rank=="C")
			m.cabs++
		if(p.rank=="B")
			m.babs++
		if(p.rank=="A")
			m.aabs++
		if(p.rank=="S")
			m.sabs++

var/daypasses=0
var/list/perklist=new
var/list/weplist=new
var/list/materiallist=new
var/list/recipelist=new
var/list/summonlist=new
var/list/bestiary=new

obj
	var/typing
	perk
		var/ajob
		var/adddam
		var/addhit
		var/damsource
		var/technique
		var/mcost
		var/costtype
		var/rank
		var/rpcost
		var/pre
		var/ontree
		var/jobneed
		var/rankneed
		var/magicneed
		var/ptype
		var/cat
		var/level
		var/players
		var/range
		var/ability=0
		var/row
		var/aoresult
		var/aresult
		var/amod
		var/doresult
		var/dmod
		var/dresult
		var/critdam
		var/basecheck
		var/abilitydamage
		var/atype
		var/savetype
		var/critrange=20
		var/npcweapon=0
		var/blu=0
		layer=4
		icon='Perk.dmi'
		Click()
			if(istype(loc, /obj/item/Materia))
				var/obj/item/Materia/l = loc
				pass(l)	// consume the var so compiler doesn't complain even if we don't use it
				if(src.ability==1)
					switch(alert("[src.desc] (Rank:[src.rank])","[src.name]","Reveal","Cancel","Attack"))
						if("Reveal")
							players={"<font color=#EC2323>[usr.name] has flashed a card: <a href="byond://?src=\ref[usr]&action=look&value=\ref[src]"><font color=#FFFFFF>[src]</a>!!"}
							if(src.blu==1)
								players={"<font color=#EC2323>[usr.name] has flashed a card: <a href="byond://?src=\ref[usr]&action=look&value=\ref[src]"><font color=#FFFFFF>[src]</a>!! <a href="byond://?src=\ref[usr]&action=blu&value=\ref[src]"> <font color=#0FBFD7><b>BLU!</b></a>"}
							view() << output("[players]","icout")
						if("Attack")
							if(src.atype=="heal")
								var/healbonus=usr.chamod*2
								doresult=raw_attack_damage_roll()
								dresult=doresult+src.adddam+healbonus
								view()<<output("<font size=1><font color=[usr.textcolor]>[usr] <font color=white>is using the <font color=[usr.textcolor]>[src.name]<font color=white> ability! They have healed a target for <font color=#A8F596><b>[dresult]</b></font> HP!","icout")
							if(src.atype=="curada")
								var/curadabonus=usr.mhp*0.5
								var/healbonus=usr.chamod*2
								doresult=raw_attack_damage_roll()
								dresult=doresult+curadabonus+healbonus
								view()<<output("<font size=1><font color=[usr.textcolor]>[usr] <font color=white>is using the <font color=[usr.textcolor]>[src.name]<font color=white> ability! They have healed a target for <font color=#A8F596><b>[dresult]</b></font> HP!","icout")
							if(src.atype=="save")
								doresult=raw_attack_damage_roll()
								amod=Checkdamtype(src.damsource,usr)
								dmod=Checkdamtype(src.damsource,usr)
								abilitydamage=raw_attack_damage_roll()
								if(src.typing=="magical")
									aresult=src.basecheck+amod+usr.rankbonus+src.addhit+2
									dresult=abilitydamage+dmod+usr.mdb+src.adddam+10
									dresult += usr.mdbadd
								else
									aresult=src.basecheck+amod+usr.rankbonus+src.addhit
									dresult=abilitydamage+dmod+usr.pdb+src.adddam
									dresult += usr.pdbadd
								view()<<output("<font size=1><font color=[usr.textcolor]>[usr] <font color=white>is using the <font color=[usr.textcolor]>[src.name]<font color=white> ability!  Saving throw: <font color=#8EF5DE><b>[aresult] [src.savetype]!</b><font color=white>, dealing <b><font color=#FFA852>[dresult] damage</b><font color=white> on a failed save!<br> Cost: <b><font color=#0FBFD7>[src.mcost] [src.costtype]</b>| Tile Range:[src.range]","icout")
							if(src.atype=="weaponsave")
								var/obj/item/Weapon/wepchoice = usr.righthand
								alert(usr,"This ability will use the weapon equipped to your right hand.")
								amod=Checkdamtype(wepchoice.damsource,usr)
								if(src.typing=="magical")
									aresult=src.basecheck+amod+usr.rankbonus+src.addhit
								else
									aresult=src.basecheck+amod+usr.rankbonus+src.addhit
								doresult=rand(wepchoice.range1,wepchoice.range2)
								dmod=Checkdamtype(wepchoice.damsource,usr)
								abilitydamage=raw_attack_damage_roll()
								if(src.typing=="magical")
									dresult=doresult+dmod+wepchoice.adddam+usr.mdb+src.adddam+abilitydamage
									aresult += usr.mdbadd
								else
									dresult=doresult+dmod+wepchoice.adddam+usr.pdb+src.adddam+abilitydamage
									aresult += usr.pdbadd
								view()<<output("<font size=1><font color=[usr.textcolor]>[usr] <font color=white>is using the <font color=[usr.textcolor]>[src.name]<font color=white> ability with their [wepchoice.name]!  Saving throw: <font color=#8EF5DE><b>[aresult] [src.savetype]!</b><font color=white>, dealing <b><font color=#FFA852>[dresult] damage</b><font color=white> on a failed save!<br> Cost: <b><font color=#0FBFD7>[src.mcost] [src.costtype]</b> | Tile Range:[src.range]","icout")
							if(src.atype=="weapon")
								alert(usr,"This ability will use the weapon equipped to your right hand.")
								if(usr.righthand==0)
									alert(usr,"You don't have a weapon equipped to use this ability!")
								else
									var/obj/item/Weapon/wepchoice = usr.righthand
									aoresult=rand(1,20)
									amod=Checkdamtype(wepchoice.damsource,usr)
									if(src.typing=="magical")
										aresult=aoresult+wepchoice.addhit+amod+usr.rankbonus+usr.mab+src.addhit
										aresult += usr.mabadd
									else
										aresult=aoresult+wepchoice.addhit+amod+usr.rankbonus+usr.pab+src.addhit
										aresult += usr.pdbadd
									doresult=rand(wepchoice.range1,wepchoice.range2)
									dmod=Checkdamtype(wepchoice.damsource,usr)
									abilitydamage=raw_attack_damage_roll()
									if(src.typing=="magical")
										dresult=doresult+dmod+wepchoice.adddam+usr.mdb+src.adddam+abilitydamage
										dresult += usr.mdbadd
									else
										dresult=doresult+dmod+wepchoice.adddam+usr.pdb+src.adddam+abilitydamage
										dresult += usr.pdbadd
									critdam=dresult+doresult
									var/truecrit=wepchoice.critrange-usr.critmod
									if(aoresult>=truecrit)
										view()<<output("<font size=1><font color=[usr.textcolor]>[usr] <font color=white>rolled a <b><font color=#3CF82C>CRITICAL</b> <font color=white>attack roll, using the <font color=[usr.textcolor]>[src.name]<font color=white> ability with their [wepchoice.name]! Result: <font color=#3CF82C><b>[aresult] to hit</b><font color=white>, dealing <b><font color=#FFA852>[critdam] damage</b><font color=white>, as an automatic hit! Cost: <b><font color=#0FBFD7>[src.mcost] [src.costtype]</b>","icout")
									else
										view()<<output("<font size=1><font color=[usr.textcolor]>[usr] <font color=white>rolled an attack roll, using the <font color=[usr.textcolor]>[src.name]<font color=white> ability with their [wepchoice.name]!  Result: <font color=#8EF5DE><b>[aresult] to hit</b><font color=white>, dealing <b><font color=#FFA852>[dresult] damage</b><font color=white> if successful!<br> Cost: <b><font color=#0FBFD7>[src.mcost] [src.costtype]</b> | Tile Range:[src.range]","icout")
							if(src.atype=="standard")
								aoresult=rand(1,20)
								amod=Checkdamtype(src.damsource,usr)
								if(src.typing=="magical")
									aresult=aoresult+src.addhit+amod+usr.rankbonus+usr.mab+2
									aresult += usr.mabadd
								else
									aresult=aoresult+src.addhit+amod+usr.rankbonus+usr.pab
									aresult += usr.pabadd
								doresult=raw_attack_damage_roll()
								dmod=Checkdamtype(src.damsource,usr)
								if(src.typing=="magical")
									dresult=doresult+dmod+src.adddam+usr.mdb+10
									dresult += usr.mdbadd
								else
									dresult=doresult+dmod+src.adddam+usr.pdb
									dresult += usr.pdbadd
								critdam=dresult+doresult
								var/truecrit=src.critrange-usr.critmod
								if(aoresult>=truecrit)
									view()<<output("<font size=1><font color=[usr.textcolor]>[usr] <font color=white>rolled a <b><font color=#3CF82C>CRITICAL</b> <font color=white>attack roll, using the <font color=[usr.textcolor]>[src.name]<font color=white> ability! Result: <font color=#3CF82C><b>[aresult] to hit</b><font color=white>, dealing <b><font color=#FFA852>[critdam] damage</b><font color=white>, as an automatic hit! Cost: <b><font color=#0FBFD7>[src.mcost] [src.costtype]</b>","icout")
								else
									view()<<output("<font size=1><font color=[usr.textcolor]>[usr] <font color=white>rolled an attack roll, using the <font color=[usr.textcolor]>[src.name]<font color=white> ability!  Result: <font color=#8EF5DE><b>[aresult] to hit</b><font color=white>, dealing <b><font color=#FFA852>[dresult] damage</b><font color=white> if successful!<br> Cost: <b><font color=#0FBFD7>[src.mcost] [src.costtype]</b> | Tile Range:[src.range]","output1")
									view()<<output("<font size=1><font color=[usr.textcolor]>[usr] <font color=white>rolled an attack roll, using the <font color=[usr.textcolor]>[src.name]<font color=white> ability! Result: <font color=#8EF5DE><b>[aresult] to hit</b><font color=white>, dealing <b><font color=#FFA852>[dresult] damage</b><font color=white> if successful!<br> Cost: <b><font color=#0FBFD7>[src.mcost] [src.costtype]</b> | Tile Range:[src.range]","icout")
						if("Cancel")
							return
				else
					switch(alert("[src.desc] (Rank:[src.rank])","[src.name]","Reveal","Cancel"))
						if("Reveal")
							if(src.blu==1)
								players={"<font color=#EC2323>[usr.name] has flashed a card: <a href="byond://?src=\ref[usr]&action=look&value=\ref[src]"><font color=#FFFFFF>[src]</a>!! <a href="byond://?src=\ref[usr]&action=blu&value=\ref[src]"> <font color=#0FBFD7><b>BLU!</b></a>"}
							view() << output("[players]","icout")
						if("Cancel")
							return
			if(istype(loc, /obj/npc))
				var/obj/npc/z = loc
				players={"<font color=#EC2323>[z.name] has flashed a card: <a href="byond://?src=\ref[usr]&action=look&value=\ref[src]"><font color=#FFFFFF>[src]</a>!!"}
				// just an ability flash
				if(!src.ability)
					switch(alert(usr, "[src.desc] (Rank:[src.rank])","[src.name]","Reveal","Cancel"))
						if("Reveal")
							if(src.blu==1)
								players={"<font color=#EC2323>[z.name] has flashed a card: <a href="byond://?src=\ref[usr]&action=look&value=\ref[src]"><font color=#FFFFFF>[src]</a>!! <a href="byond://?src=\ref[usr]&action=blu&value=\ref[src]"> <font color=#0FBFD7><b>BLU!</b></a>"}
							view() << output("[players]","icout")
					return
				// non ability; attack roll
				switch(alert("[src.desc] (Rank:[src.rank])","[src.name]","Reveal","Cancel","Attack"))
					if("Reveal")
						if(src.blu==1)
							players={"<font color=#EC2323>[z.name] has flashed a card: <a href="byond://?src=\ref[usr]&action=look&value=\ref[src]"><font color=#FFFFFF>[src]</a>!! <a href="byond://?src=\ref[usr]&action=blu&value=\ref[src]"> <font color=#0FBFD7><b>BLU!</b></a>"}
							view() << output("[players]","icout")
						else
							view() << output("[players]","icout")
					if("Attack")
						if(src.atype=="heal")
							var/healbonus=z.chamod*2
							doresult=raw_attack_damage_roll()
							dresult=doresult+src.adddam+healbonus
							view()<<output("<font size=1><font color=[usr.textcolor]>[z] <font color=white>is using the <font color=[z.textcolor]>[src.name]<font color=white> ability! They have healed a target for <font color=#A8F596><b>[dresult]</b></font> HP!","icout")
						if(src.atype=="curada")
							var/curadabonus=z.mhp*0.5
							var/healbonus=z.chamod*2
							doresult=raw_attack_damage_roll()
							dresult=doresult+curadabonus+healbonus
							view()<<output("<font size=1><font color=[usr.textcolor]>[z] <font color=white>is using the <font color=[z.textcolor]>[src.name]<font color=white> ability! They have healed a target for <font color=#A8F596><b>[dresult]</b></font> HP!","icout")
						if(src.atype=="save")
							doresult=raw_attack_damage_roll()
							amod=Checkdamtype(src.damsource,z)
							dmod=Checkdamtype(src.damsource,z)
							abilitydamage=raw_attack_damage_roll()
							if(src.typing=="magical")
								aresult=src.basecheck+amod+z.rankbonus+src.addhit+2
								dresult=abilitydamage+dmod+z.mdb+src.adddam+10
							else
								aresult=src.basecheck+amod+z.rankbonus+src.addhit
								dresult=abilitydamage+dmod+z.pdb+src.adddam
							view()<<output("<font size=1><font color=[usr.textcolor]>[z] <font color=white>is using the <font color=[usr.textcolor]>[src.name]<font color=white> ability!  Saving throw: <font color=#8EF5DE><b>[aresult] [src.savetype]!</b><font color=white>, dealing <b><font color=#FFA852>[dresult] damage</b><font color=white> on a failed save!<br> Cost: <b><font color=#0FBFD7>[src.mcost] [src.costtype]</b> | Tile Range:[src.range]","icout")
						if(src.atype=="weaponsave")
							var/obj/item/Weapon/wepchoice = z.eweapon
							alert(usr,"This ability will use the weapon equipped to your right hand.")
							amod=Checkdamtype(wepchoice.damsource,z)
							if(src.typing=="magical")
								aresult=src.basecheck+amod+usr.rankbonus+src.addhit
							else
								aresult=src.basecheck+amod+usr.rankbonus+src.addhit
							doresult=rand(wepchoice.range1,wepchoice.range2)
							dmod=Checkdamtype(wepchoice.damsource,z)
							abilitydamage=raw_attack_damage_roll()
							if(src.typing=="magical")
								dresult=doresult+dmod+wepchoice.adddam+z.mdb+src.adddam+abilitydamage
							else
								dresult=doresult+dmod+wepchoice.adddam+z.pdb+src.adddam+abilitydamage
							view()<<output("<font size=1><font color=[usr.textcolor]>[z] <font color=white>is using the <font color=[usr.textcolor]>[src.name]<font color=white> ability with their [wepchoice.name]!  Saving throw: <font color=#8EF5DE><b>[aresult] [src.savetype]!</b><font color=white>, dealing <b><font color=#FFA852>[dresult] damage</b><font color=white> on a failed save!<br> Cost: <b><font color=#0FBFD7>[src.mcost] [src.costtype]</b> | Tile Range:[src.range]","icout")
						if(src.atype=="weapon")
							alert(usr,"This ability will use the weapon equipped to your right hand.")
							if(z.eweapon==0)
								alert(usr,"You don't have a weapon equipped to use this ability!")
							else
								var/obj/item/Weapon/wepchoice = z.eweapon
								aoresult=rand(1,20)
								amod=Checkdamtype(wepchoice.damsource,z)
								if(src.typing=="magical")
									aresult=aoresult+wepchoice.addhit+amod+z.rankbonus+z.mab+src.addhit
								else
									aresult=aoresult+wepchoice.addhit+amod+z.rankbonus+z.pab+src.addhit
								doresult=rand(wepchoice.range1,wepchoice.range2)
								dmod=Checkdamtype(wepchoice.damsource,z)
								abilitydamage=raw_attack_damage_roll()
								if(src.typing=="magical")
									dresult=doresult+dmod+wepchoice.adddam+z.mdb+src.adddam+abilitydamage
								else
									dresult=doresult+dmod+wepchoice.adddam+z.pdb+src.adddam+abilitydamage
								critdam=dresult+doresult
								var/truecrit=wepchoice.critrange-z.critmod
								if(aoresult>=truecrit)
									view()<<output("<font size=1><font color=[usr.textcolor]>[z] <font color=white>rolled a <b><font color=#3CF82C>CRITICAL</b> <font color=white>attack roll, using the <font color=[usr.textcolor]>[src.name]<font color=white> ability with their [wepchoice.name]! Result: <font color=#3CF82C><b>[aresult] to hit</b><font color=white>, dealing <b><font color=#FFA852>[critdam] damage</b><font color=white>, as an automatic hit! Cost: <b><font color=#0FBFD7>[src.mcost] [src.costtype]</b>","icout")
								else
									view()<<output("<font size=1><font color=[usr.textcolor]>[z] <font color=white>rolled an attack roll, using the <font color=[usr.textcolor]>[src.name]<font color=white> ability with their [wepchoice.name]!  Result: <font color=#8EF5DE><b>[aresult] to hit</b><font color=white>, dealing <b><font color=#FFA852>[dresult] damage</b><font color=white> if successful!<br> Cost: <b><font color=#0FBFD7>[src.mcost] [src.costtype]</b> | Tile Range:[src.range]","icout")
						if(src.atype=="standard")
							aoresult=rand(1,20)
							amod=Checkdamtype(src.damsource,z)
							if(src.typing=="magical")
								aresult=aoresult+src.addhit+amod+z.rankbonus+z.mab+2
							else
								aresult=aoresult+src.addhit+amod+z.rankbonus+z.pab
							doresult=raw_attack_damage_roll()
							dmod=Checkdamtype(src.damsource,z)
							if(src.typing=="magical")
								dresult=doresult+dmod+src.adddam+z.mdb+10
							else
								dresult=doresult+dmod+src.adddam+z.pdb
							critdam=dresult+doresult
							var/truecrit=src.critrange-z.critmod
							if(aoresult>=truecrit)
								view()<<output("<font size=1><font color=[usr.textcolor]>[z] <font color=white>rolled a <b><font color=#3CF82C>CRITICAL</b> <font color=white>attack roll, using the <font color=[usr.textcolor]>[src.name]<font color=white> ability! Result: <font color=#3CF82C><b>[aresult] to hit</b><font color=white>, dealing <b><font color=#FFA852>[critdam] damage</b><font color=white>, as an automatic hit! Cost: <b><font color=#0FBFD7>[src.mcost] [src.costtype]</b>","icout")
							else
								view()<<output("<font size=1><font color=[usr.textcolor]>[z] <font color=white>rolled an attack roll, using the <font color=[usr.textcolor]>[src.name]<font color=white> ability!  Result: <font color=#8EF5DE><b>[aresult] to hit</b><font color=white>, dealing <b><font color=#FFA852>[dresult] damage</b><font color=white> if successful!<br> Cost: <b><font color=#0FBFD7>[src.mcost] [src.costtype]</b> | Tile Range:[src.range]","output1")
								view()<<output("<font size=1><font color=[usr.textcolor]>[z] <font color=white>rolled an attack roll, using the <font color=[usr.textcolor]>[src.name]<font color=white> ability! Result: <font color=#8EF5DE><b>[aresult] to hit</b><font color=white>, dealing <b><font color=#FFA852>[dresult] damage</b><font color=white> if successful!<br> Cost: <b><font color=#0FBFD7>[src.mcost] [src.costtype]</b> | Tile Range:[src.range]","icout")
					if("Cancel")
						return
			//* bandaided
			if(src in global.perk_shop.perks)
				if(usr.perkbuying==1)
					alert(usr,"You are already buying a perk.")
					usr.perkbuying=0
					return
				usr.perkbuying=1
				if(usr.check_perk(src))
					alert(usr,"You already know this perk.")
					usr.perkbuying=0
					return
				if(!isnull(purchase_stat_requirements))
					for(var/stat in purchase_stat_requirements)
						var/val = purchase_stat_requirements[stat]
						var/theirs
						switch(stat)
							// todo: this is shitcode
							if("int")
								theirs = usr.int
							if("dex")
								theirs = usr.dex
							if("con")
								theirs = usr.con
							if("wis")
								theirs = usr.wis
							if("cha")
								theirs = usr.cha
							if("str")
								theirs = usr.str
						if(!isnull(theirs) && val > theirs)
							var/list/built = list()
							for(var/needed_stat in purchase_stat_requirements)
								built += "[purchase_stat_requirements[needed_stat]] [uppertext(needed_stat)]"
							var/rendered = jointext(built, ", ")
							alert(usr, "You need at least [rendered] to purchase this perk.")
							usr.perkbuying = FALSE
							return
				if(!isnull(purchase_stat_requirements_any))
					var/passed = FALSE
					for(var/stat in purchase_stat_requirements_any)
						var/val = purchase_stat_requirements_any[stat]
						var/theirs
						switch(stat)
							// todo: this is shitcode
							if("int")
								theirs = usr.int
							if("dex")
								theirs = usr.dex
							if("con")
								theirs = usr.con
							if("wis")
								theirs = usr.wis
							if("cha")
								theirs = usr.cha
							if("str")
								theirs = usr.str
						if(!isnull(theirs) && val <= theirs)
							passed = TRUE
							break
					if(!passed)
						var/list/built = list()
						for(var/stat in purchase_stat_requirements_any)
							built += "[purchase_stat_requirements_any[stat]] [uppertext(stat)]"
						var/rendered = jointext(built, ", or ")
						alert(usr, "You need to have [rendered] to purchase this perk.")
						usr.perkbuying = FALSE
						return
				if(src.name in usr.nolearn)
					alert("You cannot learn this perk, as a perk you know is incompatible.")
					usr.perkbuying=0
					return
				switch(alert("[src.desc] (Rank: [src.rank]) (Cost: [src.rpcost])","[src.name]","Learn","Cancel"))
					if("Learn")
						if(src.jobneed==usr.subjob)
							if(src.ability==1)
								if(src.level<=2 && usr.subjobcap>=2)
									if(usr.subjobcap==2)
										if(usr.subcabs==3)
											alert("You have learned the maximum amount of C Ranks from your subjob!")
											usr.perkbuying=0
											return
									if(src.rank=="B" && usr.subjobcap==2)
										alert("You are not capable of learning abilities of this level from your Subjob without the Dual Job perk.")
										usr.perkbuying=0
										return
									if(src.rank=="A" && usr.subjobcap==2)
										alert("You are not capable of learning abilities of this level from your Subjob without the Dual Job perk.")
										usr.perkbuying=0
										return
									if(src.rank=="S" && usr.subjobcap==2)
										alert("You are not capable of learning abilities of this level from your Subjob without the Dual Job perk.")
										usr.perkbuying=0
										return
									if(src.pre)
										if(Checkmag(src,usr))
											alert("You are not capable of learning perks of this type or rank.")
											usr.perkbuying=0
											return
										if(Checkrank(src,usr))
											alert("You cannot learn abilities of that rank right now.")
											usr.perkbuying=0
											return
										if(usr.check_perk(pre))
											if(usr.rpp>=src.rpcost)
												if(src.level==2)
													usr.subcabs+=1
												usr.rpp-=src.rpcost
												var/obj/perk/p = copyatom(src)
												p.ontree=0
												usr.contents+=p
												alert("You have learned [src.name]")
												Checkspec(src,usr)
												Rankadjust(src,usr)
												winset(usr,"PerkWindow.rpp","text=\"[usr.rpp]/[usr.trpp]\"")
												usr.perkbuying=0
												return
											else
												alert("You don't have enough RPP to learn this.")
												usr.perkbuying=0
										else
											alert("You need [src.pre] in order to learn this.")
											usr.perkbuying=0
											return
									else
										if(usr.rpp>=src.rpcost)
											if(Checkmag(src,usr))
												alert("You are not capable of learning perks of this type or rank.")
												usr.perkbuying=0
												return
											if(Checkrank(src,usr))
												alert("You cannot learn abilities of that rank right now.")
												usr.perkbuying=0
												return
											if(src.level==2)
												usr.subcabs+=1
											usr.rpp-=src.rpcost
											var/obj/perk/p = copyatom(src)
											p.ontree=0
											usr.contents+=p
											alert("You have learned [src.name]")
											Checkspec(src,usr)
											Rankadjust(src,usr)
											winset(usr,"PerkWindow.rpp","text=\"[usr.rpp]/[usr.trpp]\"")
											usr.perkbuying=0
											usr.Save()
											return
										else
											alert("You don't have enough RPP to learn this.")
											usr.perkbuying=0
											return

							if(src.ability==0)
								if(src.rank<="T2" && usr.subjobcap>=2)
									if(usr.rpp>=src.rpcost)
										if(src.rank=="T2" && usr.subjobcap<2)
											alert("You are not capable of learning perks of this level from your Subjob without the Dual Job perk.")
											usr.perkbuying=0
											return
										if(src.rank=="T3" && usr.subjobcap==2)
											alert("You are not capable of learning perks of this level from your Subjob without the Dual Job perk.")
											usr.perkbuying=0
											return
										if(src.rank=="T4" && usr.subjobcap==2)
											alert("You are not capable of learning perks of this level from your Subjob without the Dual Job perk.")
											usr.perkbuying=0
											return
										if(src.rank=="T5" && usr.subjobcap==2)
											alert("You are not capable of learning perks of this level from your Subjob without the Dual Job perk.")
											usr.perkbuying=0
											return
										if(Checkmag(src,usr))
											alert("You are not capable of learning perks of this type or rank.")
											usr.perkbuying=0
											return
										if(Checkrank(src,usr))
											alert("You cannot learn abilities of that rank right now.")
											usr.perkbuying=0
											return
								if(src.pre)
									if(usr.check_perk(src.pre))
										if(usr.rpp>=src.rpcost)
											if(src.rank=="T2" && usr.subjobcap<2)
												alert("You are not capable of learning perks of this level from your Subjob without the Dual Job perk.")
												usr.perkbuying=0
												return
											if(src.rank=="T3" && usr.subjobcap==2)
												alert("You are not capable of learning perks of this level from your Subjob without the Dual Job perk.")
												usr.perkbuying=0
												return
											if(src.rank=="T4" && usr.subjobcap==2)
												alert("You are not capable of learning perks of this level from your Subjob without the Dual Job perk.")
												usr.perkbuying=0
												return
											if(src.rank=="T5" && usr.subjobcap==2)
												alert("You are not capable of learning perks of this level from your Subjob without the Dual Job perk.")
												usr.perkbuying=0
												return
											if(Checkmag(src,usr))
												alert("You are not capable of learning perks of this type or rank.")
												usr.perkbuying=0
												return
											if(Checkrank(src,usr))
												alert("You cannot learn abilities of that rank right now.")
												usr.perkbuying=0
												return
											if(src.level==2)
												usr.subcabs+=1
											usr.rpp-=src.rpcost
											var/obj/perk/p = copyatom(src)
											p.ontree=0
											usr.contents+=p
											alert("You have learned [src.name]")
											Checkspec(src,usr)
											Rankadjust(src,usr)
											winset(usr,"PerkWindow.rpp","text=\"[usr.rpp]/[usr.trpp]\"")
											usr.perkbuying=0
											return
										else
											alert("You don't have enough RPP to learn this.")
											usr.perkbuying=0
									else
										alert("You need [src.pre] in order to learn this.")
										usr.perkbuying=0
										return
								else
									if(usr.rpp>=src.rpcost)
										if(src.rank=="T2" && usr.subjobcap<2)
											alert("You are not capable of learning perks of this level from your Subjob without the Dual Job perk.")
											usr.perkbuying=0
											return
										if(src.rank=="T3" && usr.subjobcap==2)
											alert("You are not capable of learning perks of this level from your Subjob without the Dual Job perk.")
											usr.perkbuying=0
											return
										if(src.rank=="T4" && usr.subjobcap==2)
											alert("You are not capable of learning perks of this level from your Subjob without the Dual Job perk.")
											usr.perkbuying=0
											return
										if(src.rank=="T5" && usr.subjobcap==2)
											alert("You are not capable of learning perks of this level from your Subjob without the Dual Job perk.")
											usr.perkbuying=0
											return
										if(Checkmag(src,usr))
											alert("You are not capable of learning perks of this type or rank.")
											usr.perkbuying=0
											return
										if(Checkrank(src,usr))
											alert("You cannot learn abilities of that rank right now.")
											usr.perkbuying=0
											return
										if(src.level==2)
											usr.subcabs+=1
										usr.rpp-=src.rpcost
										var/obj/perk/p = copyatom(src)
										p.ontree=0
										usr.contents+=p
										alert("You have learned [src.name]")
										Checkspec(src,usr)
										Rankadjust(src,usr)
										winset(usr,"PerkWindow.rpp","text=\"[usr.rpp]/[usr.trpp]\"")
										usr.perkbuying=0
										return
									else
										alert("You don't have enough RPP to learn this.")
										usr.perkbuying=0
										return

						else
							if(Checkmag(src,usr))
								alert("You are not capable of learning perks of this type or rank.")
								usr.perkbuying=0
								return
							if(Checkrank(src,usr))
								alert("You cannot learn abilities of that rank right now.")
								usr.perkbuying=0
								return
							if(src.pre)
								if(usr.check_perk(src.pre))
									if(usr.rpp>=src.rpcost)
										usr.rpp-=src.rpcost
										var/obj/perk/p = copyatom(src)
										p.ontree=0
										usr.contents+=p
										alert("You have learned [src.name]")
										Checkspec(src,usr)
										Rankadjust(src,usr)
										winset(usr,"PerkWindow.rpp","text=\"[usr.rpp]/[usr.trpp]\"")
										usr.perkbuying=0
									else
										alert("You don't have enough RPP to learn this.")
										usr.perkbuying=0
								else
									alert("You need [src.pre] in order to learn this.")
									usr.perkbuying=0
									return
							else
								if(usr.rpp>=src.rpcost)
									usr.rpp-=src.rpcost
									var/obj/perk/p = copyatom(src)
									p.ontree=0
									usr.contents+=p
									alert("You have learned [src.name]")
									Checkspec(src,usr)
									Rankadjust(src,usr)
									winset(usr,"PerkWindow.rpp","text=\"[usr.rpp]/[usr.trpp]\"")
									usr.perkbuying=0
								else
									alert("You don't have enough RPP to learn this.")
									usr.perkbuying=0
					if("Cancel")
						usr.perkbuying=0
						return
			players={"<font color=#EC2323>[usr.name] has flashed a card: <a href="byond://?src=\ref[usr]&action=look&value=\ref[src]"><font color=#FFFFFF>[src]</a>!!"}
			if(src in usr.contents)
				if(src.ability==1)
					switch(alert("[src.desc] (Rank:[src.rank])","[src.name]","Reveal","Cancel","Attack"))
						if("Reveal")
							if(src.blu==1)
								players={"<font color=#EC2323>[usr.name] has flashed a card: <a href="byond://?src=\ref[usr]&action=look&value=\ref[src]"><font color=#FFFFFF>[src]</a>!! <a href="byond://?src=\ref[usr]&action=blu&value=\ref[src]"> <font color=#0FBFD7><b>BLU!</b></a>"}
							view() << output("[players]","icout")
						if("Attack")
							if(src.monkability==1)
								src.adddam=usr.monkbonus
							if(src.atype=="heal")
								var/healbonus=usr.chamod*2
								doresult=raw_attack_damage_roll()
								dresult=doresult+src.adddam+healbonus
								view()<<output("<font size=1><font color=[usr.textcolor]>[usr] <font color=white>is using the <font color=[usr.textcolor]>[src.name]<font color=white> ability! They have healed a target for <font color=#A8F596><b>[dresult]</b></font> HP!","icout")
							if(src.atype=="curada")
								var/healbonus=usr.chamod*2
								var/curadabonus=usr.mhp*0.5
								doresult=raw_attack_damage_roll()
								dresult=doresult+curadabonus+healbonus
								view()<<output("<font size=1><font color=[usr.textcolor]>[usr] <font color=white>is using the <font color=[usr.textcolor]>[src.name]<font color=white> ability! They have healed a target for <font color=#A8F596><b>[dresult]</b></font> HP!","icout")
							if(src.atype=="save")// Please kill me I gotta put all the mabadd stuff and shit starting here. ---Vi
								doresult=raw_attack_damage_roll()
								amod=Checkdamtype(src.damsource,usr)
								dmod=Checkdamtype(src.damsource,usr)
								abilitydamage=raw_attack_damage_roll()
								if(src.typing=="magical")
									aresult=src.basecheck+amod+usr.rankbonus+src.addhit+2
									dresult=abilitydamage+dmod+usr.mdb+src.adddam+10
									dresult += usr.mdbadd
								else
									aresult=src.basecheck+amod+usr.rankbonus+src.addhit
									dresult=abilitydamage+dmod+usr.pdb+src.adddam
									dresult+= usr.pdbadd
								view()<<output("<font size=1><font color=[usr.textcolor]>[usr] <font color=white>is using the <font color=[usr.textcolor]>[src.name]<font color=white> ability!  Saving throw: <font color=#8EF5DE><b>[aresult] [src.savetype]!</b><font color=white>, dealing <b><font color=#FFA852>[dresult] damage</b><font color=white> on a failed save!<br> Cost: <b><font color=#0FBFD7>[src.mcost] [src.costtype]</b> | Tile Range:[src.range]","icout")
							if(src.atype=="weaponsave")
								var/obj/item/Weapon/wepchoice = usr.righthand
								alert(usr,"This ability will use the weapon equipped to your right hand.")
								amod=Checkdamtype(wepchoice.damsource,usr)
								if(src.typing=="magical")
									aresult=src.basecheck+amod+usr.rankbonus+src.addhit
								else
									aresult=src.basecheck+amod+usr.rankbonus+src.addhit
								doresult=rand(wepchoice.range1,wepchoice.range2)
								dmod=Checkdamtype(wepchoice.damsource,usr)
								abilitydamage=raw_attack_damage_roll()
								if(src.typing=="magical")
									dresult=doresult+dmod+wepchoice.adddam+usr.mdb+src.adddam+abilitydamage
									dresult += usr.mdbadd
								else
									dresult=doresult+dmod+wepchoice.adddam+usr.pdb+src.adddam+abilitydamage
									dresult += usr.pdbadd
								view()<<output("<font size=1><font color=[usr.textcolor]>[usr] <font color=white>is using the <font color=[usr.textcolor]>[src.name]<font color=white> ability with their [wepchoice.name]!  Saving throw: <font color=#8EF5DE><b>[aresult] [src.savetype]!</b><font color=white>, dealing <b><font color=#FFA852>[dresult] damage</b><font color=white> on a failed save!<br> Cost: <b><font color=#0FBFD7>[src.mcost] [src.costtype]</b> | Tile Range:[src.range]","icout")
							if(src.atype=="weapon")
								alert(usr,"This ability will use the weapon equipped to your right hand.")
								if(usr.righthand==0)
									alert(usr,"You don't have a weapon equipped to use this ability!")
								else
									var/obj/item/Weapon/wepchoice = usr.righthand
									aoresult=rand(1,20)
									amod=Checkdamtype(wepchoice.damsource,usr)
									if(src.typing=="magical")
										aresult=aoresult+wepchoice.addhit+amod+usr.rankbonus+usr.mab+src.addhit
										aresult += usr.mabadd
									else
										aresult=aoresult+wepchoice.addhit+amod+usr.rankbonus+usr.pab+src.addhit
										aresult += usr.pabadd
									doresult=rand(wepchoice.range1,wepchoice.range2)
									dmod=Checkdamtype(wepchoice.damsource,usr)
									abilitydamage=raw_attack_damage_roll()
									if(src.typing=="magical")
										dresult=doresult+dmod+wepchoice.adddam+usr.mdb+src.adddam+abilitydamage
										dresult += usr.mdbadd
									else
										dresult=doresult+dmod+wepchoice.adddam+usr.pdb+src.adddam+abilitydamage
										dresult += usr.pdbadd
									critdam=dresult+doresult
									var/truecrit=wepchoice.critrange-usr.critmod
									if(aoresult>=truecrit)
										view()<<output("<font size=1><font color=[usr.textcolor]>[usr] <font color=white>rolled a <b><font color=#3CF82C>CRITICAL</b> <font color=white>attack roll, using the <font color=[usr.textcolor]>[src.name]<font color=white> ability with their [wepchoice.name]! Result: <font color=#3CF82C><b>[aresult] to hit</b><font color=white>, dealing <b><font color=#FFA852>[critdam] damage</b><font color=white>, as an automatic hit! Cost: <b><font color=#0FBFD7>[src.mcost] [src.costtype]</b>","icout")
									else
										view()<<output("<font size=1><font color=[usr.textcolor]>[usr] <font color=white>rolled an attack roll, using the <font color=[usr.textcolor]>[src.name]<font color=white> ability with their [wepchoice.name]!  Result: <font color=#8EF5DE><b>[aresult] to hit</b><font color=white>, dealing <b><font color=#FFA852>[dresult] damage</b><font color=white> if successful!<br> Cost: <b><font color=#0FBFD7>[src.mcost] [src.costtype]</b> | Tile Range:[src.range]","icout")
							if(src.atype=="standard")
								aoresult=rand(1,20)
								amod=Checkdamtype(src.damsource,usr)
								if(src.typing=="magical")
									aresult=aoresult+src.addhit+amod+usr.rankbonus+usr.mab+2
									aresult += usr.mabadd
								else
									aresult=aoresult+src.addhit+amod+usr.rankbonus+usr.pab
									aresult += usr.pabadd
								doresult=raw_attack_damage_roll()
								dmod=Checkdamtype(src.damsource,usr)
								if(src.typing=="magical")
									dresult=doresult+dmod+src.adddam+usr.mdb+10
									dresult += usr.mdbadd
								else
									dresult=doresult+dmod+src.adddam+usr.pdb
									dresult += usr.pdbadd
								critdam=dresult+doresult
								var/truecrit=src.critrange-usr.critmod
								if(aoresult>=truecrit)
									view()<<output("<font size=1><font color=[usr.textcolor]>[usr] <font color=white>rolled a <b><font color=#3CF82C>CRITICAL</b> <font color=white>attack roll, using the <font color=[usr.textcolor]>[src.name]<font color=white> ability! Result: <font color=#3CF82C><b>[aresult] to hit</b><font color=white>, dealing <b><font color=#FFA852>[critdam] damage</b><font color=white>, as an automatic hit! Cost: <b><font color=#0FBFD7>[src.mcost] [src.costtype]</b>","icout")
								else
									view()<<output("<font size=1><font color=[usr.textcolor]>[usr] <font color=white>rolled an attack roll, using the <font color=[usr.textcolor]>[src.name]<font color=white> ability!  Result: <font color=#8EF5DE><b>[aresult] to hit</b><font color=white>, dealing <b><font color=#FFA852>[dresult] damage</b><font color=white> if successful!<br> Cost: <b><font color=#0FBFD7>[src.mcost] [src.costtype]</b> | Tile Range:[src.range]","output1")
									view()<<output("<font size=1><font color=[usr.textcolor]>[usr] <font color=white>rolled an attack roll, using the <font color=[usr.textcolor]>[src.name]<font color=white> ability! Result: <font color=#8EF5DE><b>[aresult] to hit</b><font color=white>, dealing <b><font color=#FFA852>[dresult] damage</b><font color=white> if successful!<br> Cost: <b><font color=#0FBFD7>[src.mcost] [src.costtype]</b> | Tile Range:[src.range]","icout")
						if("Cancel")
							return
				else
					switch(alert("[src.desc] (Rank:[src.rank])","[src.name]","Reveal","Cancel"))
						if("Reveal")
							if(src.blu==1)
								players={"<font color=#EC2323>[usr.name] has flashed a card: <a href="byond://?src=\ref[usr]&action=look&value=\ref[src]"><font color=#FFFFFF>[src]</a>!! <a href="byond://?src=\ref[usr]&action=blu&value=\ref[src]"> <font color=#0FBFD7><b>BLU!</b></a>"}
							view() << output("[players]","icout")
						if("Cancel")
							return

obj
	proc
		Rankadjust(var/obj/perk/o, var/mob/m)
			if(o.rank=="T1")
				m.t1s++
			if(o.rank=="T2")
				m.t2s++
			if(o.rank=="T3")
				m.t3s++
			if(o.rank=="T4")
				m.t4s++
			if(o.rank=="T5")
				m.t5s++
			if(o.rank=="T6")
				m.t6s++
			if(o.rank=="E")
				m.eabs++
			if(o.rank=="D")
				m.dabs++
			if(o.rank=="C")
				m.cabs++
			if(o.rank=="B")
				m.babs++
			if(o.rank=="A")
				m.aabs++
			if(o.rank=="S")
				m.sabs++
mob
	proc
		Rankadjust(var/obj/perk/o, var/mob/m)
			if(o.rank=="T1")
				m.t1s++
			if(o.rank=="T2")
				m.t2s++
			if(o.rank=="T3")
				m.t3s++
			if(o.rank=="T4")
				m.t4s++
			if(o.rank=="T5")
				m.t5s++
			if(o.rank=="T6")
				m.t6s++
			if(o.rank=="E")
				m.eabs++
			if(o.rank=="D")
				m.dabs++
			if(o.rank=="C")
				m.cabs++
			if(o.rank=="B")
				m.babs++
			if(o.rank=="A")
				m.aabs++
			if(o.rank=="S")
				m.sabs++
