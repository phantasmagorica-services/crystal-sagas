mob
	var
		deletemode
		nocolorask

mob
	verb
		Opencustomize()
			var/row
			if(usr.intitlescreen)
				return
			winset(usr,"Customize.dummy1","cells=0x0")
			winset(usr,"Customize.dummy2","cells=0x0")
			winset(usr,"Customize","is-visible=true")
			for(var/obj/overlaydummy/A in usr.contents)
				row++
				src<<output(A,"dummy1:1,[row]")
			for(var/obj/overlaydummy2/B in usr.contents)
				src<<output(B,"dummy2:1,[row]")
			for(var/obj/overlaydummy3/C in usr.contents)
				src<<output(C,"dummy3")
		Showhair()
			var/row
			winset(usr,"Customize.Customizegrid","cells=0x0")
			for(var/A in Hairlist)
				row++
				src << output(A,"Customizegrid:1,[row]")
		Showshirt()
			var/row
			winset(usr,"Customize.Customizegrid","cells=0x0")
			for(var/A in Shirtlist)
				row++
				src << output(A,"Customizegrid:1,[row]")
		Showpant()
			var/row
			winset(usr,"Customize.Customizegrid","cells=0x0")
			for(var/A in Pantlist)
				row++
				src << output(A,"Customizegrid:1,[row]")
		Showneck()
			var/row
			winset(usr,"Customize.Customizegrid","cells=0x0")
			for(var/A in Neckware)
				row++
				src << output(A,"Customizegrid:1,[row]")
		Showweapon()
			var/row
			winset(usr,"Customize.Customizegrid","cells=0x0")
			for(var/A in Weaponlist)
				row++
				src << output(A,"Customizegrid:1,[row]")
		Showaccesory()
			var/row
			winset(usr,"Customize.Customizegrid","cells=0x0")
			for(var/A in Accessorylist)
				row++
				src << output(A,"Customizegrid:1,[row]")
		Showcustoms()
			var/row
			winset(usr,"Customize.Customizegrid","cells=0x0")
			for(var/A in usr.customoverlays)
				row++
				src << output(A,"Customizegrid:1,[row]")
		RemoveOverlays()
			usr.overlays = null
		Saveoverlays()
			switch(input("What slot would you like to save to?") in list("One","Two","Three","Cancel"))
				if("One")
					for(var/obj/overlaydummy/A in usr.contents)
						A.overlays=null
						sleep()
						A.overlays+=usr.overlays
						src<<output(A,"dummy1")
				if("Two")
					for(var/obj/overlaydummy2/B in usr.contents)
						B.overlays=null
						sleep()
						B.overlays+=usr.overlays
						src<<output(B,"dummy2")
				if("Three")
					for(var/obj/overlaydummy3/C in usr.contents)
						C.overlays=null
						sleep()
						C.overlays+=usr.overlays
						src<<output(C,"dummy3")
				if("Cancel")
					return
		Applycustom1()
			for(var/obj/overlaydummy/A in usr.contents)
				usr.overlays=null
				usr.overlays+=A.overlays
		Applycustom2()
			for(var/obj/overlaydummy2/A in usr.contents)
				usr.overlays=null
				usr.overlays+=A.overlays
		Applycustom3()
			for(var/obj/overlaydummy3/A in usr.contents)
				usr.overlays=null
				usr.overlays+=A.overlays
		Addcustomitem()
			var/obj/customs/added/A = new /obj/customs/added
			A.icon = input("Select an icon to use.","Change Icon") as null|icon
			if(A.icon==null)
				del(A)
				return
			A.name = input("Please set the name of your new item.") as text
			usr.customoverlays+=A
		ChangeFontColor()
			var/font = input("Please select your font color") as color
			if(!font)
				return 0
			else
				src.textcolor = font
		ChangeAoeIcon()
			var/aoe = input("Please select an icon to use.") as null|icon
			if(!aoe)
				return
			else
				usr.aoeicon = aoe
		Deletetoggle()
			if(usr.deletemode)
				alert("You are no longer in delete mode.")
				usr.deletemode=0
			else
				alert("You are now in delete mode. Click on an added piece of clothing to delete it. ")
				usr.deletemode=1
		NoColorToggle()
			if(usr.nocolorask)
				usr.nocolorask=0
			else
				alert("You will no longer be asked to change color when clicking an item.")
				usr.nocolorask=1
		SeeRPFlags()
			if(usr.see_invisible==1)
				usr.see_invisible=0
				usr<<output("RP flags are now invisible","oocout")
			else if(usr.see_invisible==0)
				usr.see_invisible=1
				usr<<output("RP flags are now visible","oocout")
		CustomBase()
			var/newicon = input(usr,"What would you like to change your Base icon to?") as icon
			usr.icon=newicon
		ChangeBase()
			switch(usr.race)
				if("Human")
					var/list/bases=list("Female Light","Female Dark","Female Pale","Male Light","Male Dark","Male Pale")
					var/skinchoice=input(usr,"Which base would you like to use?") as anything in bases
					switch(skinchoice)
						if("Female Light")
							usr.icon='Bases/Human/Base Female.dmi'
						if("Female Dark")
							usr.icon='Bases/Human/Base Female Dark.dmi'
						if("Female Pale")
							usr.icon='Bases/Human/Base Female Pale.dmi'
						if("Male Light")
							usr.icon='Bases/Human/Base Male.dmi'
						if("Male Dark")
							usr.icon='Bases/Human/Base Male Dark.dmi'
						if("Male Pale")
							usr.icon='Bases/Human/Base Male Pale.dmi'
				if("Elezen")
					var/list/bases=list("Female Light","Female Dark","Female Pale","Male Light","Male Dark","Male Pale")
					var/skinchoice=input(usr,"Which base would you like to use?") as anything in bases
					switch(skinchoice)
						if("Female Light")
							usr.icon='Bases/Human/Base Female.dmi'
						if("Female Dark")
							usr.icon='Bases/Human/Base Female Dark.dmi'
						if("Female Pale")
							usr.icon='Bases/Human/Base Female Pale.dmi'
						if("Male Light")
							usr.icon='Bases/Human/Base Male.dmi'
						if("Male Dark")
							usr.icon='Bases/Human/Base Male Dark.dmi'
						if("Male Pale")
							usr.icon='Bases/Human/Base Male Pale.dmi'
				if("Cetra")
					var/list/bases=list("Female Light","Female Dark","Female Pale","Male Light","Male Dark","Male Pale")
					var/skinchoice=input(usr,"Which base would you like to use?") as anything in bases
					switch(skinchoice)
						if("Female Light")
							usr.icon='Bases/Human/Base Female.dmi'
						if("Female Dark")
							usr.icon='Bases/Human/Base Female Dark.dmi'
						if("Female Pale")
							usr.icon='Bases/Human/Base Female Pale.dmi'
						if("Male Light")
							usr.icon='Bases/Human/Base Male.dmi'
						if("Male Dark")
							usr.icon='Bases/Human/Base Male Dark.dmi'
						if("Male Pale")
							usr.icon='Bases/Human/Base Male Pale.dmi'
				if("Guado")
					var/list/bases=list("Female Light","Female Dark","Female Pale","Male Light","Male Dark","Male Pale")
					var/skinchoice=input(usr,"Which base would you like to use?") as anything in bases
					switch(skinchoice)
						if("Female Light")
							usr.icon='Bases/Human/Base Female.dmi'
						if("Female Dark")
							usr.icon='Bases/Human/Base Female Dark.dmi'
						if("Female Pale")
							usr.icon='Bases/Human/Base Female Pale.dmi'
						if("Male Light")
							usr.icon='Bases/Human/Base Male.dmi'
						if("Male Dark")
							usr.icon='Bases/Human/Base Male Dark.dmi'
						if("Male Pale")
							usr.icon='Bases/Human/Base Male Pale.dmi'
				if("Miqo'te")
					var/list/bases=list("Female Light","Female Dark","Female Pale","Male Light","Male Dark","Male Pale")
					var/skinchoice=input(usr,"Which base would you like to use?") as anything in bases
					switch(skinchoice)
						if("Female Light")
							usr.icon='Bases/Human/Base Female.dmi'
						if("Female Dark")
							usr.icon='Bases/Human/Base Female Dark.dmi'
						if("Female Pale")
							usr.icon='Bases/Human/Base Female Pale.dmi'
						if("Male Light")
							usr.icon='Bases/Human/Base Male.dmi'
						if("Male Dark")
							usr.icon='Bases/Human/Base Male Dark.dmi'
						if("Male Pale")
							usr.icon='Bases/Human/Base Male Pale.dmi'
				if("Gria")
					var/list/bases=list("Female Light","Female Dark","Female Pale","Male Light","Male Dark","Male Pale")
					var/skinchoice=input(usr,"Which base would you like to use?") as anything in bases
					switch(skinchoice)
						if("Female Light")
							usr.icon='Bases/Human/Base Female.dmi'
						if("Female Dark")
							usr.icon='Bases/Human/Base Female Dark.dmi'
						if("Female Pale")
							usr.icon='Bases/Human/Base Female Pale.dmi'
						if("Male Light")
							usr.icon='Bases/Human/Base Male.dmi'
						if("Male Dark")
							usr.icon='Bases/Human/Base Male Dark.dmi'
						if("Male Pale")
							usr.icon='Bases/Human/Base Male Pale.dmi'
				if("Al-Bhed")
					var/list/bases=list("Female Light","Female Dark","Female Pale","Male Light","Male Dark","Male Pale")
					var/skinchoice=input(usr,"Which base would you like to use?") as anything in bases
					switch(skinchoice)
						if("Female Light")
							usr.icon='Bases/Human/Base Female.dmi'
						if("Female Dark")
							usr.icon='Bases/Human/Base Female Dark.dmi'
						if("Female Pale")
							usr.icon='Bases/Human/Base Female Pale.dmi'
						if("Male Light")
							usr.icon='Bases/Human/Base Male.dmi'
						if("Male Dark")
							usr.icon='Bases/Human/Base Male Dark.dmi'
						if("Male Pale")
							usr.icon='Bases/Human/Base Male Pale.dmi'
				if("Au Ra")
					var/list/bases=list("Female Light","Female Dark","Female Pale","Male Light","Male Dark","Male Pale")
					var/skinchoice=input(usr,"Which base would you like to use?") as anything in bases
					switch(skinchoice)
						if("Female Light")
							usr.icon='Bases/Human/Base Female.dmi'
						if("Female Dark")
							usr.icon='Bases/Human/Base Female Dark.dmi'
						if("Female Pale")
							usr.icon='Bases/Human/Base Female Pale.dmi'
						if("Male Light")
							usr.icon='Bases/Human/Base Male.dmi'
						if("Male Dark")
							usr.icon='Bases/Human/Base Male Dark.dmi'
						if("Male Pale")
							usr.icon='Bases/Human/Base Male Pale.dmi'
				if("Golem")
					var/list/bases=list("Female Light","Female Dark","Female Pale","Male Light","Male Dark","Male Pale")
					var/skinchoice=input(usr,"Which base would you like to use?") as anything in bases
					switch(skinchoice)
						if("Female Light")
							usr.icon='Bases/Human/Base Female.dmi'
						if("Female Dark")
							usr.icon='Bases/Human/Base Female Dark.dmi'
						if("Female Pale")
							usr.icon='Bases/Human/Base Female Pale.dmi'
						if("Male Light")
							usr.icon='Bases/Human/Base Male.dmi'
						if("Male Dark")
							usr.icon='Bases/Human/Base Male Dark.dmi'
						if("Male Pale")
							usr.icon='Bases/Human/Base Male Pale.dmi'
				if("Cyborg")
					var/list/bases=list("Female Light","Female Dark","Female Pale","Male Light","Male Dark","Male Pale")
					var/skinchoice=input(usr,"Which base would you like to use?") as anything in bases
					switch(skinchoice)
						if("Female Light")
							usr.icon='Bases/Human/Base Female.dmi'
						if("Female Dark")
							usr.icon='Bases/Human/Base Female Dark.dmi'
						if("Female Pale")
							usr.icon='Bases/Human/Base Female Pale.dmi'
						if("Male Light")
							usr.icon='Bases/Human/Base Male.dmi'
						if("Male Dark")
							usr.icon='Bases/Human/Base Male Dark.dmi'
						if("Male Pale")
							usr.icon='Bases/Human/Base Male Pale.dmi'
				if("Viera")
					var/list/bases=list("Female Light","Female Dark","Female Pale","Male Light","Male Dark","Male Pale")
					var/skinchoice=input(usr,"Which base would you like to use?") as anything in bases
					switch(skinchoice)
						if("Female Light")
							usr.icon='Bases/Human/Base Female.dmi'
						if("Female Dark")
							usr.icon='Bases/Human/Base Female Dark.dmi'
						if("Female Pale")
							usr.icon='Bases/Human/Base Female Pale.dmi'
						if("Male Light")
							usr.icon='Bases/Human/Base Male.dmi'
						if("Male Dark")
							usr.icon='Bases/Human/Base Male Dark.dmi'
						if("Male Pale")
							usr.icon='Bases/Human/Base Male Pale.dmi'
				if("Ronso")
					var/list/bases=list("Ronso Female","Ronso Male")
					var/skinchoice=input(usr,"Which base would you like to use?") as anything in bases
					switch(skinchoice)
						if("Ronso Female")
							usr.icon='Bases/Ronso/Ronso Female.dmi'
						if("Ronso Male")
							usr.icon='Bases/Ronso/Ronso Male.dmi'
				if("Lalafell")
					var/list/bases=list("Female Light","Female Dark","Female Pale","Male Light","Male Dark","Male Pale")
					var/skinchoice=input(usr,"Which base would you like to use?") as anything in bases
					switch(skinchoice)
						if("Female Light")
							usr.icon='Bases/Lalafell/Lalafell Female.dmi'
						if("Female Dark")
							usr.icon='Bases/Lalafell/Lalafell Female Dark.dmi'
						if("Female Pale")
							usr.icon='Bases/Lalafell/Lalafell Female Pale.dmi'
						if("Male Light")
							usr.icon='Bases/Lalafell/Lalafell Male.dmi'
						if("Male Dark")
							usr.icon='Bases/Lalafell/Lalafell Male Dark.dmi'
						if("Male Pale")
							usr.icon='Bases/Lalafell/Lalafell Male Pale.dmi'
				if("Roegadyn")
					var/list/bases=list("Female Light","Female Dark","Female Pale","Male Light","Male Dark","Male Pale")
					var/skinchoice=input(usr,"Which base would you like to use?") as anything in bases
					switch(skinchoice)
						if("Female Light")
							usr.icon='Bases/Human/Base Female.dmi'
						if("Female Dark")
							usr.icon='Bases/Human/Base Female Dark.dmi'
						if("Female Pale")
							usr.icon='Bases/Human/Base Female Pale.dmi'
						if("Male Light")
							usr.icon='Bases/Human/Base Male.dmi'
						if("Male Dark")
							usr.icon='Bases/Human/Base Male Dark.dmi'
						if("Male Pale")
							usr.icon='Bases/Human/Base Male Pale.dmi'
				if("Namazu")
					usr.icon='Bases/Namazu/Namazu.dmi'
				if("Gnath")
					usr.icon='Bases/Gnath/Gnath.dmi'
				if("Moogle")
					usr.icon='Bases/Moogle/Moogle.dmi'


