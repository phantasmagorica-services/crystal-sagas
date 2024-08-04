/**
 * hosts FATE logic, aka the mechanical combat system
 */
/obj/battlestorage
	var/battler1=null
	var/battler2=null
	var/battler3=null
	var/battler4=null

/atom/proc/DesignateSpots(var/mob/m,var/pcount,var/obj/Party/fighters,var/obj/battlestorage/battle)
	if(m.bposition==null)
		if(battle.battler1==null)
			m.bposition="battler1"
			battle.battler1=m
	if(m.bposition==null)
		if(battle.battler2==null)
			m.bposition="battler2"
			battle.battler2=m
	if(m.bposition==null)
		if(battle.battler3==null)
			m.bposition="battler3"
			battle.battler3=m
	if(m.bposition==null)
		if(battle.battler4==null)
			m.bposition="battler4"
			battle.battler4=m
	sleep(2)

/atom/proc/Unequipglobalmods(var/mob/a)
	for(var/obj/globalmod/gm in a.contents)
		if(gm.applied==1)
			gm.applied=0
			a.addstr -= gm.mstr
			a.adddex -= gm.mdex
			a.addcon -= gm.mcon
			a.addint -= gm.mint
			a.addwis -= gm.mwis
			a.addcha -= gm.mcha
			a.baseac -= gm.mac
			a.basedr -= gm.mdr
			a.critmod-=gm.mcritmod
			a.speedadd-=gm.mspd
			a.baserflx -= gm.mrflx
			a.basewill -= gm.mwill
			a.basefort -= gm.mfort
			//a.pab-=gm.mpab
			//a.pdb-=gm.mpdb
			//a.mdb-=gm.mmdb
			//a.mab-=gm.mmab
			a.pabadd-=gm.mpab
			a.pdbadd-=gm.mpdb
			a.mdbadd-=gm.mmdb
			a.mabadd-=gm.mmab
			a.baseacro-=gm.macro
			a.baseath-=gm.mathl
			a.basearc-=gm.march
			a.basedec-=gm.mdec
			a.basedung-=gm.mdung
			a.baseenchant-=gm.menc
			a.basein-=gm.minsi
			a.baseinv-=gm.minv
			a.basemagic-=gm.mmag
			a.basemagio-=gm.mmagi
			a.basemed-=gm.mmed
			a.basenat-=gm.mnat
			a.baseper-=gm.mperc
			a.basepers-=gm.mpers
			a.basestl-=gm.msth
			a.basethv-=gm.mthv
			a.basesurv-=gm.msurv
			a.Checkmod(1,a.str,a.addstr,a)
			a.Checkmod(2,a.dex,a.adddex,a)
			a.Checkmod(3,a.con,a.addcon,a)
			a.Checkmod(4,a.int,a.addint,a)
			a.Checkmod(5,a.wis,a.addwis,a)
			a.Checkmod(6,a.cha,a.addcha,a)
			a.Skillcheck(a)
			a.Carrycheck(a)
			a.Savecheck(a)
			a.ACcheck(a)
		a.send_chat("All Globalmods have been unequipped for FATE battle and log outs.", stream = "icout")

/atom/proc/Heal(var/mob/user,var/mob/target,var/obj/perk/spell)
	if(user.mp<=0)
		user.visible_message("[user] has attempted to use a Magic ability without any MP, and has wasted a turn!", stream = "icout")
		user.mp=0
		return
	var/range1=35
	var/range2=45
	var/classbonus=25
	if(spell.level==1)
		classbonus+=10
	if(spell.level==2)
		classbonus+=25
	if(spell.level==3)
		classbonus+=50
	if(spell.level==4)
		classbonus+=70
	if(spell.level==5)
		classbonus+=90
	if(spell.level==6)
		classbonus+=120
	if(user.job=="White Mage" || user.subjob=="White Mage")
		classbonus+=15
	if(user.job=="Astrologian" || user.subjob=="Astrologian")
		classbonus+=10
	if(user.job=="Scholar" || user.subjob=="Scholar")
		classbonus+=8
	if(user.role=="Physical Support" || user.role=="Magical Support")
		classbonus+=15
	var/heal=rand(range1,range2)
	var/healbonus=(user.chamod*2)
	var/healtotal=heal+healbonus+classbonus
	user.mp-=spell.mcost
	Healanimation(user,target)
	user.visible_message("<font color=[user.textcolor]><b>[user]</b></font> has healed <font color=[target.textcolor]><b>[target]</b></font> for <b><font color=#66F13D>[healtotal]</font></b> HP! | Cost: <b><font color=#8FE6D2>[spell.mcost] [spell.costtype]", stream = "icout")
	target.hp+=healtotal
	if(target.hp>target.mhp)
		target.hp=target.mhp
	if(spell.cleanse==1)
		target.status1=null
		target.totalstatus=0
		target.statusturns=0
	ShowHPBar(target)
	ShowMPBar(target)
	ShowSPBar(target)
	ShowHPBar(user)
	ShowMPBar(user)
	ShowSPBar(user)
	sleep(1)

/atom/proc/Enemyheal(var/obj/npc/user,var/obj/npc/target,var/obj/perk/spell)
	var/range1=10
	var/range2=35
	var/classbonus=0
	if(spell.level==1)
		classbonus+=10
	if(spell.level==2)
		classbonus+=25
	if(spell.level==3)
		classbonus+=35
	if(spell.level==4)
		classbonus+=45
	if(spell.level==5)
		classbonus+=55
	if(spell.level==6)
		classbonus+=85
	var/heal=rand(range1,range2)
	var/healbonus=(user.chamod*2)
	var/healtotal=heal+healbonus+classbonus
	user.mp-=spell.mcost
	Healanimation(user,target)
	user.visible_message("<font color=[user.textcolor]><b>[user]</b></font> has healed <font color=[target.textcolor]><b>[target]</b></font> for <b><font color=#66F13D>[healtotal]</font></b> HP! | Cost: <b><font color=#8FE6D2>[spell.mcost] [spell.costtype]", stream = "icout")
	target.hp+=healtotal
	if(target.hp>target.mhp)
		target.hp=target.mhp
	if(spell.cleanse==1)
		target.status1=null
		target.totalstatus=0
		target.statusturns=0
	ShowHPBar(target)
	ShowMPBar(target)
	ShowSPBar(target)
	ShowHPBar(user)
	ShowMPBar(user)
	ShowSPBar(user)
	sleep(12)

/atom/proc/Enemyability(var/obj/npc/user,var/mob/target,var/obj/perk/skill)
	var/aoresult=rand(1,20)
	var/aresult
	var/amod
	var/doresult
	var/dmod
	var/dresult
	var/abilitydamage
	var/statuschance=rand(1,100)
	if(skill.atype=="standard")
		amod=Checkdamtype(skill.damsource,user)
		if(skill.typing=="magical")
			aresult=aoresult+skill.addhit+amod+user.rankbonus+user.mab
		else
			aresult=aoresult+skill.addhit+amod+user.rankbonus+user.pab
		doresult=skill.raw_attack_damage_roll()
		dmod=Checkdamtype(skill.damsource,user)
		abilitydamage=skill.raw_attack_damage_roll()
		if(skill.typing=="magical")
			dresult=doresult+dmod+skill.adddam+user.mdb+skill.adddam+abilitydamage-target.basedr
		else
			dresult=doresult+dmod+skill.adddam+user.pdb+skill.adddam+abilitydamage-target.basedr
	if(skill.atype=="weapon")
		var/obj/item/Weapon/wepchoice = user.eweapon
		amod=Checkdamtype(wepchoice.damsource,user)
		if(skill.typing=="magical")
			aresult=aoresult+skill.addhit+amod+user.rankbonus+user.mab
		else
			aresult=aoresult+skill.addhit+amod+user.rankbonus+user.pab
		doresult=rand(wepchoice.range1,wepchoice.range2)
		dmod=Checkdamtype(skill.damsource,user)
		abilitydamage=skill.raw_attack_damage_roll()
		if(skill.typing=="magical")
			dresult=doresult+dmod+wepchoice.adddam+user.mdb+skill.adddam+abilitydamage-target.basedr
		else
			dresult=doresult+dmod+wepchoice.adddam+user.pdb+skill.adddam+abilitydamage-target.basedr
	if(skill.atype=="weaponsave")
		var/obj/item/Weapon/wepchoice = user.eweapon
		amod=Checkdamtype(wepchoice.damsource,user)
		if(skill.typing=="magical")
			aresult=skill.basecheck+amod+user.rankbonus+skill.addhit
		else
			aresult=skill.basecheck+amod+user.rankbonus+skill.addhit
		doresult=rand(wepchoice.range1,wepchoice.range2)
		dmod=Checkdamtype(skill.damsource,user)
		abilitydamage=skill.raw_attack_damage_roll()
		if(skill.typing=="magical")
			dresult=doresult+dmod+wepchoice.adddam+user.mdb+skill.adddam+abilitydamage-target.basedr
		else
			dresult=doresult+dmod+wepchoice.adddam+user.pdb+skill.adddam+abilitydamage-target.basedr
	if(skill.atype=="save")
		amod=Checkdamtype(skill.damsource,user)
		if(skill.typing=="magical")
			aresult=skill.basecheck+amod+user.rankbonus+skill.addhit
		else
			aresult=skill.basecheck+amod+user.rankbonus+skill.addhit
		doresult=skill.raw_attack_damage_roll()
		dmod=Checkdamtype(skill.damsource,user)
		abilitydamage=skill.raw_attack_damage_roll()
		if(skill.typing=="magical")
			dresult=doresult+dmod+skill.adddam+user.mdb+skill.adddam+abilitydamage-target.basedr
		else
			dresult=doresult+dmod+skill.adddam+user.pdb+skill.adddam+abilitydamage-target.basedr
	Enemyanimation(user,target,skill)
	user.visible_message("<font color=#F8E959><b>[user]</font> has used [skill] to attack <font color=[target.textcolor]><b>[target]</b>!!", stream = "icout")
	if(target.status1=="Squall" || target.status2=="Squall" || target.status3=="Squall")
		if(skill.element=="Fire")
			dresult+=20
			user.visible_message("The Squall effect grants this Fire attack 20 extra damage!", stream = "icout")
	if(target.status1=="Wet" || target.status2=="Wet" || target.status3=="Wet")
		if(skill.element=="Thunder")
			aresult+=5
			dresult+=15
			user.visible_message("The Wet effect grants this Thunder attack +5 to hit, and 15 extra damage!", stream = "icout")
	if(user.status1=="Heavy" || user.status2=="Heavy" || user.status3=="Heavy")
		dresult-=10
		aresult-=3
		user.visible_message("[user] is greatly burdened with how <b>Heavy</b> they are!", stream = "icout")
	if(user.status1=="Slow" || user.status2=="Slow" || user.status3=="Slow")
		aresult-=5
		AddStun(user)
		user.visible_message("[user] is afflicted with <b>Slow</b> and must skip their next action!", stream = "icout")
	if(user.status1=="Weakness" || user.status2=="Weakness" || user.status3=="Weakness")
		dresult-=15
		user.visible_message("[user]'s attack is greatly undermined with how <b>Weak</b> they're feeling!", stream = "icout")
	if(user.status1=="Paralyzed" || user.status2=="Paralyzed" || user.status3=="Paralyzed")
		var/paralyzechance=rand(30,100)
		if(paralyzechance>=70)
			user.visible_message("[user] is <b>Paralyzed</b> and failed to perform their action this turn!", stream = "icout")
			return
		else
	if(aresult<=0)
		aresult=0
	if(dresult<=0)
		dresult=0
	if(skill.typing=="physical")
		if(user.positivestatus1=="Bravery" || user.positivestatus2=="Bravery" || user.positivestatus3=="Bravery")
			dresult+=10
		if(target.positivestatus1=="Protect" || target.positivestatus2=="Protect" || target.positivestatus3=="Protect")
			dresult=round(dresult*0.5)
		if(target.positivestatus1=="Pailing" || target.positivestatus2=="Pailing" || target.positivestatus3=="Pailing")
			user.visible_message("[target]'s <b>Pailing</b> status effect has prevented an instance of Physical damage, and been consumed!", stream = "icout")
			dresult=0
			if(target.positivestatus1=="Pailing")
				target.positivestatus1=null
				positiveturns1=0
			if(target.positivestatus2=="Pailing")
				target.positivestatus2=null
				positiveturns2=0
			if(target.positivestatus3=="Pailing")
				target.positivestatus3=null
				positiveturns3=0
			if(dresult<=0)
				dresult=0
			if(dresult<=0)
				dresult=0
	if(skill.typing=="magical")
		if(user.positivestatus1=="Faith" || user.positivestatus2=="Faith" || user.positivestatus3=="Faith")
			dresult+=10
		if(target.positivestatus1=="Shell" || target.positivestatus2=="Shell" || target.positivestatus3=="Shell")
			dresult=round(dresult*0.5)
		if(target.positivestatus1=="Magic Barrier" || target.positivestatus2=="Magic Barrier" || target.positivestatus3=="Magic Barrier")
			user.visible_message("[target]'s <b>Magic Barrier</b> status effect has prevented an instance of Magical damage, and been consumed!", stream = "icout")
			dresult=0
			if(target.positivestatus1=="Magic Barrier")
				target.positivestatus1=null
				positiveturns1=0
			if(target.positivestatus2=="Magic Barrier")
				target.positivestatus2=null
				positiveturns2=0
			if(target.positivestatus3=="Magic Barrier")
				target.positivestatus3=null
				positiveturns3=0
			if(dresult<=0)
				dresult=0
	if(skill.element=="Fire")
		if(target.positivestatus1=="Barfire" || target.positivestatus2=="Barfire" || target.positivestatus3=="Barfire")
			user.visible_message("[target]'s <b>Barfire</b> status effect has prevented an instance of Fire damage, and been consumed!", stream = "icout")
			dresult=0
			if(target.positivestatus1=="Barfire")
				target.positivestatus1=null
				positiveturns1=0
			if(target.positivestatus2=="Barfire")
				target.positivestatus2=null
				positiveturns2=0
			if(target.positivestatus3=="Barfire")
				target.positivestatus3=null
				positiveturns3=0
	if(skill.element=="Water")
		if(target.positivestatus1=="Barwater" || target.positivestatus2=="Barwater" || target.positivestatus3=="Barwater")
			user.visible_message("[target]'s <b>Barwater</b> status effect has prevented an instance of Water damage, and been consumed!", stream = "icout")
			dresult=0
			if(target.positivestatus1=="Barwater")
				target.positivestatus1=null
				positiveturns1=0
			if(target.positivestatus2=="Barwater")
				target.positivestatus2=null
				positiveturns1=0
			if(target.positivestatus3=="Barwater")
				target.positivestatus3=null
				positiveturns1=0
	if(skill.element=="Ice")
		if(target.positivestatus1=="Barblizzard" || target.positivestatus2=="Barblizzard" || target.positivestatus3=="Barblizzard")
			user.visible_message("[target]'s <b>Barblizzard</b> status effect has prevented an instance of Ice damage, and been consumed!", stream = "icout")
			dresult=0
			if(target.positivestatus1=="Barblizzard")
				target.positivestatus1=null
				positiveturns1=0
			if(target.positivestatus2=="Barblizzard")
				target.positivestatus2=null
				positiveturns1=0
			if(target.positivestatus3=="Barblizzard")
				target.positivestatus3=null
				positiveturns1=0
	if(skill.element=="Thunder")
		if(target.positivestatus1=="Barthunder" || target.positivestatus2=="Barthunder" || target.positivestatus3=="Barthunder")
			user.visible_message("[target]'s <b>Barthunder</b> status effect has prevented an instance of Thunder damage, and been consumed!", stream = "icout")
			dresult=0
			if(target.positivestatus1=="Barthunder")
				target.positivestatus1=null
				positiveturns1=0
			if(target.positivestatus2=="Barthunder")
				target.positivestatus2=null
				positiveturns1=0
			if(target.positivestatus3=="Barthunder")
				target.positivestatus3=null
				positiveturns1=0
	if(skill.element=="Earth")
		if(target.positivestatus1=="Barstone" || target.positivestatus2=="Barstone" || target.positivestatus3=="Barstone")
			user.visible_message("[target]'s <b>Barblizzard</b> status effect has prevented an instance of Ice damage, and been consumed!", stream = "icout")
			dresult=0
			if(target.positivestatus1=="Barstone")
				target.positivestatus1=null
				positiveturns1=0
			if(target.positivestatus2=="Barstone")
				target.positivestatus2=null
				positiveturns1=0
			if(target.positivestatus3=="Barstone")
				target.positivestatus3=null
				positiveturns1=0
	if(skill.element=="Wind")
		if(target.positivestatus1=="Barwind" || target.positivestatus2=="Barwind" || target.positivestatus3=="Barwind")
			user.visible_message("[target]'s <b>Barblizzard</b> status effect has prevented an instance of Ice damage, and been consumed!", stream = "icout")
			dresult=0
			if(target.positivestatus1=="Barwind")
				target.positivestatus1=null
				positiveturns1=0
			if(target.positivestatus2=="Barwind")
				target.positivestatus2=null
				positiveturns1=0
			if(target.positivestatus3=="Barwind")
				target.positivestatus3=null
				positiveturns1=0
	//bubble procs after Protect, Shell, and Bar spells.
	if(target.positivestatus1=="Bubble" || target.positivestatus2=="Bubble" || target.positivestatus3=="Bubble")
		var/bubble=round(target.mhp*0.15)
		if(dresult<bubble)
			user.visible_message("<b>[target]'s</b> Bubble status effect has deflected and nullified [dresult] damage!!", stream = "icout")
		if(dresult>=bubble)
			user.visible_message("<b>[target]'s</b> Bubble has popped, but has absorbed [bubble] damage!!", stream = "icout")
			dresult-=bubble
			if(target.positivestatus1=="Bubble")
				target.positivestatus1=null
				positiveturns1=0
			if(target.positivestatus2=="Bubble")
				target.positivestatus2=null
				positiveturns2=0
			if(target.positivestatus3=="Bubble")
				target.positivestatus3=null
				positiveturns3=0
			if(dresult>=0)
				dresult=0
	if(user.positivestatus1=="Haste" || user.positivestatus2=="Haste" || user.positivestatus3=="Haste")
		aresult+=5
	//stoneskin procs after all other defensive boons do
	if(target.positivestatus1=="Stoneskin" || target.positivestatus2=="Stoneskin" || target.positivestatus3=="Stoneskin")
		dresult-=5
		target.stoneskindam+=dresult
		user.visible_message("<b>[target]'s</b> Stoneskin has absorbed 5 damage!!", stream = "icout")
		if(target.stoneskindam>=25)
			user.visible_message("<b>[target]'s</b> Stoneskin has shattered!!", stream = "icout")
			if(target.positivestatus1=="Stoneskin")
				target.positivestatus1=null
				positiveturns1=0
			if(target.positivestatus2=="Stoneskin")
				target.positivestatus2=null
				positiveturns2=0
			if(target.positivestatus3=="Stoneskin")
				target.positivestatus3=null
				positiveturns3=0
	if(target.job=="Paladin" || target.subjob=="Paladin")
		if(skill.element=="Holy")
			user.visible_message("<font color=[target.textcolor]><b>[target]</font> is a Paladin, and takes half damage from Holy abilities!", stream = "icout")
			dresult=round(dresult*0.5)
	if(target.job=="Dark Knight" || target.subjob=="Dark Knight")
		if(skill.element=="Dark" || skill.element=="Death" || skill.element=="Drain")
			user.visible_message("<font color=[target.textcolor]><b>[target]</font> is a Dark Knight, and takes half damage from Dark abilities!", stream = "icout")
			dresult=round(dresult*0.5)
	if(target.job=="Geomancer" || target.subjob=="Geomancer")
		if(skill.element=="Fire")
			user.visible_message("<font color=[target.textcolor]><b>[target]</font> is a Geomancer, and takes half damage from elemental abilities!", stream = "icout")
			dresult=round(dresult*0.5)
		if(skill.element=="Thunder")
			user.visible_message("<font color=[target.textcolor]><b>[target]</font> is a Geomancer, and takes half damage from elemental abilities!", stream = "icout")
			dresult=round(dresult*0.5)
		if(skill.element=="Water")
			user.visible_message("<font color=[target.textcolor]><b>[target]</font> is a Geomancer, and takes half damage from elemental abilities!", stream = "icout")
			dresult=round(dresult*0.5)
		if(skill.element=="Ice")
			user.visible_message("<font color=[target.textcolor]><b>[target]</font> is a Geomancer, and takes half damage from elemental abilities!", stream = "icout")
			dresult=round(dresult*0.5)
		if(skill.element=="Earth")
			user.visible_message("<font color=[target.textcolor]><b>[target]</font> is a Geomancer, and takes half damage from elemental abilities!", stream = "icout")
			dresult=round(dresult*0.5)
		if(skill.element=="Nature")
			user.visible_message("<font color=[target.textcolor]><b>[target]</font> is a Geomancer, and takes half damage from elemental abilities!", stream = "icout")
			dresult=round(dresult*0.5)
	if(aresult>=target.ac)
		user.visible_message("<b>To hit: [aresult] vs <b>[target.ac]</b> | It was a hit!! <b>[user]</b> has dealt <b><font color=#FEA14F>[dresult]</b></font> damage to <b>[target]</b>!!", stream = "icout")
		target.hp-=dresult
		var/drainvalue=round(dresult*0.5)
		if(skill.element=="Drain")
			user.visible_message("<font color=#F8E959><b>[user]</font> has drained <b>[target]</b>  for <font color=#93F752>[drainvalue] HP!", stream = "icout")
			user.hp+=drainvalue
			if(user.hp>=user.mhp)
				user.hp=user.mhp
		if(skill.element=="Osmose")
			user.visible_message("<font color=#F8E959><b>[user]</font> has drained <b>[target]</b>  for <font color=#4FC7ED>[drainvalue] MP and SP!", stream = "icout")
			user.mp+=drainvalue
			user.sp+=drainvalue
			if(user.mp>=user.mmp)
				user.mp=user.msp
			if(user.sp>=user.msp)
				user.sp=user.msp
		if(target.status1==null || target.status2==null || target.status3==null)
			if(skill.element=="Death")
				if(statuschance>=50)
					AddDoom(target)
			if(skill.element=="Time")
				if(statuschance>=70)
					AddStun(target)
				if(statuschance>=10)
					AddSlow(target)
			if(skill.element=="Earth")
				if(statuschance>=90)
					AddStun(target)
				if(statuschance>=50)
					AddHeavy(target)
			if(skill.element=="Metal")
				if(statuschance>=40)
					AddBleed(target)
			if(skill.element=="Fire")
				if(statuschance>=70)
					AddBurn(target)
			if(skill.element=="Nature")
				if(statuschance>=50)
					AddWeakness(target)
				if(statuschance>=80)
					AddPoison(target)
			if(skill.element=="Bio")
				if(statuschance>=60)
					AddPoison(target)
			if(skill.element=="Dark")
				if(statuschance>=70)
					AddBleed(target)
				if(statuschance>=20)
					AddWeakness(target)
			if(skill.element=="Water")
				if(statuschance>=20)
					AddWet(target)
			if(skill.element=="Wind")
				if(statuschance>=50)
					AddSquall(target)
			if(skill.element=="Ice")
				if(statuschance>=50)
					AddFrostbite(target)
			if(skill.element=="Thunder")
				if(statuschance>=50)
					AddWeakness(target)
				if(statuschance>=65)
					AddParalyzed(target)
				if(statuschance>=95)
					AddStun(target)
		if(target.retaliate==1)
			turnattack(target,user)
			target.retaliate=0
			if(target.hp<=0)
				Death(target)
				user.visible_message("[target] has reached 0 HP and is removed from battle!", stream = "icout")
				target.hp=0
		ShowHPBar(target)
	else
		Evade(target)
		user.visible_message("<b>To hit: [aresult] vs <b>[target.ac]</b> | It missed!", stream = "icout")
		if(target.retaliate==1)
			turnattack(target,user)
			target.retaliate=0
	ShowHPBar(target)
	ShowMPBar(target)
	ShowSPBar(target)
	ShowHPBar(user)
	ShowMPBar(user)
	ShowSPBar(user)

/atom/proc/turnattack(var/mob/user, var/obj/npc/target)
	var/aresult
	var/amod
	var/doresult
	var/dmod
	var/dresult
	var/extraanimation
	var/infusionpower
	var/obj/item/Weapon/wepchoice = user.righthand
	amod=Checkdamtype(wepchoice.damsource,user)
	if(wepchoice.typing=="magical")
		aresult=rand(1,20)+wepchoice.addhit+amod+user.rankbonus+user.mab+user.mabadd
	else
		aresult=rand(1,20)+wepchoice.addhit+amod+user.rankbonus+user.pab+user.pabadd
	doresult=rand(wepchoice.range1,wepchoice.range2)
	dmod=Checkdamtype(wepchoice.damsource,user)
	if(wepchoice.typing=="magical")
		dresult=doresult+dmod+wepchoice.adddam+user.mdb-target.basedr+user.mdbadd
	else
		dresult=doresult+dmod+wepchoice.adddam+user.pdb-target.basedr+user.pdbadd
	Playerattack(user,target)
	if(user.status1=="Heavy" || user.status2=="Heavy" || user.status3=="Heavy")
		dresult-=10
		aresult-=3
		user.visible_message("[user] is greatly burdened with how <b>Heavy</b> they are!", stream = "icout")
	if(user.status1=="Slow" || user.status2=="Slow" || user.status3=="Slow")
		aresult-=5
		AddStun(user)
		user.visible_message("[user] is afflicted with <b>Slow</b> and must skip their next action!", stream = "icout")
	if(user.status1=="Weakness" || user.status2=="Weakness" || user.status3=="Weakness")
		dresult-=15
		user.visible_message("[user]'s attack is greatly undermined with how <b>Weak</b> they're feeling!", stream = "icout")
	if(user.status1=="Paralyzed" || user.status2=="Paralyzed" || user.status3=="Paralyzed")
		var/paralyzechance=rand(30,100)
		if(paralyzechance>=70)
			user.visible_message("[user] is <b>Paralyzed</b> and failed to perform their action this turn!", stream = "icout")
			return
		else
	if(user.infusion=="Fire")
		infusionpower=user.rankbonus+user.wismod+user.chamod+user.intmod+user.mdb+user.pdb
		dresult+=infusionpower
		aresult+=user.mab
		aresult+=user.pab
		if(target.weakness=="Fire")
			dresult=round(dresult*1.5)
		extraanimation="Water"
	if(user.infusion=="Water")
		infusionpower=user.rankbonus+user.wismod+user.chamod+user.intmod+user.mdb+user.pdb
		dresult+=infusionpower
		aresult+=user.mab
		aresult+=user.pab
		if(target.weakness=="Water")
			dresult=round(dresult*1.5)
		extraanimation="Water"
	if(user.infusion=="Ice")
		infusionpower=user.rankbonus+user.wismod+user.chamod+user.intmod+user.mdb+user.pdb
		dresult+=infusionpower
		aresult+=user.mab
		aresult+=user.pab
		if(target.weakness=="Ice")
			dresult=round(dresult*1.5)
		extraanimation="Ice"
	if(user.infusion=="Thunder")
		infusionpower=user.rankbonus+user.wismod+user.chamod+user.intmod+user.mdb+user.pdb
		dresult+=infusionpower
		aresult+=user.mab
		aresult+=user.pab
		if(target.weakness=="Thunder")
			dresult=round(dresult*1.5)
		extraanimation="Thunder"
	if(user.infusion=="Dark")
		infusionpower=user.rankbonus+user.wismod+user.chamod+user.intmod+user.mdb+user.pdb
		dresult+=infusionpower
		aresult+=user.mab
		aresult+=user.pab
		if(target.weakness=="Dark")
			dresult=round(dresult*1.5)
		extraanimation="Dark"
	if(user.infusion=="Holy")
		infusionpower=user.rankbonus+user.wismod+user.chamod+user.intmod+user.mdb+user.pdb
		dresult+=infusionpower
		aresult+=user.mab
		aresult+=user.pab
		if(target.weakness=="Holy")
			dresult=round(dresult*1.5)
		extraanimation="Holy"
	if(user.infusion=="Wind")
		infusionpower=user.rankbonus+user.wismod+user.chamod+user.intmod+user.mdb+user.pdb
		dresult+=infusionpower
		aresult+=user.mab
		aresult+=user.pab
		if(target.weakness=="Wind")
			dresult=round(dresult*1.5)
		extraanimation="Wind"
	if(user.infusion=="Flare")
		infusionpower=user.rankbonus+user.wismod+user.chamod+user.intmod+user.mdb+user.pdb
		dresult+=infusionpower
		aresult+=user.mab
		aresult+=user.pab
		if(target.weakness=="Flare")
			dresult=round(dresult*1.5)
		extraanimation="Flare"
	if(extraanimation=="Fire")
		var/obj/perk/Abilities/BlackMagic/Flame/Fire/b=new
		Spellbladeanimation(user,target,b)
	if(extraanimation=="Water")
		var/obj/perk/Abilities/BlackMagic/Hydro/Water/b=new
		Spellbladeanimation(user,target,b)
	if(extraanimation=="Ice")
		var/obj/perk/Abilities/BlackMagic/Ice/Blizzard/b=new
		Spellbladeanimation(user,target,b)
	if(extraanimation=="Thunder")
		var/obj/perk/Abilities/BlackMagic/Lightning/Thunder/b=new
		Spellbladeanimation(user,target,b)
	if(extraanimation=="Dark")
		var/obj/perk/Abilities/ArcaneMagic/Darkness/Dark/b=new
		Spellbladeanimation(user,target,b)
	if(extraanimation=="Holy")
		var/obj/perk/Abilities/WhiteMagic/Holy/Dia/b=new
		Spellbladeanimation(user,target,b)
	if(extraanimation=="Wind")
		var/obj/perk/Abilities/WhiteMagic/Wind/Aero/b=new
		Spellbladeanimation(user,target,b)
	if(extraanimation=="Flare")
		var/obj/perk/Abilities/BlackMagic/Energy/Flare/b=new
		Spellbladeanimation(user,target,b)
	if(aresult<=0)
		aresult=0
	if(dresult<=0)
		dresult=0
	if(wepchoice.typing=="physical")
		if(user.positivestatus1=="Bravery" || user.positivestatus2=="Bravery" || user.positivestatus3=="Bravery")
			dresult+=10
		if(target.positivestatus1=="Protect" || target.positivestatus2=="Protect" || target.positivestatus3=="Protect")
			dresult=round(dresult*0.5)
		if(target.positivestatus1=="Pailing" || target.positivestatus2=="Pailing" || target.positivestatus3=="Pailing")
			user.visible_message("[target]'s <b>Pailing</b> status effect has prevented an instance of Physical damage, and been consumed!", stream = "icout")
			dresult=0
			if(target.positivestatus1=="Pailing")
				target.positivestatus1=null
				positiveturns1=0
			if(target.positivestatus2=="Pailing")
				target.positivestatus2=null
				positiveturns2=0
			if(target.positivestatus3=="Pailing")
				target.positivestatus3=null
				positiveturns3=0
			if(dresult<=0)
				dresult=0
			if(dresult<=0)
				dresult=0
	if(wepchoice.typing=="magical")
		if(user.positivestatus1=="Faith" || user.positivestatus2=="Faith" || user.positivestatus3=="Faith")
			dresult+=10
		if(target.positivestatus1=="Shell" || target.positivestatus2=="Shell" || target.positivestatus3=="Shell")
			dresult=round(dresult*0.5)
		if(target.positivestatus1=="Magic Barrier" || target.positivestatus2=="Magic Barrier" || target.positivestatus3=="Magic Barrier")
			user.visible_message("[target]'s <b>Magic Barrier</b> status effect has prevented an instance of Magical damage, and been consumed!", stream = "icout")
			dresult=0
			if(target.positivestatus1=="Magic Barrier")
				target.positivestatus1=null
				positiveturns1=0
			if(target.positivestatus2=="Magic Barrier")
				target.positivestatus2=null
				positiveturns2=0
			if(target.positivestatus3=="Magic Barrier")
				target.positivestatus3=null
				positiveturns3=0
			if(dresult<=0)
				dresult=0
	if(target.positivestatus1=="Bubble" || target.positivestatus2=="Bubble" || target.positivestatus3=="Bubble")
		var/bubble=round(target.mhp*0.15)
		if(dresult<bubble)
			user.visible_message("<b>[target]'s</b> Bubble status effect has deflected and nullified [dresult] damage!!", stream = "icout")
			dresult=0
		if(dresult>=bubble)
			user.visible_message("<b>[target]'s</b> Bubble has popped, but has absorbed [bubble] damage!!", stream = "icout")
			dresult-=bubble
			if(target.positivestatus1=="Bubble")
				target.positivestatus1=null
				positiveturns1=0
			if(target.positivestatus2=="Bubble")
				target.positivestatus2=null
				positiveturns2=0
			if(target.positivestatus3=="Bubble")
				target.positivestatus3=null
				positiveturns3=0
			if(dresult>=0)
				dresult=0
	if(user.positivestatus1=="Haste" || user.positivestatus2=="Haste" || user.positivestatus3=="Haste")
		aresult+=10
		dresult+=15
	//stoneskin procs after all other defensive boons do
	if(target.positivestatus1=="Stoneskin" || target.positivestatus2=="Stoneskin" || target.positivestatus3=="Stoneskin")
		dresult-=5
		target.stoneskindam+=dresult
		user.visible_message("<b>[target]'s</b> Stoneskin has absorbed 5 damage!!", stream = "icout")
		if(target.stoneskindam>=25)
			user.visible_message("<b>[target]'s</b> Stoneskin has shattered!!", stream = "icout")
			if(target.positivestatus1=="Stoneskin")
				target.positivestatus1=null
				positiveturns1=0
			if(target.positivestatus2=="Stoneskin")
				target.positivestatus2=null
				positiveturns2=0
			if(target.positivestatus3=="Stoneskin")
				target.positivestatus3=null
				positiveturns3=0
	user.visible_message("<font color=[user.textcolor]><b>[user]</font> has used <font color=[user.textcolor]><b>[wepchoice]<b></b></font> to attack <b>[target]</b>!!", stream = "icout")
	if(aresult>=target.ac)
		user.visible_message("<b>To hit: [aresult] vs <b>[target.ac]</b> | It was a hit!! [user] has dealt [dresult] damage to [target]!!", stream = "icout")
		target.hp-=dresult
		if(target.hp<=0)
			Death(target)
			target.icon=null
			target.overlays=null
			user.visible_message("[target] has reached 0 HP and is removed from battle!", stream = "icout")
			target.hp=0
		if(target.special=="Bomb")
			var/addlash=round(target.hp * 0.5)
			var/backlash=dresult+addlash
			user.visible_message("[target] exploded on contact, dealing [backlash] recoil damage to its attacker!", stream = "icout")
			target.hp=0
			Death(target)
			target.icon=null
			target.overlays=null
			Burn(user)
			user.hp-=backlash
			if(user.hp<=0)
				Death(user)
				user.hp=0
			ShowHPBar(user)
			if(target.hp<=0)
				target.overlays=null
	else
		Evade(target)
		user.visible_message("<b>To hit: [aresult] vs <b>[target.ac]</b> | It missed!", stream = "icout")
	ShowHPBar(target)
	ShowMPBar(target)
	ShowSPBar(target)
	ShowHPBar(user)
	ShowMPBar(user)
	ShowSPBar(user)
	if(target.retaliate==1)
		turnattack(target,user)
		target.retaliate=0
	if(target.hp<=0)
		target.overlays=null

