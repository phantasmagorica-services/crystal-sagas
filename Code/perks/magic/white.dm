/obj/perk/Abilities/WhiteMagic
	magicneed="White Magic"
	damsource="cha"
	costtype="Mana"
	atype="standard"
	basecheck=10
	typing="magical"
	element="Heal"

	Healing
		atype="heal"
		heal=1
		icon='Icons/Perk/Cure.png'
		Cure
			level=1
			adddam = 10
			mcost=10
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 1
			attack_roll_dice_sides = 8
			desc="The user has learned to treat simple wounds through magic. They can cure 10 + 1d8 + CHA Mod x 2 HP. Out of Battle Effects: This user can cure cuts, scrapes, bruises, and burns. They can use magic to restore vitality in small plants such as flowers and 5ft patches of foliage. (-10 mana.)"
		Cura
			level=2
			adddam = 15
			pre="Cure"
			mcost=15
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 2
			attack_roll_dice_sides = 12
			desc="The user has learned how to use magic to cure moderate wounds. They can cure 15 + 2d12 + CHA Mod x 2 HP. Out of Battle Effects: The user is capable of healing open wounds, set broken bones, and even cure up to third degree burns instantly. They can rejuvenate medium sized plants such as bushes or ferns, or a 10ft patch of grass. (-15 Mana.)"
		Curaga
			level=3
			revive=1
			adddam=20
			pre="Cura"
			mcost=30
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 3
			attack_roll_dice_sides = 12
			desc="The user has learned how to heal major wounds through the use of magic. Heals  20 + 3d12 + CHA Mod x 2 HP. 6 tile range. Out of Battle Effects: The user is able to reattach limbs that have been severed, cure major wounds that even stitches wouldn’t fix, heals all types of burns. They can also rejuvenate large plants including young trees, and patches of foliage up to 20ft. (-30 Mana.)"
		Curaja
			level=4
			revive=1
			adddam=30
			pre="Curaga"
			mcost=40
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 4
			attack_roll_dice_sides = 12
			desc="The user has learned how to heal even the most dire wounds. They heal 30 + 4d12 HP + CHA Mod x 2. 6 tile range. Out of Battle Effects: The user is capable of restoring limbs as long as the wound has not healed over. They can set and instantly heal broken bones, and can cure even the deepest burns. They can rejuvenate mature trees and patches of foliage up to 30 ft. (-40 Mana.)"
		Curada
			revive=1
			level=5
			atype="curada"
			pre="Curaja"
			mcost=65
			desc="The user has learned to pour everything they have to heal others. They can perform miracles with their healing and upon touching a target can restore nearly all their wounds, curing them of up to half their Max HP + 2d10 + CHA Mod x 2. This leaves the white mage exhausted, giving them 1 stacks of exhaustion per usage. Melee range. (-65 mana.)"
		Regen
			heal=0
			greenmagic=1
			statuseffect="Regen"
			level=3
			pre="Cura"
			desc="The user embeds a seal stored with a large amount of magic meant to release slowly over time healing wounds as they appear. Grants 'Regen'. (- 30 Mana.)"
		Asylum
			heal=0
			level=4
			pre="Regen"
			greenmagic=1
			statuseffect="Regen"
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 2
			attack_roll_damage_upper = 10
			multi=1
			desc="The user casts a sphere of magic that expands into a glittering dome upon reaching its target. Asylum covers a 3x3 area. Any friendly creature inside the asylum while it is active heals for 2d10 HP at the beginning of each turn. Any time a friendly creature is healed by a healing spell aside from Asylum, while inside the asylum they gain a bonus of +10 to the healing effect. Only 1 asylum can be activated by a user at a time. Asylums by different casters cannot overlap. Lasts for 4 turns. (-50 mana.)"
		Sacrifice
			heal=1
			level=5
			desc="The user touches another, and utilizing the immense power of sacrifice ; instills their remaining vitality and mana into the target giving up their life, but granting the receiver a tremendous boost, granting their knowledge and power to them by infusing them with some of the essence of their very soul. (Fully restore HP , SP, and MP to the target, grant them temporary HP, SP, and MP equal to 50% of their maximum.  Pick 4 of your perks to transfer to the person permanently (including Job perks) (T3 max.). You die.)"
		Temperance
			heal=1
			level=5
			addhit=20
			desc="The user crystallizes their magic, forming angelic wings behind their back. Divine essence flows freely from them, blessing those within range who are in the creature's favor. While temperance is active the user heals a bonus 20 HP for each instance of healing. Friendly targets within 6 tiles of the user gain +5 to DR as long as the aura is active. Lasts for 4 turns. (- 65 mana.)"
		Arise
			revive=1
			multi=1
			heal=0
			level=6
			pre="Asylum"
			desc="The user calls out to the heavens using a tremendous amount of their magic to drag someone's soul back from the afterlife. This spell takes a long time to cast requiring two full turns to take effect. The soul also requires that their living body be in a livable state requiring the mage to heal any great wounds on the body. This also means that the body cannot be too decayed. (Revives another player at 100% HP if they have died within one OOC day of the spell being cast. - 100 Mana.)"
	Wind
		icon='Icons/Perk/Wind.png'
		element="Wind"
		Aero
			level=1
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 1
			attack_roll_dice_sides = 12
			range=" 6 tile range."
			addhit=1
			mcost=10
			desc="The user casts a blade of wind forward, to cut at a foe. As a reaction, this spell can be used to buffet fall damage, reducing it by 10 points. Out of Battle Effects: The user is capable of controlling wind to a small degree. They can cause air to vacate a 5ft area. They can also reduce the effects of fall damage by a degree of 10ft. (Damage: 1d12+CHA wind damage | 6 tile range, +1 to hit. -10 Mana.)"
		Aerora
			level=2
			pre="Aero"
			mcost=20
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 2
			attack_roll_dice_sides = 12
			range=" 6 tile range."
			addhit=1
			desc="The user casts forth a condensed ball of air that impacts a target before becoming a swirling vortex. As a reaction, this spell can be used to buffet fall damage - reducing it by 20 points. Out of Battle Effects: The user is capable of controlling wind to a small degree. They can cause air to vacate a 10ft area. They can also reduce the effects of fall damage by a degree of 20ft. They can cause the wind to make basic sounds that can be heard from 15ft away. (Damage: 2d12+CHA wind damage | 6 tile range, +1 to hit, Magic attack roll, 2 tile knockback. -20 Mana.)"

		Aeroga
			level=3
			pre="Aerora"
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 3
			attack_roll_dice_sides = 10
			range="6 tile line, 3 tiles wide."
			mcost=35
			desc="The user summons a whirlwind to travel forward sweeping away everything in it’s path until it makes contact with it’s target, sweeping them in a torrent of wind. This attack takes up a large area, with a straight line - threatening to indiscriminately rip and tear at anyone caught within its line of movement. As a reaction, this spell can be used to send the caster safely to the ground after being knocked into the air, reducing any fall damage from that elevation by 50 points. Out of Battle Effects: The user is capable of controlling wind to a small degree. They can cause air to vacate a 15ft area. They can also reduce the effects of fall damage by a degree of 40ft. They can cause the wind to make sounds that can be heard by individuals or cast a booming sound that can be heard 30ft away (Damage: 3d10+CHA wind damage | 6 tile line, 3 tile wide. Magic attack roll. Inflicts 'Bleed' on hit. -35 Mana.)."
		Aeroja
			level=4
			pre="Aeroga"
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 4
			attack_roll_dice_sides = 12
			range=" 8 tile range, 3 tiles wide."
			atype="save"
			savetype="Reflex"
			basecheck=14
			mcost=50
			desc="The user summons a powerful vortex around them. Sitting at the eye of the storm, while the winds kick up they hold out their hand and release the winds in a torrential wave of gale force, threatening to shred and push back anything in its wake. Out of Battle Effects: The user is capable of controlling wind to a masterful degree. They can cause air to vacate a 20ft area. They can also reduce the effects of fall damage by a degree of 80ft. They can cause the wind to make sounds that can be heard by individuals or cast a booming sound that can be heard a mile away. (Damage: 4d12+CHA wind damage | 8 tile range, 3 tiles wide. Prompts a Reflex saving throw, inflicting 3 tile knockback, 'Bleed', and full damage on a failure ; or taking half damage on a success. -50 Mana.)"
		Tornado
			level=5
			pre="Aeroja"
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 6
			attack_roll_dice_sides = 12
			atype="save"
			savetype="Reflex"
			basecheck=16
			range=" 5x5 AoE in view."
			mcost=70
			desc="A tornado is created within range starting with a small swirling of wind before erupting into a full cyclone. The Tornado can be moved up to 4 tiles a turn as a bonus action. If the Tornado moves into the range of a creature, they must make the saving throw for this ability. Passive: This person's Wind Magic may now take on the 'Galeforce' attribute, allowing them to spend 8 MP in order to inflict 1d12 additional wind damage, and prompt a DC 20 Fortitude saving throw to inflict the 'Squall' status effect on failure, to any instance of Wind damage they cause. (Damage: 6d12+CHA Wind damage | Targets a 5x5 AoE in view, prompts a Reflex saving throw ; dealing full damage, knocking a target back 3 tiles, and inflicting 'Bleed' on a failure ; or half damage on a success. -70 mana, 5 Mana per turn to sustain (may last up to a maximum of 5 turns.))"
	Holy
		element="Holy"
		icon='Icons/Perk/Dia.png'
		Dia
			level=2
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 2
			attack_roll_dice_sides = 10
			range=" 6 tile range."
			mcost=15
			desc="The user creates a ball of holy light thats cast forth as a projectile burning away any darkness in it’s path. The ball illuminates everything in it’s path up to 2 tiles away, and leaves a 1 tile area of light for 3 turns upon striking. Out of Battle Effects: The user is capable of creating lights through magic. They can cast light from themselves up to 10ft around them. Alternatively they can cast these lights up to 30ft sustaining up to 2 at a time. (Damage: 2d10+CHA holy damage | 6 tile range, -15 Mana.)"
		Diara
			level=3
			pre="Dia"
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 3
			attack_roll_dice_sides = 12
			range=" 6 tile range."
			mcost=30
			desc="The user casts forward a bright ball of light. The ball lights up everything in it’s path revealing objects in the darkness up to 2 tiles around everywhere it travels, and leaves a 3x3 area of light for 3 turns upon striking. Out of Battle Effects: The user is capable of creating lights through magic. They can cast light from themselves up to 20ft around them. Alternatively they can cast these lights up to 30ft sustaining up to 3 at a time. (Damage: 3d12+CHA holy damage | 6 tile range, Magic attack roll. -30 Mana.)"
		Diaga
			level=4
			pre="Diara"
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 4
			attack_roll_dice_sides = 10
			range=" 6 tile range."
			mcost=45
			desc="The user casts forward a bright ball of light. The ball lights up everything in it’s path revealing objects in the darkness up to 3 tiles from its center everywhere it travels, and leaves a 3x3 area of light for 3 turns upon striking. Out of Battle Effects: The user is capable of creating lights through magic. They can cast light from themselves up to 30ft around them. Alternatively they can cast these lights up to 30ft sustaining up to 4 at a time. (Damage: 4d10+CHA holy damage | 6 tile range, Magical attack roll, -45 Mana.)"
		SealEvil
			name="Seal Evil"
			level=4
			desc="A special seal is prepared. One that is meant to seal evil entities. The seal is cast forth and if it strikes an enemy with Holy weakness or Dark resistance the target must make a fortitude saving throw (DC 19), or suffer silence and paralysis for 3 turns. (-40 mana)"
		Holy
			level=5
			pre="Diara"
			attack_roll_damage_dice = TRUE
			attack_roll_dice_count = 8
			attack_roll_dice_sides = 10
			range=" 8 tile range."
			atype="save"
			savetype="Fortitude"
			basecheck=18
			mcost=65
			desc="The user calls to the gods above asking for their divine light and assistance. Light bathes their immediate area, and is released in the form of eight holy orbs that are flung towards a singular target in range, and aim to converge upon them. (Damage: 8d10+CHA holy damage |8 tile range, prompts a Fortitude saving throw (DC 14+CHA+Rank bonus), inflicting full damage and 1 stack of exhaustion on a failure, or half as much damage on a success. -65 mana.)"
	Dispel
		attack_roll_damage_dice = FALSE
		attack_roll_damage_lower = 0
		attack_roll_damage_upper = 0

		icon='Icons/Perk/Dispel.png'
		Dispel
			greenmagic=1
			dispel=1
			level=3
			range=" 6 tile range."
			mcost=30
			desc="The user casts forth a ball of cleansing light upon contact cleanses a target of any beneficial status effects, to even out the playing field.  Minor Dispel: Dispels one status effect (starting with the most recently attained effect.) (Magical attack roll, inflicts 'Minor Dispel' effect on hit. 0 Damage. -30 mana)"
		Dispelara
			greenmagic=1
			dispel=2
			level=4
			pre="Dispel"
			range=" 6 tile range."
			mcost=40
			desc="The user casts forth a bright cleansing light. Make a magical attack roll. On a successful attack roll, the target loses all beneficial status effects. (6 Tile range, magical attack roll, 0 damage. -40 Mana.)"
		Dispelga
			greenmagic=1
			multi=1
			dispel=2
			level=5
			pre="Dispelara"
			mcost=65
			atype="save"
			savetype="Fortitude"
			basecheck=16
			range="3x3 AoE"
			desc="The user casts forward a tightly packed ball of magic. Upon reaching its target the ball erupts, washing over everything in cleansing light. (6 tile range, 3x3 AoE ; prompts a Fortitude saving throw (DC 18) - dispelling all positive status effects on a failure. -65 mana.)"
	Status
		icon='Icons/Perk/StatusCleanse.png'
		Blindna
			level=1
			desc="The user has learned to cure the effects of the blind status effect. Out of Battle Effects: The user can cure an individual of less than perfect vision, and can even cure someone who is permanently blind with time. (-10 Mana.)"
		Vox
			level=1
			desc="The user has learned to cure the silence status effect. Out of Battle Effects: The user can cure an individual of mutism. (-10 Mana.)"
		Poisona
			level=1
			desc="The user has learned to cure the poison status effect. (-10 Mana.)"
		Stona
			level=2
			desc="The user has learned to cure someone of the break status effect. (-15 Mana.)"
		Toadna
			level=2
			desc="The user has learned to cure someone of the toad status effect.  Out of Battle Effects: The user is capable of determining whether a toad was originally a person or not. They can also understand the basic intentions of a toad. (-15 Mana.)"
		Minina
			level=2
			desc="The user has learned to cure someone of the mini status effect. (-15 Mana.)"
		Esuna
			heal=1
			cleanse=1
			level=3
			desc="The user prays to the ones above asking for a cleansing. A target of their choice is cleared of 1 negative status effect. (Starting with the newest). (- 30 mana.)"
		Esunara
			heal=1
			cleanse=1
			level=4
			pre="Esuna"
			desc="The user prays intensely for the cleansing of themselves or an ally. A friendly target within their range is cleansed of all negative status effects. 6 tile range. (-40 Mana.)"
		Esunaga
			heal=1
			cleanse=1
			level=5
			pre="Esunara"
			desc="The user leans down to pray baking the area around them in holy cleansing light. Friendly targets within a 3x3 area of the caster are cured of all negative status effects. (-65 mana.)"
