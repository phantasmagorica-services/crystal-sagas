/obj
	var/robot=0
	var/entype
	var/mythic=0
	var/mastercraft=0 //This will be for the Namazu rework and an eventual semi-unique that crafters who get t4 armor+weapon smithing can app for.

/atom
	var/owner=0

/atom/proc/DetermineMat(var/mob/m,var/no,var/obj/recipes/a)
	var/matstring
	switch(no)
		if(1)
			matstring=a.mat1
		if(2)
			matstring=a.mat2
		if(3)
			matstring=a.mat3
		if(4)
			matstring=a.mat4
		if(5)
			matstring=a.mat5
		if(6)
			matstring=a.mat6
		if(7)
			matstring=a.mat7
		if(8)
			matstring=a.mat8
		if(9)
			matstring=a.mat9
		if(10)
			matstring=a.mat10
	for(var/obj/item/i in m.contents)
		if("[i.name]"=="[matstring]")
			return i

atom
	proc
		UpdateCraft(var/mob/m)
			var/row
			for(var/obj/item/material/A in usr.contents)
				if(A.name!="Ore" && A.name!="Synthesis" && A.name!="materials" &&A.name!="herbs")
					row++
					winset(m, "craftmats", "current-cell=1,[row]")
					m << output(A,"craftmats")
					if(A.amount>0)
						A.suffix="[A.amount]"
					if(A.amount==0)
						A.suffix="0"
					winset(m, "craftmats", "current-cell=2,[row]")
					m << output(A.suffix,"craftmats")
			m.SeeMechs()
			m.SeePots()
			m.SeeWeps()
			m.SeeArmor()
			m.SeeBuild()
			m.SeeJewel()
		UpdateStock(var/mob/m)
			var/row
			winset(m,"Stockwindow.Stockgrid","text=\"[usr.money]\"")
			for(var/obj/item/stock/Stockgem/A in usr.contents)
				row++
				winset(m, "Stockgrid", "current-cell=1,[row]")
				m << output(A,"Stockgrid")
				if(A.stock>0)
					A.suffix="[A.stock]"
				winset(m, "Stockgrid", "current-cell=2,[row]")
				m << output(A.suffix,"Stockgrid")

obj
	proc
		ViewRecipe(var/mob/m, var/obj/recipes/M)
			var/atom/result=M.creates
			var/icon/I = icon(result.icon,"")
			var/newPicture = fcopy_rsc(I)
			winset(m,"recipeout","is-visible=true")
			winset(m,"recipeout.perkicon","image=\ref[newPicture]")
			winset(m,"recipeout.desc","text=\"<p>[result.desc]</p>\"")
			winset(m,"recipeout.recipe","text=\"<br><b><font color=white>[M.mat1] : <font color=#8CF480>[M.amount1]</font> |<br> <b><font color=white>[M.mat2] : <font color=#8CF480>[M.amount2]</font> |<br> <b><font color=white>[M.mat3] : <font color=#8CF480>[M.amount3]</font> |<br> <b><font color=white>[M.mat4] : <font color=#8CF480>[M.amount4]</font> |<br> <b><font color=white>[M.mat5] : <font color=#8CF480>[M.amount5]</font> |<br> <b><font color=white>[M.mat6] : <font color=#8CF480>[M.amount6]</font> |<br> <b><font color=white>[M.mat7] : <font color=#8CF480>[M.amount7]</font> |<br> <b><font color=white>[M.mat8] : <font color=#8CF480>[M.amount8]</font> |<br> <b><font color=white>[M.mat9] : <font color=#8CF480>[M.amount9]</font> | <br><b><font color=white>[M.mat10] : <font color=#8CF480>[M.amount10]</font> |\"")

			winset(m,"recipeout.name","text=\"[result.name]\"")

mob
	verb
		OpenCraft()
			var/row
			if(usr.intitlescreen)
				return
			winset(usr,"Crafting","is-visible=true")
			for(var/obj/item/material/A in usr.contents)
				row++
				winset(usr, "craftmats", "current-cell=1,[row]")
				src << output(A,"craftmats")
				if(A.amount>0)
					A.suffix="[A.amount]"
				winset(usr, "craftmats", "current-cell=2,[row]")
				src << output(A.suffix,"craftmats")
			usr.SeeMechs()
			usr.SeePots()
			usr.SeeWeps()
			usr.SeeArmor()
			usr.SeeBuild()
			usr.SeeJewel()
		SeeBuild()
			var/row
			winset(usr,"Crafting.buildinglist","cells=0x0")
			for(var/obj/recipes/Buildings/o in usr.contents)
				row++
				src<<output(o,"buildinglist:1,[row]")
		SeeJewel()
			var/row
			winset(usr,"Crafting.jewellist","cells=0x0")
			for(var/obj/recipes/Jeweler/o in usr.contents)
				row++
				src<<output(o,"jewellist:1,[row]")
		SeeMaterials()
			var/row
			winset(usr,"Crafting.materials","cells=0x0")
			for(var/obj/item/material/o in usr.contents)
				row++
				src<<output(o,"materials:1,[row]")
		SeeMechs()
			var/row
			winset(usr,"Crafting.machinistrecipes","cells=0x0")
			for(var/obj/recipes/Machinist/o in usr.contents)
				if(o.mat1!=null)
					row++
					src<<output(o,"machinistrecipes:1,[row]")
		SeePots()
			var/row
			winset(usr,"Crafting.chemistrecipes","cells=0x0")
			for(var/obj/recipes/Chemist/o in usr.contents)
				if(o.mat1!=null)
					row++
					src<<output(o,"chemistrecipes:1,[row]")
		SeeWeps()
			var/row
			winset(usr,"Crafting.weaponrecipes","cells=0x0")
			for(var/obj/recipes/Weapons/o in global.recipe_shop.recipes)
				if(usr.smithing>=1)
					if(o.weapontype=="Longsword" && o.weptier=="Bronze")
						row++
						src<<output(o,"weaponrecipes:1,[row]")
					if(o.weapontype=="Longsword" && o.weptier=="Iron")
						row++
						src<<output(o,"weaponrecipes:1,[row]")
					if(o.weapontype=="Longsword" && o.weptier=="Steel")
						row++
						src<<output(o,"weaponrecipes:1,[row]")
				if(usr.smithing>=2)
					if(o.weapontype=="Longsword" && o.weptier=="Mythril")
						row++
						src<<output(o,"weaponrecipes:1,[row]")
				if(usr.smithing>=3)
					if(o.weapontype=="Longsword" && o.weptier=="Adamantine")
						row++
						src<<output(o,"weaponrecipes:1,[row]")
					if(o.weapontype=="Longsword" && o.weptier=="Orichalcum")
						row++
						src<<output(o,"weaponrecipes:1,[row]")
			winset(usr,"Crafting.wepcat","text=\"Longsword\"")
		swapwepcat()
			var/row
			var/swapwep
			winset(usr,"Crafting.weaponrecipes","cells=0x0")
			var/list/wepchoices=list("Longsword","Focus Crystal","Scimitar","Shuriken","Throwing Knives","Axe","Hammer","Dagger","Claw","Gauntlet","Whip","Greatsword","Katana","Spear","Scythe","Bow","Focus Sword","Staff","Rod","Tome","Sword Spear","Thief Sword","Bolt Rapier","Whip Blade","Akademia Cards","Blitz Ball","Gunblade","Bowsword","Bagangsaw","Buster Sword","Morphing Blade","Gun Arm","Magitek Pistol","Magitek Rifle")
			var/chosenwep=input(usr,"What weapon crafting list would you like to access?") as anything in wepchoices
			swapwep=chosenwep
			for(var/obj/recipes/Weapons/o in global.recipe_shop.recipes)
				if(usr.smithing>=1)
					if(o.weapontype=="[chosenwep]" && o.weptier=="Bronze")
						row++
						src<<output(o,"weaponrecipes:1,[row]")
					if(o.weapontype=="[chosenwep]" && o.weptier=="Iron")
						row++
						src<<output(o,"weaponrecipes:1,[row]")
					if(o.weapontype=="[chosenwep]" && o.weptier=="Steel")
						row++
						src<<output(o,"weaponrecipes:1,[row]")
				if(usr.smithing>=2)
					if(o.weapontype=="[chosenwep]" && o.weptier=="Mythril")
						row++
						src<<output(o,"weaponrecipes:1,[row]")
				if(usr.smithing>=3)
					if(o.weapontype=="[chosenwep]" && o.weptier=="Adamantine")
						row++
						src<<output(o,"weaponrecipes:1,[row]")
					if(o.weapontype=="[chosenwep]" && o.weptier=="Orichalcum")
						row++
						src<<output(o,"weaponrecipes:1,[row]")
				winset(usr,"Crafting.wepcat","text=\"[swapwep]\"")

		swaparmorcat()
			var/row
			var/swaparmor
			winset(usr,"Crafting.armorrecipes","cells=0x0")
			var/list/armorchoices=list("Light Armor","Medium Armor","Heavy Armor","Shield","Tower Shield")
			var/chosenarmor=input(usr,"What armor crafting list would you like to access?") as anything in armorchoices
			swaparmor=chosenarmor
			for(var/obj/recipes/Armor/o in usr.contents)
				if(o.weapontype=="[swaparmor]")
					row++
					src<<output(o,"armorrecipes:1,[row]")
			winset(usr,"Crafting.armcat","text=\"[swaparmor]\"")

		SeeArmor()
			var/row
			winset(usr,"Crafting.armorrecipes","cells=0x0")
			for(var/obj/recipes/Armor/o in usr.contents)
				if(o.weapontype=="Light Armor")
					row++
					src<<output(o,"armorrecipes:1,[row]")

