/**
 * status effects
 *
 * has support for ticking per turn in automated/mechanical battles,
 * otherwise has a description one can view
 *
 * global hardcoded effects are singletons but admins/people with permissions can add more.
 */
/datum/prototype/status_effect
	abstract_type = /datum/prototype/status_effect
	namespace = PROTOTYPE_NAMESPACE_STATUS_EFFECT
	/// name
	var/name
	/// description - what the user sees
	var/desc

/datum/prototype/status_effect/serialize()
	. = ..()
	.[NAMEOF(src, name)] = name
	.[NAMEOF(src, desc)] = desc

/datum/prototype/status_effect/deserialize(list/data)
	. = ..()
	name = data[NAMEOF(src, name)]
	desc = data[NAMEOF(src, desc)]

/datum/prototype/status_effect/validate_serializable()
	return ..() && length(id) && istext(id)

/**
 * THESE are the ones you should be using for custom rp effects.
 * you don't *need* to use these but these, by default, will save.
 */
/datum/prototype/status_effect/custom
	saved = TRUE
	auto_init = FALSE

/**
 * an instance of a status effect
 */
/datum/status_instance
	/// identifier - id
	var/id
	/// turns left
	var/turns_left

/datum/status_instance/serialize()
	return ..() + list(
		NAMEOF(src, id) = id,
		NAMEOF(src, turns_left) = turns_left,
	)

/datum/status_instance/deserialize(list/data)
	. = ..()
	id = data[NAMEOF(src, id)]
	turns_left = data[NAMEOF(src, turns_left)]

/**
 * called on apply, regardless of if it's just refreshing or not; this happens even if we don't actually increase the duration
 *
 * @params
 * * victim - person applied to
 * * silent - don't make a message
 * * duration - the new duration the person now has.
 * * old_duration - the previous duration, if any; this does not have to be lower necessarily.
 */
/datum/prototype/status_effect/proc/apply(mob/victim, silent, duration, old_duration)
	return

/**
 * called when applied in a mechanical battle, regardless of if it's just refreshing or not; this happens even if we don't actually increase the duration
 *
 * @params
 * * victim - person applied to
 * * silent - don't make a message
 * * duration - the new duration the person now has
 * * old_duration - the previous duration, if any; this does not have to be lower necessarily.
 * * battle - mechanical battle instance
 */
/datum/prototype/status_effect/proc/mechanical_apply(mob/victim, silent, duration, old_duration, datum/battle/mechanical/battle)
	return

/**
 * called on remove
 *
 * @params
 * * victim - person removing from
 * * silent - don't make a message
 * * old_duration - the previous duration.
 */
/datum/prototype/status_effect/proc/remove(mob/victim, silent, old_duration)
	return

/**
 * called when removing in a mechanical battle
 *
 * @params
 * * victim - person removing from
 * * silent - don't make a message
 * * old_duration - the previous duration.
 * * battle - mechanical battle instance
 */
/datum/prototype/status_effect/proc/mechanical_remove(mob/victim, silent, old_duration, datum/battle/mechanical/battle)
	return

/**
 * called every tick of a mechanical battle
 *
 * @params
 * * victim - person with us
 * * silent - don't make messages (if applicable)
 * * duration - duration left before tick
 * * battle - mechanical battle
 */
/datum/prototype/status_effect/proc/mechanical_tick(mob/victim, silent, duration, datum/battle/mechanical/battle)
	return

//? mob procs

/**
 * apply a status effect
 * will refresh duration if already applied
 *
 * @params
 * * id_typepath_instance - of the status effect
 * * silent - suppress messages if possible
 * * duration - new duration
 * * overwrite - shorten duration if duration is longer; without this, it only extends.
 */
/mob/proc/apply_status_effect(datum/prototype/status_effect/id_typepath_instance, silent, duration, overwrite)
	var/datum/prototype/status_effect/effect = status_effect_repository.fetch(id_typepath_instance)
	var/datum/status_instance/instance = status_instances?[effect.id]
	var/old_duration
	if(instance)
		old_duration = instance.turns_left
		instance.turns_left = overwrite? duration : max(instance.turns_left, duration)
	else
		instance = new
		instance.turns_left = duration
		instance.id = effect.id
		LAZYLIST_SET(status_instances, effect.id, instance)
	effect.apply(src, silent, duration, old_duration)
	if(istype(active_battle, /datum/battle/mechanical))
		effect.mechanical_apply(src, silent, duration, old_duration, active_battle)
	return TRUE

/**
 * remove a status effect
 */
/mob/proc/remove_status_effect(datum/prototype/status_effect/id_typepath_instance, silent)
	var/datum/prototype/status_effect/effect = status_effect_repository.fetch(id_typepath_instance)
	var/datum/status_instance/instance = status_instances?[effect.id]
	if(!instance)
		return FALSE
	if(istype(active_battle, /datum/battle/mechanical))
		effect.mechanical_remove(src, silent, instance.turns_left, active_battle)
	effect.remove(src, silent, instance.turns_left)
	status_instances -= effect.id
	return TRUE

/**
 * check for a status effect, returning null for none and number for turns left if existing
 */
/mob/proc/has_status_effect(datum/prototype/status_effect/id_typepath_instance)
	var/datum/prototype/status_effect/effect = status_effect_repository.fetch(id_typepath_instance)
	var/datum/status_instance/instance = status_instances?[effect.id]
	return instance?.turns_left

/**
 * purge status effects
 */
/mob/proc/purge_status_effects(silent)
	for(var/id in status_instances)
		remove_status_effect(id, silent)

/**
 * tick down status effects
 *
 * @params
 * * amount - turns, defaulting to 1
 * * silent - call ticks with silent param set to TRUE
 * * mechanical_tick - is this a mechanical battle tick? if so, MUST have battle instance
 * * battle - battle instance, if relevant, whether or not mechanical (optional)
 */
/mob/proc/tick_status_effects(amount = 1, silent, mechanical_tick, datum/battle/battle)
	ASSERT(!mechanical_tick || istype(battle))
	for(var/id in status_instances)
		var/datum/prototype/status_effect/effect = status_effect_repository.fetch(id)
		var/datum/status_instance/instance = status_instances[id]
		if(mechanical_tick)
			effect.mechanical_tick(src, silent, instance.turns_left, battle)
		instance.turns_left--
		if(instance.turns_left <= 0)
			remove_status_effect(id, silent)
