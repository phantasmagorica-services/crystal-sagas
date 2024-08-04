/obj/item/Weapon/Special

GENERATE_PATHS_FOR_WEAPON_METAL_TIERS(/obj/item/Weapon/Special/FocusSword, "WeaponFocusSword")
/obj/item/Weapon/Special/FocusSword
	weight=3
	weapontype="Focus Sword"
	icon='Icons/Items/Focussword.dmi'
	weapon_handedness = 1
	weapon_scale_low = 1
	weapon_scale_high = 1
	weapon_stat = CHARACTER_STAT_DEX
	weapon_desc = "A Focus Sword, which when equipped allows the usage of a Focus Crystal alongside it. If wielded this way, the Focus Crystal may attack as a bonus action."

GENERATE_PATHS_FOR_WEAPON_METAL_TIERS(/obj/item/Weapon/Special/SwordSpear, "WeaponSwordSpear")
/obj/item/Weapon/Special/SwordSpear
	weight=14
	weapontype="Sword Spear"
	icon='Icons/Items/Sword Spear.png'
	weapon_handedness = 2
	weapon_scale_low = 1
	weapon_scale_high = 2
	weapon_scale_constant = 2
	weapon_stat = CHARACTER_STAT_STR
	weapon_desc = "A sword with a relatively medium sized spear shaft affixed as the handle. It can be used as either a spear or a sword. Both Sword and Spear form require both hands to wield. Scales with Longsword | 2 tile Melee range | +2 extra damage per metal tier. 5 static DR penetration."

GENERATE_PATHS_FOR_WEAPON_METAL_TIERS(/obj/item/Weapon/Special/ThiefSword, "WeaponThiefSword")
/obj/item/Weapon/Special/ThiefSword
	weight=10
	weapontype="Thief Sword"
	icon='Icons/Items/Thiefsword.dmi'
	weapon_handedness = 1
	weapon_scale_low = 1
	weapon_scale_high = 1
	weapon_scale_constant = 2.5
	weapon_stat = CHARACTER_STAT_DEX
	weapon_desc = "Two large long-swords with rather long handles which connect at the base of the pommel to create a bo-staff like weapon, effectively allowing for dual wielding or a single long and large area-covering melee weapon. Using the weapon like this does not require dual wielding, and also allows you to perform an additional attack as a bonus action. Combined Form: Standard attacks are made as 3x3 AoEs. Dual Form: Perform an additional attack as a bonus action."

GENERATE_PATHS_FOR_WEAPON_METAL_TIERS(/obj/item/Weapon/Special/BoltRapier, "WeaponBoltRapier")
/obj/item/Weapon/Special/BoltRapier
	weapon_handedness = 1
	weight=3
	weapontype="Bolt Rapier"
	icon='Icons/Items/Boltrapier.dmi'
	weapon_scale_low = 1
	weapon_scale_high = 2
	weapon_scale_constant = 2
	weapon_stat = CHARACTER_STAT_DEX
	weapon_innate_crit = 1
	weapon_desc = "Basically a Rapier whose blade functions as a drill with an electrical current. Scales with Longsword, deals Thunder damage, and procs the Wet reaction for its attack rolls when applicable."

GENERATE_PATHS_FOR_WEAPON_METAL_TIERS(/obj/item/Weapon/Special/WhipBlade, "WeaponWhipBlade")
/obj/item/Weapon/Special/WhipBlade
	weight=8
	weapontype="Whip Blade"
	icon='Icons/Items/Whipblade.dmi'
	weapon_handedness = 1
	weapon_scale_low = 1
	weapon_scale_high = 2
	weapon_innate_hit = 2
	weapon_stat = CHARACTER_STAT_DEX
	weapon_desc = "A whip with segmented blades on it. The segments of the blade can detach and reattach, and be manipulated magically as separate razor-blades, for ranged attacks."
	weapon_range = 3

GENERATE_PATHS_FOR_WEAPON_METAL_TIERS(/obj/item/Weapon/Special/BlitzBall, "WeaponBlitzball")
/obj/item/Weapon/Special/BlitzBall
	weight=5
	weapontype="Blitz Ball"
	icon='Icons/Items/Blitzball.dmi'
	weapon_handedness = 2
	weapon_scale_low = 2
	weapon_scale_high = 1
	weapon_scale_constant = 2
	weapon_stat = CHARACTER_STAT_STR
	weapon_desc = "A ball that is made super-durable, for the purposes of the game \"Blitz-Ball\"-but modified for combat as well. It can have modifications added to it in order for it to be more dangerous, such as razor-blades or other things. When it hits an opponent, it returns to the user automatically. In addition, when using a blitzball,the wielder may spend 20 SP in order to cause it to bounce off of up to 2 target creatures within 6 tiles of the initial target at a time, applying the same to-hit and half of the damage to them as initially rolled."
	weapon_range = 6

GENERATE_PATHS_FOR_WEAPON_METAL_TIERS(/obj/item/Weapon/Special/Gunblade, "WeaponGunblade")
/obj/item/Weapon/Special/Gunblade
	weight=10
	weapontype="Gun Blade"
	icon='Icons/Items/Gunblade.dmi'
	weapon_handedness = 1
	weapon_scale_low = 1
	weapon_scale_high = 2
	weapon_stat = CHARACTER_STAT_STR
	weapon_desc = "Doesn't shoot bullets. The barrel actually has a propulsion system that the trigger activates, to enhance the velocity and force of a swing if timed correctly. Scales with Longsword, but can spend 5 Mana to gain either +1 to hit, or +15 additional damage for a single strike per turn by pulsing Mana through the barrel."

