// todo: nuke this shit from orbit
/mob/proc/Refreshinventoryscreen()
	if(usr.intitlescreen)
		return
	var/row
	winset(src,"Inventoryscreen.Money","text=\"[src.money]\"")
	winset(src,"Inventoryscreen.gear","cells=0x0")
	for(var/obj/item/Weapon/A in src.contents)
		row++
		src<<output(A,"gear:1,[row]")
		winset(src,"InventoryScreen.gear","current-cell=2,[row]")
		if(A.equipped==1)
			src<<output("Equipped","InventoryScreen.gear")
		else
			src<<output("Unequipped","InventoryScreen.gear")
	for(var/obj/item/I in src.contents)
		if(istype(I, /obj/item/Weapon))
			continue
		if(istype(I, /obj/item/material))
			continue
		row++
		winset(src,"InventoryScreen.gear","current-cell=1,[row]")
		src<<output(I,"gear:1,[row]")

obj
	limitbreakaura
		icon='AuraKaiokenBig.dmi'
		icon_state="2"
		pixel_x=-30
atom
	proc
		look_at(var/obj/perk/M,var/mob/a)
			var/icon/I = icon(M.icon,"")
			var/newPicture = fcopy_rsc(I)
			winset(usr,"Perklook","is-visible=true")
			winset(usr,"Perklook.perkicon","image=\ref[newPicture]")
			winset(usr,"Perklook.name","text=\"[M.name]\"")
			winset(usr,"Perklook.desc","text=\"<p>[M.desc]</p>\"")
			winset(usr,"Perklook.rank","text=\"[M.rank]\"")
		look_atweapon(var/obj/item/Weapon/M,var/mob/a)
			if(M.jewelery==1 || M.armor==1)
				var/icon/I = icon(M.icon,"")
				var/newPicture = fcopy_rsc(I)
				winset(usr,"accessorylook","is-visible=true")
				winset(usr,"accessorylook.perkicon","image=\ref[newPicture]")
				winset(usr,"accessorylook.damage","text=\"Min damage:[M.range1+M.adddam] | Max damage: [M.range2+M.adddam]\"")
				winset(usr,"accessorylook.tohit","text=\"[M.addhit]\"")
				winset(usr,"accessorylook.lore","text=\"[M.lore]\"")
				winset(usr,"accessorylook.name","text=\"[M.name]\"")
				winset(usr,"accessorylook.metal","text=\"[M.weptier]\"")
				winset(usr,"accessorylook.desc","text=\"<p>[M.desc]</p>\"")
				winset(usr,"accessorylook.rank","text=\"[M.rank]\"")
				winset(usr,"accessorylook.type","text=\"[M.equiptype]\"")
				winset(usr,"accessorylook.enchantment","text=\"[M.enchantment]\"")
			else
				var/icon/I = icon(M.icon,"")
				var/newPicture = fcopy_rsc(I)
				winset(usr,"Weaponlook","is-visible=true")
				winset(usr,"Weaponlook.perkicon","image=\ref[newPicture]")
				winset(usr,"Weaponlook.damage","text=\"Min damage:[M.range1+M.adddam] | Max damage: [M.range2+M.adddam]\"")
				winset(usr,"Weaponlook.tohit","text=\"[M.addhit]\"")
				winset(usr,"Weaponlook.lore","text=\"[M.lore]\"")
				winset(usr,"Weaponlook.name","text=\"[M.name]\"")
				winset(usr,"Weaponlook.metal","text=\"[M.weptier]\"")
				winset(usr,"Weaponlook.desc","text=\"<p>[M.desc]</p>\"")
				winset(usr,"Weaponlook.rank","text=\"[M.rank]\"")
				winset(usr,"Weaponlook.type","text=\"[M.equiptype]\"")
				winset(usr,"Weaponlook.enchantment","text=\"[M.enchantment]\"")
		look_atchemistry(var/obj/item/Chemist/M,var/mob/a)
			var/icon/I = icon(M.icon,"")
			var/newPicture= fcopy_rsc(I)
			winset(usr,"accessorylook","is-visible=true")
			winset(usr,"accessorylook.perkicon","image=\ref[newPicture]")
			winset(usr,"accessorylook.damage","text=\"Min damage:[M.range1+M.adddam] | Max damage: [M.range2+M.adddam]\"")
			winset(usr,"accessorylook.lore","text=\"[M.lore]\"")
			winset(usr,"accessorylook.name","text=\"[M.name]\"")
			winset(usr,"accessorylook.desc","text=\"<p>[M.desc]</p>\"")
		look_materia(var/obj/item/Materia/M,var/mob/a)
			var/icon/I = icon(M.icon,"")
			var/newPicture = fcopy_rsc(I)
			winset(usr,"Perklook","is-visible=true")
			winset(usr,"Perklook.perkicon","image=\ref[newPicture]")
			winset(usr,"Perklook.name","text=\"[M.name]\"")
			winset(usr,"Perklook.desc","text=\"<p>[M.desc]</p>\"")
			winset(usr,"Perklook.rank","text=\"[M.rank]\"")


atom
	proc
		ShowHPBar(var/atom/b)
			for(var/obj/status/HPBar/a in b.contents)
				AdjustHPBar(a,b)
		ShowMPBar(var/atom/b)
			for(var/obj/status/MPBar/a in b.contents)
				AdjustMPBar(a,b)
		ShowSPBar(var/atom/b)
			for(var/obj/status/SPBar/a in b.contents)
				AdjustSPBar(a,b)
		HideHPBar(var/atom/b)
			for(var/obj/status/HPBar/a in b.contents)
				b.overlays-=a
		HideMPBar(var/atom/b)
			for(var/obj/status/MPBar/a in b.contents)
				b.overlays-=a
		HideSPBar(var/atom/b)
			for(var/obj/status/SPBar/a in b.contents)
				b.overlays-=a
