/obj/perk/Abilities/GeneralMagicAbilities
	damsource="int"
	costtype="Mana"
	cat="Genability"
	icon='Icons/Perk/GeneralMagic.png'
	typing="magical"
	atype="standard"
	element="Force"
	Landmine
		element="Fire"
		level=2
		rank="D"
		name="Land Mine"
		mcost=6
		basecheck=8
		attack_roll_damage_dice = TRUE
		attack_roll_dice_count = 2
		attack_roll_damage_upper = 20
		adddam=0
		addhit=0
		range=" 3 tile range, placeable anywhere a creature is not already positioned."
		costtype="Mana"
		atype="save"
		damsource="int"
		typing="magical"
		ptype="spell"
		savetype="Reflex"
		desc="The user scatters landmines that float in the air, and explode on contact or when a creature passes through the same tile with their movement. (Creates a landmine on a single tile within three tiles from the user, landmines prompt a Reflex saving throw (10+INT+Rank bonus). On a failed save, creatures take 2d20+INT damage, or half as much on a successful save. Landmine can not be created on the same tile that a creature is already occupying.  -6 Mana)"

	Burst
		level=2
		rank="D"
		name="Burst"
		mcost=8
		basecheck=10
		attack_roll_damage_dice = TRUE
		attack_roll_dice_count = 2
		attack_roll_damage_upper = 4
		adddam=0
		addhit=0
		range=" 3 tile range, placeable anywhere a creature is not already positioned."
		costtype="Mana"
		atype="standard"
		damsource="int"
		typing="magical"
		ptype="spell"
		savetype="Reflex"
		desc="A low level, but essential magical technique for those studying the raw magic arts. The user draws from their reserves, and condenses potent raw mana, before firing it from their palm. For every 5 Mana spent in addition to the initial cost, this deals 3 additional damage (capping at +36) on hit. This can also be used as a reaction to the Burst spell in order to interrupt and equalize it if the opposing Burst's damage is within 10 points of damage, otherwise reducing the Beam's damage by the damage rolled by the reactor. 2d4+INT | Ranged attack roll, 5 tile line, -8 Mana)"

	Ruin
		level=2
		rank="D"
		name="Ruin"
		mcost=4
		basecheck=10
		attack_roll_damage_dice = TRUE
		attack_roll_dice_count = 2
		attack_roll_dice_sides = 2
		adddam=0
		addhit=0
		range="6 tile range."
		costtype="Mana"
		atype="standard"
		damsource="int"
		typing="magical"
		ptype="spell"
		savetype="Reflex"
		desc="A low level, but essential magical technique for those studying the raw magic arts. The user draws from their reserves, and condenses potent raw mana, before releasing it in a single globule from their palm. Three Ruin attack rolls are made, each dealing seperate damage: 2d2+ INT | Ranged attack roll, 6 tile range, -4 Mana.) (Deals a maximum of 60 damage.)"
	Tendril
		level=2
		rank="C"
		name="Tendril"
		mcost=12
		basecheck=10
		attack_roll_damage_dice = TRUE
		attack_roll_dice_count = 2
		attack_roll_dice_sides = 12
		adddam=0
		addhit=0
		range="2 Tile"
		costtype="Mana"
		atype="save"
		damsource="int"
		typing="magical"
		ptype="spell"
		savetype="Fortitude"
		desc=" A low level but useful technique for those studying the raw magic arts. The user manifests their raw mana as a 'tendril' which lashes out at a target within range, threatening to entangle them. This tendril, after binding a target - can be made to detonate at any time of the user's choice. The damage only applies on detonation. (Damage: 2d12+INT on detonation. | Prompts a Fortitude saving throw, binding the target on failure. The tendril is destroyed on a success. A bound target may spend their standard action each turn in order to roll STR against the bind DC in order to break free, and destroy the tendril. 5 tile range.) Costs 12 MP."
	Fog
		element="Bio"
		level=3
		rank="C"
		name="Fog"
		mcost=12
		basecheck=12
		attack_roll_damage_dice = TRUE
		attack_roll_dice_count = 3
		attack_roll_dice_sides = 6
		adddam=0
		addhit=0
		range=" 3 tile cone."
		costtype="Mana"
		atype="save"
		damsource="int"
		typing="magical"
		ptype="spell"
		savetype="Fortitude"
		desc="A low level, but essential magical technique for those studying the raw magic arts. The user draws from their reserves, and releases their Magic in a 'mist' like stream, which burns away at whatever it touches. (Damage: 3d6+INT | Prompts a Fortitude saving throw (12+INT+Rank Bonus) dealing full damage on a failure, or half as much on a success. 3 tile cone. -12 Mana.)"
	Fogga
		element="Bio"
		level=4
		rank="B"
		name="Fogga"
		mcost=30
		basecheck=14
		attack_roll_damage_dice = TRUE
		attack_roll_dice_count = 3
		attack_roll_dice_sides = 10
		adddam=0
		addhit=0
		range=" 5x5 AoE, 5 tile casting radius.."
		costtype="Mana"
		atype="save"
		damsource="int"
		typing="magical"
		ptype="spell"
		savetype="Fortitude"
		pre="Fog"
		desc="A more advanced version of Fog. After drawing form one's reserves, they release their Magic in a 'mist' like stream, which burns away whatever it touches. After having been cast, Fogga's 'mist' remains in place in a 5x5 AoE centered a location of the caster's choice within the initial casting radius, for 3 rounds. Any creature who starts their turn within the Mist must repeat the attack's saving throw, and take full damage on a failure, or half on a success. (Damage: 3d10+INT | Prompts a Fortitude saving throw (14+INT+Rank Bonus) dealing full damage on a failure, or half as much on a success. 3 tile cone. -30 Mana.)"
	Pyramid
		level=2
		rank="C"
		name="Pyramid"
		mcost=10
		basecheck=13
		attack_roll_damage_dice = FALSE
		attack_roll_damage_exact = 0
		adddam=0
		addhit=0
		range=" Single Tile barrier.."
		costtype="Mana"
		atype="save"
		damsource="int"
		typing="magical"
		ptype="spell"
		savetype="Reflex"
		cat="Unique"
		desc="The user fires a ball of light that when making contact with a target will expand into a pyramid shaped prison. The pyramid is unbreakable from the inside, but a strong attack from the outside can shatter it freeing whoever is inside. (Creates a 20 HP barrier around the target that is only breakable from the outside, Pyramid's AC = 13+INT+Rank Bonus | -10 Mana)"
	Trine
		element="Thunder"
		level=2
		rank="B"
		name="Trine"
		mcost=20
		basecheck=14
		attack_roll_damage_dice = TRUE
		attack_roll_dice_count = 2
		attack_roll_dice_sides = 20
		adddam=0
		addhit=0
		range=" 3x3 AoE. Can be Cast within Pyramid Spell. Destroys Pyramid."
		costtype="Mana"
		atype="save"
		damsource="int"
		typing="magical"
		ptype="spell"
		savetype="Fortitude"
		cat="Unique"
		pre="Pyramid"
		desc="A pyramid is made, and cast as the spell before, but instead of stopping its size to contain the enemy it will expand greatly covering a large area, and possibly trapping others. With the pyramid expanded so greatly the magic creating the walls has thinned to the point where it can be broken from the inside. The walls of the pyramid then begin to crackle with electricity as arcs of lightning fire latching onto anything it can inside the pyramid. (Expands to 3x3 AoE upon hitting a target, prompts a Fortitude saving throw (14+INT+Rank Bonus) - deals 2d20+INT damage on a failed saving throw, or half as much on a success. -20 Mana) (Requires Pyramid)"
	MythrilBubbles
		element="Water"
		name="Mythril Bubbles"
		level=3
		rank="C"
		damsource="int"
		atype="standard"
		typing="magical"
		ptype="spell"
		costtype="Mana"
		mcost=18
		attack_roll_damage_dice = TRUE
		attack_roll_dice_count = 2
		attack_roll_dice_sides = 10
		range="3 tile cone"
		desc="The user expels several blue bubbles through their mouth. The bubbles will float airborne, and if touched by something they will explode dealing damage to whatever made contact with them. (Damage: 2d10+INT |  ranged attack roll, 3 tile cone, inflicts Wet on hit, (1d20+INT to hit), Water Element, - 18 Mana)"
	Jolt
		element="Thunder"
		level=3
		rank="C"
		damsource="int"
		atype="standard"
		costtype="Mana"
		range="6 tiles."
		mcost=20
		attack_roll_damage_dice = TRUE
		attack_roll_dice_count = 2
		attack_roll_dice_sides = 8
		addhit=2
		ptype="spell"
		desc="The user releases a jolt of magical energy at an opponent, which inflicts Paralyze onto the opponent if it does over 20 damage to the target. (Damage: 2d8+INT | ranged attack roll (1d20+INT+2 to hit) vs. Armor, -20 Mana.)"
	Scatter
		level=3
		rank="C"
		damsource="int"
		atype="standard"
		costtype="Mana"
		range="6 tiles."
		mcost=25
		attack_roll_damage_dice = TRUE
		attack_roll_dice_count = 3
		attack_roll_dice_sides = 2
		ptype="spell"
		desc="The user releases a burst of arcane projectiles. Four in total are created, aimed at targets in whatever order the user wishes. Each bolt does individual damage. (Damage: 3d2+INT | Four ranged attack rolls (1d20+INT to hit) vs. Armor, -25 Mana.)"

	Tether
		level=3
		rank="C"
		damsource="int"
		atype="save"
		ptype="spell"
		costtype="Mana"
		range="3 Tiles."
		basecheck=11
		savetype="Strength"
		mcost=25
		desc="The user releases a whip of energy that does not damage an opponent, but if it lands - roots them in place, rendering them unable to move until the spell is released or they break free. (Prompts a STR check versus a saving throw (11+INT+Rankbonus) - on a failure, target is rooted and may not move from their position until succeeding a DC 22 STR check or the spell ends, -25 Mana.)"
	Impact
		element="Physical"
		level=3
		rank="C"
		damsource="int"
		atype="weapon"
		ptype="spell"
		costtype="Mana"
		range="Melee"
		attack_roll_damage_dice = TRUE
		attack_roll_dice_count = 2
		attack_roll_dice_sides = 6
		mcost=30
		desc="The user coats their fist or weapon in a compact and dense construct of arcane energy. They then release a melee attack which combines magical and physical damage, also knocking an opponent back as it explodes. (Make a Melee attack roll, dealing an additional 2d6+INT magical damage, and applying a 6 tile knockback on hit. -30 Mana.)"
	Laser
		level=3
		rank="C"
		damsource="int"
		atype="standard"
		ptype="spell"
		costtype="Mana"
		range="5 tile line."
		mcost=15
		addhit=3
		attack_roll_damage_dice = TRUE
		attack_roll_dice_count = 2
		attack_roll_dice_sides = 4
		desc="Mana is concentrated at the tip of a finger, and channeled to become extremely thin. It's then released in the form of a miniscule laser directed at vital points, meant to penetrate defenses. (Damage: 2d4+INT | +3 to hit, 15 Damage Reduction piercing.  5 tile line.-15 Mana.)"
	Laserga
		level=4
		rank="B"
		pre="Laser"
		damsource="int"
		atype="standard"
		ptype="spell"
		costtype="Mana"
		range="7 tile line."
		mcost=35
		addhit=4
		attack_roll_damage_dice = TRUE
		attack_roll_dice_count = 2
		attack_roll_dice_sides = 10
		desc="Mana is concentrated at the tip of a finger, and channeled into a thin but very condensed mass. It's then released in the form of a sizable laser directed at vital points, meant to penetrate defenses. (Damage: 2d10+INT | +4 to hit, 20 Damage Reduction piercing. 7 tile line. -35 Mana.)"
	Pierce
		level=3
		rank="C"
		damsource="int"
		atype="weapon"
		ptype="spell"
		costtype="Mana"
		range="6 tile range."
		mcost=30
		addhit=2
		attack_roll_damage_dice = TRUE
		attack_roll_dice_count = 2
		attack_roll_dice_sides = 6
		desc="The user coats their projectile in a screeching shroud of magical energy, which causes it to drill and burrow into a target at high speeds after being launched from their weapon. (Make a Ranged weapon attack roll, dealing an additional 2d6+INT magical damage, with +2 to hit and ignoring 5 physical damage reduction. -30 Mana.)"
	Fleche
		level=4
		rank="B"
		damsource="int"
		atype="standard"
		ptype="spell"
		costtype="Mana"
		range="6 tile range."
		mcost=35
		attack_roll_damage_dice = TRUE
		attack_roll_dice_count = 4
		attack_roll_dice_sides = 2
		desc="The caster creates a mass of five spears made of magical energy. They then release these spears at chosen targets in any order all in one burst. (Damage: 4d2+INT | Five ranged attack rolls (1d20+INT), -35 Mana.) (Deals a maximum of 120 damage.)"
	Addle
		element="Thunder"
		level=4
		rank="B"
		damsource="int"
		atype="save"
		ptype="spell"
		costtype="Mana"
		range=" 6 tile range."
		savetype="Fortitude"
		mcost=35
		basecheck=13
		attack_roll_damage_dice = TRUE
		attack_roll_dice_count = 2
		attack_roll_dice_sides = 8
		desc="The caster creates a storm-cloud of arcane energy above a target. It then releases gravity waves upon them, crushing and slowing them if the waves hit. Fortitude saving throw (13+INT+Rankbonus), on a failed save the target takes 2d8+INT damage - and their magic attacks deal 2 less damage for 3 rounds. Takes half damage on a successful save. , -35 Mana.)"
	Combust
		element="Fire"
		level=4
		rank="B"
		damsource="int"
		atype="save"
		ptype="spell"
		costtype="Mana"
		range=" 6 tile range."
		savetype="Fortitude"
		mcost=40
		basecheck=13
		attack_roll_damage_dice = TRUE
		attack_roll_dice_count = 5
		attack_roll_dice_sides = 10
		desc="The caster stands still and focuses for two turns, drawing on the Mana inside of a target individual and grabbing hold of it. They then clench their hands down, causing the mana to combust inside of the foe and dealing damage in a guaranteed hit. (Prompts a Fortitude saving throw (13+INT+Rankbonus), on a failed save the target takes 5d10+INT fire damage, or half as much on a successful save. -40 Mana.)"
	Impactga
		element="Physical"
		level=4
		rank="B"
		pre="Impact"
		damsource="int"
		atype="weapon"
		costtype="Mana"
		mcost=55
		attack_roll_damage_dice = TRUE
		attack_roll_dice_count = 2
		attack_roll_dice_sides = 12
		range="Melee"
		desc="The user coats their fist or weapon in a compact and dense construct of arcane energy, crackling with energy. They then release a melee attack which combines maigcal and physical damage, also knocking an opponent back as it explodes. (Make a Melee attack roll, dealing an additional 2d12+INT magical damage, and applying 12 tile knockback on hit. -55 Mana.)"
	Piercega
		level=4
		rank="B"
		pre="Pierce"
		damsource="int"
		atype="weapon"
		costtype="Mana"
		mcost=55
		addhit=3
		attack_roll_damage_dice = TRUE
		attack_roll_dice_count = 2
		attack_roll_dice_sides = 12
		desc="The user coats their projectile in a silent, but ominous shroud of magical energy, which causes it to drill and burrow into a target at high speeds after being launched from their weapon. (Make a Ranged weapon attack roll, dealing an additional 2d12+INT magical damage, with +3 to hit and ignoring 8 physical damage reduction. -55 Mana.)"
	Joltga
		level=4
		rank="B"
		pre="Jolt"
		damsource="int"
		atype="standard"
		costtype="Mana"
		mcost=35
		addhit=2
		attack_roll_damage_dice = TRUE
		attack_roll_dice_count = 3
		attack_roll_dice_sides = 12
		desc="The user releases a burst of magical energy upon an opponent, which inflicts Paralyze onto the opponent if it does over 20 damage to the target. Damage: 3d12+INT | Ranged attack roll (1d20+int+2) -35 Mana.)"
	JudgementGrimoire
		element="Holy"
		name="Judgement Grimoire"
		level=4
		rank="B"
		cat="Unique"
		costtype="Mana"
		damsource="int"
		atype="save"
		savetype="Reflex"
		costtype="Mana"
		mcost=50
		basecheck=13
		attack_roll_damage_dice = TRUE
		attack_roll_dice_count = 6
		attack_roll_dice_sides = 12
		desc="The user leaps into the air, and calls forth a giant sword from a portal in the sky, to strike the ground. (Prompts a Reflex saving throw to all targets in range (13+INT+Rankbonus) - targets take 6d12+INT slashing damage, or half as much on a successful save. Sword is 5 tiles wide in each direction, - 50 Mana)"
	StormLanceGrimoire
		element="Thunder"
		name="Storm Lance Grimoire"
		level=4
		rank="B"
		cat="Unique"
		damsource="int"
		atype="save"
		savetype="Reflex"
		mcost=45
		attack_roll_damage_dice = TRUE
		attack_roll_dice_count = 2
		attack_roll_dice_sides = 16
		basecheck=13
		desc="After casting, a glyph is created under the user. Four lances of lightning rise from the cardinal directions, and can be thrown able to be aimed and moved through the air by the users will. (Four separate lances, each prompting a Reflex saving throw (14+INT+Rankbonus) - targets take 2d16+WIS damage on a failed save, and are paralyzed, Thunder Element, -45 Mana)"
	SentinelsGrimoire
		name="Sentinel's Grimoire"
		level=4
		rank="B"
		cat="Unique"
		mcost=40
		desc="An enormous shield is called springing down and slamming into the ground from the sky, it can absorb a heavy amount of damage without a crack. However, it also cannot move after being placed down, and can be dispelled by the user at any time as a bonus action. (Creates an 100 HP 3x3 barrier, -40 Mana)"
	GenesisRock
		element="Earth"
		name="Genesis Rock"
		level=4
		rank="B"
		damsource="int"
		atype="save"
		savetype="Reflex"
		mcost=45
		costtype="Mana"
		basecheck=16
		attack_roll_damage_dice = TRUE
		attack_roll_dice_count = 3
		attack_roll_dice_sides = 12
		desc="Magical Mana is sent into the ground beneath the user causing parts of the earth to split away carrying them upwards on a large rock while several other large boulders spin around them. Four projectiles are then fired off at any target within 7 tiles of the point of origin. (Prompts a Reflex saving throw, dealing 3d12+INT piercing damage on a failed save, or half as much on a success - then fires off 4 magical ranged attack rolls, utilizing tome, staff, or focus in your inventory for their accuracy and damage - dealing earth damage on hit. - 45 Mana)"
	AntiAirParticleBeam
		name="Anti Air Particle Beam"
		level=4
		rank="B"
		atype="standard"
		range=" 3x3 AoE around user, 8 tiles upward."
		attack_roll_damage_dice = TRUE
		attack_roll_dice_count = 4
		attack_roll_dice_sides = 12
		adddam=5
		addhit=2
		mcost=30
		desc="Four orbs of darkness are created around the user. The orbs then fire slim beams that fire straight upward striking down anything above them. (Damage: 4d12+INT+5 | Ranged attack roll (1d20+INT+2), has advantage against airborne targets, - 30 Mana)"
	MachWave
		name="Mach Wave"
		level=4
		rank="B"
		atype="standard"
		range="5 Tile range."
		attack_roll_damage_dice = TRUE
		attack_roll_dice_count = 2
		attack_roll_dice_sides = 12
		mcost=35
		desc="Strike at the ground sending a surge of mana into the ground turning it in a powerful wave that is sent forward. The wave travels for a short distance picking up speed. After it has traveled for four tiles it quickly changes become more volatile, and picking up speed. Five tile maximum range. Deals 5 additional damage per tile travelled. (Damage: 2d12+INT | Ranged attack roll (1d20+INT+1), 5 Tile range. - 35 Mana)"
	RedSpiral
		name="Red Spiral"
		level=4
		rank="B"
		cat="Unique"
		atype="standard"
		range="2 tile radius from user."
		attack_roll_damage_dice = TRUE
		attack_roll_dice_count = 3
		attack_roll_dice_sides = 20
		adddam=5
		addhit=2
		mcost=40
		desc="Conjure four streams of magic with a red core, and a blue outline. The streams travel towards an enemy snaking around them as they travel into the air above them conjoining, and then unleashing their stored power in a beam of Mana that can wipe away enemies. (Damage: 3d20+INT+5 | Ranged attack roll at advantage (1d20+INT+2), Target must be in a 2 tile radius of the user to take effect, - 40 Mana)"
	ManaOverdrive
		name="Mana Overdrive"
		level=5
		rank="A"
		mcost=20
		costtype="MP, and HP."
		desc="Allow your Mana to overflow throughout your body, reinforcing your magical presence with your physical energy, by draining yourself of some life-force. This grants you the 'Faith' status effect, and your Spell attack rolls gain +1 to hit, and +1 to Save DCs for the duration of Faith. (-20 MP, -20 HP.)"
	LunaticHigh
		name="Lunatic High"
		level=5
		rank="A"
		cat="Unique"
		mcost=30
		desc="The user takes a deep breath channeling their energies around them as they make a loud howl. Their breath will turn yellow, and wash the area around them with its glow. The aura grants haste to everything it touches, and links the gifted to the user. For each person that is granted haste the user will gain + 1 to AC, and +1 to all attack rolls until the effect wears off. (-30 Mana | 6 round duration.)"
	BloodRedSpiral
		name="Blood Red Spiral"
		level=5
		rank="A"
		cat="Unique"
		atype="standard"
		range=" 7 tile."
		addhit=4
		adddam=5
		mcost=55
		attack_roll_damage_dice = TRUE
		attack_roll_dice_count = 3
		attack_roll_dice_sides = 12
		desc="Conjure a whole storm of red streams that can travel to several targets or be split apart to target multiple targets. The streams will try to surround the target making a circle before unleashing their stored Mana into a powerful beam roasting whatever is trapped inside. (Damage: 3d12+INT+5 | 3 Ranged Attack Rolls (1d20+INT+4), - 55 Mana)"
	Combustga
		level=5
		rank="A"
		pre="Combust"
		atype="save"
		range=" 6 tile."
		basecheck=15
		attack_roll_damage_dice = TRUE
		attack_roll_dice_count = 10
		attack_roll_dice_sides = 12
		adddam=5
		mcost=80
		desc="The caster stands still and focuses for two turns, drawing on the Mana inside of a target individual and grabbing hold of it. They then clench their hands down, causing the mana to combust inside of the foe and dealing damage in a guaranteed hit. (Prompts a Fortitude saving (15+INT+Rankbonus) throw after charging is completed, dealing 10d12+INT+5 damage on a failed save, or half as much on a success. | 2 turn charge time -80 Mana.)"
	GrandCross
		name="Grand Cross"
		level=5
		rank="A"
		cat="Unique"
		atype="standard"
		range=" 2 tile cross AoE within 7 yiles of user."
		attack_roll_damage_dice = TRUE
		attack_roll_dice_count = 7
		attack_roll_dice_sides = 12
		adddam=5
		addhit=4
		mcost=50
		desc="The user conjures four black orbs outlined with a white shell. The orbs travel together manipulated by the user as they chase a target. Once the orbs surround their target they will expand growing to roughly the size of a person. They start to spin rapidly while they converge together. Anything hit by the balls with be hit with a strong electrical charge. When the orbs converge they release their Mana into a powerful explosion in the shape of a cross. (Damage: 7d12+INT+5 | Ranged attack roll (1d20+INT+4), 2 tile cross AoE, - 50 Mana)"
	Pyroclasm
		level=5
		rank="A"
		cat="Unique"
		attack_roll_damage_dice = TRUE
		attack_roll_dice_count = 3
		attack_roll_dice_sides = 12
		adddam=5
		addhit=4
		atype="standard"
		range="8 tiles, second attack explodes as 3x3."
		mcost=55
	StarfallXVI
		name="Starfall XVI"
		level=5
		rank="A"
		cat="Unique"
		mcost=60
		atype="save"
		basecheck=15
		attack_roll_damage_dice = TRUE
		attack_roll_dice_count = 7
		attack_roll_dice_sides = 12
		adddam=4
		range=" 7x7 AoE within 6 tiles of caster."
		desc="The user creates a ball of super heated magic casting it into the air where it grows into a massive inferno sitting above the heads of everyone in the battlefield. The inferno is then cast downward scorching the very earth as it collides into setting everything ablaze. (Prompts a Reflex saving throw(15+INT+Rankbonus), dealing 7d12+INT+4 Fire damage on a failure, or half as much on a successful save. Affects a 7x7 AoE, - 60 Mana.)"
	HeartlessAngel
		name="Heartless Angel"
		level=6
		rank="S"
		cat="Unique"
		mcost=160
		basecheck=16
		atype="save"
		savetype="Fortitude"
		desc="The user standing still, and with complete concentration begins to channel, and pray to death. Over the course of three turns they pray, but when finished death deals a blow to the victim reducing them to a near death state. The victim has to be within the vision of the caster. (Prompts a Fortitude saving throw(16+INT+Rankbonus), which reduces target to 40 HP if failed, after 3 channeling turns. Does not lower beyond 40 HP. -160 Mana.)"
		attack_roll_damage_dice = FALSE
		attack_roll_damage_exact = 0