mob/var/list/customoverlays=new
var/list/Hairlist=new
var/list/Shirtlist=new
var/list/Pantlist=new
var/list/Neckware=new
var/list/Weaponlist=new
var/list/Accessorylist=new
obj
	customs
		layer=4
		Click()
			var/row
			if(usr.deletemode && istype(src,/obj/customs/added))
				usr.customoverlays-=src
				del(src)
				winset(usr,"Customize.Customizegrid","cells=0x0")
				for(var/A in usr.customoverlays)
					row++
					src << output(A,"Customizegrid:1,[row]")
			if(istype(src,/obj/customs/added))
				usr.overlays+=src
			if(usr.nocolorask)
				usr.overlays+=src
			else
				var/sicon
				var/obj/customs/added/C=new /obj/customs/added
				C.pixel_x=src.pixel_x
				C.pixel_y=src.pixel_y
				sicon=src.icon
				var/Color
				switch(alert("Do you want to make a custom color?",,"Yes","No"))
					if("Yes")
						Color =input("Please choose a color") as color
				if(Color)
					sicon+=Color
				C.icon=sicon
				C.name=src.name
				if(Color)
					C.name+="([Color])"
				usr.customoverlays+=C
				usr.overlays += C


obj/status/HPBar
	icon='Icons/HPbar.dmi'
	pixel_y=4