/atom/proc/TurnAbility(var/mob/user,var/obj/npc/target,var/obj/perk/skill)
	if(skill.costtype=="Mana")
		if(user.mp<=0)
			user.visible_message("[user] has attempted to use a Magic ability without any MP, and has wasted a turn!", stream = "icout")
			user.mp=0
			return
	if(skill.costtype=="Stamina")
		if(user.sp<=0)
			user.visible_message("[user] has attempted to use a Physical ability without any SP, and has wasted a turn!", stream = "icout")
			user.sp=0
			return
	var/aresult
	var/amod
	var/doresult
	var/dmod
	var/dresult
	var/abilitydamage
	var/statuschance=rand(1,100)
	if(skill.atype=="standard")
		amod=Checkdamtype(skill.damsource,user)
		if(skill.typing=="magical")
			aresult=rand(1,20)+skill.addhit+amod+user.rankbonus+user.mab+user.mabadd
		else
			aresult=rand(1,20)+skill.addhit+amod+user.rankbonus+user.pab+user.pabadd
		doresult=skill.raw_attack_damage_roll()
		dmod=Checkdamtype(skill.damsource,user)
		abilitydamage=skill.raw_attack_damage_roll()
		if(skill.typing=="magical")
			dresult=doresult+dmod+skill.adddam+user.mdb+skill.adddam+abilitydamage-target.basedr+user.mdbadd
		else
			dresult=doresult+dmod+skill.adddam+user.pdb+skill.adddam+abilitydamage-target.basedr+user.pdbadd
	if(skill.atype=="weapon")
		var/obj/item/Weapon/wepchoice = user.righthand
		amod=Checkdamtype(wepchoice.damsource,user)
		if(skill.typing=="magical")
			aresult=rand(1,20)+skill.addhit+amod+user.rankbonus+user.mab+usr.mabadd
		else
			aresult=rand(1,20)+skill.addhit+amod+user.rankbonus+user.pab+user.pabadd
		doresult=rand(wepchoice.range1,wepchoice.range2)
		dmod=Checkdamtype(skill.damsource,user)
		abilitydamage=skill.raw_attack_damage_roll()
		if(skill.typing=="magical")
			dresult=doresult+dmod+wepchoice.adddam+user.mdb+skill.adddam+abilitydamage-target.basedr+user.mdbadd
		else
			dresult=doresult+dmod+wepchoice.adddam+user.pdb+skill.adddam+abilitydamage-target.basedr+user.pdbadd
	if(skill.atype=="weaponsave")
		var/obj/item/Weapon/wepchoice = user.righthand
		amod=Checkdamtype(wepchoice.damsource,user)
		if(skill.typing=="magical")
			aresult=skill.basecheck+amod+user.rankbonus+skill.addhit+user.mabadd
		else
			aresult=skill.basecheck+amod+user.rankbonus+skill.addhit+user.pabadd
		doresult=rand(wepchoice.range1,wepchoice.range2)
		dmod=Checkdamtype(skill.damsource,user)
		abilitydamage=skill.raw_attack_damage_roll()
		if(skill.typing=="magical")
			dresult=doresult+dmod+wepchoice.adddam+user.mdb+skill.adddam+abilitydamage-target.basedr+user.mdbadd
		else
			dresult=doresult+dmod+wepchoice.adddam+user.pdb+skill.adddam+abilitydamage-target.basedr+user.pdbadd
	if(skill.atype=="save")
		amod=Checkdamtype(skill.damsource,user)
		if(skill.typing=="magical")
			aresult=skill.basecheck+amod+user.rankbonus+skill.addhit+user.mabadd
		else
			aresult=skill.basecheck+amod+user.rankbonus+skill.addhit+user.pabadd
		doresult=skill.raw_attack_damage_roll()
		dmod=Checkdamtype(skill.damsource,user)
		abilitydamage=skill.raw_attack_damage_roll()
		if(skill.typing=="magical")
			dresult=doresult+dmod+skill.adddam+user.mdb+skill.adddam+abilitydamage-target.basedr+user.mdbadd
		else
			dresult=doresult+dmod+skill.adddam+user.pdb+skill.adddam+abilitydamage-target.basedr+user.pdbadd
	if(skill.rank=="D")
		aresult+=4
		dresult+=10
	if(skill.rank=="C")
		aresult+=6
		dresult+=15
	if(skill.rank=="B")
		aresult+=9
		dresult+=20
	if(skill.rank=="A")
		aresult+=12
		dresult+=30
	if(skill.rank=="S")
		aresult+=20
		dresult+=40
	if(skill.name=="Jump"||skill.name=="Drake Hop"||skill.name=="Hyper Jump"||skill.name=="Sky Grinder"||skill.name=="Falling Meteor")// This is aprt of the Dragoon Rework. Dragoon skills max jump height scales on Speed. So this is to emulate that damage increase in fates.
		dresult+=(user.speed+user.speedadd)*4
	Playeranimation(user,target,skill)
	user.visible_message("<font color=#F8E959><b>[user]</font> has used [skill] to attack [target]!!", stream = "icout")
	var/drainvalue=round(dresult*0.5)
	if(skill.element==target.weakness)
		dresult=round(dresult*1.5)
		user.visible_message("<b>[target]</b> is weak to <b>[skill.element], and takes 50% more damage!</b>", stream = "icout")
	if(skill.element==target.resistance)
		dresult=round(dresult*0.5)
		user.visible_message("<b>[target]</b> is resistant to <b>[skill.element], and takes only half damage!</b>", stream = "icout")
	if(target.status1=="Squall" || target.status2=="Squall" || target.status3=="Squall")
		if(skill.element=="Fire")
			dresult+=20
			user.visible_message("The Squall effect grants this Fire attack 20 extra damage!", stream = "icout")
	if(target.status1=="Wet" || target.status2=="Wet" || target.status3=="Wet")
		if(skill.element=="Thunder")
			aresult+=5
			dresult+=15
			user.visible_message("The Wet effect grants this Thunder attack +5 to hit, and 15 extra damage!", stream = "icout")
	if(user.status1=="Heavy" || user.status2=="Heavy" || user.status3=="Heavy")
		dresult-=10
		aresult-=3
		user.visible_message("[user] is greatly burdened with how <b>Heavy</b> they are!", stream = "icout")
	if(user.status1=="Slow" || user.status2=="Slow" || user.status3=="Slow")
		aresult-=5
		AddStun(user)
		user.visible_message("[user] is afflicted with <b>Slow</b> and must skip their next action!", stream = "icout")
	if(user.status1=="Weakness" || user.status2=="Weakness" || user.status3=="Weakness")
		dresult-=15
		user.visible_message("[user]'s attack is greatly undermined with how <b>Weak</b> they're feeling!", stream = "icout")
	if(user.status1=="Paralyzed" || user.status2=="Paralyzed" || user.status3=="Paralyzed")
		var/paralyzechance=rand(30,100)
		if(paralyzechance>=70)
			user.visible_message("[user] is <b>Paralyzed</b> and failed to perform their action this turn!", stream = "icout")
			return
		else
	if(aresult<=0)
		aresult=0
	if(dresult<=0)
		dresult=0
	if(skill.typing=="physical")
		if(user.positivestatus1=="Bravery" || user.positivestatus2=="Bravery" || user.positivestatus3=="Bravery")
			dresult+=10
		if(target.positivestatus1=="Protect" || target.positivestatus2=="Protect" || target.positivestatus3=="Protect")
			dresult-=10
		if(target.positivestatus1=="Pailing" || target.positivestatus2=="Pailing" || target.positivestatus3=="Pailing")
			user.visible_message("[target]'s <b>Pailing</b> status effect has prevented an instance of Physical damage, and been consumed!", stream = "icout")
			dresult=0
			if(target.positivestatus1=="Pailing")
				target.positivestatus1=null
				positiveturns1=0
			if(target.positivestatus2=="Pailing")
				target.positivestatus2=null
				positiveturns2=0
			if(target.positivestatus3=="Pailing")
				target.positivestatus3=null
				positiveturns3=0
			if(dresult<=0)
				dresult=0
			if(dresult<=0)
				dresult=0
	if(skill.typing=="magical")
		if(user.positivestatus1=="Faith" || user.positivestatus2=="Faith" || user.positivestatus3=="Faith")
			dresult+=10
		if(target.positivestatus1=="Shell" || target.positivestatus2=="Shell" || target.positivestatus3=="Shell")
			dresult-=10
		if(target.positivestatus1=="Magic Barrier" || target.positivestatus2=="Magic Barrier" || target.positivestatus3=="Magic Barrier")
			user.visible_message("[target]'s <b>Magic Barrier</b> status effect has prevented an instance of Magical damage, and been consumed!", stream = "icout")
			dresult=0
			if(target.positivestatus1=="Magic Barrier")
				target.positivestatus1=null
				positiveturns1=0
			if(target.positivestatus2=="Magic Barrier")
				target.positivestatus2=null
				positiveturns2=0
			if(target.positivestatus3=="Magic Barrier")
				target.positivestatus3=null
				positiveturns3=0
			if(dresult<=0)
				dresult=0
	if(skill.element=="Fire")
		if(target.positivestatus1=="Barfire" || target.positivestatus2=="Barfire" || target.positivestatus3=="Barfire")
			user.visible_message("[target]'s <b>Barfire</b> status effect has prevented an instance of Fire damage, and been consumed!", stream = "icout")
			dresult=0
			if(target.positivestatus1=="Barfire")
				target.positivestatus1=null
				positiveturns1=0
			if(target.positivestatus2=="Barfire")
				target.positivestatus2=null
				positiveturns2=0
			if(target.positivestatus3=="Barfire")
				target.positivestatus3=null
				positiveturns3=0
	if(skill.element=="Water")
		if(target.positivestatus1=="Barwater" || target.positivestatus2=="Barwater" || target.positivestatus3=="Barwater")
			user.visible_message("[target]'s <b>Barwater</b> status effect has prevented an instance of Water damage, and been consumed!", stream = "icout")
			dresult=0
			if(target.positivestatus1=="Barwater")
				target.positivestatus1=null
				positiveturns1=0
			if(target.positivestatus2=="Barwater")
				target.positivestatus2=null
				positiveturns1=0
			if(target.positivestatus3=="Barwater")
				target.positivestatus3=null
				positiveturns1=0
	if(skill.element=="Ice")
		if(target.positivestatus1=="Barblizzard" || target.positivestatus2=="Barblizzard" || target.positivestatus3=="Barblizzard")
			user.visible_message("[target]'s <b>Barblizzard</b> status effect has prevented an instance of Ice damage, and been consumed!", stream = "icout")
			dresult=0
			if(target.positivestatus1=="Barblizzard")
				target.positivestatus1=null
				positiveturns1=0
			if(target.positivestatus2=="Barblizzard")
				target.positivestatus2=null
				positiveturns1=0
			if(target.positivestatus3=="Barblizzard")
				target.positivestatus3=null
				positiveturns1=0
	if(skill.element=="Thunder")
		if(target.positivestatus1=="Barthunder" || target.positivestatus2=="Barthunder" || target.positivestatus3=="Barthunder")
			user.visible_message("[target]'s <b>Barthunder</b> status effect has prevented an instance of Thunder damage, and been consumed!", stream = "icout")
			dresult=0
			if(target.positivestatus1=="Barthunder")
				target.positivestatus1=null
				positiveturns1=0
			if(target.positivestatus2=="Barthunder")
				target.positivestatus2=null
				positiveturns1=0
			if(target.positivestatus3=="Barthunder")
				target.positivestatus3=null
				positiveturns1=0
	if(skill.element=="Earth")
		if(target.positivestatus1=="Barstone" || target.positivestatus2=="Barstone" || target.positivestatus3=="Barstone")
			user.visible_message("[target]'s <b>Barblizzard</b> status effect has prevented an instance of Ice damage, and been consumed!", stream = "icout")
			dresult=0
			if(target.positivestatus1=="Barstone")
				target.positivestatus1=null
				positiveturns1=0
			if(target.positivestatus2=="Barstone")
				target.positivestatus2=null
				positiveturns1=0
			if(target.positivestatus3=="Barstone")
				target.positivestatus3=null
				positiveturns1=0
	if(skill.element=="Wind")
		if(target.positivestatus1=="Barwind" || target.positivestatus2=="Barwind" || target.positivestatus3=="Barwind")
			user.visible_message("[target]'s <b>Barblizzard</b> status effect has prevented an instance of Ice damage, and been consumed!", stream = "icout")
			dresult=0
			if(target.positivestatus1=="Barwind")
				target.positivestatus1=null
				positiveturns1=0
			if(target.positivestatus2=="Barwind")
				target.positivestatus2=null
				positiveturns1=0
			if(target.positivestatus3=="Barwind")
				target.positivestatus3=null
				positiveturns1=0
	//bubble procs after Protect, Shell, and Bar spells.
	if(target.positivestatus1=="Bubble" || target.positivestatus2=="Bubble" || target.positivestatus3=="Bubble")
		var/bubble=round(target.mhp*0.15)
		if(dresult<bubble)
			user.visible_message("<b>[target]'s</b> Bubble status effect has deflected and nullified [dresult] damage!!", stream = "icout")
			dresult=0
		if(dresult>=bubble)
			user.visible_message("<b>[target]'s</b> Bubble has popped, but has absorbed [bubble] damage!!", stream = "icout")
			dresult-=bubble
			if(target.positivestatus1=="Bubble")
				target.positivestatus1=null
				positiveturns1=0
			if(target.positivestatus2=="Bubble")
				target.positivestatus2=null
				positiveturns2=0
			if(target.positivestatus3=="Bubble")
				target.positivestatus3=null
				positiveturns3=0
			if(dresult>=0)
				dresult=0
	if(user.positivestatus1=="Haste" || user.positivestatus2=="Haste" || user.positivestatus3=="Haste")
		aresult+=5
		turnattack(user,target)
		sleep(4)
	//stoneskin procs after all other defensive boons do
	if(target.positivestatus1=="Stoneskin" || target.positivestatus2=="Stoneskin" || target.positivestatus3=="Stoneskin")
		dresult-=5
		target.stoneskindam+=dresult
		user.visible_message("<b>[target]'s</b> Stoneskin has absorbed 5 damage!!", stream = "icout")
		if(target.stoneskindam>=25)
			user.visible_message("<b>[target]'s</b> Stoneskin has shattered!!", stream = "icout")
			if(target.positivestatus1=="Stoneskin")
				target.positivestatus1=null
				positiveturns1=0
			if(target.positivestatus2=="Stoneskin")
				target.positivestatus2=null
				positiveturns2=0
			if(target.positivestatus3=="Stoneskin")
				target.positivestatus3=null
				positiveturns3=0

	if(aresult>=target.ac)
		user.visible_message("<b>To hit: [aresult] vs <b>[target.ac]</b> | It was a hit!! [user] has dealt [dresult] damage to [target]!!", stream = "icout")
		target.hp-=dresult
		if(skill.element=="Drain")
			user.visible_message("<font color=#F8E959><b>[user]</font> has drained <b>[target]</b>  for <font color=#93F752>[drainvalue] HP!", stream = "icout")
			user.hp+=drainvalue
			if(user.hp>=user.mhp)
				user.hp=user.mhp
		if(skill.element=="Osmose")
			user.visible_message("<font color=#F8E959><b>[user]</font> has drained <b>[target]</b> for <font color=#4FC7ED>[drainvalue] MP and SP!", stream = "icout")
			user.mp+=drainvalue
			user.sp+=drainvalue
			if(user.mp>=user.mmp)
				user.mp=user.mmp
			if(user.sp>=user.msp)
				user.sp=user.sp
		if(target.status1==null || target.status2==null || target.status3==null)
			if(skill.element=="Death")
				if(statuschance>=50)
					AddDoom(target)
			if(skill.element=="Time")
				if(statuschance>=70)
					AddStun(target)
				if(statuschance>=10)
					AddSlow(target)
			if(skill.element=="Earth")
				if(statuschance>=90)
					AddStun(target)
				if(statuschance>=50)
					AddHeavy(target)
			if(skill.element=="Metal")
				if(statuschance>=40)
					AddBleed(target)
			if(skill.element=="Fire")
				if(statuschance>=70)
					AddBurn(target)
			if(skill.element=="Nature")
				if(statuschance>=50)
					AddWeakness(target)
				if(statuschance>=80)
					AddPoison(target)
			if(skill.element=="Bio")
				if(statuschance>=60)
					AddPoison(target)
			if(skill.element=="Dark")
				if(statuschance>=70)
					AddBleed(target)
				if(statuschance>=20)
					AddWeakness(target)
			if(skill.element=="Water")
				if(statuschance>=20)
					AddWet(target)
			if(skill.element=="Wind")
				if(statuschance>=50)
					AddSquall(target)
			if(skill.element=="Ice")
				if(statuschance>=50)
					AddFrostbite(target)
			if(skill.element=="Thunder")
				if(statuschance>=50)
					AddWeakness(target)
				if(statuschance>=65)
					AddParalyzed(target)
				if(statuschance>=95)
					AddStun(target)
		if(target.hp<=0)
			Death(target)
			target.icon=null
			target.overlays=null
			user.visible_message("[target] has reached 0 HP and is removed from battle!", stream = "icout")
			target.hp=0
		if(target.special=="Bomb")
			var/addlash=round(target.hp * 0.5)
			var/backlash=dresult+addlash
			user.visible_message("[target] exploded on contact, dealing [backlash] recoil damage to its attacker!", stream = "icout")
			target.hp=0
			Death(target)
			target.icon=null
			target.overlays=null
			Burn(user)
			user.hp-=backlash
			if(user.hp<=0)
				Death(user)
				user.hp=0
				user.overlays=null
			sleep(4)
	else
		Evade(target)
		user.visible_message("<b>To hit: [aresult] vs <b>[target.ac]</b> It missed!", stream = "icout")
	if(skill.costtype=="Stamina")
		user.visible_message("[user] has drained [skill.mcost] SP!", stream = "icout")
		user.sp-=skill.mcost
	if(skill.costtype=="Mana")
		user.visible_message("[user] has drained [skill.mcost] MP!", stream = "icout")
		user.mp-=skill.mcost
	if(skill.costtype!="Mana"&& skill.costtype!="Stamina")
		user.visible_message("[user] has drained [skill.mcost] MP!", stream = "icout")
		user.mp-=skill.mcost
	ShowHPBar(target)
	ShowMPBar(target)
	ShowSPBar(target)
	ShowHPBar(user)
	ShowMPBar(user)
	ShowSPBar(user)
	if(target.hp<=0)
		target.overlays=null
	sleep(4)

/atom/proc/Victory(var/obj/Party/party,var/obj/FATECrystal/fate)
	for(var/mob/M in hearers(20, fate))
		M << sound(null, channel = 1)
		M << sound('Audio/Fanfare.wav', channel = 1)
	sleep(22)
	var/loot_pack
	for(var/obj/FATEs/quest in world)
		if("[quest.FATEID]"=="[party.FATEID]")
			loot_pack = quest.loot_pack
			del quest
	fate.occupied=0
	fate.FATEID=null
	fate.icon_state="inactive"
	for(var/mob/m in party.members)
		sleep(2)
		m.bposition=null
		UpdateArea(m)
		if(ispath(loot_pack, /datum/prototype/struct/loot_pack))
			var/datum/prototype/struct/loot_pack/giving = new loot_pack
			var/list/paths = giving.flatten()
			for(var/path in paths)
				m.legacy_inventory_ingest(path, paths[path], "FATE reward: +")
		if(m.hp<=0)
			m.hp=0
		m.battler=0
		m.dailyfates+=1
		if(m.dailyfates>=m.maxfates)
			m.FATEcooldown=1
		m.statusturns=0 //The following lines of code turn off all status effects.
		m.status2turns=0
		m.status3turns=0
		m.positiveturns1=0
		m.positiveturns2=0
		m.positiveturns3=0
		m.status1=null
		m.status2=null
		m.status3=null
		m.positivestatus1=null
		m.positivestatus2=null
		m.positivestatus3=null
	party.currentFATE=null
	party.FATEID=null

/atom/proc/Defeat(var/obj/Party/party,var/obj/FATECrystal/fate)
	for(var/mob/M in hearers(20, fate))
		M << sound(null,channel=1)
	sleep(4)
	for(var/obj/FATEs/quest in world)
		if(quest.FATEID==fate.FATEID)
			del quest
	fate.occupied=0
	fate.FATEID=null
	fate.icon_state=null
	for(var/obj/prop/a in view(40))
		del a
	for(var/mob/m in party.members)
		UpdateArea(m)
		m.bposition=null
		m<<sound(null)
		//m.FATEcooldown=1
		m.battler=0
		m.statusturns=0 //The following lines of code turn off all status effects.
		m.status2turns=0
		m.status3turns=0
		m.positiveturns1=0
		m.positiveturns2=0
		m.positiveturns3=0
		m.status1=null
		m.status2=null
		m.status3=null
		m.positivestatus1=null
		m.positivestatus2=null
		m.positivestatus3=null
		if(m.hp<=0)
			m.hp=0
		ShowHPBar(m)
	party.currentFATE=null
	party.FATEID=null

