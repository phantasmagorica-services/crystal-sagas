/mob/Login()
	SHOULD_CALL_PARENT(TRUE)
	raise_signal(DSIG_MOB_LOGIN)
	. = ..()
