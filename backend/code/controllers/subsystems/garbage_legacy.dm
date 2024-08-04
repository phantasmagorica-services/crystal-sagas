// todo: obviously get rid of this lmao
/proc/qdel(datum/thing)
	thing.Destroy()
	del(thing)

/datum/Del()
	gc_destroyed = GC_IN_DESTROY
	if(gc_destroyed == null)
		Destroy()
	return ..()
