/obj/perk/Jobperks/Monk
	element="Monk"
	jobneed="Monk"
	icon='Icons/Perk/Monk.png'
	Monk
		name="Monk"
		cat="Unique"
		desc="Monks hone their body before all else. They are warriors of body, spirit, and mind, specialized in fast movement and faster attacks. They gain +2 AC passively and they gain +2 PAB / MAB when attacking opponents within their melee range. +60 HP, +50 Mana, +50 SP."
	MasterofMobility
		name="Master of Mobility"
		rank="T2"
		desc="This Monk is a master of mobility on the ground. When a Monk uses their turn’s movement action, they may spend 15 SP to gain an additional +3 tiles of movement for that movement action. As an alternate option, they may lose 2 tiles of movement and spend 15 SP to not provoke Attacks of Opportunity for this movement. This alternate usage has a 1 Turn Cooldown."
	CombatMomentum
		name="Combat Momentum"
		rank="T2"
		desc="This Monk has learned the art of Combat Momentum. They can build up stacks of Combat Momentum, to a maximum of 5. Each stack grants the Monk +1 PAB and +1 PDB each. Every tile that a Monk moves away from their starting position during their turn grants them a stack of Combat Momentum, and all stacks are removed at the end of their turn."
	DefensiveManuever
		name="Defensive Manuever"
		rank="T2"
		desc="This Monk has learned to fight on their toes. After being targeted by a non-magical attack, they may choose to spend their Reaction and 20 SP to impose disadvantage to that attack. This has a 1 Turn cooldown."
	NeverGiveUp
		name="Never Give Up"
		rank="T3"
		desc="This Monk has the guts to never give up. Once the Monk is at or under 30% of their HP, they may gain ‘Haste’, ‘Bravery’ and ‘Bleed’ as Reaction, pushing themselves to the limit. These status effects remain for as long as the user is under or at 30% HP. May be used once per battle / dungeon / encounter."
	FlurryofBlows
		name="Flurry of Blows"
		rank="T3"
		desc="This Monk has mastered the ability to blend movements into movements. As a result, whenever using a Monk ability or using a Monk standard attack, they may - as a Bonus Action once per round, spend 20 SP in order to perform two extra additional Standard attacks, with each of their damages halved. 1 Turn cooldown."
	Chi
		rank="T3"
		name="Chi"
		desc="This individual has learned to harness their inner chi. Chi is a vital energy that blurs the lines between physical and magical. All non-spell (Black/White/Arcane/Green and abilities that count as spells such as Oracle’s) abilities - but not perks - may use SP or MP to pay for their costs, but if a different resource is used to the one the ability asks for, double the amount of the new resource must be spent."
	Transform
		rank="T4"
		name="Transform"
		desc="This Monk has learned to harness their Chi in order to enter a personalized 'transformed' state. Upon entering this state, the Monk gains a flowing aura, and an additional +8 PAB, MAB, PDB, and MDB, as well as +4 AC, and +2 WIS. This state costs 45 SP per round to sustain. Utilizing Transform is a Bonus Action."
	TemperedFists1
		rank="T1"
		name="Tempered Fists I"
		desc="This individual has trained their fists to act like weapons. As long as they wield no weapon their base damage roll is 2d6, and they gain +1 to hit, and +2 damage. Note: Requires no weapon, and no armor to be equipped."
		Tempered1
			name="Monk Fists I"
			cat="Unique"
			ability=1
			mcost=0
			basecheck=10
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 2
			attack_roll_dice_sides = 6
			adddam=2
			addhit=1
			range="Melee"
			costtype="Stamina"
			atype="standard"
			damsource="str"
			typing="physical"
			ptype="spell"
	TemperedFists2
		rank="T2"
		name="Tempered Fists II"
		pre="Tempered Fists I"
		desc="This individual has trained their fists to act like weapons. As long as they wield no weapon their base their base damage roll is 2d8, and they gain +2 to hit, and +3 damage. Note: Requires no weapon, and no armor to be equipped."
		Tempered2
			name="Monk Fists II"
			cat="Unique"
			ability=1
			mcost=0
			basecheck=10
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 2
			attack_roll_dice_sides = 8
			adddam=3
			addhit=2
			range="Melee"
			costtype="Stamina"
			atype="standard"
			damsource="str"
			typing="physical"
			ptype="spell"
	TemperedFists3
		rank="T3"
		name="Tempered Fists III"
		pre="Tempered Fists II"
		desc="This individual has trained their fists to act like weapons. As long as they wield no weapon their base damage roll is 2d10, and they gain +3 to hit, and +4 damage. Note: Requires no weapon, and no armor to be equipped."
		Tempered3
			name="Monk Fists III"
			cat="Unique"
			ability=1
			mcost=0
			basecheck=10
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 2
			attack_roll_dice_sides = 10
			adddam=4
			addhit=3
			range="Melee"
			costtype="Stamina"
			atype="standard"
			damsource="str"
			typing="physical"
			ptype="spell"
	TemperedFists4
		rank="T4"
		name="Tempered Fists IV"
		pre="Tempered Fists III"
		desc="This individual has trained their fists to act like weapons. As long as they wield no weapon their base damage roll is 2d12, and they gain +4 to hit, and +5 damage. Note: Requires no weapon, and no armor to be equipped."
		Tempered4
			name="Monk Fists IV"
			cat="Unique"
			ability=1
			mcost=0
			basecheck=10
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 12
			attack_roll_dice_sides = 2
			adddam=5
			addhit=4
			range="Melee"
			costtype="Stamina"
			atype="standard"
			damsource="str"
			typing="physical"
			ptype="spell"
	TemperedFists5
		rank="T5"
		name="Tempered Fists V"
		pre="Tempered Fists IV"
		desc="This individual has trained their fists to act like weapons. As long as they wield no weapon their base damage roll is 2d20, and they gain +5 to hit, and +10 damage. Note: Requires no weapon, and no armor to be equipped."
		Tempered5
			name="Monk Fists V"
			cat="Unique"
			ability=1
			mcost=0
			basecheck=10
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 20
			attack_roll_dice_sides = 2
			adddam=10
			addhit=5
			range="Melee"
			costtype="Stamina"
			atype="standard"
			damsource="str"
			typing="physical"
			ptype="spell"
	TemperedBody1
		rank="T1"
		name="Tempered Body I"
		desc="This individual has trained their body to withstand all sorts of wear. As long as they are not wearing armor their DR, AC, and all saves are increased by 1."
	TemperedBody2
		rank="T2"
		name="Tempered Body II"
		pre="Tempered Body I"
		desc="This individual has trained their body to withstand all sorts of wear. As long as they are not wearing armor their DR, AC, and all saves are increased by 2."
	TemperedBody3
		rank="T3"
		name="Tempered Body III"
		pre="Tempered Body II"
		desc="This individual has trained their body to withstand all sorts of wear. As long as they are not wearing armor their DR, AC, and saves are increased by 3."
	TemperedBody4
		rank="T4"
		name="Tempered Body IV"
		pre="Tempered Body III"
		desc="This individual has trained their body to withstand all sorts of wear. As long as they are not wearing armor their DR, AC, and saves are increased by 4."
	TemperedBody5
		rank="T5"
		name="Tempered Body V"
		pre="Tempered Body IV"
		desc="This individual has trained their body to withstand all sorts of wear. As long as they are not wearing armor their DR, AC, and saves are increased by 5."

