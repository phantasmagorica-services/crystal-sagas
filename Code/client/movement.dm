/client/Move(loc, dir)
	mob.pulledby?.stop_pulling(break_grip = TRUE)
	mob.stop_following()
	. = ..()
