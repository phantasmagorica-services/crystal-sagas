/**
 * root mob var definitions
 */
/mob
	//? Intrinsics
	use_tag = TRUE
	/// next mob id
	var/static/mob_id_next = 0
	/// realtime used as a mutator for GUID-like behavior amongst mobs
	var/static/mob_guid_mutator = "[num2text(world.realtime, 999)]"

	//? Movement
	/// Who we are following
	var/tmp/mob/pulledby
	/// Who is following us (so we know who to pull / carrythrough)
	var/tmp/mob/pulling
	/// Who are we following
	var/tmp/mob/following
	/// Who is following us; lazy-init'd list
	var/tmp/list/mob/followers

	//? Combat
	/// status effects - serialized via new serialization system, so /tmp
	/// list is list(id_or_typepath = instance datum.)
	//  todo: impl
	var/tmp/list/status_instances
	/// active battle - serialized via new serialization system, so /tmp
	//  todo: impl
	var/tmp/datum/battle/active_battle

	//? Save / Load
	/// did we get loaded? if not, do not allow saving to prevent wipes
	var/tmp/load_complete = FALSE
	/// mutex to prevent save/loads from hitting each other
	var/tmp/load_mutex = FALSE

	//? Legacy Shit
	/// starting city enum
	var/starting_city

/mob/New(loc)
	// generate tag
	generate_tag()
	return ..()

/mob/Destruct()
	terminate_pulls()
	terminate_follows()
	return ..()

/mob/generate_tag()
	tag = "mob_[mob_guid_mutator]_[++mob_id_next]"

//? serialization

/mob/serialize()
	. = ..()

/mob/deserialize(list/data)
	. = ..()

/mob/validate_serializable()
	return ..()
