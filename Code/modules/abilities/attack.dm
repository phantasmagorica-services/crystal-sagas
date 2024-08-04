/**
 * ability to perform an attack
 */
/datum/ability/attack
	abstract_type = /datum/ability/attack
	/// list of attacks to perform
	var/list/datum/attack/attack_instances

// todo

/**
 * data on an attack roll
 *
 * this does not take into account what modifiers to use. that's not this datum's job.
 */
/datum/attack
	abstract_type = /datum/attack
	/// roll type
	var/attack_roll_type = ATTACK_ROLL_EXACT

	//* for exact
	var/roll_exact_damage = 0

	//* for rand
	var/roll_rand_high = 0
	var/roll_rand_low = 0

	//* for dice
	var/roll_dice_count = 0
	var/roll_dice_sides = 0

	//* damage type - set to path on compile to auto-init into id
	var/damage_type = /datum/damage_type/physical

/datum/attack/New()
	if(ispath(damage_type))
		var/datum/damage_type/casted = damage_type
		damage_type = initial(casted.id)

/**
 * add our damage packet to an attack
 *
 * todo: this doesn't work well for non dnd-likes
 *
 * @params
 * * attack - the attack event
 * * damage_mod - the +- to damage
 * * hit_mod - the +- to hit
 *
 * @return the modified attack event
 */
/datum/attack/proc/add_to_attack(datum/event_args/attack/attack, damage_mod = 0, hit_mod = 0)
	// todo
	return attack