//											Enchanting
obj/item/Weapon/verb
	Gild()
		set src in usr.contents
		var/tempname
		var/storename
		if(src.gilded>=1)
			alert(usr,"This is already Gilded!")
			return
		if(usr.craftingactive==1)
			return
		usr.craftingactive=1
		if(usr.check_perk("Weaponsmith II"))
			if(src.weapon != 1)
				alert(usr,"You cannot Gild this item, you can only gild Weapons!")
			else
				var/list/metchoice=list("Silver")
				if(usr.smithing>=2)
					metchoice+="Gold"
				if(usr.smithing>=3)
					metchoice+="Platinum"
				var/mchoice=input(usr,"Which Metal would you like to apply to this weapon as a Gilding? Silver: +1 | Gold: +2 | Platinum: +3") as anything in metchoice
				switch(mchoice)
					if("Silver")
						for(var/obj/item/material/ingot/silver/a in usr.contents)
							if(a.amount>=10)
								storename=src.name
								tempname="Silver [src.name]"
								if(istype(src, /obj/item/Weapon))
									var/obj/item/Weapon/casted = src
									casted.weapon_forced_add_hit += 1
									casted.weapon_forced_add_dam += 1
									casted.rebuild()
								src.gilded=1
								src.weapon_static_gilding = "silver"
								src.name=tempname
								a.amount-=10
								usr.craftingactive=0
								src.desc+=" | Silver gilded."
								view()<<output("[usr.name] applies a <b>Silver</b> gilding to [storename]","icout")
								UpdateCraft(usr)
							else
								alert(usr,"Applying a Silver gilding requires at least 10 Silver ore.")
					if("Gold")
						for(var/obj/item/material/ingot/gold/a in usr.contents)
							if(a.amount>=10)
								storename=src.name
								tempname="Gold [src.name]"
								if(istype(src, /obj/item/Weapon))
									var/obj/item/Weapon/casted = src
									casted.weapon_forced_add_hit += 2
									casted.weapon_forced_add_dam += 2
									casted.rebuild()
								src.gilded=1
								src.weapon_static_gilding = "gold"
								src.name=tempname
								a.amount-=10
								usr.craftingactive=0
								src.desc+=" | Gold gilded."
								view()<<output("[usr.name] applies a <b>Gold</b> gilding to [storename]","icout")
								UpdateCraft(usr)
							else
								alert(usr,"Applying a Gold gilding requires at least 10 Gold ore.")
					if("Platinum")
						for(var/obj/item/material/ingot/platinum/a in usr.contents)
							if(a.amount>=10)
								storename=src.name
								tempname="Platinum [src.name]"
								if(istype(src, /obj/item/Weapon))
									var/obj/item/Weapon/casted = src
									casted.weapon_forced_add_hit += 3
									casted.weapon_forced_add_dam += 3
									casted.rebuild()
								src.gilded=1
								src.weapon_static_gilding = "platinum"
								src.name=tempname
								a.amount-=10
								usr.craftingactive=0
								src.desc+=" | Platinum gilded."
								view()<<output("[usr.name] applies a <b>Platinum</b> gilding to [storename]","icout")
								UpdateCraft(usr)
							else
								alert(usr,"Applying a Platinum gilding requires at least 10 Platinum ore.")

		else
			alert(usr,"Only a Weaponsmith is able to Gild an item.")

