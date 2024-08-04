/mob/proc/Learnblu(obj/perk/b)
	for(var/obj/perk/a in usr.contents)
		if(b.name == a.name)
			alert(usr,"You already know this ability!")
			return
	if(usr.job=="Blue Mage")
		switch(alert("[b.desc] (Rank: [b.rank]) (Cost: [b.rpcost])","[b.name]","Learn","Cancel"))
			if("Learn")
				if(usr.rpp>=b.rpcost)
					if(Checkmag(b,usr))
						alert(usr,"You are not capable of learning perks of this type or rank.")
						return
					if(Checkrank(b,usr))
						alert(usr,"You cannot learn abilities of that rank right now.")
						return
					usr.rpp-=b.rpcost
					var/obj/perk/p = copyatom(b)
					b.ontree=0
					usr.contents+=p
					alert(usr,"You have learned [b.name]!")
					Checkspec(b,usr)
					Rankadjust(b,usr)
				else
					alert(usr,"You do not have enough RPP to learn this!")
			if("Cancel")
				return
	else
		if(usr.subjob=="Blue Mage"||usr.race=="Ronso")
			switch(alert("[b.desc] (Rank: [b.rank]) (Cost: [b.rpcost])","[b.name]","Learn","Cancel"))
				if("Learn")
					if(usr.rpp>=b.rpcost)
						if(Checkmag(b,usr))
							alert(usr,"You are not capable of learning perks of this type or rank.")
							return
						if(Checkrank(b,usr))
							alert(usr,"You cannot learn abilities of that rank right now.")
							return
						usr.rpp-=b.rpcost
						var/obj/perk/p = copyatom(b)
						p.ontree=0
						usr.contents+=p
						alert(usr,"You have learned [b.name]!")
						Checkspec(b,usr)
						Rankadjust(b,usr)
					else
						alert(usr,"You do not have enough RPP to learn this!")
				if("Cancel")
					return
		else
			alert(usr,"You are not a Blue Mage!")
			return

/atom/Topic(href, list/href_list)
	. = ..()
	if(.)
		return
	if(href_list["action"] != "edit")
		return
	. = TRUE
	var/variable = href_list["var"]
	var/class = input("[variable]","") as null|anything in list("Number","Text","File","Nothing","View List","Edit List")
	if(!class)
		return
	if(variable=="Admin")
		return
	if(class!="View List")
		if(usr.adminlv<2)
			return
	switch(class)
		if("Nothing") vars[variable]=null
		if("Text")
			if(isnum(vars[variable]))
				var/confirm=input("This variable is currently a number and probably shouldn't be text. Continue anyways?") in list("No","Yes")
				if(confirm=="No")
					return
			vars[variable]=input("","",vars[variable]) as text
		if("Number")
			vars[variable]=input("","",vars[variable]) as num
		if("File")
			vars[variable]=input("","",vars[variable]) as file
		if("View List")
			usr << "<hr>"
			for(var/q in vars[variable])
				usr << "[q] - [vars[variable][q]]"
			usr << "<hr>"
			return
		if("Edit List")
			var/list/options = list("Cancel")
			for(var/q in vars[variable])
				options.Add(q)
			var/blah = input("Edit what?") in options
			if(blah == "Cancel")
				return
			var/bluh = input("As number or text?") in list("Number","Text","Cancel")
			if(bluh == "Cancel")
				return
			if(bluh == "Number")
				vars[variable][blah] = input("","",vars[variable][blah]) as num
			if(bluh == "Text")
				vars[variable][blah] = input("","",vars[variable][blah]) as text

/atom/Topic(href, list/href_list)
	. = ..()
	if(.)
		return
	var/action = href_list["action"]
	var/value = href_list["value"]
	switch(action)
		if("look")
			// use locate() to get the reference of the text returned by \ref
			var/target = locate(value)
			// if it exists (player hasn't logged out after window refreshed), call the look_at() function
			if(target)
				src.look_at(target,src)
			return TRUE
		if("close")
			// close the window when the player clicks the 'close' button
			src << browse(null, "window=playerlist")
			return TRUE

/atom/Topic(href, list/href_list)
	. = ..()
	if(.)
		return
	var/action2 = href_list["action2"]
	var/value2 = href_list["value"]
	switch(action2)
		if("lookwep")
			// use locate() to get the reference of the text returned by \ref
			var/target2 = locate(value2)
			// if it exists (player hasn't logged out after window refreshed), call the look_at() function
			if(target2)
				src.look_atweapon(target2,src)
			return TRUE
		if("lookchem")
			var/target2 = locate(value2)
			if(target2)
				src.look_atchemistry(target2,src)
			return TRUE
		if("close")
			// close the window when the player clicks the 'close' button
			src << browse(null, "window=playerlist")
			return TRUE

/atom/Topic(href, list/href_list)
	. = ..()
	if(.)
		return
	var/action4 = href_list["action4"]
	var/value = href_list["value"]
	switch(action4)
		if("lookmat")
			// use locate() to get the reference of the text returned by \ref
			var/target = locate(value)
			// if it exists (player hasn't logged out after window refreshed), call the look_at() function
			if(target)
				src.look_materia(target,src)
			return TRUE
		if("close")
			// close the window when the player clicks the 'close' button
			src << browse(null, "window=playerlist")
			return TRUE

mob
	Topic(href, list/href_list)
		..()
		var/action = href_list["action"]
		var/value = href_list["value"]
		switch(action)
			if("look")
				// use locate() to get the reference of the text returned by \ref
				var/target = locate(value)
				// if it exists (player hasn't logged out after window refreshed), call the look_at() function
				if(target) src.look_at(target)
			if("close")
				// close the window when the player clicks the 'close' button
				src << browse(null, "window=playerlist")
			if("blu")
				var/target=locate(value)
				if(target) src.Learnblu(target,src)

	Topic(href, list/href_list)
		..()
		var/action2 = href_list["action2"]
		var/value2 = href_list["value"]
		switch(action2)
			if("lookwep")
				// use locate() to get the reference of the text returned by \ref
				var/target2 = locate(value2)
				// if it exists (player hasn't logged out after window refreshed), call the look_at() function
				if(target2) src.look_atweapon(target2,src)
			if("close")
				// close the window when the player clicks the 'close' button
				src << browse(null, "window=playerlist")
	Topic(href, list/href_list)
		..()
		var/action4 = href_list["action4"]
		var/value = href_list["value"]
		switch(action4)
			if("lookmat")
				// use locate() to get the reference of the text returned by \ref
				var/target = locate(value)
				// if it exists (player hasn't logged out after window refreshed), call the look_at() function
				if(target) src.look_materia(target,src)
			if("close")
				// close the window when the player clicks the 'close' button
				src << browse(null, "window=playerlist")

	verb
		list_perks()
			var/page
			var/list/generated = list()

			for(var/obj/perk/M in world)
				generated += \
				{"
					<tr>
						<td width="40%"> [M.name] </td>
						<td width="60%">
							<a href="byond://?src=\ref[src]&action=look&value=\ref[M]">
								Click to view statistics
							</a>
						</td>
					</tr>
				"}

			page = \
			{"
				<html>
					<head> <title>Perk List</title> </head>
				<body>
					<b>Perks found:</b>
					<table width="100%" border="1">
						[jointext(generated, "")]
					</table>
					<a href="byond://?src=\ref[src]&action=close">\[Close Window\]</a>
				</body>
				</html>
			"}

			src << browse(page, "window=playerlist&size=500x300")
