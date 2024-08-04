/obj/perk/Abilities/GreenMagic
	typing="magical"
	magicneed="Green Magic"
	atype="standard"

	Barelement
		mcost=15
		level=2
		rpcost=2
		Barwater
			greenmagic=1
			statuseffect="Barwater"
			icon='Icons/Perk/Barwater.png'
			desc="The user concentrates their magic into a blue orb. The blue orb is attuned to water magic and can completely block one instance of water damage before being consumed. Lasts until the end of battle if not used. Range: View (-15 mana)"
		Barfire
			greenmagic=1
			statuseffect="Barfire"
			icon='Icons/Perk/Barfire.png'
			desc="The user concentrates their magic into a red orb. The red orb is attuned to fire magic and can completely block one instance of fire damage before being consumed. Lasts until the end of battle if not used. Range: View (-15 mana)"
		Barblizzard
			greenmagic=1
			statuseffect="Barblizzard"
			icon='Icons/Perk/Barice.png'
			desc="The user concentrates their magic into a white orb. The white orb is attuned to ice magic and can completely block one instance of ice damage before being consumed. Lasts until the end of battle if not used. Range: View (-15 mana)"
		Barthunder
			greenmagic=1
			statuseffect="Barthunder"
			icon='Icons/Perk/Barthunder.png'
			desc="The user concentrates their magic into a yellow orb. The yellow orb is attuned to thunder magic and can completely block one instance of thunder damage before being consumed. Lasts until the end of battle if not used. Range: View (-15 mana)"
		Baraero
			greenmagic=1
			statuseffect="Baraero"
			icon='Icons/Perk/Barwind.png'
			desc="The user concentrates their magic into a green orb. The green orb is attuned to wind magic and can completely block one instance of wind damage before being consumed. Lasts until the end of battle if not used. Range: View (-15 mana)"
		Barstone
			greenmagic=1
			statuseffect="Barstone"
			icon='Icons/Perk/Barstone.png'
			desc="The user concentrates their magic into a brown orb. The brown orb is attuned to earth magic and can completely block one instance of earth damage before being consumed. Lasts until the end of battle if not used. Range: View (-15 mana)"
	Bravery
		greenmagic=1
		statuseffect="Bravery"
		icon='Icons/Perk/Brave.png'
		mcost=30
		desc="The user through physical contact is able to cast a spell on the target that inflicts the brave status. This lasts four turns. Range: 6 tiles. (- 30 Mana.)"
		level=3
	Faith
		greenmagic=1
		statuseffect="Faith"
		icon='Icons/Perk/Faith.png'
		level=3
		mcost=30
		desc="The user through physical contact is able to cast a spell on the target that inflicts the faith status. This lasts four turns. Range: 6 tiles. (-30 Mana)"
	Haste
		greenmagic=1
		statuseffect="Haste"
		icon='Icons/Perk/Haste.png'
		mcost=30
		desc="The user through physical contact is able to cast a spell on the target that inflicts the haste status. This lasts two turns. Range: 6 tiles. (- 30 Mana.)"
		level=3
	Bubble
		greenmagic=1
		statuseffect="Bubble"
		icon='Icons/Perk/Bubble.png'
		mcost=30
		level=3
		desc="The user forms a bubble around a target in range, granting them the bubble status. Lasts for four turns. Range: 6 tiles. (- 30 Mana.)"
	Safes
		icon='Icons/Perk/Safe.png'
		Safe
			greenmagic=1
			statuseffect="Safe"
			level=4
			mcost=25
			desc="The user applies a protective seal to the target in question, meant to ward off curses and malicious attacks upon one's wellbeing. This applies the 'Safe' status effect to the target creature. Range: View (-25 Mana.)"
		Safega
			level=5
			pre="Safe"
			greenmagic=1
			multi=1
			statuseffect="Safe"
			mcost=60
			desc="The user releases a multitude of protective seals to their party, meant to ward off curses and malicious attacks upon one's wellbeing. This applies the 'Safe' status effect to the entire party. Range: View (-60 Mana.)"
	Protects
		icon='Icons/Perk/Protect.png'
		Protect
			greenmagic=1
			statuseffect="Protect"
			level=1
			mcost=10
			desc="The user focuses their magic around an individual in range. Forming a barrier against physical damage. Grants protect for 4 turns. 6 tile range. (-10 mana)"
		Protectga
			greenmagic=1
			statuseffect="Protect"
			multi=1
			level=4
			pre="Protect"
			mcost=40
			desc="Spreads a magical aura from the user that grants them, and anyone directly around them with the protect status. Grants all friendly targets within 10ft of the user protect. Lasts for 4 turns. Range: 6 tiles. (-40 mana.)"
	Shells
		icon='Icons/Perk/Shell.png'
		Shell
			greenmagic=1
			statuseffect="Shell"
			level=1
			mcost=10
			desc="The user focuses their magic around an individual in range, forming a barrier against magical damage. Grants Shell for 4 turns. 6 tile range. (-10 mana)"
		Shellga
			greenmagic=1
			statuseffect="Shell"
			level=4
			pre="Shell"
			multi=1
			mcost=40
			desc="Spreads a magical aura from the user that grants them, and anyone directly around them with the shell status. Grants all friendly targets within 10ft of the user shell. Lasts for 4 turns. Range: 6 tiles. (-40 mana.)"
	Dualprotection
		icon='Icons/Perk/Dualprotection.png'
		Stoneskin
			greenmagic=1
			statuseffect="Stoneskin"
			level=3
			mcost=30
			desc="The user casts magic over a target causing a hardened layer of skin to form over them. Grants +25 temp HP with a boost of 5 DR as long as the user has temp HP. Lasts for 5 rounds. Range: 6 tiles. (-30 mana.)"
		Stoneskinga
			level=5
			greenmagic=1
			multi=1
			mcost=40
			statuseffect="Stoneskin"
			pre="Stoneskin"
			desc="The user gives off a burst of magic that forms around all friendly targets around the user giving each of them +25 temp HP. As long as they have temp HP they receive +5 DR. Lasts for 5 rounds.. Range: View (-40 mana)"
	Refresh
		icon='Icons/Perk/Refresh.png'
		greenmagic=1
		statuseffect="Refresh"
		level=4
		mcost=40
		desc="The user applies a seal stored with a large amount of magic meant to draw magical energy from the environment into the target. Grants 'Refresh' to the target. Range: 6 tiles. (-40 mana.)"
	Barrier
		icon='Icons/Perk/Barrier.png'
		Pailing
			greenmagic=1
			statuseffect="Pailing"
			multi=1
			level=6
			mcost=80
			pre="Protectga"
			desc="The user erects a spherical barrier that stops any physical attack no matter how powerful. This technique takes a large amount of mana to sustain not being able to last very long. The bigger the user makes the barrier the more mana it takes to sustain. Creates a radial barrier that nullifies all physical attacks from passing through. Hostile creatures can not enter the barrier, and are halted by it. (Costs 20 mana per turn to sustain per tile radius.)"
		MagicBarrier
			greenmagic=1
			statuseffect="Magic Barrier"
			multi=1
			name="Magic Barrier"
			level=6
			mcost=80
			pre="Shellga"
			desc="The user erects a spherical barrier that stops any magical attack no matter how powerful. This technique takes a large amount of mana to sustain not being able to last very long. The bigger the user makes the barrier the more mana it takes to sustain. Creates a radial barrier that nullifies all magical attacks from passing through. (Costs 20 mana per turn to sustain per tile radius.)"