/atom/proc/Startbattle(var/mob/starter,var/obj/npc/enemy,var/obj/Party/fightparty)
	set waitfor=0
	var/obj/battlestorage/batstorage=new
	var/list/battlelist=new
	var/list/enemylist=new
	var/mob/battler1=null
	var/mob/battler2=null
	var/mob/battler3=null
	var/mob/battler4=null
	var/obj/perk/MonsterAbilities/Monster/PhysicalAttack/gs=new
	var/battler1state
	var/battler2state
	var/battler3state
	var/battler4state
	var/enemystate=0
	var/enemy2state=0
	var/enemy3state=0
	var/enemy4state=0
	var/b1counted=0
	var/b2counted=0
	var/b3counted=0
	var/b4counted=0
	var/e1counted=0
	var/e2counted=0
	var/e3counted=0
	var/e4counted=0
	var/battlers
	var/enemies
	var/enemyalive
	var/list/attacklist1=list()
	var/list/attacklist2=list()
	var/list/attacklist3=list()
	var/list/attacklist4=list()
	var/list/pattacklist1=list()
	var/list/pattacklist2=list()
	var/list/pattacklist3=list()
	var/list/pattacklist4=list()
	var/list/heallist1=list()
	var/list/heallist2=list()
	var/list/heallist3=list()
	var/list/heallist4=list()
	var/list/greenlist1=list()
	var/list/greenlist2=list()
	var/list/greenlist3=list()
	var/list/greenlist4=list()
	var/list/revivelist1=list()
	var/list/revivelist2=list()
	var/list/revivelist3=list()
	var/list/revivelist4=list()
	var/list/summonlist1=list()
	var/list/summonlist2=list()
	var/list/summonlist3=list()
	var/list/summonlist4=list()
	var/list/partylist=new
	var/obj/perk/attackchoice
	var/obj/perk/healchoice
	var/maxbattlers=0
	var/healer1=0
	var/healer2=0
	var/healer3=0
	var/healer4=0
	var/green1=0
	var/green2=0
	var/green3=0
	var/green4=0
	var/revive1=0
	var/revive2=0
	var/revive3=0
	var/revive4=0
	var/summon1=0
	var/summon2=0
	var/summon3=0
	var/summon4=0
	var/maxenemies=0
	var/pcount=0
	var/obj/npc/enemy2
	var/obj/npc/enemy3
	var/obj/npc/enemy4
	InitializeEnemy(enemy)
	Spawnextras(enemy)
	enemy2=enemy.enemy2
	enemy3=enemy.enemy3
	enemy4=enemy.enemy4
	enemylist+=enemy
	enemystate=1
	enemies=1
	enemyalive=1
	enemy.battling=1
	enemy2.battling=1
	enemy3.battling=1
	enemy4.battling=1
	enemy2.FATENpc=1
	enemy3.FATENpc=1
	enemy4.FATENpc=1
	maxenemies=1
	pcount=0
	if(enemy.encountersize>=2)
		enemy2.x=enemy.x+3
		enemy2.y=enemy.y
		enemy2.z=enemy.z
		enemy2.name="[enemy2.name] 2"
		enemy2state=1
		enemylist+=enemy2
		enemy2.contents+=gs
		enemies+=1
		maxenemies=2
	if(enemy.encountersize>=3)
		enemy3.x=enemy.x
		enemy3.y=enemy.y-3
		enemy3.z=enemy.z
		enemy3.name="[enemy3.name] 3"
		enemy3state=1
		enemylist+=enemy3
		enemy3.contents+=gs
		enemies+=1
		maxenemies=3
	if(enemy.encountersize>=4)
		enemy4.x=enemy.x-2
		enemy4.y=enemy.y+2
		enemy4.z=enemy.z
		enemy4.name="[enemy4.name] 4"
		enemy4state=1
		enemylist+=enemy4
		enemies+=1
		enemy4.contents+=gs
		maxenemies=4
	enemy.name="[enemy.name] 1"
	enemy.contents+=gs
	maxbattlers=1
	pcount=1
	DesignateSpots(starter, pcount, fightparty, batstorage)
	sleep(2)
	for(var/mob/viewster in view(12,starter))
		if(viewster.partyID==fightparty.partyID && viewster != starter && pcount<=4)
			maxbattlers+=1
			pcount+=1
			alert(starter,"Maxbattlers: [maxbattlers] | Pcount: [pcount]")
			if(maxbattlers>=2)
				DesignateSpots(viewster, pcount,fightparty,batstorage)
				sleep(1)
			if(maxbattlers>=3)
				DesignateSpots(viewster, pcount,fightparty,batstorage)
				sleep(1)
			if(maxbattlers>=4)
				DesignateSpots(viewster, pcount,fightparty,batstorage)
				sleep(1)
	sleep(2)
	for(var/obj/perk/a in enemy.contents)
		if(a in attacklist1)
			return
		if(a.ability==1)
			attacklist1+=a
	for(var/obj/perk/b in enemy2.contents)
		if(b in attacklist2)
			return
		if(b.ability==1)
			attacklist2+=b
	for(var/obj/perk/c in enemy3.contents)
		if(c in attacklist3)
			return
		if(c.ability==1)
			attacklist3+=c
	for(var/obj/perk/d in enemy4.contents)
		if(d in attacklist4)
			return
		if(d.ability==1)
			attacklist4+=d
	for(var/obj/Party/party in world)
		if(party.partyID==starter.partyID)
			if(party.FATEID==enemy.FATEID)
				for(var/mob/m in view(starter))
					if(m.bposition=="battler1")
						battler1=m
						battler1 << sound('battle1.ogg',1,channel=1)
						m.battler=1
						battlers+=1
						battler1state="Alive"
						partylist-=m
						battlelist+=battler1
						battler1<<output("[battler1] has been designated as 'Battler 1'","oocout")
						//Unequipglobalmods(battler1)
						for(var/obj/perk/a in battler1.contents)
							if(a.ability==1 && a.heal==0 && a.valid_standard_attack())
								pattacklist1+=a
							if(a.heal==1)
								heallist1+=a
								healer1=1
						for(var/obj/perk/a in battler1.contents)
							if(a.ability==1 && a.heal==0 && a.valid_standard_attack())
								pattacklist1+=a
							if(a.heal==1)
								heallist1+=a
								healer1=1
							if(a.greenmagic==1)
								green1=1
								greenlist1+=a
							if(a.revive==1)
								revive1=1
								revivelist1+=a
						for(var/obj/npc/a in battler1.contents)
							var/obj/npc/b = copyatom(a)
							summonlist1+=b
							summon1=1
						sleep(1)
					if(maxbattlers>=2)
						if(m.bposition=="battler2")
							battler2=m
							battler2 << sound('battle1.ogg',1,channel=1)
							m.battler=1
							battlers+=1
							battler2state="Alive"
							partylist-=m
							battlelist+=battler2
							battler2<<output("[battler2] has been designated as 'Battler 2'","oocout")
							//Unequipglobalmods(battler2)
							for(var/obj/perk/a in battler2.contents)
								if(a.ability==1 && a.heal==0 && a.valid_standard_attack())
									pattacklist2+=a
								if(a.heal==1)
									heallist2+=a
									healer2=1
								if(a.greenmagic==1)
									green2=1
									greenlist2+=a
								if(a.revive==1)
									revive2=1
									revivelist2+=a
							for(var/obj/npc/a in battler2.contents)
								var/obj/npc/b = copyatom(a)
								summonlist2+=b
								summon2=1
								sleep(1)
					if(maxbattlers>=3)
						if(m.bposition=="battler3")
							battler3=m
							battler3 << sound('battle1.ogg',1,channel=1)
							m.battler=1
							battlers+=1
							battler3state="Alive"
							partylist-=m
							battlelist+=battler3
							battler3<<output("[battler3] has been designated as 'Battler 3'","oocout")
							//Unequipglobalmods(battler3)
							for(var/obj/perk/a in battler3.contents)
								if(a.ability==1 && a.heal==0 && a.valid_standard_attack())
									pattacklist3+=a
								if(a.heal==1)
									heallist3+=a
									healer3=1
								if(a.greenmagic==1)
									green3=1
									greenlist3+=a
								if(a.revive==1)
									revive3=1
									revivelist3+=a
							for(var/obj/npc/a in battler3.contents)
								var/obj/npc/b = copyatom(a)
								summonlist3+=b
								summon3=1
								sleep(1)
					if(maxbattlers>=4)
						if(m.bposition=="battler4")
							battler4=m
							battler4 << sound('battle1.ogg',1,channel=1)
							m.battler=1
							battlers+=1
							battler4state="Alive"
							partylist-=m
							battlelist+=battler4
							battler4<<output("[battler4] has been designated as 'Battler 4'","oocout")
							//Unequipglobalmods(battler4)
							for(var/obj/perk/a in battler4.contents)
								if(a.ability==1 && a.heal==0 && a.valid_standard_attack())
									pattacklist4+=a
								if(a.heal==1)
									heallist4+=a
									healer4=1
								if(a.greenmagic==1)
									green4=1
									greenlist4+=a
								if(a.revive==1)
									revive4=1
									revivelist4+=a
							for(var/obj/npc/a in battler4.contents)
								var/obj/npc/b = copyatom(a)
								summonlist4+=b
								summon4=1
								sleep(1)
			else
				alert(starter,"This is not your FATE to fight.")
				return
	while(enemyalive==1)
		if(battlers<=0)
			enemy.visible_message("All Party Members have been defeated! <b>FATE</b> failed!!", stream = "icout")
			del enemy2
			del enemy3
			del enemy4
			for(var/obj/Party/a in world)
				if(starter.partyID==a.partyID)
					for(var/obj/FATECrystal/b in global.fate_crystals)
						if("[b.FATEID]"=="[a.FATEID]")
							Defeat(a,b)
							enemyalive=0
							sleep(4)
							del enemy
		if(maxenemies>=1)
			if(enemy.hp<=0 && e1counted==0)
				enemystate=0
				enemies-=1
				e1counted=1
				enemylist-=enemy
				usr.send_chat("[enemy] is defeated [enemies]/[maxenemies]", stream = "icout")
				sleep(4)
		if(maxenemies>=2)
			if(enemy2.hp<=0 && e2counted==0)
				enemy2state=0
				enemies-=1
				e2counted=1
				enemylist-=enemy2
				usr.send_chat("[enemy2] is defeated [enemies]/[maxenemies]", stream = "icout")
				sleep(4)
		if(maxenemies>=3)
			if(enemy3.hp<=0 && e3counted==0)
				enemy3state=0
				enemies-=1
				e3counted=1
				enemylist-=enemy3
				usr.send_chat("[enemy3] is defeated [enemies]/[maxenemies]", stream = "icout")
				sleep(4)
		if(maxenemies>=4)
			if(enemy4.hp<=0 && e4counted==0)
				enemy4state=0
				enemies-=1
				e4counted=1
				enemylist-=enemy4
				usr.send_chat("[enemy4] is defeated [enemies]/[maxenemies]", stream = "icout")
				sleep(4)
		if(maxbattlers>=1)
			if(battler1.hp<=0 && b1counted==0)
				battler1state=null
				battlers-=1
				battlelist-=battler1
				b1counted=1
		if(maxbattlers>=2)
			if(battler2.hp<=0 && b2counted==0)
				battler2state=null
				battlers-=1
				battlelist-=battler2
				b2counted=1
		if(maxbattlers>=3)
			if(battler3.hp<=0 && b3counted==0)
				battler3state=null
				battlers-=1
				battlelist-=battler3
				b3counted=1
		if(maxbattlers>=4)
			if(battler4.hp<=0 && b4counted==0)
				battler4state=null
				battlers-=1
				battlelist-=battler4
				b4counted=1
		if(maxenemies>=1 && battlers>=1)
			if(enemystate==1)
				var/mob/target=pick(battlelist)
				var/obj/ally=pick(enemylist)
				attackchoice=pick(attacklist1)
				Greencheckenemy(enemy)
				Statusprocenemy(enemy)
				if(enemy.status1=="Stun")
					enemy3.visible_message("[enemy] is stunned, and skips a turn!", stream = "icout")
					enemy.totalstatus=0
					enemy.status1=null
					return
				if(attackchoice.greenmagic==1)
					if(attackchoice.multi==1)
						for(var/obj/npc/a in enemylist)
							enemy.EnemyGreen(enemy,a, attackchoice)
					if(attackchoice.multi==0)
						enemy.EnemyGreen(enemy,ally, attackchoice)
				if(attackchoice.dispel>=1)
					if(attackchoice.multi==1)
						for(var/mob/partymembers in battlelist)
							enemy.DispelEnemy(enemy, partymembers, attackchoice)
				if(attackchoice.heal==1)
					enemy.Enemyheal(enemy,ally,attackchoice)
				if(attackchoice.dispel==0 && attackchoice.greenmagic==0  && attackchoice.heal==0)
					enemy.Enemyability(enemy,target,attackchoice)
					sleep(30)
		sleep(1)
		if(maxbattlers>=1)
			if(battler1.hp<=0 && b1counted==0)
				battler1state=null
				battlers-=1
				battlelist-=battler1
				b1counted=1
		if(maxbattlers>=2)
			if(battler2.hp<=0 && b2counted==0)
				battler2state=null
				battlers-=1
				battlelist-=battler2
				b2counted=1
		if(maxbattlers>=3)
			if(battler3.hp<=0 && b3counted==0)
				battler3state=null
				battlers-=1
				battlelist-=battler3
				b3counted=1
		if(maxbattlers>=4)
			if(battler4.hp<=0 && b4counted==0)
				battler4state=null
				battlers-=1
				battlelist-=battler4
				b4counted=1
		sleep(1)
		if(battlers<=0)
			enemy.visible_message("All Party Members have been defeated! <b>FATE</b> failed!!", stream = "icout")
			del enemy2
			del enemy3
			del enemy4
			for(var/obj/Party/a in world)
				if(starter.partyID==a.partyID)
					for(var/obj/FATECrystal/b in global.fate_crystals)
						if("[b.FATEID]"=="[a.FATEID]")
							Defeat(a,b)
							enemyalive=0
							sleep(4)
							del enemy
		sleep(1)
		if(maxenemies>=2 && battlers>=1)
			if(enemy2state==1)
				var/mob/target=pick(battlelist)
				var/obj/ally=pick(enemylist)
				attackchoice=pick(attacklist2)
				Greencheckenemy(enemy2)
				Statusprocenemy(enemy2)
				if(enemy2.status1=="Stun")
					enemy4.visible_message("[enemy2] is stunned, and skips a turn!", stream = "icout")
					enemy2.totalstatus=0
					enemy2.status1=null
					return
				if(attackchoice.greenmagic==1)
					if(attackchoice.multi==1)
						for(var/obj/npc/a in enemylist)
							enemy2.EnemyGreen(enemy2,a, attackchoice)
					if(attackchoice.multi==0)
						enemy2.EnemyGreen(enemy2,ally, attackchoice)
				if(attackchoice.dispel>=1)
					if(attackchoice.multi==1)
						for(var/mob/partymembers in battlelist)
							enemy2.DispelEnemy(enemy2, partymembers, attackchoice)
				if(attackchoice.heal==1)
					enemy2.Enemyheal(enemy2,ally,attackchoice)
				if(attackchoice.dispel==0 && attackchoice.greenmagic==0 && attackchoice.heal==0)
					enemy4.Enemyability(enemy2,target,attackchoice)
					sleep(30)
		sleep(1)
		if(maxbattlers>=1)
			if(battler1.hp<=0 && b1counted==0)
				battler1state=null
				battlers-=1
				battlelist-=battler1
				b1counted=1
		if(maxbattlers>=2)
			if(battler2.hp<=0 && b2counted==0)
				battler2state=null
				battlers-=1
				battlelist-=battler2
				b2counted=1
		if(maxbattlers>=3)
			if(battler3.hp<=0 && b3counted==0)
				battler3state=null
				battlers-=1
				battlelist-=battler3
				b3counted=1
		if(maxbattlers>=4)
			if(battler4.hp<=0 && b4counted==0)
				battler4state=null
				battlers-=1
				battlelist-=battler4
				b4counted=1
		sleep(1)
		if(battlers<=0)
			enemy.visible_message("All Party Members have been defeated! <b>FATE</b> failed!!", stream = "icout")
			del enemy2
			del enemy3
			del enemy4
			for(var/obj/Party/a in world)
				if(starter.partyID==a.partyID)
					for(var/obj/FATECrystal/b in global.fate_crystals)
						if("[b.FATEID]"=="[a.FATEID]")
							Defeat(a,b)
							sleep(4)
							enemyalive=0
							del enemy
		sleep(1)
		if(maxenemies>=3 && battlers>=1)
			if(enemy3state==1)
				var/mob/target=pick(battlelist)
				var/obj/ally=pick(enemylist)
				attackchoice=pick(attacklist3)
				Greencheckenemy(enemy3)
				Statusprocenemy(enemy3)
				if(enemy3.status1=="Stun")
					enemy3.visible_message("[enemy3] is stunned, and skips a turn!", stream = "icout")
					enemy3.totalstatus=0
					enemy3.status1=null
					return
				if(attackchoice.greenmagic==1)
					if(attackchoice.multi==1)
						for(var/obj/npc/a in enemylist)
							enemy3.EnemyGreen(enemy3,a, attackchoice)
					if(attackchoice.multi==0)
						enemy3.EnemyGreen(enemy3,ally, attackchoice)
				if(attackchoice.dispel>=1)
					if(attackchoice.multi==1)
						for(var/mob/partymembers in battlelist)
							enemy3.DispelEnemy(enemy3, partymembers, attackchoice)
					if(attackchoice.multi==0)
						enemy3.DispelEnemy(enemy3, target, attackchoice)
				if(attackchoice.heal==1)
					enemy3.Enemyheal(enemy3,ally,attackchoice)
				if(attackchoice.dispel==0 && attackchoice.greenmagic==0 && attackchoice.heal==0)
					enemy3.Enemyability(enemy3,target,attackchoice)
					sleep(30)
		sleep(1)
		if(maxbattlers>=1)
			if(battler1.hp<=0 && b1counted==0)
				battler1state=null
				battlers-=1
				battlelist-=battler1
				b1counted=1
		if(maxbattlers>=2)
			if(battler2.hp<=0 && b2counted==0)
				battler2state=null
				battlers-=1
				battlelist-=battler2
				b2counted=1
		if(maxbattlers>=3)
			if(battler3.hp<=0 && b3counted==0)
				battler3state=null
				battlers-=1
				battlelist-=battler3
				b3counted=1
		if(maxbattlers>=4)
			if(battler4.hp<=0 && b4counted==0)
				battler4state=null
				battlers-=1
				battlelist-=battler4
				b4counted=1
		sleep(1)
		if(battlers<=0)
			enemy.visible_message("All Party Members have been defeated! <b>FATE</b> failed!!", stream = "icout")
			del enemy2
			del enemy3
			del enemy4
			for(var/obj/Party/a in world)
				if(starter.partyID==a.partyID)
					for(var/obj/FATECrystal/b in global.fate_crystals)
						if("[b.FATEID]"=="[a.FATEID]")
							Defeat(a,b)
							enemyalive=0
							sleep(4)
							del enemy
		sleep(1)
		if(maxenemies>=4 && battlers>=1)
			if(enemy4state==1)
				var/mob/target=pick(battlelist)
				var/obj/ally=pick(enemylist)
				attackchoice=pick(attacklist4)
				Greencheckenemy(enemy4)
				Statusprocenemy(enemy4)
				if(enemy4.status1=="Stun")
					enemy4.visible_message("[enemy4] is stunned, and skips a turn!", stream = "icout")
					enemy4.totalstatus=0
					enemy4.status1=null
					return
				if(attackchoice.greenmagic==1)
					if(attackchoice.multi==1)
						for(var/obj/npc/a in enemylist)
							enemy4.EnemyGreen(enemy4,a, attackchoice)
					if(attackchoice.multi==0)
						enemy4.EnemyGreen(enemy4,ally, attackchoice)
				if(attackchoice.dispel>=1)
					if(attackchoice.multi==1)
						for(var/mob/partymembers in battlelist)
							enemy4.DispelEnemy(enemy4, partymembers, attackchoice  && attackchoice.heal==0)
				if(attackchoice.heal==1)
					enemy4.Enemyheal(enemy4,ally,attackchoice)
				if(attackchoice.dispel==0 && attackchoice.greenmagic==0 && attackchoice.heal==0)
					enemy4.Enemyability(enemy4,target,attackchoice)
					sleep(30)
		sleep(1)
		if(maxbattlers>=1)
			if(battler1.hp<=0 && b1counted==0)
				battler1state=null
				battlers-=1
				battlelist-=battler1
				b1counted=1
		if(maxbattlers>=2)
			if(battler2.hp<=0 && b2counted==0)
				battler2state=null
				battlers-=1
				battlelist-=battler2
				b2counted=1
		if(maxbattlers>=3)
			if(battler3.hp<=0 && b3counted==0)
				battler3state=null
				battlers-=1
				battlelist-=battler3
				b3counted=1
		if(maxbattlers>=4)
			if(battler4.hp<=0 && b4counted==0)
				battler4state=null
				battlers-=1
				battlelist-=battler4
				b4counted=1
		sleep(1)
		if(enemies<=0)
			enemy.visible_message("All Enemies have been defeated! <b>FATE</b> complete!!", stream = "icout")
			for(var/obj/Party/c in world)
				del enemy2
				del enemy3
				del enemy4
				if(battler1.partyID==c.partyID)
					for(var/obj/FATECrystal/b in global.fate_crystals)
						if("[b.FATEID]"=="[c.FATEID]")
							Victory(c,b)
							enemyalive=0
							maxbattlers=0
							enemies=0
							sleep(4)
							del enemy
		sleep(1)
		if(enemies>=1)
			if(maxbattlers>=1)
				if(battler1state=="Alive")
					Greencheckplayer(battler1)
					Statusprocparty(battler1)
					if(battler1.status1=="Stun")
						battler1.visible_message("[battler1] is stunned, and skips a turn!", stream = "icout")
						battler1.totalstatus=0
						battler1.status1=null
						return
					usr.send_chat("<font color=[battler1.textcolor]><b>[battler1]'s</font> turn, let's see what they can do!", stream = "icout")
					var/list/actions=list("Attack","Ability","Rest")
					if(green1==1)
						actions+="Green Magic"
					if(healer1==1)
						actions+="Heal"
					if(revive1==1)
						actions+="Revive"
					if(summon1==1)
						actions+="Summon"
					if(battler1.job=="Spellblade" || battler1.subjob=="Spellblade")
						actions+="Infusion"
					if(battler1.job=="Mystic Knight" || battler1.subjob=="Mystic Knight")
						actions+="Blade Cast"
						actions+="Blade Dance"
					if(battler1.job=="Dancer" || battler1.subjob=="Dancer")
						actions+="Dance"
					if(battler1.job=="Black Mage" || battler1.subjob=="Black Mage")
						actions+="Twin Cast"
					if(battler1.job=="Samurai" || battler1.subjob=="Samurai")
						actions+="Retaliate"
					var/achoice=input(battler1,"What action would you like to take this turn?") as anything in actions
					switch(achoice)
						if("Blade Cast")
							var/list/twincast=list()
							for(var/obj/perk/options in pattacklist1)
								if(options.typing=="magical")
									twincast+=options
							var/target=input(battler1,"Which enemy would you like to attack?") as anything in enemylist
							attackchoice=input(battler1,"Which Ability would you like to use this turn?") as anything in twincast
							battler1.turnattack(battler1,target)
							battler1.TurnAbility(battler1,target,attackchoice)
							sleep(4)
						if("Blade Dance")
							var/target=input(battler1,"Which enemy would you like to attack?") as anything in enemylist
							battler1.turnattack(battler1,target)
							battler1.turnattack(battler1,target)
							sleep(4)
						if("Twin Cast")
							var/list/twincast=list()
							for(var/obj/perk/options in pattacklist1)
								if(options.typing=="magical")
									twincast+=options
							attackchoice=input(battler1,"Which Ability would you like to use this turn?") as anything in twincast
							var/target=input(battler1,"Which enemy would you like to attack?") as anything in enemylist
							battler1.TurnAbility(battler1,target,attackchoice)
							sleep(4)
							attackchoice=input(battler1,"Which Ability would you like to use this turn?") as anything in twincast
							var/target2=input(battler1,"Which enemy would you like to attack?") as anything in enemylist
							battler1.TurnAbility(battler1,target2,attackchoice)
							sleep(4)
						if("Retaliate")
							if(battler1.sp<30)
								usr.send_chat("<font color=[battler1.textcolor]<b>[battler1] has attempted to use Retaliate, but could not spend 30 SP, and has forfeited their turn!", stream = "icout")
							else
								var/target=input(battler1,"Which enemy would you like to attack, setting Retaliate up?") as anything in enemylist
								battler1.turnattack(battler1,target)
								usr.send_chat("<font color=[battler1.textcolor]<b>[battler1] has entered a <b>Retaliation</b> stance!", stream = "icout")
								battler1.sp-=30
								battler1.retaliate=1
						if("Infusion")
							var/list/Infusions=list("Fire","Water","Ice","Thunder","Wind")
							var/infuchoice=input(battler1,"Which Infusion would you like to apply to your weapon?") as anything in Infusions
							battler1.infusion=infuchoice
							usr.send_chat("<font color=[battler1.textcolor]<b>[battler1] has set their Infusion type to [infuchoice]!", stream = "icout")
						if("Summon")
							var/target=input(battler1,"Which enemy would you like to summon a companion to attack?") as anything in enemylist
							var/summon=input(battler1,"Which companion would you like to call on the power of?") as anything in summonlist1
							Summonattack(battler1, target, summon)
						if("Attack")
							var/target=input(battler1,"Which enemy would you like to attack?") as anything in enemylist
							battler1.turnattack(battler1,target)
							sleep(4)
						if("Ability")
							attackchoice=input(battler1,"Which Ability would you like to use this turn?") as anything in pattacklist1
							var/target=input(battler1,"Which enemy would you like to attack?") as anything in enemylist
							battler1.TurnAbility(battler1,target,attackchoice)
							sleep(4)
						if("Heal")
							var/target=input(battler1,"Which ally would you like to heal?") as anything in battlelist
							healchoice=input(battler1,"Which Healing ability would you like to use this turn?") as anything in heallist1
							battler1.Heal(battler1,target,healchoice)
							sleep(4)
						if("Rest")
							var/conboost=(6*battler1.conmod)
							var/rest2=conboost+10
							var/rest1=conboost+5
							var/restvalue=rand(rest1,rest2)
							usr.send_chat("<font color=[battler1.textcolor]><b>[battler1]</font> has decided to rest, and restores [restvalue] HP and MP!!", stream = "icout")
							battler1.hp+=restvalue
							battler1.mp+=restvalue
							if(battler1.hp>battler1.mhp)
								battler1.hp=battler1.mhp
							if(battler1.mp>battler1.mmp)
								battler1.mp=battler1.mmp
						if("Green Magic")
							var/obj/perk/spell=input(battler1,"Which Green Magic ability would you like to use?") as anything in greenlist1
							if(spell.dispel>=1)
								if(spell.multi==1)
									for(var/obj/npc/a in enemylist)
										DispelPlayer(battler1, a, spell)
								if(spell.multi==0)
									var/dispelchoice=input(battler1,"Which enemy would you like to dispel an effect from?") as anything in enemylist
									DispelPlayer(battler1, dispelchoice, spell)
							if(spell.multi==0)
								var/targetchoice=input(battler1,"Who would you like to use it on?") as anything in battlelist
								GreenMagicOne(battler1, targetchoice, spell)
							if(spell.multi==1)
								if(battler1state=="Alive")
									GreenMagicOne(battler1, battler1, spell)
								if(battler2state=="Alive")
									GreenMagicOne(battler1, battler2, spell)
								if(battler3state=="Alive")
									GreenMagicOne(battler1,battler3, spell)
								if(battler4state=="Alive")
									GreenMagicOne(battler1,battler4, spell)
						if("Revive")
							var/list/revivechoice=list()
							if(battler1state!="Alive")
								revivechoice+=battler1
							if(battler2state!="Alive")
								revivechoice+=battler2
							if(battler3state!="Alive")
								revivechoice+=battler3
							if(battler4state!="Alive")
								revivechoice+=battler4
							var/obj/perk/spell=input(battler1,"Which revive Spell would you like to use?") as anything in revivelist1
							if(spell.multi==0)
								var/mob/choice=input(battler1,"Who would you like to revive with this Spell?") as anything in revivechoice
								Revive(battler1, choice, spell)
								if(choice.bposition=="battler1")
									battler1state="Alive"
									battlelist+=choice
									battlers+=1
									b1counted=0
								if(choice.bposition=="battler2")
									battler2state="Alive"
									battlelist+=choice
									battlers+=1
									b2counted=0
								if(choice.bposition=="battler3")
									battler3state="Alive"
									battlelist+=choice
									battlers+=1
									b3counted=0
								if(choice.bposition=="battler4")
									battler4state="Alive"
									battlelist+=choice
									battlers+=1
									b4counted=0
							if(spell.multi==1)
								if(battler1state!="Alive")
									battler1state="Alive"
									battlelist+=battler1
									Revive(battler1, battler1, spell)
									battlers+=1
									b1counted=0
								if(battler2state!="Alive")
									battler2state="Alive"
									battlelist+=battler2
									Revive(battler1, battler2, spell)
									battlers+=1
									b2counted=0
								if(battler3state!="Alive")
									battler3state="Alive"
									battlelist+=battler3
									Revive(battler1, battler3, spell)
									battlers+=1
									b3counted=0
								if(battler4state!="Alive")
									battler4state="Alive"
									battlelist+=battler4
									Revive(battler1, battler4, spell)
									battlers+=1
									b4counted=0
						if("Summon")
							return
			sleep(1)
			if(maxenemies>=1)
				if(enemy.hp<=0 && e1counted==0)
					enemystate=0
					enemies-=1
					e1counted=1
					enemylist-=enemy
					usr.send_chat("[enemy] is defeated [enemies]/[maxenemies]", stream = "icout")
					sleep(4)
			if(maxenemies>=2)
				if(enemy2.hp<=0 && e2counted==0)
					enemy2state=0
					enemies-=1
					e2counted=1
					enemylist-=enemy2
					usr.send_chat("[enemy2] is defeated [enemies]/[maxenemies]", stream = "icout")
					sleep(4)
			if(maxenemies>=3)
				if(enemy3.hp<=0 && e3counted==0)
					enemy3state=0
					enemies-=1
					e3counted=1
					enemylist-=enemy3
					usr.send_chat("[enemy3] is defeated [enemies]/[maxenemies]", stream = "icout")
					sleep(4)
			if(maxenemies>=4)
				if(enemy4.hp<=0 && e4counted==0)
					enemy4state=0
					enemies-=1
					e4counted=1
					enemylist-=enemy4
					usr.send_chat("[enemy4] is defeated [enemies]/[maxenemies]", stream = "icout")
					sleep(4)
			sleep(1)
			if(enemies<=0)
				enemy.visible_message("All Enemies have been defeated! <b>FATE</b> complete!!", stream = "icout")
				del enemy2
				del enemy3
				del enemy4
				for(var/obj/Party/c in world)
					if(battler1.partyID==c.partyID)
						for(var/obj/FATECrystal/b in global.fate_crystals)
							if("[b.FATEID]"=="[c.FATEID]")
								Victory(c,b)
								enemyalive=0
								maxbattlers=0
								enemies=0
								sleep(4)
								del enemy
			sleep(1)
			if(maxbattlers>=2)
				if(battler2state=="Alive")
					Greencheckplayer(battler2)
					Statusprocparty(battler2)
					if(battler2.status1=="Stun")
						battler2.visible_message("[battler2] is stunned, and skips a turn!", stream = "icout")
						battler2.totalstatus=0
						battler2.status1=null
						return
					usr.send_chat("<font color=[battler2.textcolor]><b>[battler2]'s</font> turn, let's see what they can do!", stream = "icout")
					var/list/actions=list("Attack","Ability","Rest")
					if(green2==1)
						actions+="Green Magic"
					if(healer2==1)
						actions+="Heal"
					if(revive2==1)
						actions+="Revive"
					if(summon2==1)
						actions+="Summon"
					if(battler2.job=="Spellblade" || battler2.subjob=="Spellblade")
						actions+="Infusion"
					if(battler2.job=="Mystic Knight" || battler2.subjob=="Mystic Knight")
						actions+="Blade Cast"
						actions+="Blade Dance"
					if(battler2.job=="Dancer" || battler2.subjob=="Dancer")
						actions+="Dance"
					if(battler2.job=="Black Mage" || battler2.subjob=="Black Mage")
						actions+="Twin Cast"
					if(battler2.job=="Samurai" || battler2.subjob=="Samurai")
						actions+="Retaliate"

					var/achoice=input(battler2,"What action would you like to take this turn?") as anything in actions
					switch(achoice)
						if("Blade Cast")
							var/list/twincast=list()
							for(var/obj/perk/options in pattacklist2)
								if(options.typing=="magical")
									twincast+=options
							var/target=input(battler2,"Which enemy would you like to attack?") as anything in enemylist
							attackchoice=input(battler2,"Which Ability would you like to use this turn?") as anything in twincast
							battler2.turnattack(battler2,target)
							battler2.TurnAbility(battler2,target,attackchoice)
						if("Blade Dance")
							var/target=input(battler2,"Which enemy would you like to attack?") as anything in enemylist
							battler2.turnattack(battler2,target)
							battler2.turnattack(battler2,target)
						if("Twin Cast")
							var/list/twincast=list()
							for(var/obj/perk/options in pattacklist2)
								if(options.typing=="magical")
									twincast+=options
							attackchoice=input(battler2,"Which Ability would you like to use this turn?") as anything in twincast
							var/target=input(battler2,"Which enemy would you like to attack?") as anything in enemylist
							battler2.TurnAbility(battler2,target,attackchoice)
							sleep(4)
							attackchoice=input(battler2,"Which Ability would you like to use this turn?") as anything in twincast
							var/target2=input(battler2,"Which enemy would you like to attack?") as anything in enemylist
							battler2.TurnAbility(battler2,target2,attackchoice)
							sleep(4)
						if("Retaliate")
							if(battler2.sp<30)
								usr.send_chat("<font color=[battler2.textcolor]<b>[battler2] has attempted to use Retaliate, but could not spend 30 SP, and has forfeited their turn!", stream = "icout")
							else
								var/target=input(battler2,"Which enemy would you like to attack, setting Retaliate up?") as anything in enemylist
								battler2.turnattack(battler2,target)
								usr.send_chat("<font color=[battler2.textcolor]<b>[battler2] has entered a <b>Retaliation</b> stance!", stream = "icout")
								battler2.sp-=30
								battler2.retaliate=1
						if("Infusion")
							var/list/Infusions=list("Fire","Water","Ice","Thunder","Wind","Holy","Dark","Flare")
							var/infuchoice=input(battler2,"Which Infusion would you like to apply to your weapon?") as anything in Infusions
							battler2.infusion=infuchoice
							usr.send_chat("<font color=[battler2.textcolor]<b>[battler2] has set their Infusion type to [infuchoice]!", stream = "icout")
						if("Summon")
							var/target=input(battler2,"Which enemy would you like to summon a companion to attack?") as anything in enemylist
							var/summon=input(battler2,"Which companion would you like to call on the power of?") as anything in summonlist2
							Summonattack(battler2, target, summon)
						if("Attack")
							var/target=input(battler2,"Which enemy would you like to attack?") as anything in enemylist
							battler2.turnattack(battler2,target)
							sleep(4)
						if("Ability")
							attackchoice=input(battler2,"Which Ability would you like to use this turn?") as anything in pattacklist2
							var/target=input(battler2,"Which enemy would you like to attack?") as anything in enemylist
							battler2.TurnAbility(battler2,target,attackchoice)
							sleep(4)
						if("Heal")
							var/target=input(battler2,"Which ally would you like to heal?") as anything in battlelist
							healchoice=input(battler2,"Which Healing ability would you like to use this turn?") as anything in heallist2
							battler2.Heal(battler2,target,healchoice)
							sleep(4)
						if("Rest")
							var/conboost=(6*battler2.conmod)
							var/rest2=conboost+10
							var/rest1=conboost+5
							var/restvalue=rand(rest1,rest2)
							usr.send_chat("<font color=[battler2.textcolor]><b>[battler2]</font> has decided to rest, and restores [restvalue] HP and MP!!", stream = "icout")
							battler2.hp+=restvalue
							battler2.mp+=restvalue
							if(battler2.hp>battler2.mhp)
								battler2.hp=battler2.mhp
							if(battler2.mp>battler2.mmp)
								battler2.mp=battler2.mmp
						if("Green Magic")
							var/obj/perk/spell=input(battler2,"Which Green Magic ability would you like to use?") as anything in greenlist2
							if(spell.dispel>=1)
								if(spell.multi==1)
									for(var/obj/npc/a in enemylist)
										DispelPlayer(battler2, a, spell)
								if(spell.multi==0)
									var/dispelchoice=input(battler2,"Which enemy would you like to dispel an effect from?") as anything in enemylist
									DispelPlayer(battler2, dispelchoice, spell)
							if(spell.multi==0)
								var/targetchoice=input(battler2,"Who would you like to use it on?") as anything in battlelist
								GreenMagicOne(battler2, targetchoice, spell)
							if(spell.multi==1)
								if(battler1state=="Alive")
									GreenMagicOne(battler2, battler1, spell)
								if(battler2state=="Alive")
									GreenMagicOne(battler2, battler2, spell)
								if(battler3state=="Alive")
									GreenMagicOne(battler2,battler3, spell)
								if(battler4state=="Alive")
									GreenMagicOne(battler2,battler4, spell)
						if("Revive")
							var/list/revivechoice=list()
							if(battler1state!="Alive")
								revivechoice+=battler1
							if(battler2state!="Alive")
								revivechoice+=battler2
							if(battler3state!="Alive")
								revivechoice+=battler3
							if(battler4state!="Alive")
								revivechoice+=battler4
							var/obj/perk/spell=input(battler2,"Which revive Spell would you like to use?") as anything in revivelist2
							if(spell.multi==0)
								var/mob/choice=input(battler2,"Who would you like to revive with this Spell?") as anything in revivechoice
								Revive(battler2, choice, spell)
								if(choice.bposition=="battler1")
									battler1state="Alive"
									battlelist+=choice
									battlers+=1
									b1counted=0
								if(choice.bposition=="battler2")
									battler2state="Alive"
									battlelist+=choice
									battlers+=1
									b2counted=0
								if(choice.bposition=="battler3")
									battler3state="Alive"
									battlelist+=choice
									battlers+=1
									b3counted=0
								if(choice.bposition=="battler4")
									battler4state="Alive"
									battlelist+=choice
									battlers+=1
									b4counted=0
							if(spell.multi==1)
								if(battler1state!="Alive")
									battler1state="Alive"
									battlelist+=battler1
									Revive(battler2, battler1, spell)
									battlers+=1
									b1counted=0
								if(battler2state!="Alive")
									battler2state="Alive"
									battlelist+=battler2
									Revive(battler2, battler2, spell)
									battlers+=1
									b2counted=0
								if(battler3state!="Alive")
									battler3state="Alive"
									battlelist+=battler3
									Revive(battler2, battler3, spell)
									battlers+=1
									b3counted=0
								if(battler4state!="Alive")
									battler4state="Alive"
									battlelist+=battler4
									Revive(battler2, battler4, spell)
									battlers+=1
									b4counted=0
			sleep(1)
			if(maxenemies>=1)
				if(enemy.hp<=0 && e1counted==0)
					enemystate=0
					enemies-=1
					e1counted=1
					enemylist-=enemy
					usr.send_chat("[enemy] is defeated [enemies]/[maxenemies]", stream = "icout")
					sleep(4)
			if(maxenemies>=2)
				if(enemy2.hp<=0 && e2counted==0)
					enemy2state=0
					enemies-=1
					e2counted=1
					enemylist-=enemy2
					usr.send_chat("[enemy2] is defeated [enemies]/[maxenemies]", stream = "icout")
					sleep(4)
			if(maxenemies>=3)
				if(enemy3.hp<=0 && e3counted==0)
					enemy3state=0
					enemies-=1
					e3counted=1
					enemylist-=enemy3
					usr.send_chat("[enemy3] is defeated [enemies]/[maxenemies]", stream = "icout")
					sleep(4)
			if(maxenemies>=4)
				if(enemy4.hp<=0 && e4counted==0)
					enemy4state=0
					enemies-=1
					e4counted=1
					enemylist-=enemy4
					usr.send_chat("[enemy4] is defeated [enemies]/[maxenemies]", stream = "icout")
					sleep(4)
			sleep(1)
			if(enemies<=0)
				enemy.visible_message("All Enemies have been defeated! <b>FATE</b> complete!!", stream = "icout")
				del enemy2
				del enemy3
				del enemy4
				for(var/obj/Party/c in world)
					if(battler1.partyID==c.partyID)
						for(var/obj/FATECrystal/b in global.fate_crystals)
							if(b.FATEID==c.FATEID)
								Victory(c,b)
								enemyalive=0
								maxbattlers=0
								enemies=0
								sleep(4)
								del enemy
			sleep(1)
			if(maxbattlers>=3)
				if(battler3state=="Alive")
					Greencheckplayer(battler3)
					Statusprocparty(battler3)
					if(battler3.status1=="Stun")
						battler3.visible_message("[battler3] is stunned, and skips a turn!", stream = "icout")
						battler3.totalstatus=0
						battler3.status1=null
						return
					usr.send_chat("<font color=[battler3.textcolor]><b>[battler3]'s</font> turn, let's see what they can do!", stream = "icout")
					var/list/actions=list("Attack","Ability","Rest")
					if(green3==1)
						actions+="Green Magic"
					if(healer3==1)
						actions+="Heal"
					if(revive3==1)
						actions+="Revive"
					if(summon3==1)
						actions+="Summon"
					if(battler3.job=="Spellblade" || battler3.subjob=="Spellblade")
						actions+="Infusion"
					if(battler3.job=="Mystic Knight" || battler3.subjob=="Mystic Knight")
						actions+="Blade Cast"
						actions+="Blade Dance"
					if(battler3.job=="Dancer" || battler3.subjob=="Dancer")
						actions+="Dance"
					if(battler3.job=="Black Mage" || battler3.subjob=="Black Mage")
						actions+="Twin Cast"
					if(battler3.job=="Samurai" || battler3.subjob=="Samurai")
						actions+="Retaliate"
					Greencheckplayer(battler3)
					if(battler3.totalstatus>=1)
						Statusprocparty(battler3)
					var/achoice=input(battler3,"What action would you like to take this turn?") as anything in actions
					switch(achoice)
						if("Blade Cast")
							var/list/twincast=list()
							for(var/obj/perk/options in pattacklist3)
								if(options.typing=="magical")
									twincast+=options
							var/target=input(battler3,"Which enemy would you like to attack?") as anything in enemylist
							attackchoice=input(battler3,"Which Ability would you like to use this turn?") as anything in twincast
							battler3.turnattack(battler3,target)
							battler3.TurnAbility(battler3,target,attackchoice)
						if("Blade Dance")
							var/target=input(battler3,"Which enemy would you like to attack?") as anything in enemylist
							battler3.turnattack(battler3,target)
							battler3.turnattack(battler3,target)
						if("Twin Cast")
							var/list/twincast=list()
							for(var/obj/perk/options in pattacklist3)
								if(options.typing=="magical")
									twincast+=options
							attackchoice=input(battler3,"Which Ability would you like to use this turn?") as anything in twincast
							var/target=input(battler3,"Which enemy would you like to attack?") as anything in enemylist
							battler3.TurnAbility(battler3,target,attackchoice)
							sleep(4)
							attackchoice=input(battler3,"Which Ability would you like to use this turn?") as anything in twincast
							var/target2=input(battler3,"Which enemy would you like to attack?") as anything in enemylist
							battler3.TurnAbility(battler3,target2,attackchoice)
							sleep(4)
						if("Retaliate")
							if(battler3.sp<30)
								usr.send_chat("<font color=[battler3.textcolor]<b>[battler3] has attempted to use Retaliate, but could not spend 30 SP, and has forfeited their turn!", stream = "icout")
							else
								var/target=input(battler3,"Which enemy would you like to attack, setting Retaliate up?") as anything in enemylist
								battler2.turnattack(battler3,target)
								usr.send_chat("<font color=[battler3.textcolor]<b>[battler3] has entered a <b>Retaliation</b> stance!", stream = "icout")
								battler3.sp-=30
								battler3.retaliate=1
						if("Infusion")
							var/list/Infusions=list("Fire","Water","Ice","Thunder","Wind","Holy","Dark","Flare")
							var/infuchoice=input(battler3,"Which Infusion would you like to apply to your weapon?") as anything in Infusions
							battler3.infusion=infuchoice
							usr.send_chat("<font color=[battler3.textcolor]<b>[battler3] has set their Infusion type to [infuchoice]!", stream = "icout")
						if("Summon")
							var/target=input(battler3,"Which enemy would you like to summon a companion to attack?") as anything in enemylist
							var/summon=input(battler3,"Which companion would you like to call on the power of?") as anything in summonlist3
							Summonattack(battler3, target, summon)
						if("Attack")
							var/target=input(battler3,"Which enemy would you like to attack?") as anything in enemylist
							battler3.turnattack(battler3,target)
							sleep(4)
						if("Ability")
							attackchoice=input(battler3,"Which Ability would you like to use this turn?") as anything in pattacklist3
							var/target=input(battler3,"Which enemy would you like to attack?") as anything in enemylist
							battler3.TurnAbility(battler3,target,attackchoice)
							sleep(4)
						if("Heal")
							var/target=input(battler3,"Which ally would you like to heal?") as anything in battlelist
							healchoice=input(battler3,"Which Healing ability would you like to use this turn?") as anything in heallist3
							battler3.Heal(battler3,target,healchoice)
							sleep(4)
						if("Rest")
							var/conboost=(6*battler3.conmod)
							var/rest2=conboost+10
							var/rest1=conboost+5
							var/restvalue=rand(rest1,rest2)
							usr.send_chat("<font color=[battler3.textcolor]><b>[battler3]</font> has decided to rest, and restores [restvalue] HP and MP!!", stream = "icout")
							battler3.hp+=restvalue
							battler3.mp+=restvalue
							if(battler3.hp>battler3.mhp)
								battler3.hp=battler3.mhp
							if(battler3.mp>battler3.mmp)
								battler3.mp=battler3.mmp
						if("Green Magic")
							var/obj/perk/spell=input(battler3,"Which Green Magic ability would you like to use?") as anything in greenlist3
							if(spell.dispel>=1)
								if(spell.multi==1)
									for(var/obj/npc/a in enemylist)
										DispelPlayer(battler3, a, spell)
								if(spell.multi==0)
									var/dispelchoice=input(battler3,"Which enemy would you like to dispel an effect from?") as anything in enemylist
									DispelPlayer(battler3, dispelchoice, spell)
							if(spell.multi==0)
								var/targetchoice=input(battler3,"Who would you like to use it on?") as anything in battlelist
								GreenMagicOne(battler3, targetchoice, spell)
							if(spell.multi==1)
								if(battler1state=="Alive")
									GreenMagicOne(battler3, battler1, spell)
								if(battler2state=="Alive")
									GreenMagicOne(battler3, battler2, spell)
								if(battler3state=="Alive")
									GreenMagicOne(battler3,battler3, spell)
								if(battler4state=="Alive")
									GreenMagicOne(battler3,battler4, spell)
						if("Revive")
							var/list/revivechoice=list()
							if(battler1state!="Alive")
								revivechoice+=battler1
							if(battler2state!="Alive")
								revivechoice+=battler2
							if(battler3state!="Alive")
								revivechoice+=battler3
							if(battler4state!="Alive")
								revivechoice+=battler4
							var/obj/perk/spell=input(battler3,"Which revive Spell would you like to use?") as anything in revivelist3
							if(spell.multi==0)
								var/mob/choice=input(battler3,"Who would you like to revive with this Spell?") as anything in revivechoice
								Revive(battler3, choice, spell)
								if(choice.bposition=="battler1")
									battler1state="Alive"
									battlelist+=choice
									battlers+=1
									b1counted=0
								if(choice.bposition=="battler2")
									battler2state="Alive"
									battlelist+=choice
									battlers+=1
									b2counted=0
								if(choice.bposition=="battler3")
									battler3state="Alive"
									battlelist+=choice
									battlers+=1
									b3counted=0
								if(choice.bposition=="battler4")
									battler4state="Alive"
									battlelist+=choice
									battlers+=1
									b4counted=0
							if(spell.multi==1)
								if(battler1state!="Alive")
									battler1state="Alive"
									battlelist+=battler1
									Revive(battler3, battler1, spell)
									battlers+=1
									b1counted=0
								if(battler2state!="Alive")
									battler2state="Alive"
									battlelist+=battler2
									Revive(battler3, battler2, spell)
									battlers+=1
									b2counted=0
								if(battler3state!="Alive")
									battler3state="Alive"
									battlelist+=battler3
									Revive(battler3, battler3, spell)
									battlers+=1
									b3counted=0
								if(battler4state!="Alive")
									battler4state="Alive"
									battlelist+=battler4
									Revive(battler3, battler4, spell)
									battlers+=1
									b4counted=0
			sleep(1)
			if(maxenemies>=1)
				if(enemy.hp<=0 && e1counted==0)
					enemystate=0
					enemies-=1
					e1counted=1
					enemylist-=enemy
					usr.send_chat("[enemy] is defeated [enemies]/[maxenemies]", stream = "icout")
					sleep(4)
			if(maxenemies>=2)
				if(enemy2.hp<=0 && e2counted==0)
					enemy2state=0
					enemies-=1
					e2counted=1
					enemylist-=enemy2
					usr.send_chat("[enemy2] is defeated [enemies]/[maxenemies]", stream = "icout")
					sleep(4)
			if(maxenemies>=3)
				if(enemy3.hp<=0 && e3counted==0)
					enemy3state=0
					enemies-=1
					e3counted=1
					enemylist-=enemy3
					usr.send_chat("[enemy3] is defeated [enemies]/[maxenemies]", stream = "icout")
					sleep(4)
			if(maxenemies>=4)
				if(enemy4.hp<=0 && e4counted==0)
					enemy4state=0
					enemies-=1
					e4counted=1
					enemylist-=enemy4
					usr.send_chat("[enemy4] is defeated [enemies]/[maxenemies]", stream = "icout")
					sleep(4)
			if(enemies<=0)
				enemy.visible_message("All Enemies have been defeated! <b>FATE</b> complete!!", stream = "icout")
				del enemy2
				del enemy3
				del enemy4
				for(var/obj/Party/c in world)
					if(battler1.partyID==c.partyID)
						for(var/obj/FATECrystal/b in global.fate_crystals)
							if("[b.FATEID]"=="[c.FATEID]")
								Victory(c,b)
								enemyalive=0
								maxbattlers=0
								enemies=0
								sleep(4)
								del enemy
			sleep(1)
			if(maxbattlers>=4)
				if(battler4state=="Alive")
					Greencheckplayer(battler4)
					Statusprocparty(battler4)
					if(battler4.status1=="Stun")
						battler4.visible_message("[battler4] is stunned, and skips a turn!", stream = "icout")
						battler4.totalstatus=0
						battler4.status1=null
						return
					usr.send_chat("<font color=[battler4.textcolor]><b>[battler4]'s</font> turn, let's see what they can do!", stream = "icout")
					var/list/actions=list("Attack","Ability","Rest")
					if(green4==1)
						actions+="Green Magic"
					if(healer4==1)
						actions+="Heal"
					if(revive4==1)
						actions+="Revive"
					if(summon4==1)
						actions+="Summon"
					if(battler4.job=="Spellblade" || battler4.subjob=="Spellblade")
						actions+="Infusion"
					if(battler4.job=="Mystic Knight" || battler4.subjob=="Mystic Knight")
						actions+="Blade Cast"
						actions+="Blade Dance"
					if(battler4.job=="Dancer" || battler4.subjob=="Dancer")
						actions+="Dance"
					if(battler4.job=="Black Mage" || battler4.subjob=="Black Mage")
						actions+="Twin Cast"
					if(battler4.job=="Samurai" || battler4.subjob=="Samurai")
						actions+="Retaliate"
					Greencheckplayer(battler4)
					if(battler4.totalstatus>=1)
						Statusprocparty(battler4)
					var/achoice=input(battler4,"What action would you like to take this turn?") as anything in actions
					switch(achoice)
						if("Blade Cast")
							var/list/twincast=list()
							for(var/obj/perk/options in pattacklist4)
								if(options.typing=="magical")
									twincast+=options
							var/target=input(battler4,"Which enemy would you like to attack?") as anything in enemylist
							attackchoice=input(battler4,"Which Ability would you like to use this turn?") as anything in twincast
							battler4.turnattack(battler4,target)
							battler4.TurnAbility(battler4,target,attackchoice)
						if("Blade Dance")
							var/target=input(battler4,"Which enemy would you like to attack?") as anything in enemylist
							battler4.turnattack(battler4,target)
							battler4.turnattack(battler4,target)
						if("Twin Cast")
							var/list/twincast=list()
							for(var/obj/perk/options in pattacklist4)
								if(options.typing=="magical")
									twincast+=options
							attackchoice=input(battler4,"Which Ability would you like to use this turn?") as anything in twincast
							var/target=input(battler4,"Which enemy would you like to attack?") as anything in enemylist
							battler4.TurnAbility(battler4,target,attackchoice)
							sleep(4)
							attackchoice=input(battler4,"Which Ability would you like to use this turn?") as anything in twincast
							var/target2=input(battler4,"Which enemy would you like to attack?") as anything in enemylist
							battler4.TurnAbility(battler4,target2,attackchoice)
							sleep(4)
						if("Retaliate")
							if(battler4.sp<30)
								usr.send_chat("<font color=[battler4.textcolor]<b>[battler4] has attempted to use Retaliate, but could not spend 30 SP, and has forfeited their turn!", stream = "icout")
							else
								var/target=input(battler4,"Which enemy would you like to attack, setting Retaliate up?") as anything in enemylist
								battler4.turnattack(battler2,target)
								usr.send_chat("<font color=[battler4.textcolor]<b>[battler4] has entered a <b>Retaliation</b> stance!", stream = "icout")
								battler4.sp-=30
								battler4.retaliate=1
						if("Infusion")
							var/list/Infusions=list("Fire","Water","Ice","Thunder","Wind","Holy","Dark","Flare")
							var/infuchoice=input(battler4,"Which Infusion would you like to apply to your weapon?") as anything in Infusions
							battler4.infusion=infuchoice
							usr.send_chat("<font color=[battler4.textcolor]<b>[battler4] has set their Infusion type to [infuchoice]!", stream = "icout")
						if("Summon")
							var/target=input(battler4,"Which enemy would you like to summon a companion to attack?") as anything in enemylist
							var/summon=input(battler4,"Which companion would you like to call on the power of?") as anything in summonlist4
							Summonattack(battler4, target, summon)
						if("Attack")
							var/target=input(battler4,"Which enemy would you like to attack?") as anything in enemylist
							battler4.turnattack(battler4,target)
							sleep(4)
						if("Ability")
							attackchoice=input(battler4,"Which Ability would you like to use this turn?") as anything in pattacklist4
							var/target=input(battler4,"Which enemy would you like to attack?") as anything in enemylist
							battler4.TurnAbility(battler4,target,attackchoice)
							sleep(4)
						if("Heal")
							var/target=input(battler4,"Which ally would you like to heal?") as anything in battlelist
							healchoice=input(battler4,"Which Healing ability would you like to use this turn?") as anything in heallist4
							battler4.Heal(battler4,target,healchoice)
							sleep(4)
						if("Rest")
							var/conboost=(6*battler4.conmod)
							var/rest2=conboost+10
							var/rest1=conboost+5
							var/restvalue=rand(rest1,rest2)
							usr.send_chat("<font color=[battler4.textcolor]><b>[battler4]</font> has decided to rest, and restores [restvalue] HP and MP!!", stream = "icout")
							battler4.hp+=restvalue
							battler4.mp+=restvalue
							if(battler4.hp>battler4.mhp)
								battler4.hp=battler4.mhp
							if(battler4.mp>battler4.mmp)
								battler4.mp=battler4.mmp
						if("Green Magic")
							var/obj/perk/spell=input(battler4,"Which Green Magic ability would you like to use?") as anything in greenlist4
							if(spell.dispel>=1)
								if(spell.multi==1)
									for(var/obj/npc/a in enemylist)
										DispelPlayer(battler4, a, spell)
								if(spell.multi==0)
									var/dispelchoice=input(battler4,"Which enemy would you like to dispel an effect from?") as anything in enemylist
									DispelPlayer(battler4, dispelchoice, spell)
							if(spell.multi==0)
								var/targetchoice=input(battler4,"Who would you like to use it on?") as anything in battlelist
								GreenMagicOne(battler4, targetchoice, spell)
							if(spell.multi==1)
								if(battler1state=="Alive")
									GreenMagicOne(battler4, battler1, spell)
								if(battler2state=="Alive")
									GreenMagicOne(battler4, battler2, spell)
								if(battler3state=="Alive")
									GreenMagicOne(battler4,battler3, spell)
								if(battler4state=="Alive")
									GreenMagicOne(battler4,battler4, spell)
						if("Revive")
							var/list/revivechoice=list()
							if(battler1state!="Alive")
								revivechoice+=battler1
							if(battler2state!="Alive")
								revivechoice+=battler2
							if(battler3state!="Alive")
								revivechoice+=battler3
							if(battler4state!="Alive")
								revivechoice+=battler4
							var/obj/perk/spell=input(battler4,"Which revive Spell would you like to use?") as anything in revivelist4
							if(spell.multi==0)
								var/mob/choice=input(battler4,"Who would you like to revive with this Spell?") as anything in revivechoice
								Revive(battler4, choice, spell)
								if(choice.bposition=="battler1")
									battler1state="Alive"
									battlelist+=choice
									battlers+=1
									b1counted=0
								if(choice.bposition=="battler2")
									battler2state="Alive"
									battlelist+=choice
									battlers+=1
									b2counted=0
								if(choice.bposition=="battler3")
									battler3state="Alive"
									battlelist+=choice
									battlers+=1
									b3counted=0
								if(choice.bposition=="battler4")
									battler4state="Alive"
									battlelist+=choice
									battlers+=1
									b4counted=0
							if(spell.multi==1)
								if(battler1state!="Alive")
									battler1state="Alive"
									battlelist+=battler1
									Revive(battler4, battler1, spell)
									battlers+=1
									b1counted=0
								if(battler2state!="Alive")
									battler2state="Alive"
									battlelist+=battler2
									Revive(battler4, battler2, spell)
									battlers+=1
									b2counted=0
								if(battler3state!="Alive")
									battler3state="Alive"
									battlelist+=battler3
									Revive(battler4, battler3, spell)
									battlers+=1
									b3counted=0
								if(battler4state!="Alive")
									battler4state="Alive"
									battlelist+=battler4
									Revive(battler4, battler4, spell)
									battlers+=1
									b4counted=0
			sleep(1)
			if(maxenemies>=1)
				if(enemy.hp<=0 && e1counted==0)
					enemystate=0
					enemies-=1
					e1counted=1
					enemylist-=enemy
					usr.send_chat("[enemy] is defeated [enemies]/[maxenemies]", stream = "icout")
					sleep(4)
			if(maxenemies>=2)
				if(enemy2.hp<=0 && e2counted==0)
					enemy2state=0
					enemies-=1
					e2counted=1
					enemylist-=enemy2
					usr.send_chat("[enemy2] is defeated [enemies]/[maxenemies]", stream = "icout")
					sleep(4)
			if(maxenemies>=3)
				if(enemy3.hp<=0 && e3counted==0)
					enemy3state=0
					enemies-=1
					e3counted=1
					enemylist-=enemy3
					usr.send_chat("[enemy3] is defeated [enemies]/[maxenemies]", stream = "icout")
					sleep(4)
			if(maxenemies>=4)
				if(enemy4.hp<=0 && e4counted==0)
					enemy4state=0
					enemies-=1
					e4counted=1
					enemylist-=enemy4
					usr.send_chat("[enemy4] is defeated [enemies]/[maxenemies]", stream = "icout")
					sleep(4)
			sleep(1)
			if(enemies<=0)
				enemy.visible_message("All Enemies have been defeated! <b>FATE</b> complete!!", stream = "icout")
				del enemy2
				del enemy3
				del enemy4
				for(var/obj/Party/c in world)
					if(battler1.partyID==c.partyID)
						for(var/obj/FATECrystal/b in global.fate_crystals)
							if("[b.FATEID]"=="[c.FATEID]")
								Victory(c,b)
								enemyalive=0
								maxbattlers=0
								enemies=0
								sleep(4)
								del enemy
			sleep(1)





