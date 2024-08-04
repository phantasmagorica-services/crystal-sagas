/obj/RPing
	icon='Rping.dmi'
	layer =99

/mob
	var/textcolor = "white"

var/list/naughtywords = list("sex","penis","pussy","cock","ass","dick","breast","boob","vagina","nipple","asshole")

/mob/proc/ChatLog(var/Info)
	set background=1
	if(length(Info)>=8000)
		Info="This entry was too long to be apended to the chat log."
	if(src.client)
		var/outputFile = file("data/ChatLogs/[src.ckey]/[time2text(world.realtime,"DD-MM-YY")].html")
		if(fexists(outputFile))
			outputFile << "<font color = black>[time2text(world.realtime,"hh:mm")]</font> [Info]"
		else
			outputFile << "<font color = black>[time2text(world.realtime,"hh:mm")]</font> [Info]"

/mob/proc/Adminlog(var/Info)
	set background = 1
	if(src.client)
		var/outputFile = file("data/ChatLogs/Adminlogs.html")
		if(fexists(outputFile))
			outputFile << "<font color = black>[time2text(world.realtime,"DD-MM-YY hh:mm")]</font> <font color = blue> [Info]</font>"
		else
			outputFile << "<font color = black>[time2text(world.realtime,"DD-MM-YY hh:mm")]</font> <font color = blue>[Info]</font>"

/mob/proc/AuditLog(var/Info)
	set background=1
	if(length(Info)>=8000)
		Info="This entry was too long to be apended to the chat log."
	if(src.client)
		var/outputFile = file("data/AuditLogs/[src.ckey]/[time2text(world.realtime,"DD-MM-YY")].html")
		if(fexists(outputFile))
			outputFile << "<font color = black>[time2text(world.realtime,"hh:mm")]</font> [Info]"
		else
			outputFile << "<font color = black>[time2text(world.realtime,"hh:mm")]</font> [Info]"

/mob/verb/Sayb()
	set hidden =1
	var/t
	t=input(usr,"What would you like to say?")
	var/preface
	if(!t)
		return
	if(t=="")
		return
	else
		if(findtext(t,"!"))
			preface="shouts"
		else
			preface="says"
		var/text = "<font color=[src.textcolor]><font size = 1><b>[src.name] [preface]:</b> <font color=white>[t]</font>"
		log_say(src, t)
		view() << output("[text]","icout")
		ChatLog(text)
		if(usr.tempeventmin)
			AuditLog(text)
		if(findtext(t,"("))

		else
			var/c=length(t)
			usr.emoteamount+=round(c*0.5)
		usr.overlays+='Exclamation.dmi'
		spawn(40)
			usr.overlays-='Exclamation.dmi'
		Checkreward(usr)

/mob/verb/Say(t as text)
	if(usr.intitlescreen)
		return
	if(!t || t == "") return
	var/preface = "says"
	if(findtext(t,"!"))
		preface = "shouts"
	var/text = "<font color=[usr.textcolor]><font size = 1><b>[usr.name] [preface]:</b> <font color=white>[t]</font>"
	log_say(src, t)
	viewers() << output("[text]","icout")
	ChatLog(text)
	if(usr.tempeventmin)
		AuditLog(text)
	if(!findtext(t,"("))
		usr.emoteamount += round(length(t)*0.75)
	usr.overlays += 'Exclamation.dmi'
	spawn(40)
	usr.overlays -= 'Exclamation.dmi'
	Checkreward(usr)

/mob/verb/Emote()
	var/charamount
	if(usr.intitlescreen)
		return
	if(usr.muted)
		usr << "<B><font color=#C0FFC0>You have been muted!"
	usr.overlays+='Rping.dmi'
	var/m = input("What does your character wish to do?")as message
	if(!m)
		usr.overlays-='Rping.dmi'
		return
	else
		//if(naughtywordfilter)
			//if(findtext(m,naughtywords))
				//client.HttpPost("https://discordapp.com/api/webhooks/790720751123824670/Bpgk49jrKVq3Zcav6IBlccwtUerlhNMc0TI1XaahGaOLZfnkqOwxTDF_PBMOQpMvM0Qr",list(content="( ͡° ͜ʖ ͡°)"))
		var/text = "<font color=[src.textcolor]><font size = 0.5>[src.name] [m]</font><br>"
		ChatLog(text)
		log_emote(src, m)
		view()<< output("<font color=[src.textcolor]><font size = 0.5>[src.name] [m]","icout")
		charamount = length(m)
		usr.emoteamount+=charamount
		Checkreward(usr)
		usr.overlays-='Rping.dmi'
		usr.Save()

/mob/verb/Ooc(t as text)
	if(!t)
		return
	if(usr.muted)
		usr << "<B><font color=#C0FFC0>You have been muted!"
		return
	else
		log_ooc(src, t)
		view() << output("<font color=[src.textcolor]><font size = 1><b>[src.name] says:</b><font color=white> ([t])</font>","looc")

/mob/verb/Localooc()
	set hidden = 1
	winset(usr,"Oocchat","is-visible=true")

/mob/verb/Who()
	var/amount=0
	for(var/mob/m in world)
		if(m.client) amount++
	winset(usr,"Who","is-visible=true")
	winset(usr,"Who.whog","cells=0x0")
	var/Row = 1
	if(amount==1)
		winset(usr,"Who.online","text=\"[amount] player online.\"")
	else
		winset(usr,"Who.online","text=\"[amount] players online.\"")
	for(var/mob/M in world)
		if(M.client)
			if(usr.adminlv<1)
				usr << output("[M.key]","Who.whog:1,[Row]")
			else
				usr << output("[M.key] ([M.name])","Who.whog:1,[Row]")
			Row++

