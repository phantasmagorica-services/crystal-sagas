/**
 * global singletons fetched from repository controllers
 *
 * they can be registered, or non-registered.
 *
 * ids are optional, but no id means it can only be fetched by type. set anonymous to TRUE for that!
 *
 * All prototypes should be:
 * * serializable
 * * comparable
 */
/datum/prototype
	abstract_type = /datum/prototype

	//? Identity
	/// id - must be unique within the repository subsystem this is stored in.
	/// Should be in CamelCase
	var/id
	/// anonymous? if true, we generate an id if coded id is not available.
	var/anonymous = FALSE
	/// namespace for anonymous generation - must be set if anonymous
	var/anonymous_namespace
	/// id next global on /datum/prototype
	var/static/id_next = 0

	/// should this be saved?
	//  todo: not yet implemented
	var/savable = FALSE
	/// lazyloaded
	var/lazy = FALSE

/datum/prototype/New()
	if(anonymous && isnull(id))
		id = generate_anonymous_uid()

/datum/prototype/proc/generate_anonymous_uid()
	// unique always, even across rounds
	ASSERT(anonymous_namespace)
	return "[anonymous_namespace]-[num2text(world.realtime, 16)]-[++id_next]"

/**
 * called on register
 *
 * if registration fails, unregister() will be called - this should clean up side effects.
 *
 * @return TRUE / FALSE to allow / deny register
 */
/datum/prototype/proc/register()
	return TRUE

/**
 * called on unregister
 * this should never fail; returning FALSE causes a fatal runtime to be generated.
 *
 * @return TRUE / FALSE on success / failure
 */
/datum/prototype/proc/unregister()
	return TRUE

/datum/prototype/serialize()
	. = ..()
	.["id"] = id

/datum/prototype/deserialize(list/data)
	. = ..()
	id = data["id"]

/**
 * Supertype of "simple" prototypes without any serious amount of processing to register/unregister
 */
/datum/prototype/struct
	abstract_type = /datum/prototype/struct