/obj/proc/Checkdamtype(t as text,var/obj/npc/m)
	var/result=0
	if(t=="str")
		result=m.strmod
	else if(t=="dex")
		result=m.dexmod
	else if(t=="con")
		result=m.conmod
	else if(t=="int")
		result=m.intmod
	else if(t=="wis")
		result=m.wismod
	else if(t=="cha")
		result=m.chamod
	return result

LEGACY_GLOBAL_DATUM_INIT(npc_archive, /datum/global_npc_archive, new)
/**
 * global npc holder
 */
/datum/global_npc_archive
	/// npcs - untyped for now
	var/list/npcs = list()

obj
	overimage

	npc
		icon='Icons/Moogle.dmi'
		layer=3
		waterwalking=1
		vehicletype="player"
		var
			initialized=0
			critmod=0
			aggro=0
			agtarget=null
			overimage
			textcolor
			eweapon=0
			npcweapon = 0
			summon=0
			scholarsum=0
			price
			FATENpc=0
			FATEID=null
			weakness
			resistance
			rank
			obj/npc/enemy2
			obj/npc/enemy3
			obj/npc/enemy4
			companiontype=null

			reflexproficient=1
			willproficient=1
			fortitudeproficient=1
			reflexexpert=0
			willexpert=0
			fortitudeexpert=0


			baseac=10
			ac=0
			acmod=0
			basedr
			dr=0
			speed=3
			special

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
			rankbonus=0
			encountersize=1

			pab=0
			pdb=0
			mab=0
			mdb=0

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
			battling=0

			baserflx=0
			rflx
			basewill=0
			will
			basefort=0
			fort
			inarchive
			archived=0
		Click()
			if(src.FATENpc==1)
				if(src.battling==1)
					return
				else
					src.battling=1
					var/questparty
					for(var/obj/Party/a in world)
						if(a.partyID==usr.partyID)
							questparty=a
					Startbattle(usr,src,questparty)
			if(src in global.stablemaster_obj?.contents)
				if(usr.job=="Beast Master" || usr.subjob=="Beast Master")
					alert(usr,"[src.desc]")
					var/list/buychoice=list("Yes","No")
					var/buy=input("Would you like to buy this Monster?") as anything in buychoice
					switch(buy)
						if("Yes")
							if(usr.money>=src.price)
								var/obj/npc/c = copyatom(src)
								usr.contents+=c
								usr.money-=src.price
								c.owner=usr.key
								c.archived=0
							else
								alert(usr,"You don't have enough money to purchase this Monster!")
								return
						if("No")
							return
				else
					alert(usr,"Only a Beastmaster is able to buy Monsters from a Stablemaster.")
					return
			else
				if (src in global.stablemaster_obj?.contents)
					return
				if(src in global.npc_archive.npcs)
					usr.npcachoice = src
					winset(usr,"NPCarchive.hp","text=\"[src.mhp]\"")
					winset(usr,"NPCarchive.mp","text=\"[src.mmp]\"")
					winset(usr,"NPCarchive.sp","text=\"[src.msp]\"")
					winset(usr,"NPCarchive.str","text=\"[src.str]\"")
					winset(usr,"NPCarchive.dex","text=\"[src.dex]\"")
					winset(usr,"NPCarchive.con","text=\"[src.con]\"")
					winset(usr,"NPCarchive.int","text=\"[src.int]\"")
					winset(usr,"NPCarchive.wis","text=\"[src.wis]\"")
					winset(usr,"NPCarchive.cha","text=\"[src.cha]\"")
					winset(usr,"NPCarchive.rflx","text=\"[src.rflx]\"")
					winset(usr,"NPCarchive.fort","text=\"[src.fort]\"")
					winset(usr,"NPCarchive.will","text=\"[src.will]\"")
					winset(usr,"NPCarchive.ac","text=\"[src.baseac]\"")
					winset(usr,"NPCarchive.dr","text=\"[src.dr]\"")
					winset(usr,"NPCarchive.spd","text=\"[src.speed]\"")
					winset(usr,"NPCarchive.acro","text=\"[src.acrobatics]\"")
					winset(usr,"NPCarchive.ath","text=\"[src.athletics]\"")
					winset(usr,"NPCarchive.arc","text=\"[src.archaeology]\"")
					winset(usr,"NPCarchive.dec","text=\"[src.deception]\"")
					winset(usr,"NPCarchive.dungdisplay","text=\"[src.dungeoneering]\"")
					winset(usr,"NPCarchive.encdisplay","text=\"[src.enchantment]\"")
					winset(usr,"NPCarchive.ins","text=\"[src.insight]\"")
					winset(usr,"NPCarchive.inv","text=\"[src.investigation]\"")
					winset(usr,"NPCarchive.magdisplay","text=\"[src.magic]\"")
					winset(usr,"NPCarchive.magi","text=\"[src.magitekOperation]\"")
					winset(usr,"NPCarchive.med","text=\"[src.medicine]\"")
					winset(usr,"NPCarchive.natdisplay","text=\"[src.naturalist]\"")
					winset(usr,"NPCarchive.per","text=\"[src.perception]\"")
					winset(usr,"NPCarchive.persdisplay","text=\"[src.persuasion]\"")
					winset(usr,"NPCarchive.sth","text=\"[src.stealth]\"")
					winset(usr,"NPCarchive.sur","text=\"[src.survival]\"")
					winset(usr,"NPCarchive.thv","text=\"[src.thievery]\"")
					winset(usr,"NPCarchive.overp","image=[src.icon]")
		DblClick()
			if(src in usr.contents)
				var/list/options = list("Deploy","View Sheet","Change Overpic","Delete")
				if(usr.adminlv>=1)
					options+="Archive NPC"
					options+="Edit Stats"
				var/choice = input("What do you wish to do with the NPC?") as null|anything in options
				switch(choice)
					if(null)
						return
					if("Deploy")
						usr.deploynpc=src
						usr.building=0
						usr.aoeclick=0
						usr.send_chat("Double click an area to deploy your npc.","oocout")
						RefreshNPC(usr)
						return
					if("View Sheet")
						viewsheet(usr,src)
					if("Edit Stats")
						winset(usr,"EditNPC","is-visible=true")
						usr.npcsheet = src
						winset(usr,"EditNPC.strdisplay","text=\"[src.str]\"")
						winset(usr,"EditNPC.hpdisplay","text=\"[src.mhp]\"")
						winset(usr,"EditNPC.mpdisplay","text=\"[src.mmp]\"")
						winset(usr,"EditNPC.spdisplay","text=\"[src.msp]\"")
						winset(usr,"EditNPC.acdisplay","text=\"[src.baseac]\"")
						winset(usr,"EditNPC.pdbdisplay","text=\"[src.pdb]\"")
						winset(usr,"EditNPC.mdbdisplay","text=\"[src.mdb]\"")
						winset(usr,"EditNPC.mabdisplay","text=\"[src.mab]\"")
						winset(usr,"EditNPC.pabdisplay","text=\"[src.pab]\"")
						winset(usr,"EditNPC.strdisplay","text=\"[src.str]\"")
						winset(usr,"EditNPC.dexdisplay","text=\"[src.dex]\"")
						winset(usr,"EditNPC.condisplay","text=\"[src.con]\"")
						winset(usr,"EditNPC.intdisplay","text=\"[src.int]\"")
						winset(usr,"EditNPC.wisdisplay","text=\"[src.wis]\"")
						winset(usr,"EditNPC.chadisplay","text=\"[src.cha]\"")
						winset(usr,"EditNPC.rflxdisplay","text=\"[src.rflx]\"")
						winset(usr,"EditNPC.fortdisplay","text=\"[src.fort]\"")
						winset(usr,"EditNPC.willdisplay","text=\"[src.will]\"")
						winset(usr,"EditNPC.acrodisplay","text=\"[src.baseacro]\"")
						winset(usr,"EditNPC.athdisplay","text=\"[src.baseath]\"")
						winset(usr,"EditNPC.arcdisplay","text=\"[src.basearc]\"")
						winset(usr,"EditNPC.decdisplay","text=\"[src.basedec]\"")
						winset(usr,"EditNPC.dungdisplay","text=\"[src.basedung]\"")
						winset(usr,"EditNPC.encdisplay","text=\"[src.baseenchant]\"")
						winset(usr,"EditNPC.insdisplay","text=\"[src.basein]\"")
						winset(usr,"EditNPC.invdisplay","text=\"[src.baseinv]\"")
						winset(usr,"EditNPC.magdisplay","text=\"[src.basemagic]\"")
						winset(usr,"EditNPC.magidisplay","text=\"[src.basemagio]\"")
						winset(usr,"EditNPC.meddisplay","text=\"[src.basemed]\"")
						winset(usr,"EditNPC.natdisplay","text=\"[src.basenat]\"")
						winset(usr,"EditNPC.perdisplay","text=\"[src.baseper]\"")
						winset(usr,"EditNPC.persdisplay","text=\"[src.basepers]\"")
						winset(usr,"EditNPC.sthdisplay","text=\"[src.basestl]\"")
						winset(usr,"EditNPC.thvdisplay","text=\"[src.basethv]\"")
						winset(usr,"EditNPC.surdisplay","text=\"[src.basesurv]\"")
					if("Change Overpic")
						var/i = input("Upload a pic.") as null|icon
						src.overimage=i
					if("Archive NPC")
						var/obj/npc/N = copyatom(src)
						N.inarchive=1
						for(var/obj/perk/p in N.contents)
							var/op = copyatom(p)
							src.contents+=op
						global.npc_archive.npcs += N
					if("Delete")
						switch(alert("Are you sure you want to delete this NPC?","Yes","No"))
							if("Yes")
								usr.npcamount--
								del(src)
							if("No")
								return
			else if(src in world)
				if(src.owner != usr.key)
					return
				if(src.archived==1)
					return
				else
					var/list/options2 = list("Recall","View Sheet","Emote")
					var/choice2 = input("What do you wish to do with the NPC?") as null|anything in options2
					switch(choice2)
						if(null)
							return
						if("Recall")
							if(src.scion)
								del src
							if(src.materiasummon)
								del src
							else
								usr.contents+=src
								src.overlays=null
								src.Savable=0
								RefreshNPC(usr)
						if("View Sheet")
							viewsheet(usr,src)
						if("Emote")
							src.overlays+='Rping.dmi'
							var/m = input("What does your character wish to do?")as message
							if(!m)
								src.overlays-='Rping.dmi'
								return
							else
								visible_message("<font color=[src.textcolor]><font size = 0.5>[src.name] [m]", stream = "icout")
								src.overlays-='Rping.dmi'
			else if(src.inarchive==1)
				return
		MouseDrop(o_o,s_l,o_l)
			if(src in usr.contents)
				return
			if(src.owner==usr.key)
				walk_to(src,o_l)
				sleep(4)
				walk(src,0)

		bob
			icon='Mannequin.dmi'
		Summons
			companiontype="Summon"
			DRank
				rank="D"
				Carbuncle
					resistance="Holy"
					icon='Icons/Summon/Carbuncle.png'
					summon=1
					mhp=90
					hp=90
					mmp=120
					mp=120
					sp=90
					msp=90
					baseac=15
					str=10
					strmod=0
					dex=16
					dexmod=3
					con=12
					conmod=1
					int=12
					intmod=1
					wis=12
					wismod=1
					cha=16
					chamod=3
					mab=7
					pab=1
					mdb=30
					pdb=5
					basedr=2
					New()
						var/obj/perk/monsterperk/Weakness_Lightning/a=new
						var/obj/perk/monsterperk/Resistance_Black_Magic/b=new
						var/obj/perk/monsterperk/Tiny/c=new
						var/obj/perk/monsterperk/Mana_Connection/d=new
						var/obj/perk/CarbunclePerk/Reaction_Emergency_Protection/e=new
						var/obj/perk/CarbunclePerk/Bonus_Action_Extended_Casting/f=new
						var/obj/perk/MonsterAttacks/Claw/wep=new
						var/obj/perk/MonsterAbilities/BLU/Ruby_Light/g=new
						var/obj/perk/MonsterAbilities/BLU/Emerald_Light/h=new
						var/obj/perk/MonsterAbilities/BLU/Diamond_Light/i=new
						var/obj/perk/MonsterAbilities/BLU/Moonstone_Light/j=new
						var/obj/perk/Abilities/WhiteMagic/Wind/Aero/k=new
						var/obj/perk/SummonPassives/Carbuncle/summ=new
						src.contents+=summ
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=e
						src.contents+=f
						src.contents+=g
						src.contents+=h
						src.contents+=i
						src.contents+=j
						src.contents+=k
						src.contents+=wep
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb
				Sylph
					resistance="Holy"
					icon='Icons/Summon/Sylph.png'
					summon=1
					mhp=80
					hp=80
					mmp=90
					mp=90
					sp=80
					msp=80
					baseac=14
					ac=14
					str=12
					strmod=1
					dex=16
					dexmod=3
					con=12
					conmod=1
					int=10
					intmod=0
					wis=14
					wismod=2
					cha=10
					chamod=0
					mab=3
					pab=2
					mdb=15
					pdb=10
					fort = 3
					rflx = 5
					will = 4
					speed = 6
					basedr=2
					New()
						var/obj/perk/Abilities/WhiteMagic/Healing/Cure/a=new
						var/obj/perk/Abilities/WhiteMagic/Wind/Aero/b=new
						var/obj/perk/MonsterAbilities/BLU/Whispering_Wind/c=new
						var/obj/perk/monsterperk/Weakness_Lightning/d=new
						var/obj/perk/monsterperk/Resistance_Wind/e=new
						var/obj/perk/monsterperk/Mana_Connection/f=new
						var/obj/perk/monsterperk/Tiny/g=new
						var/obj/perk/monsterperk/Fly_1/h=new
						var/obj/perk/MonsterAttacks/Claw/wep=new
						var/obj/perk/SummonPassives/Sylph/summ=new
						var/obj/perk/SylphPerk/Bonus_Action_Lullaby/i=new
						var/obj/perk/SylphPerk/Reaction_Soften_The_Blow_Minor/j=new
						src.contents+=summ
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=e
						src.contents+=f
						src.contents+=g
						src.contents+=h
						src.contents+=i
						src.contents+=j
						src.contents+=wep
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb
				Boko
					resistance="Nature"
					icon='Icons/Summon/Boko.png'
					summon=1
					mhp=70
					hp=70
					mmp=110
					mp=110
					sp=70
					msp=70
					baseac=14
					ac=14
					str=14
					strmod=2
					dex=18
					dexmod=4
					con=12
					conmod=1
					int=12
					intmod=1
					wis=12
					wismod=1
					cha=12
					chamod=1
					mab=3
					pab=2
					mdb=25
					pdb=20
					fort = 2
					rflx = 5
					will = 2
					speed = 9
					basedr=1
					New()
						var/obj/item/Weapon/NPCWeapons/Claw/a=new
						var/obj/perk/SummonPassives/Boko/summ=new
						var/obj/perk/monsterperk/Weakness_Lightning/b=new
						var/obj/perk/monsterperk/Resistance_Wind/c=new
						var/obj/perk/monsterperk/Swift/d=new
						var/obj/perk/monsterperk/Mount_1/e=new
						var/obj/perk/MonsterAbilities/BLU/ChocoKick/f=new
						var/obj/perk/BokoPerk/Reaction_BokoSentinel/g=new
						var/obj/perk/BokoPerk/Bonus_Action_BokoSwift/h=new
						var/obj/perk/Abilities/GreenMagic/Haste/i=new
						src.contents+=summ
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=e
						src.contents+=f
						src.contents+=g
						src.contents+=h
						src.contents+=i
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb

				Remora
					resistance="Water"
					icon='Icons/Summon/Remora.png'
					summon=1
					mhp=70
					hp=70
					mmp=200
					mp=200
					sp=200
					msp=200
					baseac=12
					str=10
					strmod=0
					dex=14
					dexmod=2
					con=10
					conmod=0
					int=10
					intmod=0
					wis=10
					wismod=0
					cha=10
					chamod=0
					mab=0
					pab=5
					mdb=0
					pdb=15
					basedr=0
					New()
						var/obj/item/Weapon/NPCWeapons/Bite/a=new
						src.contents+=a
						var/obj/perk/Abilities/BlackMagic/Hydro/Water/b=new
						src.contents+=b
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb
						var/obj/perk/SummonPassives/Remora/summ=new
						src.contents+=summ
				CaitSith
					resistance="Dark"
					icon='Icons/Summon/CaitSith.png'
					summon=1
					mhp=80
					hp=80
					mmp=250
					mp=250
					sp=250
					msp=80
					baseac=13
					str=10
					strmod=0
					dex=14
					dexmod=2
					con=10
					conmod=-0
					int=10
					intmod=-0
					wis=12
					wismod=1
					cha=10
					chamod=0
					mab=0
					pab=5
					mdb=0
					pdb=5
					basedr=0
					New()
						var/obj/item/Weapon/NPCWeapons/Claw/a=new
						src.contents+=a
						var/obj/perk/Abilities/GreenMagic/Bravery/b=new
						var/obj/perk/Abilities/GreenMagic/Faith/c=new
						src.contents+=b
						src.contents+=c
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb
						var/obj/perk/SummonPassives/CaitSith/summ=new
						src.contents+=summ
			CRank
				rank="C"
				/*AdultDrake
					name="Adult Drake"
					icon='Icons/Monsters/Dragonblue.png'
					summon=1
					mhp=255
					hp=255
					mmp=200
					mp=200
					msp=200
					sp=200
					baseac=22
					str=20
					strmod=5
					dex=18
					dexmod=4
					con=18
					conmod=4
					int=12
					intmod=1
					wis=12
					wismod=1
					cha=12
					chamod=1
					mab=11
					pab=11
					pdb=22
					mdb=18
					speed=4
					New()
						var/obj/perk/MonsterAbilities/Monster/DragonClaws/a=new
						var/obj/perk/MonsterAbilities/BLU/MonsterFlame/flame=new
						var/obj/perk/MonsterPassives/Rideable/b=new
						var/obj/perk/MonsterPassives/Flight/c=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=flame
				ChocoSteed
					name="Chocobo Steed"
					icon='Icons/Summon/Boko.png'
					summon=1
					mhp=200
					hp=200
					mmp=200
					mp=200
					msp=200
					sp=200
					baseac=22
					str=20
					strmod=5
					dex=18
					dexmod=4
					con=18
					conmod=4
					int=12
					intmod=1
					wis=12
					wismod=1
					cha=12
					chamod=1
					mab=8
					pab=8
					pdb=18
					mdb=18
					speed=4
					New()
						var/obj/perk/MonsterAbilities/Monster/ChocoKick/a=new
						var/obj/perk/MonsterPassives/Rideable/b=new
						src.contents+=a
						src.contents+=b*/
				Ifrit
					resistance="Fire"
					icon='Icons/Summon/Ifrit.png'
					summon=1
					mhp=200
					hp=200
					mmp=220
					mp=220
					sp=240
					msp=240
					baseac=13
					ac=15
					str=14
					strmod=2
					dex=14
					dexmod=2
					con=18
					conmod=4
					int=10
					intmod=0
					wis=14
					wismod=2
					cha=10
					chamod=0
					mab=2
					pab=2
					mdb=20
					pdb= 15
					fort = 8
					rflx = 6
					will = 5
					speed = 6
					basedr=7
					New()
						var/obj/perk/monsterperk/Weakness_Ice/a=new
						var/obj/perk/monsterperk/Resistance_Fire/b=new
						var/obj/perk/monsterperk/Immune_Fire/c=new
						var/obj/perk/monsterperk/Large/d=new
						var/obj/perk/monsterperk/Fire_Healing/e=new
						var/obj/perk/monsterperk/Fire_Skin/f=new
						var/obj/perk/monsterperk/Reach_10ft/g=new
						var/obj/perk/monsterperk/Fire_Adept/h=new
						var/obj/perk/IfritPerk/Reaction_Fire_Power/i=new
						var/obj/perk/IfritPerk/Bonus_Action_Fire_Poke/j=new
						var/obj/perk/Abilities/BlackMagic/Flame/Fire/k=new
						var/obj/perk/Abilities/BlackMagic/Flame/Fira/l=new
						var/obj/perk/MonsterAbilities/BLU/Hellfire/m=new
						var/obj/perk/MonsterAttacks/Claw/n=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=e
						src.contents+=f
						src.contents+=g
						src.contents+=h
						src.contents+=i
						src.contents+=j
						src.contents+=k
						src.contents+=l
						src.contents+=m
						src.contents+=n
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb
						var/obj/perk/SummonPassives/Ifrit/summ=new
						src.contents+=summ
				Shiva
					resistance="Ice"
					icon='Icons/Summon/Shiva.png'
					summon=1
					mhp=180
					hp=180
					mmp=300
					mp=300
					sp=180
					msp=180
					baseac=13
					ac=13
					str=12
					strmod=1
					dex=16
					dexmod=3
					con=12
					conmod=1
					int=10
					intmod=0
					wis=14
					wismod=2
					cha=10
					chamod=0
					mab=2
					pab=2
					mdb=25
					pdb=15
					fort = 5
					rflx = 7
					will = 7
					speed = 6
					basedr=4
					New()
						var/obj/perk/Abilities/BlackMagic/Ice/Blizzard/a=new
						var/obj/perk/Abilities/BlackMagic/Ice/Blizzara/b=new
						var/obj/item/Weapon/NPCWeapons/Punch/c=new
						var/obj/perk/monsterperk/Weakness_Fire/d=new
						var/obj/perk/monsterperk/Resistance_Ice/e=new
						var/obj/perk/monsterperk/Immune_Ice/f=new
						var/obj/perk/monsterperk/Ice_Healing/g=new
						var/obj/perk/monsterperk/Cold_Shoulder/h=new
						var/obj/perk/ShivaPerk/Reaction_Icy_Stare/i=new
						var/obj/perk/ShivaPerk/Bonus_Action_Blizzard_Kiss/j=new
						var/obj/perk/MonsterAbilities/BLU/Diamond_Dust/k=new
						src.contents+=a
						src.contents+=b
						c.name="Kick"
						src.contents+=c
						src.contents+=d
						src.contents+=e
						src.contents+=f
						src.contents+=g
						src.contents+=h
						src.contents+=i
						src.contents+=j
						src.contents+=k
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb
						var/obj/perk/SummonPassives/Shiva/summ=new
						src.contents+=summ
				Ramuh
					resistance="Thunder"
					icon='Icons/Summon/Ramuh.png'
					summon=1
					mhp=180
					hp=180
					mmp=320
					mp=320
					sp=180
					msp=180
					baseac=11
					ac=13
					str=10
					strmod=0
					dex=14
					dexmod=2
					con=12
					conmod=1
					int=10
					intmod=0
					wis=16
					wismod=3
					cha=10
					chamod=0
					mab=0
					pab=0
					mdb=25
					pdb=10
					fort = 5
					rflx = 6
					will = 8
					speed = 6
					basedr=4
					New()
						var/obj/perk/Abilities/BlackMagic/Lightning/Thunder/a=new
						var/obj/perk/Abilities/BlackMagic/Lightning/Thundara/b=new
						var/obj/perk/MonsterAbilities/BLU/Judgement_Bolt/d=new
						var/obj/item/Weapon/NPCWeapons/Staff/c=new
						var/obj/perk/monsterperk/Weakness_Wind/e=new
						var/obj/perk/monsterperk/Resistance_Lightning/f=new
						var/obj/perk/monsterperk/Immune_Lightning/g=new
						var/obj/perk/monsterperk/Wizen_Sage/h=new
						var/obj/perk/monsterperk/Thunder_Healing/i=new
						var/obj/perk/monsterperk/Spark_of_Anger/j=new
						var/obj/perk/RamuhPerk/Reaction_Eyes_In_The_Back_Of_My_Head/k=new
						var/obj/perk/RamuhPerk/Bonus_Action_Thunder_Party/l=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=e
						src.contents+=f
						src.contents+=g
						src.contents+=h
						src.contents+=i
						src.contents+=j
						src.contents+=k
						src.contents+=l
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb
						var/obj/perk/SummonPassives/Ramuh/summ=new
						src.contents+=summ
/*				Siren
					resistance="Wind"
					icon='Icons/Summon/Siren.png'
					summon=1
					mhp=80
					hp=80
					mmp=200
					mp=200
					sp=200
					msp=200
					baseac=13
					str=10
					strmod=0
					dex=14
					dexmod=2
					con=10
					conmod=0
					int=10
					intmod=0
					wis=14
					wismod=2
					cha=16
					chamod=3
					mab=8
					pab=0
					mdb=7
					pdb=0
					basedr=0
					New()
						var/obj/perk/Abilities/ArcaneMagic/Statusinfliction/Silence/a=new
						var/obj/perk/Abilities/ArcaneMagic/Statusinfliction/Sleep/b=new
						var/obj/perk/Abilities/WhiteMagic/Wind/Aero/ab=new
						var/obj/perk/Abilities/WhiteMagic/Wind/Aerora/bb=new
						var/obj/perk/Abilities/Bard/NaturesMinne/d=new
						var/obj/perk/Abilities/Bard/SinewyEtude/d1=new
						var/obj/perk/Abilities/Bard/LearnedEtude/d3=new
						var/obj/item/Weapon/NPCWeapons/Harp/c=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=ab
						src.contents+=bb
						src.contents+=d
						src.contents+=d1
						src.contents+=d3
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb
						var/obj/perk/SummonPassives/Siren/summ=new
						src.contents+=summ
				Golem
					resistance="Earth"
					icon='Icons/Summon/Golem.png'
					summon=1
					mhp=115
					hp=115
					mmp=200
					mp=200
					sp=200
					msp=200
					baseac=13
					str=12
					strmod=1
					dex=10
					dexmod=0
					con=16
					conmod=3
					int=10
					intmod=0
					wis=14
					wismod=2
					cha=10
					chamod=0
					mab=7
					pab=7
					mdb=7
					pdb=7
					basedr=3
					New()
						var/obj/perk/Abilities/Geomancer/Earth/Stone/a=new
						var/obj/perk/Abilities/Geomancer/Earth/Stonra/b=new
						var/obj/item/Weapon/NPCWeapons/Punch/sf=new
						src.contents+=a
						src.contents+=b
						src.contents+=sf
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb
						var/obj/perk/SummonPassives/Golem/summ=new
						src.contents+=summ
				Kirin
					resistance="Holy"
					icon='Icons/Summon/Kirin.png'
					summon=1
					mhp=95
					hp=95
					mmp=80
					mp=80
					sp=80
					msp=80
					baseac=16
					str=10
					strmod=0
					dex=12
					dexmod=1
					con=10
					conmod=0
					int=10
					intmod=0
					wis=10
					wismod=0
					cha=16
					chamod=3
					mab=7
					pab=6
					mdb=8
					pdb=7
					basedr=0
					New()
						var/obj/perk/Abilities/WhiteMagic/Healing/Regen/a=new
						var/obj/perk/Abilities/WhiteMagic/Healing/Cure/b=new
						var/obj/perk/Abilities/WhiteMagic/Healing/Curaga/c=new
						var/obj/perk/Abilities/WhiteMagic/Status/Esuna/d=new
						var/obj/perk/Abilities/WhiteMagic/Holy/Diara/e=new
						var/obj/item/Weapon/NPCWeapons/Horn/sf=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=e
						src.contents+=sf
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb
						var/obj/perk/SummonPassives/Kirin/summ=new
						src.contents+=summ*/
			BRank
				rank="B"
				rankbonus=3
				AlphaDrake
