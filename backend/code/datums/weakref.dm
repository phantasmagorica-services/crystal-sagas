/**
 * weak reference system
 *
 * literally just a thing that doesn't stop garbage collection
 */
/datum/weakref
	/// what to locate (direct ref)
	var/memref

/datum/weakref/New(memref)
	src.memref = memref

/datum/weakref/proc/resolve()
	RETURN_TYPE(/datum)
	var/datum/D = locate(memref)
	return (D?.weakref == src) && src

/**
 * generates a weak reference to a datum
 */
/proc/weakref(datum/D)
	RETURN_TYPE(/datum/weakref)
	if(isnull(D.weakref))
		D.weakref = new /datum/weakref(ref(D))
	return D.weakref
