// todo: /datum/prototype/perk

/obj/perk
	//* Serialization
	//  todo: move to /datum/prototype/perk
	/// Unique ID
	var/id
	/// modified ; set to TRUE to serialize everything rather than just store by path
	/// you must set this to TRUE for custom perks, or it'll be wiped on reboot.
	//  todo: move to /datum/prototype
	var/modified = FALSE

	//* new ability-attack system
	/// set this to the typepath of an attack ability or attack datum if you want a lazy-set attack (or attacks)
	var/tmp/list/attacks
	/// set this to list of typepaths of abilities
	//  todo: this does nothing yet
	var/tmp/list/abilities

	//? basic roll-to-hit for active abilities with an attack button
	/// uniform random, or dice roll?
	var/attack_roll_damage_dice = FALSE
	/// lower range for uniform random
	var/attack_roll_damage_lower
	/// upper range for uniform random
	var/attack_roll_damage_upper
	/// set this to bypass random and force fixed
	var/attack_roll_damage_exact
	/// number of dice to roll for dice roll damage calculations
	var/attack_roll_dice_count
	/// sides of dice to roll for dice roll damage calculations
	var/attack_roll_dice_sides

	//? requirements for purchase
	/// list of stats required
	var/list/purchase_stat_requirements
	/// one of these must be met
	var/list/purchase_stat_requirements_any

/**
 * we have a valid standard attack or healing roll
 */
/obj/perk/proc/valid_standard_attack()
	return !!valid_raw_attack_damage_roll()

/**
 * we have a valid raw attack damage or healing roll
 */
/obj/perk/proc/valid_raw_attack_damage_roll()
	if(attack_roll_damage_dice)
		return !isnull(attack_roll_dice_count) && !isnull(attack_roll_dice_sides)
	return !isnull(attack_roll_damage_exact) || (!isnull(attack_roll_damage_lower) && !isnull(attack_roll_damage_upper))

/**
 * renders raw attack roll damage portion as text desc, ignoring damage type / buffs / weapon / etc
 */
/obj/perk/proc/describe_raw_attack_damage_roll()
	return attack_roll_damage_dice? "[attack_roll_dice_count]d[attack_roll_dice_sides]" : "[attack_roll_damage_lower]-[attack_roll_damage_upper]"

/**
 * performs raw attack roll, ignoring damage type / buffs / weapon / etc
 */
/obj/perk/proc/raw_attack_damage_roll()
	ASSERT(valid_raw_attack_damage_roll())
	if(attack_roll_damage_dice)
		return dice_roll(attack_roll_dice_count, attack_roll_dice_sides)
	if(!isnull(attack_roll_damage_exact))
		return attack_roll_damage_exact
	return rand(attack_roll_damage_lower, attack_roll_damage_upper)

/**
 * renders perk description in one line, useful for alert()
 */
/obj/perk/proc/describe_string()
	return desc

// todo: auto damage render, more describe()'s

// todo: describe_markdown()
// todo: describe_html()
// todo: describe_data() for ui render

