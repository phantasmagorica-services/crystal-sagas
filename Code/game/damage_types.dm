LEGACY_GLOBAL_LIST_INIT(damage_types, init_damage_types())

/proc/init_damage_types()
	. = list()
	for(var/datum/damage_type/path as anything in subtypes_of_non_abstract(/datum/damage_type))
		path = new path
		.[path.id] = path

/**
 * Defines different damage types.
 */
/datum/damage_type
	abstract_type = /datum/damage_type
	/// name
	var/name = "???"
	/// unique id for this damage type - used for save/load
	var/id

/datum/damage_type/fire
	name = "Fire"
	id = "fire"

/datum/damage_type/ice
	name = "Ice"
	id = "ice"

/datum/damage_type/wind
	name = "Wind"
	id = "wind"

/datum/damage_type/water
	name = "Water"
	id = "water"

/datum/damage_type/holy
	name = "Holy"
	id = "holy"

/datum/damage_type/force
	name = "Force"
	id = "force"

/datum/damage_type/dark
	name = "Dark"
	id = "dark"

/datum/damage_type/physical
	name = "Physical"
	id = "physical"

/datum/damage_type/true
	name = "True"
	id = "true"

/datum/damage_type/thunder
	name = "Thunder"
	id = "thunder"

/datum/damage_type/poison
	name = "Poison"
	id = "poison"

/datum/damage_type/earth
	name = "Earth"
	id = "earth"

/datum/damage_type/fall
	name = "Falling"
	id = "fall"
