
/obj/recipes
	icon='Icons/Crafting/recipe.dmi'
	var/craftable=1
	var/weapontype
	var/jeweler
	var/Weapon
	var/Armor=0
	var/Machine
	var/Potion
	var/material
	var/mat1
	var/amount1
	var/mat2
	var/amount2
	var/mat3
	var/amount3
	var/mat4
	var/amount4
	var/mat5
	var/amount5
	var/mat6
	var/amount6
	var/mat7
	var/amount7
	var/mat8
	var/amount8
	var/mat9
	var/amount9
	var/mat10
	var/amount10
	var/cat
	var/atom/creates

/obj/recipes/Click()
	switch(alert("Would you like to craft this, or view its recipe?","[src.name]","Craft","Recipe"))
		if("Craft")
			Create(src, usr)
		if("Recipe")
			Recipeview(usr, src)

/obj/recipes/proc/Create(var/obj/recipes/darecipe,var/mob/m)
	var/obj/created=darecipe.creates
	if(created.factionupgradebuilding==1)
		if(usr.Currentbuildings>=usr.Maxbuildings)
			alert(usr,"You have already built your maximum amount of Faction Upgrades ([usr.Maxbuildings])")
			return
		else
			usr.Currentbuildings+=1
	if(darecipe.name=="Airship")
		for(var/area/AR in view(usr))
			if(AR.outside==0)
				alert(usr,"You cannot build an Airship inside of an interior!")
				return
		if(totalairships==maxairships)
			alert(usr,"There are already 30 Airships in the world, and no more can be created.")
			return
	if(darecipe.name=="Landrover")
		for(var/area/AR in view(usr))
			if(AR.outside==0)
				alert(usr,"You cannot build a Landrover inside of an interior!")
				return
		if(totalrovers==maxrovers)
			alert(usr,"There are already 40 Rovers in the world, and no more can be created.")
			return
	if(darecipe.name=="Ship")
		for(var/area/AR in view(usr))
			if(AR.outside==0)
				alert(usr,"You cannot build an Boat inside of an interior!")
		if(totalships==maxships)
			alert(usr,"There are already 30 Ships in the world, and no more can be created.")
			return
	if(darecipe.name=="House")
		var/factioncheck=1
		var/housecheck=0
		for(var/obj/Fortress/fort in range(15, usr))
			if(fort.faction==usr.faction)
				factioncheck=0
			else
				factioncheck=1
		for(var/obj/House/house in range(8,usr))
			housecheck=1
		if(housecheck==1 && factioncheck==1)
			alert(usr,"You cannot build a structure in range of another Player of Faction!")
			return
		for(var/area/AR in view(usr))
			if(AR.outside==0)
				alert(usr,"You cannot build a house inside of an interior!")
				return
		if(usr.housemade==1)
			alert(usr,"You have already built a house, and can not build another.")
			return
		if(totalhouses==maxhouses)
			alert(usr,"There are already 100 Houses in the world, and no more can be created.")
			return
	if(darecipe.name=="Fortress")
		var/factioncheck=1
		var/housecheck=0
		for(var/obj/Fortress/fort in range(15, usr))
			if(fort.faction==usr.faction)
				factioncheck=0
			else
				factioncheck=1
		for(var/obj/House/house in range(8,usr))
			housecheck=1
		if(housecheck==1 && factioncheck==1)
			alert(usr,"You cannot build a structure in range of another Player of Faction!")
			return
		for(var/area/AR in view(usr))
			if(AR.outside==0)
				alert(usr,"You cannot build a Fortress inside of an interior!")
				return
		for(var/obj/Fortress/a in world)
			if(usr.faction==null)
				alert(usr,"You must be in a faction to build a Fortress for it.")
				return
			if(usr.faction==a.faction)
				alert(usr,"Your faction has already built a Fortress.")
				return
		if(totalhouses==maxfortresses)
			alert(usr,"There are already 36 Fortresses in the world, and no more can be created.")
			return
	if(darecipe.CheckComp(m,darecipe))
		if(darecipe.mat1!=null)
			var/obj/item/a = DetermineMat(m,1,darecipe)
			a.amount-=amount1
			if(a.amount==0)
				a.amount=0
		if(darecipe.mat2!=null)
			var/obj/item/a2 = DetermineMat(m,2,darecipe)
			a2.amount-=amount2
			if(a2.amount<=0)
				a2.amount=0
		if(darecipe.mat3!=null)
			var/obj/item/a3 = DetermineMat(m,3,darecipe)
			a3.amount-=amount3
			if(a3.amount<=0)
				a3.amount=0
		if(darecipe.mat4!=null)
			var/obj/item/a4 = DetermineMat(m,4,darecipe)
			a4.amount-=amount4
			if(a4.amount<=0)
				a4.amount=0
		if(darecipe.mat5!=null)
			var/obj/item/a5 = DetermineMat(m,5,darecipe)
			a5.amount-=amount5
			if(a5.amount<=0)
				a5.amount=0
		if(darecipe.mat6!=null)
			var/obj/item/a6 = DetermineMat(m,6,darecipe)
			a6.amount-=amount6
			if(a6.amount<=0)
				a6.amount=0
		if(darecipe.mat7!=null)
			var/obj/item/a7 = DetermineMat(m,7,darecipe)
			a7.amount-=amount7
			if(a7.amount<=0)
				a7.amount=0
		if(darecipe.mat8!=null)
			var/obj/item/a8 = DetermineMat(m,8,darecipe)
			a8.amount-=amount8
			if(a8.amount<=0)
				a8.amount=0
		if(darecipe.mat9!=null)
			var/obj/item/a9 = DetermineMat(m,9,darecipe)
			a9.amount-=amount9
			if(a9.amount<=0)
				a9.amount=0
		if(darecipe.mat10!=null)
			var/obj/item/a10 = DetermineMat(m,10,darecipe)
			a10.amount-=amount10
			if(a10.amount<=0)
				a10.amount=0
		var/obj/o = copyatom(darecipe.creates)
		m.contents+=o
		/*for(var/obj/item/Weapon/w in m.contents)
			if(o==w)
				if(m.race=="Namazu")
					w.addhit+=1
					w.adddam+=1*/
		if(o.vehicle==1)
			o.owner=m.key
			m.contents-=o
			o.loc=m.loc
			o.Savable=1
			if(o.name=="Rover")
				totalrovers+=1
			if(o.name=="Caravel")
				totalships+=1
			if(o.name=="Airship")
				totalairships+=1
		if(o.name=="FATES Mission Manager")
			m.contents-=o
			o.x=m.x
			o.y=m.y
			o.z=m.z
			o.Savable=1
		if(o.name=="Military Recruiter")
			o.truefaction=m.faction
			o.owner=m.faction
			o.faction=m.faction
			m.contents-=o
			o.x=m.x
			o.y=m.y
			o.z=m.z
			o.Savable=1
		if(o.name=="Mine")
			o.truefaction=m.faction
			o.owner=m.faction
			o.faction=m.faction
			m.contents-=o
			o.x=m.x
			o.y=m.y
			o.z=m.z
			o.Savable=1
		if(o.name=="Log House")
			o.truefaction=m.faction
			o.owner=m.faction
			o.faction=m.faction
			m.contents-=o
			o.x=m.x
			o.y=m.y
			o.z=m.z
			o.Savable=1
		if(o.name=="Hunting Lodge")
			o.truefaction=m.faction
			o.owner=m.faction
			o.faction=m.faction
			m.contents-=o
			o.x=m.x
			o.y=m.y
			o.z=m.z
			o.Savable=1
		if(o.name=="Shop Table")
			for(var/obj/playershops/shoptable/w in m.contents)
				if(o==w)
					w.shopowner=usr.ckey
				o.Savable=1
				m.contents-=o
				o.x=m.x
				o.y=m.y
				o.z=m.z
		if(o.name=="Commerce Center")
			o.truefaction=m.faction
			o.owner=m.faction
			o.faction=m.faction
			m.contents-=o
			o.x=m.x
			o.y=m.y
			o.z=m.z
			o.Savable=1
		if(o.name=="Farm")
			o.truefaction=m.faction
			o.owner=m.faction
			o.faction=m.faction
			m.contents-=o
			o.x=m.x
			o.y=m.y
			o.z=m.z
			o.Savable=1
		if(o.name=="Mana Pylon")
			o.truefaction=m.faction
			o.owner=m.faction
			o.faction=m.faction
			m.contents-=o
			o.x=m.x
			o.y=m.y
			o.z=m.z
			o.Savable=1
		if(o.name=="Somnus Statue")
			o.truefaction=m.faction
			o.owner=m.faction
			o.faction=m.faction
			m.contents-=o
			o.x=m.x
			o.y=m.y
			o.z=m.z
			o.Savable=1
		if(o.name=="Mako Reactor")
			o.truefaction=m.faction
			o.owner=m.faction
			o.faction=m.faction
			m.contents-=o
			o.x=m.x
			o.y=m.y
			o.z=m.z
			o.Savable=1
		if(o.name=="Shell Generator")
			o.truefaction=m.faction
			o.owner=m.faction
			o.faction=m.faction
			m.contents-=o
			o.x=m.x
			o.y=m.y
			o.z=m.z
			o.Savable=1
		if(o.name=="Shrine of Yevon")
			o.truefaction=m.faction
			o.owner=m.faction
			o.faction=m.faction
			m.contents-=o
			o.x=m.x
			o.y=m.y
			o.z=m.z
			o.Savable=1
		if(o.name=="Statue of Fayth")
			o.truefaction=m.faction
			o.owner=m.faction
			o.faction=m.faction
			m.contents-=o
			o.x=m.x
			o.y=m.y
			o.z=m.z
			o.Savable=1
		if(o.name=="Statue of the Fal'Cie")
			o.truefaction=m.faction
			o.owner=m.faction
			o.faction=m.faction
			m.contents-=o
			o.x=m.x
			o.y=m.y
			o.z=m.z
			o.Savable=1
		if(o.name=="Treasury")
			o.truefaction=m.faction
			o.owner=m.faction
			o.faction=m.faction
			m.contents-=o
			o.x=m.x
			o.y=m.y
			o.z=m.z
			o.Savable=1
		if(o.name=="Inspiring Banner")
			o.truefaction=m.faction
			o.owner=m.faction
			o.faction=m.faction
			m.contents-=o
			o.x=m.x
			o.y=m.y
			o.z=m.z
			o.Savable=1
		if(o.name=="Knight Statue")
			o.truefaction=m.faction
			o.owner=m.faction
			o.faction=m.faction
			m.contents-=o
			o.x=m.x
			o.y=m.y
			o.z=m.z
			o.Savable=1
		if(o.name=="Black Mage Statue")
			o.truefaction=m.faction
			o.owner=m.faction
			o.faction=m.faction
			m.contents-=o
			o.x=m.x
			o.y=m.y
			o.z=m.z
			o.Savable=1
		if(o.name=="Rogue Statue")
			o.truefaction=m.faction
			o.owner=m.faction
			o.faction=m.faction
			m.contents-=o
			o.x=m.x
			o.y=m.y
			o.z=m.z
			o.Savable=1
		if(o.name=="White Mage Statue")
			o.truefaction=m.faction
			o.owner=m.faction
			o.faction=m.faction
			m.contents-=o
			o.x=m.x
			o.y=m.y
			o.z=m.z
			o.Savable=1
		if(o.name=="Red Mage Statue")
			o.truefaction=m.faction
			o.owner=m.faction
			o.faction=m.faction
			m.contents-=o
			o.x=m.x
			o.y=m.y
			o.z=m.z
			o.Savable=1
		if(o.name=="House")
			o.faction=m.faction
			for(var/turf/t in range(8,usr))
				t.owner=usr.key
			var/pass=input(m,"What is the password for this House?") as text
			o.password=pass
			o.owner=usr.key
			o.name="[usr.name]'s Home"
			usr.housemade=1
			totalhouses+=1
			m.contents-=o
			o.loc=m.loc
			o.Savable=1
		if(o.name=="Fortress")
			for(var/turf/t in range(15,usr))
				t.owner=usr.key
			var/pass=input(m,"What is the password for this Fortress?") as text
			o.password=pass
			o.name="[usr.faction] Fortress"
			o.faction=usr.faction
			o.owner=usr.key
			totalfortresses+=1
			m.contents-=o
			o.loc=m.loc
			o.Savable=1
		if(darecipe.robot==1)
			o.owner=m.key
			view() << output("<font color=[m.textcolor]><b>[m.name]<b></font> creates 1 <b><font color=#56ECC6>[o.name]</font></b>!","icout")
			UpdateCraft(m)
			return
		else
			view() << output("<font color=[m.textcolor]><b>[m.name]<b></font> creates 1 <b><font color=#56ECC6>[o.name]</font></b>!","icout")
			UpdateCraft(m)
			return
	else
		return

