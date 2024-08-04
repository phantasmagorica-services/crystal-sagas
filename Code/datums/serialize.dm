/**
 * checks if our data state is consistent for serialization
 */
/datum/proc/validate_serializable()
	return TRUE

/**
 * does NOT pack type info.
 */
/proc/pack_datum_data(datum/D)
	ASSERT(isdatum(D))
	. = D.serialize()
	ASSERT(islist(.))

/**
 * does NOT unpack type info.
 */
/proc/unpack_datum_data(datum/D, list/data)
	ASSERT(isdatum(D))
	ASSERT(islist(data))
	D.deserialize(data)

/**
 * validates that a datum is valid for saving
 */
/proc/validate_datum_serializable(datum/D)
	return D.validate_serializable()
