obj
	Partyholder

obj
	Party
		var/list/members=list()
		var/obj/FATEs/currentFATE=null
		var/leader
		var/totalmembers
		var/partyID
		var/FATEID
		var/FATEcooldown=0
		totalmembers=0
		icon='Icons/Items/Linkshell.png'
		DblClick()
			var/list/choices=list("Description")
			if(usr==src.leader)
				choices+="Change Leader"
			var/choice=input("What would you like to do?") as anything in choices
			switch(choice)
				if("Description")
					alert(usr,"[src.desc]")
				if("Change Leader")
					var/lchoice=input("Who would you like to give leadership?") as anything in src.members
					src.leader=lchoice
		Del()
			if(istype(currentFATE))
				del currentFATE
			return ..()

mob
	verb
		CreateParty()
			if(usr.inparty==0)
				var/list/yesno=list("Yes","No")
				var/choice=input("Would you like to create a new party?") as anything in yesno
				switch(choice)
					if("Yes")
						var/obj/Party/newparty=new
						var/pname="[usr.name] Party"
						newparty.name=pname
						newparty.partyID=pname
						newparty.leader=usr.name
						newparty.members+=usr
						usr.partyID=pname
						usr.inparty=1
						newparty.totalmembers=1
						var/pdesc=input("What is the description of this party?") as message
						newparty.desc=pdesc
						for(var/obj/Partyholder/a in world)
							a.contents+=newparty
						RefreshParty(usr)
					if("No")
						return
			else
				alert(usr,"You are already in a party!")


		PartyInvite()
			var/obj/Party/usrparty
			var/list/invites=list()
			for(var/obj/Party/a in world)
				if(a.partyID==usr.partyID)
					usrparty=a
					if(usrparty.totalmembers>=8)
						alert(usr,"You already have the maximum number of members (8).")
						return
					else
				else

			if(usr.inparty==1)
				for(var/mob/inv in view(usr))
					if(inv.partyID!=usr.partyID)
						invites+=inv
				var/mob/invchoice = input(usr,"Who would you like to invite to your party?") as null|anything in invites
				if(isnull(invchoice))
					return
				if(invchoice.inparty==1)
					alert(usr,"This person is already in a party!")
					return
				else
					var/list/invyesno = list("Yes","No")
					var/invreq = input(invchoice,"Would you like to join [usr]'s party?") as anything in invyesno
					switch(invreq)
						if("Yes")
							invchoice.partyID=usr.partyID
							invchoice.inparty=1
							for(var/obj/Party/par in world)
								if(par.partyID==usr.partyID)
									par.members+=invchoice
									par.totalmembers+=1
							RefreshParty(usr)
						if("No")
							alert(usr,"[invchoice] has denied your invitation.")
			else
				alert(usr,"You must be in a Party to invite someone to it.")
				return

		ViewParty()
			var/row
			var/row2
			var/row3
			winset(usr,"party","is-visible=true")
			winset(usr,"party.party","cells=0x0")
			winset(usr,"party.members","cells=0x0")
			winset(usr,"party.fate","cells=0x0")
			for(var/obj/Party/a in world)
				if(a.partyID==usr.partyID)
					row++
					usr<<output(a,"party.party:1,[row]")
			for(var/mob/b in world)
				if(b.partyID==usr.partyID && usr.inparty==1 && b != usr)
					row2++
					usr<<output(b,"party.members:1,[row2]")
			for(var/obj/Party/c in world)
				if(c.partyID==usr.partyID)
					for(var/obj/FATEs/q in c.contents)
						row3++
						usr<<output(q,"party.fate:1,[row3]")
						q.suffix="Coordinates: [q.CoordX],[q.CoordY],[q.locationarea]"
						winset(usr, "party.fate", "current-cell=2,[row3]")
						usr << output(q.suffix,"party.fate")



		LeaveParty()
			var/list/yesno=list("Yes","No")
			var/choice=input("Are you sure you'd like to leave this party?") as anything in yesno
			switch(choice)
				if("Yes")
					usr.inparty=0
					for(var/obj/Party/a in world)
						if(a.partyID==usr.partyID)
							a.members-=usr
							a.totalmembers-=1
							RefreshParty(usr)
						if(a.totalmembers==0)
							del a
					usr.partyID=null
				if("No")
					return
atom
	proc
		RefreshParty(var/mob/usr)
			var/row
			var/row2
			var/row3
			winset(usr,"party.party","cells=0x0")
			winset(usr,"party.members","cells=0x0")
			winset(usr,"party.fate","cells=0x0")
			for(var/obj/Party/a in world)
				if(a.partyID==usr.partyID)
					row++
					usr<<output(a,"party.party:1,[row]")
			for(var/mob/b in world)
				if(b.partyID==usr.partyID && usr.inparty==1)
					row2++
					usr<<output(b,"party.members:1,[row2]")
			for(var/obj/Party/c in world)
				if(c.partyID==usr.partyID)
					for(var/obj/FATEs/q in c.contents)
						row3++
						usr<<output(q,"party.fate:1,[row3]")
						q.suffix="Coordinates: [q.CoordX],[q.CoordY],[q.CoordZ]"
						winset(usr, "party.fate", "current-cell=2,[row3]")
						usr << output(q.suffix,"party.fate")