/*					name="Alpha Drake"
					icon='Icons/Monsters/Dragonblue.png'
					summon=1
					mhp=300
					hp=300
					mmp=250
					mp=250
					msp=250
					sp=250
					baseac=28
					str=20
					strmod=5
					dex=18
					dexmod=4
					con=18
					conmod=4
					int=12
					intmod=1
					wis=12
					wismod=1
					cha=12
					chamod=1
					mab=13
					pab=13
					pdb=25
					mdb=25
					speed=5
					basedr=8
					New()
						var/obj/perk/MonsterAbilities/Monster/DragonClaws/a=new
						var/obj/perk/MonsterAbilities/BLU/MonsterFlame/flame=new
						var/obj/perk/MonsterAbilities/BLU/Flamethrower/flame2=new
						var/obj/perk/MonsterPassives/Rideable/b=new
						var/obj/perk/MonsterPassives/Flight/c=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=flame
						src.contents+=flame2
				FatChocobo
					name="Fat Chocobo"
					icon='Icons/Summon/FatBoko.png'
					summon=1
					mhp=450
					hp=450
					mmp=300
					mp=300
					msp=300
					sp=300
					baseac=30
					str=24
					strmod=7
					dex=14
					dexmod=2
					con=26
					conmod=8
					int=12
					intmod=1
					wis=12
					wismod=1
					cha=12
					chamod=1
					mab=10
					pab=10
					pdb=15
					mdb=15
					speed=2
					New()
						var/obj/perk/MonsterAbilities/Monster/ChocoKick/a=new
						var/obj/perk/MonsterPassives/Rideable/b=new
						var/obj/perk/Jobperks/Paladin/BathedinLight/bathed=new
						var/obj/perk/Jobperks/Paladin/DivineRetribution/thorns=new
						src.contents+=a
						src.contents+=b
						src.contents+=bathed
						src.contents+=thorns
				RedChocobo
					name="Red Chocobo"
					icon='Icons/Summon/RedBoko.png'
					summon=1
					mhp=290
					hp=290
					mmp=300
					mp=300
					msp=300
					sp=300
					baseac=24
					str=24
					strmod=7
					dex=22
					dexmod=6
					con=18
					conmod=4
					int=12
					intmod=1
					wis=12
					wismod=1
					cha=12
					chamod=1
					mab=15
					pab=19
					pdb=30
					mdb=8
					speed=5
					New()
						var/obj/perk/MonsterAbilities/Monster/ChocoKick/a=new
						var/obj/perk/MonsterPassives/Rideable/b=new
						var/obj/perk/Abilities/Monk/DragonDash/ddash=new
						var/obj/perk/Abilities/Monk/Combo/combo=new
						var/obj/perk/Abilities/Monk/BurningArrow/barrow=new
						var/obj/perk/Abilities/Monk/TornadoKick/tkick=new
						src.contents+=a
						src.contents+=b
						src.contents+=ddash
						src.contents+=combo
						src.contents+=barrow
						src.contents+=tkick
				BlackChocobo
					name="Black Chocobo"
					icon='Icons/Summon/BlackBoko.png'
					summon=1
					mhp=310
					hp=310
					mmp=300
					mp=300
					msp=300
					sp=300
					baseac=24
					str=20
					strmod=5
					dex=18
					dexmod=4
					con=18
					conmod=4
					int=12
					intmod=1
					wis=12
					wismod=1
					cha=12
					chamod=1
					mab=15
					pab=8
					pdb=18
					mdb=25
					speed=5
					New()
						var/obj/perk/MonsterAbilities/Monster/ChocoKick/a=new
						var/obj/perk/Abilities/ArcaneMagic/Darkness/Dark/dark1=new
						var/obj/perk/Abilities/ArcaneMagic/Darkness/Darkja/dark2=new
						var/obj/perk/Abilities/WhiteMagic/Wind/Aeroja/aero=new
						var/obj/perk/MonsterPassives/Rideable/b=new
						var/obj/perk/MonsterPassives/Flight/c=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=dark1
						src.contents+=dark2
						src.contents+=aero*/
				Titan
					resistance="Earth"
					icon='Icons/Summon/Titan.png'
					summon=1
					mhp=400
					hp=400
					mmp=360
					mp=360
					sp=400
					msp=400
					baseac=13
					ac=13
					str=22
					strmod=6
					dex=10
					dexmod=0
					con=18
					conmod=4
					int=10
					intmod=0
					wis=14
					wismod=2
					cha=10
					chamod=0
					mab=8
					pab=12
					mdb=40
					pdb=60
					fort = 11
					rflx = 7
					will = 9
					speed = 5
					basedr=15
					New()
						var/obj/perk/Abilities/GreenMagic/Dualprotection/Stoneskin/a=new
						var/obj/perk/Abilities/GeneralMagicAbilities/Impact/b=new
						var/obj/perk/MonsterAbilities/BLU/Stone_Throw/c=new
						var/obj/perk/monsterperk/Weakness_Ice/d=new
						var/obj/perk/monsterperk/Resistance_Earth/e=new
						var/obj/perk/monsterperk/Resistance_Bludgeoning/f=new
						var/obj/perk/monsterperk/Large/g=new
						var/obj/perk/monsterperk/Thick_Skin/h=new
						var/obj/perk/monsterperk/Skybound_Pro/i=new
						var/obj/perk/monsterperk/Windup/j=new
						var/obj/perk/TitanPerk/Reaction_Fly_Swat/k=new
						var/obj/perk/TitanPerk/Bonus_Action_Muscle_Bulge/l=new
						var/obj/item/Weapon/NPCWeapons/Punch/sf=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=e
						src.contents+=f
						src.contents+=g
						src.contents+=h
						src.contents+=i
						src.contents+=j
						src.contents+=k
						src.contents+=l
						src.contents+=sf
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb
						var/obj/perk/SummonPassives/Titan/summ=new
						src.contents+=summ