obj/item/verb
	SetLore()
		if(usr.craftingactive==1)
			return
		usr.craftingactive=1
		if(usr.check_perk("Enchanter"))
			if(src.weapon != 1)
				alert(usr, "You cannot set this item's lore!")
			else
				for(var/obj/item/material/EtherPowder/a in usr.contents)
					if(a.amount>=1)
						if(src.lored==0)
							var/list/yesno=list("Yes","No")
							var/yeschoice=input(usr,"Would you like to change this item's Icon?") as anything in yesno
							src.name = input("What shall this item be called henceforth?") as text
							src.lore = input("What is the lore/description of this particular item?") as message
							src.lored=1
							if(istype(src, /obj/item/Weapon))
								var/obj/item/Weapon/casted = src
								casted.weapon_forced_add_hit += 1
								casted.weapon_forced_add_dam += 3
								casted.rebuild()
							if(src.name==null)
								src.name="Lored [src.weptier] [src.weapontype]"
							a.amount-=1
							usr.craftingactive=0
							UpdateCraft(usr)
							switch(yeschoice)
								if("Yes")
									src.icon = input("Select an icon to use.","Change Icon") as null|icon
								if("No")
									return
						else
							alert("This item already has lore!")

					else
						alert(usr, "You require 1 Ether Powder in order to give an item Lore and a Lore Bonus!")
						return
			usr.craftingactive=0

	Enchant()
		if(usr.craftingactive==1)
			return
		usr.craftingactive=1
		if(usr.job=="Dragoon"||usr.subjob=="Dragoon")
			if(src.weapontype=="Draconic")
			else
				var/list/choice=list("Yes","No","Cancel")
				var/choose=input("Would you like to make this weapon Draconic? It will scale to DEX, but only Dragoosn will be able to use it.") as anything in choice
				switch(choose)
					if("Yes")
						var/newname="Draconic [src.name]"
						src.weapontype="Draconic"
						if(istype(src, /obj/item/Weapon))
							var/obj/item/Weapon/casted = src
							casted.weapon_forced_stat = CHARACTER_STAT_DEX
							casted.rebuild()
						alert(usr,"You have made this weapon Draconic")
						src.name=newname
						return
					if("No")
					if("Cancel")
						return
		if(usr.race=="Namazu")
			if(src.mastercraft>0)
				alert(usr,"This item is already Master Crafted.")
			else
				var/list/choice=list("Yes","No","Cancel")
				var/choose=input("Would you like to Mastercraft this? Weapons get Power and Damage increased by 1 at the cost of 10 ores of it's Metal Tier.") as anything in choice
				switch(choose)
					if("Yes")
						var/newname="Masterwork [src.name]"
						if(src.weptier=="Bronze")
							var/obj/item/mtier = usr.Determinecraftmat("Bronze")
							if(mtier==null)
								alert(usr,"You don't seem to have any Bronze.")
								return
							else if(mtier.amount>=10)
								mtier.amount-=10
								if(istype(src, /obj/item/Weapon))
									var/obj/item/Weapon/casted = src
									casted.weapon_forced_add_hit += 1
									casted.weapon_forced_add_dam += 1
									casted.rebuild()
								src.mastercraft=1
								alert(usr,"You have made this weapon a Masterpiece!")
								src.name=newname
								return
							else
								alert(usr,"You don't have enough of the metal to Mastercraft!")
								return
						if(src.weptier=="Iron")
							var/obj/item/mtier = usr.Determinecraftmat("Iron")
							if(mtier==null)
								alert(usr,"You don't seem to have any Iron.")
								return
							else if(mtier.amount>=10)
								mtier.amount-=10
								if(istype(src, /obj/item/Weapon))
									var/obj/item/Weapon/casted = src
									casted.weapon_forced_add_hit += 1
									casted.weapon_forced_add_dam += 1
									casted.rebuild()
								src.mastercraft=1
								alert(usr,"You have made this weapon a Masterpiece!")
								src.name=newname
								return
							else
								alert(usr,"You don't have enough of the metal to Mastercraft!")
								return
						if(src.weptier=="Steel")
							var/obj/item/mtier = usr.Determinecraftmat("Steel")
							if(mtier==null)
								alert(usr,"You don't seem to have any Steel.")
								return
							else if(mtier.amount>=10)
								mtier.amount-=10
								if(istype(src, /obj/item/Weapon))
									var/obj/item/Weapon/casted = src
									casted.weapon_forced_add_hit += 1
									casted.weapon_forced_add_dam += 1
									casted.rebuild()
								src.mastercraft=1
								alert(usr,"You have made this weapon a Masterpiece!")
								src.name=newname
								return
							else
								alert(usr,"You don't have enough of the metal to Mastercraft!")
								return
						if(src.weptier=="Mythril")
							var/obj/item/mtier = usr.Determinecraftmat("Mythril")
							if(mtier==null)
								alert(usr,"You don't seem to have any Mythril.")
								return
							else if(mtier.amount>=10)
								mtier.amount-=10
								if(istype(src, /obj/item/Weapon))
									var/obj/item/Weapon/casted = src
									casted.weapon_forced_add_hit += 1
									casted.weapon_forced_add_dam += 1
									casted.rebuild()
								src.mastercraft=1
								alert(usr,"You have made this weapon a Masterpiece!")
								src.name=newname
								return
							else
								alert(usr,"You don't have enough of the metal to Mastercraft!")
								return
						if(src.weptier=="Adamantine")
							var/obj/item/mtier = usr.Determinecraftmat("Adamantine")
							if(mtier==null)
								alert(usr,"You don't seem to have any Adamantine.")
								return
							else if(mtier.amount>=10)
								mtier.amount-=10
								if(istype(src, /obj/item/Weapon))
									var/obj/item/Weapon/casted = src
									casted.weapon_forced_add_hit += 1
									casted.weapon_forced_add_dam += 1
									casted.rebuild()
								src.mastercraft=1
								alert(usr,"You have made this weapon a Masterpiece!")
								src.name=newname
								return
							else
								alert(usr,"You don't have enough of the metal to Mastercraft!")
								return
						if(src.weptier=="Orichalcum")
							var/obj/item/mtier = usr.Determinecraftmat("Orichalcum")
							if(mtier==null)
								alert(usr,"You don't seem to have any Orichalcum.")
								return
							else if(mtier.amount>=10)
								mtier.amount-=10
								if(istype(src, /obj/item/Weapon))
									var/obj/item/Weapon/casted = src
									casted.weapon_forced_add_hit += 1
									casted.weapon_forced_add_dam += 1
									casted.rebuild()
								src.mastercraft=1
								alert(usr,"You have made this weapon a Masterpiece!")
								src.name=newname
								return
							else
								alert(usr,"You don't have enough of the metal to Mastercraft!")
								return
					if("No")
					if("Cancel")
						return
		usr.craftingactive=0

		if(usr.check_perk("Enchanter"))
			switch(input("Do you wish to add an elemental effect or status effect?") in list("Elemental","Status","Mythic","Cancel"))
				if("Elemental")
					if(src.enchanted)
						alert(usr,"This weapon already has an enchantment on it")
						return
					switch(input("What element do you wish to add?") in list("Fire","Ice","Water","Thunder","Wind","Earth","Bio","Dark","Holy"))
						if("Fire")
							var/obj/item/fgem = usr.Determinecraftmat("Fire Gem")
							if(fgem==null)
								alert(usr,"You don't seem to have any Fire Gems")
								return
							switch(input("Which level of enchantment you want to add?") in list ("Novice","Intermediate","Expert"))
								if("Novice")
									if(fgem.amount>=4)
										fgem.amount-=4
										src.enchantment=" Enchanted(Novice) Fire Element"
										src.enchanted=1
										view()<<output("[usr.name] enchants their [src.name]","icout")
									else
										alert(usr,"You don't have enough. You need at least 3 Fire Gems")
								if("Intermediate")
									if(fgem.amount>=8)
										fgem.amount-=8
										src.enchantment=" Enchanted(Intermediate) Fire +1 to hit, latently."
										if(istype(src, /obj/item/Weapon))
											var/obj/item/Weapon/casted = src
											casted.weapon_forced_add_hit += 1
											casted.rebuild()
										src.enchanted=1
										view()<<output("[usr.name] enchants their [src.name]","icout")
									else
										alert(usr,"You don't have enough. You need at least 8 Fire Gems")
								if("Expert")
									if(fgem.amount>=12)
										fgem.amount-=12
										src.enchantment=" Enchanted(Expert) Fire +1 to hit and +3 to damage, latently."
										if(istype(src, /obj/item/Weapon))
											var/obj/item/Weapon/casted = src
											casted.weapon_forced_add_hit += 1
											casted.weapon_forced_add_dam += 3
											casted.rebuild()
										src.enchanted=1
										view()<<output("[usr.name] enchants their [src.name]","icout")
									else
										alert(usr,"You don't have enough. You need at least 12 Fire Gems")

						if("Ice")
							var/obj/item/igem = usr.Determinecraftmat("Ice Gem")
							if(igem==null)
								alert(usr,"You don't seem to have any Ice Gems")
								return
							switch(input("Which level of enchantment you want to add?") in list ("Novice","Intermediate","Expert"))
								if("Novice")
									if(igem.amount>=4)
										igem.amount-=4
										src.enchantment=" Enchanted(Novice) Ice Element"
										src.enchanted=1
										view()<<output("[usr.name] enchants their [src.name]","icout")
									else
										alert(usr,"You don't have enough. You need at least 3 Ice Gems")
								if("Intermediate")
									if(igem.amount>=8)
										igem.amount-=8
										src.enchantment=" Enchanted(Intermediate) Ice +1 to hit, latently."
										if(istype(src, /obj/item/Weapon))
											var/obj/item/Weapon/casted = src
											casted.weapon_forced_add_hit += 1
											casted.rebuild()
										src.enchanted=1
										view()<<output("[usr.name] enchants their [src.name]","icout")
									else
										alert(usr,"You don't have enough. You need at least 8 Ice Gems")
								if("Expert")
									if(igem.amount>=12)
										igem.amount-=12
										src.enchantment=" Enchanted(Expert) Ice +1 to hit and +3 to damage, latently."
										if(istype(src, /obj/item/Weapon))
											var/obj/item/Weapon/casted = src
											casted.weapon_forced_add_hit += 1
											casted.weapon_forced_add_dam += 3
											casted.rebuild()
										src.enchanted=1
										view()<<output("[usr.name] enchants their [src.name]","icout")
									else
										alert(usr,"You don't have enough. You need at least 12 Ice Gems")

						if("Thunder")
							var/obj/item/tgem = usr.Determinecraftmat("Thunder Gem")
							if(tgem==null)
								alert(usr,"You don't seem to have any Thunder Gems")
								return
							switch(input("Which level of enchantment you want to add?") in list ("Novice","Intermediate","Expert"))
								if("Novice")
									if(tgem.amount>=4)
										tgem.amount-=4
										src.enchantment=" Enchanted(Novice) Thunder Element"
										src.enchanted=1
										view()<<output("[usr.name] enchants their [src.name]","icout")
									else
										alert(usr,"You don't have enough. You need at least 3 Thunder Gems")
								if("Intermediate")
									if(tgem.amount>=8)
										tgem.amount-=8
										src.enchantment=" Enchanted(Intermediate) Thunder +1 to hit, latently."
										if(istype(src, /obj/item/Weapon))
											var/obj/item/Weapon/casted = src
											casted.weapon_forced_add_hit += 1
											casted.rebuild()
										src.enchanted=1
										view()<<output("[usr.name] enchants their [src.name]","icout")
									else
										alert(usr,"You don't have enough. You need at least 8 Thunder Gems")
								if("Expert")
									if(tgem.amount>=12)
										tgem.amount-=12
										src.enchantment=" Enchanted(Expert) Thunder +1 to hit and +3 to damage, latently."
										if(istype(src, /obj/item/Weapon))
											var/obj/item/Weapon/casted = src
											casted.weapon_forced_add_hit += 1
											casted.weapon_forced_add_dam += 3
											casted.rebuild()
										src.enchanted=1
										view()<<output("[usr.name] enchants their [src.name]","icout")
									else
										alert(usr,"You don't have enough. You need at least 12 Thunder Gems")

						if("Water")
							var/obj/item/wgem = usr.Determinecraftmat("Water Gem")
							if(wgem==null)
								alert(usr,"You don't seem to have any Water Gems")
								return
							switch(input("Which level of enchantment you want to add?") in list ("Novice","Intermediate","Expert"))
								if("Novice")
									if(wgem.amount>=4)
										wgem.amount-=4
										src.enchantment=" Enchanted(Novice) Water Element"
										src.enchanted=1
										view()<<output("[usr.name] enchants their [src.name]","icout")
									else
										alert(usr,"You don't have enough. You need at least 3 Water Gems")
								if("Intermediate")
									if(wgem.amount>=8)
										wgem.amount-=8
										src.enchantment=" Enchanted(Intermediate) Water +1 to hit, latently."
										if(istype(src, /obj/item/Weapon))
											var/obj/item/Weapon/casted = src
											casted.weapon_forced_add_hit += 1
											casted.rebuild()
										src.enchanted=1
										view()<<output("[usr.name] enchants their [src.name]","icout")
									else
										alert(usr,"You don't have enough. You need at least 8 Water Gems")
								if("Expert")
									if(wgem.amount>=12)
										wgem.amount-=12
										src.enchantment=" Enchanted(Expert) Water +1 to hit and +3, latently."
										if(istype(src, /obj/item/Weapon))
											var/obj/item/Weapon/casted = src
											casted.weapon_forced_add_hit += 1
											casted.weapon_forced_add_dam += 3
											casted.rebuild()
										src.enchanted=1
										view()<<output("[usr.name] enchants their [src.name]","icout")
									else
										alert(usr,"You don't have enough. You need at least 12 Water Gems")

						if("Wind")
							var/obj/item/wigem = usr.Determinecraftmat("Wind Gem")
							if(wigem==null)
								alert(usr,"You don't seem to have any Wind Gems")
								return
							switch(input("Which level of enchantment you want to add?") in list ("Novice","Intermediate","Expert"))
								if("Novice")
									if(wigem.amount>=4)
										wigem.amount-=4
										src.enchantment=" Enchanted(Novice) Wind Element"
										src.enchanted=1
										view()<<output("[usr.name] enchants their [src.name]","icout")
									else
										alert(usr,"You don't have enough. You need at least 3 Wind Gems")
								if("Intermediate")
									if(wigem.amount>=8)
										wigem.amount-=8
										src.enchantment=" Enchanted(Intermediate) Wind +1 to hit, latently."
										if(istype(src, /obj/item/Weapon))
											var/obj/item/Weapon/casted = src
											casted.weapon_forced_add_hit += 1
											casted.rebuild()
										src.enchanted=1
										view()<<output("[usr.name] enchants their [src.name]","icout")
									else
										alert(usr,"You don't have enough. You need at least 8 Wind Gems")
								if("Expert")
									if(wigem.amount>=12)
										wigem.amount-=12
										src.enchantment=" Enchanted(Expert) Wind +1 to hit and +3 to damage, latently."
										if(istype(src, /obj/item/Weapon))
											var/obj/item/Weapon/casted = src
											casted.weapon_forced_add_hit += 1
											casted.weapon_forced_add_dam += 3
											casted.rebuild()
										src.enchanted=1
										view()<<output("[usr.name] enchants their [src.name]","icout")
									else
										alert(usr,"You don't have enough. You need at least 12 Wind Gems")

						if("Earth")
							var/obj/item/egem = usr.Determinecraftmat("Earth Gem")
							if(egem==null)
								alert(usr,"You don't seem to have any Earth Gems")
								return
							switch(input("Which level of enchantment you want to add?") in list ("Novice","Intermediate","Expert"))
								if("Novice")
									if(egem.amount>=4)
										egem.amount-=4
										src.enchantment=" Enchanted(Novice) Earth Element"
										src.enchanted=1
										view()<<output("[usr.name] enchants their [src.name]","icout")
									else
										alert(usr,"You don't have enough. You need at least 3 Earth Gems")
								if("Intermediate")
									if(egem.amount>=8)
										egem.amount-=8
										src.enchantment=" Enchanted(Intermediate) Earth +1 to hit, latently."
										if(istype(src, /obj/item/Weapon))
											var/obj/item/Weapon/casted = src
											casted.weapon_forced_add_hit += 1
											casted.rebuild()
										src.enchanted=1
										view()<<output("[usr.name] enchants their [src.name]","icout")
									else
										alert(usr,"You don't have enough. You need at least 8 Earth Gems")
								if("Expert")
									if(egem.amount>=12)
										egem.amount-=12
										src.enchantment=" Enchanted(Expert) Earth +1 to hit and +3 to damage, latently."
										if(istype(src, /obj/item/Weapon))
											var/obj/item/Weapon/casted = src
											casted.weapon_forced_add_hit += 1
											casted.weapon_forced_add_dam += 3
											casted.rebuild()
										src.enchanted=1
										view()<<output("[usr.name] enchants their [src.name]","icout")
									else
										alert(usr,"You don't have enough. You need at least 12 Earth Gems")

						if("Bio")
							var/obj/item/bgem = usr.Determinecraftmat("Bio Gem")
							if(bgem==null)
								alert(usr,"You don't seem to have any Bio Gems")
								return
							switch(input("Which level of enchantment you want to add?") in list ("Novice","Intermediate","Expert"))
								if("Novice")
									if(bgem.amount>=4)
										bgem.amount-=4
										src.enchantment=" Enchanted(Novice) Bio Element"
										src.enchanted=1
										view()<<output("[usr.name] enchants their [src.name]","icout")
									else
										alert(usr,"You don't have enough. You need at least 3 Bio Gems")
								if("Intermediate")
									if(bgem.amount>=8)
										bgem.amount-=8
										src.enchantment=" Enchanted(Intermediate) Bio +1 to hit, latently."
										if(istype(src, /obj/item/Weapon))
											var/obj/item/Weapon/casted = src
											casted.weapon_forced_add_hit += 1
											casted.rebuild()
										src.enchanted=1
										view()<<output("[usr.name] enchants their [src.name]","icout")
									else
										alert(usr,"You don't have enough. You need at least 8 Bio Gems")
								if("Expert")
									if(bgem.amount>=12)
										bgem.amount-=12
										src.enchantment=" Enchanted(Expert) Bio +1 to hit and +3 to damage, latently."
										if(istype(src, /obj/item/Weapon))
											var/obj/item/Weapon/casted = src
											casted.weapon_forced_add_hit += 1
											casted.weapon_forced_add_dam += 3
											casted.rebuild()
										src.enchanted=1
										view()<<output("[usr.name] enchants their [src.name]","icout")
									else
										alert(usr,"You don't have enough. You need at least 12 Bio Gems")

						if("Holy")
							var/obj/item/hgem = usr.Determinecraftmat("Holy Gem")
							if(hgem==null)
								alert(usr,"You don't seem to have any Holy Gems")
								return
							switch(input("Which level of enchantment you want to add?") in list ("Novice","Intermediate","Expert"))
								if("Novice")
									if(hgem.amount>=4)
										hgem.amount-=4
										src.enchantment=" Enchanted(Novice) Holy Element"
										src.enchanted=1
										view()<<output("[usr.name] enchants their [src.name]","icout")
									else
										alert(usr,"You don't have enough. You need at least 3 Holy Gems")
								if("Intermediate")
									if(hgem.amount>=8)
										hgem.amount-=8
										src.enchantment=" Enchanted(Intermediate) Holy +1 to hit, latently."
										if(istype(src, /obj/item/Weapon))
											var/obj/item/Weapon/casted = src
											casted.weapon_forced_add_hit += 1
											casted.rebuild()
										src.enchanted=1
										view()<<output("[usr.name] enchants their [src.name]","icout")
									else
										alert(usr,"You don't have enough. You need at least 8 Holy Gems")
								if("Expert")
									if(hgem.amount>=12)
										hgem.amount-=12
										src.enchantment=" Enchanted(Expert) Holy +1 to hit and +3 to damage, latently."
										if(istype(src, /obj/item/Weapon))
											var/obj/item/Weapon/casted = src
											casted.weapon_forced_add_hit += 1
											casted.weapon_forced_add_dam += 3
											casted.rebuild()
										src.enchanted=1
										view()<<output("[usr.name] enchants their [src.name]","icout")
									else
										alert(usr,"You don't have enough. You need at least 12 Holy Gems")

						if("Dark")
							var/obj/item/dgem = usr.Determinecraftmat("Dark Gem")
							if(dgem==null)
								alert(usr,"You don't seem to have any Dark Gems")
								return
							switch(input("Which level of enchantment you want to add?") in list ("Novice","Intermediate","Expert"))
								if("Novice")
									if(dgem.amount>=4)
										dgem.amount-=4
										src.enchantment=" Enchanted(Novice) Dark Element"
										src.enchanted=1
										view()<<output("[usr.name] enchants their [src.name]","icout")
									else
										alert(usr,"You don't have enough. You need at least 3 Dark Gems")
								if("Intermediate")
									if(dgem.amount>=8)
										dgem.amount-=8
										src.enchantment=" Enchanted(Intermediate) Dark +1 to hit, latently."
										if(istype(src, /obj/item/Weapon))
											var/obj/item/Weapon/casted = src
											casted.weapon_forced_add_hit += 1
											casted.rebuild()
										src.enchanted=1
										view()<<output("[usr.name] enchants their [src.name]","icout")
									else
										alert(usr,"You don't have enough. You need at least 8 Dark Gems")
								if("Expert")
									if(dgem.amount>=12)
										dgem.amount-=12
										src.enchantment=" Enchanted(Expert) Dark +1 to hit and +3 to damage, latently."
										if(istype(src, /obj/item/Weapon))
											var/obj/item/Weapon/casted = src
											casted.weapon_forced_add_hit += 1
											casted.weapon_forced_add_dam += 3
											casted.rebuild()
										src.enchanted=1
										view()<<output("[usr.name] enchants their [src.name]","icout")
									else
										alert(usr,"You don't have enough. You need at least 12 Dark Gems")

				if("Status")
					if(src.enchanted==1)
						alert(usr,"This item already has a basic Enhantment applied.")
						return
					if(src.armor==1 || src.jewelery==1)
						src.entype="armor"
					else
						src.entype="weapon"
					switch(input("What status effect do you wish to instill?") in list("Poison","Blind","Silence","Sleep","Slow","Stop","Doom","Paralyze","Toad",""))
						if("Poison")
							var/obj/item/dgem = usr.Determinecraftmat("Bio Gem")
							if(dgem==null)
								alert(usr,"You don't seem to have any Bio Gems")
								return
							if(dgem.amount>=4)
								if(src.entype=="armor")
									src.enchantment=" Enchanted (Poison) | Gives advantage against Poison saving throws."
								if(src.entype=="weapon")
									if(istype(src, /obj/item/Weapon))
										var/obj/item/Weapon/casted = src
										casted.weapon_forced_add_hit += 1
										casted.weapon_forced_add_dam += 1
										casted.rebuild()
									src.enchanted=1
									src.enchantment=" Enchanted (Poison) +1 to hit and +1 damage, latently. | Attacks prompt DC 15 Saving Throw on hit, inflicting Poison on failure."
							else
								alert(usr,"You need 4 Bio Gems to apply the Poison enchantment.")
						if("Blind")
							var/obj/item/dgem = usr.Determinecraftmat("Dark Gem")
							if(dgem==null)
								alert(usr,"You don't seem to have any Dark Gems")
								return
							if(dgem.amount>=4)
								if(src.entype=="armor")
									src.enchantment=" Enchanted (Blind) | Gives advantage against Blind saving throws."
								if(src.entype=="weapon")
									if(istype(src, /obj/item/Weapon))
										var/obj/item/Weapon/casted = src
										casted.weapon_forced_add_hit += 1
										casted.weapon_forced_add_dam += 1
										casted.rebuild()
									src.enchanted=1
									src.enchantment=" Enchanted (Blind) +1 to hit, latently.| Attacks prompt DC 15 Saving Throw on hit, inflicting Blind on failure."
							else
								alert(usr,"You need 4 Dark Gems to apply the Blind enchantment.")
						if("Silence")
							var/obj/item/dgem = usr.Determinecraftmat("White Gem")
							if(dgem==null)
								alert(usr,"You don't seem to have any White Gems")
								return
							if(dgem.amount>=4)
								if(src.entype=="armor")
									src.enchantment=" Enchanted (Silence) | Gives advantage against Silence saving throws."
								if(src.entype=="weapon")
									if(istype(src, /obj/item/Weapon))
										var/obj/item/Weapon/casted = src
										casted.weapon_forced_add_hit += 1
										casted.weapon_forced_add_dam += 1
										casted.rebuild()
									src.enchanted=1
									src.enchantment=" Enchanted (Silence) +1 to hit, latently.| Attacks prompt DC 15 Saving Throw on hit, inflicting Silence on failure."
							else
								alert(usr,"You need 4 White Gems to apply the Silence enchantment.")
						if("Sleep")
							var/obj/item/dgem = usr.Determinecraftmat("Black Gem")
							if(dgem==null)
								alert(usr,"You don't seem to have any Black Gems")
								return
							if(dgem.amount>=4)
								if(src.entype=="armor")
									src.enchantment=" Enchanted (Sleep) | Gives advantage against Sleep saving throws."
								if(src.entype=="weapon")
									alert(usr,"This Enchantment cannot be applied to weapons.")
									return
							else
								alert(usr,"You need 4 Black Gems to apply the Sleep enchantment.")
						if("Slow")
							var/obj/item/dgem = usr.Determinecraftmat("White Gem")
							if(dgem==null)
								alert(usr,"You don't seem to have any White Gems")
								return
							if(dgem.amount>=4)
								if(src.entype=="armor")
									src.enchantment=" Enchanted (Slow) | Gives advantage against Slow saving throws."
								if(src.entype=="weapon")
									alert(usr,"This Enchantment cannot be applied to weapons.")
									return
							else
								alert(usr,"You need 4 White Gems to apply the Slow enchantment.")
						if("Stop")
							var/obj/item/dgem = usr.Determinecraftmat("Holy Gem")
							if(dgem==null)
								alert(usr,"You don't seem to have any Holy Gems")
								return
							if(dgem.amount>=4)
								if(src.entype=="armor")
									src.enchantment=" Enchanted (Stop) | Gives advantage against Stop saving throws."
								if(src.entype=="weapon")
									alert(usr,"This Enchantment cannot be applied to weapons.")
									return
							else
								alert(usr,"You need 4 Holy Gems to apply the Stop enchantment.")
								return
						if("Doom")
							var/obj/item/dgem = usr.Determinecraftmat("Dark Gem")
							if(dgem==null)
								alert(usr,"You don't seem to have any Dark Gems")
								return
							if(dgem.amount>=4)
								if(src.entype=="armor")
									src.enchantment=" Enchanted (Doom) | Gives advantage against Doom saving throws."
								if(src.entype=="weapon")
									alert(usr,"This Enchantment cannot be applied to weapons.")
									return
							else
								alert(usr,"You need 4 Dark Gems to apply the Doom enchantment.")
								return
						if("Paralyze")
							var/obj/item/dgem = usr.Determinecraftmat("Thunder Gem")
							if(dgem==null)
								alert(usr,"You don't seem to have any Thunder Gems")
								return
							if(dgem.amount>=4)
								if(src.entype=="armor")
									src.enchantment=" Enchanted (Paralyze) | Gives advantage against Paralyze saving throws."
								if(src.entype=="weapon")
									alert(usr,"This Enchantment cannot be applied to weapons.")
									return
							else
								alert(usr,"You need 4 Thunder Gems to apply the Paralyze enchantment.")
								return
						if("Toad")
							var/obj/item/dgem = usr.Determinecraftmat("Bio Gem")
							if(dgem==null)
								alert(usr,"You don't seem to have any Bio Gems")
								return
							if(dgem.amount>=4)
								if(src.entype=="armor")
									src.enchantment=" Enchanted (Toad) | Gives advantage against Toad saving throws."
								if(src.entype=="weapon")
									alert(usr,"This Enchantment cannot be applied to weapons.")
									return
							else
								alert(usr,"You need 4 Bio Gems to apply the Toad enchantment.")
								return
				if("Mythic")
					if(src.armor==1 || src.jewelery==1)
						alert(usr,"You can not apply Mythic enchantments to Armor or Accessories.")
						return
					if(src.mythic==1)
						alert(usr,"This item already has a Mythic enchantment applied.")
						return
					if(src.enchanted != 1)
						alert(usr,"You must apply a basic elemental or status enchantment before applying a Mythic enchantment.")
						return

					else
						var/choice = input("Which Mythic enchantment do you wish to apply?") as null|anything in list("Drain","Osmose","Angelic","Arcane","Destruction","Crippling","Corrosion","Mighty","Keen","Swift","Homing","Force Field","Mana Rod","Strong","Agile","Sturdy","Wise","Clever","Beautiful","Ogre","Clairvoyance","Teleporter","Esper Bane","Delver","Tamer","Tactical","Sagely","Divine","Supersonic","Vengeful","Brutish")
						if(!choice)
							return
						switch(choice)
							if("Drain")
								var/list/yesno = list("Yes","No")
								var/yesnochoice = input("Drain Effect: This weapon restores half of the damage it deals to its wielder. This can only apply to one attack roll per round.") as anything in yesno
								switch(yesnochoice)
									if("Yes")
										var/addenchant=" This weapon restores half of the damage it deals to its wielder. This can only apply to one attack roll per round."
										var/obj/item/dgem = usr.Determinecraftmat("Dark Gem")
										if(dgem==null)
											alert(usr,"You don't seem to have any Dark Gems (15 needed).")
											return
										if(dgem.amount>=15)
											if(istype(src, /obj/item/Weapon))
												var/obj/item/Weapon/casted = src
												casted.weapon_forced_add_hit += 1
												casted.weapon_forced_add_dam += 5
												casted.rebuild()
											src.mythic=1
											src.enchantment="[src.enchantment] | [addenchant]"
											return
										else
											alert(usr,"You need at least 15 Dark Gems to add Drain.")
											return
									if("No")
										return
							if("Osmose")
								var/list/yesno = list("Yes","No")
								var/yesnochoice = input("Osmose Effect: This weapon restores half of the damage it deals to its wielder as MP. This can only apply to one attack roll per round.") as anything in yesno
								switch(yesnochoice)
									if("Yes")
										var/addenchant=" This weapon restores half of the damage it deals to its wielder as MP. This can only apply to one attack roll per round."
										var/obj/item/dgem = usr.Determinecraftmat("Holy Gem")
										if(dgem==null)
											alert(usr,"You don't seem to have any Holy Gems (15 needed).")
											return
										if(dgem.amount>=15)
											if(istype(src, /obj/item/Weapon))
												var/obj/item/Weapon/casted = src
												casted.weapon_forced_add_hit += 1
												casted.weapon_forced_add_dam += 5
												casted.rebuild()
											src.mythic=1
											src.enchantment="[src.enchantment] | [addenchant]"
											return
										else
											alert(usr,"You need at least 15 Holy Gems to add Osmose.")
											return
									if("No")
										return
							if("Angelic")
								var/list/yesno = list("Yes","No")
								var/yesnochoice = input("Angelic Effect: This weapon restores 20 HP to its wielder and allies within 5 tiles on a succesful hit. Deals 2x damage to Undead. The healing pulse only procs once per round.") as anything in yesno
								switch(yesnochoice)
									if("Yes")
										var/addenchant=" This weapon restores 20 HP to its wielder and allies within 5 tiles on a succesful hit. Deals 2x damage to Undead. The healing pulse only procs once per round."
										var/obj/item/dgem = usr.Determinecraftmat("White Gem")
										if(dgem==null)
											alert(usr,"You don't seem to have any White Gems (15 needed).")
											return
										if(dgem.amount>=15)
											if(istype(src, /obj/item/Weapon))
												var/obj/item/Weapon/casted = src
												casted.weapon_forced_add_hit += 1
												casted.weapon_forced_add_dam += 5
												casted.rebuild()
											src.mythic=1
											src.enchantment="[src.enchantment] | [addenchant]"
											return
										else
											alert(usr,"You need at least 15 White Gems to add Angelic.")
											return
									if("No")
										return
							if("Arcane")
								var/list/yesno = list("Yes","No")
								var/yesnochoice = input("Arcane Effect: This weapon restores 5 MP and SP to its wielder and allies within 5 tiles on a succesful hit. The refresh pulse only procs once per round.") as anything in yesno
								switch(yesnochoice)
									if("Yes")
										var/addenchant=" This weapon restores 1/4 of the damage it deals as MP to its wielder and allies within 5 tiles."
										var/obj/item/dgem = usr.Determinecraftmat("Black Gem")
										if(dgem==null)
											alert(usr,"You don't seem to have any Black Gems (15 needed).")
											return
										if(dgem.amount>=15)
											if(istype(src, /obj/item/Weapon))
												var/obj/item/Weapon/casted = src
												casted.weapon_forced_add_hit += 1
												casted.weapon_forced_add_dam += 5
												casted.rebuild()
											src.mythic=1
											src.enchantment="[src.enchantment] | [addenchant]"
											return
										else
											alert(usr,"You need at least 15 Black Gems to add Arcane.")
											return
							if("Destruction")
								var/list/yesno = list("Yes","No")
								var/yesnochoice = input("Destruction Effect: This weapon's attacks deal 10 damage as an automatic hit to enemy creatures within 5 tiles of the target.") as anything in yesno
								switch(yesnochoice)
									if("Yes")
										var/addenchant=" This weapon's attacks deal 10 damage as an automatic hit to enemy creatures within 5 tiles of the target."
										var/obj/item/dgem = usr.Determinecraftmat("Fire Gem")
										if(dgem==null)
											alert(usr,"You don't seem to have any Fire Gems (15 needed).")
											return
										if(dgem.amount>=15)
											if(istype(src, /obj/item/Weapon))
												var/obj/item/Weapon/casted = src
												casted.weapon_forced_add_hit += 1
												casted.weapon_forced_add_dam += 5
												casted.rebuild()
											src.mythic=1
											src.enchantment="[src.enchantment] | [addenchant]"
											return
										else
											alert(usr,"You need at least 15 Fire Gems to add Destruction.")
											return
							if("Crippling")
								var/list/yesno = list("Yes","No")
								var/yesnochoice = input("Crippling Effect: This weapon's attacks inflict 'Bleed', and 'Heavy' on hit.") as anything in yesno
								switch(yesnochoice)
									if("Yes")
										var/addenchant=" This weapon's attacks inflict 'Bleed', and 'Heavy' on hit."
										var/obj/item/dgem = usr.Determinecraftmat("Dark Gem")
										if(dgem==null)
											alert(usr,"You don't seem to have any Dark Gems (15 needed).")
											return
										if(dgem.amount>=15)
											if(istype(src, /obj/item/Weapon))
												var/obj/item/Weapon/casted = src
												casted.weapon_forced_add_hit += 1
												casted.weapon_forced_add_dam += 5
												casted.rebuild()
											src.mythic=1
											src.enchantment="[src.enchantment] | [addenchant]"
											return
										else
											alert(usr,"You need at least 15 Dark Gems to add Crippling.")
											return
							if("Corrosion")
								var/list/yesno = list("Yes","No")
								var/yesnochoice = input("Corrosion Effect: This weapon's attacks inflict 'Poison', and 'Burn' on hit.") as anything in yesno
								switch(yesnochoice)
									if("Yes")
										var/addenchant=" This weapon's attacks inflict 'Poison', and 'Burn' on hit."
										var/obj/item/dgem = usr.Determinecraftmat("Bio Gem")
										if(dgem==null)
											alert(usr,"You don't seem to have any Bio Gems (15 needed).")
											return
										if(dgem.amount>=15)
											if(istype(src, /obj/item/Weapon))
												var/obj/item/Weapon/casted = src
												casted.weapon_forced_add_hit += 1
												casted.weapon_forced_add_dam += 5
												casted.rebuild()
											src.mythic=1
											src.enchantment="[src.enchantment] | [addenchant]"
											return
										else
											alert(usr,"You need at least 15 Bio Gems to add Corrosion.")
											return
							if("Mighty")
								var/list/yesno = list("Yes","No")
								var/yesnochoice = input("Mighty Effect: This weapon gains +7 additional damage (latently added}..") as anything in yesno
								switch(yesnochoice)
									if("Yes")
										var/addenchant=" This weapon gains +7 additional damage (latently added)."
										var/obj/item/dgem = usr.Determinecraftmat("Earth Gem")
										if(dgem==null)
											alert(usr,"You don't seem to have any Earth Gems (15 needed).")
											return
										if(dgem.amount>=15)
											if(istype(src, /obj/item/Weapon))
												var/obj/item/Weapon/casted = src
												casted.weapon_forced_add_hit += 1
												casted.weapon_forced_add_dam += 12
												casted.rebuild()
											src.mythic=1
											src.enchantment="[src.enchantment] | [addenchant]"
											return
										else
											alert(usr,"You need at least 15 Earth Gems to add Mighty.")
											return
							if("Keen")
								var/list/yesno = list("Yes","No")
								var/yesnochoice = input("Keen Effect: This weapon's crit range is reduced by 1. (latently added}..") as anything in yesno
								switch(yesnochoice)
									if("Yes")
										var/addenchant=" This weapon's crit range is reduced by 1. (latently added)."
										var/obj/item/dgem = usr.Determinecraftmat("Ice Gem")
										if(dgem==null)
											alert(usr,"You don't seem to have any Ice Gems (15 needed).")
											return
										if(dgem.amount>=15)
											if(istype(src, /obj/item/Weapon))
												var/obj/item/Weapon/casted = src
												casted.weapon_forced_add_hit += 1
												casted.weapon_forced_add_dam += 5
												casted.rebuild()
												casted.weapon_forced_add_crit += 1
											src.mythic=1
											src.enchantment="[src.enchantment] | [addenchant]"
											return
										else
											alert(usr,"You need at least 15 Ice Gems to add Keen.")
											return
							if("Swift")
								var/list/yesno = list("Yes","No")
								var/yesnochoice = input("Swift Effect: This Weapon gains a +2 to hit bonus (latently added), and may attack an extra time per attack action.") as anything in yesno
								switch(yesnochoice)
									if("Yes")
										var/addenchant=" This Weapon gains a +3 to hit bonus (latently added), and may attack an extra time per attack action."
										var/obj/item/dgem = usr.Determinecraftmat("Wind Gem")
										if(dgem==null)
											alert(usr,"You don't seem to have any Wind Gems (15 needed).")
											return
										if(dgem.amount>=15)
											if(istype(src, /obj/item/Weapon))
												var/obj/item/Weapon/casted = src
												casted.weapon_forced_add_hit += 3
												casted.weapon_forced_add_dam += 5
												casted.rebuild()
											src.mythic=1
											src.enchantment="[src.enchantment] | [addenchant]"
											return
										else
											alert(usr,"You need at least 15 Wind Gems to add Swift.")
											return
							if("Homing")
								var/list/yesno = list("Yes","No")
								var/yesnochoice = input("Homing Effect: This Weapon may once per round, when missing an attack roll allow the wielder to spend 5 MP to re-roll the attack.") as anything in yesno
								switch(yesnochoice)
									if("Yes")
										var/addenchant=" This Weapon may once per round, when missing an attack roll allow the wielder to spend 5 MP to re-roll the attack."
										var/obj/item/dgem = usr.Determinecraftmat("Thunder Gem")
										if(dgem==null)
											alert(usr,"You don't seem to have any Thunder Gems (15 needed).")
											return
										if(dgem.amount>=15)
											if(istype(src, /obj/item/Weapon))
												var/obj/item/Weapon/casted = src
												casted.weapon_forced_add_hit += 1
												casted.weapon_forced_add_dam += 5
												casted.rebuild()
											src.mythic=1
											src.enchantment="[src.enchantment] | [addenchant]"
											return
										else
											alert(usr,"You need at least 15 Thunder Gems to add Swift.")
											return
							if("Mana Rod")
								var/list/yesno= list("Yes","No")
								var/yesnochoice=input("Mana Rod Effect: While this weapon is equipped and wielded, Magical attacks towards the user when dealing damage, restore their MP and SP for half of the damage they take after resistance and damage reductions are applied.") as anything in yesno
								switch(yesnochoice)
									if("Yes")
										var/addenchant=" While this weapon is equipped and wielded, Magical attacks towards the user when dealing damage, restore their MP and SP for half of the damage they take after resistance and damage reductions are applied."
										var/obj/item/dgem = usr.Determinecraftmat("White Gem")
										if(dgem==null)
											alert(usr,"You don't seem to have any White Gems. (15  needed).")
											return
										if(dgem.amount>=15)
											if(istype(src, /obj/item/Weapon))
												var/obj/item/Weapon/casted = src
												casted.weapon_forced_add_hit += 1
												casted.weapon_forced_add_dam += 5
												casted.rebuild()
											src.mythic=1
											src.enchantment="[src.enchantment] | [addenchant]"
											return
										else
											alert(usr,"You need at least 15 White Gems to add Mana Rod.")
											return
							if("Force Field")
								var/list/yesno= list("Yes","No")
								var/yesnochoice=input("Force Field Effect: While this weapon is equipped, the wielder may spend 40 MP to gain effective resistance against a single roll's instance of damage, as a reaction.") as anything in yesno
								switch(yesnochoice)
									if("Yes")
										var/addenchant=" While this weapon is equipped, the wielder may spend 40 MP to gain effective resistance against a single roll's instance of damage, as a reaction."
										var/obj/item/dgem = usr.Determinecraftmat("Earth Gem")
										if(dgem==null)
											alert(usr,"You don't seem to have any Earth Gems. (15  needed).")
											return
										if(dgem.amount>=15)
											if(istype(src, /obj/item/Weapon))
												var/obj/item/Weapon/casted = src
												casted.weapon_forced_add_hit += 1
												casted.weapon_forced_add_dam += 5
												casted.rebuild()
											src.mythic=1
											src.enchantment="[src.enchantment] | [addenchant]"
											return
										else
											alert(usr,"You need at least 15 Earth Gems to add Force Field.")
											return
							if("Strong")
								var/list/yesno= list("Yes","No")
								var/yesnochoice=input("Strong Effect: While this weapon is equipped, the wielder gains +5 PDB, and +2 STR as a global modifier.") as anything in yesno
								switch(yesnochoice)
									if("Yes")
										var/addenchant=" While this weapon is equipped, the wielder gains +5 PDB, and +2 STR as a global modifier. This effect can not stack with itself."
										var/obj/item/dgem = usr.Determinecraftmat("Fire Gem")
										if(dgem==null)
											alert(usr,"You don't seem to have any Fire Gems. (15  needed).")
											return
										if(dgem.amount>=15)
											if(istype(src, /obj/item/Weapon))
												var/obj/item/Weapon/casted = src
												casted.weapon_forced_add_hit += 1
												casted.weapon_forced_add_dam += 5
												casted.rebuild()
											src.mythic=1
											src.enchantment="[src.enchantment] | [addenchant]"
											return
										else
											alert(usr,"You need at least 15 Fire Gems to add Strong.")
											return
							if("Agile")
								var/list/yesno= list("Yes","No")
								var/yesnochoice=input("Agile Effect: While this weapon is equipped, the wielder gains +2 PAB, and +2 DEX as a global modifier. This effect cannot stack with itself.") as anything in yesno
								switch(yesnochoice)
									if("Yes")
										var/addenchant=" While this weapon is equipped, the wielder gains +2 PAB, and +2 DEX as a global modifier."
										var/obj/item/dgem = usr.Determinecraftmat("Wind Gem")
										if(dgem==null)
											alert(usr,"You don't seem to have any Wind Gems. (15  needed).")
											return
										if(dgem.amount>=15)
											if(istype(src, /obj/item/Weapon))
												var/obj/item/Weapon/casted = src
												casted.weapon_forced_add_hit += 1
												casted.weapon_forced_add_dam += 5
												casted.rebuild()
											src.mythic=1
											src.enchantment="[src.enchantment] | [addenchant]"
											return
										else
											alert(usr,"You need at least 15 Wind Gems to add Agile.")
											return
							if("Sturdy")
								var/list/yesno= list("Yes","No")
								var/yesnochoice=input("Sturdy Effect: While this weapon is equipped, the wielder gains +1 AC, and +2 CON as a global modifier. This effect cannot stack with itself.") as anything in yesno
								switch(yesnochoice)
									if("Yes")
										var/addenchant=" While this weapon is equipped, the wielder gains +1 AC, and +2 CON as a global modifier. This effect cannot stack with itself."
										var/obj/item/dgem = usr.Determinecraftmat("Earth Gem")
										if(dgem==null)
											alert(usr,"You don't seem to have any Earth Gems. (15  needed).")
											return
										if(dgem.amount>=15)
											if(istype(src, /obj/item/Weapon))
												var/obj/item/Weapon/casted = src
												casted.weapon_forced_add_hit += 1
												casted.weapon_forced_add_dam += 5
												casted.rebuild()
											src.mythic=1
											src.enchantment="[src.enchantment] | [addenchant]"
											return
										else
											alert(usr,"You need at least 15 Earth Gems to add Sturdy.")
											return
							if("Wise")
								var/list/yesno= list("Yes","No")
								var/yesnochoice=input("Wise Effect: While this weapon is equipped, the wielder gains +4 MAB, and +2 WIS as a global modifier. This effect cannot stack with itself.") as anything in yesno
								switch(yesnochoice)
									if("Yes")
										var/addenchant=" While this weapon is equipped, the wielder gains +4 MAB, and +2 WIS as a global modifier. This effect cannot stack with itself."
										var/obj/item/dgem = usr.Determinecraftmat("Water Gem")
										if(dgem==null)
											alert(usr,"You don't seem to have any Water Gems. (15  needed).")
											return
										if(dgem.amount>=15)
											if(istype(src, /obj/item/Weapon))
												var/obj/item/Weapon/casted = src
												casted.weapon_forced_add_hit += 1
												casted.weapon_forced_add_dam += 5
												casted.rebuild()
											src.mythic=1
											src.enchantment="[src.enchantment] | [addenchant]"
											return
										else
											alert(usr,"You need at least 15 Water Gems to add Wise.")
											return
							if("Clever")
								var/list/yesno= list("Yes","No")
								var/yesnochoice=input("Clever Effect: While this weapon is equipped, the wielder gains +4 MAB, and +2 INT as a global modifier. This effect cannot stack with itself.") as anything in yesno
								switch(yesnochoice)
									if("Yes")
										var/addenchant=" While this weapon is equipped, the wielder gains +4 MAB, and +2 INT as a global modifier. This effect cannot stack with itself."
										var/obj/item/dgem = usr.Determinecraftmat("Thunder Gem")
										if(dgem==null)
											alert(usr,"You don't seem to have any Thunder Gems. (15  needed).")
											return
										if(dgem.amount>=15)
											if(istype(src, /obj/item/Weapon))
												var/obj/item/Weapon/casted = src
												casted.weapon_forced_add_hit += 1
												casted.weapon_forced_add_dam += 5
												casted.rebuild()
											src.mythic=1
											src.enchantment="[src.enchantment] | [addenchant]"
											return
										else
											alert(usr,"You need at least 15 Thunder Gems to add Wise.")
											return
							if("Beautiful")
								var/list/yesno= list("Yes","No")
								var/yesnochoice=input("Beautiful Effect: While this weapon is equipped, the wielder gains +4 MAB, and +2 CHA as a global modifier. This effect cannot stack with itself.") as anything in yesno
								switch(yesnochoice)
									if("Yes")
										var/addenchant=" While this weapon is equipped, the wielder gains +4 MAB, and +2 CHA as a global modifier. This effect cannot stack with itself."
										var/obj/item/dgem = usr.Determinecraftmat("Bio Gem")
										if(dgem==null)
											alert(usr,"You don't seem to have any Bio Gems. (15  needed).")
											return
										if(dgem.amount>=15)
											if(istype(src, /obj/item/Weapon))
												var/obj/item/Weapon/casted = src
												casted.weapon_forced_add_hit += 1
												casted.weapon_forced_add_dam += 5
												casted.rebuild()
											src.mythic=1
											src.enchantment="[src.enchantment] | [addenchant]"
											return
										else
											alert(usr,"You need at least 15 Bio Gems to add Wise.")
											return
							if("Ogre")
								var/list/yesno= list("Yes","No")
								var/yesnochoice=input("Ogre Effect: While this weapon is equipped, the wielder gains +20 PDB, but may not use Abilities or Spells of any type.") as anything in yesno
								switch(yesnochoice)
									if("Yes")
										var/addenchant=" While this weapon is equipped, the wielder gains +10 PDB, but may not use Abilities or Spells of any type."
										var/obj/item/dgem = usr.Determinecraftmat("Dark Gem")
										if(dgem==null)
											alert(usr,"You don't seem to have any Dark Gems. (15  needed).")
											return
										if(dgem.amount>=15)
											if(istype(src, /obj/item/Weapon))
												var/obj/item/Weapon/casted = src
												casted.weapon_forced_add_hit += 1
												casted.weapon_forced_add_dam += 5
												casted.rebuild()
											src.mythic=1
											src.enchantment="[src.enchantment] | [addenchant]"
											return
										else
											alert(usr,"You need at least 15 Dark Gems to add Ogre.")
											return
							if("Clairvoyance")
								var/list/yesno= list("Yes","No")
								var/yesnochoice=input("Clairvoyance Effect: While this weapon is equipped, the wielder gains immunity to Blind, advantage on Perception checks, and +2 WIS..") as anything in yesno
								switch(yesnochoice)
									if("Yes")
										var/addenchant=" While this weapon is equipped, the wielder gains immunity to Blind, advantage on Perception checks, and +2 WIS."
										var/obj/item/dgem = usr.Determinecraftmat("Dark Gem")
										if(dgem==null)
											alert(usr,"You don't seem to have any Dark Gems. (15  needed).")
											return
										if(dgem.amount>=15)
											if(istype(src, /obj/item/Weapon))
												var/obj/item/Weapon/casted = src
												casted.weapon_forced_add_hit += 1
												casted.weapon_forced_add_dam += 5
												casted.rebuild()
											src.mythic=1
											src.enchantment="[src.enchantment] | [addenchant]"
											return
										else
											alert(usr,"You need at least 15 Dark Gems to add Clairvoyance.")
											return
							if("Teleporter")
								var/list/yesno= list("Yes","No")
								var/yesnochoice=input("Teleporter Effect: This weapon allows placement of Teleportation glyphs as Bonus Actions, for 40 MP. Allows activation of created glyphs as Standard Action, at 10 MP cost. Releases 10 damage auto-hit 3x3 burst on teleport, from previous location.") as anything in yesno
								switch(yesnochoice)
									if("Yes")
										var/addenchant=" This weapon allows placement of Teleportation glyphs as Bonus Actions, for 40 MP. Allows activation of created glyphs as Standard Action, at 10 MP cost. Releases 10 damage auto-hit 3x3 burst on teleport, from previous location."
										var/obj/item/dgem = usr.Determinecraftmat("Dark Gem")
										if(dgem==null)
											alert(usr,"You don't seem to have any Dark Gems. (15  needed).")
											return
										if(dgem.amount>=15)
											if(istype(src, /obj/item/Weapon))
												var/obj/item/Weapon/casted = src
												casted.weapon_forced_add_hit += 1
												casted.weapon_forced_add_dam += 5
												casted.rebuild()
											src.mythic=1
											src.enchantment="[src.enchantment] | [addenchant]"
											return
										else
											alert(usr,"You need at least 15 Dark Gems to add Teleporter.")
											return
							if("Esper Bane")
								var/list/yesno= list("Yes","No")
								var/yesnochoice=input("Esper Bane Effect: Deals 30 additional damage on weapon attacks which deal damage to Espers, Summons, Eidolons, Aeons, Scions, and Half Espers when using this weapon.") as anything in yesno
								switch(yesnochoice)
									if("Yes")
										var/addenchant=" Deals 30 additional damage on weapon attacks which deal damage to Espers, Summons, Eidolons, Aeons, Scions, and Half Espers when using this weapon."
										var/obj/item/dgem = usr.Determinecraftmat("Holy Gem")
										if(dgem==null)
											alert(usr,"You don't seem to have any Holy Gems. (15  needed).")
											return
										if(dgem.amount>=15)
											if(istype(src, /obj/item/Weapon))
												var/obj/item/Weapon/casted = src
												casted.weapon_forced_add_hit += 1
												casted.weapon_forced_add_dam += 5
												casted.rebuild()
											src.mythic=1
											src.enchantment="[src.enchantment] | [addenchant]"
											return
										else
											alert(usr,"You need at least 15 Holy Gems to add Esper Bane.")
											return
							if("Delver")
								var/list/yesno= list("Yes","No")
								var/yesnochoice=input("Delver Effect: Grants advantage on skill checks during Dungeons while wielded.") as anything in yesno
								switch(yesnochoice)
									if("Yes")
										var/addenchant=" Grants advantage on skill checks during Dungeons while wielded."
										var/obj/item/dgem = usr.Determinecraftmat("Holy Gem")
										if(dgem==null)
											alert(usr,"You don't seem to have any Holy Gems. (15  needed).")
											return
										if(dgem.amount>=15)
											if(istype(src, /obj/item/Weapon))
												var/obj/item/Weapon/casted = src
												casted.weapon_forced_add_hit += 1
												casted.weapon_forced_add_dam += 5
												casted.rebuild()
											src.mythic=1
											src.enchantment="[src.enchantment] | [addenchant]"
											return
										else
											alert(usr,"You need at least 15 Holy Gems to add Delver.")
											return
							if("Tamer")
								var/list/yesno= list("Yes","No")
								var/yesnochoice=input("Tamer: Grants +5 to all Beastmaster related rolls while wielded.") as anything in yesno
								switch(yesnochoice)
									if("Yes")
										var/addenchant=" Grants +5 to all Beastmaster related rolls while wielded."
										var/obj/item/dgem = usr.Determinecraftmat("Holy Gem")
										if(dgem==null)
											alert(usr,"You don't seem to have any Holy Gems. (15  needed).")
											return
										if(dgem.amount>=15)
											if(istype(src, /obj/item/Weapon))
												var/obj/item/Weapon/casted = src
												casted.weapon_forced_add_hit += 1
												casted.weapon_forced_add_dam += 5
												casted.rebuild()
											src.mythic=1
											src.enchantment="[src.enchantment] | [addenchant]"
											return
										else
											alert(usr,"You need at least 15 Holy Gems to add Tamer.")
											return
							if("Sagely")
								var/list/yesno= list("Yes","No")
								var/yesnochoice=input("Sagely: Changes weapon's typing to 'magical' from 'physical' and its scaling to WIS.") as anything in yesno
								switch(yesnochoice)
									if("Yes")
										var/addenchant=" Changes weapon's typing to 'magical' from 'physical' and its scaling to WIS."
										var/obj/item/dgem = usr.Determinecraftmat("Dark Gem")
										if(dgem==null)
											alert(usr,"You don't seem to have any Dark Gems. (15  needed).")
											return
										if(dgem.amount>=15)
											if(istype(src, /obj/item/Weapon))
												var/obj/item/Weapon/casted = src
												casted.weapon_forced_add_hit += 1
												casted.weapon_forced_add_dam += 5
												casted.rebuild()
												casted.weapon_forced_stat = CHARACTER_STAT_WIS
											src.typing="magical"
											src.mythic=1
											src.enchantment="[src.enchantment] | [addenchant]"
											return
										else
											alert(usr,"You need at least 15 Dark Gems to add Sagely.")
											return
							if("Tactical")
								var/list/yesno= list("Yes","No")
								var/yesnochoice=input("Tactical: Changes weapon's typing to 'magical' from 'physical' and its scaling to INT.") as anything in yesno
								switch(yesnochoice)
									if("Yes")
										var/addenchant=" Changes weapon's typing to 'magical' from 'physical' and its scaling to INT."
										var/obj/item/dgem = usr.Determinecraftmat("Dark Gem")
										if(dgem==null)
											alert(usr,"You don't seem to have any Dark Gems. (15  needed).")
											return
										if(dgem.amount>=15)
											if(istype(src, /obj/item/Weapon))
												var/obj/item/Weapon/casted = src
												casted.weapon_forced_add_hit += 1
												casted.weapon_forced_add_dam += 5
												casted.rebuild()
												casted.weapon_forced_stat = CHARACTER_STAT_INT
											src.typing="magical"
											src.mythic=1
											src.enchantment="[src.enchantment] | [addenchant]"
											return
										else
											alert(usr,"You need at least 15 Dark Gems to add Tactical.")
											return
							if("Divine")
								var/list/yesno= list("Yes","No")
								var/yesnochoice=input("Divine: Changes weapon's typing to 'magical' from 'physical' and its scaling to CHA.") as anything in yesno
								switch(yesnochoice)
									if("Yes")
										var/addenchant=" Changes weapon's typing to 'magical' from 'physical' and its scaling to CHA."
										var/obj/item/dgem = usr.Determinecraftmat("White Gem")
										if(dgem==null)
											alert(usr,"You don't seem to have any White Gems. (15  needed).")
											return
										if(dgem.amount>=15)
											if(istype(src, /obj/item/Weapon))
												var/obj/item/Weapon/casted = src
												casted.weapon_forced_add_hit += 1
												casted.weapon_forced_add_dam += 5
												casted.rebuild()
												casted.weapon_forced_stat = CHARACTER_STAT_CHA
											src.typing="magical"
											src.mythic=1
											src.enchantment="[src.enchantment] | [addenchant]"
											return
										else
											alert(usr,"You need at least 15 White Gems to add Divine.")
											return
							if("Supersonic")
								var/list/yesno= list("Yes","No")
								var/yesnochoice=input("Supersonic: Grants +2 Speed while wielded.") as anything in yesno
								switch(yesnochoice)
									if("Yes")
										var/addenchant=" Grants +2 Speed while wielded."
										var/obj/item/dgem = usr.Determinecraftmat("Wind Gem")
										if(dgem==null)
											alert(usr,"You don't seem to have any Wind Gems. (15  needed).")
											return
										if(dgem.amount>=15)
											if(istype(src, /obj/item/Weapon))
												var/obj/item/Weapon/casted = src
												casted.weapon_forced_add_hit += 1
												casted.weapon_forced_add_dam += 5
												casted.rebuild()
											src.mythic=1
											src.enchantment="[src.enchantment] | [addenchant]"
											return
										else
											alert(usr,"You need at least 15 Wind Gems to add Supersonic.")
											return
							if("Vengeful")
								var/list/yesno= list("Yes","No")
								var/yesnochoice=input("Vengeful: Grants the wielder +2 PDB and +2 MDB for each instance of damage they take, stacking up to 8 PDB and 8 MDB, lasts until end of battle.") as anything in yesno
								switch(yesnochoice)
									if("Yes")
										var/addenchant=" Grants the wielder +2 PDB and +2 MDB for each instance of damage they take, stacking up to 8 PDB and 8 MDB, lasts until end of battle."
										var/obj/item/dgem = usr.Determinecraftmat("Fire Gem")
										if(dgem==null)
											alert(usr,"You don't seem to have any Fire Gems. (15  needed).")
											return
										if(dgem.amount>=15)
											if(istype(src, /obj/item/Weapon))
												var/obj/item/Weapon/casted = src
												casted.weapon_forced_add_hit += 1
												casted.weapon_forced_add_dam += 5
												casted.rebuild()
											src.mythic=1
											src.enchantment="[src.enchantment] | [addenchant]"
											return
										else
											alert(usr,"You need at least 15 Fire Gems to add Vengeful.")
											return
							if("Brutish")
								return
				if("Cancel")
					return
		else
			alert(usr,"You need to learn how to enchant first.")
		UpdateCraft(usr)

mob/proc
	Determinecraftmat(var/string)
		var/instring
		for(var/obj/item/i in src.contents)
			instring=i.name
			if("[instring]"=="[string]")
				return i


