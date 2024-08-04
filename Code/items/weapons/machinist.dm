/obj/item/Weapon/Machinist
	abstract_type = /obj/item/Weapon/Machinist

	weapontype="Machinist"
	typing="physical"
	equiptype="1h"

	weapon_scale_high = 0
	weapon_scale_low = 0
	weapon_scale_constant = 0

//* weapons

/obj/item/Weapon/Machinist/BioBlaster
	entity_id = "WeaponBioBlaster"
	icon='Icons/Items/Pistol.png'
	name="Bio Blaster"
	weapon_desc = "A Bio Blaster, which is similar to a Magitek Pistol, except that it releases raw Bio energy in the form of radiation. Inflicts 'Poison' on hit."
	weapon_base_low = 25
	weapon_base_high = 25
	weapon_innate_hit = 2
	weapon_innate_damage = 5
	weapon_stat = CHARACTER_STAT_DEX
	range="6 Tiles"
	weapon_handedness = 1

/obj/item/Weapon/Machinist/Drillsword
	entity_id = "WeaponDrillSword"
	icon='Icons/Items/Drillsword.png'
	name="Drill Sword"
	weapon_desc = "A Sword that has a Drill with sharpened frundles, instead of a blade. This can be used to deal Slashing or Piercing damage, and ignores 10 points of Damage Reduction. Can be used for Samurai, Paladin, Dark Knight, Rogue, and Red Mage abilities."
	weapon_base_low = 10
	weapon_base_high = 18
	weapon_innate_hit = 2
	weapon_innate_damage = 5
	weapon_stat = CHARACTER_STAT_DEX
	range="Melee"
	weapon_handedness = 1

/obj/item/Weapon/Machinist/Drillspear
	entity_id = "WeaponDrillSpear"
	icon='Icons/Items/Drillspear.png'
	name="Drill Spear"
	weapon_desc = "A Spear that has a Drill at the tip, meant for piercing sturdy defenses. This weapon deals Piercing damage, and ignores 15 points of Damage Reduction. Can be used for Dark Knight, Rogue, and Dragoon abilities."
	range="2 TIle Melee Range"
	weapon_base_low = 10
	weapon_base_high = 18
	weapon_innate_hit = 1
	weapon_innate_damage = 5
	weapon_stat = CHARACTER_STAT_STR
	weapon_handedness = 2

/obj/item/Weapon/Machinist/Chainsaw
	entity_id = "WeaponChainsaw"
	icon='Icons/Items/Chainsaw.png'
	name="Chainsaw"
	weapon_desc = "A Chainsaw. Generally used by Machinists, a Chainsaw inflicts 'Bleed' on hit."
	weapon_base_low = 25
	weapon_base_high = 35
	weapon_innate_hit = 1
	weapon_innate_damage = 2
	weapon_stat = CHARACTER_STAT_STR
	weapon_handedness = 1

/obj/item/Weapon/Machinist/BallisticPistol
	entity_id = "WeaponBallisticPistol"
	icon='Icons/Items/Pistol.png'
	name="Ballistic Pistol"
	weapon_desc = "A Ballistic Pistol. Unlike Magitek guns, this type of gun can be utilized with special Machinist munitions. When a Machinist munition is used alongside this weapon, its attacks gain that munition's specified effects."
	weapon_base_low = 25
	weapon_base_high = 35
	weapon_stat = CHARACTER_STAT_DEX
	weapon_range = 6
	weapon_handedness = 1

/obj/item/Weapon/Machinist/Flamethrower
	entity_id = "WeaponFlamethrower"
	icon='Icons/Items/Flamethrower.png'
	name="Flame Thrower"
	weapon_desc = "A Flame Thrower. Used by Machinists, this tool's basic attacks have a wide range, and prompt a DC 12 Fortitude saving throw on hit, inflicting Burn on a failure. This weapon's attack is a cone (5 tiles)."
	weapon_base_low = 30
	weapon_base_high = 40
	weapon_innate_hit = 5
	weapon_innate_damage = 5
	weapon_stat = CHARACTER_STAT_DEX
	weapon_range = 5
	weapon_handedness = 2

