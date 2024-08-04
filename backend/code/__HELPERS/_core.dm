/**
 * returns tag, or ref, of a datum
 *
 * why? because we can sometimes tag things instead of use a direct ref, as tags don't get reused. (hopefully.)
 */
/proc/AUTO_REF(datum/D)
	if(!istype(D))
		return ref(D)
	if(!D.use_tag)
		return ref(D)
	if(isnull(D.tag))
		SOFT_CRASH("datum [D] ([D.type]) marked to use tag but lacking tag")
		return ref(D)
	return D.tag

/**
 * throws a runtime error - this does not preserve original line numbers.
 */
/proc/SOFT_CRASH(msg)
	CRASH("[msg]")
