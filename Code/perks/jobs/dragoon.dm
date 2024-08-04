/obj/perk/Jobperks/Dragoon
	jobneed="Dragoon"
	icon='Icons/Perk/Dragoon.png'
	Dragoon
		id = "DragoonLegacyJob"
		name="Dragoon (Job)"
		cat="Unique"
		desc="Dragoons may apply ‘Draconic’ enchantment to weapons, which changes their weapon type to ‘Dragoon’ for the sake of equipment (barring non Dragoons from using it) and also changes its active scaling stat to Dexterity. They gain an additional +3 to hit with any polearm-type weapon (spear, sword spear, bagangsaw, scythe) while air-borne, this buff lasts for 1 round after landing. Dragoons have a base tile jump height of half their movement speed, and are immune to fall damage entirely.+40 HP, +30 MP, +70 SP."
	SpearMastery
		id = "DragoonSpearMastery"
		rank="T1"
		name="Spear Mastery"
		desc="As a warrior with an ancient connection to the dragon-slaying spear, the Dragoons may shift their spear to a two-handed grip. When used this way, they cannot equip other weapons to their other hand, but gain +2 PDB as a Global Modifier per Rank Bonus. Additionally, when SP is spent on Spear’s ability, the weapon inflicts Bleed on that attack."
	EnhancedJump
		id = "DragoonEnhancedJump"
		rank="T1"
		name="Enhanced Jump"
		desc="This individual has spent a long time perfecting their jump and strengthening their legs. When they jump, their speed is nigh unmatched. Gain +1 to your base Jump tiles."
	DragonSight
		id = "DragoonSight"
		rank="T2"
		name="Dragon Sight"
		desc="Upon pouncing a target with a Jump ability, the Dragoon's infused dragon blood forces their predator's instincts to activate. Their eyes become slit like a dragon on the hunt for it's next meal. For 3 rounds after using any 'Jump' ability, the user gains +1 PAB, MAB and AC. They also gain dark-vision and a max sight range of 15 tiles. This does not stack with itself but can have it's duration refreshed."
	BloodoftheWyvern
		id = "DragoonWyvernBlood"
		rank="T2"
		name="Blood of the Wyvern"
		desc="A dragoon’s dragon blood enhanced body grants them supernatural aerodynamics. They can cut through the air like an arrow. By calling on their dragon blood on take off, the Dragoon is able to greatly enhance their height. The Dragoon can add 5 to their Jump Height whenever they leave the ground. This has a 3 round cooldown, starting when the Dragoon next lands. They may also immediately land on the ground."
	Glide
		id = "DragoonGlide"
		rank="T3"
		name="Glide"
		desc="The dragoon is controlled enough to be able to glide through the air at a semi-sustained altitude. They can double-jump whilst gliding to go higher up, or dip when necessary. They have supreme control of the air. A Dragoon falls 2 tiles per turn, and may freely move at half their movement speed through the air in any direction besides upward."
	WyvernTrainer
		id = "DragoonWyvernTrainer"
		rank="T3"
		name="Wyvern Trainer"
		cat="Unique"
		desc="This individual has learned how to train wyverns forming a bond with one that becomes their permanent partner. They gain the ability to speak to dragons and form a psychic connection with their partner capable of communicating and feeling everything their partner feels. Their partner grows with the dragoon growing stronger over time."
	Wyvern
		id = "DragoonWyvernLegacy"
		name="Wyvern"
		cat="Unique"
		desc="A Wyvern is a very rare occuerence. It is a Dragon that has taken to more civilized creatures, and become friends with them. A Wyvern is able to fly, passively ; and is mountable. It is resistant to Fire, Doom, Break, and Poison."
	DeepDraconicConnection
		id = "DragoonDeepConnection"
		rank="T4"
		name="Deep Draconic Connection"
		pre="Wyvern Trainer"
		cat="Unique"
		desc="The Dragoon has gained a deep connection with their Wyvern. Upon attaining this perk, the Dragoon's Wyvern is automatically considered a Mature Wyvern, and increases in rank from B to A. Furthermore, its HP increases by 120, its MP increases by 120, and its SP increases by 120. It gains +4 to all physical ability scores, and +2 to Wisdom, as well as +3 PAB, +3 MAB, +5 PDB, +5 MDB,  +5 AC, and +5 global damage reduction."
	NidhoggsFury
		id = "DragoonNidhoggFury"
		rank="T4"
		name="Nidhogg's Fury"
		desc="The Dragoon has learned how to infuse their greatest strikes with draconic power. Calling upon the boundless fury of Nidhogg, a Dragoon’s strike as they return to the earth conjures the image of a blazing draconic eye at the point of impact - burning with energies that strengthen their allies. After a ‘Jump’ attack, regardless of hit or miss, the user may create an AoE with a radius of tiles equal to the height of that previous Jump, Hyper Jump or Sky Grinder. All allies within that AoE gain ‘Bravery’ and +2 critical range for 2 Turns. 2 Turn Cooldown."

