/**
 * supertype of almost all object types.
 */
/datum
	/// use tags instead of refs?
	var/use_tag = FALSE

	//? weakref.dm
	/// weak reference
	var/datum/weakref/weakref

	//? dispose.dm
	/**
	 * are we mid delete?
	 *
	 * ? this is not implemented on most types. ?
	 *
	 * possibe values:
	 * * null - not mid delete
	 * * nonnegative number - world.time of deletion
	 */
	var/disposing = null

	//? serialize.dm
	/// implements the serialization system?
	var/serializable = FALSE

	//? signals.dm
	/**
	 * signals - list(signal = list(datum = procpath))
	 */
	var/list/signals_lookup
	/**
	 * signals we registered on others - list(other = list(signals))
	 */
	var/list/signals_hooked

/**
 * orders ourselves to clean up anything needed.
 */
/datum/proc/Destruct()
	cleanup_signals()
	tag = null

/**
 * datum del hook to ensure deletion logic runs
 */
/datum/Del()
	/// cleanup logic
	if(disposing == null)
		Destruct()
	return ..()

/**
 * datum save hook to serialize
 */
/datum/Write(savefile/F)
	. = ..()
	if(serializable)
		if(validate_serializable())
			F["__data__"] << serialize()
		else
			stack_trace("attempted to Write but validate_serializable() failed on [type]")

/**
 * datum load hook to deserialize
 */
/datum/Read(savefile/F)
	. = ..()
	if(serializable)
		var/list/data
		F["__data__"] >> data
		if(data)
			deserialize(data)
