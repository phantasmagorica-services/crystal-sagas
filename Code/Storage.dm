/obj/storage
	var/locked
	var/keyid
	var/slots=0
	var/maxslots=3

/obj/storage/Click()
	if(locked)
		if(CheckKey(usr))
			switch(alert("Do you wish to unlock the [src.name]?",,"Yes","No"))
				if("Yes")
					src.locked=0
				if("No")
					return
		else
			usr<<output("This [src.name] is locked. You don't have the key to it.","oocout")
	else
		var/row
		winset(usr,"Storage","is-visible=true")
		winset(usr,"Storage.slotdis","text=\"Slots:[slots]/[maxslots]\"")
		usr.storagelook=src
		for(var/obj/item/A in src.contents)
			row++
			winset(usr, "storegrid", "current-cell=1,[row]")
			usr << output(A,"storegrid")
			if(A.amount>0)
				A.suffix="[A.amount]"
			winset(usr, "storegrid", "current-cell=2,[row]")
			usr << output(A.suffix,"storegrid")

/obj/storage/Chest
	icon='Map Icons/Outdoordec.dmi'
	icon_state="36"

/obj/storage/Chest/New()
	locked=1
	keyid="key1"
	password=""

/mob/verb/Lock()
	set hidden=1
	var/obj/storage/s=usr.storagelook
	if(s.CheckKey(usr))
		s.locked=1
		winset(usr,"Storage","is-visible=false")
		usr.storagelook=null
	else
		alert("You don't have the key to this chest. ")

/mob/verb/Store()
	var/list/choice=new
	var/obj/storage/s=usr.storagelook
	if(s.slots>=s.maxslots)
		alert("This container is too full to store anything else")
		return
	for(var/obj/item/i2 in usr.contents)
		choice+=i2
	var/obj/item/i = input("Choose and item to store") as null|anything in choice
	if(i.amount>0)
		var/amo = input("How many do you wish to store?") as num
		if(amo>i.amount)
			alert("You don't have that many")
		else if(amo==i.amount)
			for(var/obj/item/o in s.contents)
				if(i.name==o.name)
					o.amount+=amo
					usr.carryweight-=i.weight*i.amount
					del(i)
					usr.RefreshStorage()
					return
			i.instorage=1
			usr.carryweight-=i.weight*i.amount
			i.Move(s)
			s.slots++
		else if(amo<i.amount)
			for(var/obj/item/o in s.contents)
				if(i.name==o.name)
					o.amount+=amo
					i.amount-=amo
					usr.carryweight-=i.weight*amo
					usr.RefreshStorage()
					return
			i.amount-=amo
			var/obj/item/ci=copyatom(i)
			ci.amount=amo
			ci.instorage=1
			usr.carryweight-=ci.weight*amo
			s.contents+=ci
	else
		i.instorage=1
		usr.carryweight-=i.weight
		s.slots++
		i.Move(s)
	usr.RefreshStorage()

/mob/proc/CloseStorage()
	usr.storagelook=null

/mob/proc/RefreshStorage()
	if(winget(src,"Storage","is-visible=true"))
		var/row
		var/obj/storage/s=src.storagelook
		winset(usr,"Storage.slotdis","text=\"Slots:[s.slots]/[s.maxslots]\"")
		winset(src,"storegrid","cells=0x0")
		for(var/obj/item/A in s.contents)
			row++
			winset(src, "storegrid", "current-cell=1,[row]")
			usr << output(A,"storegrid")
			if(A.amount>0)
				A.suffix="[A.amount]"
			winset(src, "storegrid", "current-cell=2,[row]")
			usr << output(A.suffix,"storegrid")