/mob/verb/Announce(m as message)
	set hidden = 1
	if(!m)
		return
	else
		view() << output("<font color=#ff3300><font size = 3>[m]</font>","oocout")
		if(usr.tempeventmin)
			AuditLog(text)

/proc/Checkreward(var/mob/m)
	var/currenttime = time2text(world.realtime,"Day")
	if(m.rppcheckdate==currenttime&&m.rppchecks==5)
		return
	if(m.rppcheckdate!=currenttime)
		m.rppcheckdate=currenttime
		m.rppchecks=0
		m.limitbreakused=0
		/*if(m.emoteamount>=7500)
			m.emoteamount-=7500
			m.emoteamount*=0.5
		else
			m.emoteamount=0*/

	//! TEPMORARY: PROGRESSION FREEZE
	if(m.trpp >= 80)
		if(m.emoteamount >= 6000 && m.rppchecks < 1)
			m.rppchecks++
			m.send_chat("You are currently at the 80 RPP progression cap put into place during storyline catchup. Your emotes/participation will be stored for later, but you will not continue to gain RPP until the lock is lifted.", stream = "oocout")
		return

	//Every RPP bracket should total up to 6000 to hit their daily cap.
	if(m.emoteamount>=12000 && m.rppchecks<1 && m.trpp>=200)
		m.rpp+=1
		m.trpp+=1
		m.rppchecks+=1
		m.emoteamount-=12000
		m << output("You have reached an RPP milestone for the day. You have gained 1 RPP for a total of [m.rppchecks].","oocout")
		Updaterank(m)
	if(m.emoteamount>=9000 && m.rppchecks<1 && m.trpp>=150 && m.trpp<200)
		m.rpp+=1
		m.trpp+=1
		m.rppchecks+=1
		m.emoteamount-=9000
		m << output("You have reached an RPP milestone for the day. You have gained 1 RPP for a total of [m.rppchecks].","oocout")
		Updaterank(m)
	if(m.emoteamount>=6000 && m.rppchecks<1 && m.trpp>=100 && m.trpp<150)
		m.rpp+=1
		m.trpp+=1
		m.rppchecks+=1
		m.emoteamount-=6000
		m << output("You have reached an RPP milestone for the day. You have gained 1 RPP for a total of [m.rppchecks].","oocout")
		Updaterank(m)
	if(m.emoteamount>=3000 && m.rppchecks<2 && m.trpp>=80 && m.trpp<100)
		m.rpp+=1
		m.trpp+=1
		m.rppchecks+=1
		m.emoteamount-=3000
		m << output("You have reached an RPP milestone for the day. You have gained 1 RPP for a total of [m.rppchecks].","oocout")
		Updaterank(m)
	if(m.emoteamount>=2000 && m.rppchecks<3 && m.trpp>=50 && m.trpp<80)
		m.rpp+=1
		m.trpp+=1
		m.rppchecks+=1
		m.emoteamount-=2000
		m << output("You have reached an RPP milestone for the day. You have gained 1 RPP for a total of [m.rppchecks].","oocout")
		Updaterank(m)
	if(m.emoteamount>=1200 && m.rppchecks<5 && m.trpp<50)
		m.rpp+=1
		m.trpp+=1
		m.rppchecks+=1
		m.emoteamount-=1200
		m << output("You have reached an RPP milestone for the day. You have gained 1 RPP for a total of [m.rppchecks].","oocout")
		Updaterank(m)

/proc/Updaterank(var/mob/m)
	if(m.trpp<80&&m.trpp>=45)
		if(m.rank=="Rookie")

			return
		else
			m.rank="Rookie"
			m.rankbonus=2
			m.maxsummonsC=2
			m.maxsummonsB=1
			m.mhp+=40
			m.hp+=40
			m.msp+=40
			m.sp+=40
			m.mmp+=40
			m.mp+=40
			m.APcap=14
	if(m.trpp>=80&&m.trpp<100)
		if(m.rank=="Adept")
			return
		else
			m.rank="Adept"
			m.rankbonus=3
			m.maxsummonsC=3
			m.maxsummonsB=2
			m.mhp+=30
			m.hp+=30
			m.msp+=30
			m.sp+=30
			m.mmp+=30
			m.mp+=30
			m.APcap=18
	if(m.trpp>=150&&m.trpp<200)
		if(m.rank=="Hero")
			return
		if(m.rank!="Veteran")
			return
		else
			m.rank="Hero"
			m.rankbonus=5
			m.maxsummonsC=5
			m.maxsummonsB=3
			m.maxsummonsA=2
			m.mhp+=35
			m.hp+=35
			m.msp+=35
			m.sp+=35
			m.mmp+=35
			m.mp+=35
			m.APcap=26
			m.strcap=24
			m.dexcap=24
			m.concap=24
			m.intcap=24
			m.wiscap=24
			m.chacap=24
	if(m.trpp>=200)
		if(m.rank=="Master")
			return
		else
			m.rank="Master"
			m.rankbonus=6
			m.maxsummonsA=3
			m.mhp+=45
			m.hp+=45
			m.msp+=45
			m.sp+=45
			m.mmp+=45
			m.mp+=45
			m.APcap=30
			m.strcap=26
			m.dexcap=26
			m.concap=26
			m.intcap=26
			m.wiscap=26
			m.chacap=26
