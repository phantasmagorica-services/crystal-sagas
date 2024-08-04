/**
 * Core helpers for the DND game system.
 */

// todo: ALL of these should be able to be rebuilt from scratch at will. enforce *stateless* caching.

//? the 3 combat intrinsics

/mob/proc/get_armor_class()
	return ac

/mob/proc/get_damage_reduction()
	return dr

/mob/proc/get_speed()
	return speed

//? the 6 core stats

/mob/proc/get_stat_dexterity()
	return dex

/mob/proc/get_statmod_dexterity()
	return dexmod

/mob/proc/get_stat_strength()
	return str

/mob/proc/get_statmod_strength()
	return strmod

/mob/proc/get_stat_constitution()
	return con

/mob/proc/get_statmod_constitution()
	return conmod

/mob/proc/get_stat_intelligence()
	return int

/mob/proc/get_statmod_intelligence()
	return intmod

/mob/proc/get_stat_wisdom()
	return wis

/mob/proc/get_statmod_wisdom()
	return wismod

/mob/proc/get_stat_charisma()
	return cha

/mob/proc/get_statmod_charisma()
	return chamod

//? the 4 attack modifiers

/mob/proc/get_magic_accuracy_bonus()
	return mab + mabadd

/mob/proc/get_magic_damage_bonus()
	return mdb + mdbadd

/mob/proc/get_physical_accuracy_bonus()
	return pab + pabadd

/mob/proc/get_physical_damage_bonus()
	return pdb + pdbadd