/*				Garuda
					resistance="Wind"
					icon='Icons/Summon/Garuda.png'
					summon=1
					mhp=105
					hp=105
					mmp=200
					mp=200
					sp=90
					msp=90
					baseac=20
					str=10
					strmod=0
					dex=18
					dexmod=4
					con=10
					conmod=0
					int=12
					intmod=1
					wis=10
					wismod=0
					cha=20
					chamod=5
					mab=8
					pab=8
					mdb=12
					pdb=12
					basedr=0
					New()
						var/obj/perk/Abilities/WhiteMagic/Wind/Aero/a=new
						var/obj/perk/Abilities/WhiteMagic/Wind/Aerora/b=new
						var/obj/perk/Abilities/WhiteMagic/Wind/Aeroga/c=new
						var/obj/perk/Abilities/WhiteMagic/Wind/Aeroja/d=new
						var/obj/item/Weapon/NPCWeapons/RazorFeather/sf=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=sf
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb
						var/obj/perk/SummonPassives/Garuda/summ=new
						src.contents+=summ
				Bismark
					resistance="Water"
					icon='Icons/Summon/Bismark.png'
					summon=1
					mhp=155
					hp=155
					mmp=150
					mp=150
					sp=90
					msp=90
					baseac=18
					str=16
					strmod=3
					dex=10
					dexmod=0
					con=18
					conmod=4
					int=12
					intmod=1
					wis=14
					wismod=2
					cha=0
					chamod=0
					mab=9
					pab=6
					mdb=15
					pdb=7
					basedr=4
					New()
						var/obj/perk/Abilities/BlackMagic/Hydro/Water/a=new
						var/obj/perk/Abilities/BlackMagic/Hydro/Watera/b=new
						var/obj/perk/Abilities/BlackMagic/Hydro/Waterga/c=new
						var/obj/perk/Abilities/BlackMagic/Hydro/Waterja/d=new
						var/obj/item/Weapon/NPCWeapons/Ram/sf=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=sf
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb
						var/obj/perk/SummonPassives/Bismark/summ=new
						src.contents+=summ
				Fenrir
					resistance="Physical"
					icon='Icons/Summon/Fenrir.png'
					summon=1
					mhp=120
					hp=120
					mmp=150
					mp=100
					sp=120
					msp=120
					baseac=19
					str=18
					strmod=4
					dex=10
					dexmod=0
					con=18
					conmod=4
					int=14
					intmod=2
					wis=10
					wismod=0
					cha=0
					chamod=0
					mab=2
					pab=12
					mdb=5
					pdb=15
					basedr=1
					New()
						var/obj/perk/Abilities/GeneralWeaponAbilities/Melee/QuickHit/a=new
						var/obj/perk/Abilities/GeneralWeaponAbilities/Melee/Shout/b=new
						var/obj/perk/Abilities/GeneralWeaponAbilities/Melee/TriumphantGrasp/c=new
						var/obj/perk/Abilities/GeneralMagicAbilities/Ruin/d=new
						var/obj/item/Weapon/NPCWeapons/Claw/sf=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=sf
						src.eweapon=sf
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb
						var/obj/perk/SummonPassives/Fenrir/summ=new
						src.contents+=summ
				Ixion
					resistance="Thunder"
					icon='Icons/Summon/Ixion.png'
					summon=1
					mhp=125
					hp=125
					mmp=125
					mp=125
					sp=90
					msp=90
					baseac=17
					str=16
					strmod=2
					dex=10
					dexmod=1
					con=14
					conmod=2
					int=10
					intmod=0
					wis=18
					wismod=4
					cha=10
					chamod=0
					mab=12
					pab=7
					mdb=14
					pdb=6
					basedr=0
					New()
						var/obj/perk/Abilities/BlackMagic/Lightning/Thunder/a=new
						var/obj/perk/Abilities/BlackMagic/Lightning/Thundara/b=new
						var/obj/perk/Abilities/BlackMagic/Lightning/Thundaga/c=new
						var/obj/perk/Abilities/BlackMagic/Lightning/Thundaja/d=new
						var/obj/perk/Abilities/GeneralWeaponAbilities/Melee/Braver/e=new
						var/obj/perk/Abilities/GeneralWeaponAbilities/Melee/CrossSlash/f=new
						var/obj/item/Weapon/NPCWeapons/Horn/sf=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=e
						src.contents+=f
						src.contents+=sf
						src.eweapon=sf
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb
						var/obj/perk/SummonPassives/Ixion/summ=new
						src.contents+=summ
				Diabolos
					resistance="Dark"
					icon='Icons/Summon/Diabolos.png'
					summon=1
					mhp=115
					hp=115
					mmp=100
					mp=100
					sp=90
					msp=90
					baseac=18
					str=10
					strmod=0
					dex=16
					dexmod=3
					con=14
					conmod=2
					int=10
					intmod=0
					wis=20
					wismod=5
					cha=10
					chamod=0
					mab=9
					pab=9
					mdb=9
					pdb=9
					basedr=0
					New()
						var/obj/perk/Abilities/ArcaneMagic/Darkness/Dark/a=new
						var/obj/perk/Abilities/ArcaneMagic/Darkness/Darkra/b=new
						var/obj/perk/Abilities/ArcaneMagic/Darkness/Darkaga/c=new
						var/obj/perk/Abilities/ArcaneMagic/Darkness/Darkja/d=new
						var/obj/item/Weapon/NPCWeapons/Claw/sf=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=sf
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb
						var/obj/perk/SummonPassives/Diabolos/summ=new
						src.contents+=summ
				Valefor
					resistance="Holy"
					icon='Icons/Summon/Valefor.png'
					summon=1
					mhp=100
					hp=100
					mmp=150
					mp=150
					sp=90
					msp=90
					baseac=19
					str=10
					strmod=0
					dex=16
					dexmod=3
					con=10
					conmod=0
					int=14
					intmod=2
					wis=18
					wismod=4
					cha=10
					chamod=0
					mab=10
					pab=10
					mdb=8
					pdb=8
					basedr=0
					New()
						var/obj/perk/Abilities/GeneralMagicAbilities/Laser/a=new
						var/obj/perk/Abilities/GeneralMagicAbilities/Laserga/b=new
						var/obj/perk/Abilities/GeneralMagicAbilities/Impact/c=new
						var/obj/perk/Abilities/BlackMagic/Flame/Fire/d=new
						var/obj/perk/Abilities/BlackMagic/Ice/Blizzard/e=new
						var/obj/perk/Abilities/BlackMagic/Lightning/Thunder/f=new
						var/obj/perk/Abilities/WhiteMagic/Wind/Aerora/g=new
						var/obj/item/Weapon/NPCWeapons/Claw/sf=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=e
						src.contents+=f
						src.contents+=g
						src.contents+=sf
						src.eweapon=sf
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb
						var/obj/perk/SummonPassives/Valefor/summ=new
						src.contents+=summ
				Ravana
					resistance="Dark"
					icon='Icons/Summon/Ravana.png'
					summon=1
					mhp=155
					hp=155
					mmp=100
					mp=100
					sp=120
					msp=120
					baseac=20
					str=18
					strmod=4
					dex=18
					dexmod=4
					con=16
					conmod=4
					int=10
					intmod=0
					wis=18
					wismod=4
					cha=10
					chamod=0
					mab=5
					pab=12
					mdb=12
					pdb=14
					basedr=7
					New()
						var/obj/perk/Abilities/GeneralWeaponAbilities/Melee/CrossSlash/a=new
						var/obj/perk/Abilities/GeneralWeaponAbilities/Melee/BladeBeam/b=new
						var/obj/perk/Abilities/GeneralWeaponAbilities/Melee/Halone/c=new
						var/obj/perk/Abilities/GeneralWeaponAbilities/Melee/Riposte/d=new
						var/obj/perk/Abilities/GeneralWeaponAbilities/Melee/FatedCircle/e=new
						var/obj/perk/Abilities/GeneralWeaponAbilities/Melee/FinishingTouch/f=new
						var/obj/perk/Abilities/GeneralWeaponAbilities/Melee/Shout/g=new
						var/obj/perk/Abilities/ArcaneMagic/Darkness/Darkja/dar=new
						var/obj/item/Weapon/Melee/Longsword/Mythril/sf=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=e
						src.contents+=f
						src.contents+=g
						src.contents+=dar
						src.contents+=sf
						src.eweapon=sf
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb
						var/obj/perk/SummonPassives/Ravana/summ=new
						src.contents+=summ
				Ashura
					resistance="Physical"
					icon='Icons/Summon/Ashura.png'
					summon=1
					mhp=125
					hp=125
					mmp=100
					mp=100
					sp=120
					msp=120
					baseac=19
					str=18
					strmod=4
					dex=10
					dexmod=0
					con=16
					conmod=3
					int=10
					intmod=0
					wis=10
					wismod=0
					cha=18
					chamod=4
					mab=7
					pab=7
					mdb=7
					pdb=7
					basedr=2
					New()
						var/obj/perk/Abilities/GeneralWeaponAbilities/Melee/CrossSlash/a=new
						var/obj/perk/Abilities/GeneralWeaponAbilities/Melee/BladeBeam/b=new
						var/obj/perk/Abilities/GeneralWeaponAbilities/Melee/Halone/c=new
						var/obj/perk/Abilities/WhiteMagic/Healing/Cura/cur=new
						var/obj/perk/Abilities/WhiteMagic/Holy/Diara/da=new
						var/obj/perk/Abilities/GeneralWeaponAbilities/Melee/Riposte/d=new
						var/obj/perk/Abilities/GeneralWeaponAbilities/Melee/FatedCircle/e=new
						var/obj/perk/Abilities/GeneralWeaponAbilities/Melee/FinishingTouch/f=new
						var/obj/perk/Abilities/GeneralWeaponAbilities/Melee/Shout/g=new
						var/obj/item/Weapon/Melee/Longsword/Mythril/sf=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=e
						src.contents+=f
						src.contents+=g
						src.contents+=sf
						src.contents+=cur
						src.contents+=da
						src.eweapon=sf
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb
						var/obj/perk/SummonPassives/Ashura/summ=new
						src.contents+=summ
			ARank
				rank="A"
				archived=1
				rankbonus=5
				Odin
					resistance="Physical"
					icon='Icons/Summon/Odin.png'
					summon=1
					mhp=155
					hp=155
					mmp=110
					mp=110
					sp=150
					msp=150
					baseac=21
					str=18
					strmod=4
					dex=16
					dexmod=3
					con=18
					conmod=4
					int=10
					intmod=0
					wis=10
					wismod=0
					cha=10
					chamod=0
					mab=12
					pab=12
					mdb=12
					pdb=25
					basedr=2
					New()
						var/obj/perk/Abilities/GeneralWeaponAbilities/Melee/CrossSlash/a=new
						var/obj/perk/Abilities/GeneralWeaponAbilities/Melee/BladeBeam/b=new
						var/obj/perk/Abilities/GeneralWeaponAbilities/Melee/Halone/c=new
						var/obj/perk/Abilities/Samurai/IaidoStance/d=new
						var/obj/perk/Abilities/Samurai/Tsubamagaeshi/e=new
						var/obj/item/Weapon/Melee/Katana/Adamantine/sf=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=e
						src.contents+=sf
						src.eweapon=sf
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb
						var/obj/perk/SummonPassives/Odin/summ=new
						src.contents+=summ
				Leviathan
					resistance="Water"
					icon='Icons/Summon/Leviathan.png'
					summon=1
					mhp=190
					hp=190
					mmp=190
					mp=190
					sp=120
					msp=120
					baseac=19
					str=22
					strmod=6
					dex=16
					dexmod=3
					con=14
					conmod=2
					int=12
					intmod=1
					wis=22
					wismod=6
					cha=10
					chamod=2
					mab=12
					pab=6
					mdb=18
					pdb=8
					basedr=2
					New()
						var/obj/perk/Abilities/BlackMagic/Hydro/Waterja/a=new
						var/obj/perk/Abilities/BlackMagic/Hydro/Flood/b=new
						var/obj/perk/Abilities/BlackMagic/Hydro/Tsunami/c=new
						var/obj/perk/Abilities/GeneralMagicAbilities/Laserga/d=new
						var/obj/perk/Abilities/GreenMagic/Bubble/e=new
						var/obj/perk/Abilities/GreenMagic/Barelement/Barwater/f=new
						var/obj/item/Weapon/NPCWeapons/Bite/sf=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=e
						src.contents+=f
						src.contents+=sf
						src.eweapon=sf
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb
						var/obj/perk/SummonPassives/Leviathan/summ=new
						src.contents+=summ

				Bahamut
					resistance="Flare"
					icon='Icons/Summon/Bahamut.png'
					summon=1
					mhp=215
					hp=215
					mmp=255
					mp=255
					sp=120
					msp=120
					baseac=20
					str=22
					strmod=6
					dex=12
					dexmod=1
					con=18
					conmod=4
					int=16
					intmod=3
					wis=22
					wismod=6
					cha=10
					chamod=0
					mab=12
					pab=9
					mdb=20
					pdb=15
					basedr=3
					New()
						var/obj/perk/Abilities/BlackMagic/Energy/Flare/a=new
						var/obj/perk/MonsterAbilities/BLU/DragoFlare/b=new
						var/obj/perk/Abilities/BlackMagic/Energy/Scathe/c=new
						var/obj/perk/Abilities/GeneralMagicAbilities/Laserga/d=new
						var/obj/item/Weapon/NPCWeapons/Bite/sf=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=sf
						src.eweapon=sf
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb
						var/obj/perk/SummonPassives/Bahamut/summ=new
						src.contents+=summ
				Alexander
					resistance="Holy"
					icon='Icons/Summon/Alexander.png'
					speed=1
					summon=1
					mhp=255
					hp=255
					mmp=255
					mp=255
					sp=120
					msp=120
					baseac=20
					str=22
					strmod=6
					dex=14
					dexmod=2
					con=24
					conmod=7
					int=18
					intmod=4
					wis=10
					wismod=0
					cha=22
					chamod=6
					mab=14
					pab=6
					mdb=25
					pdb=8
					basedr=10
					New()
						var/obj/perk/Abilities/GreenMagic/Protects/Protectga/a=new
						var/obj/perk/Abilities/GreenMagic/Shells/Shellga/b=new
						var/obj/perk/Abilities/GreenMagic/Bravery/c=new
						var/obj/perk/Abilities/GreenMagic/Haste/d=new
						var/obj/perk/Abilities/GreenMagic/Safes/Safega/e=new
						var/obj/perk/Abilities/GreenMagic/Dualprotection/Stoneskin/f=new
						var/obj/perk/Abilities/WhiteMagic/Holy/Diaga/g=new
						var/obj/perk/Abilities/GeneralMagicAbilities/Laserga/h=new
						var/obj/perk/Abilities/GeneralMagicAbilities/Fleche/i=new
						var/obj/perk/Abilities/GeneralMagicAbilities/Jolt/j=new
						var/obj/perk/Abilities/Paladin/Cover/k=new
						var/obj/item/Weapon/NPCWeapons/Ram/sf=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=e
						src.contents+=f
						src.contents+=g
						src.contents+=h
						src.contents+=i
						src.contents+=j
						src.contents+=k
						src.contents+=sf
						src.eweapon=sf
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb
						var/obj/perk/SummonPassives/Alexander/summ=new
						src.contents+=summ
				Hades
					resistance="Dark"
					icon='Icons/Summon/Hades.png'
					summon=1
					mhp=155
					hp=155
					mmp=255
					mp=255
					sp=120
					msp=120
					baseac=20
					str=14
					strmod=2
					dex=20
					dexmod=5
					con=20
					conmod=5
					int=22
					intmod=6
					wis=22
					wismod=6
					cha=10
					chamod=0
					mab=11
					pab=0
					mdb=25
					pdb=0
					basedr=10
					New()
						var/obj/perk/Abilities/ArcaneMagic/Darkness/Darkaga/a=new
						var/obj/perk/Abilities/ArcaneMagic/Bios/Bioaga/b=new
						var/obj/perk/Abilities/ArcaneMagic/Drains/Drainga/c=new
						var/obj/perk/Abilities/ArcaneMagic/Toads/Toadga/d=new
						var/obj/perk/Abilities/ArcaneMagic/Statusinfliction/Blindga/e=new
						var/obj/perk/Abilities/ArcaneMagic/Death/Corpse/f=new
						var/obj/item/Weapon/NPCWeapons/Staff/sf=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=e
						src.contents+=f
						src.contents+=sf
						src.eweapon=sf
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb
						var/obj/perk/SummonPassives/Hades/summ=new
						src.contents+=summ
				Cerberus
					resistance="Fire"
					icon='Icons/Summon/Cerberus.png'
					summon=1
					mhp=155
					hp=155
					mmp=255
					mp=255
					sp=120
					msp=120
					baseac=20
					str=22
					strmod=6
					dex=16
					dexmod=3
					con=20
					conmod=5
					int=22
					intmod=6
					wis=22
					wismod=6
					cha=10
					chamod=0
					mab=12
					pab=12
					mdb=20
					pdb=20
					basedr=4
					New()
						var/obj/perk/Abilities/BlackMagic/Flame/Firaja/a=new
						var/obj/perk/Abilities/BlackMagic/Ice/Blizzaja/b=new
						var/obj/perk/Abilities/BlackMagic/Lightning/Thundaja/c=new
						var/obj/perk/Abilities/ArcaneMagic/Drains/Drainga/d=new
						var/obj/perk/Abilities/ArcaneMagic/Osmoses/Osmosega/e=new
						var/obj/item/Weapon/NPCWeapons/Bite/sf=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=e
						src.contents+=sf
						src.eweapon=sf
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb
						var/obj/perk/SummonPassives/Cerberus/summ=new
						src.contents+=summ
				Anima
					resistance="Dark"
					icon='Icons/Summon/Anima.png'
					summon=1
					mhp=145
					hp=145
					mmp=255
					mp=255
					sp=120
					msp=120
					baseac=20
					str=22
					strmod=6
					dex=16
					dexmod=3
					con=20
					conmod=5
					int=22
					intmod=6
					wis=22
					wismod=6
					cha=10
					chamod=0
					mab=11
					pab=10
					mdb=20
					pdb=10
					basedr=2
					New()
						var/obj/perk/Abilities/BlackMagic/Flame/Firaja/a=new
						var/obj/perk/Abilities/BlackMagic/Ice/Blizzaja/b=new
						var/obj/perk/Abilities/BlackMagic/Lightning/Thundaja/c=new
						var/obj/perk/Abilities/BlackMagic/Hydro/Waterja/d=new
						var/obj/perk/Abilities/BlackMagic/Other/Apocalypse/e=new
						var/obj/item/Weapon/NPCWeapons/Punch/sf=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=e
						src.contents+=sf
						src.eweapon=sf
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb
						var/obj/perk/SummonPassives/Anima/summ=new
						src.contents+=summ
				Hecatoncheir
					resistance="Metal"
					icon='Icons/Summon/Hecatoncheir.png'
					summon=1
					mhp=195
					hp=195
					mmp=255
					mp=255
					sp=120
					msp=120
					baseac=20
					str=22
					strmod=6
					dex=16
					dexmod=3
					con=20
					conmod=5
					int=22
					intmod=6
					wis=22
					wismod=6
					cha=10
					chamod=0
					mab=11
					pab=12
					mdb=20
					pdb=12
					basedr=5
					New()
						var/obj/perk/MonsterAbilities/BLU/MatraMagic/a=new
						var/obj/perk/Abilities/BlackMagic/Energy/Scathe/b=new
						var/obj/perk/Abilities/GeneralMagicAbilities/Laserga/c=new
						var/obj/perk/Abilities/GeneralMagicAbilities/Fleche/d=new
						var/obj/perk/Abilities/Geomancer/Quake/e=new
						var/obj/item/Weapon/NPCWeapons/Punch/sf=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=e
						src.contents+=sf
						src.eweapon=sf
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb
						var/obj/perk/SummonPassives/Hecatoncheir/summ=new
						src.contents+=summ
				Lakshmi
					resistance="Holy"
					icon='Icons/Summon/Lakshmi.png'
					summon=1
					mhp=195
					hp=195
					mmp=255
					mp=255
					sp=120
					msp=120
					baseac=20
					str=10
					strmod=0
					dex=22
					dexmod=6
					con=12
					conmod=1
					int=14
					intmod=2
					wis=18
					wismod=4
					cha=22
					chamod=6
					mab=12
					pab=11
					mdb=20
					pdb=12
					basedr=5
					New()
						var/obj/perk/Abilities/WhiteMagic/Holy/a=new
						var/obj/perk/Abilities/ArcaneMagic/Statusinfliction/Sleep/b=new
						var/obj/perk/Abilities/ArcaneMagic/Statusinfliction/Sleepga/c=new
						var/obj/perk/Abilities/GeneralMagicAbilities/Ruin/d=new
						var/obj/perk/Abilities/WhiteMagic/Healing/Cure/e=new
						var/obj/perk/Abilities/WhiteMagic/Healing/Cura/f=new
						var/obj/perk/Abilities/WhiteMagic/Healing/Curaga/g=new
						var/obj/perk/Abilities/WhiteMagic/Status/Esunaga/h=new
						var/obj/item/Weapon/NPCWeapons/Punch/sf=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=e
						src.contents+=f
						src.contents+=g
						src.contents+=h
						src.contents+=sf
						src.eweapon=sf
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb
						var/obj/perk/SummonPassives/Lakshmi/summ=new
						src.contents+=summ
			SRank
				rank="S"
				NeoBahamut
					resistance="Flare"
					icon='Icons/Summon/NeoBahamut.png'
					name="Neo Bahamut"
					summon=1
					mhp=375
					hp=375
					mmp=280
					mp=280
					sp=150
					msp=150
					baseac=23
					str=24
					strmod=7
					dex=12
					dexmod=1
					con=18
					conmod=4
					int=14
					intmod=2
					wis=24
					wismod=7
					cha=12
					chamod=2
					mab=13
					pab=9
					mdb=45
					pdb=25
					basedr=5
					New()
						var/obj/perk/Abilities/BlackMagic/Energy/Flare/a=new
						var/obj/perk/MonsterAbilities/BLU/DragoFlare/b=new
						var/obj/perk/Abilities/BlackMagic/Energy/Scathe/c=new
						var/obj/perk/Abilities/GeneralMagicAbilities/Laserga/d=new
						var/obj/item/Weapon/NPCWeapons/Bite/sf=new
						var/obj/perk/Abilities/BlackMagic/Energy/Megaflare/e=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=sf
						src.contents+=e
						src.eweapon=sf
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb
						var/obj/perk/SummonPassives/NeoBahamut/summ=new
						src.contents+=summ
				Eden
					resistance="Holy"
					icon='Icons/Summon/Eden.png'
					summon=1
					mhp=400
					hp=400
					mmp=350
					mp=350
					sp=150
					msp=150
					baseac=23
					str=24
					strmod=7
					dex=12
					dexmod=1
					con=18
					conmod=4
					int=14
					intmod=2
					wis=24
					wismod=7
					cha=12
					chamod=2
					mab=12
					pab=8
					mdb=45
					pdb=25
					basedr=8
					New()
						var/obj/perk/Abilities/WhiteMagic/Holy/Diaga/a=new
						var/obj/perk/Abilities/WhiteMagic/Healing/Curaga/b=new
						var/obj/perk/Abilities/BlackMagic/Energy/Scathe/c=new
						var/obj/perk/Abilities/BlackMagic/Ice/Freeze/d=new
						var/obj/perk/Abilities/BlackMagic/Other/Meltdown/e=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=e
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb
						var/obj/perk/SummonPassives/Eden/summ=new
						src.contents+=summ
				Ark
					resistance="Wind"
					icon='Icons/Summon/Ark.png'
					summon=1
					mhp=380
					hp=380
					mmp=210
					mp=210
					sp=300
					msp=300
					baseac=23
					str=24
					strmod=7
					dex=12
					dexmod=1
					con=18
					conmod=4
					int=24
					intmod=7
					wis=14
					wismod=2
					cha=12
					chamod=2
					mab=12
					pab=8
					mdb=45
					pdb=25
					basedr=5
					New()
						var/obj/perk/MonsterAbilities/BLU/MatraMagic/a=new
						var/obj/perk/Abilities/GeneralMagicAbilities/Laserga/b=new
						var/obj/perk/Abilities/GeneralMagicAbilities/Addle/c=new
						var/obj/perk/Abilities/GeneralMagicAbilities/Combust/d=new
						var/obj/perk/Abilities/GeneralMagicAbilities/Impactga/e=new
						var/obj/item/Weapon/NPCWeapons/Ram/sf=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=sf
						src.contents+=e
						src.eweapon=sf
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb
						var/obj/perk/SummonPassives/Ark/summ=new
						src.contents+=summ
				Shinryu
					resistance="Fire"
					icon='Icons/Summon/Shinryu.png'
					summon=1
					mhp=380
					hp=380
					mmp=210
					mp=210
					sp=300
					msp=300
					baseac=23
					str=24
					strmod=7
					dex=12
					dexmod=1
					con=18
					conmod=4
					int=14
					intmod=2
					wis=24
					wismod=7
					cha=12
					chamod=2
					mab=12
					pab=8
					mdb=45
					pdb=25
					basedr=5
					New()
						var/obj/perk/MonsterAbilities/BLU/DragoFlare/a=new
						var/obj/perk/Abilities/ArcaneMagic/Bios/Bioaga/b=new
						var/obj/perk/Abilities/ArcaneMagic/Darkness/Darkaga/c=new
						var/obj/perk/MonsterAbilities/BLU/GreatFlamethrower/d=new
						var/obj/perk/Abilities/GeneralWeaponAbilities/Melee/TriumphantGrasp/e=new
						var/obj/item/Weapon/NPCWeapons/Bite/sf=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=sf
						src.contents+=e
						src.eweapon=sf
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb
						var/obj/perk/SummonPassives/Shinryu/summ=new
						src.contents+=summ
				MagusSisters
					resistance="General"
					icon='Icons/Summon/Magussisters.png'
					summon=1
					mhp=300
					hp=300
					mmp=280
					mp=280
					sp=300
					msp=300
					baseac=23
					str=20
					strmod=5
					dex=12
					dexmod=1
					con=18
					conmod=4
					int=14
					intmod=2
					wis=24
					wismod=7
					cha=12
					chamod=2
					mab=12
					pab=10
					mdb=35
					pdb=35
					basedr=2
					New()
						var/obj/perk/Abilities/BlackMagic/Flame/Firaja/a=new
						var/obj/perk/Abilities/BlackMagic/Ice/Blizzaja/b=new
						var/obj/perk/Abilities/BlackMagic/Lightning/Thundaja/c=new
						var/obj/perk/Abilities/BlackMagic/Hydro/Waterja/d=new
						var/obj/perk/Abilities/ArcaneMagic/Darkness/Darkja/e=new
						var/obj/item/Weapon/Melee/Scythe/Mythril/sf=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=sf
						src.contents+=e
						src.eweapon=sf
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb
						var/obj/perk/SummonPassives/MagusSisters/summ=new
						src.contents+=summ
				Phoenix
					resistance="Fire"
					icon='Icons/Summon/Phoenix.png'
					summon=1
					mhp=300
					hp=300
					mmp=700
					mp=700
					sp=300
					msp=300
					baseac=23
					str=12
					strmod=5
					dex=12
					dexmod=1
					con=18
					conmod=4
					int=14
					intmod=2
					wis=24
					wismod=7
					cha=20
					chamod=5
					mab=12
					pab=10
					mdb=35
					pdb=35
					basedr=0
					New()
						var/obj/perk/Abilities/BlackMagic/Flame/Firaja/a=new
						var/obj/perk/Abilities/BlackMagic/Flame/Ardor/b=new
						var/obj/perk/Abilities/WhiteMagic/Healing/Regen/c=new
						var/obj/perk/Abilities/WhiteMagic/Healing/Asylum/d=new
						var/obj/perk/Abilities/WhiteMagic/Healing/Temperance/e=new
						var/obj/perk/Abilities/WhiteMagic/Healing/Arise/f=new
						var/obj/perk/Abilities/WhiteMagic/Healing/Curaja/g=new
						var/obj/perk/Abilities/WhiteMagic/Healing/Curada/h=new
						var/obj/item/Weapon/NPCWeapons/Claw/sf=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=sf
						src.contents+=e
						src.contents+=f
						src.contents+=g
						src.contents+=h
						src.eweapon=sf
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb
						var/obj/perk/SummonPassives/Phoenix/summ=new
						src.contents+=summ
				Raiden
					resistance="Physical"
					icon='Icons/Summon/Raiden.png'
					summon=1
					mhp=315
					hp=315
					mmp=200
					mp=200
					sp=200
					msp=200
					baseac=23
					str=22
					strmod=6
					dex=22
					dexmod=6
					con=18
					conmod=4
					int=10
					intmod=0
					wis=10
					wismod=0
					cha=12
					chamod=1
					mab=0
					pab=15
					mdb=0
					pdb=55
					basedr=2
					New()
						var/obj/perk/Abilities/GeneralWeaponAbilities/Melee/CrossSlash/a=new
						var/obj/perk/Abilities/GeneralWeaponAbilities/Melee/BladeBeam/b=new
						var/obj/perk/Abilities/GeneralWeaponAbilities/Melee/Halone/c=new
						var/obj/perk/Abilities/GeneralWeaponAbilities/Melee/Innocence/f=new
						var/obj/perk/Abilities/GeneralWeaponAbilities/Melee/ThunderGod/g=new
						var/obj/perk/Abilities/Samurai/IaidoStance/d=new
						var/obj/perk/Abilities/Samurai/Tsubamagaeshi/e=new
						var/obj/item/Weapon/Melee/Katana/Orichalcum/sf=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=e
						src.contents+=f
						src.contents+=g
						src.contents+=sf
						src.eweapon=sf
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb
						var/obj/perk/SummonPassives/Raiden/summ=new
						src.contents+=summ*/
			Necromancer
				resistance="Dark"
				rank="Necromancer"
				rankbonus=4
				DRank
					ZombieWarrior
						name="Zombie Warrior"
						icon='Icons/Summon/Necromancer/Zombie.png'
						summon=1
						mhp=40
						hp=40
						mmp=100
						mp=100
						sp=60
						msp=60
						str=14
						strmod=1
						baseac=12
						dex=10
						dexmod=0
						con=10
						conmod=0
						int=10
						intmod=0
						wis=12
						wismod=1
						cha=10
						chamod=0
						mab=2
						pab=5
						mdb=0
						pdb=15
						New()
							var/obj/perk/Abilities/ArcaneMagic/Bios/Bio/b=new
							var/obj/item/Weapon/NPCWeapons/Punch/c=new
							src.contents+=b
							src.contents+=c
							var/obj/status/HPBar/hpb = new
							src.contents+=hpb
							var/obj/status/SPBar/spb = new
							src.contents+=spb
							var/obj/status/MPBar/mpb = new
							src.contents+=mpb
				CRank
					SkeletonWarrior
						name="Skeleton Warrior"
						icon='Icons/Summon/Necromancer/SkeletalWarrior.png'
						summon=1
						mhp=80
						hp=80
						mmp=100
						mp=100
						sp=60
						msp=60
						str=14
						strmod=1
						baseac=16
						dex=10
						dexmod=0
						con=10
						conmod=0
						int=10
						intmod=0
						wis=12
						wismod=1
						cha=10
						chamod=0
						mab=2
						pab=5
						mdb=0
						pdb=20
						New()
							var/obj/perk/Abilities/ArcaneMagic/Bios/Bioara/b=new
							var/obj/perk/Abilities/GeneralWeaponAbilities/Melee/Braver/d=new
							var/obj/item/Weapon/Melee/Longsword/Steel/c=new
							src.contents+=b
							src.contents+=c
							src.contents+=d
							src.eweapon=c
							var/obj/status/HPBar/hpb = new
							src.contents+=hpb
							var/obj/status/SPBar/spb = new
							src.contents+=spb
							var/obj/status/MPBar/mpb = new
							src.contents+=mpb
					SkeletonArcher
						name="Skeleton Archer"
						icon='Icons/Summon/Necromancer/SkeletalArcher.png'
						summon=1
						mhp=70
						hp=70
						mmp=100
						mp=100
						sp=60
						msp=60
						str=14
						strmod=1
						baseac=12
						dex=22
						dexmod=6
						con=10
						conmod=0
						int=10
						intmod=0
						wis=12
						wismod=1
						cha=10
						chamod=0
						mab=2
						pab=5
						mdb=0
						pdb=25
						New()
							var/obj/perk/Abilities/ArcaneMagic/Bios/Bioaga/b=new
							var/obj/perk/Abilities/GeneralWeaponAbilities/Ranged/BloodyShot/d=new
							var/obj/item/Weapon/Ranged/Bow/Steel/c=new
							src.contents+=b
							src.contents+=c
							src.contents+=d
							src.eweapon=c
							var/obj/status/HPBar/hpb = new
							src.contents+=hpb
							var/obj/status/SPBar/spb = new
							src.contents+=spb
							var/obj/status/MPBar/mpb = new
							src.contents+=mpb
					SkeletalHound
						name="Skeletal Hound"
						icon='Icons/Summon/Necromancer/SkeletalHound.png'
						summon=1
						mhp=70
						hp=70
						mmp=100
						mp=100
						sp=60
						msp=60
						str=14
						strmod=1
						baseac=12
						dex=22
						dexmod=6
						con=10
						conmod=0
						int=10
						intmod=0
						wis=12
						wismod=1
						cha=10
						chamod=0
						mab=2
						pab=5
						mdb=0
						pdb=25
						New()
							var/obj/perk/Abilities/ArcaneMagic/Bios/Bioaga/b=new
							var/obj/item/Weapon/NPCWeapons/Bite/c=new
							src.contents+=b
							src.contents+=c
							var/obj/status/HPBar/hpb = new
							src.contents+=hpb
							var/obj/status/SPBar/spb = new
							src.contents+=spb
							var/obj/status/MPBar/mpb = new
							src.contents+=mpb
					SkeletalMage
						name="Skeletal Mage"
						icon='Icons/Summon/Necromancer/SkeletalMage.png'
						summon=1
						mhp=90
						hp=90
						mmp=300
						mp=300
						sp=60
						msp=60
						str=12
						strmod=1
						baseac=16
						dex=14
						dexmod=2
						con=10
						conmod=0
						int=10
						intmod=0
						wis=22
						wismod=6
						cha=10
						chamod=0
						mab=8
						pab=5
						mdb=25
						pdb=0
						New()
							var/obj/perk/Abilities/BlackMagic/Flame/Firaja/a=new
							var/obj/perk/Abilities/BlackMagic/Lightning/Thundaja/b=new
							var/obj/perk/Abilities/BlackMagic/Ice/Blizzaja/d=new
							var/obj/perk/Abilities/ArcaneMagic/Darkness/Darkja/e=new
							var/obj/item/Weapon/NPCWeapons/Staff/c=new
							src.contents+=a
							src.contents+=b
							src.contents+=c
							src.contents+=d
							src.contents+=e
							var/obj/status/HPBar/hpb = new
							src.contents+=hpb
							var/obj/status/SPBar/spb = new
							src.contents+=spb
							var/obj/status/MPBar/mpb = new
							src.contents+=mpb
				BRank
					Lich
						name="Lich"
						icon='Icons/Summon/Necromancer/Lich.png'
						summon=1
						mhp=125
						hp=125
						mmp=300
						mp=300
						sp=60
						msp=60
						str=14
						strmod=2
						baseac=20
						dex=14
						dexmod=2
						con=10
						conmod=0
						int=10
						intmod=0
						wis=24
						wismod=7
						cha=10
						chamod=0
						mab=10
						pab=5
						mdb=35
						pdb=0
						New()
							var/obj/perk/Abilities/BlackMagic/Flame/Firaja/a=new
							var/obj/perk/Abilities/BlackMagic/Lightning/Thundaja/b=new
							var/obj/perk/Abilities/BlackMagic/Ice/Blizzaja/d=new
							var/obj/perk/Abilities/ArcaneMagic/Darkness/Darkja/e=new
							var/obj/perk/Abilities/ArcaneMagic/Death/Corpse/f=new
							var/obj/perk/Abilities/BlackMagic/Ice/Freeze/g=new
							var/obj/perk/MonsterAbilities/Summon/CorruptEarth/h=new
							var/obj/item/Weapon/NPCWeapons/Staff/c=new
							src.contents+=a
							src.contents+=b
							src.contents+=c
							src.contents+=d
							src.contents+=e
							src.contents+=f
							src.contents+=g
							src.contents+=h
							var/obj/status/HPBar/hpb = new
							src.contents+=hpb
							var/obj/status/SPBar/spb = new
							src.contents+=spb
							var/obj/status/MPBar/mpb = new
							src.contents+=mpb
							var/obj/perk/SummonPassives/Lich/summ=new
							src.contents+=summ
					BoneTitan
						name="Bone Titan"
						icon='Icons/Summon/Necromancer/BoneTitan.png'
						summon=1
						mhp=180
						hp=180
						mmp=300
						mp=300
						sp=60
						msp=60
						str=22
						strmod=6
						baseac=20
						dex=14
						dexmod=2
						con=10
						conmod=0
						int=10
						intmod=0
						wis=24
						wismod=7
						cha=10
						chamod=0
						mab=10
						pab=5
						mdb=35
						pdb=0
						New()
							var/obj/perk/Abilities/Geomancer/Earth/Stonaja/a=new
							var/obj/perk/Abilities/Geomancer/Quake/b=new
							var/obj/perk/Abilities/ArcaneMagic/Darkness/Darkja/d=new
							var/obj/item/Weapon/NPCWeapons/BoneClub/c=new
							src.contents+=a
							src.contents+=b
							src.contents+=c
							src.contents+=d
							var/obj/status/HPBar/hpb = new
							src.contents+=hpb
							var/obj/status/SPBar/spb = new
							src.contents+=spb
							var/obj/status/MPBar/mpb = new
							src.contents+=mpb
				ARank
					name="Scarmiglione"
					Scarmiglione
						icon='Icons/Summon/Necromancer/Scarmiglione.png'
						summon=1
						mhp=300
						hp=300
						mmp=400
						mp=400
						sp=60
						msp=60
						str=20
						strmod=5
						baseac=24
						dex=14
						dexmod=2
						con=10
						conmod=0
						int=10
						intmod=0
						wis=22
						wismod=6
						cha=10
						chamod=0
						mab=8
						pab=5
						mdb=25
						pdb=0
						New()
							var/obj/perk/Abilities/BlackMagic/Flame/Firaja/a=new
							var/obj/perk/Abilities/BlackMagic/Lightning/Thundaja/b=new
							var/obj/perk/Abilities/BlackMagic/Ice/Blizzaja/d=new
							var/obj/perk/Abilities/ArcaneMagic/Darkness/Darkja/e=new
							var/obj/perk/Abilities/ArcaneMagic/Drains/Drainga/f=new
							var/obj/perk/Abilities/ArcaneMagic/Death/Breakartpentagram/g=new
							var/obj/perk/Abilities/BlackMagic/Energy/Flare/h=new
							var/obj/perk/MonsterAbilities/Summon/PoisonCloud/i=new
							var/obj/item/Weapon/NPCWeapons/Claw/c=new
							src.contents+=a
							src.contents+=b
							src.contents+=c
							src.contents+=d
							src.contents+=e
							src.contents+=f
							src.contents+=g
							src.contents+=h
							src.contents+=i
							var/obj/status/HPBar/hpb = new
							src.contents+=hpb
							var/obj/status/SPBar/spb = new
							src.contents+=spb
							var/obj/status/MPBar/mpb = new
							src.contents+=mpb
							var/obj/perk/SummonPassives/Scarmiglione/summ=new
							src.contents+=summ
			Aeons //Aeon Del note needs new aeons
				summon=1
				rankbonus=6
				name="-----------Aeons-----------"
				Syldra
					name="Syldra"
					icon='Icons/Summon/Aeons/Syldra.png'
					summon=1
					mhp=185
					hp=185
					mmp=220
					mp=220
					sp=100
					msp=100
					baseac=18
					str=16
					strmod=3
					dex=10
					dexmod=0
					con=18
					conmod=4
					int=12
					intmod=1
					wis=20
					wismod=5
					cha=0
					chamod=0
					mab=12
					pab=12
					mdb=12
					pdb=12
					basedr=4
					New()
						var/obj/perk/Abilities/BlackMagic/Hydro/Water/a=new
						var/obj/perk/Abilities/BlackMagic/Hydro/Watera/b=new
						var/obj/perk/Abilities/BlackMagic/Hydro/Waterga/c=new
						var/obj/perk/Abilities/BlackMagic/Hydro/Waterja/d=new
						var/obj/item/Weapon/NPCWeapons/Ram/sf=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=sf
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb
						var/obj/perk/SummonPassives/Syldra/summ=new
						src.contents+=summ
				Quetzalli
					name="Quetzalli"
					icon='Icons/Summon/Aeons/Quetzalli.png'
					var/monkbonus=5
					summon=1
					mhp=185
					hp=185
					mmp=220
					mp=220
					sp=100
					msp=100
					baseac=18
					str=20
					strmod=5
					dex=10
					dexmod=0
					con=18
					conmod=4
					int=12
					intmod=1
					wis=18
					wismod=4
					cha=0
					chamod=0
					mab=12
					pab=12
					mdb=12
					pdb=12
					basedr=4
					New()
						var/obj/perk/Abilities/WhiteMagic/Wind/Aero/a=new
						var/obj/perk/Abilities/WhiteMagic/Wind/Aerora/b=new
						var/obj/perk/Abilities/WhiteMagic/Wind/Aeroga/c=new
						var/obj/perk/Abilities/Monk/TornadoKick/d=new
						var/obj/item/Weapon/NPCWeapons/RazorFeather/sf=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=sf
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb
						var/obj/perk/SummonPassives/Quetzalli/summ=new
						src.contents+=summ
				Seraph
					name="Seraph"
					icon='Icons/Summon/Aeons/Seraph.png'
					summon=1
					mhp=185
					hp=185
					mmp=220
					mp=220
					sp=100
					msp=100
					baseac=18
					str=20
					strmod=5
					dex=10
					dexmod=0
					con=18
					conmod=4
					int=12
					intmod=1
					wis=18
					wismod=4
					cha=16
					chamod=3
					mab=12
					pab=12
					mdb=12
					pdb=12
					basedr=4
					New()
						var/obj/perk/Abilities/WhiteMagic/Holy/Dia/a=new
						var/obj/perk/Abilities/WhiteMagic/Holy/Diaga/b=new
						var/obj/perk/Abilities/WhiteMagic/Holy/Diara/c=new
						var/obj/perk/Abilities/WhiteMagic/Holy/Holy/d=new
						var/obj/perk/Abilities/WhiteMagic/Healing/Curaga/cr=new
						var/obj/item/Weapon/NPCWeapons/Punch/sf=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=cr
						src.contents+=sf
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb
						var/obj/perk/SummonPassives/Seraph/summ=new
						src.contents+=summ
				Percival
					name="Percival"
					icon='Icons/Summon/Aeons/Percival.png'
					mhp=235
					hp=235
					mmp=200
					mp=200
					sp=300
					msp=300
					baseac=18
					str=22
					strmod=6
					dex=10
					dexmod=0
					con=18
					conmod=4
					int=12
					intmod=1
					wis=18
					wismod=4
					cha=0
					chamod=0
					mab=12
					pab=12
					mdb=12
					pdb=12
					basedr=10
					New()
						var/obj/perk/Abilities/Paladin/Cover/a=new
						var/obj/perk/Abilities/Swordsaint/JudgementBlade/b=new
						var/obj/perk/Abilities/Samurai/Mineuchi/c=new
						var/obj/perk/Abilities/Knight/HonorableDuel/d=new
						var/obj/perk/Abilities/GeneralWeaponAbilities/Melee/BladeBeam/cr=new
						var/obj/item/Weapon/Melee/Greatsword/Adamantine/sf=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=cr
						src.contents+=sf
						src.eweapon=sf
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb
						var/obj/perk/SummonPassives/Percival/summ=new
						src.contents+=summ
				Pandemona
					name="Pandemona"
					icon='Icons/Summon/Aeons/Pandemona.png'
					mhp=200
					hp=200
					mmp=280
					mp=280
					sp=100
					msp=100
					baseac=18
					str=22
					strmod=6
					dex=24
					dexmod=7
					con=18
					conmod=4
					int=12
					intmod=1
					wis=14
					wismod=2
					cha=0
					chamod=0
					mab=12
					pab=12
					mdb=12
					pdb=12
					basedr=5
					New()
						var/obj/perk/Abilities/TimeMage/Gravitys/Graviga/a=new
						var/obj/perk/Abilities/ArcaneMagic/Statusinfliction/Blindga/b=new
						var/obj/perk/Abilities/ArcaneMagic/Drains/Drainga/c=new
						var/obj/perk/Abilities/DarkKnight/DarkCannon/d=new
						var/obj/perk/Abilities/DarkKnight/DarkNebula/cr=new
						var/obj/item/Weapon/Melee/Dagger/Mythril/sf=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=cr
						src.contents+=sf
						src.eweapon=sf
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb
						var/obj/perk/SummonPassives/Pandemona/summ=new
						src.contents+=summ
				Madeen
					name="Madeen"
					icon='Icons/Summon/Aeons/Madeen.png'
					mhp=215
					hp=215
					mmp=350
					mp=350
					sp=180
					msp=180
					baseac=18
					str=22
					strmod=6
					dex=10
					dexmod=0
					con=18
					conmod=4
					int=12
					intmod=1
					wis=14
					wismod=2
					cha=0
					chamod=0
					mab=14
					pab=14
					mdb=14
					pdb=14
					basedr=3
					New()
						var/obj/perk/Abilities/BlackMagic/Energy/Flare/a=new
						var/obj/perk/Abilities/WhiteMagic/Holy/Holy/b=new
						var/obj/perk/Jobperks/Oracle/OracleMagic/DiskofLight/c=new
						var/obj/perk/Jobperks/Oracle/OracleMagic/SealingBlade/d=new
						var/obj/perk/Jobperks/Oracle/OracleMagic/SoulConvergence/cr=new
						var/obj/perk/Jobperks/Oracle/OracleMagic/Sparkstrike/st=new
						var/obj/item/Weapon/NPCWeapons/Claw/sf=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=st
						src.contents+=cr
						src.contents+=sf
						src.eweapon=sf
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb
						var/obj/perk/SummonPassives/Madeen/summ=new
						src.contents+=summ
				Yojimbo
					name="Yojimbo"
					icon='Icons/Summon/Aeons/Yojimbo.png'
					mhp=215
					hp=215
					mmp=115
					mp=115
					sp=250
					msp=250
					baseac=18
					str=24
					strmod=7
					dex=20
					dexmod=6
					con=18
					conmod=4
					int=12
					intmod=1
					wis=14
					wismod=2
					cha=0
					chamod=0
					mab=12
					pab=12
					mdb=12
					pdb=12
					basedr=5
					New()
						var/obj/perk/Abilities/Samurai/Mineuchi/a=new
						var/obj/perk/Abilities/Samurai/Yukikaze/b=new
						var/obj/perk/Abilities/Samurai/TachiKagero/c=new
						var/obj/perk/Abilities/Samurai/Zeninage/d=new
						var/obj/perk/Abilities/Samurai/Gyoten/cr=new
						var/obj/item/Weapon/Melee/Katana/Adamantine/sf=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=cr
						src.contents+=sf
						src.eweapon=sf
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb
						var/obj/perk/SummonPassives/Yojimbo/summ=new
						src.contents+=summ
				Atomos
					name="Atomos"
					icon='Icons/Summon/Aeons/Atomos.png'
					mhp=180
					hp=180
					mmp=400
					mp=400
					sp=100
					msp=100
					baseac=18
					str=24
					strmod=7
					dex=20
					dexmod=6
					con=18
					conmod=4
					int=20
					intmod=5
					wis=20
					wismod=5
					cha=0
					chamod=0
					mab=12
					pab=12
					mdb=12
					pdb=12
					basedr=5
					New()
						var/obj/perk/Abilities/TimeMage/Gravitys/Gravity/a=new
						var/obj/perk/Abilities/TimeMage/Gravitys/Gravara/b=new
						var/obj/perk/Abilities/TimeMage/Gravitys/Gravija/c=new
						var/obj/perk/Abilities/ArcaneMagic/Bios/Bioara/d=new
						var/obj/perk/Abilities/ArcaneMagic/Bios/Scourge/cr=new
						var/obj/item/Weapon/NPCWeapons/Bite/sf=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=cr
						src.contents+=sf
						src.eweapon=sf
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb
						var/obj/perk/SummonPassives/Atomos/summ=new
						src.contents+=summ
				Salamander
					name="Salamander"
					icon='Icons/Summon/Aeons/Salamander.png'
					mhp=180
					hp=180
					mmp=400
					mp=400
					sp=100
					msp=100
					baseac=18
					str=18
					strmod=4
					dex=22
					dexmod=7
					con=18
					conmod=4
					int=20
					intmod=5
					wis=20
					wismod=5
					cha=0
					chamod=0
					mab=9
					pab=15
					mdb=9
					pdb=20
					basedr=5
					New()
						var/obj/perk/Abilities/BlackMagic/Flame/Fira/a=new
						var/obj/perk/Abilities/BlackMagic/Flame/Firaga/b=new
						var/obj/perk/Abilities/BlackMagic/Flame/Ardor/c=new
						var/obj/perk/Abilities/Dragoon/Jump/d=new
						var/obj/perk/Abilities/Dragoon/VorpalThrust/cr=new
						var/obj/perk/Jobperks/Dragoon/Dragoon/dr=new
						var/obj/perk/Jobperks/Dragoon/EnhancedJump/ej=new
						var/obj/perk/Jobperks/Dragoon/Glide/gl=new
						var/obj/item/Weapon/NPCWeapons/Bite/sf=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=dr
						src.contents+=cr
						src.contents+=sf
						src.contents+=ej
						src.contents+=gl
						src.eweapon=sf
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb
						var/obj/perk/SummonPassives/Salamander/summ=new
						src.contents+=summ
				BahamutJudgement
					name="Bahamut Judgement"
					icon='Icons/Summon/Aeons/BahamutJudgement.png'
					mhp=250
					hp=250
					mmp=300
					mp=300
					sp=125
					msp=125
					baseac=20
					str=22
					strmod=6
					dex=12
					dexmod=1
					con=18
					conmod=4
					int=14
					intmod=2
					wis=22
					wismod=6
					cha=20
					chamod=5
					mab=16
					pab=16
					mdb=15
					pdb=15
					basedr=3
					New()
						var/obj/perk/Abilities/BlackMagic/Energy/Flare/a=new
						var/obj/perk/Abilities/BlackMagic/Energy/Megaflare/ab=new
						var/obj/perk/Abilities/WhiteMagic/Holy/Holy/ad=new
						var/obj/perk/MonsterAbilities/BLU/DragoFlare/b=new
						var/obj/perk/Abilities/BlackMagic/Energy/Scathe/c=new
						var/obj/perk/Abilities/GeneralMagicAbilities/Laserga/d=new
						var/obj/item/Weapon/NPCWeapons/Bite/sf=new
						src.contents+=a
						src.contents+=ab
						src.contents+=ad
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=sf
						src.eweapon=sf
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb
						var/obj/perk/SummonPassives/BahamutJudgement/summ=new
						src.contents+=summ
				Byrnhildr
					name="Byrnhildr"
					icon='Icons/Summon/Aeons/Byrnhildr.png'
					mhp=235
					hp=235
					mmp=300
					mp=300
					sp=150
					msp=150
					baseac=20
					str=22
					strmod=6
					dex=12
					dexmod=1
					con=18
					conmod=4
					int=14
					intmod=2
					wis=22
					wismod=6
					cha=18
					chamod=4
					mab=10
					pab=13
					mdb=12
					pdb=20
					basedr=3
					New()
						var/obj/perk/Abilities/BlackMagic/Flame/Firaga/a=new
						var/obj/perk/Abilities/BlackMagic/Flame/Ardor/ab=new
						var/obj/perk/Abilities/BlackMagic/Other/Meltdown/ad=new
						var/obj/perk/Abilities/WhiteMagic/Healing/Asylum/b=new
						var/obj/perk/Abilities/GeneralWeaponAbilities/Melee/JechtCombo/c=new
						var/obj/perk/Abilities/GeneralWeaponAbilities/Melee/Launch/d=new
						var/obj/item/Weapon/Melee/Spear/Adamantine/sf=new
						src.contents+=a
						src.contents+=ab
						src.contents+=ad
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=sf
						src.eweapon=sf
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb
						var/obj/perk/SummonPassives/Byrnhildr/summ=new
						src.contents+=summ
				Enkidu
					name="Enkidu"
					icon='Icons/Summon/Aeons/Enkidu.png'
					mhp=200
					hp=200
					mmp=300
					mp=300
					sp=300
					msp=300
					baseac=20
					str=22
					strmod=6
					dex=12
					dexmod=1
					con=18
					conmod=4
					int=14
					intmod=2
					wis=22
					wismod=6
					cha=18
					chamod=4
					mab=9
					pab=15
					mdb=12
					pdb=25
					basedr=3
					New()
						var/obj/perk/Abilities/Monk/BurningArrow/a=new
						var/obj/perk/Abilities/Monk/DolphinBlow/ab=new
						var/obj/perk/Abilities/Monk/TornadoKick/ad=new
						var/obj/perk/Abilities/Monk/MeteorDive/b=new
						var/obj/perk/Abilities/GeneralMagicAbilities/Impactga/c=new
						var/obj/item/Weapon/NPCWeapons/Punch/sf=new
						src.contents+=a
						src.contents+=ab
						src.contents+=ad
						src.contents+=b
						src.contents+=c
						src.contents+=sf
						src.eweapon=sf
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb
						var/obj/perk/SummonPassives/Enkidu/summ=new
						src.contents+=summ
				FinalAeon
					name="Ultima : Final Aeon"
					icon='Icons/Summon/Aeons/Ultima.png'
					resistance="Ultima"
					rankbonus=10
					mhp=400
					hp=400
					mmp=400
					mp=400
					sp=60
					msp=60
					str=28
					strmod=9
					baseac=26
					dex=14
					dexmod=2
					con=10
					conmod=0
					int=10
					intmod=0
					wis=22
					wismod=6
					cha=10
					chamod=0
					mab=18
					pab=18
					mdb=50
					pdb=50
					basedr=8
					New()
						var/obj/perk/Abilities/BlackMagic/Energy/Ultima/a=new
						var/obj/perk/Abilities/GeneralMagicAbilities/Ruin/b=new
						var/obj/perk/Abilities/GeneralMagicAbilities/Burst/d=new
						var/obj/perk/Abilities/GeneralMagicAbilities/Laserga/e=new
						var/obj/perk/Abilities/ArcaneMagic/Drains/Drainga/f=new
						var/obj/perk/Abilities/BlackMagic/Energy/Flare/h=new
						var/obj/item/Weapon/NPCWeapons/Claw/c=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=e
						src.contents+=f
						src.contents+=h
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb
						var/obj/perk/SummonPassives/FinalAeon/summ=new
						src.contents+=summ


			Geomancer
				rank="Geomancer"
				name="----------Geomancer--------"
				rankbonus=4
				SpiritedTree
					name="Spirited Tree"
					icon='Icons/Summon/SpiritedTree.png'
					resistance="Nature"
					mhp=150
					hp=150
					mmp=1500
					mp=1500
					sp=500
					msp=500
					baseac=18
					str=16
					strmod=3
					dex=14
					dexmod=3
					con=20
					conmod=5
					int=20
					intmod=5
					wis=20
					wismod=5
					cha=10
					chamod=0
					mab=9
					pab=9
					mdb=25
					pdb=15
					basedr=5
					verb
						ElementalShift()
							set name="Elemental Shift"
							var/obj/perk/Abilities/Geomancer/InfuseElemental/trues=new
							if(usr.check_perk(trues))
								var/list/shifts=list("Nature","Fire","Water","Earth","Lightning","Wind","Ice")
								var/chosen=input(usr,"Which form would you like to shift this Elemental to?") as anything in shifts
								switch(chosen)
									if("Nature")
										src.icon='Icons/Summon/SpiritedTree.png'
										for(var/obj/perk/Abilities/a in src.contents)
											del a
										var/obj/perk/Abilities/Geomancer/SpiritedTree/BranchArrow/a=new
										src.contents+=a
										var/obj/perk/Abilities/Geomancer/SpiritedTree/BranchSpear/b=new
										src.contents+=b
										var/obj/perk/MonsterAbilities/BLU/ShrapnelSeed/c=new
										src.contents+=c
										var/obj/perk/MonsterAbilities/BLU/PhotosyntheticWave/d=new
										src.contents+=d
									if("Fire")
										src.icon='Icons/Summon/Fire Elemental.png'
										for(var/obj/perk/Abilities/a in src.contents)
											del a
										var/obj/perk/Abilities/BlackMagic/Flame/Firaga/a=new
										src.contents+=a
										var/obj/perk/Abilities/BlackMagic/Flame/Firaja/b=new
										src.contents+=b
									if("Water")
										src.icon='Icons/Summon/Water Elemental.png'
										for(var/obj/perk/Abilities/a in src.contents)
											del a
										var/obj/perk/Abilities/BlackMagic/Hydro/Waterga/a=new
										src.contents+=a
										var/obj/perk/Abilities/BlackMagic/Hydro/Waterja/b=new
										src.contents+=b
									if("Earth")
										src.icon='Icons/Summon/Earth Elemental.png'
										for(var/obj/perk/Abilities/a in src.contents)
											del a
										var/obj/perk/Abilities/Geomancer/Earth/Stoneaga/a=new
										src.contents+=a
										var/obj/perk/Abilities/Geomancer/Earth/Stonaja/b=new
										src.contents+=b
									if("Lightning")
										src.icon='Icons/Summon/Lightning Elemental.png'
										for(var/obj/perk/Abilities/a in src.contents)
											del a
										var/obj/perk/Abilities/BlackMagic/Lightning/Thundaga/a=new
										src.contents+=a
										var/obj/perk/Abilities/BlackMagic/Lightning/Thundaja/b=new
										src.contents+=b
									if("Wind")
										src.icon='Icons/Summon/Wind Elemental.png'
										for(var/obj/perk/Abilities/a in src.contents)
											del a
										var/obj/perk/Abilities/WhiteMagic/Wind/Aeroga/a=new
										src.contents+=a
										var/obj/perk/Abilities/WhiteMagic/Wind/Aeroja/b=new
										src.contents+=b
									if("Ice")
										src.icon='Icons/Summon/Ice Elemental.png'
										for(var/obj/perk/Abilities/a in src.contents)
											del a
										var/obj/perk/Abilities/BlackMagic/Ice/Blizzaga/a=new
										src.contents+=a
										var/obj/perk/Abilities/BlackMagic/Ice/Blizzaja/b=new
										src.contents+=b
							else
								alert(usr,"You lack the perk required to perform this action!")
								return
					New()
						var/obj/perk/Abilities/Geomancer/SpiritedTree/BranchArrow/a=new
						var/obj/perk/Abilities/Geomancer/SpiritedTree/BranchSpear/b=new
						var/obj/perk/MonsterAbilities/BLU/ShrapnelSeed/c=new
						var/obj/perk/MonsterAbilities/BLU/PhotosyntheticWave/d=new
						var/obj/item/Weapon/NPCWeapons/Branch/sf=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=sf
						src.eweapon=sf
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb

			Ninja
				rank="Ninja"
				name="----------Ninja--------"
				rankbonus=4
				NinjaToad
					resistance="Fire"
					name="Ninja Toad"
					icon='Icons/Summon/Toad.png'
					mhp=180
					hp=180
					mmp=200
					mp=200
					sp=200
					msp=200
					baseac=20
					str=20
					strmod=5
					dex=14
					dexmod=3
					con=20
					conmod=5
					int=14
					intmod=2
					wis=14
					wismod=2
					cha=10
					chamod=0
					mab=12
					pab=12
					mdb=18
					pdb=18
					basedr=5
					New()
						var/obj/perk/MonsterAbilities/BLU/OilBullet/a=new
						var/obj/perk/MonsterAbilities/BLU/Flamethrower/b=new
						var/obj/perk/MonsterAbilities/BLU/MagicTongue/c=new
						var/obj/perk/MonsterAbilities/BLU/ToadKata/d=new
						var/obj/perk/MonsterAbilities/BLU/HydroCannon/e=new
						var/obj/perk/Abilities/GeneralMagicAbilities/MythrilBubbles/f=new
						var/obj/perk/Abilities/GeneralMagicAbilities/Impact/g=new
						var/obj/item/Weapon/NPCWeapons/GamaRyuKen/sf=new
						src.eweapon=sf
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=e
						src.contents+=f
						src.contents+=g
						src.contents+=sf
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb
				NinjaSnake
					resistance="Drain"
					name="Ninja Snake"
					icon='Icons/Summon/Snake.png'
					mhp=100
					hp=100
					mmp=250
					mp=250
					sp=250
					msp=250
					baseac=22
					str=14
					strmod=2
					dex=20
					dexmod=5
					con=16
					conmod=3
					int=18
					intmod=4
					wis=20
					wismod=5
					cha=10
					chamod=0
					mab=14
					pab=14
					mdb=35
					pdb=35
					basedr=0
					New()
						var/obj/perk/MonsterAbilities/BLU/Vampire/a=new
						var/obj/perk/Abilities/GeneralMagicAbilities/Tether/b=new
						var/obj/perk/Abilities/GeneralMagicAbilities/Jolt/c=new
						var/obj/perk/Abilities/ArcaneMagic/Statusinfliction/Hold/d=new
						var/obj/perk/Abilities/ArcaneMagic/Bios/Bioara/e=new
						var/obj/perk/Abilities/BlackMagic/Energy/Flare/f=new
						var/obj/perk/Abilities/BlackMagic/Lightning/Thunder/g=new
						var/obj/perk/Abilities/BlackMagic/Lightning/Thundara/h=new
						var/obj/perk/Abilities/BlackMagic/Lightning/Thundaga/i=new
						var/obj/item/Weapon/NPCWeapons/SnakeFang/sf=new
						src.eweapon=sf
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=e
						src.contents+=f
						src.contents+=g
						src.contents+=h
						src.contents+=i
						src.contents+=sf
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb

				NinjaSlug
					resistance="Holy"
					icon='Icons/Summon/Slug.png'
					name="Ninja Slug"
					mhp=120
					hp=120
					mmp=200
					mp=200
					sp=200
					msp=200
					baseac=18
					str=12
					strmod=1
					dex=12
					dexmod=1
					con=12
					conmod=1
					int=18
					intmod=4
					wis=20
					wismod=5
					cha=18
					chamod=4
					mab=9
					pab=9
					mdb=18
					pdb=18
					basedr=0
					New()
						var/obj/perk/MonsterAbilities/BLU/Acid/a=new
						var/obj/perk/Abilities/GreenMagic/Refresh/b=new
						var/obj/perk/Abilities/GreenMagic/Bubble/c=new
						var/obj/perk/Abilities/GreenMagic/Protects/Protect/d=new
						var/obj/perk/Abilities/GreenMagic/Shells/Shell/e=new
						var/obj/perk/Abilities/BlackMagic/Hydro/Water/f=new
						var/obj/perk/Abilities/BlackMagic/Hydro/Watera/g=new
						var/obj/perk/Abilities/BlackMagic/Hydro/Waterga/h=new
						var/obj/perk/Abilities/WhiteMagic/Healing/Cure/i=new
						var/obj/perk/Abilities/WhiteMagic/Healing/Cura/j=new
						var/obj/perk/Abilities/WhiteMagic/Healing/Curaga/k=new
						var/obj/item/Weapon/NPCWeapons/SlugSlam/sf=new
						src.eweapon=sf
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=e
						src.contents+=f
						src.contents+=g
						src.contents+=h
						src.contents+=i
						src.contents+=j
						src.contents+=k
						src.contents+=sf
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb
				Monsterlabel
					name="----------Monsters--------"
		Monsters
			var/worldboss=0
			companiontype="Monsters"
			archived=1
			var/unroot=0
			Dragoon
				Wyvern
					name="Wyvern"
					icon='Icons/Monsters/Wyvern.png'
					rankbonus=5
					mhp=300
					hp=300
					mmp=300
					mp=300
					sp=200
					msp=200
					str=18
					strmod=4
					baseac=30
					dex=16
					dexmod=3
					con=18
					conmod=4
					int=16
					intmod=3
					wis=16
					wismod=3
					cha=14
					chamod=2
					mab=12
					pab=12
					mdb=25
					pdb=25
					basedr=5
					speed=5
					New()
						var/obj/perk/MonsterAbilities/BLU/DragoFlare/df=new
						var/obj/perk/Abilities/BlackMagic/Flame/Firaga/f=new
						var/obj/perk/Abilities/GeneralWeaponAbilities/Melee/Shout/sh=new
						var/obj/perk/MonsterAbilities/Monster/DragonClaws/dc=new
						var/obj/perk/Jobperks/Dragoon/Wyvern/wyv=new
						//var/obj/perk/MonsterPassives/Rideable/ride=new
						src.contents+=df
						src.contents+=f
						src.contents+=sh
						src.contents+=dc
						src.contents+=wyv
						//src.contents+=ride
			DRank
				name="---D Rank--"
				price=500
				encountersize=2
				rank="D"
				ac=14
				rankbonus=0

//GOBLIN
				Goblin
					name="Goblin"
					icon='Goblin.png'
					weakness="Ice"
					resistance="Dark"
					overimage='PNG/NPCOvers/Goblinover.png'
					unroot=1
					mhp=90
					hp=90
					mmp=90
					mp=90
					sp=90
					msp=90
					str=14
					strmod=2
					baseac=16
					dex=16
					dexmod=3
					con=12
					conmod=1
					int=10
					intmod=0
					wis=12
					wismod=1
					cha=10
					chamod=0
					mab=2
					pab=3
					mdb=20
					pdb=25
					fort = 2
					rflx = 6
					will = 2
					basedr = 4
					speed = 7
					New()
						var/obj/perk/MonsterAbilities/BLU/GoblinStrike/a=new
						var/obj/perk/MonsterAbilities/BLU/MagicHammer/b=new
						var/obj/item/Weapon/NPCWeapons/Punch/c=new
						var/obj/perk/monsterperk/Small/d=new
						var/obj/perk/GoblinPerk/Side_Step/e=new
						var/obj/perk/GoblinPerk/Emergency_Potion/f=new
						var/obj/perk/MonsterAbilities/BLU/Crude_Potion/g=new
						var/obj/perk/MonsterAbilities/BLU/Steal/h=new
						var/obj/perk/monsterperk/Weakness_Ice/i=new
						var/obj/perk/monsterperk/Resistance_Dark/j=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=e
						src.contents+=f
						src.contents+=g
						src.contents+=h
						src.contents+=i
						src.contents+=j
						src.eweapon=c
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb


//MANDRAGORA
				Mandragora
					name="Mandragora"
					icon='Icons/Monsters/Mandragora.png'
					weakness="Fire"
					resistance="Nature"
					encountersize=4
					unroot=1
					mhp=90
					hp=90
					mmp=130
					mp=130
					sp=110
					msp=110
					str=12
					strmod=1
					baseac=15
					dex=14
					dexmod=2
					con=14
					conmod=2
					int=10
					intmod=0
					wis=16
					wismod=3
					cha=10
					chamod=0
					mab=4
					pab=2
					mdb=30
					pdb=20
					fort = 4
					rflx = 4
					will = 5
					basedr = 3
					speed = 6
					New()
						var/obj/perk/MonsterAbilities/BLU/ShrapnelSeed/a=new
						var/obj/perk/MonsterAbilities/BLU/PhotosyntheticWave/b=new
						var/obj/perk/MonsterAbilities/BLU/Chestnut/c=new
						var/obj/perk/MonsterAbilities/BLU/Shriek/d=new
						var/obj/item/Weapon/NPCWeapons/Punch/e=new
						var/obj/perk/monsterperk/Weakness_Fire/f=new
						var/obj/perk/monsterperk/Resistance_Black_Magic/g=new
						var/obj/perk/monsterperk/Small/h=new
						var/obj/perk/monsterperk/Nature_Adept/i=new
						var/obj/perk/MandragoraPerk/Natures_Bandaid/j=new
						var/obj/perk/MandragoraPerk/Reaction_Worry_Spore/k=new
						var/obj/perk/MandragoraPerk/Safe_Space/l=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=e
						src.contents+=f
						src.contents+=g
						src.contents+=h
						src.contents+=i
						src.contents+=j
						src.contents+=k
						src.contents+=l
						src.eweapon=c
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb


