/**
 * legacy weapons
 */
/obj/item/Weapon
	abstract_type = /obj/item/Weapon

	//* old stats system - moved to here and well documented
	/// use weapon system?
	/// this is here because some things are under /Weapon but aren't .. weapons.
	var/tmp/weapon_system = TRUE
	/// weapon tier - use defines
	var/tmp/weapon_tier = WEAPON_TIER_BRONZE
	/// innate tohit bonus
	var/tmp/weapon_innate_hit = 0
	/// innate damage bonus
	var/tmp/weapon_innate_damage = 0
	/// innate crit bonus; if you set this to any negative number, the weapon can't crit at all as its crit range will be above 20.
	var/tmp/weapon_innate_crit = 0
	/// innate hands required
	var/tmp/weapon_handedness = 1
	/// what stat we scale with (damage and to hit)
	var/tmp/weapon_stat = CHARACTER_STAT_STR
	/// tile range
	var/tmp/weapon_range = 1

	/// constant multiplier for tier_scaling_constant - added to damage as a constant
	var/tmp/weapon_scale_constant = 0
	/// floor of damage roll, multiplied by tier
	var/tmp/weapon_scale_low = 1
	/// ceiling of damage roll, multiplied by tier
	var/tmp/weapon_scale_high = 2

	/// base low damage roll
	var/tmp/weapon_base_low = 0
	/// base high damage roll
	var/tmp/weapon_base_high = 0

	/// description
	var/tmp/weapon_desc = "A weapon of some kind."

	//* set re-typing without completely disabling updates
	//  todo: this is terrible and the new entity mapper system should do something less terrible
	/// non-tmp override stat
	var/weapon_forced_stat
	/// non-tmp add hit
	var/weapon_forced_add_hit = 0
	/// non-tmp add damage
	var/weapon_forced_add_dam = 0
	/// non-tmp add crit
	var/weapon_forced_add_crit = 0

	//* legacy storage
	/// gild id
	var/weapon_static_gilding


/obj/item/Weapon/Read(savefile/F)
	. = ..()
	if(!modified)
		// rebuild our stats from the code if we're not a modified weapon
		rebuild()

/obj/item/Weapon/proc/rebuild()
	// don't rebuild non weapons
	if(!weapon_system)
		return
	// called to rebuild stats on boot for non-modified (custom) weapons
	//! these are legacy vars
	addhit = weapon_innate_hit + weapon_forced_add_hit
	adddam = weapon_innate_damage + weapon_forced_add_dam
	critrange = 20 - weapon_innate_crit - weapon_forced_add_crit
	equiptype = weapon_handedness > 1? "2h" : "1h"
	damsource = isnull(weapon_forced_stat)? weapon_stat : weapon_forced_stat
	range = "[weapon_range] tiles"
	desc = weapon_desc

	if(weapon_static_gilding)
		gilded = TRUE
		desc += "| [capitalize(weapon_static_gilding)]"

	range1 = weapon_base_low
	range2 = weapon_base_high

	// flat boost multiplied to weapon_scale_constant
	var/tier_scaling_constant = 0
	// multiplies scale_low to get the weapon's random damage range
	var/tier_scaling_low = 1
	// multiplies scale_high to get the weapon's random damage range
	var/tier_scaling_high = 1
	switch(weapon_tier)
		if(WEAPON_TIER_BRONZE)
			tier_scaling_constant = 1
			tier_scaling_low = 1
			tier_scaling_high = 6
			//! legacy : set weptier
			weptier = "Bronze"
			//! end
		if(WEAPON_TIER_IRON)
			tier_scaling_constant = 2
			tier_scaling_low = 1
			tier_scaling_high = 8
			//! legacy : set weptier
			weptier = "Iron"
			//! end
		if(WEAPON_TIER_STEEL)
			tier_scaling_constant = 3
			tier_scaling_low = 1
			tier_scaling_high = 10
			//! legacy : set weptier
			weptier = "Steel"
			//! end
		if(WEAPON_TIER_MYTHRIL)
			tier_scaling_constant = 4
			tier_scaling_low = 1
			tier_scaling_high = 12
			//! legacy : set weptier
			weptier = "Mythril"
			//! end
		if(WEAPON_TIER_ADAMANTINE)
			tier_scaling_constant = 5
			tier_scaling_low = 1
			tier_scaling_high = 16
			//! legacy : set weptier
			weptier = "Adamantine"
			//! end
		if(WEAPON_TIER_ORICHALCUM)
			tier_scaling_constant = 6
			tier_scaling_low = 2
			tier_scaling_high = 40
			//! legacy : set weptier
			weptier = "Orichalcum"
			//! end

	adddam += weapon_scale_constant * tier_scaling_constant
	range1 += weapon_scale_low * tier_scaling_low
	range2 += weapon_scale_high * tier_scaling_high