/obj/perk/Abilities/Monk
	monkability=1
	jobneed="Monk"
	icon='Icons/Perk/Monk.png'
	damsource="str"
	costtype="Stamina"
	atype="weapon"
	typing="physical"
	element="Monk"
	ChiBlast
		element="Force"
		name="Chi Blast"
		rank="E"
		attack_roll_damage_dice = TRUE
		attack_roll_dice_count = 1
		attack_roll_dice_sides = 6
		damsource="wis"
		range=" 6 tiles."
		mcost=10
		costtype="Mana"
		typing="physical"
		desc="The individual gathers their chi energy, and releases it in a potent burst - which causes it to hurl forth as a sphere of pure energy. You may add Physical damage bonus to this technique. (Damage: 1d6+WIS Force damage | Ranged magical attack roll, -10 Mana.)"
	FocusedCounter
		name="Focused Counter"
		rank="D"
		desc="By focusing their Chi and staying completely still they are capable of perceiving an incoming attack and delivering a counter-attack if they manage to avoid it. (As a reaction to a missed melee attack against the user, a melee counter-attack may be used. This ability may occupy the same reaction as Defensive Maneuver. -15 Mana.)"
	BurningArrow
		element="Fire"
		name="Burning Arrow"
		rank="D"
		attack_roll_damage_dice = TRUE
		attack_roll_dice_count = 2
		attack_roll_dice_sides = 12
		range="Melee"
		mcost=15
		desc="The user ignites their leg, and enters into a flying spear-kick towards a target creature. When this attack makes contact with a target it sets forth a small fiery explosion. (Damage: 2d12+STR fire damage. | Melee attack roll. Inflicts burn on hit. -15 Stamina.)"
	Penance
		element="General"
		rank="C"
		attack_roll_damage_dice = TRUE
		attack_roll_dice_count = 3
		attack_roll_dice_sides = 12
		range=" Melee."
		mcost=30
		costtype="Mana"
		damsource="wis"
		desc="The user strikes at a target's pressure point controlling magic ability. By implanting some of their chi they interrupt the flow of magic. Make a Penance attack roll. After damage calculation, the target must make a Fortitude saving throw (DC 12 + Wis + Rank). On a failed save the target suffers from damage to their magic system, gaining the same effect as ‘Silence’ for 2 Turns. (Damage: 3d12+WIS Force damage. | Melee attack roll. -30 Mana.)"
	Combo
		name="Combo"
		rank="C"
		desc="The Monk may utilize this ability as a Bonus Action in order to spend 20 SP. They may then use another Monk ability that is C Rank or lower, at double its SP or MP cost."
	ChakraGlide
		name="Chakra Glide"
		rank="C"
		desc="The monk may launch themselves forwards for the cost of 40 MP. Upon doing so, the Monk bursts forward in a straight line, traveling exactly 7 tiles. If the line intersects with an opponent, the user makes a Standard Attack and that opponent must make a Fortitude saving throw (DC 10 + Str + Rank) or both the opponent and Monk continue to the end of that line. If the save is passed, the Monk’s movement ends. If the initially struck enemy strikes others during their path, the initial standard attack applies to them as well."
		range=" 7 tile line."
		mcost=40
		costtype= "MP"
	DragonDash
		name="Dragon Dash"
		rank="B"
		desc="The Monk may use this ability in order to burst across the battle-field, coating their body in Chi energy. They may travel up to 8 tiles to a single target of their choice, and upon reaching the target, they may perform a Standard attack. These attacks ignore Damage Reduction, and count as Force damage, due to Chi infused fists. Costs 50 MP."
		mcost=50
		costtype=" MP"
	IronBody
		name="Iron Body"
		rank="B"
		cat = "Unique"
		desc = "This perk is removed. Please adminhelp for a refund."
	GaleKick
		element="Wind"
		name="Gale Kick"
		rank="B"
		range=" 7 tile."
		attack_roll_damage_dice = FALSE
		attack_roll_damage_lower = 40
		attack_roll_damage_upper = 55
		atype="weapon"
		mcost=40
		addhit=3
		costtype= "Mana"
		desc="The Monk may spend 55 MP in order to perform a roundhouse kick, which releases a blade of air from the heel. +3 to hit. On hit, this blade of air inflicts 'Bleed' and 'Squall'"
	Zanzoken
		name="Zanzoken"
		rank="B"
		desc="The Monk may spend 50 SP to perform instantaneous movement to another position within their Speed’s worth of tiles as a movement action. Upon doing so, the Monk gains 1 stack of 'Blink'. If this Blink proc is activated, the Monk may instantaneously reposition to another tile within 5 tiles, as a reaction. If they reposition themselves near an enemy creature, they may use a Standard Attack."
	Chakra
		rank="C"
		atype="heal"
		damsource="wis"
		attack_roll_damage_dice = TRUE
		attack_roll_dice_count = 2
		attack_roll_dice_sides = 20
		desc="The user floods parts of their body with Chi healing it and purging it of poisons. They heal for 2d20 HP and cure themselves of poison, blind, and silence. (- 30 mana.)"
	DolphinBlow
		element="Water"
		name="Dolphin Blow"
		rank="C"
		attack_roll_damage_dice = TRUE
		attack_roll_dice_count = 3
		attack_roll_dice_sides = 10
		range=" Melee."
		mcost=30
		costtype="Mana"
		desc="The user channels their chakra forming a puddle of water below them and a target. An uppercut is made, and the projection of a dolphin erupts from the puddle to strike their target, and carry them away on a successful hit. (Damage: 3d10+STR water damage | Melee attack roll, knocks back 5 tiles in a chosen direction on hit. -30 mana.)"
	TornadoKick
		element="Wind"
		name="Tornado Kick"
		rank="C"
		attack_roll_damage_dice = TRUE
		attack_roll_dice_count = 3
		attack_roll_dice_sides = 10
		range=" 3x3 AoE centered around user."
		atype="weaponsave"
		basecheck=12
		savetype="Fortitude"
		mcost=30
		costtype="Mana"
		desc="The user kicks off the ground making them airborne. They then spin rapidly, their foot outstretched, kicking up a powerful storm of wind. They finish by landing on the ground as the built up whirlwind fires outwards omnidirectionally. (Damage: 3d10+STR wind damage | 3x3 AoE, Fortitude saving throw (DC 12+STR+Rank bonus), dealing full damage and 5 tile knockback on failure, half damage on success. -30 mana.)"
	MeteorDive
		element="Comet"
		name="Meteor Dive"
		rank="B"
		attack_roll_damage_dice = TRUE
		attack_roll_dice_count = 5
		attack_roll_dice_sides = 10
		mcost=40
		damsource="str"
		atype="weaponsave"
		savetype="Reflex"
		basecheck=14
		desc="The user grapples the opponent holding them in their arms as they kick off the ground, and soar upwards before crashing down, and slamming the opponent into the ground. Note: Can even be used on trains. The target must roll a Reflex Save. If the target fails the roll they are grappled and launched with the user towards a location within 6 tiles. (Damage: 5d10+WIS | Reflex Save (DC 14+STR+Rank bonus), dealing full damage on a failure, or none on a success. - 40 stamina.)"
	ChiWave
		element="Force"
		name="Chi Wave"
		rank="B"
		basecheck=15
		attack_roll_damage_dice = FALSE
		attack_roll_damage_lower = 40
		attack_roll_damage_upper = 60
		damsource="wis"
		atype="weaponsave"
		savetype="Fortitude"
		basecheck = 12
		mcost=60
		costtype=" MP"
		range=" 3 tile wide, 7 tile long line."
		desc="The Monk channels Chi throughout their entire body, before releasing it from a specific point, as a massive wave of energy, prompting a Fortitude saving throw (DC 12+STR+Rank bonus), and dealing full damage and dragging a creature to the end of the AoE on a failure, or half and no drag on a success. Costs 60 MP."
	BurningRave
		element="Fire"
		name="Burning Rave"
		rank="B"
		attack_roll_damage_dice = TRUE
		attack_roll_dice_count = 5
		attack_roll_dice_sides = 10
		range=" 5x5 AoE centered around user."
		atype="weaponsave"
		savetype="Fortitude"
		basecheck=12
		mcost=50
		costtype="Mana"
		desc="The user extends chi outside of their body forming an aura. They then ignite the aura causing it to burn at an intense heat. It's then condensed at the fist, and a single punch is made, which causes the heat to reverberate in a massive area around the user, seeking to scorch anyone within range. (Damage: 5d10+STR fire damage | 5x5 AoE, Fortitude saving throw  (DC 12+STR+Rank bonus). Full damage + burn infliction on a failure, half damage on a success. -50 mana.)"
	PressurePoint
		name="Pressure Point"
		rank="A"
		mcost=65
		costtype="Mana"
		attack_roll_damage_dice = TRUE
		attack_roll_dice_count = 7
		attack_roll_dice_sides = 10
		range=" Melee"
		desc="The user has learned how to get around even magical defenses with their martial prowess. They channel their power into a single finger that punches through any armor or magical barrier, and dealing heavy damage to the target. (Damage: 7d10+STR force | Melee attack roll. Ignores the effects of protect, shell, reflect, and stoneskin. Dispels these status effects on hit. If no barrier type effect is active, inflicts -2 to damage reduction for 3 turns. -65 Mana.)"
	PhantomRush
		name="Phantom Rush"
		rank="A"
		desc="The user floods their body with Chi, enhancing their speed and causing them to appear as a blur to anyone looking. They deliver a series of attacks towards a single target, making 3 basic Monk attacks; each requiring their own roll but gaining a +2 to hit. Gives the Monk the 'Blink' status. (- 65 mana.)"
	FinalHeaven
		name="Final Heaven"
		rank="S"
		attack_roll_damage_dice = TRUE
		attack_roll_dice_count = 9
		attack_roll_dice_sides = 12
		range=" 7x7 AoE"
		savetype="Reflex"
		atype="weaponsave"
		basecheck=15
		mcost=120
		costtype="Mana"
		desc="The user concentrates all their chi into their fist causing it to glow red with a brilliant aura of energy. They slam their fist into the ground releasing the chi in a fiery explosion of energy around them, seeking to obliterate their surroundings and any foes unfortunate enough to be caught in the radius. (Damage: 9d12+STR fire damage | 7x7 AoE, Reflex saving throw (DC 15+STR+Rank bonus), dealing full damage and inflicting burn on a failure, and half damage on a success. -120 Mana.)"
	DoomFist
		name="Doom Fist"
		rank="S"
		desc="The user concentrates their chi into their vision seeing the pressure points in their opponent. They make several concentrated attacks hitting one point after another. If all points are hit the target is met with certain death with only minutes to live. Make 3 attack rolls. For each one that hits the target is affected with the following. Slow => Silence => Doom. (-100 mana.)"
	LuckyCombo
		name="Lucky Combo"
		rank="S"
		cat="Unique"
		attack_roll_damage_dice = FALSE
		attack_roll_damage_lower = 50
		attack_roll_damage_upper = 60
		damsource="str"
		atype="weapon"
		critrange=10
		range=" Melee"
		mcost=120
		costtype=" Stamina"
		desc="The user channels a large amount of Chi lifting into the air as what appear to be slot machine slots form around them. The slots tick down each landing after one another. The Monk then rockets forward, bringing the force of Luck with their strikes. The Monk makes 3 'Lucky Slots' attack rolls, which each have a base crit range of 10-20, dealing 50-60+STR damage on each. Costs 120 Stamina."
