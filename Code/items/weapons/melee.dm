/obj/item/Weapon/Melee
	typing="physical"
	weapon_range = 1

GENERATE_PATHS_FOR_WEAPON_METAL_TIERS(/obj/item/Weapon/Melee/Longsword, "WeaponLongsword")
/obj/item/Weapon/Melee/Longsword
	weight=5
	weapontype="Longsword"
	icon='Icons/Items/Longsword.dmi'
	weapon_handedness = 1
	weapon_scale_constant = 1
	weapon_scale_low = 1
	weapon_scale_high = 2
	weapon_stat = CHARACTER_STAT_STR
	weapon_desc = "Longswords are considered a rather versatile weapon due to it's balanced design. And can be used Offensively or Defensively.  A longsword user is capable of switching between offensive, defensive or neutral modes. In Offensive, they sacrifice AC for PAB and MAB, in Defensive they sacrifice PAB and MAB for AC.  Neutral cancels out either mode. Offense and Defense mode trades are capped at Metal Tier."
	weapon_innate_hit = 1

GENERATE_PATHS_FOR_WEAPON_METAL_TIERS(/obj/item/Weapon/Melee/Scimitar, "WeaponScimitar")
/obj/item/Weapon/Melee/Scimitar
	weight=5
	weapontype="Scimitar"
	icon='Icons/Items/Scimitar.png'
	weapon_handedness = 1
	weapon_scale_low = 1
	weapon_scale_high = 2
	weapon_stat = CHARACTER_STAT_STR
	weapon_desc = "A long, curved blade. Scimitars specialize in taking advantage of their unique shape to catch opponents off guard. Scimitar have a latent +2 to hit bonus, and if utilized alongside Sneak Attack, deal 15 unreducable true damage in addition to the attack's damage."
	weapon_innate_hit = 2

GENERATE_PATHS_FOR_WEAPON_METAL_TIERS(/obj/item/Weapon/Melee/Hammer, "WeaponHammer")
/obj/item/Weapon/Melee/Hammer
	weight=10
	weapontype="Hammer"
	icon='Icons/Items/Hammer.dmi'
	weapon_handedness = 1
	weapon_scale_low = 1
	weapon_scale_high = 2
	weapon_stat = CHARACTER_STAT_STR
	weapon_desc = "A Hammer, which is not very accurate but does high damage. If a Hammer hits an opponent, the wielder may choose to apply a 2 tile Knockback in a direction of their choosing. If the target hits a wall or surface in doing so, they take 2d10 additional damage."

GENERATE_PATHS_FOR_WEAPON_METAL_TIERS(/obj/item/Weapon/Melee/Axe, "WeaponAxe")
/obj/item/Weapon/Melee/Axe
	weight=15
	weapontype="Axe"
	icon='Icons/Items/Axe.dmi'
	weapon_handedness = 1
	weapon_scale_low = 1
	weapon_scale_high = 2
	weapon_stat = CHARACTER_STAT_STR
	weapon_innate_crit = 1
	weapon_desc = "An Axe, which has a higher chance to critically hit than most other weapons. Once per turn on a standard attack the wielder may choose to spend 20 SP in order to deal an additional Metal Tier * 5 damage as true damage to their target."

GENERATE_PATHS_FOR_WEAPON_METAL_TIERS(/obj/item/Weapon/Melee/Dagger, "WeaponDagger")
/obj/item/Weapon/Melee/Dagger
	weight=2
	weapontype="Dagger"
	icon='Icons/Items/Dagger.dmi'
	weapon_handedness = 1
	weapon_scale_low = 1
	weapon_scale_high = 1
	weapon_stat = CHARACTER_STAT_DEX
	weapon_desc = "A dagger, which has a knack for critically hitting; rolling crits at 17 or higher, and has a latent +1 to hit bonus. On a critical hit, a Dagger ignores ALL damage reduction, and inflicts Weakness, but for 1 turn rather than its standard duration."
	weapon_innate_crit = 3
	weapon_innate_hit = 1

GENERATE_PATHS_FOR_WEAPON_METAL_TIERS(/obj/item/Weapon/Melee/Gauntlet, "WeaponGauntlet")
/obj/item/Weapon/Melee/Gauntlet
	weight=2
	weapontype="Gauntlet"
	icon='Icons/Items/Gauntlet.png'
	weapon_handedness = 2
	weapon_scale_low = 0.5
	weapon_scale_high = 1
	weapon_stat = CHARACTER_STAT_STR
	weapon_desc = "If a Gauntlet attack is made as a standard action, the user may use their bonus action to attack a second time for 20 SP. If at least two gauntlet attacks hit in the same round, the Gauntlet inflicts an additional 5 true damage per metal tier, and knocks the target back a distance of 1 x Strength Bonus if the wielder wishes to knock them back."
	weapon_innate_hit = 1

