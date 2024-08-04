mob
	verb
		turnleft()
			set hidden=1
			usr.dir = WEST
		turnright()
			set hidden=1
			usr.dir= EAST
		turnup()
			set hidden=1
			usr.dir=NORTH
		turndown()
			set hidden=1
			usr.dir=SOUTH
		testobj()
			var/obj/o=new
			o.icon='Icons/Blank.dmi'
			o.screen_loc="2,14"
			usr.client.screen+=o
		testperks()
			var/count
			for(var/obj/perk/p in perklist)
				count++
			world<<output("[count]","output1")
		SaveSelf()
			usr.Save()
		Roll()
			var/num1
			var/num2
			var/result
			num1=input("What is the starting the range of the roll?")as num
			num2=input("What is the ending range of the roll?") as num
			result=rand(num1,num2)
			view()<<output("[num1]~[num2]=[result]","icout")
		Adminhelp()
			var/obj/adminreport/r=new
			r.name=input("What is the subject of this report?") as text
			if(r.name==null)
				r.name="Report"
			r.desc=input("What are you in need of help with?") as message
			r.submitted=usr.ckey
			r.submitdate=time2text(world.realtime,"MM/DD/YYYY")
			for(var/obj/adminreportholder/a in world)
				a.contents+=r
			usr<<output("Your report has been submitted. Please be patient while an admin fixes your problem. If you don't receive a response in a timely manner, please submit a ticket on our discord channel.","oocout")
			// todo: not hardcoded admin ping ID
			world.TgsTargetedChatBroadcast("[key_name(usr)] submitted an adminhelp - [r.name]: [r.desc]. <@&810115110390726656>", admin_only = TRUE)
		OpenAdminPanel()
			if(usr.adminlv>0)
				winset(usr,"AdminPanel","is-visible=true")
			else if(usr.eventmin||usr.tempeventmin)
				winset(usr,"EventminPanel","is-visible=true")
		Compass()
			winset(usr,"compass","is-visible=true")
			winset(usr,"compass.comp","text=\"Location: [usr.x], [usr.y], [usr.areain]\"")
		Races()
			var/list/racs=new
			for(var/mob/Q in world)
				if(Q.client)
					if(!(racs.Find(Q.race)))
						racs.Add("[Q.race]")
						racs["[Q.race]"]=1
					else
						racs["[Q.race]"]++
			if(racs)
				for(var/x in racs)
					usr<<output("[x] - [racs[x]]","oocout")
		Turntracker()
			if(usr.turntracker==0)
				usr.turntracker=1
				var/obj/Turntracker/turn=new
				turn.x=usr.x
				turn.y=usr.y
				turn.z=usr.z
				turn.owner=usr.key
			else
				alert(usr,"You already have a turn tracker deployed!")

	proc
		statroll(var/mod,var/rolltype,var/n,var/bonus)
			if(n==null)
				n=src.name
			var/roll1=rand(1,20)
			var/roll2=rand(1,20)
			var/adjustroll1=roll1+mod+bonus
			var/adjustroll2=roll2+mod+bonus
			var/lower
			var/higher
			var/crit
			if(src.advantage||src.disadvantage)
				if(roll1==20 || roll2==20)
					crit=1
				if(adjustroll1>adjustroll2)
					higher=adjustroll1
					lower=adjustroll2
					if(src.advantage)
						if(crit==1)
							view()<<output("<font size=1><font color=[src.textcolor]>([n]) <font color=#86FDCD>[rolltype] at <font color=#98F7A2><b>advantage</b><font color=white>: <font color=#E1F3E3>[lower]  | <font color=#98F7A2><b>~[higher]~ | Critical Success, Nat 20!</b>","icout")
						else
							view()<<output("<font size=1><font color=[src.textcolor]>([n]) <font color=#86FDCD>[rolltype] at <font color=#98F7A2><b>advantage</b><font color=white>: <font color=#E1F3E3>[lower]  | <font color=#98F7A2><b>~[higher]~</b>","icout")
					else if(src.disadvantage)
						view()<<output("<font size=1><font color=[src.textcolor]>([n]) <font color=#86FDCD>[rolltype] at <font color=#CB230F><b>disadvantage</b><font color=white>: <font color=#E1F3E3>[higher]  | <font color=#CB230F><b>~[lower]~</b>","icout")
				else if(adjustroll1<adjustroll2)
					higher=adjustroll2
					lower=adjustroll1
					if(src.advantage)
						if(crit==1)
							view()<<output("<font size=1><font color=[src.textcolor]>([n]) <font color=#86FDCD>[rolltype] at <font color=#98F7A2><b>advantage</b><font color=white>: <font color=#E1F3E3>[lower]  | <font color=#98F7A2><b>~[higher]~ | Critical Success, Nat 20!</b>","icout")
						else
							view()<<output("<font size=1><font color=[src.textcolor]>([n]) <font color=#86FDCD>[rolltype] at <font color=#98F7A2><b>advantage</b><font color=white>: <font color=#E1F3E3>[lower]  | <font color=#98F7A2><b>~[higher]~</b>","icout")
					else if(src.disadvantage)
						view()<<output("<font size=1><font color=[src.textcolor]>([n]) <font color=#86FDCD>[rolltype] at <font color=#CB230F><b>disadvantage</b><font color=white>: <font color=#E1F3E3>[higher]  | <font color=#CB230F><b>~[lower]~</b>","icout")
				else
					if(src.advantage)
						if(crit==1)
							view()<<output("<font size=1><font color=[src.textcolor]>([n]) <font color=#86FDCD>[rolltype] at <font color=#98F7A2><b>advantage</b><font color=white>: <font color=white>[adjustroll1]  | <font color=white><b>[adjustroll2] | Critical Success, Nat 20!</b>","icout")
						else
							view()<<output("<font size=1><font color=[src.textcolor]>([n]) <font color=#86FDCD>[rolltype] at <font color=#98F7A2><b>advantage</b><font color=white>: <font color=white>[adjustroll1]  | <font color=white><b>[adjustroll2]</b>","icout")

					else if(src.disadvantage)
						view()<<output("<font size=1><font color=[src.textcolor]>([n]) <font color=#86FDCD>[rolltype] at <font color=#CB230F><b>disadvantage</b><font color=white>: <font color=white>[adjustroll1]  | <font color=#white><b>[adjustroll2]</b>","icout")
			else
				if(roll1==20)
					crit=1
					view()<<output("<font size=1><font color=[src.textcolor]>([n]) <font color=#86FDCD>[rolltype]: <font color=#47D34C><b>[adjustroll1]</font> | Critical success, natural 20!","icout")
				else
					view()<<output("<font size=1><font color=[src.textcolor]>([n]) <font color=#86FDCD>[rolltype]: <font color=white><b>[adjustroll1]</font>","icout")