/obj/recipes/proc/Recipeview(var/mob/m,var/obj/recipes/b)
	ViewRecipe(m, b)

/obj/recipes/proc/CheckComp(var/mob/m,var/obj/recipes/a)
	if(mat1!=null)
		if(src.FindMat(m,1))
			var/obj/item/check1=DetermineMat(m,1,a)
			if(check1.amount>=amount1)

			else
				alert(m,"You do not have enough [mat1]")
				return 0
		else
			alert(usr,"You do not have any [mat1]")
			return 0
	if(mat2!=null)
		if(src.FindMat(m,2))
			var/obj/item/check2=DetermineMat(m,2,a)
			if(check2.amount>=amount2)

			else
				alert(m,"You do not have enough [mat2]")
				return 0
		else
			alert(m,"You do not have any [mat2]")
			return 0
	if(mat3!=null)
		if(src.FindMat(m,3))
			var/obj/item/check3=DetermineMat(m,3,a)
			if(check3.amount>=amount3)

			else
				alert(m,"You do not have enough [mat3]")
				return 0
		else
			alert(m,"You do not have any [mat3]")
			return 0
	if(mat4!=null)
		if(src.FindMat(m,4))
			var/obj/item/check4=DetermineMat(m,4,a)
			if(check4.amount>=amount4)

			else
				alert(usr,"You do not have enough [mat4]")
				return 0
		else
			alert(usr,"You do not have any [mat4]")
			return 0
	if(mat5!=null)
		if(src.FindMat(m,5))
			var/obj/item/check5=DetermineMat(m,5,a)
			if(check5.amount>=amount5)

			else
				alert(m,"You do not have enough [mat5]")
				return 0
		else
			alert(m,"You do not have any [mat5]")
			return 0
	if(mat6!=null)
		if(src.FindMat(m,6))
			var/obj/item/check6=DetermineMat(m,6,a)
			if(check6.amount>=amount6)

			else
				alert(m,"You do not have enough [mat6]")
				return 0
		else
			alert(m,"You do not have any [mat6]")
			return 0
	if(mat7!=null)
		if(src.FindMat(m,7))
			var/obj/item/check7=DetermineMat(m,7,a)
			if(check7.amount>=amount7)

			else
				alert(usr,"You do not have enough [mat7]")
				return 0
		else
			alert(usr,"You do not have any [mat7]")
			return 0
	if(mat8!=null)
		if(src.FindMat(m,8))
			var/obj/item/check8=DetermineMat(m,8,a)
			if(check8.amount>=amount8)

			else
				alert(m,"You do not have enough [mat8]")
				return 0
		else
			alert(usr,"You do not have any [mat8]")
			return 0
	if(mat9!=null)
		if(src.FindMat(m,9))
			var/obj/item/check9=DetermineMat(m,9,a)
			if(check9.amount>=amount9)

			else
				alert(usr,"You do not have enough [mat9]")
				return 0
		else
			alert(usr,"You do not have any [mat9]")
			return 0
	if(mat10!=null)
		if(src.FindMat(m,10))
			var/obj/item/check10=DetermineMat(m,10,a)
			if(check10.amount>=amount10)

			else
				alert(m,"You do not have enough [mat10]")
				return 0
		else
			alert(m,"You do not have any [mat10]")
			return 0
	return 1

