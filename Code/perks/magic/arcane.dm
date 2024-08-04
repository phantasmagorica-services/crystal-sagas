/obj/perk/Abilities/ArcaneMagic
	magicneed="Arcane Magic"
	damsource="wis"
	costtype="Mana"
	atype="standard"
	basecheck=10
	typing="magical"
	element="General"

	Darkness
		element="Dark"
		icon='Icons/Perk/Apocalypse.png'
		Dark
			atype="standard"
			level=1
			range="6 tiles."
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 2
			attack_roll_dice_sides = 12
			mcost=15
			desc="A small laser-like projectile, made of darkness. On hit, inflicts 'Weakness'. Costs 15 MP. 2d12+WIS damage."
		Darkra
			level=2
			range="6 tiles."
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 3
			attack_roll_dice_sides = 10
			mcost=25
			desc="A sphere of darkness, fired from the palm of the hand. On hit, inflicts 'Weakness'. Costs 25 MP. 3d10+WIS damage."
		Darkaga
			level=3
			range="8 tiles."
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 5
			attack_roll_dice_sides = 12
			mcost=40
			desc="A large sphere of darkness, fired from the palm at a target. On hit, this inflicts 'Weakness'. Costs 40 MP. 5d12+WIS damage."
		Darkja
			level=4
			range="3x3 AoE at a point in view."
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 8
			attack_roll_dice_sides = 10
			mcost=60
			desc="A massive ball of darkness, which manifests as a sphere at a point in view. On hit, this spell inflicts 'Weakness' and 'Slow'. Costs 60 MP. 8d10+WIS damage."
	Bios
		element="Bio"
		icon='Icons/Perk/Bio.png'
		Bio
			level=1
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 2
			attack_roll_dice_sides = 12
			range=" 6 tile range."
			mcost=15
			desc="The caster creates a corrosive bubble Upon contact with the target the bubble pops coating its target with poison. On a successful hit, the target must also make a Fortitude saving throw (DC 15) or be inflicted with 'Poison'. (Damage: 2d12+WIS Bio damage | 6 tile range, Magical attack roll. -15 mana)"
		Bioara
			level=2
			pre="Bio"
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 3
			attack_roll_dice_sides = 10
			range=" 6 tile range."
			mcost=30
			desc="The caster creates a corrosive bubble Upon contact with the target the bubble pops coating its target with poison. On a successful hit, the target must also make a Fortitude saving throw (DC 18) or be inflicted with 'Poison'. (Damage: 3d10+WIS Bio | 6 Tile range, Magical attack roll. -30 mana.)"
		Bioaga
			level=3
			pre="Bioara"
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 5
			attack_roll_dice_sides = 12
			range=" 10 tile range, 5x5 projectile."
			mcost=70
			desc="The caster creates a huge bubble of corrosive poison liquid. The bubble travels until it reaches its target, popping and raining hell upon the area below. On a successful hit, a creature must make a Fortitude saving throw (DC 19) ; being inflicted with 'Poison' on a failure. (Damage: 5d12+WIS Bio damage | 10 tile range, 5x5 size projectile, Magical attack roll. -70 Mana.)"
		Scourge
			level=4
			pre="Bioaga"
			desc="The caster injects a section of land with poisonous scourge. Everything in the land dries up and dies, smelling of rot. The poison initially covers a 3x3 AoE, spreading an additional 1 in every direction at the end of the users turn (capping at 10x10). Targets who begin their turn while in the rot take 3d10 Bio damage. (-65 initial mana to cast, -10 to sustain.)"
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 3
			attack_roll_dice_sides = 10
			range="3x3 AoE, spreading 1 tile in each direction each turn."
			mcost=65
	Drains
		element="Drain"
		icon='Icons/Perk/Drain.png'
		Drain
			level=1
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 2
			attack_roll_dice_sides = 12
			range=" 6 tile range."
			mcost=15
			desc="The caster creates a red tendril of magic that latches onto a target siphoning life force into the user. (Damage: 2d12 to HP | 6 Tile range, Magical attack roll, heals the caster for HP equal to damage dealt.. -15 mana.)"
		Drainga
			level=3
			pre="Drain"
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 3
			attack_roll_dice_sides = 12
			range=" 6 tile cone."
			basecheck=14
			atype="save"
			savetype="Fortitude"
			mcost=50
			desc="Acts the same as the drain spell, but the user is able to split the end of the tendril into several smaller parts allowing them to attach to multiple targets at once. There is no limit to the amount of tendrils created, but the more that are made the weaker, and smaller they will become. (Damage: 3d12 to HP | 5 tile cone, prompts a Fortitude saving throw (DC 14+WIS+Rank bonus), dealing full damage and draining on a failure, or dealing half damage to target's HP with no drain instead on a success. -50 mana.)"
	Osmoses
		element="Osmose"
		icon='Icons/Perk/Osmose.png'
		Osmose
			level=1
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 2
			attack_roll_dice_sides = 12
			range=" 6 tile range."
			mcost=1
			desc="The caster creates a blue orb of magic from their hand. The orb is able to sprout a tendril that can travel to a medium range or a bit longer depending on how much mana the user wishes to put into the spell. (Damage: 2d12 to MP | 6 Tile range, Magical attack roll, drains damage to MP dealt. -1 Mana.) Out of Battle Effects: The user is capable of draining magic placed in an object."
		Osmosega
			level=3
			pre="Osmose"
			atype="save"
			savetype="Reflex"
			range=" 5 tile cone."
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 3
			attack_roll_dice_sides = 12
			basecheck=14
			mcost=5
			desc="Acts the same as the syphon spell, but the user is able to split the end of the tendril into several smaller parts allowing them to attach to multiple targets at once. There is no limit to the amount of tendrils created, but the more that are made the weaker, and smaller they will become. (Damage: 3d12 to MP | 5 tile cone, prompts a Reflex saving throw (DC 14+WIS+Rank bonus), dealing full damage and draining on a failure, or dealing half damage to MP on a success. -5 Mana.)"
	Toads
		element="Bio"
		icon='Icons/Perk/Toad.png'
		Toad
			level=1
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 1
			attack_roll_dice_sides = 12
			range=" 5 tile range."
			desc="The user creates an orb of magic in their palm. They then shape the orb into the form of a frog. The spell is nearly indistinguishable from a normal frog. The spell can move on its own - leaping, and traveling like a real frog. On a successful hit, a creature is prompted with a Fortitude saving throw (DC 15), being inflicted with the 'Toad' status effect on a failure. Out of Battle Effects: This user is capable of communicating with toads. They have a fairly detailed knowledge on them and gain advantage on any naturalist checks regarding frogs or toads. (Damage: 1d12+WIS force | 5 tile range, Magical attack roll. -30 Mana.)"
		Toadga
			level=3
			pre="Toad"
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 5
			attack_roll_dice_sides = 12
			range=" 10 tile range, 3x3 sized projectile."
			mcost=80
			desc="The user forms an orb of magic above their head. The orb shifts and changes shape until it bursts spewing magical toads in every direction. On a successful hit, prompts a Fortitude saving throw (DC 18) ; inflicting 'Toad' on a failure. (Damage: 5d12+WIS Force damage | 10 tile range, 3x3 sized projectile. Magical attack roll. - 80 mana.)"
	Statusinfliction
		element="General"
		icon='Icons/Perk/Statusinfliction.png'
		Blind
			level=1
			range=" 6 tiles."
			atype="save"
			savetype="Fortitude"
			attack_roll_damage_dice = FALSE
			attack_roll_damage_exact = 0
			mcost=15
			desc="The user has learned how to inflict the blind status effect. Target must make a fortitude save or suffer blind for four turns. 6 tile range. Out of Battle Effects: The user is capable of tricking a target's sight. They can temporarily cause their sight to become blurry or cause irritation in their eyes. The effect is subtle and targets are mostly unable to determine magical tampering. (Fortitude saving throw (DC 10+WIS+Rank bonus), inflicts Blind on failure. -15 Mana)"
		Blindga
			level=3
			pre="Blind"
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 2
			attack_roll_dice_sides = 6
			range=" 6 tile range."
			mcost=30
			desc="The user spews a cloud of magical black ash that blinds everything it comes in contact with. (Damage: 2d6+WIS force | 6 tile range, Magical attack roll, inflicts Blind on hit. - 30 mana)"
		Silence
			level=1
			attack_roll_damage_dice = FALSE
			attack_roll_damage_exact = 0
			atype="save"
			range=" 6 tile range."
			mcost=15
			savetype="Fortitude"
			desc="The user casts forward a bolt of magick aimed at a targets throat. Upon contact the bolt will pass through the target locking their ability to speak. Target must make a fortitude saving throw or suffer silence. 6 tile range. (Fortitude saving throw (DC 10+WIS+Rank bonus), inflicts Silence on failure. -15 mana.)"
		Sleep
			level=1
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 1
			attack_roll_damage_upper = 8
			attack_roll_dice_sides = 8
			range=" 6 tile range."
			mcost=15
			desc="The caster creates a dark cloud. Upon contact the cloud lulls the target to sleep. (Damage: 1d8+WIS force | 6 Tile range, Magical attack roll, inflicts Sleep on hit. -15 mana.)"
		Sleepga
			level=3
			pre="Sleep"
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 3
			attack_roll_damage_upper = 10
			attack_roll_dice_sides = 10
			range=" 5x5 AoE within 10 tiles."
			mcost=60
			desc="The user starts to exhale a strange white powder forming it into a ring of clouds around them. Once the cloud is built to a large size the user throws their arms out at the clouds disperse outward spreading among the area. If the cloud is breathed in it will make the afflicted drowsy, and an excessive amount will put them to sleep entirely. (Damage: 3d10+WIS Force | 5x5 AoE within 10 tiles, Magical attack roll. Inflicts Sleep on hit. - 60 Mana.)"
		Hold
			level=2
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 2
			attack_roll_damage_upper = 4
			attack_roll_dice_sides = 4
			range=" 5 tile range."
			savetype="Reflex"
			atype="save"
			mcost=30
			desc="The user casts their spell creating a ball of crackling Mana onto the ground. The ball travels at the caster's control. From the ball chains of lightning can be created. The tendrils can extend up to six feet from the ball, and can wrap around an enemy creating a minute electric shock that can paralyze them in place. Out of Battle Effects: The user is capable of using their magic to hold objects or people in place. The tendrils are capable of restraining an object up to 20 feet in size. (Damage: 2d4+WIS force | 5 tile range, Prompts a reflex saving throw (DC 10+WIS+Rankbonus), inflicting stun and dealing full damage on a failure, or half damage on a success. -30 Mana.)"
	Death
		element="Death"
		icon='Icons/Perk/Death.png'
		Corpse
			level=4
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 4
			attack_roll_dice_sides = 8
			range=" 5x5 AoE within 8 tiles."
			atype="save"
			savetype="Reflex"
			basecheck=14
			mcost=60
			desc="The caster reaches out to all freshly fallen corpses in view. Using the negative energy created from their death they cause the corpses to explode in a nova of dark energy. Each corpse explodes into a 5x5 AoE, and prompts a 'Corpse' saving throw attack to any creature within its radius. This can be used on willing 'Zombie' and 'Skeleton' creatures, as a medium as opposed to a corpse so long as those creatures are the caster's allies. View range. (Damage: 4d8+WIS dark | 5x5 AoE, prompts a Reflex saving throw (DC 14+WIS+Rank bonus), dealing full damage on a failure, or half on a success. - 60 mana)"
		Break
			level=4
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 1
			attack_roll_dice_sides = 10
			range=" 10 tile range."
			mcost=80
			desc="The user casts several stones that fly towards an enemy. The stones seep an eerie mist, and seem to be pale in color. The stones are a trick as if they hit something they do very little damage at all, but if it comes into contact with a living thing it will turn the area it hit into stone. (Damage: 1d10+WIS force | 10 Tile range, Magical attack roll. Inflicts Break on hit. -80 Mana.)"
		Breakga
			level=5
			pre="Break"
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 2
			attack_roll_dice_sides = 10
			range=" 5 tile cone."
			mcost=100
			desc="The user holds their hand in front of them. What appears to be a stone forms by magic in their hand. The stone forms into hundreds of splinters firing out and peppering the area in front of the user, damaging and inflicting 'Break' onto anything it hits. (Damage: 2d10+WIS force | 5 tile cone, Magical attack roll, inflicts Break on hit. -100 Mana.)"
		Breakartpentagram
			element="Dark"
			name="Breakart Pentagram"
			level=5
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 10
			attack_roll_dice_sides = 8
			range=" 10 tile range, 5x5 AoE."
			mcost=65
			desc="The user forms a pentagram of magic. The magic is imbued with energy of the abyss and is capable of interfering with the bond that keeps espers on this plane. It is particularly effective against Summon / Eidolon type creatures, as it removes their very lifeforce from this plane, bit by bit. (Damage: 10d8+WIS force damage | 10 tile range, 5x5 AoE. Only damages summons / half espers. Magical attack roll. -65 mana.)"
		Death
			element="Dark"
			level=6
			pre="Corpse"
			attack_roll_damage_dice = FALSE
			attack_roll_damage_exact = 4
			range=" 8 tile range."
			mcost=150
			desc="The user forms a skull entity made of magic. The skull travels as a projectile before colliding with its target unleashing its dark energy directly into the heart of the target. On a successful hit, if the target has less than 100 HP after damage calculation, they die instantly. Otherwise it does nothing. -100 mana. Can only be cast once per day. (Damage: 4 Force damage | Magical attack roll. -150 Mana.)"