//GEEZARD
				Geezard
					name="Geezard"
					icon='Icons/Monsters/Geezard.png'
					weakness="Holy"
					resistance="Drain"
					encountersize=4
					unroot=1
					mhp=110
					hp=110
					mmp=110
					mp=110
					sp=110
					msp=110
					str=14
					strmod=2
					baseac=15
					dex=14
					dexmod=2
					con=14
					conmod=2
					int=10
					intmod=0
					wis=14
					wismod=2
					cha=10
					chamod=0
					mab=3
					pab=3
					mdb=25
					pdb=25
					fort = 3
					rflx = 5
					will = 3
					basedr = 3
					speed = 6
					New()
						var/obj/perk/MonsterAbilities/BLU/GeezardClaw/a=new
						var/obj/item/Weapon/NPCWeapons/Punch/c=new
						var/obj/perk/monsterperk/Weakness_Holy/d=new
						var/obj/perk/monsterperk/Resistance_Dark/e=new
						var/obj/perk/monsterperk/Small/f=new
						var/obj/perk/monsterperk/Ripose/g=new
						var/obj/perk/monsterperk/Drainer/h=new
						var/obj/perk/Abilities/BlackMagic/Flame/Fira/i=new
						var/obj/perk/Abilities/ArcaneMagic/Drains/Drain/j=new
						src.contents+=a
						src.contents+=c
						src.contents+=d
						src.contents+=e
						src.contents+=f
						src.contents+=g
						src.contents+=h
						src.contents+=i
						src.contents+=j
						src.eweapon=c
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb


//EYE WING
				EyeWing
					name="Eye Wing"
					icon='Icons/Monsters/EyeWing.png'
					weakness="Ice"
					resistance="Fire"
					encountersize=4
					unroot=1
					mhp=90
					hp=90
					mmp=130
					mp=130
					sp=90
					msp=90
					str=10
					strmod=0
					baseac=13
					dex=16
					dexmod=3
					con=12
					conmod=1
					int=10
					intmod=0
					wis=16
					wismod=3
					cha=10
					chamod=0
					mab=4
					pab=1
					mdb= 30
					pdb= 15
					fort = 4
					rflx = 6
					will = 1
					basedr = 2
					speed = 7
					New()
						var/obj/perk/Abilities/WhiteMagic/Wind/Aero/a=new
						var/obj/perk/MonsterAbilities/BLU/PoisonPowder/b=new
						var/obj/perk/monsterperk/Weakness_Lightning/c=new
						var/obj/perk/monsterperk/Resistance_Wind/d=new
						var/obj/perk/monsterperk/Small/e=new
						var/obj/perk/monsterperk/Wind_Adept/f=new
						var/obj/perk/monsterperk/Fly_1/g=new
						var/obj/perk/EyewingPerk/Size_Up/h=new
						var/obj/perk/EyewingPerk/Aerodynamic/i=new
						var/obj/perk/MonsterAbilities/BLU/Monster_Gaze/j=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=e
						src.contents+=f
						src.contents+=g
						src.contents+=h
						src.contents+=i
						src.contents+=j
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb

//C RANKS
			CRank
				encountersize=3
				rankbonus= 0
				rank="C"
				name="--C Rank--"
				New()
					InitializeEnemy(src)
				SilverLobo
					unroot=1
					name="Silver Lobo"
					weakness="Dark"
					resistance="Metal"
					icon='Icons/Monsters/SilverLobo.png'
					mhp=200
					hp=200
					mmp=180
					mp=180
					sp=200
					msp=200
					baseac=15
					ac=15
					str=14
					strmod=2
					dex=16
					dexmod=3
					con=14
					conmod=2
					int=10
					intmod=0
					wis=12
					wismod=1
					cha=10
					chamod=0
					mab=4
					pab=5
					mdb=35
					pdb=40
					fort = 6
					rflx = 7
					will = 5
					basedr = 5
					speed = 8
					New()
						var/obj/perk/MonsterAbilities/BLU/SilverFang/a=new
						var/obj/perk/MonsterAbilities/BLU/Howl/b=new
						var/obj/perk/monsterperk/Weakness_Dark/c=new
						var/obj/perk/monsterperk/Resistance_Physical/d=new
						var/obj/perk/monsterperk/Pack_Tactics/e=new
						var/obj/perk/monsterperk/Enhanced_Smell/f=new
						var/obj/perk/SilverLoboPerk/Reaction_Counter/g=new
						var/obj/perk/SilverLoboPerk/Reaction_Flank_Guard/h=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=e
						src.contents+=f
						src.contents+=g
						src.contents+=h
						var/obj/status/HPBar/hpb=new
						src.contents+=hpb
						var/obj/status/SPBar/spb=new
						src.contents+=spb
						var/obj/status/MPBar/mpb=new
						src.contents+=mpb

				Chocobo
					name="Chocobo"
					unroot=1
					weakness="Dark"
					resistance="Nature"
					icon='Icons/Monsters/Chocobo.png'
					mhp=180
					hp=180
					mmp=260
					mp=260
					sp=180
					msp=180
					baseac=18
					ac=18
					str=14
					strmod=2
					dex=18
					dexmod=4
					con=12
					conmod=1
					int=12
					intmod=1
					wis=14
					wismod=2
					cha=14
					chamod=2
					mab=5
					pab=4
					mdb=35
					pdb=35
					fort = 5
					rflx = 8
					will = 6
					basedr = 5
					speed = 11
					New()
						var/obj/perk/MonsterAbilities/BLU/ChocoKick/a=new
						var/obj/perk/Abilities/GreenMagic/Haste/b=new
						var/obj/perk/monsterperk/Weakness_Lightning/c=new
						var/obj/perk/monsterperk/Resistance_Wind/d=new
						var/obj/perk/monsterperk/Swift/e=new
						var/obj/perk/monsterperk/Large/f=new
						var/obj/perk/monsterperk/Mount_1/g=new
						var/obj/perk/ChocoboPerk/Bonus_Action_ChocoSwift/h=new
						var/obj/perk/ChocoboPerk/Reaction_ChocoSentinel/i=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=e
						src.contents+=f
						src.contents+=g
						src.contents+=h
						src.contents+=i
						var/obj/status/HPBar/hpb=new
						src.contents+=hpb
						var/obj/status/SPBar/spb=new
						src.contents+=spb
						var/obj/status/MPBar/mpb=new
						src.contents+=mpb
				Caterchipillar
					name="Caterchipillar"
					unroot=1
					weakness="Fire"
					resistance="Bio"
					icon='Icons/Monsters/Caterchipillar.png'
					mhp=220
					hp=220
					mmp=240
					mp=240
					sp=220
					msp=220
					baseac=15
					ac=15
					str=14
					strmod=2
					dex=12
					dexmod=1
					con=16
					conmod=3
					int=12
					intmod=1
					wis=16
					wismod=3
					cha=10
					chamod=0
					mab=6
					pab=5
					mdb=40
					pdb=35
					fort = 7
					rflx = 5
					will = 7
					basedr = 6
					speed = 6
					New()
						var/obj/perk/MonsterAbilities/BLU/Ultra_Waves/a=new
						var/obj/perk/MonsterAbilities/BLU/Sticky_Webs/b=new
						var/obj/perk/MonsterAbilities/BLU/Paralyzing_Sting/c=new
						var/obj/perk/monsterperk/Weakness_Fire/d=new
						var/obj/perk/monsterperk/Resistance_Status_Effects/e=new
						var/obj/perk/monsterperk/Immune_Poison/f=new
						var/obj/perk/monsterperk/Chitin_Armor/g=new
						var/obj/perk/CaterchipillarPerk/Bonus_Action_DefenseCurl/h=new
						var/obj/perk/CaterchipillarPerk/Reaction_LongReach/i=new
						var/obj/perk/monsterperk/Resistance_Water/j=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=e
						src.contents+=f
						src.contents+=g
						src.contents+=h
						src.contents+=i
						src.contents+=j
						var/obj/status/HPBar/hpb=new
						src.contents+=hpb
						var/obj/status/SPBar/spb=new
						src.contents+=spb
						var/obj/status/MPBar/mpb=new
						src.contents+=mpb

				Bagoly
					name="Bagoly"
					unroot=1
					weakness="Thunder"
					resistance="Wind"
					icon='Icons/Monsters/Bagoly.png'
				Mu
					name="Mu"
					weakness="Osmose"
					resistance="Drain"
					unroot=1
					icon='Icons/Monsters/Mu.png'
				Hornet
					name="Hornet"
					weakness="Ice"
					resistance="Bio"
					unroot=1
					icon='Icons/Monsters/Hornet.png'
				Flan
					name="Flan"
					weakness="General"
					resistance="Physical"
					unroot=1
					icon='Icons/Monsters/Flan.png'
					mhp=160
					hp=160
					mmp=280
					mp=280
					sp=160
					msp=160
					baseac=14
					ac=14
					str=10
					strmod=0
					dex=14
					dexmod=2
					con=10
					conmod=0
					int=12
					intmod=1
					wis=18
					wismod=4
					cha=12
					chamod=1
					mab=9
					pab=4
					mdb=50
					pdb=25
					fort = 4
					rflx = 6
					will = 8
					basedr = 3
					speed = 7
					New()
						var/obj/perk/MonsterAbilities/BLU/Gelatinous_Lake/a=new
						var/obj/perk/MonsterAbilities/BLU/Goo_Stream/b=new
						var/obj/perk/Abilities/BlackMagic/Flame/Fira/c=new
						var/obj/perk/Abilities/BlackMagic/Lightning/Thundara/d=new
						var/obj/perk/Abilities/BlackMagic/Hydro/Watera/e=new
						var/obj/perk/monsterperk/Weakness_Fire/f=new
						var/obj/perk/monsterperk/Resistance_Ice/g=new
						var/obj/perk/monsterperk/Immune_Physical/h=new
						var/obj/perk/monsterperk/Magic_Adept/i=new
						var/obj/perk/monsterperk/Potent/j=new
						var/obj/perk/FlanPerk/Bonus_Action_Flan_DualCast/k=new
						var/obj/perk/FlanPerk/Reaction_Flan_Spellmunity/l=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=e
						src.contents+=f
						src.contents+=g
						src.contents+=h
						src.contents+=i
						src.contents+=j
						src.contents+=k
						src.contents+=l
						var/obj/status/HPBar/hpb=new
						src.contents+=hpb
						var/obj/status/SPBar/spb=new
						src.contents+=spb
						var/obj/status/MPBar/mpb=new
						src.contents+=mpb
				Sahaugin
					name="Sahaugin"
					weakness="Thunder"
					resistance="Fire"
					unroot=1
					icon='Icons/Monsters/Sahaugin.png'
				Rukh
					name="Rukh"
					weakness="Thunder"
					resistance="Wind"
					unroot=1
					icon='Icons/Monsters/Rukh.png'
					mhp=170
					hp=170
					mmp=170
					mp=170
					sp=170
					msp=170
					baseac=15
					ac=15
					str=14
					strmod=2
					dex=16
					dexmod=3
					con=12
					conmod=1
					int=10
					intmod=0
					wis=12
					wismod=1
					cha=10
					chamod=0
					mab=3
					pab=3
					mdb=25
					pdb=30
					fort = 5
					rflx = 7
					will = 5
					basedr = 4
					speed = 9
					New()
						var/obj/perk/MonsterAbilities/BLU/Blinder_Beak/a=new
						var/obj/perk/Abilities/WhiteMagic/Wind/Aero/b=new
						var/obj/perk/Abilities/BlackMagic/Lightning/Thundara/c=new
						var/obj/perk/Abilities/BlackMagic/Hydro/Watera/d=new
						var/obj/perk/monsterperk/Weakness_Lightning/e=new
						var/obj/perk/monsterperk/Resistance_Wind/f=new
						var/obj/perk/monsterperk/Fly_2/g=new
						var/obj/perk/monsterperk/Mount_1/h=new
						var/obj/perk/RukhPerk/Reaction_Rage/i=new
						var/obj/perk/RukhPerk/Reaction_Counter/j=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=e
						src.contents+=f
						src.contents+=g
						src.contents+=h
						src.contents+=i
						src.contents+=j
						var/obj/status/HPBar/hpb=new
						src.contents+=hpb
						var/obj/status/SPBar/spb=new
						src.contents+=spb
						var/obj/status/MPBar/mpb=new
						src.contents+=mpb
				Behemoth_Boss
					name="Behemoth (Boss)"
					weakness="Ice"
					resistance="Physical/Status Effects/Earth/Fire"
					unroot=1
					icon='Icons/Monsters/BehemothBoss.png'
					mhp=600
					hp=600
					mmp=400
					mp=400
					sp=800
					msp=800
					baseac=18
					ac=18
					str=24
					strmod=7
					dex=18
					dexmod=4
					con=18
					conmod=4
					int=10
					intmod=0
					wis=12
					wismod=1
					cha=10
					chamod=0
					mab=6
					pab=2
					mdb=10
					pdb=25
					fort = 8
					rflx = 8
					will = 5
					basedr = 10 //+5 vs Magic..
					speed = 9
					New()
						var/obj/perk/MonsterAbilities/BLU/Charge/a=new
						var/obj/perk/MonsterAbilities/BLU/Horn_Skewer/b=new
						var/obj/perk/MonsterAbilities/BLU/Build_Up_Steam/c=new
						var/obj/perk/Abilities/WhiteMagic/Wind/Aero/d=new
						var/obj/perk/Abilities/BlackMagic/Lightning/Thundara/e=new
						var/obj/perk/Abilities/BlackMagic/Hydro/Watera/f=new
						var/obj/perk/monsterperk/Weakness_Ice/g=new
						var/obj/perk/monsterperk/Resistance_Physical/h=new
						var/obj/perk/monsterperk/Resistance_Status_Effects/i=new
						var/obj/perk/monsterperk/Resistance_Earth/j=new
						var/obj/perk/monsterperk/Resistance_Fire/k=new
						var/obj/perk/monsterperk/Immune_Slow/l=new
						var/obj/perk/monsterperk/Immune_Mind/m=new
						var/obj/perk/monsterperk/Magic_Hide/n=new
						var/obj/perk/monsterperk/Lair_Effect_Unsteady_Footing/o=new
						var/obj/perk/monsterperk/Lair_Effect_Rocks_Fall/p=new
						var/obj/perk/monsterperk/Advanced_Rage/q=new
						var/obj/perk/Behemoth_Boss_Perk/Reaction_Counter/r=new
						var/obj/perk/Behemoth_Boss_Perk/Bonus_Action_Earth_Shaker/s=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=e
						src.contents+=f
						src.contents+=g
						src.contents+=h
						src.contents+=i
						src.contents+=j
						src.contents+=k
						src.contents+=l
						src.contents+=m
						src.contents+=n
						src.contents+=o
						src.contents+=p
						src.contents+=q
						src.contents+=r
						src.contents+=s
						var/obj/status/HPBar/hpb=new
						src.contents+=hpb
						var/obj/status/SPBar/spb=new
						src.contents+=spb
						var/obj/status/MPBar/mpb=new
						src.contents+=mpb

				Behemoth_Infant
					name="Behemoth Infant"
					weakness="Ice"
					resistance="Bludgeoning"
					unroot=1
					icon='Icons/Monsters/Baby_Behemoth.png'
					mhp=200
					hp=200
					mmp=160
					mp=160
					sp=200
					msp=200
					baseac=14
					ac=14
					str=16
					strmod=3
					dex=14
					dexmod=2
					con=14
					conmod=2
					int=10
					intmod=0
					wis=10
					wismod=0
					cha=10
					chamod=0
					mab=3
					pab=6
					mdb=15
					pdb=25
					fort = 6
					rflx = 6
					will = 4
					basedr = 5
					speed = 6
					New()
						var/obj/perk/monsterperk/Weakness_Ice/a=new
						var/obj/perk/monsterperk/Resistance_Bludgeoning/b=new
						var/obj/item/Weapon/NPCWeapons/Horn/c=new
						var/obj/perk/MonsterAbilities/BLU/Baby_Charge/d=new
						var/obj/perk/BehemothInfantPerks/Bonus_Action_Fend_for_Itself/e=new
						var/obj/perk/BehemothInfantPerks/Reaction_Cute_Charm/f=new
						var/obj/perk/BehemothInfantPerks/Rage/g=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=e
						src.contents+=f
						src.contents+=g
						var/obj/status/HPBar/hpb=new
						src.contents+=hpb
						var/obj/status/SPBar/spb=new
						src.contents+=spb
						var/obj/status/MPBar/mpb=new
						src.contents+=mpb

				Sin_Scale
					name="Sin Scale"
					weakness="Holy"
					resistance="Dark"
					unroot=1
					icon='Icons/Monsters/Sinscale.png'
					mhp=180
					hp=180
					mmp=170
					mp=170
					sp=180
					msp=180
					baseac=16
					ac=16
					str=12
					strmod=1
					dex=16
					dexmod=3
					con=14
					conmod=2
					int=12
					intmod=1
					wis=14
					wismod=2
					cha=10
					chamod=0
					mab=5
					pab=3
					mdb=25
					pdb=15
					fort = 5
					rflx = 8
					will = 4
					basedr = 2
					speed = 7
					New()
						var/obj/perk/Abilities/ArcaneMagic/Bios/Bio/a=new
						var/obj/perk/Abilities/ArcaneMagic/Bios/Bioara/b=new
						var/obj/perk/Abilities/ArcaneMagic/Drains/Drain/c=new
						var/obj/perk/Abilities/ArcaneMagic/Osmoses/Osmose/d=new
						var/obj/perk/monsterperk/Weakness_Holy/e=new
						var/obj/perk/monsterperk/Resistance_Dark/f=new
						var/obj/perk/monsterperk/Fly_2/g=new
						var/obj/perk/monsterperk/Pack_Tactics/h=new
						var/obj/perk/monsterperk/Small/i=new
						var/obj/perk/Sin_ScalePerk/Reaction_Toxin_Explosion/j=new
						var/obj/perk/Sin_ScalePerk/Bonus_Action_ScaleDance/k=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=e
						src.contents+=f
						src.contents+=g
						src.contents+=h
						src.contents+=i
						src.contents+=j
						src.contents+=k
						var/obj/status/HPBar/hpb=new
						src.contents+=hpb
						var/obj/status/SPBar/spb=new
						src.contents+=spb
						var/obj/status/MPBar/mpb=new
						src.contents+=mpb
				Ankheg
					name="Ankheg"
					weakness="Fire"
					resistance="Earth"
					unroot=1
					icon='Icons/Monsters/Ankheg.png'
				Mortibody
					name="Mortibody"
					weakness="Holy"
					resistance="Dark"
					unroot=1
					icon='Icons/Monsters/Mortibody.png'
				PitFiend
					name="Pit Fiend"
					weakness="Holy"
					resistance="Dark"
					name="Pit Fiend"
					unroot=1
					icon='Icons/Monsters/PitFiend.png'
				StingRay
					name="Sting Ray"
					weakness="Thunder"
					resistance="Water"
					name="Sting Ray"
					unroot=1
					icon='Icons/Monsters/Stingray.png'
				Mesmerize
					name="Mesmerize"
					weakness="Comet"
					resistance="Holy"
					unroot=1
					icon='Icons/Monsters/Mesmerize.png'
				Steeling
					name="Steeling"
					weakness="Holy"
					resistance="Metal"
					unroot=1
					icon='Icons/Monsters/Steeling.png'
				Wererat
					name="Wererat"
					weakness="Metal"
					resistance="Bio"
					unroot=1
					icon='Icons/Monsters/Wererat.png'
				Grangalon
					name="Grangalon"
					weakness="Dark"
					resistance="Metal"
					unroot=1
					icon='Icons/Monsters/Grangalon.png'
				Bomb
					name="Bomb"
					weakness="Ice"
					resistance="Fire"
					unroot=1
					icon='Icons/Monsters/Bomb.png'
				Aerouge
					name="Aerouge"
					weakness="Ice"
					resistance="Thunder"
					name="Aerouge"
					unroot=1
					icon='Icons/Monsters/Aerouge.png'
				Funguar
					name="Funguar"
					weakness="Fire"
					resistance="Nature"
					name="Funguar"
					unroot=1
					icon='Icons/Monsters/Funguar.png'
				BlazeBeetle
					weakness="Ice"
					resistance="Fire"
					name="Blaze Beetle"
					unroot=1
					icon='Icons/Monsters/BlazeBeetle.png'
				Crawler
					name="Crawler"
					weakness="Fire"
					resistance="Earth"
					unroot=1
					icon='Icons/Monsters/Crawler.png'
				Cactuar
					name="Cactuar"
					weakness="Metal"
					resistance="Nature"
					unroot=1
					icon='Icons/Monsters/Cactuar.png'
				Arcophes
					name="Arcophes"
					weakness="Thunder"
					resistance="Water"
					unroot=1
					icon='Icons/Monsters/Acrophes.png'
				EnchantedFan
					weakness="General"
					resistance="Wind"
					name="Enchanted Fan"
					unroot=1
					icon='Icons/Monsters/EnchantedFan.png'
				TouchMe
					weakness="Metal"
					resistance="Bio"
					name="Touch Me"
					unroot=1
					icon='Icons/Monsters/Touchme.png'
				DorkyFace
					weakness="Holy"
					resistance="Dark"
					name="Dorky Face"
					unroot=1
					icon='Icons/Monsters/DorkyFace.png'


//B RANKS
			BRank
				rankbonus=0
				encountersize=4
				rank="B"
				name="--B Rank--"
				New()
					InitializeEnemy(src)
				Gigantoad
					name="Gigantoad"
					weakness="Lightning"
					resistance="Water"
					unroot=1
					icon='Icons/Monsters/Gigantoad.png'
					mhp=420
					hp=420
					mmp=360
					mp=360
					sp=420
					msp=420
					baseac=16
					ac=16
					str=14
					strmod=2
					dex=16
					dexmod=3
					con=20
					conmod=5
					int=10
					intmod=0
					wis=14
					wismod=2
					cha=10
					chamod=0
					mab=8
					pab=9
					mdb=40
					pdb=45
					fort = 16
					rflx = 10
					will = 9
					basedr = 11
					speed = 8
					New()
						var/obj/perk/MonsterAbilities/BLU/GiganToad_Tongue_Restrict/a=new
						var/obj/perk/MonsterAbilities/BLU/GiganToad_Consume/b=new
						var/obj/perk/monsterperk/Immune_Toad/c=new
						var/obj/perk/monsterperk/Large/d=new
						var/obj/perk/monsterperk/Weakness_Lightning/e=new
						var/obj/perk/monsterperk/Resistance_Water/f=new
						var/obj/perk/monsterperk/Expert_Focus/g=new
						var/obj/perk/monsterperk/Swimmer_1/h=new
						var/obj/perk/GiganToadPerk/Bonus_Action_SticklerTongue/i=new
						var/obj/perk/GiganToadPerk/Reaction_PoisonHide/j=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=e
						src.contents+=f
						src.contents+=g
						src.contents+=h
						src.contents+=i
						src.contents+=j
						var/obj/status/HPBar/hpb=new
						src.contents+=hpb
						var/obj/status/SPBar/spb=new
						src.contents+=spb
						var/obj/status/MPBar/mpb=new
						src.contents+=mpb
				Gargoyle
					name="Gargoyle"
					weakness="Holy"
					resistance="Dark"
					unroot=1
					icon='Icons/Monsters/Gargoyle.png'
				FlanMaster
					name="Flan Master"
					weakness="Metal"
					resistance="Nature"
					name="Flan Master"
					unroot=1
					icon='Icons/Monsters/Flanmaster.png'
				Garula
					name="Garula"
					weakness="Fire"
					resistance="Ice"
					unroot=1
					icon='Icons/Monsters/Garula.png'
				Dullahan
					name="Dullahan"
					weakness="General"
					resistance="Physical"
					unroot=1
					icon='Icons/Monsters/Dullahan.png'
				Grenade
					name="Grenade"
					weakness="Ice"
					resistance="Fire"
					unroot=1
					icon='Icons/Monsters/Grenade.png'
				Orthos
					name="Orthos"
					weakness="General"
					resistance="Physical"
					unroot=1
					icon='Icons/Monsters/Orthos.png'
				Aeronite
					name="Aeronite"
					weakness="Thunder"
					resistance="Wind"
					unroot=1
					icon='Icons/Monsters/Aeronite.png'
				Buel
					name="Buel"
					weakness="Lightning"
					resistance="Magic (Except Thunder)"
					name="Buel"
					unroot=1
					icon='Icons/Monsters/Buel.png'
					mhp=380
					hp=380
					mmp=480
					mp=480
					sp=380
					msp=380
					baseac=19
					ac=19
					str=10
					strmod=0
					dex=16
					dexmod=3
					con=16
					conmod=3
					int=14
					intmod=2
					wis=18
					wismod=4
					cha=14
					chamod=2
					mab=12
					pab=6
					mdb=75
					pdb=30
					fort = 9
					rflx = 9
					will = 10
					basedr = 9
					speed = 9
					New()
						var/obj/perk/Abilities/BlackMagic/Flame/Fira/a=new
						var/obj/perk/Abilities/BlackMagic/Lightning/Thundaga/b=new
						var/obj/perk/Abilities/TimeMage/Greens/Reflect/c=new
						var/obj/perk/Abilities/WhiteMagic/Wind/Aero/d=new
						var/obj/perk/monsterperk/Weakness_Lightning/e=new
						var/obj/perk/monsterperk/Resistance_Magical_NonLightning/f=new
						var/obj/perk/monsterperk/Fly_2/g=new
						var/obj/perk/monsterperk/Float/h=new
						var/obj/perk/monsterperk/Magic_Adept/i=new
						var/obj/perk/monsterperk/Potent/j=new
						var/obj/perk/BuelPerk/Reaction_DualMirror/k=new
						var/obj/perk/BuelPerk/Bonus_Action_SwiftCast/l=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=e
						src.contents+=f
						src.contents+=g
						src.contents+=h
						src.contents+=i
						src.contents+=j
						src.contents+=k
						src.contents+=l
						var/obj/status/HPBar/hpb=new
						src.contents+=hpb
						var/obj/status/SPBar/spb=new
						src.contents+=spb
						var/obj/status/MPBar/mpb=new
						src.contents+=mpb
				Darkmare
					name="Darkmare"
					weakness="Comet"
					resistance="Dark"
					name="Darkmare"
					unroot=1
					icon='Icons/Monsters/Darkmare.png'
				MythrilGolem
					name="Mythril Golem"
					weakness="Metal"
					resistance="Earth"
					name="Mythril Golem"
					unroot=1
					icon='Icons/Monsters/MythrilGolem.png'
				HellHound
					name="Hellhound"
					weakness="Holy"
					resistance="Fire"
					name="Hell Hound"
					unroot=1
					icon='Icons/Monsters/Hellhound.png'
				WoollyCroc
					weakness="Thunder"
					resistance="Water"
					name="Woolly Croc"
					unroot=1
					icon='Icons/Monsters/WoollyCroc.png'
				NatureGolem
					weakness="Fire"
					resistance="Nature"
					name="Nature Golem"
					unroot=1
					icon='Icons/Monsters/NatureGolem.png'
				Slaven
					weakness="Ice"
					resistance="Thunder"
					unroot=1
					name="Slaven"
					icon='Icons/Monsters/Slaven.png'
				Shoopuff
					name="Shoopuff"
					weakness="Flare"
					resistance="Water"
					unroot=1
					icon='Icons/Monsters/Shoopuff.png'
				Oiling
					name="Oiling"
					weakness="Fire"
					resistance="Bio"
					unroot=1
					icon='Icons/Monsters/Oiling.png'
				Ochu
					name="Ochu"
					weakness="Fire"
					resistance="Nature"
					unroot=1
					icon='Icons/Monsters/Ochu.png'
				Sleipnir
					name="Sleipnir"
					weakness="Holy"
					resistance="Metal"
					name="Sleipnir"
					unroot=1
					icon='Icons/Monsters/Sleipnir.png'
				SkullEater
					name="Skull Eater"
					weakness="Holy"
					resistance="Death"
					name="Skull Eater"
					unroot=1
					icon='Icons/Monsters/SkullEater.png'
				IceGigas
					weakness="Fire"
					resistance="Ice"
					name="Ice Gigas"
					unroot=1
					icon='Icons/Monsters/IceGigas.png'
				CursedBeing
					weakness="Holy"
					resistance="Dark"
					name="Cursed Being"
					unroot=1
					icon='Icons/Monsters/CursedBeing.png'
				LandWorm
					weakness="Comet"
					resistance="Earth"
					unroot=1
					name="Land Worm"
					icon='Icons/Monsters/LandWorm.png'
				Arachne
					name="Arachne"
					weakness="Metal"
					resistance="Dark"
					unroot=1
					icon='Icons/Monsters/Arachne.png'
				Chimera
					name="Chimera"
					weakness="Comet"
					resistance="General"
					unroot=1
					icon='Icons/Monsters/Chimera.png'
				Tonberry
					name="Tonberry"
					weakness="Comet"
					resistance="Dark"
					unroot=1
					icon='Icons/Monsters/Tonberry.png'
				IronClaw
					name="Iron Claw"
					weakness="Comet"
					resistance="Metal"
					name="Iron Claw"
					unroot=1
					icon='Icons/Monsters/IronClaw.png'
				Mimic
					name="Mimic"
					weakness="Holy"
					resistance="Dark"
					unroot=1
					icon='Icons/Monsters/Mimic.png'
				Adamankary
					name="Adamankary"
					weakness="Water"
					resistance="Bio"
					unroot=1
					icon='Icons/Monsters/Adamankary.png'
				Karlabos
					name="Karlabos"
					weakness="Thunder"
					resistance="Water"
					unroot=1
					icon='Icons/Monsters/Karlabos.png'
				HellRider
					name="Hell Rider"
					weakness="Water"
					resistance="Flare"
					name="Hell Rider"
					unroot=1
					icon='Icons/Monsters/HellRider.png'
				DeathDealer
					weakness="Holy"
					resistance="Flare"
					name="Death Dealer"
					unroot=1
					icon='Icons/Monsters/DeathDealer.png'
				Cockatrice
					weakness="Earth"
					resistance="Water"
					unroot=1
					name="Cockatrice"
					icon='Icons/Monsters/Cockatrice.png'
				Behemoth
					weakness="Water"
					resistance="Comet"
					unroot=1
					name="Behemoth"
					icon='Icons/Monsters/Behemoth.png'
				Coeurl
					weakness="Water"
					resistance="Thunder"
					unroot=1
					name="Coeurl"
					icon='Icons/Monsters/Coeurl.png'
				RedSoul
					name="Red Soul"
					weakness="Water"
					resistance="Fire"
					name="Red Soul"
					unroot=1
					icon='Icons/Monsters/RedSoul.png'
				Armadilion
					name="Armadilion"
					weakness="Comet"
					resistance="Metal"
					unroot=1
					icon='Icons/Monsters/Aramadilio.png'
			ARank
				encountersize=4
				rankbonus=5
				mhp=880
				hp=880
				mmp=900
				mp=900
				sp=900
				msp=900
				baseac=26
				ac=26
				str=20
				strmod=5
				dex=20
				dexmod=5
				con=20
				conmod=5
				int=20
				intmod=5
				wis=20
				wismod=5
				cha=20
				chamod=5
				mab=20
				pab=20
				mdb=25
				pdb=25
				rank="A"
				name="--A Rank--"
				New()
					InitializeEnemy(src)
				DeathScythe
					weakness="Holy"
					resistance="Dark"
					name="Death Scythe"
					unroot=1
					icon='Icons/Monsters/Deathscythe.png'
				Archaeosaur
					name="Archaeosaur"
					weakness="Metal"
					resistance="Dark"
					unroot=1
					icon='Icons/Monsters/Archaeosaur.png'
				Abductor
					name="Abductor"
					weakness="Nature"
					resistance="Wind"
					unroot=1
					icon='Icons/Monsters/Abductor.png'
				Adamantoise
					name="Adamantoise"
					weakness="Comet"
					resistance="Metal"
					unroot=1
					icon='Icons/Monsters/Adamantoise.png'
				Thextera
					name="Thextera"
					weakness="Thunder"
					resistance="Water"
					unroot=1
					icon='Icons/Monsters/Thextera.png'
				Evrae
					name="Evrae"
					weakness="Thunder"
					resistance="Flare"
					unroot=1
					icon='Icons/Monsters/Evrae.png'
				Beezelbub
					name="Beezelbub"
					weakness="Holy"
					resistance="Bio"
					unroot=1
					icon='Icons/Monsters/Beezelbub.png'
				Scylla
					name="Scylla"
					weakness="Metal"
					resistance="Holy"
					unroot=1
					icon='Icons/Monsters/Scylla.png'
				Ahriman
					name="Ahriman"
					weakness="Ice"
					resistance="Thunder"
					unroot=1
					icon='Icons/Monsters/Ahriman.png'
				Basilisk
					name="Basilisk"
					weakness="Metal"
					resistance="Bio"
					unroot=1
					icon='Icons/Monsters/Basilisk.png'
				ChocoboEater
					weakness="General"
					resistance="Physical"
					name="Chocobo Eater"
					unroot=1
					icon='Icons/Monsters/ChocoboEater.png'
				DemonWall
					weakness="Water"
					resistance="Earth"
					name="Demon Wall"
					unroot=1
					icon='Icons/Monsters/DemonWall.png'
				Antlion
					name="Antlion"
					weakness="Ice"
					resistance="Earth"
					unroot=1
					icon='Icons/Monsters/Antlion.png'
				MindFlayer
					weakness="Physical"
					resistance="Thunder"
					name="Mind Flayer"
					unroot=1
					icon='Icons/Monsters/Mindflayer.png'
				Malboro
					name="Malboro"
					weakness="Fire"
					resistance="Bio"
					unroot=1
					icon='Icons/Monsters/Malboro.png'
				Gigantuar
					name="Gigantuar"
					weakness="Metal"
					resistance="Nature"
					unroot=1
					icon='Icons/Monsters/Gigantuar.png'
				Elnoyle
					name="Elnoyle"
					weakness="Comet"
					resistance="Death"
					unroot=1
					icon='Icons/Monsters/Elnoyle.png'
				Varuna
					name="Varuna"
					weakness="Fire"
					resistance="Ice"
					unroot=1
					icon='Icons/Monsters/Varuna.png'
				Giruvengan
					name="Giruvengan"
					weakness="Holy"
					resistance="Dark"
					unroot=1
					icon='Icons/Monsters/Ghostguy.png'
				IronGiant
					name="Iron Giant"
					weakness="General"
					resistance="Physical"
					name="Iron Giant"
					unroot=1
					icon='Icons/Monsters/IronGiant.png'
				Catoblepas
					name="Catoblepas"
					weakness="Holy"
					resistance="Dark"
					unroot=1
					icon='Icons/Monsters/Catoblepas.png'
			SRank
				rank="A"
				name="--S Rank--"
				rankbonus=5
				Sin
					BodyofSin
						name="Body of Sin"
						icon='Icons/Monsters/Sin.png'
						unroot=1
						mhp=6000
						hp=6000
						mmp=5000
						mp=5000
						sp=5000
						msp=5000
						str=26
						strmod=9
						dex=12
						dexmod=1
						con=18
						conmod=4
						int=20
						intmod=5
						wis=26
						wismod=8
						cha=20
						chamod=5
						baseac=36
						mab=16
						pab=16
						mdb=35
						pdb=35
						basedr=15
					ScaleofSin
						unroot=1
						name="Scale of Sin"
						icon='Icons/Monsters/Sinscale.png'
						mhp=250
						hp=250
						mmp=350
						mp=350
						sp=350
						msp=350
						str=22
						strmod=6
						dex=12
						dexmod=1
						con=18
						conmod=4
						int=20
						intmod=5
						wis=24
						wismod=7
						cha=20
						chamod=5
						baseac=25
						mab=10
						pab=10
						mdb=20
						pdb=20
						basedr=5
					TentacleofSin
						name="Tentacle of Sin"
						icon='Icons/Monsters/Sintentacle.png'
						unroot=1
						mhp=200
						hp=200
						mmp=350
						mp=350
						sp=350
						msp=350
						str=22
						strmod=6
						dex=12
						dexmod=1
						con=18
						conmod=4
						int=20
						intmod=5
						wis=24
						wismod=7
						cha=20
						chamod=5
						baseac=20
						mab=12
						pab=12
						mdb=25
						pdb=25
						basedr=0
				Jenova
					name="Jenova the Astral Cataclysm"
					icon='Icons/Monsters/Jenovapod.png'
					weakness="Holy"
					resistance="Dark"
					unroot=1
					mhp=4000
					hp=4000
					mmp=3000
					mp=3000
					sp=3000
					msp=3000
					str=16
					strmod=3
					dex=12
					dexmod=1
					con=18
					conmod=4
					int=20
					intmod=5
					wis=22
					wismod=6
					cha=20
					chamod=5
					baseac=18
					mab=16
					pab=16
					mdb=25
					pdb=25
					New()
						var/obj/perk/Abilities/ArcaneMagic/Drains/Drain/a=new
						var/obj/perk/Abilities/ArcaneMagic/Osmoses/Osmose/b=new
						var/obj/perk/Abilities/ArcaneMagic/Bios/Bio/c=new
						var/obj/perk/Abilities/ArcaneMagic/Bios/Bioara/d=new
						var/obj/perk/Abilities/ArcaneMagic/Bios/Bioaga/e=new
						var/obj/perk/Abilities/ArcaneMagic/Bios/Scourge/f=new
						var/obj/perk/Abilities/ArcaneMagic/Statusinfliction/Silence/g=new
						var/obj/perk/Boss/Jenova/BossJenova/jen1=new
						var/obj/perk/Boss/Jenova/Geostigma/jen2=new
						var/obj/perk/Boss/Jenova/ParasiteSpores/jen3=new
						var/obj/perk/Boss/Jenova/BiologicalParasite/jen4=new
						var/obj/perk/MonsterAbilities/Monster/Tentacle/wepy=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=e
						src.contents+=f
						src.contents+=g
						src.contents+=jen1
						src.contents+=jen2
						src.contents+=jen3
						src.contents+=jen4
						src.contents+=wepy
						src.eweapon=wepy
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb
				JenovaZygote
					name="Jenova Zygote"
					icon='Icons/Monsters/Zygote.png'
					weakness="Holy"
					resistance="Dark"
					unroot=1
					mhp=550
					hp=550
					mmp=400
					mp=400
					sp=400
					msp=400
					str=16
					strmod=3
					dex=12
					dexmod=1
					con=18
					conmod=4
					int=10
					intmod=0
					wis=14
					wismod=2
					cha=12
					chamod=1
					baseac=13
					mab=15
					pab=15
					mdb=20
					pdb=20
					New()
						var/obj/perk/Boss/Jenova/Gas/jen1=new
						src.contents+=jen1
						var/obj/perk/MonsterAbilities/Monster/Tentacle/wepy=new
						src.contents+=wepy
						src.eweapon=wepy
			FateBoss
				rank="C"
				worldboss=1
				encountersize=3
				Brachiosaur
					icon='Icons/Monsters/Brachiosaur.png'
					name="Brachiosaur"
					resistance="Energy"
					weakness="Nature"
					unroot=1
					mhp=2000
					hp=2000
					mmp=1000
					mp=1000
					sp=1000
					msp=1000
					str=20
					strmod=5
					dex=20
					dexmod=5
					con=20
					conmod=5
					int=20
					intmod=5
					wis=20
					wismod=5
					cha=20
					chamod=5
					baseac=24
					mab=18
					pab=18
					mdb=35
					pdb=35
					New()
						var/obj/perk/Abilities/BlackMagic/Energy/Ultima/a=new
						var/obj/perk/Abilities/WhiteMagic/Healing/Curaga/b=new
						var/obj/perk/Abilities/Geomancer/Earth/Stonaja/c=new
						var/obj/perk/Abilities/WhiteMagic/Healing/Regen/d=new
						var/obj/item/Weapon/NPCWeapons/Punch/wep=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=wep
						src.eweapon=wep
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb
				HaywireMecha
					name="Haywire Mecha"
					resistance="Metal"
					weakness="Thunder"
					icon='Icons/Monsters/Haywire.png'
					unroot=1
					mhp=2000
					hp=2000
					mmp=1000
					mp=1000
					sp=1000
					msp=1000
					str=20
					strmod=5
					dex=20
					dexmod=5
					con=20
					conmod=5
					int=20
					intmod=5
					wis=20
					wismod=5
					cha=20
					chamod=5
					baseac=24
					mab=18
					pab=18
					mdb=35
					pdb=35
					New()
						var/obj/perk/Abilities/BlackMagic/Energy/Scathe/a=new
						var/obj/perk/Abilities/BlackMagic/Lightning/Thundaja/b=new
						var/obj/perk/MonsterAbilities/BLU/SilverWheel/c=new
						var/obj/perk/Abilities/GreenMagic/Refresh/d=new
						var/obj/item/Weapon/NPCWeapons/Punch/wep=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=wep
						src.eweapon=wep
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb
				BerserkGiant
					name="Berserk Giant"
					resistance="Physical"
					weakness="General"
					icon='Icons/Monsters/Berserkgiant.png'
					unroot=1
					mhp=2000
					hp=2000
					mmp=1000
					mp=1000
					sp=1000
					msp=1000
					str=20
					strmod=5
					dex=20
					dexmod=5
					con=20
					conmod=5
					int=20
					intmod=5
					wis=20
					wismod=5
					cha=20
					chamod=5
					baseac=24
					mab=18
					pab=18
					mdb=35
					pdb=35
					New()
						var/obj/perk/Abilities/GeneralWeaponAbilities/Melee/BladeBeam/a=new
						var/obj/perk/Abilities/BlackMagic/Lightning/Thundaja/b=new
						var/obj/perk/MonsterAbilities/BLU/Heave/c=new
						var/obj/perk/Abilities/GreenMagic/Refresh/d=new
						var/obj/item/Weapon/Special/BusterSword/Orichalcum/wep=new
						var/obj/perk/Abilities/WhiteMagic/Healing/Regen/e=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=e
						src.contents+=wep
						src.eweapon=wep
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb
				MalboroKing
					name="Malboro King"
					resistance="Bio"
					weakness="Fire"
					icon='Icons/Monsters/MalboroKing.png'
					unroot=1
					mhp=2000
					hp=2000
					mmp=1000
					mp=1000
					sp=1000
					msp=1000
					str=20
					strmod=5
					dex=20
					dexmod=5
					con=20
					conmod=5
					int=20
					intmod=5
					wis=20
					wismod=5
					cha=20
					chamod=5
					baseac=24
					mab=18
					pab=18
					mdb=35
					pdb=35
					New()
						var/obj/perk/MonsterAbilities/BLU/DeathBreath/a=new
						var/obj/perk/MonsterAbilities/BLU/OilBullet/b=new
						var/obj/perk/MonsterAbilities/BLU/BioSphere/c=new
						var/obj/perk/Abilities/WhiteMagic/Healing/Regen/d=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb
				VoidDweller
					name="Void Dweller"
					resistance="Dark"
					weakness="Holy"
					icon='Icons/Monsters/VoidDweller.png'
					unroot=1
					mhp=2000
					hp=2000
					mmp=1000
					mp=1000
					sp=1000
					msp=1000
					str=20
					strmod=5
					dex=20
					dexmod=5
					con=20
					conmod=5
					int=20
					intmod=5
					wis=20
					wismod=5
					cha=20
					chamod=5
					baseac=24
					mab=18
					pab=18
					mdb=35
					pdb=35
					New()
						var/obj/perk/Abilities/ArcaneMagic/Darkness/Darkja/a=new
						var/obj/perk/Abilities/BlackMagic/Energy/Scathe/b=new
						var/obj/perk/Abilities/GreenMagic/Protects/Protect/c=new
						var/obj/perk/Abilities/GreenMagic/Shells/Shell/d=new
						var/obj/perk/Abilities/BlackMagic/Flame/Firaja/e=new
						var/obj/perk/Abilities/BlackMagic/Energy/Ultima/f=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=e
						src.contents+=f
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb
				Orichalcoise
					name="Orichalcoise"
					resistance="Earth"
					weakness="Water"
					icon='Icons/Monsters/Orichalcoise.png'
					unroot=1
					mhp=2000
					hp=2000
					mmp=1000
					mp=1000
					sp=1000
					msp=1000
					str=20
					strmod=5
					dex=20
					dexmod=5
					con=20
					conmod=5
					int=20
					intmod=5
					wis=20
					wismod=5
					cha=20
					chamod=5
					baseac=24
					mab=18
					pab=18
					mdb=35
					pdb=35
					New()
						var/obj/perk/Abilities/Geomancer/Quake/a=new
						var/obj/perk/MonsterAbilities/BLU/AdamantDrum/b=new
						var/obj/perk/Abilities/GreenMagic/Protects/Protect/c=new
						var/obj/perk/Abilities/GreenMagic/Shells/Shell/d=new
						var/obj/perk/Abilities/WhiteMagic/Healing/Regen/e=new
						var/obj/perk/Abilities/BlackMagic/Hydro/Tsunami/f=new
						var/obj/perk/MonsterAbilities/BLU/ClawStrike/g=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=e
						src.contents+=f
						src.contents+=g
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb
				LichKing
					name="Lich King"
					resistance="Dark"
					weakness="Holy"
					icon='Icons/Summon/Necromancer/Lich.png'
					unroot=1
					mhp=2000
					hp=2000
					mmp=1000
					mp=1000
					sp=1000
					msp=1000
					str=20
					strmod=5
					dex=20
					dexmod=5
					con=20
					conmod=5
					int=20
					intmod=5
					wis=20
					wismod=5
					cha=20
					chamod=5
					baseac=24
					mab=18
					pab=18
					mdb=35
					pdb=35
					New()
						var/obj/perk/Abilities/ArcaneMagic/Darkness/Darkja/a=new
						var/obj/perk/Abilities/BlackMagic/Energy/Scathe/b=new
						var/obj/perk/Abilities/GreenMagic/Protects/Protect/c=new
						var/obj/perk/Abilities/GreenMagic/Shells/Shell/d=new
						var/obj/perk/Abilities/BlackMagic/Flame/Firaja/e=new
						var/obj/perk/Abilities/ArcaneMagic/Drains/Drainga/f=new
						var/obj/perk/Abilities/ArcaneMagic/Osmoses/Osmosega/g=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=e
						src.contents+=f
						src.contents+=g
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb
				TonberryKing
					name="Tonberry King"
					resistance="Death"
					weakness="Holy"
					icon='Icons/Monsters/TonberryKing.png'
					unroot=1
					mhp=2000
					hp=2000
					mmp=1000
					mp=1000
					sp=1000
					msp=1000
					str=20
					strmod=5
					dex=20
					dexmod=5
					con=20
					conmod=5
					int=20
					intmod=5
					wis=20
					wismod=5
					cha=20
					chamod=5
					baseac=24
					mab=18
					pab=18
					mdb=35
					pdb=35
					New()
						var/obj/perk/Abilities/ArcaneMagic/Darkness/Darkja/a=new
						var/obj/perk/Abilities/WhiteMagic/Healing/Curada/b=new
						var/obj/perk/Abilities/GreenMagic/Protects/Protect/c=new
						var/obj/perk/Abilities/GreenMagic/Shells/Shell/d=new
						var/obj/perk/MonsterAbilities/Monster/CursedClaws/e=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
						src.contents+=d
						src.contents+=e
						var/obj/status/HPBar/hpb = new
						src.contents+=hpb
						var/obj/status/SPBar/spb = new
						src.contents+=spb
						var/obj/status/MPBar/mpb = new
						src.contents+=mpb