GENERATE_PATHS_FOR_WEAPON_METAL_TIERS(/obj/item/Weapon/Melee/Claw, "WeaponClaw")
/obj/item/Weapon/Melee/Claw
	weight=2
	weapontype="Claw"
	icon='Icons/Items/Gauntlet.png'
	weapon_handedness = 2
	weapon_scale_low = 0.5
	weapon_scale_high = 1
	weapon_stat = CHARACTER_STAT_DEX
	weapon_desc = "If a Claw attack is made as a standard action, the user may use their bonus action to attack a second time for 20 SP. If at least two claw attacks hit in the same round, the Claw inflicts bleed. Claws have a critical range of 19-20."
	weapon_innate_crit = 1

GENERATE_PATHS_FOR_WEAPON_METAL_TIERS(/obj/item/Weapon/Melee/Whip, "WeaponWhip")
/obj/item/Weapon/Melee/Whip
	weight=1
	weapontype="Whip"
	icon='Icons/Items/Whip.dmi'
	weapon_handedness = 1
	weapon_scale_low = 1
	weapon_scale_high = 2
	weapon_stat = CHARACTER_STAT_DEX
	weapon_desc = "A Whip, which is extremely accurate but does little damage. Whips have a latent +2 to hit, and if an opponent's DEX score is lower than the wielder's, Whip attacks gain +3 to hit."
	weapon_innate_hit = 2

GENERATE_PATHS_FOR_WEAPON_METAL_TIERS(/obj/item/Weapon/Melee/Greatsword, "WeaponGreathsword")
/obj/item/Weapon/Melee/Greatsword
	weight=15
	weapontype="Greatsword"
	icon='Icons/Items/Greatsword.dmi'
	weapon_handedness = 2
	weapon_scale_low = 1
	weapon_scale_high = 2
	weapon_stat = CHARACTER_STAT_STR
	weapon_desc = "A Greatsword, which must be wielded in two hands. While a Greatsword is wielded, the wielder gains +2 STR. In addition, their basic attacks target the center tile, and two tiles beside the tile in front of them."
	weapon_innate_hit = 1

GENERATE_PATHS_FOR_WEAPON_METAL_TIERS(/obj/item/Weapon/Melee/Katana, "WeaponKatana")
/obj/item/Weapon/Melee/Katana
	weight=8
	weapontype="Katana"
	icon='Icons/Items/Katana.dmi'
	weapon_handedness = 2
	weapon_scale_low = 1
	weapon_scale_high = 2
	weapon_stat = CHARACTER_STAT_STR
	weapon_desc = "A Katana, which ignores 3 static points of damage reduction, and 2 extra points per Metal Tier (2 at Bronze, 4 at Iron, 6 at Steel, 8 at Mythril, 10 at Adamantine, 12 at Orichalcum.)"

GENERATE_PATHS_FOR_WEAPON_METAL_TIERS(/obj/item/Weapon/Melee/Scythe, "WeaponScythe")
/obj/item/Weapon/Melee/Scythe
	weight=15
	weapontype="Scythe"
	icon='Icons/Items/Scythe.dmi'
	weapon_handedness = 2
	weapon_scale_low = 1
	weapon_scale_high = 2
	weapon_stat = CHARACTER_STAT_DEX
	weapon_desc = "A Scythe, which is extremely proficient in hacking and cleaving. Scythes inflict Bleed whenever they hit a target. If a target creature is afflicted with Bleed, a Scythe deals 2d8 additional damage on hit, up to once per round."
	weapon_innate_crit = 1

GENERATE_PATHS_FOR_WEAPON_METAL_TIERS(/obj/item/Weapon/Melee/Spear, "WeaponSpear")
/obj/item/Weapon/Melee/Spear
	weight=10
	weapontype="Spear"
	icon='Icons/Items/Spear.dmi'
	weapon_handedness = 2
	weapon_scale_low = 1
	weapon_scale_high = 2
	weapon_stat = CHARACTER_STAT_STR
	weapon_desc = "A spear, which has a Melee range of 2 tiles. Spears when wielded, allow the user to spend 30 SP on hit, to ignore up to 25 points of damage reduction as a free action, once per round."