obj/status/MPBar
	icon='Icons/MPbar.dmi'
	pixel_y=-1
obj/status/SPBar
	icon='Icons/SPbar.dmi'
	pixel_y=-6

atom
	var
		mhp=50
		mmp=10
		msp=10
		hp=50
		mp=10
		sp=10

atom
	proc
		AdjustHPBar(var/obj/status/HPBar/a,var/atom/b)
			var/max
			var/minor
			var/hurt
			var/damage
			var/damage1
			var/damage2
			var/damage3
			var/damage4
			var/damage5
			var/damage6
			var/damage7
			var/koed=0
			max=b.mhp
			minor=b.mhp*0.95
			hurt=b.mhp*0.9
			damage=b.mhp*0.8
			damage1=b.mhp*0.7
			damage2=b.mhp*0.6
			damage3=b.mhp*0.5
			damage4=b.mhp*0.4
			damage5=b.mhp*0.3
			damage6=b.mhp*0.2
			damage7=b.mhp*0.1
			koed=0
			b.overlays-=a
			if(b.hp==max)
				a.icon_state="100"
			if(b.hp>=minor && b.hp<max)
				a.icon_state="95"
			if(b.hp>=hurt && b.hp<minor)
				a.icon_state="90"
			if(b.hp>=damage && b.hp<hurt)
				a.icon_state="80"
			if(b.hp>=damage1&&b.hp<damage)
				a.icon_state="70"
			if(b.hp>=damage2&&b.hp<damage1)
				a.icon_state="60"
			if(b.hp>=damage3&&b.hp<damage2)
				a.icon_state="50"
			if(b.hp>=damage4&&b.hp<damage3)
				a.icon_state="40"
			if(b.hp>=damage5&&b.hp<damage4)
				a.icon_state="30"
			if(b.hp>=damage6&&b.hp<damage5)
				a.icon_state="20"
			if(b.hp>=damage7&&b.hp<damage6)
				a.icon_state="10"
			if(b.hp>koed&&b.hp<damage7)
				a.icon_state="10"
			if(b.hp==koed)
				a.icon_state="0"
			b.overlays+=a
		AdjustMPBar(var/obj/status/MPBar/a,var/atom/b)
			var/max
			var/minor
			var/hurt
			var/damage
			var/damage1
			var/damage2
			var/damage3
			var/damage4
			var/damage5
			var/damage6
			var/damage7
			var/koed=0
			max=b.mmp
			minor=b.mmp*0.95
			hurt=b.mmp*0.9
			damage=b.mmp*0.8
			damage1=b.mmp*0.7
			damage2=b.mmp*0.6
			damage3=b.mmp*0.5
			damage4=b.mmp*0.4
			damage5=b.mmp*0.3
			damage6=b.mmp*0.2
			damage7=b.mmp*0.1
			koed=0
			b.overlays-=a
			if(b.mp==max)
				a.icon_state="100"
			if(b.mp>=minor && b.mp<max)
				a.icon_state="95"
			if(b.mp>=hurt && b.mp<minor)
				a.icon_state="90"
			if(b.mp>=damage && b.mp<hurt)
				a.icon_state="80"
			if(b.mp>=damage1&&b.mp<damage)
				a.icon_state="70"
			if(b.mp>=damage2&&b.mp<damage1)
				a.icon_state="60"
			if(b.mp>=damage3&&b.mp<damage2)
				a.icon_state="50"
			if(b.mp>=damage4&&b.mp<damage3)
				a.icon_state="40"
			if(b.mp>=damage5&&b.mp<damage4)
				a.icon_state="30"
			if(b.mp>=damage6&&b.mp<damage5)
				a.icon_state="20"
			if(b.mp>=damage7&&b.mp<damage6)
				a.icon_state="10"
			if(b.mp>koed&&b.mp<damage7)
				a.icon_state="10"
			if(b.mp==koed)
				a.icon_state="0"
			b.overlays+=a
		AdjustSPBar(var/obj/status/SPBar/a,var/obj/npc/b)
			var/max
			var/minor
			var/hurt
			var/damage
			var/damage1
			var/damage2
			var/damage3
			var/damage4
			var/damage5
			var/damage6
			var/damage7
			var/koed=0
			max=b.msp
			minor=b.msp*0.95
			hurt=b.msp*0.9
			damage=b.msp*0.8
			damage1=b.msp*0.7
			damage2=b.msp*0.6
			damage3=b.msp*0.5
			damage4=b.msp*0.4
			damage5=b.msp*0.3
			damage6=b.msp*0.2
			damage7=b.msp*0.1
			koed=0
			b.overlays-=a
			if(b.sp==max)
				a.icon_state="100"
			if(b.sp>=minor && b.sp<max)
				a.icon_state="95"
			if(b.sp>=hurt && b.sp<minor)
				a.icon_state="90"
			if(b.sp>=damage && b.sp<hurt)
				a.icon_state="80"
			if(b.sp>=damage1&&b.sp<damage)
				a.icon_state="70"
			if(b.sp>=damage2&&b.sp<damage1)
				a.icon_state="60"
			if(b.sp>=damage3&&b.sp<damage2)
				a.icon_state="50"
			if(b.sp>=damage4&&b.sp<damage3)
				a.icon_state="40"
			if(b.sp>=damage5&&b.sp<damage4)
				a.icon_state="30"
			if(b.sp>=damage6&&b.sp<damage5)
				a.icon_state="20"
			if(b.sp>=damage7&&b.sp<damage6)
				a.icon_state="10"
			if(b.sp>koed&&b.sp<damage7)
				a.icon_state="10"
			if(b.sp==koed)
				a.icon_state="0"
			b.overlays+=a