/obj/item/Weapon/Machinist/Taser
	entity_id = "WeaponTaser"
	icon='Icons/Items/Pistol.png'
	name="Taser"
	weapon_base_low = 20
	weapon_base_high = 35
	weapon_innate_hit = 2
	weapon_innate_damage = 2
	weapon_stat = CHARACTER_STAT_DEX
	weapon_range = 5
	weapon_desc = "A simple Taser Gun, which on hit prompts a DC 8 Fortitude saving throw. On a failure, target creature is inflicted with 'Paralyzed'."
	weapon_handedness = 1

/obj/item/Weapon/Machinist/RocketLauncher
	entity_id = "WeaponRocketLauncher"
	icon='Icons/Items/Rocketlauncher.png'
	name="Rocket Launcher"
	weapon_desc = "A Rocket Launcher, that fires explosive missiles at a target location, with the attack taking the form of an 3x3 AoE. Has a 3 turn cooldown after use."
	weapon_base_low = 60
	weapon_base_high = 65
	weapon_stat = CHARACTER_STAT_INT
	weapon_range = 6
	weapon_handedness = 2

/obj/item/Weapon/Machinist/BeamCannon
	entity_id = "WeaponBeamCannon"
	icon='Icons/Items/Beamcannon.png'
	name="Beam Cannon"
	weapon_desc = "A Beam Cannon, similar to a rocket launcher that fires a globule of energy which explodes at a target location, taking the form of an 5x5 AoE. Has a 5 turn cooldown after use."
	weapon_base_low = 60
	weapon_base_high = 80
	weapon_innate_hit = 3
	weapon_stat = CHARACTER_STAT_INT
	weapon_range = 6
	weapon_handedness = 2

/obj/item/Weapon/Machinist/WreckingBall
	entity_id = "WeaponWreckingBall"
	icon='Icons/Items/Wreckingball.png'
	name="Wrecking Ball"
	weapon_desc = "A massive Wrecking Ball, used by Machinists generally as a Melee or Ranged weapon. This weapon inflicts Heavy on hit. Requires 16 STR to use."
	weapon_base_low = 40
	weapon_base_high = 50
	weapon_innate_hit = -1
	weapon_innate_damage = 5
	weapon_range = 4
	weapon_stat = CHARACTER_STAT_STR
	weapon_handedness = 2

/obj/item/Weapon/Machinist/EnergySword
	entity_id = "WeaponEnergySword"
	icon='Icons/Items/Energysword.png'
	name="Energy Sword"
	weapon_desc = "A metal hilt, which has been fitted with a Mana crystal. When activated, a blade of pure energy is created. This weapon can deal either Force or Slashing damage, and can count as a Longsword, OR a Katana, for bonuses."
	weapon_base_low = 30
	weapon_base_high = 40
	weapon_innate_hit = 2
	weapon_innate_damage = 5
	weapon_stat = CHARACTER_STAT_STR
	weapon_handedness = 1

/obj/item/Weapon/Machinist/LaserOffenseOrb
	entity_id = "WeaponLaserAttackOrb"
	icon='Icons/Items/Laserorb.png'
	range="8 Tiles"
	name="Laser Offense Orb"
	weapon_desc = "A small orb, which when equipped floats around its user. This orb is able to fire off Laser shots during its wielder's turn, as a bonus action rather than a standard action."
	weapon_base_low = 20
	weapon_base_high = 30
	weapon_innate_hit = 5
	weapon_stat = CHARACTER_STAT_INT
	weapon_handedness = 1

/obj/item/Weapon/Machinist/LaserDefenseOrb
	entity_id = "WeaponLaserDefendOrb"
	icon='Icons/Items/Laserorb.png'
	name="Laser Defense Orb"
	weapon_range = 8
	weapon_desc = "A small orb, designed for defense rather than offense. It floats around its user, and can only attack by using its wielder's Reaction. As a reaction to an incoming attack or saving throw, this orb may fire a laser attack."
	weapon_base_low = 15
	weapon_base_high = 20
	weapon_innate_hit = 5
	weapon_stat = CHARACTER_STAT_INT
	weapon_handedness = 1

