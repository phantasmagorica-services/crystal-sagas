/obj/perk/Abilities/BlackMagic
	magicneed="Black Magic"
	damsource="wis"
	costtype="Mana"
	atype="standard"
	basecheck=10
	typing="magical"

	Hydro
		element="Water"
		icon='Icons/Perk/Water.png'
		Water
			level=1
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 1
			attack_roll_dice_sides = 12
			atype="standard"
			range="10 tile range."
			mcost=5
			desc="In Battle Effects: Release a blast of condensed water upon a target within range. Applies 'Wet' on hit. Out of Battle Effects: This individual is capable of controlling water. They can move up to 5ft of water from one location to another within view. They are capable of creating a 5ft puddle from water in the air. (Damage: 1d12+WIS water damage | 10 tile range, Magical attack roll. -5 Mana.)"
		Watera
			level=2
			pre="Water"
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 2
			attack_roll_dice_sides = 12
			range="8 tile range."
			mcost=15
			desc="A medium sized, tightly packed ball of water is launched towards the target. Applies wet on hit. Out of Battle Effects: This individual is capable of controlling water. They can move up to a 10x10ft block of water from one location to another within view. They are capable of creating a 10ft puddle from water in the air. (Damage: 2d12+WIS water damage | 8 tile range, Magical attack roll. -15 Mana.)"
		Waterga
			level=3
			pre="Watera"
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 3
			attack_roll_dice_sides = 12
			range="3x3 Projectile, 10 tile range."
			atype="save"
			savetype="Reflex"
			basecheck=10
			mcost=30
			desc="A large ball of water is tightly compacted and launched in an arc, then exploding with concussive force at its target location. Out of Battle Effects: This individual is capable of controlling water. They can move up to a 15x15ft block of water from one location to another within view. They are capable of creating a 15ft puddle from water in the air. They are capable of diving sources of water up to 5 miles away. (Damage: 3d12+WIS water damage | 10 tile range, 3x3 sized projectile. Prompts a reflex saving throw, which if failed causes full damage - and inflicts 'Wet'. On a success, take half damage. -30 Mana.)"
		Waterja
			level=4
			pre="Waterga"
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 5
			attack_roll_dice_sides = 12
			range="5x5 AoE at a point in view."
			atype="save"
			savetype="Reflex"
			basecheck=14
			mcost=45
			desc="An ancient runic circle forms underneath the target, upon activation a torrent of water is summoned to assault the target area with its raging tides. Out of Battle Effects: This individual is capable of controlling water. They can move up to a 30x30ft block of water from one location to another within view. They are capable of creating a 30ft puddle from pure magic. They are capable of divining sources of water up to 10 miles away. (Damage: 5d12+WIS water damage | 5x5 AoE at a point in view, prompts a Reflex saving throw ; dealing full damage, inflicting 'Wet', and knocking prone on failure - or dealing half damage on a success. -45 Mana.)"
		Flood
			level=4
			pre="Waterja"
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 3
			attack_roll_dice_sides = 12
			range="Single target, within view."
			mcost=40
			desc="Magic is used to form a puddle under a target. More and more water is created before it erupts upwards in a powerful column that sends the target up into the air.  (Damage: 3d12+WIS water damage | Single target within view, Magical attack roll, on hit launches target 6 tiles into the air. -40 mana.)"
		Tsunami
			level=5
			pre="Waterja"
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 6
			attack_roll_dice_sides = 12
			atype="save"
			savetype="Fortitude"
			range=" 7 tile long, 5 tile wide zone."
			basecheck=16
			mcost=70
			desc="The user holds out their hand collecting a significant amount of water before releasing it in a giant wave that sweeps away anything in front of them. Passive: This person's Water magic may now take on the 'Whorl' attribute, allowing them to spend 8 MP in order to inflict 2d10 additional water damage, and prompt a DC 20 Fortitude saving throw to inflict the 'Whorl' status effect on failure, to any instance of Water damage they cause. (Damage: 6d12+WIS Water damage | Targets a 7 tile long, 5 tile wide zone in front of the caster, prompts a Fortitude saving throw (DC 16+WIS+Rank bonus), dealing full damage and inflicting 'Wet', carrying the creature to the edge of the AoE, and knocking prone on a failure, and dealing half damage on a success. -70 mana.)"
	Ice
		icon='Icons/Perk/Ice.png'
		element="Ice"
		Blizzard
			level=1
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 1
			attack_roll_dice_sides = 12
			range="10 tile range."
			mcost=5
			desc="Creates a shard of ice that is launched towards the target and shatters on impact. If an enemy has the 'Wet' status effect, applies 'Slow' on hit. Out of Battle Effects: This individual is capable of freezing or thawing a source of water they can touch up to 5ft in size. (Damage: 1d12+WIS ice damage | 10 tile range, Magical attack roll. -5 Mana.)"
		Blizzara
			level=2
			pre="Blizzard"
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 2
			attack_roll_dice_sides = 12
			range="3x3 AoE at a point within 10 tiles."
			atype="save"
			savetype="Reflex"
			mcost=20
			desc="The caster creates a shard of ice in the air, then crashing it down into the ground and releasing its cold temperature like a small nova. Out of Battle Effects: This individual is capable of freezing or thawing a source of water within a 60ft range and up to 10ft in size. They are capable of creating simple shapes out of ice. (Damage: 2d12+WIS ice damage | 3x3 AoE at a point within 10 tiles. Prompts a reflex saving throw, dealing full damage on a failure, or half as much on a success.) Costs 20 MP."
		Blizzaga
			level=3
			pre="Blizzara"
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 3
			attack_roll_dice_sides = 12
			mcost=30
			range="5x5 AoE at an epicenter within 10 tiles."
			desc="A large crystal of ice is formed above a medium sized area. It then crashes down to explode, sending freezing chunks of ice at any creature within its range. Creatures who are hit, and have the 'wet' status effect have 'Slow' applied to them. Out of Battle Effects: This individual is capable of freezing or thawing a source of water within a 80ft range and up to 15ft in size. They are capable of creating most shapes out of ice. (Damage: 3d12+WIS ice damage | 5x5 AoE at an epicenter within 10 tiles, Magical attack roll. -30 Mana.)"
		Blizzaja
			level=4
			pre="Blizzaga"
			basecheck=14
			atype="save"
			savetype="Reflex"
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 5
			attack_roll_dice_sides = 12
			mcost=45
			range="5x5 AoE at a point in view."
			desc="An ancient runic circle forms under the target, upon activation it pelts the area with hundreds of sharp snowflakes, and a truly chilling breeze. Creatures with the 'Wet' status effect who fail the saving throw are also afflicted with 'Slow'. Out of Battle Effects: This individual is capable of freezing or thawing a source of water within a 100ft range and up to 25ft in size. They are capable of creating intricate shapes out of ice. (Damage: 5d12+WIS ice damage | 5x5 AoE at a point in view, prompts a Fortitude saving throw ; dealing full damage, and inflicting 'Frostbite' on a failure, or half damage on a success. -45 Mana.)"
		Freeze
			level=5
			pre="Blizzaja"
			basecheck=15
			atype="save"
			savetype="Fortitude"
			mcost=65
			desc="The air around the user grows. Extremely cold creatures in the area start to see their breath and see ice particles form all around them covering the ground with a blanket of snow. Affects an 8 tile range around the user. Creatures starting their turn in the area of effect must make a fortitude saving throw or be rendered frozen. When frozen, creatures are unable to move and cannot use bonus actions or reactions. They take 1d12 Ice damage for each turn frozen, and receive critical damage from fire based damage, with the first instance of fire damage they take dethawing them. If the caster of Freeze stops sustaining the Freeze ability, all frozen creatures are dethawed. Passive: This person's Ice Magic may now take on the form of 'Sheer Frost' - allowing them to spend 8 MP in order to prompt a DC 20 Fortitude saving throw on any instance of Ice damage that they cause, inflicting 'Frosbite' on failure. (-65 mana, 10 per turn sustained.)"
	Flame
		element="Fire"
		icon='Icons/Perk/Fire.png'
		Fire
			level=1
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 1
			attack_roll_dice_sides = 12
			range="10 tile range."
			mcost=5
			desc="A small and simple ball of fire that is launched towards the target. On hit, prompts a DC 12 Fortitude saving throw, applying 'Burn' on failure. Out of Battle Effects: This individual is capable of ignite an object within 5ft of themselves. They can spread a fire within view 5ft in any direction. (Damage: 1d12+WIS fire damage | 10 tile range, Magical attack roll. -5 Mana.)"
		Fira
			level=2
			pre="Fire"
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 2
			attack_roll_dice_sides = 12
			mcost=15
			range=" 10 tile range, 3x3 sized projectile."
			desc="A medium sized ball of fire that when launched explodes on impact. On hit, prompts a Fortitude saving throw. On a failure, creatures take an additional 1d10 fire damage, and are afflicted with 'Burn'. Out of Battle Effects: This individual is capable of igniting or extinguishing an object within 30ft of themselves. They can spread a fire within view 5ft in any direction. (Damage: 2d12+WIS fire damage | 10 tile range, 3x3 sized projectile. Magical attack roll. -15 Mana.)"
		Firaga
			level=3
			pre="Fira"
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 3
			attack_roll_dice_sides = 12
			range=" 10 tile range, 3x3 sized projectile."
			mcost=30
			desc="A large fireball is launched towards the target, with hissing flames. It explodes on contact with its target location. Creatures who are hit by the fire-ball must make a Fortitude saving throw (DC 18) or take an additional 3d12 fire damage, and be afflicted with 'Burn'. Out of Battle Effects: This individual is capable of igniting or extinguishing an object within 50ft of themselves. They can spread a fire within view 10ft in any direction. (Damage: 3d12+WIS fire damage | 10 tile range, 3x3 sized projectile. Magical attack roll. -30 Mana.)"
		Firaja
			level=4
			pre="Firaga"
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 6
			attack_roll_dice_sides = 12
			mcost=45
			atype="save"
			savetype="Reflex"
			basecheck=14
			range=" 5x5 AoE at a point in view."
			desc="An ancient runic circle forms under a target before superheating the area and erupting in a powerful column of flame. Out of Battle Effects: This individual is capable of igniting or extinguishing an object within 60ft of themselves. They can spread a fire within view 20ft in any direction. (Damage: 6d12+WIS fire damage | 5x5 AoE at a point in view, prompts a Reflex saving throw ; dealing full damage, and inflicting 'Burn' on a failure, or half damage on a success. -45 Mana.)"
		Ardor
			level=5
			pre="Firaja"
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 7
			attack_roll_dice_sides = 12
			mcost=70
			range=" 5x5 AoE in view."
			desc="A sphere of flame is created growing larger and larger until it reaches its apex size. The sphere is superheated, burning so hot it turns blue in color before erupting into a cyclone of searing heat. Out of battle effects: The user is capable of superheating any source of fire, doubling the damage caused by environmental fire damage, and turning the fire blue. Passive: This person's Fire Magic may now take on the form of 'Blue Fire' - allowing them to spend 8 MP to add 2d12 fire damage to any instance of Fire damage that they deal, as an incidental action. (Damage: 7d12+WIS fire damage | Targets a 5x5 AoE in view, Magical attack roll. Inflicts 'Burn' on hit. -70 Mana.)"
	Lightning
		element="Thunder"
		icon='Icons/Perk/Thunder.png'
		Thunder
			level=1
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 1
			attack_roll_dice_sides = 12
			mcost=5
			range=" 10 tile range"
			desc="Above the target, the aether becomes volatile before a bolt of lightning forms and arcs down towards the target. Creatures affected with 'Wet' prompt this attack roll to gain +3 to hit. Out of Battle Effects: This individual is capable of generating or taking an electrical charge from an object they touch. They can sense whether an object has an electrical charge or not. (Damage: 1d12+WIS thunder damage | 10 tile range, Magical attack roll. -5 Mana.)"
		Thundara
			level=2
			pre="Thunder"
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 2
			attack_roll_dice_sides = 6
			range=" 10 tile range"
			mcost=15
			desc="The aether above the target becomes volatile before bolts of electricity arc down towards the target, jumping from one to the next. Deals the same damage to one additional target so long as they are inflicted with 'Wet' and within 3 tiles of the original target. Out of Battle Effects: This individual is capable of generating or taking an electrical charge from an object within 30ft. They can sense whether an object has an electrical charge or not. (Damage: 2d6+WIS thunder damage | 10 tile range, 1 magical attack roll -15 Mana.)"
		Thundaga
			level=3
			pre="Thundara"
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 4
			attack_roll_dice_sides = 10
			range=" 10 tile range."
			mcost=30
			desc="The aether above the target becomes volatile before a massive, spear-like bolt of lightning strikes down upon a target. On hit, a creature must succeed a DC 15 Fortitude saving throw, or suffer from the 'Paralyze' status effect. This attack has a +3 to hit against creatures with 'Wet' applied to them. (Damage: 4d10+WIS thunder damage | 10 tile range, Magical attack roll. -30 Mana.)"
		Thundaja
			level=4
			pre="Thundaga"
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 5
			attack_roll_dice_sides = 12
			range=" 5x5 AoE at a point in view."
			atype="save"
			savetype="Reflex"
			basecheck=14
			desc="An ancient runic circle forms above a target. Upon activation powerful bolts of lighting strike the area. Creatures with the 'Wet' status effect suffer disadvantage on this saving throw. In addition, a creature with 'Wet' releases a bolt of lightning with a 17 to hit against any creature within 3 tiles of them, dealing 2d12 additional thunder damage on a successful hit. (Damage: 5d12+WIS thunder damage | 5x5 AoE at a point in view, prompts a Reflex saving throw ; dealing full damage, and inflicting 'Paralyze' on a failure, or half damage on a success. -45 Mana.)"
	Energy
		element="Flare"
		icon='Icons/Perk/Flare.png'
		Flare
			level=4
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 6
			attack_roll_dice_sides = 10
			mcost=45
			range=" 3 tile wide, 6 tile long line."
			desc="Magic is concentrated into dense glowing spheres around a target. The spheres of raw Mana bulge and spark before exploding outward into a small nova. (Damage: 6d10+WIS force damage | Magical attack roll, ignores up to 10 magical DR. -45 Mana.)"
		Scathe
			level=5
			pre="Flare"
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 9
			attack_roll_dice_sides = 10
			range=" 5 tile wide, 10 tile long wave."
			atype="save"
			savetype="Fortitude"
			basecheck=16
			mcost=70
			desc="The user creates a disc of concentrated magic in front of them. The disc grows larger, sparking with energy until it is released forward in the form of a massive, and powerful beam. (Damage: 9d10+WIS force damage | 5 tile wide, 10 tile long wave. Prompts a Fortitude saving throw, dealing full damage on a failure, and half on a success. Ignores up to 15 points of damage reduction. -70 mana.)"
		FlareStar
			name="Flare Star"
			level=5
			pre="Scathe"
			cat="Unique"
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 10
			attack_roll_dice_sides = 8
			mcost=90
			range=" 10 tile range."
			desc="The user creates 5 spheres of searing energy around a target in range. The spheres ascend upwards combining into a single projectile that flies downwards and impacts against the target creating a powerful explosion. (Damage: 10d8+WIS force damage | Single target, Magical attack roll. Ignores all damage reduction. -90 mana.)"
		Megaflare
			icon='Icons/Perk/Megaflare.png'
			level=6
			pre="Scathe"
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 10
			attack_roll_dice_sides = 12
			range=" 5 tile wide, 15 tile long wave."
			atype="save"
			savetype="Reflex"
			basecheck=18
			mcost=120
			desc="The user forms a sphere of energy in their hand. The sphere is charged until it radiates a blue glow surging with energy. It is then fired in front of the user, meant to obliterate most conventional forms of protective magic and destroy the chosen target without mercy. (Damage: 10d12+WIS force damage | 5 tile wide, 15 tile long wave. Prompts a Reflex saving throw, dealing full on a failure, or half on a success. Ignores the effects of reflect or shell, and up to 30 points of DR. -120 mana)"
		Ultima
			element="Ultima"
			icon='Icons/Perk/Ultima.png'
			level=6
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 40
			attack_roll_dice_sides = 10
			desc="The ultimate magic ability. The user unleashes everything they have in a powerful magical explosion. The spell uses up all the users mana dealing 1d10 force damage, and growing in range by 1 tile for every 10 mana consumed to cast the spell (max of 40d10 at 400 Mana spent). Targets caught in the effect must succeed a Reflex saving throw (DC 26) or take the full damage ; taking only half on a successful save. (Drain: 100% of current Mana. Adds 3 stacks of exhaustion to caster.)"
	Other
		Meltdown
			element="Fire"
			icon='Icons/Perk/Meltdown.png'
			level=5
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 3
			attack_roll_dice_sides = 8
			range=" 5x5 AoE in view. 3 Saves."
			atype="save"
			basecheck=14
			savetype="Reflex"
			desc="The user churns an area of the ground heating it and turning it into a molten crater of magma. They then cause the area to erupt firing molten debris. The first attack manifests as Fire, the second manifests as molten rock, and the third as scorching winds. Each element has a different associated status effect: Fire: Burn Earth: Heavy Wind: Bleed (Damage: 3d8+WIS fire/earth/wind | 5x5 AoE in view. Prompts 3 Reflex saving throws, one for each element. On a failure, take full damage and be inflicted with that element's status effect. On a success, take half damage. -70 mana.)"
		Apocalypse
			element="Dark"
			icon='Icons/Perk/Apocalypse.png'
			level=6
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 4
			attack_roll_dice_sides = 10
			range=" 5x5 AoE within 8 tiles."
			desc="The user casts a glyph onto the ground. The glyph is a dark purple color with a sinister energy. Targets in the AoE feel an unsettling energy.  Targets in the AoE have 20 mana siphoned from them to form a ball of energy in the sky that explodes, raining down bursts of energy onto the targeted area. The attack makes an attack roll in the area for each individual who had Mana sapped. (Damage: 4d10+WIS force damage | 5x5 AoE, magical attack roll. -120 mana.)"
