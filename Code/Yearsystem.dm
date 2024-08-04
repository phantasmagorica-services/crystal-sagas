var/global/obj/cooldownchecker/day_checker

/obj/cooldownchecker
	var/totalpasses=0
	/// last day of week we were checked
	//  todo: better system
	var/last_dayofweek

/obj/cooldownchecker/New()
	var/savefile/day_save = new("data/legacy/day_system")
	day_save["day"] >> last_dayofweek
	day_save["totalpasses1"] >> totalpasses
	if(isnull(totalpasses))
		//! WARNING WARNING SHITCODE ALERT: THIS IS NEEDED TO MIGRATE FROM OLD SYSTEM
		totalpasses = 1000
	if(!isnull(global.day_checker))
		stack_trace("deleted an enemy day checker")
		del global.day_checker
	global.day_checker = src
	loop()

/obj/cooldownchecker/proc/loop()
	set waitfor = FALSE
	do_loop()

/obj/cooldownchecker/proc/do_loop()
	while(TRUE)
		auto_prime()
		sleep(1 MINUTES)

/obj/cooldownchecker/proc/auto_prime()
	var/current_dayofweek = time2text(world.realtime, "Day")
	if(current_dayofweek == last_dayofweek)
		return
	last_dayofweek = current_dayofweek
	log_world("TIME: day-looper firing")
	spawn(15 SECONDS) // don't hit anything else if it's at world boot this is shitcode oh well
		if(global.day_checker != src)
			log_world("TIME: day-looper aborted")
			return
		totalpasses++
		RefreshDay(totalpasses)
		log_world("TIME: day-looper finished")

		var/savefile/day_save = new("data/legacy/day_system")
		day_save["day"] << last_dayofweek
		day_save["totalpasses1"] << totalpasses

var/year = 1466
var/yearcount
var/yearspeed
var/month = 1
var/monthname
var/monthcount
var/daytime = "Night"

/proc/Time()
	while(TRUE)
		set background = TRUE
		if(daytime=="Day")
			daytime="Night"
			sd_OutsideLight(4)
			world<<output("It is now night time.","oocout")
		else
			daytime="Day"
			world<<output("It is now day time.","oocout")
			sd_OutsideLight(6)
		monthcount++
		if(monthcount==28)
			month++
			monthcount=0
			Monthname(month)
			yearcount++
			for(var/mob/m in world)
				m.teachslot = 0
			world<<output("It is Month [monthname] of Year [year]AS","oocout")
		if(yearcount==10)
			year++
			yearcount=0
			month = 1
			Monthname(month)
			Agecheck()
			world<<output("It is now Year [year]AS","oocout")
		sleep(432000)

/proc/RefreshDay(total_passes)
	set background = TRUE
	for(var/obj/resource_node/N in global.resource_nodes)
		N.refresh()
	for(var/mob/a in world)
		a.stockdrawn=0
		a.Lifestreamraincooldown=0
		a.FATEcooldown=0
		a.dailyfates=0
		a.limitbreakused=0
		a.totalpasses = total_passes
		a.FATEcooldown=0
		a.minednodes=0
		a.Save()
	for(var/obj/Faction/a in world)
		a.Collectcooldown=0
	for(var/obj/Factionupgrades/a in world)
		a.Collectcooldown=0
	world.send_chat("It's a new day! All 24 hour cooldowns have been reset.", stream = "icout")
	Saveworld()
	//sleep(150)
	//world.Reboot() //This will make the game auto-reboot

/proc/Monthname(n as num)
	if(n==1)
		monthname = "Dawnmonth"

/proc/Agecheck()
	for(var/mob/m in world)
		if(m.client)
			m.age++