obj
	proc
		getrollinfo(obj/item/Weapon/A, B, C, D, E)
			var/players
			players+= \
			{"<font color=#EC2323>[usr.name]'s roll receipt:  <a href="byond://?src=\ref[usr]&action3=rollread&value=\ref[src]&storedpab=\ref[usr.pab]&storedpdb=\ref[usr.pdb]&storedmab=\ref[usr.mab]&storedmdb=\ref[usr.mdb]&storedhitroll=\ref[B]&storeddamroll=\ref[C]&storeddamresult=\ref[E]&storedhitresult=\ref[D]&storedname=\ref[usr.name]">here.</a>
			"}
			view(usr)<<output("[players]","icout")
mob
	verb
		AddHPBar()
			for(var/obj/status/HPBar/a in usr.contents)
				AdjustHPBar(a,usr)
		AddMPBar()
			for(var/obj/status/MPBar/a in usr.contents)
				AdjustMPBar(a,usr)
		AddSPBar()
			for(var/obj/status/SPBar/a in usr.contents)
				AdjustSPBar(a,usr)
		LoseHPBar()
			for(var/obj/status/HPBar/a in usr.contents)
				usr.overlays-=a
		LoseMPBar()
			for(var/obj/status/MPBar/a in usr.contents)
				usr.overlays-=a
		LoseSPBar()
			for(var/obj/status/SPBar/a in usr.contents)
				usr.overlays-=a
		NPCHPMinus()
			var/b=usr.npcsheet
			ReduceNPCHP(b,usr)
			refreshnpcsheet(usr,b)

		NPCMPMinus()
			var/b=usr.npcsheet
			ReduceNPCMP(b,usr)
			refreshnpcsheet(usr,b)

		NPCSPMinus()
			var/b=usr.npcsheet
			ReduceNPCSP(b,usr)
			refreshnpcsheet(usr,b)

		NPCHPPlus()
			var/b=usr.npcsheet
			IncreaseNPCHP(b,usr)
			refreshnpcsheet(usr,b)

		NPCMPPlus()
			var/b=usr.npcsheet
			IncreaseNPCMP(b,usr)
			refreshnpcsheet(usr,b)

		NPCSPPlus()
			var/b=usr.npcsheet
			IncreaseNPCSP(b,usr)
			refreshnpcsheet(usr,b)

atom
	proc
		ReduceNPCHP(var/obj/npc/b,var/mob/m)
			var/decrease = input("HP Reduction.") as null|num
			var/check=b.hp-decrease
			if(check < 0)
				b.hp=0
				view(b)<<output("<font color=[b.textcolor]><b>[b.name]</b><font color=white> has taken <b><font color=red>[decrease]</b></font> damage!","oocout")
			else
				b.hp-=decrease
				view(b)<<output("<font color=[b.textcolor]><b>[b.name]</b><font color=white> has taken <b><font color=red>[decrease]</b></font> damage!","oocout")
				view(b)<<output("<font color=[b.textcolor]><b>[b.name]</b><font color=white> is now at <font color=#60F570><b>[b.hp] / [b.mhp]</font> HP!!","oocout")
			if(b.hp==0)
				view(b)<<output("<b><font color=[b.textcolor]>[b.name]</font> has been reduced to 0 HP, and is now considered <font color=red><b>KOed</b></font>!!","oocout")
			refreshnpcsheet(m,b)
			ShowHPBar(b)


		ReduceNPCMP(var/obj/npc/b,var/mob/m)
			var/decrease = input("MP Reduction.") as null|num
			var/check=b.mp-decrease
			if(check < 0)
				b.mp=0
				view(b)<<output("<font color=[b.textcolor]><b>[b.name]</b><font color=white> has drained <b><font color=red>[decrease]</b></font> MP!","oocout")
			else
				b.mp-=decrease
				view(b)<<output("<font color=[b.textcolor]><b>[b.name]</b><font color=white> has drained <b><font color=red>[decrease]</b></font> MP!","oocout")
				view(b)<<output("<font color=[b.textcolor]><b>[b.name]</b><font color=white> is now at <font color=#60F570><b>[b.mp] / [b.mmp]</font> MP!!","oocout")
			if(b.mp==0)
				view(b)<<output("<b><font color=[b.textcolor]><b>[b.name]</b></font> has been reduced to 0 MP, and now has <font color=red><b>1 additional static stack of exhaustion</b></font> until it raises above 0</font>!!","oocout")
			refreshnpcsheet(m,b)
			ShowMPBar(b)

		ReduceNPCSP(var/obj/npc/b,var/mob/m)
			var/decrease = input("SP Reduction.") as null|num
			var/check=b.sp-decrease
			if(check < 0)
				b.sp=0
				view(b)<<output("<font color=[b.textcolor]><b>[b.name]</b><font color=white> has drained <b><font color=red>[decrease]</b></font> SP!","oocout")
			else
				b.sp-=decrease
				view(b)<<output("<font color=[b.textcolor]><b>[b.name]</b><font color=white> has drained <b><font color=red>[decrease]</b></font> SP!","oocout")
				view(b)<<output("<font color=[b.textcolor]><b>[b.name]</b><font color=white> is now at <font color=#60F570><b>[b.sp] / [b.msp]</font> SP!!","oocout")
			if(b.sp==0)
				view(b)<<output("<b><font color=[b.textcolor]><b>[b.name]</font> has been reduced to 0 SP, and now has <font color=red><b>1 additional static stack of exhaustion</b></font> until it raises above 0</font>!!","oocout")
			refreshnpcsheet(m,b)
			ShowSPBar(b)

		IncreaseNPCHP(var/obj/npc/b,var/mob/m)
			var/increase = input("HP Increase.") as null|num
			var/overflowed
			if(increase >= b.mhp)
				overflowed = b.mhp - b.hp
				b.hp=b.mhp
				view(b)<<output("<font color=[b.textcolor]><b>[b.name]</b><font color=white> has been restored by <b><font color=#60F570>[overflowed] HP!","oocout")
			else
				b.hp+=increase
				view(b)<<output("<font color=[b.textcolor]><b>[b.name]</b><font color=white> has been restored by <b><font color=#60F570>[increase] HP!","oocout")
			if(b.hp>=b.mhp)
				view(b)<<output("<b><font color=[b.textcolor]><b>[b.name]</font> has reached max HP!","oocout")
				b.hp=b.mhp
			view(b)<<output("<font color=[b.textcolor]><b>[b.name]</b><font color=white> is now at <font color=#60F570><b>[b.hp] / [b.mhp]</font> HP!!","oocout")
			refreshnpcsheet(m,b)
			ShowHPBar(b)

		IncreaseNPCMP(var/obj/npc/b,var/mob/m)
			var/increase = input("MP Increase.") as null|num
			var/overflowed
			if(increase >= b.mmp)
				overflowed = b.mmp - b.mp
				b.mp=b.mmp
				view(b)<<output("<font color=[b.textcolor]><b>[b.name]</b><font color=white> has been restored by <b><font color=#60F5E5>[overflowed] MP!","oocout")
			else
				b.mp+=increase
				view(b)<<output("<font color=[b.textcolor]><b>[b.name]</b><font color=white> has been restored by <b><font color=#2AF0DB>[increase] MP!","oocout")
			if(b.mp>=b.mmp)
				view(b)<<output("<b><font color=[b.textcolor]><b>[b.name][b]</font> has reached max MP!","oocout")
				b.mp=b.mmp
			view(b)<<output("<font color=[b.textcolor]><b>[b.name]</b><font color=white> is now at <font color=#2AF0DB><b>[b.mp] / [b.mmp]</font> MP!!","oocout")
			refreshnpcsheet(m,b)
			ShowMPBar(b)

		IncreaseNPCSP(var/obj/npc/b,var/mob/m)
			var/increase = input("SP Increase.") as null|num
			var/overflowed
			if(increase >= b.mmp)
				overflowed = b.msp - b.sp
				b.sp=b.msp
				view(b)<<output("<font color=[b.textcolor]><b>[b.name]</b><font color=white> has been restored by <b><font color=#F8F475>[overflowed] SP!","oocout")
			else
				b.sp+=increase
				view(b)<<output("<font color=[b.textcolor]><b>[b.name]</b><font color=white> has been restored by <b><font color=#F8F475>[increase] SP!","oocout")
			if(b.sp>=b.msp)
				view(b)<<output("<b><font color=[b.textcolor]><b>[b.name]</font> has reached max SP!","oocout")
				b.sp=b.msp
			view(b)<<output("<font color=[b.textcolor]><b>[b.name]</b><font color=white> is now at <font color=#F8F475><b>[b.sp] / [b.msp]</font> SP!!","oocout")
			refreshnpcsheet(m,b)
			ShowSPBar(b)
mob
	verb
//NPCHPSPandMP
		ReduceHP()
			if(usr.battler==1)
				return
			else
				var/decrease = input("HP Reduction.") as null|num
				var/check=usr.hp-decrease
				if(check < 0)
					usr.hp=0
					view(usr)<<output("<font color=[usr.textcolor]><b>[usr]</b><font color=white> has taken <b><font color=red>[decrease]</b></font> damage!","oocout")
				else
					usr.hp-=decrease
					view(usr)<<output("<font color=[usr.textcolor]><b>[usr]</b><font color=white> has taken <b><font color=red>[decrease]</b></font> damage!","oocout")
					view(usr)<<output("<font color=[usr.textcolor]><b>[usr]</b><font color=white> is now at <font color=#60F570><b>[usr.hp] / [usr.mhp]</font> HP!!","oocout")
				if(usr.hp==0)
					view(usr)<<output("<b><font color=[usr.textcolor][usr]></font> has been reduced to 0 HP, and is now considered <font color=red><b>KOed</b></font>!!","oocout")
				UpdateResources()
				ShowHPBar(usr)


		ReduceMP()
			if(usr.battler==1)
				return
			else
				var/decrease = input("MP Reduction.") as null|num
				var/check=usr.mp-decrease
				if(check < 0)
					usr.mp=0
					view(usr)<<output("<font color=[usr.textcolor]><b>[usr]</b><font color=white> has drained <b><font color=red>[decrease]</b></font> MP!","oocout")
				else
					usr.mp-=decrease
					view(usr)<<output("<font color=[usr.textcolor]><b>[usr]</b><font color=white> has drained <b><font color=red>[decrease]</b></font> MP!","oocout")
					view(usr)<<output("<font color=[usr.textcolor]><b>[usr]</b><font color=white> is now at <font color=#60F570><b>[usr.mp] / [usr.mmp]</font> MP!!","oocout")
				if(usr.mp==0)
					view(usr)<<output("<b><font color=[usr.textcolor]>[usr]</font> has been reduced to 0 MP, and now has <font color=red><b>1 additional static stack of exhaustion</b></font> until it raises above 0</font>!!","oocout")
				UpdateResources()
				ShowMPBar(usr)

		ReduceSP()
			if(usr.battler==1)
				return
			else
				var/decrease = input("SP Reduction.") as null|num
				var/check=usr.sp-decrease
				if(check < 0)
					usr.sp=0
					view(usr)<<output("<font color=[usr.textcolor]><b>[usr]</b><font color=white> has drained <b><font color=red>[decrease]</b></font> SP!","oocout")
				else
					usr.sp-=decrease
					view(usr)<<output("<font color=[usr.textcolor]><b>[usr]</b><font color=white> has drained <b><font color=red>[decrease]</b></font> SP!","oocout")
					view(usr)<<output("<font color=[usr.textcolor]><b>[usr]</b><font color=white> is now at <font color=#60F570><b>[usr.sp] / [usr.msp]</font> SP!!","oocout")
				if(usr.sp==0)
					view(usr)<<output("<b><font color=[usr.textcolor]>[usr]</font> has been reduced to 0 SP, and now has <font color=red><b>1 additional static stack of exhaustion</b></font> until it raises above 0</font>!!","oocout")
				UpdateResources()
				ShowSPBar(usr)

		IncreaseHP()
			if(usr.battler==1)
				return
			else
				var/increase = input("HP Increase.") as null|num
				var/overflowed
				if(increase >= usr.mhp)
					overflowed = usr.mhp - usr.hp
					usr.hp=usr.mhp
					view(usr)<<output("<font color=[usr.textcolor]>[usr]</b><font color=white> has been restored by <b><font color=#60F570>[overflowed] HP!","oocout")
				else
					usr.hp+=increase
					view(usr)<<output("<font color=[usr.textcolor]>[usr]</b><font color=white> has been restored by <b><font color=#60F570>[increase] HP!","oocout")
				if(usr.hp>=usr.mhp)
					view(usr)<<output("<b><font color=[usr.textcolor]>[usr]</font> has reached max HP!","oocout")
					usr.hp=usr.mhp
				view(usr)<<output("<font color=[usr.textcolor]><b>[usr]</b><font color=white> is now at <font color=#60F570><b>[usr.hp] / [usr.mhp]</font> HP!!","oocout")
				UpdateResources()
				ShowHPBar(usr)

		IncreaseMP()
			if(usr.battler==1)
				return
			else
				var/increase = input("MP Increase.") as null|num
				var/overflowed
				if(increase >= usr.mmp)
					overflowed = usr.mmp - usr.mp
					usr.mp=usr.mmp
					view(usr)<<output("<font color=[usr.textcolor]>[usr]</b><font color=white> has been restored by <b><font color=#60F5E5>[overflowed] MP!","oocout")
				else
					usr.mp+=increase
					view(usr)<<output("<font color=[usr.textcolor]>[usr]</b><font color=white> has been restored by <b><font color=#2AF0DB>[increase] MP!","oocout")
				if(usr.mp>=usr.mmp)
					view(usr)<<output("<b><font color=[usr.textcolor]>[usr]</font> has reached max MP!","oocout")
					usr.mp=usr.mmp
				view(usr)<<output("<font color=[usr.textcolor]><b>[usr]</b><font color=white> is now at <font color=#2AF0DB><b>[usr.mp] / [usr.mmp]</font> MP!!","oocout")
				UpdateResources()
				ShowMPBar(usr)

		IncreaseSP()
			if(usr.battler==1)
				return
			else
				var/increase = input("SP Increase.") as null|num
				var/overflowed
				if(increase >= usr.mmp)
					overflowed = usr.msp - usr.sp
					usr.sp=usr.msp
					view(usr)<<output("<font color=[usr.textcolor]>[usr]</b><font color=white> has been restored by <b><font color=#F8F475>[overflowed] SP!","oocout")
				else
					usr.sp+=increase
					view(usr)<<output("<font color=[usr.textcolor]>[usr]</b><font color=white> has been restored by <b><font color=#F8F475>[increase] SP!","oocout")
				if(usr.sp>=usr.msp)
					view(usr)<<output("<b><font color=[usr.textcolor]>[usr]</font> has reached max SP!","oocout")
					usr.sp=usr.msp
				view(usr)<<output("<font color=[usr.textcolor]><b>[usr]</b><font color=white> is now at <font color=#F8F475><b>[usr.sp] / [usr.msp]</font> SP!!","oocout")
				UpdateResources()
				ShowSPBar(usr)

		UpdateResources()
			var/mob/M
			if(usr.viewing)
				M = usr.target
			else
				M = usr
			winset(usr,"Charsheet.HP","text=\"[M.hp]/[M.mhp]\"")
			winset(usr,"Charsheet.MP","text=\"[M.mp]/[M.mmp]\"")
			winset(usr,"Charsheet.SP","text=\"[M.sp]/[M.msp]\"")

		Rollsheet()
			set hidden = 1
			if(usr.intitlescreen)
				return
			usr.Skillcheck(usr)
			usr.Carrycheck(usr)
			usr.Savecheck(usr)
			usr.ACcheck(usr)
			usr.RefreshCharsheet(usr)
			var/winpos = winget(usr,"Profile","pos")
			winset(usr,"CharSheet","is-visible=false")
			winset(usr,"Perksheet","is-visible=false")
			winset(usr,"Rollsheet","is-visible=true")
			winset(usr,"Rollsheet","pos=[winpos]")
			winset(usr,"Rollsheet.acrobatics","text=\"Acrobatics:[usr.acrobatics]\"")
			winset(usr,"Rollsheet.athletics","text=\"Athletics:[usr.athletics]\"")
			winset(usr,"Rollsheet.archaeology","text=\"Archaeology:[usr.archaeology]\"")
			winset(usr,"Rollsheet.deception","text=\"Deception:[usr.deception]\"")
			winset(usr,"Rollsheet.dungeoneering","text=\"Dungeoneering:[usr.dungeoneering]\"")
			winset(usr,"Rollsheet.enchantment","text=\"Enchantment:[usr.enchantment]\"")
			winset(usr,"Rollsheet.insight","text=\"Insight:[usr.insight]\"")
			winset(usr,"Rollsheet.investigation","text=\"Investigation:[usr.investigation]\"")
			winset(usr,"Rollsheet.magic","text=\"Magic:[usr.magic]\"")
			winset(usr,"Rollsheet.magiop","text=\"Magitek Operation:[usr.magitekOperation]\"")
			winset(usr,"Rollsheet.medicine","text=\"Medicine:[usr.medicine]\"")
			winset(usr,"Rollsheet.naturalist","text=\"Naturalist:[usr.naturalist]\"")
			winset(usr,"Rollsheet.perception","text=\"Perception:[usr.perception]\"")
			winset(usr,"Rollsheet.persuasion","text=\"Persuasion:[usr.persuasion]\"")
			winset(usr,"Rollsheet.stealth","text=\"Stealth:[usr.stealth]\"")
			winset(usr,"Rollsheet.survival","text=\"Survival:[usr.survival]\"")
			winset(usr,"Rollsheet.thievery","text=\"Thievery:[usr.thievery]\"")
			winset(usr,"Rollsheet.Rflx","text=\"Reflex:[usr.rflx]\"")
			winset(usr,"Rollsheet.Fort","text=\"Fortitude:[usr.fort]\"")
			winset(usr,"Rollsheet.Will","text=\"Will:[usr.will]\"")
		Charsheet()
			set hidden = 1
			if(usr.intitlescreen)
				return
			usr.Skillcheck(usr)
			usr.Carrycheck(usr)
			usr.Savecheck(usr)
			usr.ACcheck(usr)
			usr.RefreshCharsheet(usr)
			var/row
			var/winpos = winget(usr,"Profile","pos")
			winset(usr,"Profile","is-visible=false")
			winset(usr,"Rollsheet","is-visible=false")
			winset(usr,"Perksheet","is-visible=false")
			winset(usr,"CharSheet","is-visible=true")
			winset(usr,"CharSheet","pos=[winpos]")
			var/mob/M
			if(usr.viewing)
				M = usr.target
			else
				M = usr
			winset(usr,"CharSheet.Nameplate","text=\"[usr.name]\"")
			winset(usr,"CharSheet.str","text=\"[M.str]+[M.addstr]/[M.strmod]\"")
			winset(usr,"CharSheet.dex","text=\"[M.dex]+[M.adddex]/[M.dexmod]\"")
			winset(usr,"CharSheet.con","text=\"[M.con]+[M.addcon]/[M.conmod]\"")
			winset(usr,"CharSheet.int","text=\"[M.int]+[M.addint]/[M.intmod]\"")
			winset(usr,"CharSheet.wis","text=\"[M.wis]+[M.addwis]/[M.wismod]\"")
			winset(usr,"CharSheet.cha","text=\"[M.cha]+[M.addcha]/[M.chamod]\"")
			winset(usr,"Charsheet.RPP","text=\"[M.rpp]/[M.trpp]\"")
			winset(usr,"Charsheet.HP","text=\"[M.hp]/[M.mhp]\"")
			winset(usr,"Charsheet.MP","text=\"[M.mp]/[M.mmp]\"")
			winset(usr,"Charsheet.SP","text=\"[M.sp]/[M.msp]\"")
			winset(usr,"Charsheet.Race","text=\"Race: [M.race]\"")
			winset(usr,"Charsheet.Job","text=\"Job: [M.job]\"")
			winset(usr,"Charsheet.Subjob","text=\"Subjob: [M.subjob]\"")
			winset(usr,"Charsheet.ajob","text=\"[M.ajob]\"")
			winset(usr,"Charsheet.role","text=\"Role: [M.role]\"")
			winset(usr,"Charsheet.rank","text=\"Rank: [M.rank]\"")
			winset(usr,"Charsheet.rankbonus","text=\"Rank Bonus: [M.rankbonus]\"")
			winset(usr,"Charsheet.AC","text=\"[M.ac]\"")
			winset(usr,"Charsheet.DR","text=\"[M.basedr+M.conmod]\"")
			winset(usr,"Charsheet.SPD","text=\"[M.speed]+[M.speedadd]\"")
			winset(usr,"Charsheet.pab","text=\"[M.pab]+[M.pabadd]\"")
			winset(usr,"Charsheet.pdb","text=\"[M.pdb]+[M.pdbadd]\"")
			winset(usr,"Charsheet.mab","text=\"[M.mab]+[M.mabadd]\"")
			winset(usr,"Charsheet.mdb","text=\"[M.mdb]+[M.mdbadd]\"")
			winset(usr,"Charsheet.ap","text=\"[M.abilitypoints]\"")
			winset(usr,"Charsheet.materiagrid","cells=0x0")
			for(var/obj/item/Materia/C in usr.contents)
				if(C.equipped==1)
					row++
					usr<<output(C,"materiagrid:1,[row]")

		Editsheet()
			set hidden = 1
			if(usr.intitlescreen)
				return
			winset(usr,"Charsheet.strplus","is-visible=true")
			winset(usr,"Charsheet.dexplus","is-visible=true")
			winset(usr,"Charsheet.conplus","is-visible=true")
			winset(usr,"Charsheet.intplus","is-visible=true")
			winset(usr,"Charsheet.wisplus","is-visible=true")
			winset(usr,"Charsheet.chaplus","is-visible=true")

		Closecharsheet()
			set hidden = 1
			if(usr.intitlescreen)
				return
			winset(usr,"Charsheet.addstr","is-visible=false")
			winset(usr,"Charsheet.adddex","is-visible=false")
			winset(usr,"Charsheet.addcon","is-visible=false")
			winset(usr,"Charsheet.addint","is-visible=false")
			winset(usr,"Charsheet.addwis","is-visible=false")
			winset(usr,"Charsheet.addcha","is-visible=false")
			winset(usr,"Rollsheet","is-visible=false")
			winset(usr,"Perksheet","is-visible=false")
			winset(usr,"Profile.Edit1","is-visible=false")
			winset(usr,"Profile.Edit2","is-visible=false")
			usr.editing = 0
			usr.viewing = null
			usr.target = null
			usr.npcsheet = null

		Perksheet()
			if(usr.intitlescreen)
				return
			var/row
			var/row2
			var/row3
			var/row4
			winset(usr,"Rollsheet","is-visible=false")
			winset(usr,"Perksheet","is-visible=true")
			winset(usr,"CharSheet","is-visible=false")
			winset(usr,"Perksheet.weapongrid","cells=0x0")
			winset(usr,"Perksheet.jobgrid","cells=0x0")
			winset(usr,"Perksheet.generalgrid","cells=0x0")
			winset(usr,"Perksheet.spellgrid","cells=0x0")
			for(var/obj/perk/A in usr.contents)
				if(A.ptype=="general")
					row++
					usr<<output(A,"generalgrid:1,[row]")
			for(var/obj/perk/B in usr.contents)
				if(B.ptype=="job")
					row2++
					usr<<output(B,"jobgrid:1,[row2]")
			for(var/obj/perk/F in usr.contents)
				if(F.cat=="Unique" && F.ability==0 && F.ptype!="job")
					row2++
					usr<<output(F,"jobgrid:1,[row2]")
			for(var/obj/perk/C in usr.contents)
				if(C.ability==1)
					row3++
					usr<<output(C,"spellgrid:1,[row3]")
			for(var/obj/item/D in usr.contents)
				if(D.weapon==1)
					row4++
					winset(usr,"weapongrid","current-cell=1,[row4]")
					usr<<output(D,"weapongrid:1,[row4]")
					winset(usr,"weapongrid","current-cell=2,[row4]")
					if(D.equipped==1)
						usr<<output("Equipped","weapongrid")
					else
						usr<<output("Unequipped","weapongrid")
		InventoryScreen()
			winset(usr,"Inventoryscreen","is-visible=true")
			usr.Refreshinventoryscreen()
		Materiawindow()
			if(usr.intitlescreen)
				return
			var/row
			var/row2
			var/row3
			var/row4
			var/row5
			winset(usr,"Materiascreen","is-visible=true")
			winset(usr,"Materiascreen.mslot1","cells=0x0")
			winset(usr,"Materiascreen.slot2","cells=0x0")
			winset(usr,"Materiascreen.slot3","cells=0x0")
			winset(usr,"Materiascreen.unequipped","cells=0x0")
			winset(usr,"Materiascreen.equipped","cells=0x0")
			for(var/obj/item/Materia/A in usr.contents)
				if(A==usr.materia1)
					row++
					usr<<output(A,"mslot1:1,[row]")
				if(A==usr.materia2)
					row2++
					usr<<output(A,"slot2:1,[row2]")
				if(A==usr.materia3)
					row3++
					usr<<output(A,"slot3:1,[row3]")
				if(A.equipped==1)
					row4++
					usr<<output(A,"equipped:1,[row4]")
				if(A.equipped==0)
					row5++
					usr<<output(A,"unequipped:1,[row5]")
		Limitbreak()
			if(usr.intitlescreen)
				return
			if(!usr.limitbreak)
				var/list/techs=new
				for(var/obj/perk/p in usr.contents)
					if(p.ability==1)
						techs+=p
				var/obj/choice = input("What technique do you wish to set as your limit break?") as null|anything in techs
				usr.limitbreak = choice
				var/image/i = choice.icon
				winset(usr,"Charsheet.lb","image=[i]")
			else if(usr.limitbreak)
				var/limitable=usr.mhp*0.5
				switch(alert("What do you wish to do?",,"Limit Break","Change","Cancel"))
					if("Limit Break")
						if(usr.hp>limitable)
							alert(usr,"You can only use Limitbreak when below 50% HP!")
							return
						if(usr.limitbreakused)
							alert("You have already used your limit break for the day.")
						else
							var/obj/limitbreakaura/a = new
							usr.overlays+=a
							view()<<'Audio/Limit Break.ogg'
							sleep(20)
							usr.overlays-=a
							Limitbreakcalc(usr,usr.limitbreak)
							usr.limitbreakused=1
					if("Change")
						var/list/techs2=new
						for(var/obj/perk/p in usr.contents)
							if(p.technique)
								techs2+=p
						var/obj/choice2 = input("What technique do you wish to set as your limit break?") as null|anything in techs2
						usr.limitbreak = choice2
						var/image/i2=choice2.icon
						winset(usr,"Charsheet.lb","image=[i2]")
					if("Cancel")
						return

		ShowAC()
			if(usr.intitlescreen)
				return
			if(!npcsheet)
				view() << output("<font size=1><font color=[usr.textcolor]>[usr.name] flashes their AC showing a base Armor Class of [usr.ac]</font>","icout")
			else
				var/obj/npc/n = npcsheet
				view() << output("<font size=1><font color=#ffff99>[n.name] flashes their AC showing a base Armor Class of [n.baseac]</font>","icout")

		ShowDR()
			if(usr.intitlescreen)
				return
			if(!npcsheet)
				view() << output("<font size=1><font color=[usr.textcolor]>[usr.name] flashes their DR showing a base Damage Reduction of [usr.basedr+usr.conmod]</font>","icout")
			else
				var/obj/npc/n = npcsheet
				view() << output("<font size=1><font color=#ffff99>[n.name] flashes their DR showing a base Damage Reduction of [n.basedr+n.conmod]</font>","icout")
		ShowSpeed()
			if(usr.intitlescreen)
				return
			if(!npcsheet)
				view() << output("<font size=1><font color=[usr.textcolor]>[usr.name] flashes their Speed showing a base Tile Movement of [usr.speed+usr.speedadd]</font>","icout")
			else
				var/obj/npc/n = npcsheet
				view() << output("<font size=1><font color=#ffff99>[n.name] flashes their Speed showing a base Tile Movement of [n.speed]</font>","icout")

		AdvantageToggle()
			if(usr.intitlescreen)
				return
			if(advantage)
				advantage=0
			else
				advantage=1
				disadvantage=0
				winset(usr,"CharSheet.distog","is-checked=false")
		DisadvantageToggle()
			if(usr.intitlescreen)
				return
			if(disadvantage)
				disadvantage=0
			else
				disadvantage=1
				advantage=0
				winset(usr,"CharSheet.advtog","is-checked=false")

		Spendpoints()
			if(usr.intitlescreen)
				return
			winset(usr,"Charsheet.addstr","is-visible=true")
			winset(usr,"Charsheet.adddex","is-visible=true")
			winset(usr,"Charsheet.addcon","is-visible=true")
			winset(usr,"Charsheet.addint","is-visible=true")
			winset(usr,"Charsheet.addwis","is-visible=true")
			winset(usr,"Charsheet.addcha","is-visible=true")

			if(usr.APspent==9000)//This is a data migration that will be temporary. After we test it and it goes live for an update or two, we can remove it.
				usr.APspent=0
				usr.str=10
				usr.con=10
				usr.dex=10
				usr.wis=10
				usr.cha=10
				usr.int=10
				usr.abilitypoints=10+((usr.rankbonus-1)*4)
				for(var/obj/perk/p in usr.contents)
					if(p.name=="Mako Affected")
						usr.str+=2
						usr.con+=2
						usr.dex+=2
					if(p.name=="Aether Affected")
						usr.wis+=2
						usr.cha+=2
						usr.int+=2
					if(p.name=="Mako Poisoning")
						usr.str+=0
						usr.con-=0
						usr.dex+=0
					if(p.name=="Harbinger of Chaos")
						usr.str+=2
						usr.con+=2
						usr.dex+=2
						usr.wis+=2
						usr.cha+=2
						usr.int+=2
					if(p.name=="Embodiment of Sin")
						usr.str+=2
						usr.con+=2
						usr.dex+=2
						usr.wis+=2
						usr.cha+=2
						usr.int+=2
					if(p.name=="L'cie (Job)")
						usr.str+=2
						usr.con+=2
						usr.dex+=2
						usr.wis+=2
						usr.cha+=2
						usr.int+=2
					if(p.name=="Imperfect Jenova Cells")
						usr.str+=4
						usr.con+=2
						usr.dex+=4
					if(p.name=="Perfect Jenova Cells")
						usr.str+=4
						usr.con+=4
						usr.dex+=4
					if(p.name=="Summoner of Yevon")
						usr.wis+=4
						usr.cha+=4
						usr.int+=4
					if(p.name=="Guado Physiology")
						usr.wis+=2
					if(p.name=="Elezen Physiology")
						usr.dex+=2
					if(p.name=="Roegadyn Strength")
						usr.str+=2
					if(p.name=="Layered Muscle")
						usr.str+=2
					if(p.name=="The Big One's Wisdom")
						usr.wis+=2
					if(p.name=="Pint Size")
						usr.wis+=2
					if(p.name=="Lifestream Conneciton")
						usr.str+=2
						usr.con+=2
						usr.dex+=2
					if(p.name=="Aether Connection")
						usr.wis+=2
						usr.cha+=2
						usr.int+=2
					if(p.name=="Pure Red Mage")
						usr.abilitypoints+=2
						usr.APspent -= 2
					if(p.name=="Red Empowerment")
						usr.abilitypoints+=2
						usr.APspent -= 2
					if(p.name=="Appointed Guardian")
						usr.abilitypoints+=2
						usr.APspent -= 2
					if(p.name=="Machinist")
						usr.int+=2

			else
				usr.APcap=10+((usr.rankbonus-1)*4)
				usr.abilitypoints= usr.APcap-usr.APspent

			// if(usr.str>usr.strcap)
			// 	usr.abilitypoints+=(usr.str-usr.strcap)
			// 	usr.APspent-=(usr.str-usr.strcap)
			// 	usr.str=usr.strcap
			// 	usr.Checkmod(1,usr.str,usr.addstr,usr)
			// if(usr.dex>usr.dexcap)
			// 	usr.abilitypoints+=(usr.dex-usr.dexcap)
			// 	usr.APspent-=(usr.dex-usr.dexcap)
			// 	usr.dex=usr.dexcap
			// 	usr.Checkmod(2,usr.dex,usr.adddex,usr)
			// if(usr.con>usr.concap)
			// 	usr.abilitypoints+=(usr.con-usr.concap)
			// 	usr.APspent-=(usr.con-usr.concap)
			// 	usr.con=usr.concap
			// 	usr.Checkmod(3,usr.con,usr.addcon,usr)
			// if(usr.int>usr.intcap)
			// 	usr.abilitypoints+=(usr.int-usr.intcap)
			// 	usr.APspent-=(usr.int-usr.intcap)
			// 	usr.int=usr.intcap
			// 	usr.Checkmod(4,usr.int,usr.addint,usr)
			// if(usr.wis>usr.wiscap)
			// 	usr.abilitypoints+=(usr.wis-usr.wiscap)
			// 	usr.APspent-=(usr.wis-usr.wiscap)
			// 	usr.wis=usr.wiscap
			// 	usr.Checkmod(5,usr.wis,usr.addwis,usr)
			// if(usr.cha>usr.chacap)
			// 	usr.abilitypoints+=(usr.cha-usr.chacap)
			// 	usr.APspent-=(usr.cha-usr.chacap)
			// 	usr.cha=usr.chacap
			// 	usr.Checkmod(6,usr.cha,usr.addcha,usr)
			RefreshCharsheet(usr)


		Addstrc()
			if(usr.intitlescreen)
				return
			if(usr.abilitypoints>0)
				// if(usr.str>=usr.strcap)
				// 	alert("You cannot increase your stat any higher right now.")
				// 	return
				usr.str++
				usr.APspent++
				usr.abilitypoints--
				usr.Checkmod(1,usr.str,usr.addstr,usr)
				RefreshCharsheet(usr)
			else
				alert("You don't have any points to spend.")
		Adddexc()
			if(usr.intitlescreen)
				return
			if(usr.abilitypoints>0)
				// if(usr.dex>=usr.dexcap)
				// 	alert("You cannot increase your stat any higher right now.")
				// 	return
				usr.dex++
				usr.APspent++
				usr.abilitypoints--
				usr.Checkmod(2,usr.dex,usr.adddex,usr)
				RefreshCharsheet(usr)
			else
				alert("You don't have any points to spend.")
		Addconc()
			if(usr.intitlescreen)
				return
			if(usr.abilitypoints>0)
				// if(usr.con>=usr.concap)
				// 	alert("You cannot increase your stat any higher right now.")
				// 	return
				usr.con++
				usr.APspent++
				usr.abilitypoints--
				usr.Checkmod(3,usr.con,usr.addcon,usr)
				RefreshCharsheet(usr)
			else
				alert("You don't have any points to spend.")
		Addintc()
			if(usr.intitlescreen)
				return
			if(usr.abilitypoints>0)
				// if(usr.int>=usr.intcap)
				// 	alert("You cannot increase your stat any higher right now.")
				// 	return
				usr.int++
				usr.APspent++
				usr.abilitypoints--
				usr.Checkmod(4,usr.int,usr.addint,usr)
				RefreshCharsheet(usr)
			else
				alert("You don't have any points to spend.")
		Addwisc()
			if(usr.intitlescreen)
				return
			if(usr.abilitypoints>0)
				// if(usr.wis>=usr.wiscap)
				// 	alert("You cannot increase your stat any higher right now.")
				// 	return
				usr.wis++
				usr.APspent++
				usr.abilitypoints--
				usr.Checkmod(5,usr.wis,usr.addwis,usr)
				RefreshCharsheet(usr)
			else
				alert("You don't have any points to spend.")
		Addchac()
			if(usr.intitlescreen)
				return
			if(usr.abilitypoints>0)
				// if(usr.cha>=usr.chacap)
				// 	alert("You cannot increase your stat any higher right now.")
				// 	return
				usr.cha++
				usr.APspent++
				usr.abilitypoints--
				usr.Checkmod(6,usr.cha,usr.addcha,usr)
				RefreshCharsheet(usr)
			else
				alert("You don't have any points to spend.")


		Rollstr()
			set hidden = 1
			if(usr.intitlescreen)
				return
			if(!npcsheet)
				usr.statroll(usr.strmod,"Strength Roll")
			else
				var/obj/npc/n = npcsheet
				usr.statroll(n.strmod,"Strength Roll",n.name)

		Rolldex()
			set hidden = 1
			if(usr.intitlescreen)
				return
			if(!npcsheet)
				usr.statroll(usr.dexmod,"Dexterity Roll")
			else
				var/obj/npc/n = npcsheet
				usr.statroll(n.dexmod,"Dexterity Roll",n.name)

		Rollcon()
			set hidden = 1
			if(usr.intitlescreen)
				return
			if(!npcsheet)
				usr.statroll(usr.conmod,"Constitution Roll")
			else
				var/obj/npc/n = npcsheet
				usr.statroll(n.conmod,"Constitution Roll",n.name)

		Rollint()
			set hidden = 1
			if(usr.intitlescreen)
				return
			if(!npcsheet)
				usr.statroll(usr.intmod,"Intelligence Roll")
			else
				var/obj/npc/n = npcsheet
				usr.statroll(n.intmod,"intelligence Roll",n.name)

		Rollwis()
			set hidden = 1
			if(usr.intitlescreen)
				return
			if(!npcsheet)
				usr.statroll(usr.wismod,"Wisdom Roll")
			else
				var/obj/npc/n = npcsheet
				usr.statroll(n.wismod,"Wisdom Roll",n.name)

		Rollcha()
			set hidden = 1
			if(usr.intitlescreen)
				return
			if(!npcsheet)
				usr.statroll(usr.chamod,"Charisma Roll")
			else
				var/obj/npc/n = npcsheet
				usr.statroll(n.chamod,"Charisma Roll",n.name)

		Rollacr()
			set hidden = 1
			if(usr.intitlescreen)
				return
			var/bonus=0
			if(usr.acrobaticsproficient==1)
				bonus=usr.rankbonus
			if(!npcsheet)
				usr.statroll(usr.acrobatics,"Acrobatics Roll")
			else
				var/obj/npc/n = npcsheet
				usr.statroll(n.acrobatics,"Acrobatics Roll",n.name, bonus)

		Rollath()
			set hidden = 1
			if(usr.intitlescreen)
				return
			var/bonus=0
			if(usr.athleticsproficient==1)
				bonus=usr.rankbonus
			if(!npcsheet)
				usr.statroll(usr.athletics,"Athletics Roll")
			else
				var/obj/npc/n = npcsheet
				usr.statroll(n.athletics,"Athletics Roll",n.name, bonus)

		Rollarc()
			set hidden = 1
			if(usr.intitlescreen)
				return
			var/bonus=0
			if(usr.archaeologyproficient==1)
				bonus=usr.rankbonus
			if(!npcsheet)
				usr.statroll(usr.archaeology,"Archaeology Roll")
			else
				var/obj/npc/n = npcsheet
				usr.statroll(n.archaeology,"Archaeology Roll",n.name, bonus)

		Rolldec()
			set hidden = 1
			if(usr.intitlescreen)
				return
			var/bonus=0
			if(usr.deceptionproficient==1)
				bonus=usr.rankbonus
			if(!npcsheet)
				usr.statroll(usr.deception,"Deception Roll")
			else
				var/obj/npc/n = npcsheet
				usr.statroll(n.deception,"Deception Roll",n.name, bonus)

		Rolldung()
			set hidden = 1
			if(usr.intitlescreen)
				return
			var/bonus=0
			if(usr.dungeoneeringproficient==1)
				bonus=usr.rankbonus
			if(!npcsheet)
				usr.statroll(usr.dungeoneering,"Dungeoneering Roll")
			else
				var/obj/npc/n = npcsheet
				usr.statroll(n.dungeoneering,"Dungeoneering Roll",n.name, bonus)

		Rollenc()
			set hidden = 1
			if(usr.intitlescreen)
				return
			var/bonus=0
			if(usr.enchantmentproficient==1)
				bonus=usr.rankbonus
			if(!npcsheet)
				usr.statroll(usr.enchantment,"Enchantment Roll")
			else
				var/obj/npc/n = npcsheet
				usr.statroll(n.enchantment,"Enchantment Roll",n.name, bonus)

		Rollins()
			set hidden = 1
			if(usr.intitlescreen)
				return
			var/bonus=0
			if(usr.insightproficient==1)
				bonus=usr.rankbonus
			if(!npcsheet)
				usr.statroll(usr.insight,"Insight Roll")
			else
				var/obj/npc/n = npcsheet
				usr.statroll(n.insight,"Insight Roll",n.name, bonus)

		Rollinv()
			set hidden = 1
			if(usr.intitlescreen)
				return
			var/bonus=0
			if(usr.investigationproficient==1)
				bonus=usr.rankbonus
			if(!npcsheet)
				usr.statroll(usr.investigation,"Investigation Roll")
			else
				var/obj/npc/n = npcsheet
				usr.statroll(n.investigation,"Investigation Roll",n.name, bonus)

		Rollmag()
			set hidden = 1
			if(usr.intitlescreen)
				return
			var/bonus=0
			if(usr.magicproficient==1)
				bonus=usr.rankbonus
			if(!npcsheet)
				usr.statroll(usr.magic,"Magic Roll")
			else
				var/obj/npc/n = npcsheet
				usr.statroll(n.magic,"Magic Roll",n.name, bonus)

		Rollmagi()
			set hidden = 1
			if(usr.intitlescreen)
				return
			var/bonus=0
			if(usr.magitekoperationproficient==1)
				bonus=usr.rankbonus
			if(!npcsheet)
				usr.statroll(usr.magitekOperation,"Magitek Operation Roll")
			else
				var/obj/npc/n = npcsheet
				usr.statroll(n.magitekOperation,"Magitek Operation Roll",n.name, bonus)

		Rollmed()
			set hidden = 1
			if(usr.intitlescreen)
				return
			var/bonus=0
			if(usr.medicineproficient==1)
				bonus=usr.rankbonus
			if(!npcsheet)
				usr.statroll(usr.medicine,"Medicine Roll")
			else
				var/obj/npc/n = npcsheet
				usr.statroll(n.medicine,"Medicine Roll",n.name, bonus)

		Rollnat()
			set hidden = 1
			if(usr.intitlescreen)
				return
			var/bonus=0
			if(usr.naturalistproficient==1)
				bonus=usr.rankbonus
			if(!npcsheet)
				usr.statroll(usr.naturalist,"Naturalist Roll")
			else
				var/obj/npc/n = npcsheet
				usr.statroll(n.naturalist,"Naturalist Roll",n.name, bonus)

		Rollper()
			set hidden = 1
			if(usr.intitlescreen)
				return
			var/bonus=0
			if(usr.perceptionproficient==1)
				bonus=usr.rankbonus
			if(!npcsheet)
				usr.statroll(usr.perception,"Perception Roll")
			else
				var/obj/npc/n = npcsheet
				usr.statroll(n.perception,"Perception Roll",n.name, bonus)

		Rollpers()
			set hidden = 1
			if(usr.intitlescreen)
				return
			var/bonus=0
			if(usr.persuasionproficient==1)
				bonus=usr.rankbonus
			if(!npcsheet)
				usr.statroll(usr.persuasion,"Persuasion Roll")
			else
				var/obj/npc/n = npcsheet
				usr.statroll(n.persuasion,"Persuasion Roll",n.name, bonus)

		Rollsth()
			set hidden = 1
			if(usr.intitlescreen)
				return
			var/bonus=0
			if(usr.stealthproficient==1)
				bonus=usr.rankbonus
			if(!npcsheet)
				usr.statroll(usr.stealth,"Stealth Roll")
			else
				var/obj/npc/n = npcsheet
				usr.statroll(n.stealth,"Stealth Roll",n.name, bonus)

		Rollsur()
			set hidden = 1
			if(usr.intitlescreen)
				return
			var/bonus=0
			if(usr.survivalproficient==1)
				bonus=usr.rankbonus
			if(!npcsheet)
				usr.statroll(usr.survival,"Survival Roll")
			else
				var/obj/npc/n = npcsheet
				usr.statroll(n.survival,"Survival Roll",n.name, bonus)

		Rollthv()
			set hidden = 1
			if(usr.intitlescreen)
				return
			var/bonus=0
			if(usr.thieveryproficient==1)
				bonus=usr.rankbonus
			if(!npcsheet)
				usr.statroll(usr.thievery,"Thievery Roll")
			else
				var/obj/npc/n = npcsheet
				usr.statroll(n.thievery,"Thievery Roll",n.name, bonus)

		Rollrflx()
			set hidden = 1
			if(usr.intitlescreen)
				return
			if(!npcsheet)
				usr.statroll(usr.rflx,"Reflex Save",)
			else
				var/obj/npc/n = npcsheet
				usr.statroll(n.rflx,"Reflex Save",n.name)

		Rollwill()
			set hidden = 1
			if(usr.intitlescreen)
				return
			if(!npcsheet)
				usr.statroll(usr.will,"Will Save")
			else
				var/obj/npc/n = npcsheet
				usr.statroll(n.will,"Will Save",n.name)

		Rollfort()
			set hidden = 1
			if(usr.intitlescreen)
				return
			if(!npcsheet)
				usr.statroll(usr.fort,"Fortitude Save")
			else
				var/obj/npc/n = npcsheet
				usr.statroll(n.fort,"Fortitude Save",n.name)


		ViewWar()
			set hidden = 1
			if(usr.intitlescreen)
				return
			var/E
			for(var/obj/Eye/Wareye/o in world)
				E=o
			src.client.eye = E
			src.client.perspective = EYE_PERSPECTIVE


obj
	ReturnView
		icon='Icons/Blank.dmi'
		layer=4
		Click()
			usr.client.eye = usr
			usr.client.perspective = EYE_PERSPECTIVE


mob/proc
	Checkmod(s as num,n as num,t as num,mob/m)
		if(usr.intitlescreen)
			return
		var/result = n+t
		if(result==10||result==11)
			if(s==1)
				m.strmod=0
			if(s==2)
				m.dexmod=0
			if(s==3)
				m.conmod=0
			if(s==4)
				m.intmod=0
			if(s==5)
				m.wismod=0
			if(s==6)
				m.chamod=0
		if(result==12||result==13)
			if(s==1)
				m.strmod=1
			if(s==2)
				m.dexmod=1
			if(s==3)
				m.conmod=1
			if(s==4)
				m.intmod=1
			if(s==5)
				m.wismod=1
			if(s==6)
				m.chamod=1
		if(result==14||result==15)
			if(s==1)
				m.strmod=2
			if(s==2)
				m.dexmod=2
			if(s==3)
				m.conmod=2
			if(s==4)
				m.intmod=2
			if(s==5)
				m.wismod=2
			if(s==6)
				m.chamod=2
		if(result==16||result==17)
			if(s==1)
				m.strmod=3
			if(s==2)
				m.dexmod=3
			if(s==3)
				m.conmod=3
			if(s==4)
				m.intmod=3
			if(s==5)
				m.wismod=3
			if(s==6)
				m.chamod=3
		if(result==18||result==19)
			if(s==1)
				m.strmod=4
			if(s==2)
				m.dexmod=4
			if(s==3)
				m.conmod=4
			if(s==4)
				m.intmod=4
			if(s==5)
				m.wismod=4
			if(s==6)
				m.chamod=4
		if(result==20||result==21)
			if(s==1)
				m.strmod=5
			if(s==2)
				m.dexmod=5
			if(s==3)
				m.conmod=5
			if(s==4)
				m.intmod=5
			if(s==5)
				m.wismod=5
			if(s==6)
				m.chamod=5
		if(result==22||result==23)
			if(s==1)
				m.strmod=6
			if(s==2)
				m.dexmod=6
			if(s==3)
				m.conmod=6
			if(s==4)
				m.intmod=6
			if(s==5)
				m.wismod=6
			if(s==6)
				m.chamod=6
		if(result==24||result==25)
			if(s==1)
				m.strmod=7
			if(s==2)
				m.dexmod=7
			if(s==3)
				m.conmod=7
			if(s==4)
				m.intmod=7
			if(s==5)
				m.wismod=7
			if(s==6)
				m.chamod=7
		if(result==26||result==27)
			if(s==1)
				m.strmod=8
			if(s==2)
				m.dexmod=8
			if(s==3)
				m.conmod=8
			if(s==4)
				m.intmod=8
			if(s==5)
				m.wismod=8
			if(s==6)
				m.chamod=8
		if(result==28||result==29)
			if(s==1)
				m.strmod=9
			if(s==2)
				m.dexmod=9
			if(s==3)
				m.conmod=9
			if(s==4)
				m.intmod=9
			if(s==5)
				m.wismod=9
			if(s==6)
				m.chamod=9
		if(result==30||result==31)
			if(s==1)
				m.strmod=10
			if(s==2)
				m.dexmod=10
			if(s==3)
				m.conmod=10
			if(s==4)
				m.intmod=10
			if(s==5)
				m.wismod=10
			if(s==6)
				m.chamod=10
		if(result==32||result==33)
			if(s==1)
				m.strmod=11
			if(s==2)
				m.dexmod=11
			if(s==3)
				m.conmod=11
			if(s==4)
				m.intmod=11
			if(s==5)
				m.wismod=11
			if(s==6)
				m.chamod=11
		if(result==34||result==35)
			if(s==1)
				m.strmod=12
			if(s==2)
				m.dexmod=12
			if(s==3)
				m.conmod=12
			if(s==4)
				m.intmod=12
			if(s==5)
				m.wismod=12
			if(s==6)
				m.chamod=12
		if(result==36||result==37)
			if(s==1)
				m.strmod=13
			if(s==2)
				m.dexmod=13
			if(s==3)
				m.conmod=13
			if(s==4)
				m.intmod=13
			if(s==5)
				m.wismod=13
			if(s==6)
				m.chamod=13
		if(result==38||result==39)
			if(s==1)
				m.strmod=14
			if(s==2)
				m.dexmod=14
			if(s==3)
				m.conmod=14
			if(s==4)
				m.intmod=14
			if(s==5)
				m.wismod=14
			if(s==6)
				m.chamod=14
		if(result==40||result==41)
			if(s==1)
				m.strmod=15
			if(s==2)
				m.dexmod=15
			if(s==3)
				m.conmod=15
			if(s==4)
				m.intmod=15
			if(s==5)
				m.wismod=15
			if(s==6)
				m.chamod=15
		m.Skillcheck(m)
		m.Carrycheck(m)
		m.Savecheck(m)
		m.ACcheck(m)
		m.RefreshCharsheet(m)
	Stealthcheck(var/mob/m,var/mob/t)
		var/result1=rand(1,20)
		var/result2=rand(1,20)
		result1+=m.stealth
		result2+=t.perception
		if(result1<result2)
			m.invisibility=0
			m.stealthing=0
			m<<output("You have been spotted by[t]","icout")
			t<<output("You spy [m] trying to sneak around","icout")
	Skillcheck(mob/m)
		var/acrobonus=0
		var/athbonus=0
		var/archbonus=0
		var/decbonus=0
		var/dungbonus=0
		var/enchbonus=0
		var/insbonus=0
		var/invbonus=0
		var/magbonus=0
		var/magibonus=0
		var/medibonus=0
		var/natbonus=0
		var/persbonus=0
		var/percbonus=0
		var/stebonus=0
		var/survbonus=0
		var/thievbonus=0
		if(usr.acrobaticsproficient==1)
			acrobonus=usr.rankbonus
		if(usr.athleticsproficient==1)
			athbonus=usr.rankbonus
		if(usr.archaeologyproficient==1)
			archbonus=usr.rankbonus
		if(usr.deceptionproficient==1)
			decbonus=usr.rankbonus
		if(usr.dungeoneeringproficient==1)
			dungbonus=usr.rankbonus
		if(usr.enchantmentproficient==1)
			enchbonus=usr.rankbonus
		if(usr.insightproficient==1)
			insbonus=usr.rankbonus
		if(usr.investigationproficient==1)
			invbonus=usr.rankbonus
		if(usr.magitekoperationproficient==1)
			magibonus=usr.rankbonus
		if(usr.medicineproficient==1)
			medibonus=usr.rankbonus
		if(usr.magicproficient==1)
			magbonus=usr.rankbonus
		if(usr.naturalistproficient==1)
			natbonus=usr.rankbonus
		if(usr.perceptionproficient==1)
			percbonus=usr.rankbonus
		if(usr.persuasionproficient==1)
			persbonus=usr.rankbonus
		if(usr.stealthproficient==1)
			stebonus=usr.rankbonus
		if(usr.survivalproficient==1)
			survbonus=usr.rankbonus
		if(usr.thieveryproficient==1)
			thievbonus=usr.rankbonus
		m.acrobatics=m.baseacro+dexmod+acrobonus
		m.athletics=m.baseath+strmod+athbonus
		m.archaeology=m.basearc+intmod+archbonus
		m.deception=m.basedec+chamod+decbonus
		m.dungeoneering=m.basedung+intmod+dungbonus
		m.enchantment=m.baseenchant+intmod+enchbonus
		m.insight=m.basein+wismod+insbonus
		m.investigation=m.baseinv+intmod+invbonus
		m.magic=m.basemagic+wismod+magbonus
		m.magitekOperation=m.basemagio+intmod+magibonus
		m.medicine=m.basemed+intmod+medibonus
		m.naturalist=m.basenat+chamod+natbonus
		m.perception=m.baseper+wismod+percbonus
		m.persuasion=m.basepers+chamod+persbonus
		m.stealth=m.basestl+dexmod+stebonus
		m.thievery=m.basethv+dexmod+thievbonus
		m.survival=m.basesurv+wismod+survbonus
		m.RefreshCharsheet(m)
	Carrycheck(mob/m)
		if(m.str==10)
			m.carrylimit=110
		if(m.str==11)
			m.carrylimit=125
		if(m.str==12)
			m.carrylimit=150
		if(m.str==13)
			m.carrylimit=180
		if(m.str==14)
			m.carrylimit=210
		if(m.str==15)
			m.carrylimit=250
		if(m.str==16)
			m.carrylimit=280
		if(m.str==17)
			m.carrylimit=310
		if(m.str==18)
			m.carrylimit=350
		if(m.str==19)
			m.carrylimit=380
		if(m.str==20)
			m.carrylimit=400
	Savecheck(mob/m)
		m.rflx=m.baserflx+m.dexmod
		m.will=m.basewill+m.wismod
		m.fort=m.basefort+m.conmod
		if(m.reflexproficient==1)
			m.rflx+=m.rankbonus
		if(m.willproficient==1)
			m.will+=m.rankbonus
		if(m.fortitudeproficient==1)
			m.fort+=m.rankbonus
		if(m.reflexexpert==1)
			m.rflx+=m.rankbonus+3
		if(m.willexpert==1)
			m.will+=m.rankbonus+3
		if(m.fortitudeexpert==1)
			m.fort+=m.rankbonus+3
		winset(m,"Charsheet.Rflx","text=\"Reflex:[m.rflx]\"")
		winset(m,"Charsheet.Fort","text=\"Fortitude:[m.fort]\"")
		winset(m,"Charsheet.Will","text=\"Will:[m.will]\"")
	ACcheck(mob/m)
		m.ac=m.baseac+acmod+dexmod+rankbonus
		winset(m,"Charsheet.AC","text=\"[m.ac]\"")
atom
	proc
		RefreshCharsheet(var/mob/m)
			if(winget(m,"CharSheet","is-visible=true"))
				winset(usr,"CharSheet.Nameplate","text=\"[usr.name]\"")
				winset(usr,"CharSheet.str","text=\"[usr.str]+[usr.addstr]/[usr.strmod]\"")
				winset(usr,"CharSheet.dex","text=\"[usr.dex]+[usr.adddex]/[usr.dexmod]\"")
				winset(usr,"CharSheet.con","text=\"[usr.con]+[usr.addcon]/[usr.conmod]\"")
				winset(usr,"CharSheet.int","text=\"[usr.int]+[usr.addint]/[usr.intmod]\"")
				winset(usr,"CharSheet.wis","text=\"[usr.wis]+[usr.addwis]/[usr.wismod]\"")
				winset(usr,"CharSheet.cha","text=\"[usr.cha]+[usr.addcha]/[usr.chamod]\"")
				winset(usr,"Charsheet.RPP","text=\"[usr.rpp]/[usr.trpp]\"")
				winset(usr,"Charsheet.HP","text=\"[usr.hp]/[usr.mhp]\"")
				winset(usr,"Charsheet.MP","text=\"[usr.mp]/[usr.mmp]\"")
				winset(usr,"Charsheet.Race","text=\"Race: [usr.race]\"")
				winset(usr,"Charsheet.Job","text=\"Job: [usr.job]\"")
				winset(usr,"Charsheet.Subjob","text=\"Subjob: [usr.subjob]\"")
				winset(usr,"Charsheet.ajob","text=\"[usr.ajob]\"")
				winset(usr,"Charsheet.role","text=\"Role: [usr.role]\"")
				winset(usr,"Charsheet.rank","text=\"Rank: [usr.rank]\"")
				winset(usr,"Charsheet.rankbonus","text=\"Rank Bonus: [usr.rankbonus]\"")
				winset(usr,"Charsheet.AC","text=\"[usr.ac]\"")
				winset(usr,"Charsheet.DR","text=\"[usr.basedr]\"")
				winset(usr,"Charsheet.SPD","text=\"[usr.speed]\"")
				winset(usr,"Charsheet.pab","text=\"[usr.pab]\"")
				winset(usr,"Charsheet.pdb","text=\"[usr.pdb]\"")
				winset(usr,"Charsheet.mab","text=\"[usr.mab]\"")
				winset(usr,"Charsheet.mdb","text=\"[usr.mdb]\"")
				winset(usr,"Charsheet.ap","text=\"[usr.abilitypoints]\"")
mob
	proc
		Limitbreakcalc(var/mob/m,var/obj/perk/a)
			var/players
			var/aoresult
			var/aresult
			var/amod
			var/doresult
			var/dmod
			var/dresult
			var/critdam
			var/abilitydamage
			players={"<font color=#EC2323>[m.name] has flashed an ability as their limitbreak!: <a href="byond://?src=\ref[m]&action=look&value=\ref[a]"><font color=#FFFFFF>[a]</a>!!"}
			view() << output("[players]","icout")
			if(a.atype=="save")
				doresult=a.raw_attack_damage_roll()
				amod=Checkdamtype(a.damsource,m)
				dmod=Checkdamtype(a.damsource,m)
				abilitydamage=a.raw_attack_damage_roll()
				if(a.typing=="magical")
					aresult=a.basecheck+amod+m.rankbonus+a.addhit+4
					dresult=(abilitydamage+dmod+m.mdb+a.adddam)
					dresult += usr.mdbadd
				else
					aresult=a.basecheck+amod+m.rankbonus+a.addhit+4
					dresult=(abilitydamage+dmod+m.pdb+a.adddam)
					dresult += usr.pdbadd
				dresult*=2
				view()<<output("<font size=1><font color=[m.textcolor]>[m] <font color=white>is using the <font color=[m.textcolor]>[a.name]<font color=white> ability!  Saving throw: <font color=#8EF5DE><b>[aresult] [a.savetype]!</b><font color=white>, dealing <b><font color=#FFA852>[dresult] damage</b><font color=white> on a failed save!<br> Cost: <b><font color=#0FBFD7>[a.mcost] [a.costtype]</b> | Tile Range:[a.range]","icout")
			if(a.atype=="weaponsave")
				var/obj/item/Weapon/wepchoice = m.righthand
				alert(m,"This ability will use the weapon equipped to your right hand.")
				amod=Checkdamtype(wepchoice.damsource,m)
				if(a.typing=="magical")
					aresult=a.basecheck+amod+m.rankbonus+a.addhit+4
				else
					aresult=a.basecheck+amod+m.rankbonus+a.addhit+4
				doresult=rand(wepchoice.range1,wepchoice.range2)
				dmod=Checkdamtype(a.damsource,m)
				abilitydamage=a.raw_attack_damage_roll()
				if(a.typing=="magical")
					dresult=(doresult+dmod+wepchoice.adddam+m.mdb+a.adddam+abilitydamage)
					dresult += usr.mdbadd
				else
					dresult=(doresult+dmod+wepchoice.adddam+m.pdb+a.adddam+abilitydamage)
					dresult += usr.pdbadd
				dresult*=2
				view()<<output("<font size=1><font color=[usr.textcolor]>[usr] <font color=white>is using the <font color=[m.textcolor]>[a.name]<font color=white> ability with their [wepchoice.name]!  Saving throw: <font color=#8EF5DE><b>[aresult] [a.savetype]!</b><font color=white>, dealing <b><font color=#FFA852>[dresult] damage</b><font color=white> on a failed save!<br> Cost: <b><font color=#0FBFD7>[a.mcost] [a.costtype]</b> | Tile Range:[a.range]","icout")
			if(a.atype=="weapon")
				alert(m,"This ability will use the weapon equipped to your right hand.")
				if(m.righthand==0)
					alert(m,"You don't have a weapon equipped to use this ability!")
				else
					var/obj/item/Weapon/wepchoice = m.righthand
					aoresult=rand(1,20)
					amod=Checkdamtype(wepchoice.damsource,m)
					if(a.typing=="magical")
						aresult=aoresult+wepchoice.addhit+amod+m.rankbonus+m.mab+a.addhit+3
						aresult += usr.mabadd
					else
						aresult=aoresult+wepchoice.addhit+amod+m.rankbonus+m.pab+a.addhit+3
						aresult += usr.pabadd
					doresult=rand(wepchoice.range1,wepchoice.range2)
					dmod=Checkdamtype(a.damsource,m)
					abilitydamage=a.raw_attack_damage_roll()
					if(a.typing=="magical")
						dresult=(doresult+dmod+wepchoice.adddam+m.mdb+a.adddam+abilitydamage)
						dresult += usr.mdbadd
					else
						dresult=(doresult+dmod+wepchoice.adddam+m.pdb+a.adddam+abilitydamage)
						dresult += usr.pdbadd
					dresult*=2
					critdam=dresult+doresult
					if(aoresult>=wepchoice.critrange)
						view()<<output("<font size=1><font color=[m.textcolor]>[m] <font color=white>rolled a <b><font color=#3CF82C>CRITICAL</b> <font color=white>attack roll, using the <font color=[m.textcolor]>[a.name]<font color=white> ability with their [wepchoice.name]! Result: <font color=#3CF82C><b>[aresult] to hit</b><font color=white>, dealing <b><font color=#FFA852>[critdam] damage</b><font color=white>, as an automatic hit! Cost: <b><font color=#0FBFD7>[a.mcost] [a.costtype]</b>","icout")
					else
						view()<<output("<font size=1><font color=[m.textcolor]>[m] <font color=white>rolled an attack roll, using the <font color=[m.textcolor]>[a.name]<font color=white> ability with their [wepchoice.name]!  Result: <font color=#8EF5DE><b>[aresult] to hit</b><font color=white>, dealing <b><font color=#FFA852>[dresult] damage</b><font color=white> if successful!<br> Cost: <b><font color=#0FBFD7>[a.mcost] [a.costtype]</b> | Tile Range:[a.range]","icout")
			if(a.atype=="standard")
				aoresult=rand(1,20)
				amod=Checkdamtype(a.damsource,m)
				if(a.typing=="magical")
					aresult=aoresult+a.addhit+amod+m.rankbonus+m.mab+3
					aresult += usr.mabadd
				else
					aresult=aoresult+a.addhit+amod+m.rankbonus+m.pab+3
					aresult += usr.pabadd
				doresult=a.raw_attack_damage_roll()
				dmod=Checkdamtype(a.damsource,m)
				if(a.typing=="magical")
					dresult=(doresult+dmod+a.adddam+m.mdb)
					dresult += usr.mdbadd
				else
					dresult=(doresult+dmod+a.adddam+m.pdb)
					dresult += usr.pdbadd
				dresult*=2
				critdam=dresult+doresult
				if(aoresult>=a.critrange)
					view()<<output("<font size=1><font color=[m.textcolor]>[m] <font color=white>rolled a <b><font color=#3CF82C>CRITICAL</b> <font color=white>attack roll, using the <font color=[m.textcolor]>[m.name]<font color=white> ability! Result: <font color=#3CF82C><b>[aresult] to hit</b><font color=white>, dealing <b><font color=#FFA852>[critdam] damage</b><font color=white>, as an automatic hit! Cost: <b><font color=#0FBFD7>[a.mcost] [a.costtype]</b>","icout")
				else
					view()<<output("<font size=1><font color=[m.textcolor]>[m] <font color=white>rolled an attack roll, using the <font color=[m.textcolor]>[a.name]<font color=white> ability!  Result: <font color=#8EF5DE><b>[aresult] to hit</b><font color=white>, dealing <b><font color=#FFA852>[dresult] damage</b><font color=white> if successful!<br> Cost: <b><font color=#0FBFD7>[a.mcost] [a.costtype]</b> | Tile Range:[a.range]","output1")
					view()<<output("<font size=1><font color=[m.textcolor]>[m] <font color=white>rolled an attack roll, using the <font color=[m.textcolor]>[a.name]<font color=white> ability! Result: <font color=#8EF5DE><b>[aresult] to hit</b><font color=white>, dealing <b><font color=#FFA852>[dresult] damage</b><font color=white> if successful!<br> Cost: <b><font color=#0FBFD7>[a.mcost] [a.costtype]</b> | Tile Range:[a.range]","icout")
obj
	proc
		RefreshMateria(var/mob/m)
			var/row
			var/row2
			var/row3
			var/row4
			var/row5
			if(winget(m,"Materiascreen","is-visible=true"))
				winset(m,"Materiascreen.mslot1","cells=0x0")
				winset(m,"Materiascreen.slot2","cells=0x0")
				winset(m,"Materiascreen.slot3","cells=0x0")
				winset(m,"Materiascreen.unequipped","cells=0x0")
				winset(m,"Materiascreen.equipped","cells=0x0")
				for(var/obj/item/Materia/A in m.contents)
					if(A==m.materia1)
						row++
						m<<output(A,"mslot1:1,[row]")
					if(A==m.materia2)
						row2++
						m<<output(A,"slot2:1,[row2]")
					if(A==m.materia3)
						row3++
						m<<output(A,"slot3:1,[row3]")
					if(A.equipped==1)
						row4++
						m<<output(A,"equipped:1,[row4]")
					if(A.equipped==0)
						row5++
						m<<output(A,"unequipped:1,[row5]")