proc
	viewsheet(var/mob/u,var/obj/npc/t)
		u.npcsheet = t
		var/row
		var/row2
		var/row3
		winset(u,"NPCSheet","is-visible=true")
		winset(u,"NPCSheet.Nameplate","text=\"[t.name]\"")
		winset(u,"NPCSheet.str","text=\"[t.str]+[t.addstr]/[t.strmod]\"")
		winset(u,"NPCSheet.dex","text=\"[t.dex]+[t.adddex]/[t.dexmod]\"")
		winset(u,"NPCSheet.con","text=\"[t.con]+[t.addcon]/[t.conmod]\"")
		winset(u,"NPCSheet.int","text=\"[t.int]+[t.addint]/[t.intmod]\"")
		winset(u,"NPCSheet.wis","text=\"[t.wis]+[t.addwis]/[t.wismod]\"")
		winset(u,"NPCSheet.cha","text=\"[t.cha]+[t.addcha]/[t.chamod]\"")
		winset(u,"NPCsheet.HP","text=\"[t.hp]/[t.mhp]\"")
		winset(u,"NPCsheet.MP","text=\"[t.mp]/[t.mmp]\"")
		winset(u,"NPCsheet.SP","text=\"[t.sp]/[t.msp]\"")
		winset(u,"NPCsheet.AC","text=\"[t.baseac]\"")
		winset(u,"NPCsheet.DR","text=\"[t.basedr]\"")
		winset(u,"NPCsheet.SPD","text=\"[t.speed]\"")
		winset(u,"NPCsheet.pab","text=\"[t.pab]\"")
		winset(u,"NPCsheet.pdb","text=\"[t.pdb]\"")
		winset(u,"NPCsheet.mab","text=\"[t.mab]\"")
		winset(u,"NPCsheet.mdb","text=\"[t.mdb]\"")
		winset(u,"NPCsheet.perks","cells=0x0")
		winset(u,"NPCsheet.abilities","cells=0x0")
		winset(u,"NPCsheet.weapons","cells=0x0")
		for(var/obj/perk/A in t.contents)
			if(A.ability==0)
				row++
				u<<output(A,"perks:1,[row]")
		for(var/obj/perk/B in t.contents)
			if(B.ability==1)
				row2++
				u<<output(B,"abilities:1,[row2]")
		for(var/obj/perk/D in t.contents)
			if(D.npcweapon==1)
				row3++
				u<<output(D,"weapons:1,[row3]")
		for(var/obj/item/Weapon/F in t.contents)
			if(F.weapon==1)
				row3++
				u<<output(F,"weapons:1,[row3]")

//npcrefresh
	refreshnpcsheet(var/mob/u,var/obj/npc/t)
		u.npcsheet = t
		var/row
		var/row2
		var/row3
		winset(u,"NPCSheet.Nameplate","text=\"[t.name]\"")
		winset(u,"NPCSheet.str","text=\"[t.str]+[t.addstr]/[t.strmod]\"")
		winset(u,"NPCSheet.dex","text=\"[t.dex]+[t.adddex]/[t.dexmod]\"")
		winset(u,"NPCSheet.con","text=\"[t.con]+[t.addcon]/[t.conmod]\"")
		winset(u,"NPCSheet.int","text=\"[t.int]+[t.addint]/[t.intmod]\"")
		winset(u,"NPCSheet.wis","text=\"[t.wis]+[t.addwis]/[t.wismod]\"")
		winset(u,"NPCSheet.cha","text=\"[t.cha]+[t.addcha]/[t.chamod]\"")
		winset(u,"NPCsheet.HP","text=\"[t.hp]/[t.mhp]\"")
		winset(u,"NPCsheet.MP","text=\"[t.mp]/[t.mmp]\"")
		winset(u,"NPCsheet.SP","text=\"[t.sp]/[t.msp]\"")
		winset(u,"NPCsheet.AC","text=\"[t.baseac]\"")
		winset(u,"NPCsheet.DR","text=\"[t.basedr]\"")
		winset(u,"NPCsheet.SPD","text=\"[t.speed]\"")
		winset(u,"NPCsheet.pab","text=\"[t.pab]\"")
		winset(u,"NPCsheet.pdb","text=\"[t.pdb]\"")
		winset(u,"NPCsheet.mab","text=\"[t.mab]\"")
		winset(u,"NPCsheet.mdb","text=\"[t.mdb]\"")
		winset(u,"NPCsheet.perks","cells=0x0")
		winset(u,"NPCsheet.abilities","cells=0x0")
		winset(u,"NPCsheet.weapons","cells=0x0")
		for(var/obj/perk/A in t.contents)
			if(A.ability==0)
				row++
				u<<output(A,"perks:1,[row]")
		for(var/obj/perk/B in t.contents)
			if(B.ability==1)
				row2++
				u<<output(B,"abilities:1,[row2]")
		for(var/obj/perk/D in t.contents)
			if(D.npcweapon==1)
				row3++
				u<<output(D,"weapons:1,[row3]")
		for(var/obj/item/Weapon/F in t.contents)
			if(F.weapon==1)
				row3++
				u<<output(F,"weapons:1,[row3]")

	RefreshNPC(var/mob/m)
		if(winget(m,"NPC","is-visible=true"))
			var/row
			winset(m,"NPC.npcview","cells=0x0")
			winset(usr,"NPC.maxc","text=\"[usr.Csummonslearned]/[usr.maxsummonsC]\"")
			winset(usr,"NPC.maxb","text=\"[usr.Bsummonslearned]/[usr.maxsummonsB]\"")
			winset(usr,"NPC.maxa","text=\"[usr.Asummonslearned]/[usr.maxsummonsA]\"")
			for(var/obj/npc/n in m.contents)
				row++
				m << output(n,"npcview:1,[row]")

	Ncheckmod(var/obj/npc/o)
		o.strmod = round((o.str + o.addstr) / 2) - 5
		o.dexmod = round((o.dex + o.adddex) / 2) - 5
		o.conmod = round((o.con + o.addcon) / 2) - 5
		o.intmod = round((o.int + o.addint) / 2) - 5
		o.wismod = round((o.wis + o.addwis) / 2) - 5
		o.chamod = round((o.cha + o.addcha) / 2) - 5

	NSkillcheck(var/obj/npc/m)
		m.acrobatics=m.baseacro+m.dexmod
		m.athletics=m.baseath+m.strmod
		m.archaeology=m.basearc+m.intmod
		m.deception=m.basedec+m.chamod
		m.dungeoneering=m.basedung+m.intmod
		m.enchantment=m.baseenchant+m.intmod
		m.insight=m.basein+m.wismod
		m.investigation=m.baseinv+m.intmod
		m.magic=m.basemagic+m.wismod
		m.magitekOperation=m.basemagio+m.wismod
		m.medicine=m.basemed+m.intmod
		m.naturalist=m.basenat+m.chamod
		m.perception=m.baseper+m.wismod
		m.persuasion=m.basepers+m.chamod
		m.stealth=m.basestl+m.dexmod
		m.thievery=m.basethv+m.dexmod
		m.survival=m.basesurv+m.wismod


mob
	verb
		Opennpc()
			var/row
			winset(usr,"NPC","is-visible=true")
			winset(usr,"NPC.npcview","cells=0x0")
			winset(usr,"NPC.maxc","text=\"[usr.Csummonslearned]/[usr.maxsummonsC]\"")
			winset(usr,"NPC.maxb","text=\"[usr.Bsummonslearned]/[usr.maxsummonsB]\"")
			winset(usr,"NPC.maxa","text=\"[usr.Asummonslearned]/[usr.maxsummonsA]\"")
			for(var/obj/npc/n in usr.contents)
				row++
				src << output(n,"npcview:1,[row]")
		Submitchanges()
			var/obj/npc/n = usr.npcsheet
			if(winget(src,"EditNPC.hp","text"))
				n.mhp=text2num(winget(src,"EditNPC.hp","text"))
				n.hp=text2num(winget(src,"EditNPC.hp","text"))
				winset(usr,"EditNPC.hpdisplay","text=\"[n.mhp]\"")
			if(winget(src,"EditNPC.sp","text"))
				n.msp=text2num(winget(src,"EditNPC.sp","text"))
				n.sp=text2num(winget(src,"EditNPC.sp","text"))
				winset(usr,"EditNPC.spdisplay","text=\"[n.msp]\"")
			if(winget(src,"EditNPC.mp","text"))
				n.mmp=text2num(winget(src,"EditNPC.mp","text"))
				winset(usr,"EditNPC.mpdisplay","text=\"[n.mmp]\"")
			if(winget(src,"EditNPC.mp","text"))
				n.mp=text2num(winget(src,"EditNPC.mp","text"))
				winset(usr,"EditNPC.mpdisplay","text=\"[n.mmp]\"")
			if(winget(src,"EditNPC.pab","text"))
				n.pab=text2num(winget(src,"EditNPC.pab","text"))
				winset(usr,"EditNPC.pabdisplay","text=\"[n.pab]\"")
			if(winget(src,"EditNPC.mab","text"))
				n.mab=text2num(winget(src,"EditNPC.mab","text"))
				winset(usr,"EditNPC.mabdisplay","text=\"[n.mab]\"")
			if(winget(src,"EditNPC.pdb","text"))
				n.pdb=text2num(winget(src,"EditNPC.pdb","text"))
				winset(usr,"EditNPC.pdbdisplay","text=\"[n.pdb]\"")
			if(winget(src,"EditNPC.mdb","text"))
				n.mdb=text2num(winget(src,"EditNPC.mdb","text"))
				winset(usr,"EditNPC.mdbdisplay","text=\"[n.mdb]\"")
			if(winget(src,"EditNPC.str","text"))
				n.str=text2num(winget(src,"EditNPC.str","text"))
				winset(usr,"EditNPC.strdisplay","text=\"[n.str]\"")
			if(winget(src,"EditNPC.dex","text"))
				n.dex=text2num(winget(src,"EditNPC.dex","text"))
				winset(usr,"EditNPC.dexdisplay","text=\"[n.dex]\"")
			if(winget(src,"EditNPC.ac","text"))
				n.baseac=text2num(winget(src,"EditNPC.ac","text"))
				winset(usr,"EditNPC.acdisplay","text=\"[n.baseac]\"")
			if(winget(src,"EditNPC.con","text"))
				n.con=text2num(winget(src,"EditNPC.con","text"))
				winset(usr,"EditNPC.condisplay","text=\"[n.con]\"")
			if(winget(src,"EditNPC.int","text"))
				n.int=text2num(winget(src,"EditNPC.int","text"))
				winset(usr,"EditNPC.intdisplay","text=\"[n.int]\"")
			if(winget(src,"EditNPC.wis","text"))
				n.wis=text2num(winget(src,"EditNPC.wis","text"))
				winset(usr,"EditNPC.wisdisplay","text=\"[n.wis]\"")
			if(winget(src,"EditNPC.cha","text"))
				n.cha=text2num(winget(src,"EditNPC.cha","text"))
				winset(usr,"EditNPC.chadisplay","text=\"[n.cha]\"")
			if(winget(src,"EditNPC.rflx","text"))
				n.rflx=text2num(winget(src,"EditNPC.rflx","text"))
				winset(usr,"EditNPC.rflxdisplay","text=\"[n.rflx]\"")
			if(winget(src,"EditNPC.fort","text"))
				n.fort=text2num(winget(src,"EditNPC.fort","text"))
				winset(usr,"EditNPC.fortdisplay","text=\"[n.fort]\"")
			if(winget(src,"EditNPC.will","text"))
				n.will=text2num(winget(src,"EditNPC.will","text"))
				winset(usr,"EditNPC.willdisplay","text=\"[n.will]\"")
			if(winget(src,"EditNPC.acro","text"))
				n.baseacro=text2num(winget(src,"EditNPC.acro","text"))
				winset(usr,"EditNPC.acrodisplay","text=\"[n.baseacro]\"")
			if(winget(src,"EditNPC.ath","text"))
				n.baseath=text2num(winget(src,"EditNPC.ath","text"))
				winset(usr,"EditNPC.athdisplay","text=\"[n.baseath]\"")
			if(winget(src,"EditNPC.arc","text"))
				n.basearc=text2num(winget(src,"EditNPC.arc","text"))
				winset(usr,"EditNPC.arcdisplay","text=\"[n.basearc]\"")
			if(winget(src,"EditNPC.dec","text"))
				n.basedec=text2num(winget(src,"EditNPC.dec","text"))
				winset(usr,"EditNPC.decdisplay","text=\"[n.basedec]\"")
			if(winget(src,"EditNPC.dung","text"))
				n.basedung=text2num(winget(src,"EditNPC.dung","text"))
				winset(usr,"EditNPC.dungdisplay","text=\"[n.basedung]\"")
			if(winget(src,"EditNPC.enc","text"))
				n.baseenchant=text2num(winget(src,"EditNPC.enc","text"))
				winset(usr,"EditNPC.encdisplay","text=\"[n.baseenchant]\"")
			if(winget(src,"EditNPC.ins","text"))
				n.basein=text2num(winget(src,"EditNPC.ins","text"))
				winset(usr,"EditNPC.insdisplay","text=\"[n.basein]\"")
			if(winget(src,"EditNPC.inv","text"))
				n.baseinv=text2num(winget(src,"EditNPC.inv","text"))
				winset(usr,"EditNPC.invdisplay","text=\"[n.baseinv]\"")
			if(winget(src,"EditNPC.mag","text"))
				n.basemagic=text2num(winget(src,"EditNPC.mag","text"))
				winset(usr,"EditNPC.magdisplay","text=\"[n.basemagic]\"")
			if(winget(src,"EditNPC.magi","text"))
				n.basemagio=text2num(winget(src,"EditNPC.magi","text"))
				winset(usr,"EditNPC.magidisplay","text=\"[n.basemagio]\"")
			if(winget(src,"EditNPC.med","text"))
				n.basemed=text2num(winget(src,"EditNPC.med","text"))
				winset(usr,"EditNPC.meddisplay","text=\"[n.basemed]\"")
			if(winget(src,"EditNPC.nat","text"))
				n.basenat=text2num(winget(src,"EditNPC.nat","text"))
				winset(usr,"EditNPC.natdisplay","text=\"[n.basenat]\"")
			if(winget(src,"EditNPC.per","text"))
				n.baseper=text2num(winget(src,"EditNPC.per","text"))
				winset(usr,"EditNPC.perdisplay","text=\"[n.baseper]\"")
			if(winget(src,"EditNPC.pers","text"))
				n.basepers=text2num(winget(src,"EditNPC.pers","text"))
				winset(usr,"EditNPC.persdisplay","text=\"[n.basepers]\"")
			if(winget(src,"EditNPC.sth","text"))
				n.basestl=text2num(winget(src,"EditNPC.sth","text"))
				winset(usr,"EditNPC.sthdisplay","text=\"[n.basestl]\"")
			if(winget(src,"EditNPC.thv","text"))
				n.basethv=text2num(winget(src,"EditNPC.thv","text"))
				winset(usr,"EditNPC.thvdisplay","text=\"[n.basethv]\"")
			if(winget(src,"EditNPC.sur","text"))
				n.basesurv=text2num(winget(src,"EditNPC.sur","text"))
				winset(usr,"EditNPC.surdisplay","text=\"[n.basesurv]\"")
			Ncheckmod(n)
			NSkillcheck(n)


		CloseArchive()
			usr.npcachoice = null
			winset(usr,"NPCarchive.hp","text=\"\"")
			winset(usr,"NPCarchive.mp","text=\"\"")
			winset(usr,"NPCarchive.sp","text=\"\"")
			winset(usr,"NPCarchive.str","text=\"\"")
			winset(usr,"NPCarchive.dex","text=\"\"")
			winset(usr,"NPCarchive.con","text=\"\"")
			winset(usr,"NPCarchive.int","text=\"\"")
			winset(usr,"NPCarchive.wis","text=\"\"")
			winset(usr,"NPCarchive.cha","text=\"\"")
			winset(usr,"NPCarchive.rflx","text=\"\"")
			winset(usr,"NPCarchive.fort","text=\"\"")
			winset(usr,"NPCarchive.will","text=\"\"")
			winset(usr,"NPCarchive.ac","text=\"\"")
			winset(usr,"NPCarchive.dr","text=\"\"")
			winset(usr,"NPCarchive.spd","text=\"\"")
			winset(usr,"NPCarchive.acro","text=\"\"")
			winset(usr,"NPCarchive.ath","text=\"\"")
			winset(usr,"NPCarchive.arc","text=\"\"")
			winset(usr,"NPCarchive.dec","text=\"\"")
			winset(usr,"NPCarchive.dung","text=\"\"")
			winset(usr,"NPCarchive.enc","text=\"\"")
			winset(usr,"NPCarchive.ins","text=\"\"")
			winset(usr,"NPCarchive.inv","text=\"\"")
			winset(usr,"NPCarchive.mag","text=\"\"")
			winset(usr,"NPCarchive.magi","text=\"\"")
			winset(usr,"NPCarchive.med","text=\"\"")
			winset(usr,"NPCarchive.nat","text=\"\"")
			winset(usr,"NPCarchive.per","text=\"\"")
			winset(usr,"NPCarchive.pers","text=\"\"")
			winset(usr,"NPCarchive.sth","text=\"\"")
			winset(usr,"NPCarchive.sur","text=\"\"")
			winset(usr,"NPCarchive.thv","text=\"\"")
			winset(usr,"NPCarchive.overp","image=")
		DownloadArchive()
			if(usr.npcamount>=npclimit)
				alert("You have already reached your limit on NPCs")
				return
			else
				var/obj/npc/n = copyatom(usr.npcachoice)
				if(n.companiontype=="Monsters")
					InitializeEnemy(n)
				n.archived=0
				usr.contents+=n
				usr.send_chat("[n.name] has been added to your NPC list.","oocout")
				RefreshNPC(usr)
		Addperknpc()
			if(usr.eventmin||usr.tempeventmin||usr.adminlv>0)
				var/obj/npc/n = usr.npcsheet
				var/ap = input("What perk do you wish to give the NPC?") as null|anything in perklist
				var/p = copyatom(ap)
				n.contents+=p
		Addwepnpc()
			if(usr.eventmin||usr.tempeventmin||usr.adminlv>0)
				var/obj/npc/n = usr.npcsheet
				var/az = input("What weapon do you wish to give the NPC?") as null|anything in weplist
				var/qw = copyatom(az)
				n.contents+=qw
		Viewnpcperks()
			var/npcperks
			var/obj/npc/n = usr.npcachoice
			for(var/obj/perk/p in n.contents)
				npcperks+= ", [p.name]"
			alert("[n.name] has the following perks:[npcperks]")
		Recallall()
			for(var/obj/npc/n in world)
				if(n.owner==usr.key)
					if(!n.inarchive)
						usr.contents+=n
						n.overlays=null
						n.Savable=0
			RefreshNPC(usr)
		AddNpc()
			if(usr.eventmin||usr.tempeventmin||usr.adminlv>0)
				var/obj/npc/n = new /obj/npc
				n.name=input("What is the NPC's name?")as text
				n.icon=input("What is the NPC's icon?")as icon
				usr.contents+=n
				RefreshNPC(usr)
				return
			else
				if(usr.npcamount >= usr.npclimit)
					alert("You are at your limit for NPC's")
					return
				else
					var/obj/npc/n = new /obj/npc
					usr.contents+=n
					RefreshNPC(usr)

//Monster / Summon attacks & abilities
obj
	item
		Weapon
			NPCWeapons
				icon='Icons/Perk/GeneralWeapon.png'
				Ewer
					name="Famfrit's Ewer"
					desc="A Ewer attached to a chain."
					icon='Icons/Items/Ewer.png'
					range1=20
					range2=40
					adddam=5
					addhit=3
					damsource="str"
					range=" 5 tiles, Melee."
				SnakeFang
					name="Snake Fang"
					desc="A mighty Snake's fang."
					range1=5
					range2=20
					adddam=2
					addhit=5
					damsource="dex"
					range="Melee"
				SlugSlam
					name="Slug Slam"
					desc="A Slug's body is its weapon."
					range1=5
					range2=20
					adddam=1
					addhit=3
					damsource="str"
					range="Melee"
				GamaRyuKen
					damsource="str"
					name="Gama Ryu Ken"
					desc="Toad Style Martial Arts! Very effective."
					range1=5
					range2=20
					adddam=0
					addhit=6
					range="Melee"
				Branch
					damsource="wis"
					name="Sharp Branch"
					desc="A sharp branch, wielded by a Spirited Tree!"
					range1=8
					range2=20
					adddam=2
					addhit=2
					range="Melee"
				Bite
					damsource="str"
					name="Bite"
					desc="A biting attack!"
					range1=10
					range2=25
					adddam=0
					addhit=1
					range="Melee"
				Claw
					damsource="dex"
					name="Claw"
					desc="A Claw attack!"
					range1=10
					range2=24
					adddam=1
					addhit=2
					range="Melee"
				Punch
					damsource="dex"
					name="Punch"
					desc="A Martial Arts attack!"
					range1=10
					range2=24
					adddam=1
					addhit=2
					range="Melee"
				Staff
					damsource="wis"
					name="Staff"
					desc="A magical staff."
					range1=5
					range2=15
					addhit=5
					range=" 5 tiles."
					adddam=2
					typing="magical"
				Harp
					damsource="wis"
					name="Harp"
					desc="A magical harp."
					range1=5
					range2=10
					addhit=3
					range=" 5 tiles."
					adddam=2
					typing="magical"
				Horn
					damsource="str"
					name="Horn"
					desc="A vestigial Horn attack!"
					range1=10
					range2=24
					adddam=1
					addhit=2
					range="Melee"
				RazorFeather
					damsource="dex"
					name="Razor Feather"
					desc="A sharp Feather attack!"
					range1=12
					range2=24
					adddam=1
					addhit=2
					range="Melee"
				Ram
					damsource="con"
					name="Ram"
					desc="A body slam attack!"
					range1=20
					range2=28
					adddam=5
					addhit=1
					range="Melee"
				BoneClub
					damsource="str"
					name="Bone Club"
					desc="A huge bone club!"
					range1=35
					range2=75
					adddam=5
					addhit=3
					range="Melee"
obj
	perk
		MonsterAttacks
			icon='Icons/Perk/MonsterAbility.png'
			ability=1
			Claw
				desc="A basic Claw attack (2d6+STR damage)."
				rank="E"
				rpcost=3
				technique=1
				level=2
				mcost=5
				attack_roll_damage_dice = TRUE
				attack_roll_dice_count = 2
				attack_roll_damage_upper = 6
				adddam=0
				addhit=0
				basecheck=10
				damsource="str"
				range="Melee"
				atype="standard"
				costtype="Stamina"

obj
	perk
		NPCWeapons
			npcweapon=1
			Click()
				for(var/obj/npc/z in world)
					if(src in z.contents)
						var/aoresult
						var/aresult
						var/amod
						var/doresult
						var/dmod
						var/dresult
						var/critdam
						aoresult=rand(1,20)
						amod=Checkdamtype(src.damsource,z)
						if(src.typing=="magical")
							aresult=aoresult+src.addhit+amod+usr.rankbonus+z.mab
						else
							aresult=aoresult+src.addhit+amod+usr.rankbonus+z.pab
						doresult=raw_attack_damage_roll()
						dmod=Checkdamtype(src.damsource,usr)
						if(src.typing=="magical")
							dresult=doresult+dmod+src.adddam+z.mdb
						else
							dresult=doresult+dmod+src.adddam+z.pdb
						critdam=dresult+doresult
						if(aoresult==20)
							usr.visible_message("<font size=1><font color=[usr.textcolor]>[z] <font color=white>rolled a <b><font color=#3CF82C>CRITICAL</b> <font color=white>attack roll, using their <font color=[usr.textcolor]>[src.name]<font color=white>! Result: <font color=#3CF82C><b>[aresult] to hit</b><font color=white>, dealing <b><font color=#FFA852>[critdam] damage</b><font color=white>, as an automatic hit!", stream = "icout")
						else
							usr.visible_message("<font size=1><font color=[usr.textcolor]>[z] <font color=white>rolled an attack roll, using their <font color=[usr.textcolor]>[src.name]<font color=white>!  Result: <font color=#8EF5DE><b>[aresult] to hit</b><font color=white>, dealing <b><font color=#FFA852>[dresult] damage</b><font color=white> if successful!<br>Tile Range:[src.range]","output1")
							usr.visible_message("<font size=1><font color=[usr.textcolor]>[z] <font color=white>rolled an attack roll, using their <font color=[usr.textcolor]>[src.name]<font color=white>! Result: <font color=#8EF5DE><b>[aresult] to hit</b><font color=white>, dealing <b><font color=#FFA852>[dresult] damage</b><font color=white> if successful!<br>Tile Range:[src.range]", stream = "icout")

			Punch
				desc="A basic punch."
				rank="Weapon"
				rpcost=3
				technique=1
				level=2
				mcost=0
				attack_roll_damage_dice = TRUE
				attack_roll_dice_count = 1
				attack_roll_damage_upper = 8
				adddam=0
				addhit=0
				basecheck=10
				damsource="str"
				range="Melee"
				atype="standard"
				costtype="Stamina"
				npcweapon=1
			Ninja
				GamaRyuKen
				name="Gama Ryu Ken"
				rank="Weapon"
				technique=1
				level=2
				mcost=0
				attack_roll_damage_dice = TRUE
				attack_roll_dice_count = 2
				attack_roll_damage_upper = 15
				adddam=0
				addhit=2
				damsource="Str"
				range="Melee"
				atype="standard"
				costtype="Stamina"
				npcweapon=1


