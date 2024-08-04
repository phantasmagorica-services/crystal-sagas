/obj/item/Weapon/Ranged
	typing="physical"

/obj/item/Weapon/Ranged/ThrowingWeapons

GENERATE_PATHS_FOR_WEAPON_METAL_TIERS(/obj/item/Weapon/Ranged/ThrowingWeapons/Shuriken, "WeaponShuriken")
/obj/item/Weapon/Ranged/ThrowingWeapons/Shuriken
	weight=5
	weapontype="Shuriken"
	icon='Icons/Items/Shuriken.dmi'
	weapon_handedness = 1
	weapon_innate_hit = 2
	weapon_innate_crit = 1
	weapon_scale_low = 0.5
	weapon_scale_high = 1
	weapon_range = 6
	weapon_stat = CHARACTER_STAT_DEX
	weapon_desc = "A set of Shuriken. These deal small amounts of damage, but for each attack action made with them, you may use a 'free action' - to spend 20 SP in order to perform an additional attack (up to once per turn). On a critical hit, a Shuriken inflicts Bleed. If a creature is bleeding, all Shuriken attacks gain +5 flat damage."


GENERATE_PATHS_FOR_WEAPON_METAL_TIERS(/obj/item/Weapon/Ranged/ThrowingWeapons/ThrowingKnives, "WeaponThrowingKnife")
/obj/item/Weapon/Ranged/ThrowingWeapons/ThrowingKnives
	weight=5
	weapontype="Throwing Knives"
	icon='Icons/Items/ThrowingKnives.dmi'
	weapon_handedness = 1
	weapon_innate_hit = 3
	weapon_innate_crit = 2
	weapon_scale_low = 0.5
	weapon_scale_high = 1
	weapon_range = 6
	weapon_stat = CHARACTER_STAT_DEX
	weapon_desc = "A set of Throwing Knives, which deal piercing damage, have a reduced critical hit rate, +3 latent to hit bonus, and are ranged ;  for each attack action made with them, you may use a 'free action' - to spend 20 SP in order to perform an additional attack (up to once per turn)."

GENERATE_PATHS_FOR_WEAPON_METAL_TIERS(/obj/item/Weapon/Ranged/ThrowingWeapons/AkademiaCards, "WeaponAkademiaCard")
/obj/item/Weapon/Ranged/ThrowingWeapons/AkademiaCards
	weight=4
	weapontype="Akademia Cards"
	icon='Icons/Items/Akacard.dmi'
	typing = "magical"
	weapon_handedness = 1
	weapon_scale_low = 1
	weapon_scale_high = 1
	weapon_scale_constant = 3
	weapon_range = 6
	weapon_desc = "Very sharp cards which can be thrown as projectiles and summoned back magically. Whenever an Akademia Card attack roll deals damage to a creature, that creature also takes an additional 5 HP, MP, and SP damage. Grants +2 MAB and +3 MDB per metal tier."

GENERATE_PATHS_FOR_WEAPON_METAL_TIERS(/obj/item/Weapon/Ranged/Bow, "WeaponBow")
/obj/item/Weapon/Ranged/Bow
	weight=5
	weapontype="Bow"
	icon='Icons/Items/Bow.dmi'
	weapon_handedness = 2
	weapon_scale_low = 2
	weapon_scale_high = 2
	weapon_stat = CHARACTER_STAT_DEX
	weapon_range = 6
	weapon_desc = "A bow, which is useful for ranged attacks! A bow’s piercing arrows ignore 2 x Metal Tier DR."