/obj/recipes/proc/FindMat(var/mob/m,var/no)
	var/namestring
	var/matstring
	switch(no)
		if(1)
			matstring=mat1
		if(2)
			matstring=mat2
		if(3)
			matstring=mat3
		if(4)
			matstring=mat4
		if(5)
			matstring=mat5
		if(6)
			matstring=mat6
		if(7)
			matstring=mat7
		if(8)
			matstring=mat8
		if(9)
			matstring=mat9
		if(10)
			matstring=mat10
	for(var/obj/item/i in m.contents)
		namestring=i.name
		if("[namestring]"=="[matstring]")
			return 1
	return 0

/obj/recipes
	Chemist
		Potions
			Potion
				name="Potion"
				mat1="Gysahl Greens"
				amount1=2
				New()
					var/obj/item/Chemist/Potion/a=new
					src.creates=a
					src.name=a.name
			Ether
				mat1="Ether Powder"
				mat2="Garidav Wildgrass"
				amount1=1
				amount2=1
				New()
					var/obj/item/Chemist/Ether/a=new
					src.creates=a
					src.name=a.name
			Poison
				mat1="Bio Gem"
				mat2="Coeurl Whisker"
				mat3="Tonberry Knife"
				amount1=1
				amount2=1
				amount3=1
				New()
					var/obj/item/Chemist/Poison/a=new
					src.creates=a
					src.name=a.name
			SilencePoison
				mat1="Pixie Sand"
				mat2="Sahaugin Scale"
				mat3="Diamond"
				mat4="Flying Eye's Wing"
				amount1=1
				amount2=1
				amount3=1
				amount4=1
				New()
					var/obj/item/Chemist/SilencePoison/a=new
					src.creates=a
					src.name=a.name
			BlindPoison
				mat1="Flying Eye's Eye"
				mat2="Vomp Carrots"
				mat3="Ether Powder"
				amount1=1
				amount2=3
				amount3=2
				New()
					var/obj/item/Chemist/BlindPoison/a=new
					src.creates=a
					src.name=a.name
			FrogPoison
				mat1="Dark Gem"
				mat2="San d'Orian Carrots"
				mat3="Gigantoad Slime"
				amount1=2
				amount2=3
				amount3=5
				New()
					var/obj/item/Chemist/FrogPoison/a=new
					src.creates=a
					src.name=a.name
			BerserkPoison
				mat1="Fire Gem"
				mat2="Vomp Carrots"
				amount1=2
				amount2=5
				New()
					var/obj/item/Chemist/BerserkPoison/a=new
					src.creates=a
					src.name=a.name
			Antidote
				mat1="Bio Gem"
				mat2="Gysahl Greens"
				amount1=1
				amount2=3
				New()
					var/obj/item/Chemist/Antidote/a=new
					src.creates=a
					src.name=a.name
			EchoHerbs
				mat1="Holy Gem"
				mat2="Vomp Carrots"
				mat3="Ether Powder"
				amount1=1
				amount2=3
				amount3=2
				New()
					var/obj/item/Chemist/Echoherbs/a=new
					src.creates=a
					src.name=a.name
			Eyedrops
				mat1="Dark Gem"
				mat2="Vomp Carrots"
				mat3="Aether Powder"
				mat4="Flying Eye's Eye"
				amount1=1
				amount2=3
				amount3=2
				amount4=5
				New()
					var/obj/item/Chemist/Eyedrops/a=new
					src.creates=a
					src.name=a.name
			HiPotion
				mat1="White Gem"
				mat2="Vomp Carrots"
				mat3="Ether Powder"
				amount1=2
				amount2=3
				amount3=5
				New()
					var/obj/item/Chemist/HiPotion/a=new
					src.creates=a
					src.name=a.name
			RegenOrb
				mat1="White Gem"
				mat2="Sharug Greens"
				mat3="Ether Powder"
				mat4="Coeurl Whisker"
				amount1=5
				amount2=3
				amount3=2
				amount4=1
				New()
					var/obj/item/Chemist/RegenOrb/a=new
					src.creates=a
					src.name=a.name
			MaxEther
				mat1="Black Gem"
				mat2="Vomp Carrots"
				mat3="Ether Powder"
				amount1=5
				amount2=3
				amount3=2
				New()
					var/obj/item/Chemist/MaxEther/a=new
					src.creates=a
					src.name=a.name
			RefreshOrb
				mat1="White Gem"
				mat2="Sharug Greens"
				mat3="Ether Powder"
				mat4="Sahaugin Scale"
				amount1=5
				amount2=3
				amount3=2
				amount4=1
				New()
					var/obj/item/Chemist/RefreshOrb/a=new
					src.creates=a
					src.name=a.name
			GoldNeedle
				mat1="Gold Ingot"
				mat2="Sharug Greens"
				mat3="Diamond"
				amount1=1
				amount2=3
				amount3=1
				New()
					var/obj/item/Chemist/Goldneedle/a=new
					src.creates=a
					src.name=a.name
			MaidensKiss
				mat1="Zegham Carrots"
				mat2="Vomp Carrots"
				mat3="Diamond"
				amount1=2
				amount2=2
				amount3=1
				New()
					var/obj/item/Chemist/Maidenskiss/a=new
					src.creates=a
					src.name=a.name
			Tranquilizer
				mat1="Topkekko Wildgrass"
				mat2="Diamond"
				amount1=2
				amount2=1
				New()
					var/obj/item/Chemist/Tranquilizer/a=new
					src.creates=a
					src.name=a.name
			Remedy
				mat1="Gysahl Greens"
				mat2="Sharug Greens"
				mat3="Ether Powder"
				mat4="Zuu Feather"
				amount1=5
				amount2=3
				amount3=2
				amount4=1
				New()
					var/obj/item/Chemist/Remedy/a=new
					src.creates=a
					src.name=a.name
			XPotion
				mat1="Gysahl Greens"
				mat2="Gigantoad Slime"
				mat3="Vomp Carrots"
				mat4="Coeurl Whisker"
				amount4=1
				amount1=8
				amount2=1
				amount3=1
				New()
					var/obj/item/Chemist/XPotion/a=new
					src.creates=a
					src.name=a.name
			PhoenixDown
				mat1="Phoenix Down"
				amount1=1
				mat2="Pixie Sand"
				amount2=50
				New()
					var/obj/item/Chemist/PhoenixDown/a=new
					src.creates=a
					src.name=a.name
			ElixirofYouth
				mat1="Phoenix Feather"
				mat1=1
				mat2="Pixie Sand"
				amount2=100
				New()
					var/obj/item/Chemist/ElixirofYouth/a=new
					src.creates=a
					src.name=a.name
		Bombs
			FireBomb
				name="Fire Bomb Bag"
				mat1="Steel Ingot"
				mat2="Aether Powder"
				mat3="Fire Gem"
				amount1=5
				amount2=3
				amount3=1
				mat4="Leather"
				amount4=10
				mat5="Wool"
				mat6="Bomb Core"
				amount6=1
				New()
					var/obj/item/Weapon/Chemist/FireBomb/a=new
					src.creates=a
					src.name=a.name
			WaterBomb
				name="Water Bomb Bag"
				mat1="Steel Ingot"
				mat2="Aether Powder"
				mat3="Water Gem"
				amount1=5
				amount2=3
				amount3=1
				mat4="Leather"
				amount4=10
				mat5="Wool"
				mat6="Bomb Core"
				amount6=1
				New()
					var/obj/item/Weapon/Chemist/WaterBomb/a=new
					src.creates=a
					src.name=a.name
			ThunderBomb
				name="Thunder Bomb Bag"
				mat1="Steel Ingot"
				mat2="Aether Powder"
				mat3="Thunder Gem"
				amount1=5
				amount2=3
				amount3=1
				mat4="Leather"
				amount4=10
				mat5="Wool"
				mat6="Bomb Core"
				amount6=1
				New()
					var/obj/item/Weapon/Chemist/ThunderBomb/a=new
					src.creates=a
					src.name=a.name
			EarthBomb
				name="Earth Bomb Bag"
				mat1="Steel Ingot"
				mat2="Aether Powder"
				mat3="Earth Gem"
				amount1=5
				amount2=3
				amount3=1
				mat4="Leather"
				amount4=10
				mat5="Wool"
				mat6="Bomb Core"
				amount6=1
				New()
					var/obj/item/Weapon/Chemist/EarthBomb/a=new
					src.creates=a
					src.name=a.name
			IceBomb
				name="Ice Bomb Bag"
				mat1="Steel Ingot"
				mat2="Aether Powder"
				mat3="Ice Gem"
				amount1=5
				amount2=3
				amount3=1
				mat4="Leather"
				amount4=10
				mat5="Wool"
				mat6="Bomb Core"
				amount6=1
				New()
					var/obj/item/Weapon/Chemist/IceBomb/a=new
					src.creates=a
					src.name=a.name
			BioBomb
				name="Bio Bomb Bag"
				mat1="Steel Ingot"
				mat2="Aether Powder"
				mat3="Bio Gem"
				amount1=5
				amount2=3
				amount3=1
				mat4="Leather"
				amount4=10
				mat5="Wool"
				mat6="Bomb Core"
				amount6=1
				New()
					var/obj/item/Weapon/Chemist/BioBomb/a=new
					src.creates=a
					src.name=a.name
			WindBomb
				name="Wind Bomb Bag"
				mat1="Steel Ingot"
				mat2="Aether Powder"
				mat3="Wind Gem"
				amount1=5
				amount2=3
				amount3=1
				mat4="Leather"
				amount4=10
				mat5="Wool"
				mat6="Bomb Core"
				amount6=1
				New()
					var/obj/item/Weapon/Chemist/WindBomb/a=new
					src.creates=a
					src.name=a.name
			DarkBomb
				name="Dark Bomb Bag"
				mat1="Steel Ingot"
				mat2="Aether Powder"
				mat3="Dark Gem"
				amount1=5
				amount2=3
				amount3=1
				mat4="Leather"
				amount4=10
				mat5="Wool"
				mat6="Bomb Core"
				amount6=1
				New()
					var/obj/item/Weapon/Chemist/DarkBomb/a=new
					src.creates=a
					src.name=a.name
			HolyBomb
				name="Holy Bomb Bag"
				mat1="Steel Ingot"
				mat2="Aether Powder"
				mat3="Holy Gem"
				mat4="Leather"
				amount4=10
				mat5="Wool"
				mat6="Bomb Core"
				amount6="1"
				amount5=5
				amount1=5
				amount2=3
				amount3=1
				New()
					var/obj/item/Weapon/Chemist/HolyBomb/a=new
					src.creates=a
					src.name=a.name

	Machinist
		Manual
			mat1="Wood"
			amount1=5
			mat2="Raw Mako"
			amount2=2
			New()
				var/obj/item/Machinist/Manual/a=new
				src.name=a.name
				src.creates=a
		Terraformer
			mat1="Steel Ingot"
			amount1=2
			mat2="Raw Mako"
			amount2=1
			New()
				var/obj/item/Machinist/Terraformer/a=new
				src.creates=a
				src.name=a.name
		Linkshell
			mat1="Mythril Ingot"
			amount1=1
			New()
				var/obj/item/Machinist/Linkshell/a=new
				src.creates=a
				src.name=a.name
		Speaker
			mat1="Steel Ingot"
			amount1=1
			New()
				var/obj/item/Machinist/Speaker/a=new
				src.creates=a
				src.name=a.name
		Weapons
			T1
				BallisticPistol
					mat1="Steel Ingot"
					amount1=5
					mat2="Mythril Ingot"
					amount2=5
					mat3="Adamantine Ingot"
					amount3=1
					mat4="Tonberry Knife"
					amount4=1
					New()
						var/obj/item/Weapon/Machinist/BallisticPistol/a=new
						src.creates=a
						src.name=a.name
				Wrench
					mat1="Steel Ingot"
					amount1=1
					mat2="Bronze Ingot"
					amount2=1
					mat3="Fire Gem"
					amount3=1
					New()
						var/obj/item/Weapon/Machinist/Wrench/a=new
						src.creates=a
						src.name=a.name
				Chainsaw
					mat1="Steel Ingot"
					amount1=5
					mat2="Mythril Ingot"
					amount2=1
					mat3="Earth Gem"
					amount3=1
					New()
						var/obj/item/Weapon/Machinist/Chainsaw/a=new
						src.creates=a
						src.name=a.name
				Drillsword
					mat1="Steel Ingot"
					amount1=5
					mat2="Mythril Ingot"
					amount2=1
					mat3="Earth Gem"
					amount3=1
					New()
						var/obj/item/Weapon/Machinist/Drillsword/a=new
						src.creates=a
						src.name=a.name
				Drillspear
					mat1="Steel Ingot"
					amount1=5
					mat2="Mythril Ingot"
					amount2=1
					mat3="Earth Gem"
					amount3=1
					New()
						var/obj/item/Weapon/Machinist/Drillspear/a=new
						src.creates=a
						src.name=a.name
				RocketLauncher
					mat1="Steel Ingot"
					amount1=5
					mat2="Mythril Ingot"
					amount2=1
					mat3="Fire Gem"
					amount3=1
					New()
						var/obj/item/Weapon/Machinist/RocketLauncher/a=new
						src.creates=a
						src.name=a.name
				Ammo
					Basic
						FireBullet
							mat1="Steel Ingot"
							amount1=3
							mat2="Mythril Ingot"
							amount2=1
							mat3="Fire Gem"
							amount3=1
							New()
								var/obj/item/Weapon/Machinist/Ammo/Basic/FireBullet/a=new
								src.creates=a
								src.name=a.name
						ThunderBullet
							mat1="Steel Ingot"
							amount1=3
							mat2="Mythril Ingot"
							amount2=1
							mat3="Thunder Gem"
							amount3=1
							New()
								var/obj/item/Weapon/Machinist/Ammo/Basic/ThunderBullet/a=new
								src.creates=a
								src.name=a.name
						EarthBullet
							mat1="Steel Ingot"
							amount1=3
							mat2="Mythril Ingot"
							amount2=1
							mat3="Earth Gem"
							amount3=1
							New()
								var/obj/item/Weapon/Machinist/Ammo/Basic/EarthBullet/a=new
								src.creates=a
								src.name=a.name
						WaterBullet
							mat1="Steel Ingot"
							amount1=3
							mat2="Mythril Ingot"
							amount2=1
							mat3="Water Gem"
							amount3=1
							New()
								var/obj/item/Weapon/Machinist/Ammo/Basic/WaterBullet/a=new
								src.creates=a
								src.name=a.name
						LowAPRound
							mat1="Steel Ingot"
							amount1=3
							mat2="Mythril Ingot"
							amount2=1
							mat3="Tonberry Knife"
							amount3=1
							New()
								var/obj/item/Weapon/Machinist/Ammo/Basic/LowAPRound/a=new
								src.creates=a
								src.name=a.name
			T3
				Ammo
					Advanced
						AeroBullet
							mat1="Steel Ingot"
							amount1=5
							mat2="Adamantine Ingot"
							amount2=1
							mat3="Wind Gem"
							amount3=1
							New()
								var/obj/item/Weapon/Machinist/Ammo/Advanced/AeroBullet/a=new
								src.creates=a
								src.name=a.name
						IceBullet
							mat1="Steel Ingot"
							amount1=5
							mat2="Adamantine Ingot"
							amount2=1
							mat3="Ice Gem"
							amount3=1
							New()
								var/obj/item/Weapon/Machinist/Ammo/Advanced/IceBullet/a=new
								src.creates=a
								src.name=a.name
						BioBullet
							mat1="Steel Ingot"
							amount1=5
							mat2="Adamantine Ingot"
							amount2=1
							mat3="Bio Gem"
							amount3=1
							New()
								var/obj/item/Weapon/Machinist/Ammo/Advanced/BioBullet/a=new
								src.creates=a
								src.name=a.name
						DarkBullet
							mat1="Steel Ingot"
							amount1=5
							mat2="Adamantine Ingot"
							amount2=1
							mat3="Dark Gem"
							amount3=1
							New()
								var/obj/item/Weapon/Machinist/Ammo/Advanced/DarkBullet/a=new
								src.creates=a
								src.name=a.name
						HolyBullet
							mat1="Steel Ingot"
							amount1=5
							mat2="Adamantine Ingot"
							amount2=1
							mat3="Holy Gem"
							amount3=1
							New()
								var/obj/item/Weapon/Machinist/Ammo/Advanced/HolyBullet/a=new
								src.creates=a
								src.name=a.name
						HighAPRound
							mat1="Steel Ingot"
							amount1=5
							mat2="Adamantine Ingot"
							amount2=1
							mat3="Zuu Feather"
							amount3=1
							New()
								var/obj/item/Weapon/Machinist/Ammo/Advanced/HighAPRound/a=new
								src.creates=a
								src.name=a.name
					Nethicite
						mat1="Steel Ingot"
						amount1=10
						mat2="Adamantine Ingot"
						amount2=1
						mat3="Dark Gem"
						amount3=1
						mat4="Black Gem"
						amount4=1
						New()
							var/obj/item/Weapon/Machinist/Ammo/Nethicite/a=new
							src.creates=a
							src.name=a.name
				LaserOffenseOrb
					mat1="Steel Ingot"
					amount1=10
					mat2="Mythril Ingot"
					amount2=1
					mat3="Thunder Gem"
					amount3=1
					mat4="Black Gem"
					amount4=1
					New()
						var/obj/item/Weapon/Machinist/LaserOffenseOrb/a=new
						src.creates=a
						src.name=a.name
				LaserDefenseOrb
					mat1="Steel Ingot"
					amount1=10
					mat2="Mythril Ingot"
					amount2=1
					mat3="Thunder Gem"
					amount3=1
					mat4="White Gem"
					amount4=1
					New()
						var/obj/item/Weapon/Machinist/LaserDefenseOrb/a=new
						src.creates=a
						src.name=a.name
				Taser
					mat1="Steel Ingot"
					amount1=4
					mat2="Mythril Ingot"
					amount2=2
					mat3="Thunder Gem"
					amount3=1
					New()
						var/obj/item/Weapon/Machinist/Taser/a=new
						src.creates=a
						src.name=a.name
				WreckingBall
					mat1="Steel Ingot"
					amount1=15
					mat2="Mythril Ingot"
					amount2=1
					mat3="Earth Gem"
					amount3=1
					New()
						var/obj/item/Weapon/Machinist/WreckingBall/a=new
						src.creates=a
						src.name=a.name
				BeamCannon
					mat1="Steel Ingot"
					amount1=8
					mat2="Mythril Ingot"
					amount2=15
					mat3="Dark Gem"
					amount3=1
					New()
						var/obj/item/Weapon/Machinist/BeamCannon/a=new
						src.creates=a
						src.name=a.name
				EnergySword
					mat1="Steel Ingot"
					amount1=10
					mat2="Mythril Ingot"
					amount2=5
					mat3="Holy Gem"
					amount3=1
					mat4="Adamantine Ingot"
					amount4=2
					New()
						var/obj/item/Weapon/Machinist/EnergySword/a=new
						src.creates=a
						src.name=a.name
				Flamethrower
					mat1="Steel Ingot"
					amount1=5
					mat2="Mythril Ingot"
					amount2=3
					mat3="Fire Gem"
					amount3=1
					New()
						var/obj/item/Weapon/Machinist/Flamethrower/a=new
						src.creates=a
						src.name=a.name
				BioBlaster
					mat1="Steel Ingot"
					amount1=5
					mat2="Mythril Ingot"
					amount2=3
					mat3="Bio Gem"
					amount3=1
					New()
						var/obj/item/Weapon/Machinist/BioBlaster/a=new
						src.creates=a
						src.name=a.name
		Upgrades
			T2
				Cores
					PowerCore
						mat1="Iron Ingot"
						amount1=10
						mat2="Steel Ingot"
						amount2=10
						mat3="Fire Gem"
						amount3=1
						mat4="Mythril Ingot"
						amount4=2
						New()
							var/obj/item/Machinist/Cores/PowerCore/a=new
							src.creates=a
							src.name=a.name
					DefenseCore
						mat1="Iron Ingot"
						amount1=10
						mat2="Steel Ingot"
						amount2=10
						mat3="Earth Gem"
						amount3=1
						mat4="Mythril Ingot"
						amount4=2
						New()
							var/obj/item/Machinist/Cores/DefenseCore/a=new
							src.creates=a
							src.name=a.name
					SpeedCore
						mat1="Iron Ingot"
						amount1=10
						mat2="Steel Ingot"
						amount2=10
						mat3="Wind Gem"
						amount3=1
						mat4="Mythril Ingot"
						amount4=2
						New()
							var/obj/item/Machinist/Cores/SpeedCore/a=new
							src.creates=a
							src.name=a.name
				Modules
					Strength
						mat1="Iron Ingot"
						amount1=10
						mat2="Steel Ingot"
						amount2=10
						mat3="Fire Gem"
						amount3=1
						New()
							var/obj/item/Machinist/Modules/StrengthModule/a=new
							src.creates=a
							src.name=a.name
					Wisdom
						mat1="Iron Ingot"
						amount1=10
						mat2="Steel Ingot"
						amount2=10
						mat3="Ice Gem"
						amount3=1
						New()
							var/obj/item/Machinist/Modules/WisdomModule/a=new
							src.creates=a
							src.name=a.name
			T3
				Cores
					ElementalCore
						mat1="Iron Ingot"
						amount1=10
						mat2="Steel Ingot"
						amount2=10
						mat3="Black Gem"
						amount3=1
						mat4="Mythril Ingot"
						amount4=5
						New()
							var/obj/item/Machinist/Cores/ElementalCore/a=new
							src.contents+=a
							src.name=a.name
					HPCore
						mat1="Iron Ingot"
						amount1=10
						mat2="Steel Ingot"
						amount2=10
						mat3="Holy Gem"
						amount3=1
						mat4="Mythril Ingot"
						amount4=5
						New()
							var/obj/item/Machinist/Cores/HPCore/a=new
							src.contents+=a
							src.name=a.name
				Modules
					Dexterity
						mat1="Iron Ingot"
						amount1=10
						mat2="Steel Ingot"
						amount2=10
						mat3="Wind Gem"
						amount3=1
						New()
							var/obj/item/Machinist/Modules/DexterityModule/a=new
							src.creates=a
							src.name=a.name
					Constitution
						mat1="Iron Ingot"
						amount1=10
						mat2="Steel Ingot"
						amount2=10
						mat3="Earth Gem"
						amount3=1
						New()
							var/obj/item/Machinist/Modules/ConstitutionModule/a=new
							src.creates=a
							src.name=a.name
					Intelligence
						mat1="Iron Ingot"
						amount1=10
						mat2="Steel Ingot"
						amount2=10
						mat3="Thunder Gem"
						amount3=1
						New()
							var/obj/item/Machinist/Modules/IntelligenceModule/a=new
							src.creates=a
							src.name=a.name
					Charisma
						mat1="Iron Ingot"
						amount1=10
						mat2="Steel Ingot"
						amount2=10
						mat3="Water Gem"
						amount3=1
						New()
							var/obj/item/Machinist/Modules/CharismaModule/a=new
							src.creates=a
							src.name=a.name
			T4
				Augment
					mat1="Iron Ingot"
					amount1=15
					mat2="Steel Ingot"
					amount2=20
					mat3="Gold Ingot"
					amount3=5
					New()
						var/obj/item/Machinist/Augment/CyberneticAugmentation/a=new
						src.creates=a
						src.name=a.name
		Misc
			T3
				ForceFieldEmitter
					mat1="Iron Ingot"
					amount1=10
					mat2="Steel Ingot"
					amount2=5
					mat3="Raw Mako"
					amount3=1
					mat4="Bronze Ingot"
					amount4=1
					New()
						var/obj/item/Machinist/ForceFieldEmitter/a=new
						src.creates=a
						src.name=a.name
				ForceFieldRemote
					mat1="Iron Ingot"
					amount1=4
					mat2="Bronze Ingot"
					amount2=5
					New()
						var/obj/item/Machinist/ForceFieldRemote/a=new
						src.creates=a
						src.name=a.name

		Robots
			T2
				Defender
					mat1="Iron Ingot"
					amount1=10
					mat2="Steel Ingot"
					amount2=5
					mat3="Raw Mako"
					amount3=1
					mat4="Bronze Ingot"
					amount4=1
					New()
						var/obj/npc/Robots/T2/Defender/a=new
						src.creates=a
				Striker
					mat1="Iron Ingot"
					amount1=10
					mat2="Steel Ingot"
					amount2=5
					mat3="Raw Mako"
					amount3=1
					mat4="Bronze Ingot"
					amount4=1
					New()
						var/obj/npc/Robots/T2/Striker/a=new
						src.creates=a
			T3
				Blitzer
					mat1="Iron Ingot"
					amount1=15
					mat2="Steel Ingot"
					amount2=10
					mat3="Raw Mako"
					amount3=2
					mat4="Bronze Ingot"
					amount4=5
					New()
						var/obj/npc/Robots/T3/Blitzer/a=new
						src.creates=a
				Guardian
					mat1="Iron Ingot"
					amount1=15
					mat2="Steel Ingot"
					amount2=10
					mat3="Raw Mako"
					amount3=2
					mat4="Bronze Ingot"
					amount4=5
					New()
						var/obj/npc/Robots/T3/Guardian/a=new
						src.creates=a
		Magitek
			T4
				MagitekArmor
					mat1="Iron Ingot"
					amount1=15
					mat2="Steel Ingot"
					amount2=10
					mat3="Raw Mako"
					amount3=5
					mat4="Bronze Ingot"
					amount4=5
					mat5="Mythril Ingot"
					amount5=10
					mat6="Adamantine Ingot"
					amount6=10
					New()
						var/obj/npc/Robots/T4/MagitekArmor/a=new
						src.creates=a
						src.name=a.name
			T5
				MagitekMecha
					mat1="Iron Ingot"
					amount1=50
					mat2="Steel Ingot"
					amount2=35
					mat3="Raw Mako"
					amount3=10
					mat4="Bronze Ingot"
					amount4=10
					mat5="Mythril Ingot"
					amount5=20
					mat6="Adamantine Ingot"
					amount6=20
					New()
						var/obj/npc/Robots/T5/MagitekMecha/a=new
						src.creates=a
						src.name=a.name
		Vehicles
			Landrover
				mat1="Wood"
				amount1=100
				mat2="Stone"
				amount2=150
				mat3="Steel Ingot"
				amount3=50
				mat4="Mythril Ingot"
				amount4=5
				mat5="Raw Mako"
				amount5=5
				mat6="Leather"
				amount6=50
				mat7="Earth Gem"
				amount7=10
				New()
					var/obj/Vehicles/Tech/Travel/Rover/a=new
					src.creates=a
					src.name=a.name
			Ship
				mat1="Wood"
				amount1=80
				mat2="Wool"
				amount2=50
				mat3="Steel Ingot"
				amount3=50
				mat4="Mythril Ingot"
				amount4=2
				mat5="Raw Mako"
				amount5=5
				mat6="Leather"
				amount6=50
				mat7="Water Gem"
				amount7=10
				New()
					var/obj/Vehicles/Tech/Travel/Caravel/a=new
					src.creates=a
					src.name=a.name
			Airship
				mat1="Wood"
				amount1=100
				mat2="Wool"
				amount2=150
				mat3="Steel Ingot"
				amount3=50
				mat4="Mythril Ingot"
				amount4=15
				mat5="Raw Mako"
				amount5=35
				mat6="Leather"
				amount6=50
				mat7="Wind Gem"
				amount7=25
				New()
					var/obj/Vehicles/Tech/Travel/Airship/a=new
					src.creates=a
					src.name=a.name


	Buildings
		PersonalShop
			mat1="Wood"
			amount1=5
			mat2="Stone"
			amount2=5
			New()
				var/obj/playershops/shoptable/a=new
				src.creates=a
				src.name=a.name
		House
			mat1="Wood"
			amount1=100
			mat2="Stone"
			amount2=50
			mat3="Steel Ingot"
			amount3=5
			mat4="Leather"
			amount4=15
			mat5="Wool"
			amount5=15
			New()
				var/obj/House/a=new
				src.creates=a
		Fortress
			mat1="Wood"
			amount1=500
			mat2="Stone"
			amount2=250
			mat3="Steel Ingot"
			amount3=15
			mat4="Mythril Ingot"
			amount4=10
			mat5="Leather"
			amount5=30
			mat6="Wool"
			amount6=30
			New()
				var/obj/Fortress/a=new
				src.creates=a
		Faction
			Global
				Fategiver
					name="FATE Giver"
					mat1="Wool"
					mat2="Leather"
					mat3="Stone"
					amount1=5
					amount2=5
					amount3=5
					New()
						var/obj/FATEGiver/a=new
						src.creates=a
				Recruiter
					name="Military Recruiter"
					mat1="Mythril Ingot"
					mat2="Gold Ingot"
					mat3="Silver Ingot"
					amount1=5
					amount2=5
					amount3=5
					New()
						var/obj/Factionupgrades/Global/Recruiter/a=new
						src.creates=a
				Mine
					mat1="Wood"
					mat2="Stone"
					mat3="Steel Ingot"
					mat4="Mythril Ingot"
					amount1=100
					amount2=100
					amount3=5
					amount3=5
					New()
						var/obj/Factionupgrades/Global/Mine/a=new
						src.creates=a
				Loghouse
					mat1="Wood"
					mat2="Stone"
					mat3="Steel Ingot"
					amount1=80
					amount2=50
					amount3=5
					New()
						var/obj/Factionupgrades/Global/Loghouse/a=new
						src.creates=a
						src.name=a.name
				HuntingLodge
					mat1="Wood"
					mat2="Stone"
					mat3="Leather"
					amount1=80
					amount2=50
					amount3=5
					New()
						var/obj/Factionupgrades/Global/HuntingLodge/a=new
						src.creates=a
						src.name=a.name
				Commercecenter
					mat1="Wood"
					mat2="Stone"
					mat3="Steel Ingot"
					mat4="Mythril Ingot"
					mat5="Gold Ingot"
					amount1=50
					amount2=50
					amount3=5
					amount4=5
					amount5=3
					New()
						var/obj/Factionupgrades/Global/Commercecenter/a=new
						src.creates=a
						src.name=a.name
				Farm
					mat1="Wood"
					mat2="Stone"
					mat3="Leather"
					mat4="Wool"
					amount1=50
					amount2=50
					amount3=3
					amount4=2
					New()
						var/obj/Factionupgrades/Global/Farm/a=new
						src.creates=a
						src.name=a.name
			Insomnia
				ManaPylon
					mat1="Ether Powder"
					mat2="Mythril Ingot"
					amount1=10
					amount2=5
					New()
						var/obj/Factionupgrades/Insomnia/ManaPylon/a=new
						src.creates=a
						src.name=a.name
				SomnusStatue
					mat1="Stone"
					mat2="Aether Powder"
					amount1=60
					amount2=100
					New()
						var/obj/Factionupgrades/Insomnia/SomnusStatue/a=new
						src.creates=a
						src.name=a.name
			Midgar
				MakoReactor
					mat1="Raw Mako"
					mat2="Steel Ingot"
					mat3="Silver Ingot"
					amount1=10
					amount2=20
					amount3=15
					New()
						var/obj/Factionupgrades/Midgar/MakoReactor/a=new
						src.creates=a
						src.name=a.name
				ShellGenerator
					mat1="Earth Gem"
					amount1=5
					mat2="Steel Ingot"
					amount2=15
					mat3="Mythril Ingot"
					amount3=8
					New()
						var/obj/Factionupgrades/Midgar/ShellGenerator/a=new
						src.creates=a
						src.name=a.name
			Yevon
				YevonShrine
					mat1="Stone"
					mat2="Ether Powder"
					mat3="Mythril Ingot"
					amount1=100
					amount2=50
					amount3=15
					New()
						var/obj/Factionupgrades/Yevon/YevonShrine/a=new
						src.creates=a
						src.name=a.name
				FaythStatue
					mat1="Stone"
					mat2="Gold Ingot"
					mat3="Silver Ingot"
					amount1=100
					amount2=5
					amount3=5
					New()
						var/obj/Factionupgrades/Yevon/FaythStatue/a=new
						src.creates=a
						src.name=a.name
			Akademia
				StatueofFalcie
					mat1="Stone"
					mat2="Ether Powder"
					mat3="Silver Ingot"
					amount1=100
					amount2=5
					amount3=10
					New()
						var/obj/Factionupgrades/Akademia/StatueofFalcie/a=new
						src.creates=a
						src.name=a.name
			Independant
				Treasury
					mat1="Wood"
					mat2="Gold Ingot"
					mat3="Silver Ingot"
					amount1=100
					amount2=5
					amount3=5
					New()
						var/obj/Factionupgrades/Independant/Treasury/a=new
						src.creates=a
						src.name=a.name
				InspiringBanner
					mat1="Wood"
					mat2="Wool"
					mat3="Leather"
					amount1=100
					amount2=20
					amount3=20
					New()
						var/obj/Factionupgrades/Independant/InspiringBanner/a=new
						src.creates=a
						src.name=a.name
				WarriorStatue
					mat1="Stone"
					mat2="Gold Ingot"
					mat3="Silver Ingot"
					amount1=80
					amount2=5
					amount3=5
					New()
						var/obj/Factionupgrades/Independant/WarriorStatue/a=new
						src.creates=a
						src.name=a.name
				RogueStatue
					mat1="Stone"
					mat2="Gold Ingot"
					mat3="Silver Ingot"
					amount1=80
					amount2=5
					amount3=5
					New()
						var/obj/Factionupgrades/Independant/RogueStatue/a=new
						src.creates=a
						src.name=a.name
				BlackMageStatue
					mat1="Stone"
					mat2="Gold Ingot"
					mat3="Silver Ingot"
					amount1=80
					amount2=5
					amount3=5
					New()
						var/obj/Factionupgrades/Independant/BlackMageStatue/a=new
						src.creates=a
						src.name=a.name
				WhiteMageStatue
					mat1="Stone"
					mat2="Gold Ingot"
					mat3="Silver Ingot"
					amount1=80
					amount2=5
					amount3=5
					New()
						var/obj/Factionupgrades/Independant/WhiteMageStatue/a=new
						src.creates=a
						src.name=a.name
				RedMageStatue
					mat1="Stone"
					mat2="Gold Ingot"
					mat3="Silver Ingot"
					amount1=80
					amount2=5
					amount3=5
					New()
						var/obj/Factionupgrades/Independant/RedMageStatue/a=new
						src.creates=a
						src.name=a.name
