/* This demo is for making things slower and faster.*/
// To test it, just Build/Compile and than Build/Run.

client/var/delay=1
client/var/tmp/move=1

//Simple, short, and sweet.
mob/Move()
	winset(usr,"compass.comp","text=\"Location: [usr.x], [usr.y], [usr.areain]\"")
	if(src.battler==1)
		return FALSE
	else
		return ..()

/client/Move(loc, dir)
	if(src.move)
		src.move=0
		. = ..()
		sleep(src.delay)
		src.move=1

//Testing stuff.
mob/verb/change_delay()
	set name="Zippy Mode"
	if(usr.adminlv<1) return
	client.delay=input("The bigger the number, the slower you will walk.","Delay",client.delay)as num
