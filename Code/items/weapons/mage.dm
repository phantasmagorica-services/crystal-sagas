/obj/item/Weapon/Magical
	typing="magical"

GENERATE_PATHS_FOR_WEAPON_METAL_TIERS(/obj/item/Weapon/Magical/Staff, "WeaponStaff")
/obj/item/Weapon/Magical/Staff
	weight=8
	weapontype="Staff"
	icon='Icons/Items/Staff.dmi'
	weapon_handedness = 2
	weapon_range = 5
	weapon_stat = CHARACTER_STAT_CHA
	weapon_scale_low = 1
	weapon_scale_high = 2
	weapon_desc = "A magical staff, which can be used for costless Magical attack rolls, which deal force damage. A wielder of a staff may also spend 5 MP in order to increase a direct healing spell’s (Cure line as an example) healing by 5. This increase is capped at 5*Metal Tier."

GENERATE_PATHS_FOR_WEAPON_METAL_TIERS(/obj/item/Weapon/Magical/Rod, "WeaponRod")
/obj/item/Weapon/Magical/Rod
	weight=8
	weapontype="Rod"
	icon='Icons/Items/Staff.dmi'
	weapon_handedness = 2
	weapon_range = 5
	weapon_stat = CHARACTER_STAT_WIS
	weapon_scale_low = 1
	weapon_scale_high = 2
	weapon_desc = "Whenever a Rod basic attack or a spell cast while the Rod is wielded hits a target, the wielder may spend 5 MP in order to overcharge their spellcasting, and deal 5 additional damage per 5 MP (capping at 5*Metal Tier)."

GENERATE_PATHS_FOR_WEAPON_METAL_TIERS(/obj/item/Weapon/Magical/Tome, "WeaponTome")
/obj/item/Weapon/Magical/Tome
	weight=5
	weapontype="Tome"
	icon='Icons/Items/Tome.dmi'
	weapon_handedness = 1
	weapon_range = 5
	weapon_stat = CHARACTER_STAT_INT
	weapon_scale_low = 1
	weapon_scale_high = 1
	weapon_desc = "A Magical tome, which can be used for costless Magical attack rolls, which deals force damage. The wielder of a tome is capable of absorbing MP equal to the damage its basic attack deals to a target creature (max metal tier x 10 MP a turn)."

GENERATE_PATHS_FOR_WEAPON_METAL_TIERS(/obj/item/Weapon/Magical/FocusCrystal, "WeaponFocusCrystal")
/obj/item/Weapon/Magical/FocusCrystal
	weight=4
	weapontype="Focus Crystal"
	icon='Icons/Items/Focus Crystal.dmi'
	weapon_handedness = 1
	weapon_range = 5
	weapon_stat = CHARACTER_STAT_WIS
	weapon_scale_low = 1
	weapon_scale_high = 1
	weapon_desc = "A Focus Crystal, which can be wielded in one hand alongside a Focus Sword in order to cast magical blasts as a Bonus action. Deals Force damage. Grants +2 MAB and +3 MDB per metal tier."
