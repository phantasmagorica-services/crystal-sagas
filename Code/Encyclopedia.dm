obj
	ency
		icon = 'Encyclopedia.dmi'
		var/favorite
		var/entrytext = {"{"<html>
<head><title></head></title><body>
<font size=8><font color="#0099FF"><font size=-1><b><i>
<font color="#00FFFF">Your logged activities<br>
</body><html>"}
		Click()
			usr<<browse(src.entrytext,"window=Encyclopedia.text")
		verb
			Deletethis()
				if(usr.adminlv<2)
					alert(usr,"You are not an Admin, and cannot delete an Encyclopedia entry.")
				else
					del src
/*		DblClick()
			if(!favorite)
				src.favorite = 1
				src.icon_state = "favorite"
				var/obj/ency/favorite/r = new /obj/ency/favorite
				r.name = src.name
				r.entrytext =src.entrytext
				r.icon_state = src.icon_state
				usr.contents+=r

			else
				src.favorite = 0
				src.icon_state = ""*/
		rules


mob/verb
	ViewEcyclopedia()
		winset(usr,"Encyclopedia","is-visible=true")

	CreateEntry()
		var/n = input("Enter the name of the entry") as text
		var/m = input("Please enter the new entry") as message
		var/is = input("Do you wish this entry to have an image? Please paste as an image url") as text
		var/i = {"<img src="[is]" width = 255" height = 150">"}
		var/c
		var/list/choices=list("Requests and Quests","Looking for Party")
		if(usr.adminlv>=2)
			choices+="World Events"
			choices+="Rulings"
		var/choose=input("What category will this entry go to?") as anything in choices
		switch(choose)
			if("World Events")
				c="World Events"
			if("Rulings")
				c="Rulings"
			if("Requests and Quests")
				c="Requests and Quests"
			if("Looking for Party")
				c="Looking for Party"
		text2file("[i][m]","data/Encyclopedia/[c]/[n].txt")
	ShowRulesCat()
		var/row
		var/d
		winset(usr,"Encyclopedia.Contents","cells=1x1")
		for(var/r in flist("Encyclopedia/Rules/"))
			row++
			d = file("data/Encyclopedia/Rules/[r]")
			var/obj/ency/rules/p = new /obj/ency/rules
			p.name = r
			p.entrytext = file2text(d)
			usr.contents+=p
			usr << output(p,"Contents:1,[row]")
	ShowFactions()
		var/row
		var/d
		winset(usr,"Encyclopedia.Contents","cells=1x1")
		for(var/r in flist("Encyclopedia/Factions/"))
			row++
			d = file("data/Encyclopedia/Factions/[r]")
			var/obj/ency/rules/p = new /obj/ency/rules
			p.name = r
			p.entrytext = file2text(d)
			usr.contents+=p
			usr << output(p,"Contents:1,[row]")
	ShowJobsCat()
		var/row
		var/d
		winset(usr,"Encyclopedia.Contents","cells=1x1")
		for(var/r in flist("Encyclopedia/Jobs/"))
			row++
			d = file("data/Encyclopedia/Jobs/[r]")
			var/obj/ency/rules/p = new /obj/ency/rules
			p.name = r
			p.entrytext = file2text(d)
			usr.contents+=p
			usr << output(p,"Contents:1,[row]")
	ShowCombatCat()
		var/row
		var/d
		winset(usr,"Encyclopedia.Contents","cells=1x1")
		for(var/r in flist("Encyclopedia/Combat/"))
			row++
			d = file("data/Encyclopedia/Combat/[r]")
			var/obj/ency/rules/p = new /obj/ency/rules
			p.name = r
			p.entrytext = file2text(d)
			usr.contents+=p
			usr << output(p,"Contents:1,[row]")
	ShowCraftingCat()
		var/row
		var/d
		winset(usr,"Encyclopedia.Contents","cells=1x1")
		for(var/r in flist("Encyclopedia/Crafting/"))
			row++
			d = file("data/Encyclopedia/Crafting/[r]")
			var/obj/ency/rules/p = new /obj/ency/rules
			p.name = r
			p.entrytext = file2text(d)
			usr.contents+=p
			usr << output(p,"Contents:1,[row]")
	ShowUniquesCat()
		var/row
		var/d
		winset(usr,"Encyclopedia.Contents","cells=1x1")
		for(var/r in flist("Encyclopedia/Uniques/"))
			row++
			d = file("data/Encyclopedia/Uniques/[r]")
			var/obj/ency/rules/p = new /obj/ency/rules
			p.name = r
			p.entrytext = file2text(d)
			usr.contents+=p
			usr << output(p,"Contents:1,[row]")
	ShowWorldEvents()
		var/row
		var/d
		winset(usr,"Encyclopedia.Contents","cells=1x1")
		for(var/r in flist("Encyclopedia/World Events/"))
			row++
			d = file("data/Encyclopedia/World Events/[r]")
			var/obj/ency/rules/p = new /obj/ency/rules
			p.name = r
			p.entrytext = file2text(d)
			usr.contents+=p
			usr << output(p,"Contents:1,[row]")
	ShowWorldInfo()
		var/row
		var/d
		winset(usr,"Encyclopedia.Contents","cells=1x1")
		for(var/r in flist("Encyclopedia/World Info/"))
			row++
			d = file("data/Encyclopedia/World Info/[r]")
			var/obj/ency/rules/p = new /obj/ency/rules
			p.name = r
			p.entrytext = file2text(d)
			usr.contents+=p
			usr << output(p,"Contents:1,[row]")
	ShowRequests()
		var/row
		var/d
		winset(usr,"Encyclopedia.Contents","cells=1x1")
		for(var/r in flist("Encyclopedia/Requests and Quests/"))
			row++
			d = file("data/Encyclopedia/Requests and Quests/[r]")
			var/obj/ency/rules/p = new /obj/ency/rules
			p.name = r
			p.entrytext = file2text(d)
			usr.contents+=p
			usr << output(p,"Contents:1,[row]")
	ShowRulings()
		var/row
		var/d
		winset(usr,"Encyclopedia.Contents","cells=1x1")
		for(var/r in flist("Encyclopedia/Rulings/"))
			row++
			d = file("data/Encyclopedia/Rulings/[r]")
			var/obj/ency/rules/p = new /obj/ency/rules
			p.name = r
			p.entrytext = file2text(d)
			usr.contents+=p
			usr << output(p,"Contents:1,[row]")
	ShowLFP()
		var/row
		var/d
		winset(usr,"Encyclopedia.Contents","cells=1x1")
		for(var/r in flist("Encyclopedia/Looking for Party/"))
			row++
			d = file("data/Encyclopedia/Looking for Party/[r]")
			var/obj/ency/rules/p = new /obj/ency/rules
			p.name = r
			p.entrytext = file2text(d)
			usr.contents+=p
			usr << output(p,"Contents:1,[row]")



