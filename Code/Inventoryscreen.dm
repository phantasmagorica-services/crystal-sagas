mob
	verb
		Dropmoney()
			var/amount= input(usr,"How much do you wish to drop?")as num
			if(amount>usr.money)
				alert("You don't have that much to drop.")
				return
			if(amount<=0)
				alert("You cannot drop less than 0, or 0 Gil!")
				return
			else
				var/obj/Money/m =new /obj/Money
				usr.money-=amount
				m.value = amount
				m.loc=usr.loc
				winset(usr,"InventoryScreen.Money","text=\"[usr.money]\"")
		DropGSP()
			var/amount= input(usr,"How much do you wish to drop?")as num
			if(amount>usr.GSP)
				alert("You don't have that much to drop.")
			if(amount<=0)
				alert("You cannot drop less than 0, or 0 GSP!")
				return
			else
				var/obj/GSP/m =new /obj/GSP
				usr.GSP-=amount
				m.value = amount
				m.loc=usr.loc
				winset(usr,"InventoryScreen.gsp","text=\"[usr.GSP]\"")
		SeeEquipment()
			if(usr.intitlescreen)
				return
			var/row
			winset(usr,"Equipment","is-visible=true")
			winset(usr,"Equipment.name","text=\"[usr.name]\"")
			winset(usr,"Equipment.player","is-visible=false")
			row++
			usr<<output(usr,"Equipment.player:1,[row]")
			var/icon/I1 = icon(usr.righthand.icon,"Yee",SOUTH,1,0)
			var/newPicture1 = fcopy_rsc(I1)
			winset(usr,"Equipment.RightHand","image=\ref[newPicture1]")
			var/icon/I2 = icon(usr.lefthand.icon,"Yee",SOUTH,1,0)
			var/newPicture2 = fcopy_rsc(I2)
			winset(usr,"Equipment.LeftHand","image=\ref[newPicture2]")
			var/icon/I3 = icon(usr.armor.icon,"Yee",SOUTH,1,0)
			var/newPicture3 = fcopy_rsc(I3)
			winset(usr,"Equipment.Armor","image=\ref[newPicture3]")
			var/icon/I4 = icon(usr.materia1.icon,"Yee",SOUTH,1,0)
			var/newPicture4 = fcopy_rsc(I4)
			winset(usr,"Equipment.Materia1","image=\ref[newPicture4]")
			var/icon/I5 = icon(usr.materia2.icon,"Yee",SOUTH,1,0)
			var/newPicture5 = fcopy_rsc(I5)
			winset(usr,"Equipment.Materia2","image=\ref[newPicture5]")
			var/icon/I6 = icon(usr.materia3.icon,"Yee",SOUTH,1,0)
			var/newPicture6 = fcopy_rsc(I6)
			winset(usr,"Equipment.Materia3","image=\ref[newPicture6]")
			var/icon/I7 = icon(usr.accessory1.icon,"Yee",SOUTH,1,0)
			var/newPicture7 = fcopy_rsc(I7)
			winset(usr,"Equipment.Accessory1","image=\ref[newPicture7]")
			var/icon/I8 = icon(usr.accessory2.icon,"Yee",SOUTH,1,0)
			var/newPicture8 = fcopy_rsc(I8)
			winset(usr,"Equipment.Accessory2","image=\ref[newPicture8]")
		CloseEquip()
			winset(usr,"Equipment","is-visible=false")
	proc
		RefreshEquipment()
			var/row
			winset(usr,"Equipment.name","text=\"[usr.name]\"")
			winset(usr,"Equipment.player","is-visible=false")
			row++
			usr<<output(usr,"Equipment.player:1,[row]")
			var/icon/I1 = icon(usr.righthand.icon,"Yee",SOUTH,1,0)
			var/newPicture1 = fcopy_rsc(I1)
			winset(usr,"Equipment.RightHand","image=\ref[newPicture1]")
			var/icon/I2 = icon(usr.lefthand.icon,"Yee",SOUTH,1,0)
			var/newPicture2 = fcopy_rsc(I2)
			winset(usr,"Equipment.LeftHand","image=\ref[newPicture2]")
			var/icon/I3 = icon(usr.armor.icon,"Yee",SOUTH,1,0)
			var/newPicture3 = fcopy_rsc(I3)
			winset(usr,"Equipment.Armor","image=\ref[newPicture3]")
			var/icon/I4 = icon(usr.materia1.icon,"Yee",SOUTH,1,0)
			var/newPicture4 = fcopy_rsc(I4)
			winset(usr,"Equipment.Materia1","image=\ref[newPicture4]")
			var/icon/I5 = icon(usr.materia2.icon,"Yee",SOUTH,1,0)
			var/newPicture5 = fcopy_rsc(I5)
			winset(usr,"Equipment.Materia2","image=\ref[newPicture5]")
			var/icon/I6 = icon(usr.materia3.icon,"Yee",SOUTH,1,0)
			var/newPicture6 = fcopy_rsc(I6)
			winset(usr,"Equipment.Materia3","image=\ref[newPicture6]")
			var/icon/I7 = icon(usr.accessory1.icon,"Yee",SOUTH,1,0)
			var/newPicture7 = fcopy_rsc(I7)
			winset(usr,"Equipment.Accessory1","image=\ref[newPicture7]")
			var/icon/I8 = icon(usr.accessory2.icon,"Yee",SOUTH,1,0)
			var/newPicture8 = fcopy_rsc(I8)
			winset(usr,"Equipment.Accessory2","image=\ref[newPicture8]")

obj
	Money
		var/value = 0
		icon = 'Icons/Gil.png'
		Click()
			if(usr in view(1,src))
				usr.money += value
				usr.Refreshinventoryscreen()
				del(src)
	GSP
		var/value = 0
		icon='Icons/GSP.png'
		Click()
			if(usr in view(1,src))
				usr.GSP += value
				usr.Refreshinventoryscreen()
				del(src)
