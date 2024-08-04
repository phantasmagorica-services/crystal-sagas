/**
 * base type of /atom/movable, which are all objects in BYOND that can be in an arbitrary location
 */
/atom/movable
	abstract_type = /atom/movable

	//* Entity Serialization
	/// our entity ID; must be unique
	/// if this is null, we will never be serialized
	var/entity_id
	/// are we modified? if so, we store our entity serialization/deserialization data, rather than just our ID
	var/entity_modified = FALSE

/atom/movable/clone(atom/newloc)
	CRASH("not implemented")

/**
 * Stores full state, not just base state
 *
 * This is on /movable level because /atom requires better handling than this by far.
 */
/atom/movable/proc/entity_serialize()
	RETURN_TYPE(/list)
	. = list()
	/// store core data like perks, etc
	var/list/entity_data = serialize()
	if(!isnull(entity_data))
		.["entity"] = entity_data

/**
 * Restores full state, not just base state
 *
 * This is on /movable level because /atom requires better handling than this by far.
 */
/atom/movable/proc/entity_deserialize(list/data)
	/// restore core data like perks, etc
	if(!isnull(data["entity"]))
		deserialize(data["entity"])

/**
 * Resets to default
 */
/atom/movable/proc/entity_reset()
	entity_modified = FALSE
