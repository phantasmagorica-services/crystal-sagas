atom
	var
		statusturns
		status1
		status2
		status3
		status2turns
		status3turns
		totalstatus
		infusion1
		infusion2
		infusion1turns
		infusion2turns
		positivestatus1
		positivestatus2
		positivestatus3
		positiveturns1
		positiveturns2
		positiveturns3
		stoneskindam

atom
	proc
		Summonattack(var/mob/user, var/obj/npc/target, var/obj/npc/summon)
			var/obj/prop/summonobject=new
			summonobject.name=summon.name
			summonobject.icon=summon.icon
			var/obj/prop/Target/attack=new
			var/obj/prop/Cast/Magic/cast=new
			var/summonbonus=round(summon.mhp*0.25)
			var/basedamage=rand(70,80)
			var/adddamage=summon.conmod+summon.strmod+summon.wismod+summon.chamod+summon.wismod+summon.intmod+summon.dexmod+summon.pab+summon.mab
			var/damage=basedamage+summonbonus+adddamage
			var/element=summon.resistance
			var/summonpositionx=target.x+3
			var/summoncost=round(summon.mhp*0.5)
			var/costtype="Mana"
			var/power=rand(1,20)
			var/tohit=power+adddamage+user.mab+summon.mab
			var/statuschance=rand(1,100)
			if(user.mp<summoncost)
				view(user)<<output("<b>[user]</b> has tried to Summon <b>[summon]</b> but has failed because they lack the MP, and so must rest!","icout")
				return
			else
				user.mp-=summoncost
				if(user.mp<=0)
					user.mp=0
			if(summon.companiontype=="Knight")
				summoncost=0
			if(summon.companiontype=="Mage")
				summoncost=0
			if(summon.companiontype=="Healer")
				summoncost=0
			if(summon.companiontype=="Blitzer")
				summoncost=0
			if(summon.companiontype=="Monster")
				summoncost=0
			if(summon.companiontype=="Robot")
				summoncost=0
			if(target.weakness==element)
				basedamage=round(basedamage*1.5)
			view(12,user) << sound('Audio/Soundeffects/Castmagic.wav',channel=3)
			if(element=="Fire")
				attack.icon='Icons/Animation/Attack/Fire.dmi'
			if(element=="Ice")
				attack.icon='Icons/Animation/Attack/Ice.dmi'
			if(element=="Water")
				attack.icon='Icons/Animation/Attack/Water.dmi'
			if(element=="Wind")
				attack.icon='Icons/Animation/Attack/Wind.dmi'
			if(element=="Nature")
				attack.icon='Icons/Animation/Attack/Nature.dmi'
			if(element=="Bio")
				attack.icon='Icons/Animation/Attack/Bio.dmi'
			if(element=="Metal")
				attack.icon='Icons/Animation/Attack/Metal.dmi'
			if(element=="Earth")
				attack.icon='Icons/Animation/Attack/Earth.dmi'
			if(element=="Drain")
				attack.icon='Icons/Animation/Attack/Drain.dmi'
			if(element=="Dark")
				attack.icon='Icons/Animation/Attack/Dark.dmi'
			if(element=="Holy")
				attack.icon='Icons/Animation/Attack/Holy.dmi'
			if(element=="Thunder")
				attack.icon='Icons/Animation/Attack/Thunder.dmi'
			if(element=="Physical")
				attack.icon='Icons/Animation/Attack/Physical.dmi'
			if(element=="General")
				attack.icon='Icons/Animation/Attack/Magic.dmi'
			if(element=="Flare")
				attack.icon='Icons/Animation/Attack/Flare.dmi'
			if(element=="Comet")
				attack.icon='Icons/Animation/Attack/Comet.dmi'
			if(element=="Ultima")
				attack.icon='Icons/Animation/Attack/Ultima.dmi'
			if(element=="Time")
				attack.icon='Icons/Animation/Attack/Time.dmi'
			if(element=="Death")
				attack.icon='Icons/Animation/Attack/Dark.dmi'
			if(summon.companiontype=="Summon")
				summonobject.x=summonpositionx
				summonobject.y=target.y
				summonobject.z=target.z
				sleep(5)
				cast.x=summonobject.x
				cast.y=summonobject.y
				cast.z=summonobject.z
				sleep(8)
				del cast
				view(12,user) << sound('Audio/Soundeffects/General.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(10)
			if(summon.companiontype=="Monster")
				summonobject.x=summonpositionx
				summonobject.y=target.y
				summonobject.z=target.z
				sleep(5)
				cast.x=summonobject.x
				cast.y=summonobject.y
				cast.z=summonobject.z
				sleep(8)
				del cast
				view(12,user) << sound('Audio/Soundeffects/Dark.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(10)
			if(summon.companiontype=="Robot")
				attack.icon='Icons/Animation/Attack/Laser.dmi'
				summonobject.x=summonpositionx
				summonobject.y=target.y
				summonobject.z=target.z
				sleep(5)
				cast.x=summonobject.x
				cast.y=summonobject.y
				cast.z=summonobject.z
				sleep(8)
				del cast
				view(12,user) << sound('Audio/Soundeffects/Laser.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(10)
			if(summon.companiontype=="Blitzer")
				attack.icon='Icons/Animation/Attack/Physical.dmi'
				summonobject.x=summonpositionx
				summonobject.y=target.y
				summonobject.z=target.z
				sleep(5)
				cast.x=summonobject.x
				cast.y=summonobject.y
				cast.z=summonobject.z
				sleep(8)
				del cast
				view(12,user) << sound('Audio/Soundeffects/Physical.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(10)
			if(summon.companiontype=="Knight")
				attack.icon='Icons/Animation/Attack/Physical.dmi'
				summonobject.x=summonpositionx
				summonobject.y=target.y
				summonobject.z=target.z
				sleep(5)
				cast.x=summonobject.x
				cast.y=summonobject.y
				cast.z=summonobject.z
				sleep(8)
				del cast
				view(12,user) << sound('Audio/Soundeffects/Physical.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(10)
			if(summon.companiontype=="Mage")
				element="Fire"
				attack.icon='Icons/Animation/Attack/Fire.dmi'
				summonobject.x=summonpositionx
				summonobject.y=target.y
				summonobject.z=target.z
				sleep(5)
				cast.x=summonobject.x
				cast.y=summonobject.y
				cast.z=summonobject.z
				sleep(8)
				del cast
				view(12,user) << sound('Audio/Soundeffects/Fire.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(10)
			if(summon.companiontype=="Healer")
				element="Holy"
				attack.icon='Icons/Animation/Attack/Holy.dmi'
				summonobject.x=summonpositionx
				summonobject.y=target.y
				summonobject.z=target.z
				sleep(5)
				cast.x=summonobject.x
				cast.y=summonobject.y
				cast.z=summonobject.z
				sleep(8)
				del cast
				view(12,user) << sound('Audio/Soundeffects/Holy.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(10)
			if(element==null)
				element="General"
			del attack
			del summonobject
			view(user)<<output("To hit: <b><font color=[user.textcolor]>[tohit]</b> versus <b>[target.baseac]</b> AC <b>([target.name])</b>","icout")
			if(tohit>=target.baseac)
				view(user)<<output("<b><font color=[user.textcolor]>[user]</b> has spent <b>[summoncost] [costtype]</b> to summon forth the power of <font color=[user.textcolor]><b>[summon] ; with <b>[tohit] to hit</b> versus <b>[target.baseac] AC</b>, dealing <font color=#FA6815><b>[damage]</font> <b>[element]</b> damage to <b>[target]</b>!</b>!!</font>","icout")
				target.hp-=damage
			if(tohit<target.baseac)
				view(user)<<output("<b><font color=[user.textcolor]>[user]</b> has spent <b>[summoncost] [costtype]</b> to summon forth the power of <font color=[user.textcolor]><b>[summon] ; but has missed, with a <b>[tohit]</b> to hit, against an AC of <b>[target.baseac]</b>.","icout")
			if(element=="Time")
				if(statuschance>=70)
					AddStun(target)
				if(statuschance>=10)
					AddSlow(target)
			if(element=="Earth")
				if(statuschance>=90)
					AddStun(target)
				if(statuschance>=50)
					AddHeavy(target)
			if(element=="Metal")
				if(statuschance>=40)
					AddBleed(target)
			if(element=="Fire")
				if(statuschance>=70)
					AddBurn(target)
			if(element=="Nature")
				if(statuschance>=50)
					AddWeakness(target)
				if(statuschance>=80)
					AddPoison(target)
			if(element=="Bio")
				if(statuschance>=60)
					AddPoison(target)
			if(element=="Dark")
				if(statuschance>=70)
					AddBleed(target)
				if(statuschance>=20)
					AddWeakness(target)
			if(element=="Water")
				if(statuschance>=20)
					AddWet(target)
			if(element=="Wind")
				if(statuschance>=50)
					AddSquall(target)
			if(element=="Ice")
				if(statuschance>=50)
					AddFrostbite(target)
			if(element=="Thunder")
				if(statuschance>=50)
					AddWeakness(target)
				if(statuschance>=95)
					AddStun(target)
			ShowHPBar(target)
			ShowMPBar(target)
			ShowSPBar(target)
			if(target.hp<=0)
				Death(target)
				sleep(4)
				target.hp=0
				view(user)<<output("<b>[target]</b> has been reduced to 0 HP, and is removed from battle!!!","icout")
				target.icon=null
atom
	proc
		Revive(var/mob/user, var/mob/target, var/obj/perk/spell)
			var/healbonus
			var/casterbonus=round(user.chamod*5)
			if(spell.level==1)
				healbonus=0
			if(spell.level==2)
				healbonus=0
			if(spell.level==3)
				healbonus=5
			if(spell.level==4)
				healbonus=15
			if(spell.level==5)
				healbonus=20
			if(spell.level==6)
				healbonus=40
			var/heal=casterbonus+healbonus
			Heal(target)
			target.hp=0
			target.hp+=heal
			view(user)<<output("<b><font color=[user.textcolor]>[user]</font> has revived <b><font color=[target.textcolor]>[target]</b></font> using <b>[spell]</b> at <b><font color=#83F779>[heal]</b></font> HP!","icout")
			ShowHPBar(target)
			ShowMPBar(target)
			ShowSPBar(target)

atom
	proc
		Greencheckenemy(var/obj/npc/user)
			var/regenammt=round(user.mhp*0.08)
			var/refreshammt=round(user.mmp*0.08)
			if(user.positivestatus1=="Regen" || user.positivestatus2=="Regen" || user.positivestatus3=="Regen")
				if(user.positivestatus1=="Regen")
					user<<output("<b>[user]</b> has <b>[user.statusturns] turns left of</b> <font color=##91F785>Regen! Regenerated <b><font color=#91F785>[regenammt]</b> HP.</font>","icout")
					user.positiveturns1-=1
					user.hp+=regenammt
				if(user.positivestatus2=="Regen")
					user<<output("<b>[user]</b> has <b>[user.status2turns] turns left of</b> <font color=##91F785>Regen! Regenerated <b><font color=#91F785>[regenammt]</b> HP.</font>","icout")
					user.positiveturns2-=1
					user.hp+=regenammt
				if(user.positivestatus3=="Regen")
					user<<output("<b>[user]</b> has <b>[user.status3turns] turns left of</b> <font color=##91F785>Regen! Regenerated <b><font color=#91F785>[regenammt]</b> HP.</font>","icout")
					user.positiveturns3-=1
					user.hp+=regenammt
			if(user.positivestatus1=="Refresh" || user.positivestatus2=="Regen" || user.positivestatus3=="Regen")
				if(user.positivestatus1=="Refresh")
					user<<output("<b>[user]</b> has <b>[user.statusturns] turns left of</b> <font color=##91F785>Refresh! Regenerated <b><font color=#85EBF7>[regenammt]</b> MP.</font>","icout")
					user.positiveturns1-=1
					user.mp+=refreshammt
					user.sp+=refreshammt
				if(user.positivestatus2=="Refresh")
					user<<output("<b>[user]</b> has <b>[user.status2turns] turns left of</b> <font color=##91F785>Refresh! Regenerated <b><font color=#85EBF7>[regenammt]</b> MP.</font>","icout")
					user.positiveturns2-=1
					user.mp+=refreshammt
					user.sp+=refreshammt
				if(user.positivestatus3=="Refresh")
					user<<output("<b>[user]</b> has <b>[user.status3turns] turns left of</b> <font color=##91F785>Refresh! Regenerated <b><font color=#85EBF7>[regenammt]</b> MP.</font>","icout")
					user.positiveturns3-=1
					user.mp+=refreshammt
					user.sp+=refreshammt
			if(user.hp>=user.mhp)
				user.hp=user.mhp
			if(user.mp>=user.mmp)
				user.mp=user.mmp
			if(user.sp>=user.msp)
				user.sp=user.msp
			if(user.positivestatus1=="Faith" || user.positivestatus2=="Faith" || user.positivestatus3=="Faith")
				if(user.positivestatus1=="Faith")
					user<<output("<b>[user]</b> has <b>[user.statusturns] turns left of</b> <font color=#91F785>Faith!</font>","icout")
					user.positiveturns1-=1
				if(user.positivestatus2=="Faith")
					user<<output("<b>[user]</b> has <b>[user.status2turns] turns left of</b> <font color=#91F785>Faith!</font>","icout")
					user.positiveturns2-=1
				if(user.positivestatus3=="Faith")
					user<<output("<b>[user]</b> has <b>[user.status3turns] turns left of</b> <font color=#91F785>Faith!</font>","icout")
			if(user.positivestatus1=="Bravery" || user.positivestatus2=="Bravery" || user.positivestatus3=="Bravery")
				if(user.positivestatus1=="Bravery")
					user<<output("<b>[user]</b> has <b>[user.statusturns] turns left of</b> <font color=#91F785>Bravery!</font>","icout")
					user.positiveturns1-=1
				if(user.positivestatus2=="Bravery")
					user<<output("<b>[user]</b> has <b>[user.status2turns] turns left of</b> <font color=#91F785>Bravery!</font>","icout")
					user.positiveturns2-=1
				if(user.positivestatus3=="Bravery")
					user<<output("<b>[user]</b> has <b>[user.status3turns] turns left of</b> <font color=#91F785>Bravery!</font>","icout")
			if(user.positivestatus1=="Haste" || user.positivestatus2=="Haste" || user.positivestatus3=="Haste")
				if(user.positivestatus1=="Haste")
					user<<output("<b>[user]</b> has <b>[user.statusturns] turns left of</b> <font color=#91F785>Haste!</font>","icout")
					user.positiveturns1-=1
				if(user.positivestatus2=="Haste")
					user<<output("<b>[user]</b> has <b>[user.status2turns] turns left of</b> <font color=#91F785>Haste!</font>","icout")
					user.positiveturns2-=1
				if(user.positivestatus3=="Haste")
					user<<output("<b>[user]</b> has <b>[user.status3turns] turns left of</b> <font color=#91F785>Haste!</font>","icout")
			if(user.positivestatus1=="Barfire" || user.positivestatus2=="Barfire" || user.positivestatus3=="Barfire")
				if(user.positivestatus1=="Barfire")
					user<<output("<b>[user]</b> has <b>[user.statusturns] turns left of</b> <font color=#91F785>Barfire!</font>","icout")
					user.positiveturns1-=1
				if(user.positivestatus2=="Barfire")
					user<<output("<b>[user]</b> has <b>[user.status2turns] turns left of</b> <font color=#91F785>Barfire!</font>","icout")
					user.positiveturns2-=1
				if(user.positivestatus3=="Barfire")
					user<<output("<b>[user]</b> has <b>[user.status3turns] turns left of</b> <font color=#91F785>Barfire!</font>","icout")
					user.positiveturns3-=1
			if(user.positivestatus1=="Barwater" || user.positivestatus2=="Barwater" || user.positivestatus3=="Barwater")
				if(user.positivestatus1=="Barwater")
					user<<output("<b>[user]</b> has <b>[user.statusturns] turns left of</b> <font color=#91F785>Barwater!</font>","icout")
					user.positiveturns1-=1
				if(user.positivestatus2=="Barwater")
					user<<output("<b>[user]</b> has <b>[user.status2turns] turns left of</b> <font color=#91F785>Barwater!</font>","icout")
					user.positiveturns2-=1
				if(user.positivestatus3=="Barwater")
					user<<output("<b>[user]</b> has <b>[user.status3turns] turns left of</b> <font color=#91F785>Barwater!</font>","icout")
					user.positiveturns3-=1
			if(user.positivestatus1=="Barthunder" || user.positivestatus2=="Barthunder" || user.positivestatus3=="Barthunder")
				if(user.positivestatus1=="Barthunder")
					user<<output("<b>[user]</b> has <b>[user.statusturns] turns left of</b> <font color=#91F785>Barthunder!</font>","icout")
					user.positiveturns1-=1
				if(user.positivestatus2=="Barthunder")
					user<<output("<b>[user]</b> has <b>[user.status2turns] turns left of</b> <font color=#91F785>Barthunder!</font>","icout")
					user.positiveturns2-=1
				if(user.positivestatus3=="Barthunder")
					user<<output("<b>[user]</b> has <b>[user.status3turns] turns left of</b> <font color=#91F785>Barthunder!</font>","icout")
					user.positiveturns3-=1
			if(user.positivestatus1=="Barstone" || user.positivestatus2=="Barstone" || user.positivestatus3=="Barstone")
				if(user.positivestatus1=="Barstone")
					user<<output("<b>[user]</b> has <b>[user.statusturns] turns left of</b> <font color=#91F785>Barstone!</font>","icout")
					user.positiveturns1-=1
				if(user.positivestatus2=="Barstone")
					user<<output("<b>[user]</b> has <b>[user.status2turns] turns left of</b> <font color=#91F785>Barstone!</font>","icout")
					user.positiveturns2-=1
				if(user.positivestatus3=="Barstone")
					user<<output("<b>[user]</b> has <b>[user.status3turns] turns left of</b> <font color=#91F785>Barstone!</font>","icout")
					user.positiveturns3-=1
			if(user.positivestatus1=="Barblizzard" || user.positivestatus2=="Barblizzard" || user.positivestatus3=="Barblizzard")
				if(user.positivestatus1=="Barblizzard")
					user<<output("<b>[user]</b> has <b>[user.statusturns] turns left of</b> <font color=#91F785>Barblizzard!</font>","icout")
					user.positiveturns1-=1
				if(user.positivestatus2=="Barblizzard")
					user<<output("<b>[user]</b> has <b>[user.status2turns] turns left of</b> <font color=#91F785>Barblizzard!</font>","icout")
					user.positiveturns2-=1
				if(user.positivestatus3=="Barblizzard")
					user<<output("<b>[user]</b> has <b>[user.status3turns] turns left of</b> <font color=#91F785>Barblizzard!</font>","icout")
					user.positiveturns3-=1
			if(user.positivestatus1=="Baraero" || user.positivestatus2=="Baraero" || user.positivestatus3=="Baraero")
				if(user.positivestatus1=="Baraero")
					user<<output("<b>[user]</b> has <b>[user.statusturns] turns left of</b> <font color=#91F785>Baraero!</font>","icout")
					user.positiveturns1-=1
				if(user.positivestatus2=="Baraero")
					user<<output("<b>[user]</b> has <b>[user.status2turns] turns left of</b> <font color=#91F785>Baraero!</font>","icout")
					user.positiveturns2-=1
				if(user.positivestatus3=="Baraero")
					user<<output("<b>[user]</b> has <b>[user.status3turns] turns left of</b> <font color=#91F785>Baraero!</font>","icout")
					user.positiveturns3-=1
			if(user.positivestatus1=="Pailing" || user.positivestatus2=="Pailing" || user.positivestatus3=="Pailing")
				if(user.positivestatus1=="Pailing")
					user<<output("<b>[user]</b> has <b>[user.statusturns] turns left of</b> <font color=#91F785>Pailing!</font>","icout")
					user.positiveturns1-=1
				if(user.positivestatus2=="Pailing")
					user<<output("<b>[user]</b> has <b>[user.status2turns] turns left of</b> <font color=#91F785>Pailing!</font>","icout")
					user.positiveturns2-=1
				if(user.positivestatus3=="Pailing")
					user<<output("<b>[user]</b> has <b>[user.status3turns] turns left of</b> <font color=#91F785>Pailing!</font>","icout")
					user.positiveturns3-=1
			if(user.positivestatus1=="Magic Barrer" || user.positivestatus2=="Magic Barrer" || user.positivestatus3=="Magic Barrer")
				if(user.positivestatus1=="Magic Barrer")
					user<<output("<b>[user]</b> has <b>[user.statusturns] turns left of</b> <font color=#91F785>Magic Barrer!</font>","icout")
					user.positiveturns1-=1
				if(user.positivestatus2=="Magic Barrer")
					user<<output("<b>[user]</b> has <b>[user.status2turns] turns left of</b> <font color=#91F785>Magic Barrer!</font>","icout")
					user.positiveturns2-=1
				if(user.positivestatus3=="Magic Barrer")
					user<<output("<b>[user]</b> has <b>[user.status3turns] turns left of</b> <font color=#91F785>Magic Barrer!</font>","icout")
					user.positiveturns3-=1
			if(user.positivestatus1=="Stoneskin" || user.positivestatus2=="Stoneskin" || user.positivestatus3=="Stoneskin")
				if(user.positivestatus1=="Stoneskin")
					user<<output("<b>[user]</b> has <b>[user.statusturns] turns left of</b> <font color=#91F785>Stoneskin!</font>","icout")
					user.positiveturns1-=1
				if(user.positivestatus2=="Stoneskin")
					user<<output("<b>[user]</b> has <b>[user.status2turns] turns left of</b> <font color=#91F785>Stoneskin!</font>","icout")
					user.positiveturns2-=1
				if(user.positivestatus3=="Stoneskin")
					user<<output("<b>[user]</b> has <b>[user.status3turns] turns left of</b> <font color=#91F785>Stoneskin!</font>","icout")
					user.positiveturns3-=1
			if(user.positivestatus1=="Protect" || user.positivestatus2=="Protect" || user.positivestatus3=="Protect")
				if(user.positivestatus1=="Protect")
					user<<output("<b>[user]</b> has <b>[user.statusturns] turns left of</b> <font color=#91F785>Protect!</font>","icout")
					user.positiveturns1-=1
				if(user.positivestatus2=="Protect")
					user<<output("<b>[user]</b> has <b>[user.status2turns] turns left of</b> <font color=#91F785>Protect!</font>","icout")
					user.positiveturns2-=1
				if(user.positivestatus3=="Protect")
					user<<output("<b>[user]</b> has <b>[user.status3turns] turns left of</b> <font color=#91F785>Protect!</font>","icout")
					user.positiveturns3-=1
			if(user.positivestatus1=="Shell" || user.positivestatus2=="Shell" || user.positivestatus3=="Shell")
				if(user.positivestatus1=="Shell")
					user<<output("<b>[user]</b> has <b>[user.statusturns] turns left of</b> <font color=#91F785>Shell!</font>","icout")
					user.positiveturns1-=1
				if(user.positivestatus2=="Shell")
					user<<output("<b>[user]</b> has <b>[user.status2turns] turns left of</b> <font color=#91F785>Shell!</font>","icout")
					user.positiveturns2-=1
				if(user.positivestatus3=="Shell")
					user<<output("<b>[user]</b> has <b>[user.status3turns] turns left of</b> <font color=#91F785>Shell!</font>","icout")
					user.positiveturns3-=1
			if(user.positiveturns1<=0)
				user.positivestatus1=null
				user.positiveturns1-=1
			if(user.positiveturns2<=0)
				user.positivestatus2=null
				user.positiveturns2-=1
			if(user.positiveturns3<=0)
				user.positivestatus3=null
				user.positiveturns3-=1
				sleep(4)
			ShowHPBar(user)
			ShowMPBar(user)
			ShowSPBar(user)
		Greencheckplayer(var/mob/user)
			var/regenammt=round(user.mhp*0.08)
			var/refreshammt=round(user.mmp*0.08)
			if(user.positivestatus1=="Regen" || user.positivestatus2=="Regen" || user.positivestatus3=="Regen")
				if(user.positivestatus1=="Regen")
					user<<output("<b>[user]</b> has <b>[user.statusturns] turns left of</b> <font color=##91F785>Regen! Regenerated <b><font color=#91F785>[regenammt]</b> HP.</font>","icout")
					user.positiveturns1-=1
					user.hp+=regenammt
				if(user.positivestatus2=="Regen")
					user<<output("<b>[user]</b> has <b>[user.status2turns] turns left of</b> <font color=##91F785>Regen! Regenerated <b><font color=#91F785>[regenammt]</b> HP.</font>","icout")
					user.positiveturns2-=1
					user.hp+=regenammt
				if(user.positivestatus3=="Regen")
					user<<output("<b>[user]</b> has <b>[user.status3turns] turns left of</b> <font color=##91F785>Regen! Regenerated <b><font color=#91F785>[regenammt]</b> HP.</font>","icout")
					user.positiveturns3-=1
					user.hp+=regenammt
			if(user.positivestatus1=="Refresh" || user.positivestatus2=="Regen" || user.positivestatus3=="Regen")
				if(user.positivestatus1=="Refresh")
					user<<output("<b>[user]</b> has <b>[user.statusturns] turns left of</b> <font color=##91F785>Refresh! Regenerated <b><font color=#85EBF7>[regenammt]</b> MP.</font>","icout")
					user.positiveturns1-=1
					user.mp+=refreshammt
					user.sp+=refreshammt
				if(user.positivestatus2=="Refresh")
					user<<output("<b>[user]</b> has <b>[user.status2turns] turns left of</b> <font color=##91F785>Refresh! Regenerated <b><font color=#85EBF7>[regenammt]</b> MP.</font>","icout")
					user.positiveturns2-=1
					user.mp+=refreshammt
					user.sp+=refreshammt
				if(user.positivestatus3=="Refresh")
					user<<output("<b>[user]</b> has <b>[user.status3turns] turns left of</b> <font color=##91F785>Refresh! Regenerated <b><font color=#85EBF7>[regenammt]</b> MP.</font>","icout")
					user.positiveturns3-=1
					user.mp+=refreshammt
					user.sp+=refreshammt
			if(user.hp>=user.mhp)
				user.hp=user.mhp
			if(user.mp>=user.mmp)
				user.mp=user.mmp
			if(user.sp>=user.msp)
				user.sp=user.msp
			if(user.positivestatus1=="Faith" || user.positivestatus2=="Faith" || user.positivestatus3=="Faith")
				if(user.positivestatus1=="Faith")
					user<<output("<b>[user]</b> has <b>[user.statusturns] turns left of</b> <font color=#91F785>Faith!</font>","icout")
					user.positiveturns1-=1
				if(user.positivestatus2=="Faith")
					user<<output("<b>[user]</b> has <b>[user.status2turns] turns left of</b> <font color=#91F785>Faith!</font>","icout")
					user.positiveturns2-=1
				if(user.positivestatus3=="Faith")
					user<<output("<b>[user]</b> has <b>[user.status3turns] turns left of</b> <font color=#91F785>Faith!</font>","icout")
			if(user.positivestatus1=="Bravery" || user.positivestatus2=="Bravery" || user.positivestatus3=="Bravery")
				if(user.positivestatus1=="Bravery")
					user<<output("<b>[user]</b> has <b>[user.statusturns] turns left of</b> <font color=#91F785>Bravery!</font>","icout")
					user.positiveturns1-=1
				if(user.positivestatus2=="Bravery")
					user<<output("<b>[user]</b> has <b>[user.status2turns] turns left of</b> <font color=#91F785>Bravery!</font>","icout")
					user.positiveturns2-=1
				if(user.positivestatus3=="Bravery")
					user<<output("<b>[user]</b> has <b>[user.status3turns] turns left of</b> <font color=#91F785>Bravery!</font>","icout")
			if(user.positivestatus1=="Haste" || user.positivestatus2=="Haste" || user.positivestatus3=="Haste")
				if(user.positivestatus1=="Haste")
					user<<output("<b>[user]</b> has <b>[user.statusturns] turns left of</b> <font color=#91F785>Haste!</font>","icout")
					user.positiveturns1-=1
				if(user.positivestatus2=="Haste")
					user<<output("<b>[user]</b> has <b>[user.status2turns] turns left of</b> <font color=#91F785>Haste!</font>","icout")
					user.positiveturns2-=1
				if(user.positivestatus3=="Haste")
					user<<output("<b>[user]</b> has <b>[user.status3turns] turns left of</b> <font color=#91F785>Haste!</font>","icout")
			if(user.positivestatus1=="Barfire" || user.positivestatus2=="Barfire" || user.positivestatus3=="Barfire")
				if(user.positivestatus1=="Barfire")
					user<<output("<b>[user]</b> has <b>[user.statusturns] turns left of</b> <font color=#91F785>Barfire!</font>","icout")
					user.positiveturns1-=1
				if(user.positivestatus2=="Barfire")
					user<<output("<b>[user]</b> has <b>[user.status2turns] turns left of</b> <font color=#91F785>Barfire!</font>","icout")
					user.positiveturns2-=1
				if(user.positivestatus3=="Barfire")
					user<<output("<b>[user]</b> has <b>[user.status3turns] turns left of</b> <font color=#91F785>Barfire!</font>","icout")
					user.positiveturns3-=1
			if(user.positivestatus1=="Barwater" || user.positivestatus2=="Barwater" || user.positivestatus3=="Barwater")
				if(user.positivestatus1=="Barwater")
					user<<output("<b>[user]</b> has <b>[user.statusturns] turns left of</b> <font color=#91F785>Barwater!</font>","icout")
					user.positiveturns1-=1
				if(user.positivestatus2=="Barwater")
					user<<output("<b>[user]</b> has <b>[user.status2turns] turns left of</b> <font color=#91F785>Barwater!</font>","icout")
					user.positiveturns2-=1
				if(user.positivestatus3=="Barwater")
					user<<output("<b>[user]</b> has <b>[user.status3turns] turns left of</b> <font color=#91F785>Barwater!</font>","icout")
					user.positiveturns3-=1
			if(user.positivestatus1=="Barthunder" || user.positivestatus2=="Barthunder" || user.positivestatus3=="Barthunder")
				if(user.positivestatus1=="Barthunder")
					user<<output("<b>[user]</b> has <b>[user.statusturns] turns left of</b> <font color=#91F785>Barthunder!</font>","icout")
					user.positiveturns1-=1
				if(user.positivestatus2=="Barthunder")
					user<<output("<b>[user]</b> has <b>[user.status2turns] turns left of</b> <font color=#91F785>Barthunder!</font>","icout")
					user.positiveturns2-=1
				if(user.positivestatus3=="Barthunder")
					user<<output("<b>[user]</b> has <b>[user.status3turns] turns left of</b> <font color=#91F785>Barthunder!</font>","icout")
					user.positiveturns3-=1
			if(user.positivestatus1=="Barstone" || user.positivestatus2=="Barstone" || user.positivestatus3=="Barstone")
				if(user.positivestatus1=="Barstone")
					user<<output("<b>[user]</b> has <b>[user.statusturns] turns left of</b> <font color=#91F785>Barstone!</font>","icout")
					user.positiveturns1-=1
				if(user.positivestatus2=="Barstone")
					user<<output("<b>[user]</b> has <b>[user.status2turns] turns left of</b> <font color=#91F785>Barstone!</font>","icout")
					user.positiveturns2-=1
				if(user.positivestatus3=="Barstone")
					user<<output("<b>[user]</b> has <b>[user.status3turns] turns left of</b> <font color=#91F785>Barstone!</font>","icout")
					user.positiveturns3-=1
			if(user.positivestatus1=="Barblizzard" || user.positivestatus2=="Barblizzard" || user.positivestatus3=="Barblizzard")
				if(user.positivestatus1=="Barblizzard")
					user<<output("<b>[user]</b> has <b>[user.statusturns] turns left of</b> <font color=#91F785>Barblizzard!</font>","icout")
					user.positiveturns1-=1
				if(user.positivestatus2=="Barblizzard")
					user<<output("<b>[user]</b> has <b>[user.status2turns] turns left of</b> <font color=#91F785>Barblizzard!</font>","icout")
					user.positiveturns2-=1
				if(user.positivestatus3=="Barblizzard")
					user<<output("<b>[user]</b> has <b>[user.status3turns] turns left of</b> <font color=#91F785>Barblizzard!</font>","icout")
					user.positiveturns3-=1
			if(user.positivestatus1=="Baraero" || user.positivestatus2=="Baraero" || user.positivestatus3=="Baraero")
				if(user.positivestatus1=="Baraero")
					user<<output("<b>[user]</b> has <b>[user.statusturns] turns left of</b> <font color=#91F785>Baraero!</font>","icout")
					user.positiveturns1-=1
				if(user.positivestatus2=="Baraero")
					user<<output("<b>[user]</b> has <b>[user.status2turns] turns left of</b> <font color=#91F785>Baraero!</font>","icout")
					user.positiveturns2-=1
				if(user.positivestatus3=="Baraero")
					user<<output("<b>[user]</b> has <b>[user.status3turns] turns left of</b> <font color=#91F785>Baraero!</font>","icout")
					user.positiveturns3-=1
			if(user.positivestatus1=="Pailing" || user.positivestatus2=="Pailing" || user.positivestatus3=="Pailing")
				if(user.positivestatus1=="Pailing")
					user<<output("<b>[user]</b> has <b>[user.statusturns] turns left of</b> <font color=#91F785>Pailing!</font>","icout")
					user.positiveturns1-=1
				if(user.positivestatus2=="Pailing")
					user<<output("<b>[user]</b> has <b>[user.status2turns] turns left of</b> <font color=#91F785>Pailing!</font>","icout")
					user.positiveturns2-=1
				if(user.positivestatus3=="Pailing")
					user<<output("<b>[user]</b> has <b>[user.status3turns] turns left of</b> <font color=#91F785>Pailing!</font>","icout")
					user.positiveturns3-=1
			if(user.positivestatus1=="Magic Barrer" || user.positivestatus2=="Magic Barrer" || user.positivestatus3=="Magic Barrer")
				if(user.positivestatus1=="Magic Barrer")
					user<<output("<b>[user]</b> has <b>[user.statusturns] turns left of</b> <font color=#91F785>Magic Barrer!</font>","icout")
					user.positiveturns1-=1
				if(user.positivestatus2=="Magic Barrer")
					user<<output("<b>[user]</b> has <b>[user.status2turns] turns left of</b> <font color=#91F785>Magic Barrer!</font>","icout")
					user.positiveturns2-=1
				if(user.positivestatus3=="Magic Barrer")
					user<<output("<b>[user]</b> has <b>[user.status3turns] turns left of</b> <font color=#91F785>Magic Barrer!</font>","icout")
					user.positiveturns3-=1
			if(user.positivestatus1=="Stoneskin" || user.positivestatus2=="Stoneskin" || user.positivestatus3=="Stoneskin")
				if(user.positivestatus1=="Stoneskin")
					user<<output("<b>[user]</b> has <b>[user.statusturns] turns left of</b> <font color=#91F785>Stoneskin!</font>","icout")
					user.positiveturns1-=1
				if(user.positivestatus2=="Stoneskin")
					user<<output("<b>[user]</b> has <b>[user.status2turns] turns left of</b> <font color=#91F785>Stoneskin!</font>","icout")
					user.positiveturns2-=1
				if(user.positivestatus3=="Stoneskin")
					user<<output("<b>[user]</b> has <b>[user.status3turns] turns left of</b> <font color=#91F785>Stoneskin!</font>","icout")
					user.positiveturns3-=1
			if(user.positivestatus1=="Protect" || user.positivestatus2=="Protect" || user.positivestatus3=="Protect")
				if(user.positivestatus1=="Protect")
					user<<output("<b>[user]</b> has <b>[user.statusturns] turns left of</b> <font color=#91F785>Protect!</font>","icout")
					user.positiveturns1-=1
				if(user.positivestatus2=="Protect")
					user<<output("<b>[user]</b> has <b>[user.status2turns] turns left of</b> <font color=#91F785>Protect!</font>","icout")
					user.positiveturns2-=1
				if(user.positivestatus3=="Protect")
					user<<output("<b>[user]</b> has <b>[user.status3turns] turns left of</b> <font color=#91F785>Protect!</font>","icout")
					user.positiveturns3-=1
			if(user.positivestatus1=="Shell" || user.positivestatus2=="Shell" || user.positivestatus3=="Shell")
				if(user.positivestatus1=="Shell")
					user<<output("<b>[user]</b> has <b>[user.statusturns] turns left of</b> <font color=#91F785>Shell!</font>","icout")
					user.positiveturns1-=1
				if(user.positivestatus2=="Shell")
					user<<output("<b>[user]</b> has <b>[user.status2turns] turns left of</b> <font color=#91F785>Shell!</font>","icout")
					user.positiveturns2-=1
				if(user.positivestatus3=="Shell")
					user<<output("<b>[user]</b> has <b>[user.status3turns] turns left of</b> <font color=#91F785>Shell!</font>","icout")
					user.positiveturns3-=1
			if(user.positiveturns1<=0)
				user.positivestatus1=null
				user.positiveturns1-=1
			if(user.positiveturns2<=0)
				user.positivestatus2=null
				user.positiveturns2-=1
			if(user.positiveturns3<=0)
				user.positivestatus3=null
				user.positiveturns3-=1
			ShowHPBar(user)
			ShowMPBar(user)
			ShowSPBar(user)
			sleep(4)

atom
	proc
		EnemyGreen(var/obj/npc/user,var/obj/npc/target, var/obj/perk/ability)
			var/list/choices=list("Slot 1","Slot 2","Slot 3")
			var/chosenslot=pick(choices)
			GreenMagic(target)
			switch(chosenslot)
				if("Slot 1")
					if(target.positivestatus1==null)
						target.positivestatus1=ability.statuseffect
						target.positiveturns1=3
						view(user)<<output("<b>[user]</b> has applied <b><font color=#79EBEE>[ability.statuseffect]</font> to <b>[target]</b> as <b>Boon [chosenslot]</b>!!","icout")
				if("Slot 2")
					if(target.positivestatus2==null)
						target.positivestatus2=ability.statuseffect
						target.positiveturns2=3
						view(user)<<output("<b>[user]</b> has applied <b><font color=#79EBEE>[ability.statuseffect]</font> to <b>[target]</b> as <b>Boon [chosenslot]</b>!!","icout")
				if("Slot 3")
					if(target.positivestatus3==null)
						target.positivestatus3=ability.statuseffect
						target.positiveturns3=3
						view(user)<<output("<b>[user]</b> has applied <b><font color=#79EBEE>[ability.statuseffect]</font> to <b>[target]</b> as <b>Boon [chosenslot]</b>!!","icout")
		GreenMagicOne(var/mob/user,var/mob/target, var/obj/perk/ability)
			var/cost=ability.mcost
			if(ability.multi==1)
				cost=round(cost*0.4)
			var/list/choices=list("Slot 1","Slot 2","Slot 3")
			var/chosenslot=input(user, "Which Positive status slot would you like to apply this status effect to for [target]? It will overwrite any effect in that slot.") as anything in choices
			GreenMagic(target)
			switch(chosenslot)
				if("Slot 1")
					target.positivestatus1=ability.statuseffect
					target.positiveturns1=3
				if("Slot 2")
					target.positivestatus2=ability.statuseffect
					target.positiveturns2=3
				if("Slot 3")
					target.positivestatus3=ability.statuseffect
					target.positiveturns3=3
			view(user)<<output("<b>[user]</b> has applied <b><font color=#79EBEE>[ability.statuseffect]</font> to <b>[target]</b> as <b>Boon [chosenslot] | Cost: [cost] Mana</b>!!","icout")
atom
	proc
		DispelEnemy(var/obj/npc/user, var/mob/target, var/obj/perk/spell)
			var/list/slots=list()
			Dispel(target)
			if(spell.dispel==1)
				if(target.positivestatus1!=null)
					slots+=target.positivestatus1
				if(target.positivestatus2!=null)
					slots+=target.positivestatus2
				if(target.positivestatus3!=null)
					slots+=target.positivestatus3
				var/choice=pick(slots)
				if(choice==target.positivestatus1)
					view(target)<<output("<b>[user]</b> has <b><font color=#B3F8FA>dispelled</font><b>[target]</b>'s <b>[target.positivestatus1]</b> effect!","icout")
					target.positivestatus1=null
				if(choice==target.positivestatus2)
					view(target)<<output("<b>[user]</b> has <b><font color=#B3F8FA>dispelled</font><b>[target]</b>'s <b>[target.positivestatus2]</b> effect!","icout")
					target.positivestatus2=null
				if(choice==target.positivestatus3)
					view(target)<<output("<b>[user]</b> has <b><font color=#B3F8FA>dispelled</font><b>[target]</b>'s <b>[target.positivestatus3]</b> effect!","icout")
					target.positivestatus3=null
			if(spell.dispel==2)
				target.positivestatus1=null
				target.positivestatus2=null
				target.positivestatus3=null
				view(target)<<output("<b>[user]</b> has fully <b><font color=#B3F8FA>dispelled</font> <b>[target]</b>'s positive status effects!","icout")
atom
	proc
		DispelPlayer(var/mob/user, var/obj/npc/target, var/obj/perk/spell)
			if(spell.dispel==1)
				var/list/slots=list()
				if(target.positivestatus1!=null)
					slots+=target.positivestatus1
				if(target.positivestatus2!=null)
					slots+=target.positivestatus2
				if(target.positivestatus3!=null)
					slots+=target.positivestatus3
				var/choice=input(user,"Which effect would you like to dispel?") as anything in slots
				if(choice==target.positivestatus1)
					view(target)<<output("<b>[user]</b> has <b><font color=#B3F8FA>dispelled</font><b>[target]</b>'s <b>[target.positivestatus1]</b> effect!","icout")
					target.positivestatus1=null
				if(choice==target.positivestatus2)
					view(target)<<output("<b>[user]</b> has <b><font color=#B3F8FA>dispelled</font><b>[target]</b>'s <b>[target.positivestatus2]</b> effect!","icout")
					target.positivestatus2=null
				if(choice==target.positivestatus3)
					view(target)<<output("<b>[user]</b> has <b><font color=#B3F8FA>dispelled</font><b>[target]</b>'s <b>[target.positivestatus3]</b> effect!","icout")
					target.positivestatus3=null
				Dispel(target)
			if(spell.dispel==2)
				target.positivestatus1=null
				target.positivestatus2=null
				target.positivestatus3=null
				view(target)<<output("<b>[user]</b> has fully <b><font color=#B3F8FA>dispelled</font> <b>[target]</b>'s positive status effects!","icout")
				Dispel(target)
atom
	proc
		AddBurn(var/atom/target)
			if(target.positivestatus1=="Safe" || target.positivestatus2=="Safe" || target.positivestatus3=="Safe")
				if(target.positivestatus1=="Safe")
					positivestatus1=null
					view(target)<<output("<b>[target]'s Safe effect has prevented a status effect!</b>","icout")
					return
				if(target.positivestatus2=="Safe")
					positivestatus2=null
					view(target)<<output("<b>[target]'s Safe effect has prevented a status effect!</b>","icout")
					return
				if(target.positivestatus3=="Safe")
					positivestatus3=null
					view(target)<<output("<b>[target]'s Safe effect has prevented a status effect!</b>","icout")
					return
			if (target.status1==null || target.status2==null || target.status3==null)
				if(target.status1==null)
					if(target.status2 == "Burn" || target.status3 == "Burn")
						return
					else
						target.status1="Burn"
						target.statusturns=3
						view(target) <<output("<b>[target] has been afflicted with <b>Burn</b>!","icout")
						return
				if(target.status2==null)
					if(target.status1=="Burn" || target.status3 == "Burn")
						return
					else
						target.status2="Burn"
						target.status2turns=3
						view(target) <<output("<b>[target] has been afflicted with <b>Burn</b>!","icout")
						return
				if(target.status3==null)
					target.status3="Burn"
					target.status3turns=3
					view(target) <<output("<b>[target] has been afflicted with <b>Burn</b>!","icout")
					return

		AddParalyzed(var/atom/target)
			if(target.positivestatus1=="Safe" || target.positivestatus2=="Safe" || target.positivestatus3=="Safe")
				if(target.positivestatus1=="Safe")
					positivestatus1=null
					view(target)<<output("<b>[target]'s Safe effect has prevented a status effect!</b>","icout")
					return
				if(target.positivestatus2=="Safe")
					positivestatus2=null
					view(target)<<output("<b>[target]'s Safe effect has prevented a status effect!</b>","icout")
					return
				if(target.positivestatus3=="Safe")
					positivestatus3=null
					view(target)<<output("<b>[target]'s Safe effect has prevented a status effect!</b>","icout")
					return
			if (target.status1==null || target.status2==null || target.status3==null)
				if(target.status1==null)
					if(target.status2 == "Paralyzed" || target.status3 == "Paralyzed")
						return
					else
						target.status1="Paralyzed"
						target.statusturns=3
						view(target) <<output("<b>[target] has been afflicted with <b>Paralyzed</b>!","icout")
						return
				if(target.status2==null)
					if(target.status1=="Paralyzed" || target.status3 == "Paralyzed")
						return
					else
						target.status2="Paralyzed"
						target.status2turns=3
						view(target) <<output("<b>[target] has been afflicted with <b>Paralyzed</b>!","icout")
						return
				if(target.status3==null)
					target.status3="Paralyzed"
					target.status3turns=3
					view(target) <<output("<b>[target] has been afflicted with <b>Paralyzed</b>!","icout")
					return

		AddPoison(var/atom/target)
			if(target.positivestatus1=="Safe" || target.positivestatus2=="Safe" || target.positivestatus3=="Safe")
				if(target.positivestatus1=="Safe")
					positivestatus1=null
					view(target)<<output("<b>[target]'s Safe effect has prevented a status effect!</b>","icout")
					return
				if(target.positivestatus2=="Safe")
					positivestatus2=null
					view(target)<<output("<b>[target]'s Safe effect has prevented a status effect!</b>","icout")
					return
				if(target.positivestatus3=="Safe")
					positivestatus3=null
					view(target)<<output("<b>[target]'s Safe effect has prevented a status effect!</b>","icout")
					return
			if (target.status1==null || target.status2==null || target.status3==null)
				if(target.status1==null)
					if(target.status2 == "Poison" || target.status3 == "Poison")
						return
					else
						target.status1="Poison"
						target.statusturns=3
						view(target) <<output("<b>[target] has been afflicted with <b>Poison</b>!","icout")
						return
				if(target.status2==null)
					if(target.status1=="Poison" || target.status3 == "Poison")
						return
					else
						target.status2="Poison"
						target.status2turns=3
						view(target) <<output("<b>[target] has been afflicted with <b>Poison</b>!","icout")
						return
				if(target.status3==null)
					target.status3="Poison"
					target.status3turns=3
					view(target) <<output("<b>[target] has been afflicted with <b>Poison</b>!","icout")
					return

		AddBleed(var/atom/target)
			if(target.positivestatus1=="Safe" || target.positivestatus2=="Safe" || target.positivestatus3=="Safe")
				if(target.positivestatus1=="Safe")
					positivestatus1=null
					view(target)<<output("<b>[target]'s Safe effect has prevented a status effect!</b>","icout")
					return
				if(target.positivestatus2=="Safe")
					positivestatus2=null
					view(target)<<output("<b>[target]'s Safe effect has prevented a status effect!</b>","icout")
					return
				if(target.positivestatus3=="Safe")
					positivestatus3=null
					view(target)<<output("<b>[target]'s Safe effect has prevented a status effect!</b>","icout")
					return
			if (target.status1==null || target.status2==null || target.status3==null)
				if(target.status1==null)
					if(target.status2 == "Bleed" || target.status3 == "Bleed")
						return
					else
						target.status1="Bleed"
						target.statusturns=3
						view(target) <<output("<b>[target] has been afflicted with <b>Bleed</b>!","icout")
						return
				if(target.status2==null)
					if(target.status1=="Bleed" || target.status3 == "Bleed")
						return
					else
						target.status2="Bleed"
						target.status2turns=3
						view(target) <<output("<b>[target] has been afflicted with <b>Bleed</b>!","icout")
						return
				if(target.status3==null)
					target.status3="Bleed"
					target.status3turns=3
					view(target) <<output("<b>[target] has been afflicted with <b>Bleed</b>!","icout")
					return
		AddFrostbite(var/atom/target)
			if(target.positivestatus1=="Safe" || target.positivestatus2=="Safe" || target.positivestatus3=="Safe")
				if(target.positivestatus1=="Safe")
					positivestatus1=null
					view(target)<<output("<b>[target]'s Safe effect has prevented a status effect!</b>","icout")
					return
				if(target.positivestatus2=="Safe")
					positivestatus2=null
					view(target)<<output("<b>[target]'s Safe effect has prevented a status effect!</b>","icout")
					return
				if(target.positivestatus3=="Safe")
					positivestatus3=null
					view(target)<<output("<b>[target]'s Safe effect has prevented a status effect!</b>","icout")
					return
			if (target.status1==null || target.status2==null || target.status3==null)
				if(target.status1==null)
					if(target.status2 == "Frostbite" || target.status3 == "Frostbite")
						return
					else
						target.status1="Frostbite"
						target.statusturns=3
						view(target) <<output("<b>[target] has been afflicted with <b>Frostbite</b>!","icout")
						return
				if(target.status2==null)
					if(target.status1=="Frostbite" || target.status3 == "Frostbite")
						return
					else
						target.status2="Frostbite"
						target.status2turns=3
						view(target) <<output("<b>[target] has been afflicted with <b>Frostbite</b>!","icout")
						return
				if(target.status3==null)
					target.status3="Frostbite"
					target.status3turns=3
					view(target) <<output("<b>[target] has been afflicted with <b>Frostbite</b>!","icout")
					return
		AddDoom(var/atom/target)
			if(target.positivestatus1=="Safe" || target.positivestatus2=="Safe" || target.positivestatus3=="Safe")
				if(target.positivestatus1=="Safe")
					positivestatus1=null
					view(target)<<output("<b>[target]'s Safe effect has prevented a status effect!</b>","icout")
					return
				if(target.positivestatus2=="Safe")
					positivestatus2=null
					view(target)<<output("<b>[target]'s Safe effect has prevented a status effect!</b>","icout")
					return
				if(target.positivestatus3=="Safe")
					positivestatus3=null
					view(target)<<output("<b>[target]'s Safe effect has prevented a status effect!</b>","icout")
					return
			if (target.status1==null || target.status2==null || target.status3==null)
				if(target.status1==null)
					if(target.status2 == "Doom" || target.status3 == "Doom")
						return
					else
						target.status1="Doom"
						target.statusturns=3
						view(target) <<output("<b>[target] has been afflicted with <b>Doom</b>!","icout")
						return
				if(target.status2==null)
					if(target.status1=="Doom" || target.status3 == "Doom")
						return
					else
						target.status2="Doom"
						target.status2turns=3
						view(target) <<output("<b>[target] has been afflicted with <b>Doom</b>!","icout")
						return
				if(target.status3==null)
					target.status3="Doom"
					target.status3turns=3
					view(target) <<output("<b>[target] has been afflicted with <b>Doom</b>!","icout")
					return
		AddWet(var/atom/target)
			if(target.positivestatus1=="Safe" || target.positivestatus2=="Safe" || target.positivestatus3=="Safe")
				if(target.positivestatus1=="Safe")
					positivestatus1=null
					view(target)<<output("<b>[target]'s Safe effect has prevented a status effect!</b>","icout")
					return
				if(target.positivestatus2=="Safe")
					positivestatus2=null
					view(target)<<output("<b>[target]'s Safe effect has prevented a status effect!</b>","icout")
					return
				if(target.positivestatus3=="Safe")
					positivestatus3=null
					view(target)<<output("<b>[target]'s Safe effect has prevented a status effect!</b>","icout")
					return
			if (target.status1==null || target.status2==null || target.status3==null)
				if(target.status1==null)
					if(target.status2 == "Wet" || target.status3 == "Wet")
						return
					else
						target.status1="Wet"
						target.statusturns=3
						view(target) <<output("<b>[target] has been afflicted with <b>Wet</b>!","icout")
						return
				if(target.status2==null)
					if(target.status1=="Wet" || target.status3 == "Wet")
						return
					else
						target.status2="Wet"
						target.status2turns=3
						view(target) <<output("<b>[target] has been afflicted with <b>Wet</b>!","icout")
						return
				if(target.status3==null)
					target.status3="Wet"
					target.status3turns=3
					view(target) <<output("<b>[target] has been afflicted with <b>Wet</b>!","icout")
					return
		AddStun(var/atom/target)
			if(target.positivestatus1=="Safe" || target.positivestatus2=="Safe" || target.positivestatus3=="Safe")
				if(target.positivestatus1=="Safe")
					positivestatus1=null
					view(target)<<output("<b>[target]'s Safe effect has prevented a status effect!</b>","icout")
					return
				if(target.positivestatus2=="Safe")
					positivestatus2=null
					view(target)<<output("<b>[target]'s Safe effect has prevented a status effect!</b>","icout")
					return
				if(target.positivestatus3=="Safe")
					positivestatus3=null
					view(target)<<output("<b>[target]'s Safe effect has prevented a status effect!</b>","icout")
					return
			if (target.status1==null || target.status2==null || target.status3==null)
				if(target.status1==null)
					if(target.status2 == "Stun" || target.status3 == "Stun")
						return
					else
						target.status1="Stun"
						target.statusturns=3
						view(target) <<output("<b>[target] has been afflicted with <b>Stun</b>!","icout")
						return
				if(target.status2==null)
					if(target.status1=="Stun" || target.status3 == "Stun")
						return
					else
						target.status2="Stun"
						target.status2turns=3
						view(target) <<output("<b>[target] has been afflicted with <b>Stun</b>!","icout")
						return
				if(target.status3==null)
					target.status3="Stun"
					target.status3turns=3
					view(target) <<output("<b>[target] has been afflicted with <b>Stun</b>!","icout")
					return
		AddSquall(var/atom/target)
			if(target.positivestatus1=="Safe" || target.positivestatus2=="Safe" || target.positivestatus3=="Safe")
				if(target.positivestatus1=="Safe")
					positivestatus1=null
					view(target)<<output("<b>[target]'s Safe effect has prevented a status effect!</b>","icout")
					return
				if(target.positivestatus2=="Safe")
					positivestatus2=null
					view(target)<<output("<b>[target]'s Safe effect has prevented a status effect!</b>","icout")
					return
				if(target.positivestatus3=="Safe")
					positivestatus3=null
					view(target)<<output("<b>[target]'s Safe effect has prevented a status effect!</b>","icout")
					return
			if (target.status1==null || target.status2==null || target.status3==null)
				if(target.status1==null)
					if(target.status2 == "Squall" || target.status3 == "Squall")
						return
					else
						target.status1="Squall"
						target.statusturns=3
						view(target) <<output("<b>[target] has been afflicted with <b>Squall</b>!","icout")
						return
				if(target.status2==null)
					if(target.status1=="Squall" || target.status3 == "Squall")
						return
					else
						target.status2="Squall"
						target.status2turns=3
						view(target) <<output("<b>[target] has been afflicted with <b>Squall</b>!","icout")
						return
				if(target.status3==null)
					target.status3="Squall"
					target.status3turns=3
					view(target) <<output("<b>[target] has been afflicted with <b>Squall</b>!","icout")
					return
		AddSlow(var/atom/target)
			if(target.positivestatus1=="Safe" || target.positivestatus2=="Safe" || target.positivestatus3=="Safe")
				if(target.positivestatus1=="Safe")
					positivestatus1=null
					view(target)<<output("<b>[target]'s Safe effect has prevented a status effect!</b>","icout")
					return
				if(target.positivestatus2=="Safe")
					positivestatus2=null
					view(target)<<output("<b>[target]'s Safe effect has prevented a status effect!</b>","icout")
					return
				if(target.positivestatus3=="Safe")
					positivestatus3=null
					view(target)<<output("<b>[target]'s Safe effect has prevented a status effect!</b>","icout")
					return
			if (target.status1==null || target.status2==null || target.status3==null)
				if(target.status1==null)
					if(target.status2 == "Slow" || target.status3 == "Slow")
						return
					else
						target.status1="Slow"
						target.statusturns=3
						view(target) <<output("<b>[target] has been afflicted with <b>Slow</b>!","icout")
						return
				if(target.status2==null)
					if(target.status1=="Slow" || target.status3 == "Slow")
						return
					else
						target.status2="Slow"
						target.status2turns=3
						view(target) <<output("<b>[target] has been afflicted with <b>Slow</b>!","icout")
						return
				if(target.status3==null)
					target.status3="Slow"
					target.status3turns=3
					view(target) <<output("<b>[target] has been afflicted with <b>Slow</b>!","icout")
					return
		AddHeavy(var/atom/target)
			if(target.positivestatus1=="Safe" || target.positivestatus2=="Safe" || target.positivestatus3=="Safe")
				if(target.positivestatus1=="Safe")
					positivestatus1=null
					view(target)<<output("<b>[target]'s Safe effect has prevented a status effect!</b>","icout")
					return
				if(target.positivestatus2=="Safe")
					positivestatus2=null
					view(target)<<output("<b>[target]'s Safe effect has prevented a status effect!</b>","icout")
					return
				if(target.positivestatus3=="Safe")
					positivestatus3=null
					view(target)<<output("<b>[target]'s Safe effect has prevented a status effect!</b>","icout")
					return
			if (target.status1==null || target.status2==null || target.status3==null)
				if(target.status1==null)
					if(target.status2 == "Heavy" || target.status3 == "Heavy")
						return
					else
						target.status1="Heavy"
						target.statusturns=3
						view(target) <<output("<b>[target] has been afflicted with <b>Heavy</b>!","icout")
						return
				if(target.status2==null)
					if(target.status1=="Heavy" || target.status3 == "Heavy")
						return
					else
						target.status2="Heavy"
						target.status2turns=3
						view(target) <<output("<b>[target] has been afflicted with <b>Heavy</b>!","icout")
						return
				if(target.status3==null)
					target.status3="Heavy"
					target.status3turns=3
					view(target) <<output("<b>[target] has been afflicted with <b>Heavy</b>!","icout")
					return
		AddWeakness(var/atom/target)
			if(target.positivestatus1=="Safe" || target.positivestatus2=="Safe" || target.positivestatus3=="Safe")
				if(target.positivestatus1=="Safe")
					positivestatus1=null
					view(target)<<output("<b>[target]'s Safe effect has prevented a status effect!</b>","icout")
					return
				if(target.positivestatus2=="Safe")
					positivestatus2=null
					view(target)<<output("<b>[target]'s Safe effect has prevented a status effect!</b>","icout")
					return
				if(target.positivestatus3=="Safe")
					positivestatus3=null
					view(target)<<output("<b>[target]'s Safe effect has prevented a status effect!</b>","icout")
					return
			if (target.status1==null || target.status2==null || target.status3==null)
				if(target.status1==null)
					if(target.status2 == "Weakness" || target.status3 == "Weakness")
						return
					else
						target.status1="Weakness"
						target.statusturns=3
						view(target) <<output("<b>[target] has been afflicted with <b>Weakness</b>!","icout")
						return
				if(target.status2==null)
					if(target.status1=="Weakness" || target.status3 == "Weakness")
						return
					else
						target.status2="Weakness"
						target.status2turns=3
						view(target) <<output("<b>[target] has been afflicted with <b>Weakness</b>!","icout")
						return
				if(target.status3==null)
					target.status3="Heavy"
					target.status3turns=3
					view(target) <<output("<b>[target] has been afflicted with <b>Weakness</b>!","icout")
					return

atom
	proc
		Statusprocenemy(var/obj/user)
			if(user.statusturns<=0)
				user.totalstatus-=1
				user.status1=null
				if(user.totalstatus<=0)
					user.totalstatus=0
			if(user.status1=="Bleed" || user.status2=="Bleed" || user.status3=="Bleed")
				Bleed(user)
				user<<output("<b>[user]</b> has taken <b>5</b> <b><font color=#F26646>Bleed damage!</font>","icout")
				user.hp-=5
				if(user.status1=="Bleed")
					user.statusturns-=1
				if(user.status2=="Bleed")
					user.status2turns-=1
				if(user.status3=="Bleed")
					user.status3turns-=1
			if(user.status1=="Poison" || user.status2=="Poison" || user.status3=="Poison")
				Poison(user)
				user<<output("<b>[user]</b> has taken <b>5</b> <b><font color=#6EF679>Poison damage!</font>","icout")
				user.hp-=5
				if(user.status1=="Poison")
					user.statusturns-=1
				if(user.status2=="Poison")
					user.status2turns-=1
				if(user.status3=="Poison")
					user.status3turns-=1
			if(user.status1=="Burn" || user.status2=="Burn" || user.status3=="Burn")
				Burn(user)
				user<<output("<b>[user]</b> has taken <b>5</b> <font color=#FAB130>Burn damage!</font>","icout")
				user.hp-=5
				if(user.status1=="Burn")
					user.statusturns-=1
				if(user.status2=="Burn")
					user.status2turns-=1
				if(user.status3=="Burn")
					user.status3turns-=1
			if(user.status1=="Frostbite" || user.status2=="Frostbite" || user.status3=="Frostbite")
				Frostbite(user)
				user<<output("<b>[user]</b> has taken <b>4</b> <font color=#94FAED>Frostbite damage!</font>","icout")
				user.hp-=4
				if(user.status1=="Frostbite")
					user.statusturns-=1
				if(user.status2=="Frostbite")
					user.status2turns-=1
				if(user.status3=="Frostbite")
					user.status3turns-=1
			if(user.status1=="Squall" || user.status2=="Squall" || user.status3=="Squall")
				if(user.status1=="Squall")
					user<<output("<b>[user]</b> has <b>[user.statusturns] turns left of</b> <font color=#94FAED>Squall!</font>","icout")
					user.statusturns-=1
				if(user.status2=="Squall")
					user<<output("<b>[user]</b> has <b>[user.status2turns] turns left of</b> <font color=#94FAED>Squall!</font>","icout")
					user.status2turns-=1
				if(user.status3=="Squall")
					user<<output("<b>[user]</b> has <b>[user.status3turns] turns left of</b> <font color=#94FAED>Squall!</font>","icout")
					user.status3turns-=1
			if(user.status1=="Wet" || user.status2=="Wet" || user.status3=="Wet")
				if(user.status1=="Wet")
					user<<output("<b>[user]</b> has <b>[user.statusturns] turns left of</b> <font color=#94FAED>Wet!</font>","icout")
					user.statusturns-=1
				if(user.status2=="Wet")
					user<<output("<b>[user]</b> has <b>[user.status2turns] turns left of</b> <font color=#94FAED>Wet!</font>","icout")
					user.status2turns-=1
				if(user.status3=="Wet")
					user<<output("<b>[user]</b> has <b>[user.status3turns] turns left of</b> <font color=#94FAED>Wet!</font>","icout")
					user.status3turns-=1
			if(user.status1=="Slow" || user.status2=="Slow" || user.status3=="Slow")
				if(user.status1=="Slow")
					user<<output("<b>[user]</b> has <b>[user.statusturns] turns left of</b> <font color=#94FAED>Slow!</font>","icout")
					user.statusturns-=1
				if(user.status2=="Slow")
					user<<output("<b>[user]</b> has <b>[user.status2turns] turns left of</b> <font color=#94FAED>Slow!</font>","icout")
					user.status2turns-=1
				if(user.status3=="Slow")
					user<<output("<b>[user]</b> has <b>[user.status3turns] turns left of</b> <font color=#94FAED>Slow!</font>","icout")
					user.status3turns-=1
			if(user.status1=="Heavy" || user.status2=="Heavy" || user.status3=="Heavy")
				if(user.status1=="Heavy")
					user<<output("<b>[user]</b> has <b>[user.statusturns] turns left of</b> <font color=#94FAED>Heavy!</font>","icout")
					user.statusturns-=1
				if(user.status2=="Heavy")
					user<<output("<b>[user]</b> has <b>[user.status2turns] turns left of</b> <font color=#94FAED>Heavy!</font>","icout")
					user.status2turns-=1
				if(user.status3=="Heavy")
					user<<output("<b>[user]</b> has <b>[user.status3turns] turns left of</b> <font color=#94FAED>Heavy!</font>","icout")
					user.status3turns-=1
			if(user.status1=="Weakness" || user.status2=="Weakness" || user.status3=="Weakness")
				if(user.status1=="Weakness")
					user<<output("<b>[user]</b> has <b>[user.statusturns] turns left of</b> <font color=#94FAED>Weakness!</font>","icout")
					user.statusturns-=1
				if(user.status2=="Weakness")
					user<<output("<b>[user]</b> has <b>[user.status2turns] turns left of</b> <font color=#94FAED>Weakness!</font>","icout")
					user.status2turns-=1
				if(user.status3=="Weakness")
					user<<output("<b>[user]</b> has <b>[user.status3turns] turns left of</b> <font color=#94FAED>Weakness!</font>","icout")
					user.status3turns-=1
			if(user.status1=="Paralyzed" || user.status2=="Paralyzed" || user.status3=="Paralyzed")
				if(user.status1=="Paralyzed")
					user<<output("<b>[user]</b> has <b>[user.statusturns] turns left of</b> <font color=#94FAED>Paralyzed!</font>","icout")
					user.statusturns-=1
				if(user.status2=="Paralyzed")
					user<<output("<b>[user]</b> has <b>[user.status2turns] turns left of</b> <font color=#94FAED>Paralyzed!</font>","icout")
					user.status2turns-=1
				if(user.status3=="Paralyzed")
					user<<output("<b>[user]</b> has <b>[user.status3turns] turns left of</b> <font color=#94FAED>Paralyzed!</font>","icout")
					user.status3turns-=1
			if(user.hp<=0)
				usr.hp=0
				user<<output("<b>[user]</b> has been rendered unable to fight by Status Effect damage!","icout")
				Death(user)
				sleep(4)
			if(user.statusturns<=0)
				user.status1=null
				user.totalstatus-=1
			if(user.status2turns<=0)
				user.status2=null
				user.totalstatus-=1
			if(user.status3turns<=0)
				user.status3=null
				user.totalstatus-=1
			ShowHPBar(user)
			ShowMPBar(user)
			ShowSPBar(user)
			sleep(2)
		Statusprocparty(var/mob/user)
			if(user.status1=="Doom" || user.status2=="Doom" || user.status3=="Doom")
				Death(user)
				if(user.status1=="Doom")
					user<<output("<b>[user] has [user.statusturns] turns until <b><font color=#DDB3E5>Doom</font> kills them!","icout")
					if(user.statusturns<=0)
						user.hp=0
						user.status1=null
						view(user)<<output("<b><font color=[user.textcolor]>[user]</font> has been killed by <b><font color=#B284F5>Doom</font>!!","icout")
					else
						user.status1=null
						user.statusturns-=1
				if(user.status2=="Doom")
					user<<output("<b>[user] has [user.status2turns] turns until <b><font color=#DDB3E5>Doom</font> kills them!","icout")
					if(user.status2turns<=0)
						user.hp=0
						user.status2=null
						view(user)<<output("<b><font color=[user.textcolor]>[user]</font> has been killed by <b><font color=#B284F5>Doom</font>!!","icout")
					else
						user.status2=null
						user.status2turns-=1
				if(user.status3=="Doom")
					user<<output("<b>[user] has [user.status3turns] turns until <b><font color=#DDB3E5>Doom</font> kills them!","icout")
					if(user.status3turns<=0)
						user.hp=0
						user.status3=null
						view(user)<<output("<b><font color=[user.textcolor]>[user]</font> has been killed by <b><font color=#B284F5>Doom</font>!!","icout")
					else
						user.status3=null
						user.status3turns-=1
			if(user.status1=="Paralyzed" || user.status2=="Paralyzed" || user.status3=="Paralyzed")
				if(user.status1=="Paralyzed")
					user<<output("<b>[user]</b> has <b>[user.statusturns] turns left of</b> <font color=#94FAED>Paralyzed!</font>","icout")
					user.statusturns-=1
				if(user.status2=="Paralyzed")
					user<<output("<b>[user]</b> has <b>[user.status2turns] turns left of</b> <font color=#94FAED>Paralyzed!</font>","icout")
					user.status2turns-=1
				if(user.status3=="Paralyzed")
					user<<output("<b>[user]</b> has <b>[user.status3turns] turns left of</b> <font color=#94FAED>Paralyzed!</font>","icout")
					user.status3turns-=1
			if(user.status1=="Bleed" || user.status2=="Bleed" || user.status3=="Bleed")
				Bleed(user)
				user<<output("<b>[user]</b> has taken <b>5</b> <b><font color=#F26646>Bleed damage!</font>","icout")
				user.hp-=5
				if(user.status1=="Bleed")
					user.statusturns-=1
				if(user.status2=="Bleed")
					user.status2turns-=1
				if(user.status3=="Bleed")
					user.status3turns-=1
			if(user.status1=="Poison" || user.status2=="Poison" || user.status3=="Poison")
				Poison(user)
				user<<output("<b>[user]</b> has taken <b>5</b> <b><font color=#6EF679>Poison damage!</font>","icout")
				user.hp-=5
				if(user.status1=="Poison")
					user.statusturns-=1
				if(user.status2=="Poison")
					user.status2turns-=1
				if(user.status3=="Poison")
					user.status3turns-=1
			if(user.status1=="Burn" || user.status2=="Burn" || user.status3=="Burn")
				Burn(user)
				user<<output("<b>[user]</b> has taken <b>5</b> <font color=#FAB130>Burn damage!</font>","icout")
				user.hp-=5
				if(user.status1=="Burn")
					user.statusturns-=1
				if(user.status2=="Burn")
					user.status2turns-=1
				if(user.status3=="Burn")
					user.status3turns-=1
			if(user.status1=="Frostbite" || user.status2=="Frostbite" || user.status3=="Frostbite")
				Frostbite(user)
				user<<output("<b>[user]</b> has taken <b>4</b> <font color=#94FAED>Frostbite damage!</font>","icout")
				user.hp-=4
				if(user.status1=="Frostbite")
					user.statusturns-=1
				if(user.status2=="Frostbite")
					user.status2turns-=1
				if(user.status3=="Frostbite")
					user.status3turns-=1
			if(user.status1=="Squall" || user.status2=="Squall" || user.status3=="Squall")
				if(user.status1=="Squall")
					user<<output("<b>[user]</b> has <b>[user.statusturns] turns left of</b> <font color=#94FAED>Squall!</font>","icout")
					user.statusturns-=1
				if(user.status2=="Squall")
					user<<output("<b>[user]</b> has <b>[user.status2turns] turns left of</b> <font color=#94FAED>Squall!</font>","icout")
					user.status2turns-=1
				if(user.status3=="Squall")
					user<<output("<b>[user]</b> has <b>[user.status3turns] turns left of</b> <font color=#94FAED>Squall!</font>","icout")
					user.status3turns-=1
			if(user.status1=="Wet" || user.status2=="Wet" || user.status3=="Wet")
				if(user.status1=="Wet")
					user<<output("<b>[user]</b> has <b>[user.statusturns] turns left of</b> <font color=#94FAED>Wet!</font>","icout")
					user.statusturns-=1
				if(user.status2=="Wet")
					user<<output("<b>[user]</b> has <b>[user.status2turns] turns left of</b> <font color=#94FAED>Wet!</font>","icout")
					user.status2turns-=1
				if(user.status3=="Wet")
					user<<output("<b>[user]</b> has <b>[user.status3turns] turns left of</b> <font color=#94FAED>Wet!</font>","icout")
					user.status3turns-=1
			if(user.status1=="Slow" || user.status2=="Slow" || user.status3=="Slow")
				if(user.status1=="Slow")
					user<<output("<b>[user]</b> has <b>[user.statusturns] turns left of</b> <font color=#94FAED>Slow!</font>","icout")
					user.statusturns-=1
				if(user.status2=="Slow")
					user<<output("<b>[user]</b> has <b>[user.status2turns] turns left of</b> <font color=#94FAED>Slow!</font>","icout")
					user.status2turns-=1
				if(user.status3=="Slow")
					user<<output("<b>[user]</b> has <b>[user.status3turns] turns left of</b> <font color=#94FAED>Slow!</font>","icout")
					user.status3turns-=1
			if(user.status1=="Heavy" || user.status2=="Heavy" || user.status3=="Heavy")
				if(user.status1=="Heavy")
					user<<output("<b>[user]</b> has <b>[user.statusturns] turns left of</b> <font color=#94FAED>Heavy!</font>","icout")
					user.statusturns-=1
				if(user.status2=="Heavy")
					user<<output("<b>[user]</b> has <b>[user.status2turns] turns left of</b> <font color=#94FAED>Heavy!</font>","icout")
					user.status2turns-=1
				if(user.status3=="Heavy")
					user<<output("<b>[user]</b> has <b>[user.status3turns] turns left of</b> <font color=#94FAED>Heavy!</font>","icout")
					user.status3turns-=1
			if(user.status1=="Weakness" || user.status2=="Weakness" || user.status3=="Weakness")
				if(user.status1=="Weakness")
					user<<output("<b>[user]</b> has <b>[user.statusturns] turns left of</b> <font color=#94FAED>Weakness!</font>","icout")
					user.statusturns-=1
				if(user.status2=="Weakness")
					user<<output("<b>[user]</b> has <b>[user.status2turns] turns left of</b> <font color=#94FAED>Weakness!</font>","icout")
					user.status2turns-=1
				if(user.status3=="Weakness")
					user<<output("<b>[user]</b> has <b>[user.status3turns] turns left of</b> <font color=#94FAED>Weakness!</font>","icout")
					user.status3turns-=1
			if(user.hp<=0)
				usr.hp=0
				user<<output("<b>[user]</b> has been rendered unable to fight by Status Effect damage!","icout")
				Death(user)
				sleep(4)
			if(user.statusturns<=0)
				user.status1=null
			if(user.status2turns<=0)
				user.status2=null
			if(user.statusturns<=0)
				user.status3=null
			ShowHPBar(user)
			ShowMPBar(user)
			ShowSPBar(user)
			sleep(2)


atom
	proc
		Healanimation(var/atom/user,var/atom/target)
			set waitfor = FALSE
			var/obj/prop/Cast/Heal/cast=new
			var/obj/prop/Target/Heal/heal=new
			view(12,user) << sound('Audio/Soundeffects/Castmagic.wav',channel=3)
			sleep(5)
			cast.x=user.x
			cast.y=user.y
			cast.z=user.z
			sleep(8)
			del cast
			view(12,user) << sound('Audio/Soundeffects/Heal.wav',channel=3)
			heal.x=target.x
			heal.y=target.y
			heal.z=target.z
			sleep(10)
			del heal

		Burn(var/atom/target)
			set waitfor = FALSE
			var/obj/prop/Target/Fire/attack=new
			view(12,target) << sound('Audio/Soundeffects/Fire.wav',channel=3)
			attack.x=target.x
			attack.y=target.y
			attack.z=target.z
			sleep(10)
			del attack
		Poison(var/atom/target)
			set waitfor = FALSE
			var/obj/prop/Target/Bio/attack=new
			view(12,target) << sound('Audio/Soundeffects/Bio.wav',channel=3)
			attack.x=target.x
			attack.y=target.y
			attack.z=target.z
			sleep(10)
			del attack
		Frostbite(var/atom/target)
			set waitfor = FALSE
			var/obj/prop/Target/Ice/attack=new
			view(12,target) << sound('Audio/Soundeffects/Ice.wav',channel=3)
			attack.x=target.x
			attack.y=target.y
			attack.z=target.z
			sleep(10)
			del attack
		Bleed(var/atom/target)
			set waitfor = FALSE
			var/obj/prop/Target/Dark/attack=new
			view(12,target) << sound('Audio/Soundeffects/Dark.wav',channel=3)
			attack.x=target.x
			attack.y=target.y
			attack.z=target.z
			sleep(10)
			del attack

		Death(var/atom/target)
			set waitfor = FALSE
			var/obj/prop/Death/death=new
			view(12,target) << sound('Audio/Soundeffects/Death.wav',channel=3)
			death.x=target.x
			death.y=target.y
			death.z=target.z
			spawn(12)
				del death
		GreenMagic(var/atom/target)
			set waitfor = FALSE
			var/obj/prop/Target/Heal/heal=new
			view(12,target) << sound('Audio/Soundeffects/Heal.wav',channel=3)
			heal.x=target.x
			heal.y=target.y
			heal.z=target.z
			spawn(12)
				del heal
		Dispel(var/atom/target)
			set waitfor = FALSE
			var/obj/prop/Target/Holy/dispel=new
			view(12,target) << sound('Audio/Soundeffects/Holy.wav',channel=3)
			dispel.x=target.x
			dispel.y=target.y
			dispel.z=target.z
			sleep(12)
			del dispel
		Evade(var/atom/target)
			set waitfor = FALSE
			var/obj/prop/Evade/evade=new
			view(12,target) << sound('Audio/Soundeffects/Evasion.wav',channel=3)
			evade.x=target.x
			evade.y=target.y
			evade.z=target.z
			sleep(4)
			del evade

		Enemyanimation(var/obj/npc/user,var/mob/target,var/obj/perk/skill)
			set waitfor = FALSE
			var/element=skill.element
			if(element=="Death")
				var/obj/prop/Cast/Magic/cast=new
				var/obj/prop/Target/Dark/attack=new
				view(12,user) << sound('Audio/Soundeffects/Castmagic.wav',channel=3)
				sleep(5)
				cast.x=user.x
				cast.y=user.y
				cast.z=user.z
				sleep(8)
				del cast
				view(12,user) << sound('Audio/Soundeffects/Dark.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(10)
				del attack
			if(element=="Fire")
				var/obj/prop/Cast/Magic/cast=new
				var/obj/prop/Target/Fire/attack=new
				view(12,user) << sound('Audio/Soundeffects/Castmagic.wav',channel=3)
				sleep(5)
				cast.x=user.x
				cast.y=user.y
				cast.z=user.z
				sleep(8)
				del cast
				view(12,user) << sound('Audio/Soundeffects/Fire.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(10)
				del attack
			if(element=="Water")
				var/obj/prop/Cast/Magic/cast=new
				var/obj/prop/Target/Water/attack=new
				view(12,user) << sound('Audio/Soundeffects/Castmagic.wav',channel=3)
				sleep(5)
				cast.x=user.x
				cast.y=user.y
				cast.z=user.z
				sleep(8)
				del cast
				view(12,user) << sound('Audio/Soundeffects/Water.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(10)
				del attack
			if(element=="Thunder")
				var/obj/prop/Cast/Magic/cast=new
				var/obj/prop/Target/Thunder/attack=new
				view(12,user) << sound('Audio/Soundeffects/Castmagic.wav',channel=3)
				sleep(5)
				cast.x=user.x
				cast.y=user.y
				cast.z=user.z
				sleep(8)
				del cast
				view(12,user) << sound('Audio/Soundeffects/Thunder.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(10)
				del attack
			if(element=="Ice")
				var/obj/prop/Cast/Magic/cast=new
				var/obj/prop/Target/Ice/attack=new
				view(12,user) << sound('Audio/Soundeffects/Castmagic.wav',channel=3)
				sleep(5)
				cast.x=user.x
				cast.y=user.y
				cast.z=user.z
				sleep(8)
				del cast
				view(12,user) << sound('Audio/Soundeffects/Ice.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(10)
				del attack
			if(element=="Wind")
				var/obj/prop/Cast/Magic/cast=new
				var/obj/prop/Target/Wind/attack=new
				view(12,user) << sound('Audio/Soundeffects/Castmagic.wav',channel=3)
				sleep(5)
				cast.x=user.x
				cast.y=user.y
				cast.z=user.z
				sleep(8)
				del cast
				view(12,user) << sound('Audio/Soundeffects/Wind.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(10)
				del attack
			if(element=="Earth")
				var/obj/prop/Cast/Magic/cast=new
				var/obj/prop/Target/Earth/attack=new
				view(12,user) << sound('Audio/Soundeffects/Castmagic.wav',channel=3)
				sleep(5)
				cast.x=user.x
				cast.y=user.y
				cast.z=user.z
				sleep(8)
				del cast
				view(12,user) << sound('Audio/Soundeffects/Earth.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(10)
				del attack
			if(element=="General")
				var/obj/prop/Cast/Magic/cast=new
				var/obj/prop/Target/General/attack=new
				view(12,user) << sound('Audio/Soundeffects/Castmagic.wav',channel=3)
				sleep(5)
				cast.x=user.x
				cast.y=user.y
				cast.z=user.z
				sleep(8)
				del cast
				view(12,user) << sound('Audio/Soundeffects/General.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(10)
				del attack
			if(element=="Dark")
				var/obj/prop/Cast/Magic/cast=new
				var/obj/prop/Target/Dark/attack=new
				view(12,user) << sound('Audio/Soundeffects/Castmagic.wav',channel=3)
				sleep(5)
				cast.x=user.x
				cast.y=user.y
				cast.z=user.z
				sleep(8)
				del cast
				view(12,user) << sound('Audio/Soundeffects/Dark.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(10)
				del attack
			if(element=="Holy")
				var/obj/prop/Cast/Magic/cast=new
				var/obj/prop/Target/Holy/attack=new
				view(12,user) << sound('Audio/Soundeffects/Castmagic.wav',channel=3)
				sleep(5)
				cast.x=user.x
				cast.y=user.y
				cast.z=user.z
				sleep(8)
				del cast
				view(12,user) << sound('Audio/Soundeffects/Holy.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(10)
				del attack
			if(element=="Time")
				var/obj/prop/Cast/Magic/cast=new
				var/obj/prop/Target/Time/attack=new
				view(12,user) << sound('Audio/Soundeffects/Castmagic.wav',channel=3)
				sleep(5)
				cast.x=user.x
				cast.y=user.y
				cast.z=user.z
				sleep(8)
				del cast
				view(12,user) << sound('Audio/Soundeffects/Time.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(10)
				del attack
			if(element=="Physical")
				var/obj/prop/Cast/Physical/cast=new
				var/obj/prop/Target/Physical/attack=new
				view(12,user) << sound('Audio/Soundeffects/Castmagic.wav',channel=3)
				sleep(5)
				cast.x=user.x
				cast.y=user.y
				cast.z=user.z
				sleep(8)
				del cast
				view(12,user) << sound('Audio/Soundeffects/Physical.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(10)
				del attack
			if(element=="Heal")
				var/obj/prop/Cast/Heal/cast=new
				var/obj/prop/Target/Heal/attack=new
				view(12,user) << sound('Audio/Soundeffects/Castmagic.wav',channel=3)
				sleep(5)
				cast.x=user.x
				cast.y=user.y
				cast.z=user.z
				sleep(8)
				del cast
				view(12,user) << sound('Audio/Soundeffects/Heal.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(10)
				del attack
			if(element=="Bio")
				var/obj/prop/Cast/Magic/cast=new
				var/obj/prop/Target/Bio/attack=new
				view(12,user) << sound('Audio/Soundeffects/Castmagic.wav',channel=3)
				sleep(5)
				cast.x=user.x
				cast.y=user.y
				cast.z=user.z
				sleep(8)
				del cast
				view(12,user) << sound('Audio/Soundeffects/Bio.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(12)
				del attack
			if(element=="Robot")
				var/obj/prop/Cast/Magic/cast=new
				var/obj/prop/Target/Robot/attack=new
				view(12,user) << sound('Audio/Soundeffects/Castmagic.wav',channel=3)
				sleep(5)
				cast.x=user.x
				cast.y=user.y
				cast.z=user.z
				sleep(8)
				del cast
				view(12,user) << sound('Audio/Soundeffects/Robot.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(12)
				del attack
			if(element=="Laser")
				var/obj/prop/Cast/Magic/cast=new
				var/obj/prop/Target/Laser/attack=new
				view(12,user) << sound('Audio/Soundeffects/Castmagic.wav',channel=3)
				sleep(5)
				cast.x=user.x
				cast.y=user.y
				cast.z=user.z
				sleep(8)
				del cast
				view(12,user) << sound('Audio/Soundeffects/Laser.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(12)
				del attack
			if(element=="Nature")
				var/obj/prop/Cast/Magic/cast=new
				var/obj/prop/Target/Nature/attack=new
				view(12,user) << sound('Audio/Soundeffects/Castmagic.wav',channel=3)
				sleep(5)
				cast.x=user.x
				cast.y=user.y
				cast.z=user.z
				sleep(8)
				del cast
				view(12,user) << sound('Audio/Soundeffects/Nature.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(12)
				del attack
			if(element=="Flare")
				var/obj/prop/Cast/Magic/cast=new
				var/obj/prop/Target/Flare/attack=new
				view(12,user) << sound('Audio/Soundeffects/Castmagic.wav',channel=3)
				sleep(5)
				cast.x=user.x
				cast.y=user.y
				cast.z=user.z
				sleep(8)
				del cast
				view(12,user) << sound('Audio/Soundeffects/Flare.wav',channel=3)
				attack.pixel_x=-64
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(13)
				del attack
			if(element=="Comet")
				var/obj/prop/Cast/Magic/cast=new
				var/obj/prop/Target/Comet/attack=new
				view(12,user) << sound('Audio/Soundeffects/Castmagic.wav',channel=3)
				sleep(5)
				cast.x=user.x
				cast.y=user.y
				cast.z=user.z
				sleep(8)
				del cast
				view(12,user) << sound('Audio/Soundeffects/Comet.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(14)
				del attack
			if(element=="Ultima")
				var/obj/prop/Cast/Magic/cast=new
				var/obj/prop/Target/Ultima/attack=new
				view(12,user) << sound('Audio/Soundeffects/Castmagic.wav',channel=3)
				sleep(5)
				cast.x=user.x
				cast.y=user.y
				cast.z=user.z
				sleep(8)
				del cast
				view(12,user) << sound('Audio/Soundeffects/Ultima.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(22)
				del attack
			if(element=="Monk")
				var/obj/prop/Cast/Physical/cast=new
				var/obj/prop/Target/Monk/attack=new
				view(12,user) << sound('Audio/Soundeffects/Castmagic.wav',channel=3)
				sleep(5)
				cast.x=user.x
				cast.y=user.y
				cast.z=user.z
				sleep(8)
				del cast
				view(12,user) << sound('Audio/Soundeffects/Physical.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(14)
				del attack
			if(element=="Drain")
				var/obj/prop/Cast/Physical/cast=new
				var/obj/prop/Target/Drain/attack=new
				view(12,user) << sound('Audio/Soundeffects/Castmagic.wav',channel=3)
				sleep(5)
				cast.x=user.x
				cast.y=user.y
				cast.z=user.z
				sleep(8)
				del cast
				view(12,user) << sound('Audio/Soundeffects/General.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(14)
				del attack
			if(element=="Osmose")
				var/obj/prop/Cast/Physical/cast=new
				var/obj/prop/Target/Osmose/attack=new
				view(12,user) << sound('Audio/Soundeffects/Castmagic.wav',channel=3)
				sleep(5)
				cast.x=user.x
				cast.y=user.y
				cast.z=user.z
				sleep(8)
				del cast
				view(12,user) << sound('Audio/Soundeffects/General.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(14)
				del attack
			if(element=="Metal")
				var/obj/prop/Cast/Magic/cast=new
				var/obj/prop/Target/Metal/attack=new
				view(12,user) << sound('Audio/Soundeffects/Castmagic.wav',channel=3)
				sleep(5)
				cast.x=user.x
				cast.y=user.y
				cast.z=user.z
				sleep(8)
				del cast
				view(12,user) << sound('Audio/Soundeffects/Physical.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(10)
				del attack


		Playerattack(var/mob/user,var/obj/npc/target)
			set waitfor = FALSE
			var/obj/prop/Cast/Physical/cast=new
			var/obj/prop/Target/Physical/attack=new
			var/obj/prop/Target/Physical/attack2=new
			var/obj/item/Weapon/reference=user.righthand
			var/reficon=reference.icon
			attack2.icon=reficon
			attack.layer=98
			attack2.layer=99
			view(12,user) << sound('Audio/Soundeffects/Castmagic.wav',channel=3)
			sleep(5)
			cast.x=user.x
			cast.y=user.y
			cast.z=user.z
			sleep(8)
			del cast
			view(12,user) << sound('Audio/Soundeffects/Physical.wav',channel=3)
			attack2.x=target.x
			attack2.y=target.y
			attack2.z=target.z
			attack.x=target.x
			attack.y=target.y
			attack.z=target.z
			sleep(10)
			del attack
			del attack2


		Spellbladeanimation(var/mob/user,var/obj/npc/target,var/obj/perk/skill)
			set waitfor = FALSE
			var/element=skill.element
			if(element=="Death")
				var/obj/prop/Target/Dark/attack=new
				view(12,user) << sound('Audio/Soundeffects/Dark.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(10)
				del attack
			if(element=="Fire")
				var/obj/prop/Target/Fire/attack=new
				view(12,user) << sound('Audio/Soundeffects/Fire.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(10)
				del attack
			if(element=="Water")
				var/obj/prop/Target/Water/attack=new
				view(12,user) << sound('Audio/Soundeffects/Water.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(10)
				del attack
			if(element=="Thunder")
				var/obj/prop/Target/Thunder/attack=new
				view(12,user) << sound('Audio/Soundeffects/Thunder.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(10)
				del attack
			if(element=="Ice")
				var/obj/prop/Target/Ice/attack=new
				view(12,user) << sound('Audio/Soundeffects/Ice.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(10)
				del attack
			if(element=="Wind")
				var/obj/prop/Target/Wind/attack=new
				view(12,user) << sound('Audio/Soundeffects/Wind.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(10)
				del attack
			if(element=="Earth")
				var/obj/prop/Target/Earth/attack=new
				view(12,user) << sound('Audio/Soundeffects/Earth.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(10)
				del attack
			if(element=="General")
				var/obj/prop/Target/General/attack=new
				view(12,user) << sound('Audio/Soundeffects/General.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(10)
				del attack
			if(element=="Dark")
				var/obj/prop/Target/Dark/attack=new
				view(12,user) << sound('Audio/Soundeffects/Dark.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(10)
				del attack
			if(element=="Holy")
				var/obj/prop/Target/Holy/attack=new
				view(12,user) << sound('Audio/Soundeffects/Holy.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(10)
				del attack
			if(element=="Time")
				var/obj/prop/Target/Time/attack=new
				view(12,user) << sound('Audio/Soundeffects/Time.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(10)
				del attack
			if(element=="Physical")
				var/obj/prop/Target/Physical/attack=new
				view(12,user) << sound('Audio/Soundeffects/Physical.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(10)
				del attack
			if(element=="Heal")
				var/obj/prop/Target/Heal/attack=new
				view(12,user) << sound('Audio/Soundeffects/Heal.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(10)
				del attack
			if(element=="Bio")
				var/obj/prop/Target/Bio/attack=new
				view(12,user) << sound('Audio/Soundeffects/Bio.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(12)
				del attack
			if(element=="Robot")
				var/obj/prop/Cast/Magic/cast=new
				var/obj/prop/Target/Robot/attack=new
				view(12,user) << sound('Audio/Soundeffects/Castmagic.wav',channel=3)
				sleep(5)
				cast.x=user.x
				cast.y=user.y
				cast.z=user.z
				sleep(8)
				del cast
				view(12,user) << sound('Audio/Soundeffects/Robot.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(12)
				del attack
			if(element=="Metal")
				var/obj/prop/Cast/Magic/cast=new
				var/obj/prop/Target/Metal/attack=new
				view(12,user) << sound('Audio/Soundeffects/Castmagic.wav',channel=3)
				sleep(5)
				cast.x=user.x
				cast.y=user.y
				cast.z=user.z
				sleep(8)
				del cast
				view(12,user) << sound('Audio/Soundeffects/Physical.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(10)
				del attack
			if(element=="Laser")
				var/obj/prop/Cast/Magic/cast=new
				var/obj/prop/Target/Laser/attack=new
				view(12,user) << sound('Audio/Soundeffects/Castmagic.wav',channel=3)
				sleep(5)
				cast.x=user.x
				cast.y=user.y
				cast.z=user.z
				sleep(8)
				del cast
				view(12,user) << sound('Audio/Soundeffects/Laser.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(12)
				del attack
			if(element=="Nature")
				var/obj/prop/Cast/Magic/cast=new
				var/obj/prop/Target/Nature/attack=new
				view(12,user) << sound('Audio/Soundeffects/Castmagic.wav',channel=3)
				sleep(5)
				cast.x=user.x
				cast.y=user.y
				cast.z=user.z
				sleep(8)
				del cast
				view(12,user) << sound('Audio/Soundeffects/Nature.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(12)
				del attack
			if(element=="Flare")
				var/obj/prop/Target/Flare/attack=new
				view(12,user) << sound('Audio/Soundeffects/Flare.wav',channel=3)
				attack.pixel_x=-64
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(13)
				del attack
			if(element=="Comet")
				var/obj/prop/Cast/Magic/cast=new
				var/obj/prop/Target/Comet/attack=new
				view(12,user) << sound('Audio/Soundeffects/Castmagic.wav',channel=3)
				sleep(5)
				cast.x=user.x
				cast.y=user.y
				cast.z=user.z
				sleep(8)
				del cast
				view(12,user) << sound('Audio/Soundeffects/Comet.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(13)
				del attack
			if(element=="Ultima")
				var/obj/prop/Cast/Magic/cast=new
				var/obj/prop/Target/Ultima/attack=new
				view(12,user) << sound('Audio/Soundeffects/Castmagic.wav',channel=3)
				sleep(5)
				cast.x=user.x
				cast.y=user.y
				cast.z=user.z
				sleep(8)
				del cast
				view(12,user) << sound('Audio/Soundeffects/Ultima.wav',channel=3)
				attack.pixel_x=-64
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(22)
				del attack
			if(element=="Monk")
				var/obj/prop/Cast/Physical/cast=new
				var/obj/prop/Target/Monk/attack=new
				view(12,user) << sound('Audio/Soundeffects/Castmagic.wav',channel=3)
				sleep(5)
				cast.x=user.x
				cast.y=user.y
				cast.z=user.z
				sleep(8)
				del cast
				view(12,user) << sound('Audio/Soundeffects/Physical.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(14)
				del attack
			if(element=="Drain")
				var/obj/prop/Cast/Physical/cast=new
				var/obj/prop/Target/Drain/attack=new
				view(12,user) << sound('Audio/Soundeffects/Castmagic.wav',channel=3)
				sleep(5)
				cast.x=user.x
				cast.y=user.y
				cast.z=user.z
				sleep(8)
				del cast
				view(12,user) << sound('Audio/Soundeffects/General.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(14)
				del attack
			if(element=="Osmose")
				var/obj/prop/Cast/Physical/cast=new
				var/obj/prop/Target/Osmose/attack=new
				view(12,user) << sound('Audio/Soundeffects/Castmagic.wav',channel=3)
				sleep(5)
				cast.x=user.x
				cast.y=user.y
				cast.z=user.z
				sleep(8)
				del cast
				view(12,user) << sound('Audio/Soundeffects/General.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(14)
				del attack

		Playeranimation(var/mob/user,var/obj/npc/target,var/obj/perk/skill)
			set waitfor = FALSE
			var/element=skill.element
			if(element=="Death")
				var/obj/prop/Cast/Magic/cast=new
				var/obj/prop/Target/Dark/attack=new
				view(12,user) << sound('Audio/Soundeffects/Castmagic.wav',channel=3)
				sleep(5)
				cast.x=user.x
				cast.y=user.y
				cast.z=user.z
				sleep(8)
				del cast
				view(12,user) << sound('Audio/Soundeffects/Dark.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(10)
				del attack
			if(element=="Fire")
				var/obj/prop/Cast/Magic/cast=new
				var/obj/prop/Target/Fire/attack=new
				view(12,user) << sound('Audio/Soundeffects/Castmagic.wav',channel=3)
				sleep(5)
				cast.x=user.x
				cast.y=user.y
				cast.z=user.z
				sleep(8)
				del cast
				view(12,user) << sound('Audio/Soundeffects/Fire.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(10)
				del attack
			if(element=="Water")
				var/obj/prop/Cast/Magic/cast=new
				var/obj/prop/Target/Water/attack=new
				view(12,user) << sound('Audio/Soundeffects/Castmagic.wav',channel=3)
				sleep(5)
				cast.x=user.x
				cast.y=user.y
				cast.z=user.z
				sleep(8)
				del cast
				view(12,user) << sound('Audio/Soundeffects/Water.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(10)
				del attack
			if(element=="Thunder")
				var/obj/prop/Cast/Magic/cast=new
				var/obj/prop/Target/Thunder/attack=new
				view(12,user) << sound('Audio/Soundeffects/Castmagic.wav',channel=3)
				sleep(5)
				cast.x=user.x
				cast.y=user.y
				cast.z=user.z
				sleep(8)
				del cast
				view(12,user) << sound('Audio/Soundeffects/Thunder.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(10)
				del attack
			if(element=="Ice")
				var/obj/prop/Cast/Magic/cast=new
				var/obj/prop/Target/Ice/attack=new
				view(12,user) << sound('Audio/Soundeffects/Castmagic.wav',channel=3)
				sleep(5)
				cast.x=user.x
				cast.y=user.y
				cast.z=user.z
				sleep(8)
				del cast
				view(12,user) << sound('Audio/Soundeffects/Ice.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(10)
				del attack
			if(element=="Wind")
				var/obj/prop/Cast/Magic/cast=new
				var/obj/prop/Target/Wind/attack=new
				view(12,user) << sound('Audio/Soundeffects/Castmagic.wav',channel=3)
				sleep(5)
				cast.x=user.x
				cast.y=user.y
				cast.z=user.z
				sleep(8)
				del cast
				view(12,user) << sound('Audio/Soundeffects/Wind.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(10)
				del attack
			if(element=="Earth")
				var/obj/prop/Cast/Magic/cast=new
				var/obj/prop/Target/Earth/attack=new
				view(12,user) << sound('Audio/Soundeffects/Castmagic.wav',channel=3)
				sleep(5)
				cast.x=user.x
				cast.y=user.y
				cast.z=user.z
				sleep(8)
				del cast
				view(12,user) << sound('Audio/Soundeffects/Earth.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(10)
				del attack
			if(element=="General")
				var/obj/prop/Cast/Magic/cast=new
				var/obj/prop/Target/General/attack=new
				view(12,user) << sound('Audio/Soundeffects/Castmagic.wav',channel=3)
				sleep(5)
				cast.x=user.x
				cast.y=user.y
				cast.z=user.z
				sleep(8)
				del cast
				view(12,user) << sound('Audio/Soundeffects/General.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(10)
				del attack
			if(element=="Dark")
				var/obj/prop/Cast/Magic/cast=new
				var/obj/prop/Target/Dark/attack=new
				view(12,user) << sound('Audio/Soundeffects/Castmagic.wav',channel=3)
				sleep(5)
				cast.x=user.x
				cast.y=user.y
				cast.z=user.z
				sleep(8)
				del cast
				view(12,user) << sound('Audio/Soundeffects/Dark.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(10)
				del attack
			if(element=="Holy")
				var/obj/prop/Cast/Magic/cast=new
				var/obj/prop/Target/Holy/attack=new
				view(12,user) << sound('Audio/Soundeffects/Castmagic.wav',channel=3)
				sleep(5)
				cast.x=user.x
				cast.y=user.y
				cast.z=user.z
				sleep(8)
				del cast
				view(12,user) << sound('Audio/Soundeffects/Holy.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(10)
				del attack
			if(element=="Time")
				var/obj/prop/Cast/Magic/cast=new
				var/obj/prop/Target/Time/attack=new
				view(12,user) << sound('Audio/Soundeffects/Castmagic.wav',channel=3)
				sleep(5)
				cast.x=user.x
				cast.y=user.y
				cast.z=user.z
				sleep(8)
				del cast
				view(12,user) << sound('Audio/Soundeffects/Time.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(10)
				del attack
			if(element=="Physical")
				var/obj/prop/Cast/Physical/cast=new
				var/obj/prop/Target/Physical/attack=new
				view(12,user) << sound('Audio/Soundeffects/Castmagic.wav',channel=3)
				sleep(5)
				cast.x=user.x
				cast.y=user.y
				cast.z=user.z
				sleep(8)
				del cast
				view(12,user) << sound('Audio/Soundeffects/Physical.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(10)
				del attack
			if(element=="Heal")
				var/obj/prop/Cast/Heal/cast=new
				var/obj/prop/Target/Heal/attack=new
				view(12,user) << sound('Audio/Soundeffects/Castmagic.wav',channel=3)
				sleep(5)
				cast.x=user.x
				cast.y=user.y
				cast.z=user.z
				sleep(8)
				del cast
				view(12,user) << sound('Audio/Soundeffects/Heal.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(10)
				del attack
			if(element=="Bio")
				var/obj/prop/Cast/Magic/cast=new
				var/obj/prop/Target/Bio/attack=new
				view(12,user) << sound('Audio/Soundeffects/Castmagic.wav',channel=3)
				sleep(5)
				cast.x=user.x
				cast.y=user.y
				cast.z=user.z
				sleep(8)
				del cast
				view(12,user) << sound('Audio/Soundeffects/Bio.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(12)
				del attack
			if(element=="Robot")
				var/obj/prop/Cast/Magic/cast=new
				var/obj/prop/Target/Robot/attack=new
				view(12,user) << sound('Audio/Soundeffects/Castmagic.wav',channel=3)
				sleep(5)
				cast.x=user.x
				cast.y=user.y
				cast.z=user.z
				sleep(8)
				del cast
				view(12,user) << sound('Audio/Soundeffects/Robot.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(12)
				del attack
			if(element=="Metal")
				var/obj/prop/Cast/Magic/cast=new
				var/obj/prop/Target/Metal/attack=new
				view(12,user) << sound('Audio/Soundeffects/Castmagic.wav',channel=3)
				sleep(5)
				cast.x=user.x
				cast.y=user.y
				cast.z=user.z
				sleep(8)
				del cast
				view(12,user) << sound('Audio/Soundeffects/Physical.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(10)
				del attack
			if(element=="Laser")
				var/obj/prop/Cast/Magic/cast=new
				var/obj/prop/Target/Laser/attack=new
				view(12,user) << sound('Audio/Soundeffects/Castmagic.wav',channel=3)
				sleep(5)
				cast.x=user.x
				cast.y=user.y
				cast.z=user.z
				sleep(8)
				del cast
				view(12,user) << sound('Audio/Soundeffects/Laser.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(12)
				del attack
			if(element=="Nature")
				var/obj/prop/Cast/Magic/cast=new
				var/obj/prop/Target/Nature/attack=new
				view(12,user) << sound('Audio/Soundeffects/Castmagic.wav',channel=3)
				sleep(5)
				cast.x=user.x
				cast.y=user.y
				cast.z=user.z
				sleep(8)
				del cast
				view(12,user) << sound('Audio/Soundeffects/Nature.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(12)
				del attack
			if(element=="Flare")
				var/obj/prop/Cast/Magic/cast=new
				var/obj/prop/Target/Flare/attack=new
				view(12,user) << sound('Audio/Soundeffects/Castmagic.wav',channel=3)
				sleep(5)
				cast.x=user.x
				cast.y=user.y
				cast.z=user.z
				sleep(8)
				del cast
				view(12,user) << sound('Audio/Soundeffects/Flare.wav',channel=3)
				attack.pixel_x=-64
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(13)
				del attack
			if(element=="Comet")
				var/obj/prop/Cast/Magic/cast=new
				var/obj/prop/Target/Comet/attack=new
				view(12,user) << sound('Audio/Soundeffects/Castmagic.wav',channel=3)
				sleep(5)
				cast.x=user.x
				cast.y=user.y
				cast.z=user.z
				sleep(8)
				del cast
				view(12,user) << sound('Audio/Soundeffects/Comet.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(13)
				del attack
			if(element=="Ultima")
				var/obj/prop/Cast/Magic/cast=new
				var/obj/prop/Target/Ultima/attack=new
				view(12,user) << sound('Audio/Soundeffects/Castmagic.wav',channel=3)
				sleep(5)
				cast.x=user.x
				cast.y=user.y
				cast.z=user.z
				sleep(8)
				del cast
				view(12,user) << sound('Audio/Soundeffects/Ultima.wav',channel=3)
				attack.pixel_x=-64
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(22)
				del attack
			if(element=="Monk")
				var/obj/prop/Cast/Physical/cast=new
				var/obj/prop/Target/Monk/attack=new
				view(12,user) << sound('Audio/Soundeffects/Castmagic.wav',channel=3)
				sleep(5)
				cast.x=user.x
				cast.y=user.y
				cast.z=user.z
				sleep(8)
				del cast
				view(12,user) << sound('Audio/Soundeffects/Physical.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(14)
				del attack
			if(element=="Drain")
				var/obj/prop/Cast/Physical/cast=new
				var/obj/prop/Target/Drain/attack=new
				view(12,user) << sound('Audio/Soundeffects/Castmagic.wav',channel=3)
				sleep(5)
				cast.x=user.x
				cast.y=user.y
				cast.z=user.z
				sleep(8)
				del cast
				view(12,user) << sound('Audio/Soundeffects/General.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(14)
				del attack
			if(element=="Osmose")
				var/obj/prop/Cast/Physical/cast=new
				var/obj/prop/Target/Osmose/attack=new
				view(12,user) << sound('Audio/Soundeffects/Castmagic.wav',channel=3)
				sleep(5)
				cast.x=user.x
				cast.y=user.y
				cast.z=user.z
				sleep(8)
				del cast
				view(12,user) << sound('Audio/Soundeffects/General.wav',channel=3)
				attack.x=target.x
				attack.y=target.y
				attack.z=target.z
				sleep(14)
				del attack


obj
	prop
		Summon
		Evade
			pixel_x=-10
			pixel_y=-10
			layer=99
			icon='Icons/Animation/Evade.dmi'
		Death
			layer=99
			icon='Icons/Animation/Death.dmi'
		Cast
			layer=99
			Magic
				icon='Icons/Animation/Cast/Magic.dmi'
			Physical
				icon='Icons/Animation/Cast/Physicalcast.dmi'
			Heal
				icon='Icons/Animation/Cast/Healcast.dmi'
		Target
			layer=99
			Fire
				icon='Icons/Animation/Attack/Fire.dmi'
			Water
				icon='Icons/Animation/Attack/Water.dmi'
			Thunder
				icon='Icons/Animation/Attack/Thunder.dmi'
			Ice
				icon='Icons/Animation/Attack/Ice.dmi'
			Wind
				icon='Icons/Animation/Attack/Wind.dmi'
			Earth
				icon='Icons/Animation/Attack/Earth.dmi'
			General
				icon='Icons/Animation/Attack/Magic.dmi'
			Dark
				icon='Icons/Animation/Attack/Dark.dmi'
			Holy
				icon='Icons/Animation/Attack/Holy.dmi'
			Time
				icon='Icons/Animation/Attack/Time.dmi'
			Physical
				icon='Icons/Animation/Attack/Physical.dmi'
			Heal
				icon='Icons/Animation/Attack/Heal.dmi'
			Bio
				icon='Icons/Animation/Attack/Bio.dmi'
			Laser
				icon='Icons/Animation/Attack/Laser.dmi'
			Robot
				icon='Icons/Animation/Attack/Robot.dmi'
			Comet
				icon='Icons/Animation/Attack/Comet.dmi'
			Flare
				icon='Icons/Animation/Attack/Flare.dmi'
			Nature
				icon='Icons/Animation/Attack/Nature.dmi'
			Metal
				icon='Icons/Animation/Attack/Metal.dmi'
			Monk
				icon='Icons/Animation/Attack/Monk.dmi'
				pixel_x=10
			Ultima
				icon='Icons/Animation/Attack/Ultima.dmi'
				pixel_x=-32
			Drain
				pixel_x=-20
				icon='Icons/Animation/Attack/Drain.dmi'
			Osmose
				pixel_x=-20
				icon='Icons/Animation/Attack/Osmose.dmi'