/obj/perk/Abilities/Dragoon
	jobneed="Dragoon"
	icon='Icons/Perk/Dragoon.png'
	costtype="Stamina"
	damsource="dex"
	atype="weapon"
	range=" Melee"
	typing="physical"
	Jump
		id = "DragoonJump"
		element="Physical"
		rank="E"
		atype="weapon"
		mcost=10
		costtype="Stamina"
		desc="When used, the Dragoon instantly travels to ground elevation from their current elevation. For every tile travelled downward, the attack gains 5 additional damage (capping at 50, at 10 tiles.) Make a standard attack roll with your weapon, and add the additional damage after the fact. This puts the 'Jump' movement action on cooldown for 1 round after use. This costs 10 Stamina."
	Gungnir
		id = "DragoonGungnir"
		element="Physical"
		rank="E"
		attack_roll_damage_dice = TRUE
		attack_roll_dice_count = 1
		attack_roll_dice_sides = 8
		mcost=5
		range=" 6 tile range."
		desc="The user is able to throw their weapon, and have it teleport back to them from wherever position it was due to mana infusion. The Mana infused in the weapon is attuned to the user, and can be magnetized to a target the weapon hits, creating a temporary connection between them. If this attack hits, it deals half normal weapon damage, and causes the next attack from the Dragoon that hits the marked target to take 1d10 additional damage, and be inflicted with 'Weakness'. If the creature is healed before this occurs, this effect is dissipated. Esuna and other cleansing abilities will also cleanse this effect. Bonus Action. 6 Tile range."
	Lancet
		id = "DragoonLancet"
		rank="D"
		desc=" Sinking their spear into a foe, the Dragoon restores themselves with the foe’s spilt vitality. On a successful ‘Jump’ Attack and successfully dealing damage, the user may roll 2d6, draining that much HP and MP from their opponent. This is an automatic hit, but requires the initial Jump to have hit its target.  (-10 SP)"
	BarrelRoll
		id = "DragoonBarrelRoll"
		name="Barrel Roll"
		rank="C"
		desc="The Dragoon’s aerodynamic body allows them to spin and flip gracefully through the air. This technique may be used when the user is attacked while airborne, as a Reaction, imposing Disadvantage on that attack while treating the user’s AC as 2 higher against the triggering attack. (15 SP)"
	DrakeHop
		id = "DragoonDrakeHop"
		element="Physical"
		name="Drake Hop"
		rank="C"
		atype="weapon"
		mcost=15
		costtype="Stamina"
		desc="A lesser version of the Dragoon’s signature Jump ability. They are able to quickly flip directly above their target and swing their weapon, or use this swing when coming downward to strike their target. The swinging action transfers the kinetic energy that would otherwise deal serious damage to their target back at them, sending them upward. Inflict half the damage onto the target and sends the user into the air at half their base ‘Jump’ movement action height. If used while already Airborne, deals half of a standard Jump’s bonus damage, before knocking the dragoon back up at half the height they descended from. Counts as a Movement Action, Action of Opportunity cannot be activated against it. (-15 SP)"
	VorpalThrust
		id = "DragoonVorpalThrust"
		element="Physical"
		name="Vorpal Thrust"
		rank="C"
		attack_roll_damage_dice = TRUE
		attack_roll_dice_count = 1
		attack_roll_dice_sides = 12
		range=" 3 tile line."
		mcost=20
		desc="The user dashes forward as a Standard Action, weapon braced and pointed forwards as they rush through everything in front of them. This can be utilized either on the ground, or in mid-air. Attacks of Opportunity are not triggered by this technique, but it also counts as the user’s movement action. (Damage: Weapon Damage+1d12+DEX| 5 Tile line, which the user moves along. Melee attack roll. -20 Stamina.)"
	CelestialShooter
		id = "DragoonCelestialShooter"
		element="Physical"
		name="Celestial Shooter"
		rank="B"
		range=" Melee"
		mcost=40
		desc="The user imbues their weapon with magic, making a scooping strike that sends their target up in the air. If a target is hit with this attack, the Dragoon may immediately follow them to their current height in the air. Make a standard weapon attack. If it hits, this launches the target 5 tiles into the air, and the Dragoon may then immediately follow them to that elevation as an incidental action. Costs 40 SP."
	HyperJump
		id = "DragoonHyperJump"
		element="Physical"
		name="Hyper Jump"
		rank="B"
		mcost=30
		attack_roll_damage_dice = FALSE
		attack_roll_damage_exact = 0
		desc="Hyper Jump is a more taxing, but also more powerful version of Jump. When used, the Dragoon travels to ground elevation from their current airborne elevation, and makes a standard weapon attack. If it hits, it gains a flat damage bonus equal to 8 per tile traveled (max 80). This puts the ‘Jump’ movement action on cooldown for 1 round after use. Costs 30 SP."
	SkyGrinder
		id = "DragoonSkyGrinder"
		element="Physical"
		name="Sky Grinder"
		rank="B"
		attack_roll_damage_dice = FALSE
		attack_roll_damage_exact = 0
		range=" Melee"
		mcost=45
		desc="The Dragoon transforms the momentum from their mid-air movement into a rotational force, akin to a drill. This attack loses power for the rotational momentum, but gains penetrative force. Upon use, Sky Grinder deals 5 damage per tile traveled (max 50), and transfers you to ground elevation immediately. Make a standard weapon attack, and add the additional damage as a flat bonus. If this attack hits, it reduces the target’s DR by 3 per tile traveled (max 30) for 2 rounds. Sky Grinder counts as a ‘Jump’ attack for abilities that mention them. The Damage Reduction nerf does not stack. This puts the ‘Jump’ movement action on cooldown for 1 round after use. Costs 45 stamina."
	FallingMeteor
		id = "DragoonFallingMeteor"
		element="Comet"
		name="Falling Meteor"
		rank="A"
		attack_roll_damage_dice = TRUE
		attack_roll_dice_count = 3
		attack_roll_dice_sides = 10
		atype="weaponsave"
		savetype="Reflex"
		basecheck=16
		mcost=65
		desc="While moving through the air, the user of this ability carries the momentum of their fall or glide, to impact the ground and send out a powerful shockwave holding all the momentum of the fall. If using this ability, the user returns to the ground as a full action regardless of their current elevation, generating the shockwave with themselves as the epicenter. This attack affects a 5x5 area around the epicenter of the target tile. Travel to the ground elevation for that tile instantly from your current elevation. It deals 15 damage per tile traveled (max 150), flatly; or half as much on a successful Fortitude saving throw (base check of 14+DEX+Rank bonus). This counts as a Jump ability for abilities that mention them. This puts the ‘Jump’ movement action on cooldown for 1 round after use. Costs 65 Stamina."
	SkyRave
		id = "DragoonSkyRave"
		name="Sky Rave"
		rank="A"
		critrange=0
		atype="weapon"
		damsource="dex"
		desc="Unleash a torrent of attacks against an airborne enemy. Make three standard weapon attacks against the creature with advantage on each attack roll before sending them downwards a maximum of 5 tiles; forcing them to take the fall damage. If all three attacks hit, make a final attack is an automatic critical hit (Sky Rave attack roll) and the opponent takes double the fall damage upon hitting the ground. This can be used as a reaction to Celestial Shooter for an additional cost of 30 Stamina. This puts the 'Jump' movement action on cooldown for 1 round after use. (-90 Stamina.)"
	SkyHigh
		id = "DragoonSkyHigh"
		name="Sky High"
		rank="S"
		desc="The user spends an incredible amount of energy into their legs. They jump 15 tiles into the air. They may then choose to expend a bonus action in order to utilize any 'Jump' ability at half its cost from their current height, but granting it +8 to hit.  If no Jump ability is used as a bonus action, you may not sustain your elevation using Glide on the turn this is used, nor the turn after. This costs 100 SP to initiate, and is a Standard action."