obj/customs/hair
	Bangs
		icon='Hair/Bangs.dmi'
	Braids
		icon='Hair/Braids.dmi'
	Buns
		icon='Hair/Buns.dmi'
	Lightning
		icon='Hair/Lightning.dmi'
	LongEmo
		name="Emo"
		icon='Hair/LongEmo.dmi'
	Messy
		icon='Hair/Messy.dmi'
	Noble
		icon='Hair/Noble.dmi'
	Noctis
		icon='Hair/Noctis.dmi'
	Ponytail
		icon='Hair/Ponytail.dmi'
	Protagonist
		icon='Hair/Protagonist.dmi'
	Punk
		icon='Hair/Punk.dmi'
	Sera
		icon='Hair/Sera.dmi'
	ShaggySpiky
		name="Spiky and Shaggy"
		icon='Hair/ShaggySpiky.dmi'
	Short
		icon='Hair/Short.dmi'
	Spikyfem
		name="Spiky Feminine"
		icon='Hair/Spikyfem.dmi'
	Twintails
		name="Twintails"
		icon='Hair/Twintails.dmi'


obj/customs/shirt
	LongSleeve
		name="Long Sleeve"
		icon='Crystal Saga Clothes/Longsleeve Shirt.dmi'
	ShortSleeve
		name="Short Sleeve"
		icon='Crystal Saga Clothes/Shortsleeve Shirt.dmi'
	TankTop
		name="Tank Top"
		icon='Crystal Saga Clothes/Tank Top.dmi'
	WhiteMage
		name="White Mage's Robes"
		icon='Crystal Saga Clothes/White Mage.dmi'
	ClosedJacket
		name="Closed Jacket"
		icon='Crystal Saga Clothes/Closed Jacket.dmi'
	OpenJacket
		icon='Crystal Saga Clothes/Open Jacket.dmi'
		name="Open Jacket"
	ChestPlateBlack
		name="Recolorable Chest Plate"
		icon='Crystal Saga Clothes/Chestplateblack.dmi'
	Chestplate
		name="Chestplate"