/obj/item/Weapon/Machinist/Wrench
	entity_id = "WeaponWrench"
	icon='Wrench.dmi'
	weapon_handedness = 1
	weapon_stat = CHARACTER_STAT_INT
	weapon_base_high = 20
	weapon_base_low = 15
	weapon_desc = "A Wrench, used by Machinists generally as a Melee weapon. This weapon has the added benefit of being able to heal a Robot or Mech for 3d10 HP by using a standard action."


//* shitcode - ammo

/obj/item/Weapon/Machinist/Ammo
	abstract_type = /obj/item/Weapon/Machinist/Ammo
	weapon_system = FALSE

/obj/item/Weapon/Machinist/Ammo/verb/UseAmmo()
	players ={"<font color=#EC2323>[usr.name] has used a special Ammunition: <a href="byond://?src=\ref[usr]&action2=lookwep&value=\ref[src]"><font color=#FFFFFF>[src]</a>!!"}
	src.amount-=1
	if(src.amount==0)
		del src

/obj/item/Weapon/Machinist/Ammo
	icon='Icons/Items/Ammo.png'
	Basic
		abstract_type = /obj/item/Weapon/Machinist/Ammo
		FireBullet
			entity_id = "AmmoBulletFire"
			name="Fire Bullet"
			desc="Fire Bullets deals Fire damage, and prompt a DC 10 Forttiude saving throw on hit, inflicting burn on failure."
		ThunderBullet
			entity_id = "AmmoBulletThunder"
			name="Thunder Bullet"
			desc="Thunder Bullets deal Thunder damage, and prompt a DC 10 Fortitude saving throw on hit, inflicting Paralzyed on failure."
		WaterBullet
			entity_id = "AmmoBulletWater"
			name="Water Bullet"
			desc="Water Bullets deal Water damage, and inflict 'Wet' on hit."
		EarthBullet
			entity_id = "AmmoBulletEarth"
			name="Earth Bullet"
			desc="Earth Bullets deal Earth damage, and inflict 'Weakness' on hit."
		LowAPRound
			entity_id = "AmmoBulletAPLow"
			name="Low Quality AP Bullet"
			desc="Low AP Rounds have 10 points of damage reduction piercing, and deal 5 flat additional damage."
	Advanced
		abstract_type = /obj/item/Weapon/Machinist/Ammo
		AeroBullet
			entity_id = "AmmoBulletAero"
			name="Aero Bullet"
			desc="Aero Bullets deal Wind damage, and inflict 'Bleed' on hit."
		IceBullet
			entity_id = "AmmoBulletIce"
			name="Ice Bullet"
			desc="Ice Bullets deal Ice damage, and inflict 'Frostbite' on hit."
		BioBullet
			entity_id = "AmmoBulletBio"
			name="Bio Bullet"
			desc="Bio Bullets deal Bio damage, and inflict 'Poison, and Blind' on hit."
		DarkBullet
			entity_id = "AmmoBulletDark"
			name="Dark Bullet"
			desc="Dark Bullets deal Dark damage, and inflict 'Blind, Weakness, and Heavy' on hit."
		HolyBullet
			entity_id = "AmmoBulletHoly"
			name="Holy Bullet"
			desc="Holy Bullets deal Holy damage, and inflict 'Silence, and Slow' on hit."
		HighAPRound
			entity_id = "AmmoBulletAPHigh"
			name="High Quality AP Bullet"
			desc="High AP Rounds have 20 points of damage reduction piercing, and deal 15 flat additional damage."
	Nethicite
		entity_id = "AmmoBulletNethicite"
		name="Nethicite Ammo"
		desc="A very advanced form of Ammunition. When a Nethicite bullet hits a target creature, they must make a Will saving throw, DC 20. On a failure, they lose the ability to use Abilities for 2 rounds."