GENERATE_PATHS_FOR_WEAPON_METAL_TIERS(/obj/item/Weapon/Special/Bowsword, "WeaponBowsword")
/obj/item/Weapon/Special/Bowsword
	weight=10
	weapontype="Bowsword"
	icon='Icons/Items/Bow Sword.png'
	weapon_handedness = 2
	weapon_scale_low = 2
	weapon_scale_high = 1
	weapon_scale_constant = 2
	weapon_stat = CHARACTER_STAT_DEX
	weapon_desc = "A bow composed of metal, with two blades on either side - and a thin center grip which can notch arrows, along with a metal wire string. It can be used for either Melee Attack Rolls, or Ranged Attack Rolls - and is compatible with both Ranged Abilities and Melee Abilities."

GENERATE_PATHS_FOR_WEAPON_METAL_TIERS(/obj/item/Weapon/Special/Bagangsaw, "WeaponBagangsaw")
/obj/item/Weapon/Special/Bagangsaw
	weight=20
	weapontype="Bagangsaw"
	icon='Icons/Items/Bagsaw.dmi'
	weapon_handedness = 2
	weapon_scale_low = 1
	weapon_scale_high = 2
	weapon_scale_constant = 3
	weapon_stat = CHARACTER_STAT_STR
	weapon_desc = "A staff with a rotating saw-blade at the end. Slashing damage. 2 tile Melee range. On a successful standard attack, the wielder of a Bagangsaw can spend 20 SP to 'jam it' into a target, subjecting them to the whirling saw-blade and causing them to take 5*Metal Tier true damage and Bleed for 1 Turn."

GENERATE_PATHS_FOR_WEAPON_METAL_TIERS(/obj/item/Weapon/Special/BusterSword, "WeaponBusterSword")
/obj/item/Weapon/Special/BusterSword
	weight=30
	weapontype="Buster Sword"
	icon='Icons/Items/Bustersword.dmi'
	weapon_handedness = 2
	weapon_scale_low = 2
	weapon_scale_high = 2
	weapon_scale_constant = 2
	weapon_stat = CHARACTER_STAT_STR
	weapon_desc = "A giant sword with so much length and thickness that every swing is devastating. Takes a very particular type of training as well as 16 strength to wield. +2 AC when wielded."

GENERATE_PATHS_FOR_WEAPON_METAL_TIERS(/obj/item/Weapon/Special/MorphingBlade, "WeaponMorphBlade")
/obj/item/Weapon/Special/MorphingBlade
	weight=40
	weapontype="Morphing Blade"
	icon='Icons/Items/Morphingblade.png'
	weapon_handedness = 2
	weapon_scale_low = 2
	weapon_scale_high = 2
	weapon_scale_constant = 2
	weapon_stat = CHARACTER_STAT_STR
	weapon_desc = "A Morphing Blade, transfigured into Greatsword mode. Gains +1 to hit. On the turn that a wielder of a Morphing Blade morphs their blade to a different type, the weapon gains +15 additional damage, and +4 to hit. Doing so is a bonus action."

GENERATE_PATHS_FOR_WEAPON_METAL_TIERS(/obj/item/Weapon/Special/GunArm, "WeaponGunArm")
/obj/item/Weapon/Special/GunArm
	weight=10
	weapontype="Gun Arm"
	icon='Icons/Items/Gunarm.dmi'
	weapon_handedness = 1
	weapon_scale_low = 1
	weapon_scale_high = 1
	weapon_scale_constant = 1
	weapon_innate_damage = 5
	weapon_stat = CHARACTER_STAT_DEX
	weapon_desc = "A semi-automatic gun that is attached in place of your hand or fastened to it -- can be multiple different types of attachments such as rocket fists, hydraulic fists, a drill, grenade launcher, cannon ball launcher, etc. Once per turn, when a Gun Arm attack hits a target creature, the wielder may spend 20 SP to release (Metal Tier+1) sets of 10 true damage to any enemy within the user’s range."

GENERATE_PATHS_FOR_WEAPON_METAL_TIERS(/obj/item/Weapon/Special/MagitekPistol, "WeaponMagitekPistol")
/obj/item/Weapon/Special/MagitekPistol
	icon='Icons/Items/Pistol.dmi'
	weapontype="Magitek Pistol"
	weight=4
	weapon_handedness = 1
	weapon_innate_hit = 1
	weapon_range = 6
	weapon_scale_low = 1
	weapon_scale_high = 1
	weapon_stat = CHARACTER_STAT_DEX
	weapon_desc = "A Magitek Pistol, deals Force damage. When a target is dealt damage by a Magitek Pistol, they must roll a fortitude saving throw (DC 10+Metal Tier), on failure they are inflicted with Burn, Poison, or Wet; of the user's choice."

GENERATE_PATHS_FOR_WEAPON_METAL_TIERS(/obj/item/Weapon/Special/MagitekRifle, "WeaponMagitekRifle")
/obj/item/Weapon/Special/MagitekRifle
	equiptype="2h"
	weapontype="Magitek Rifle"
	weight=8
	weapon_handedness = 2
	weapon_range = 6
	weapon_innate_hit = 6
	weapon_scale_low = 1
	weapon_scale_high = 2
	weapon_stat = CHARACTER_STAT_DEX
	weapon_desc = "A Magitek Rifle, deals Force damage. 2H. When a target is dealt damage by a Magitek Rifle, they are knocked back 1 tile, and must roll a Fortitude saving throw (DC 10+ Metal Tier) or be knocked prone."