obj/customs/pant
	Pants
		icon='Crystal Saga Clothes/Pants.dmi'
	Shorts
		icon='Crystal Saga Clothes/Shorts.dmi'
	Skirt
		icon='Crystal Saga Clothes/Skirt.dmi'


obj/customs/neckware
	RubyAmulet
		icon='Icons/AmuletRuby.dmi'

obj/customs/weapons
	ShortSword
		name="Short Sword"
		icon='Crystal Saga Clothes/Hipsword.dmi'
	LongSword
		name="Long Sword"
		icon='Crystal Saga Clothes/Backsword.dmi'
	Spear
		name="Spear"
		icon='Crystal Saga Clothes/Spear.dmi'
	Greatsword
		icon='Crystal Saga Clothes/Greatsword.dmi'
	Hammer
		icon='Crystal Saga Clothes/Hammer.dmi'
	FocusCrystal
		name="Focus Crystal"
		icon='Crystal Saga Clothes/Focus Crystal.dmi'
	Bow
		icon='Crystal Saga Clothes/Bow.dmi'
	BusterSword
		name="Buster Sword"
		icon='Crystal Saga Clothes/Buster Sword.dmi'


obj/customs/accessorys
	GriaWings
		name="Gria Wings"
		icon='Bases/Gria Wings.dmi'
	VieraEars
		name="Viera Ears"
		icon='Bases/Bunny Ears.dmi'
	MiqoteEars
		name="Miq'ote Ears"
		icon='Bases/Cat Ears.dmi'
	Tail
		name="Tail"
		icon='Bases/Tail.dmi'
	RonsoTail
		name="Ronso Tail"
		icon='Bases/RonsoTail.dmi'
	GenomeTail
		name="Genome Tail"
		icon='Bases/Genome Tail.dmi'
	Cape
		icon='Crystal Saga Clothes/Cape.dmi'
	SOLDIERPauldron
		name="SOLDIER Pauldron"
		icon='Crystal Saga Clothes/PauldronSoldier.dmi'
	RedMage
		name="Red Mage's Hat"
		icon='Crystal Saga Clothes/Red Mage.dmi'
	BlueMage
		name="Blue Mage's Cap"
		icon='Crystal Saga Clothes/Blue Mage.dmi'
	Viking
		name="Viking's Helm"
		icon='Crystal Saga Clothes/VikingHelm.dmi'
	Strawhat
		name="Straw Hat"
		icon='Crystal Saga Clothes/Strawhat.dmi'
	Dragoon
		name="Dragoon's Helm"
		icon='Crystal Saga Clothes/Dragoon.dmi'
	BlackMage
		name="Black Mage's Hat"
		icon='Crystal Saga Clothes/Blackmage.dmi'
	Fullhelm
		name="Fullhelm"
		icon='Crystal Saga Clothes/Fullhelm.dmi'
	Fullhelm2
		name="Fullhelm (Recolorable)"
		icon='Crystal Saga Clothes/Recolorable Fullhelm.dmi'
	Headband
		icon='Crystal Saga Clothes/Headband.dmi'
	WaistSash
		name="Waist Sash"
		icon='Crystal Saga Clothes/Waistsash.dmi'
	Scarf
		icon='Crystal Saga Clothes/Scarf.dmi'
	Gloves
		icon='Crystal Saga Clothes/Gloves.dmi'
	Bandana
		icon='Crystal Saga Clothes/Bandana.dmi'
	Belt
		icon='Crystal Saga Clothes/Belt.dmi'
	Bra
		icon='Crystal Saga Clothes/Bra.dmi'
	Shoes
		icon='Crystal Saga Clothes/Shoes.dmi'
	Boots
		icon='Crystal Saga Clothes/Boots.dmi'

obj/customs/added

obj
	overlaydummy
		icon='Icons/Mannequin.dmi'
	overlaydummy2
		icon='Icons/Mannequin.dmi'
	overlaydummy3
		icon='Icons/Mannequin.dmi'


proc
	Addcustoms()
		for(var/A in typesof(/obj/customs/hair)) if(A!=/obj/customs/hair) Hairlist+=new A
		for(var/B in typesof(/obj/customs/shirt)) if(B!=/obj/customs/shirt) Shirtlist+=new B
		for(var/C in typesof(/obj/customs/pant)) if(C!=/obj/customs/pant) Pantlist+=new C
		for(var/D in typesof(/obj/customs/neckware)) if(D!=/obj/customs/neckware) Neckware+=new D
		for(var/E in typesof(/obj/customs/weapons)) if(E!=/obj/customs/weapons) Weaponlist+=new E
		for(var/F in typesof(/obj/customs/accessorys)) if(F!=/obj/customs/accessorys) Accessorylist+=new F
