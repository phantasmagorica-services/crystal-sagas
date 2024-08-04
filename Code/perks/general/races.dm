/obj/perk/Raceperks
	ptype="general"

/obj/perk/Raceperks/Human
	icon='Icons/Perk/Human.png'

/obj/perk/Raceperks/Human/Willtoovercome
	name="The Will to Overcome"
	desc="A humans Will is one of their most admirable traits, nigh impossible to break for some. They can use this willpower to overcome weak levels of mind control however this only works once. Additionally, they can instead overcome one status ailment. This effect can only be activated once per encounter, instance, or dungeon. This only applies to mortal-level mind control, i.e. from creatures such as Mindflayers. It does not apply to Mind Control or things inflicted by Unique perks such as Body of Sin, Embodiment of Sin, Fal'Cie, L'Cie, or anything similar to them."

/obj/perk/Raceperks/Human/Humandetermination
	name="Human Determination"
	desc="This person is determined, they’ve set their goals and will stop at nothing to achieve this. They get a short burst of inspiration to help push them towards their goals. This allows them to add +5 to a single roll. It can only be used once per encounter, dungeon, or instance."
/obj/perk/Raceperks/Guado
	icon='Icons/Perk/Guado.png'

/obj/perk/Raceperks/Guado/Guadophysiology
	name="Guado Physiology"
	desc="Guado have extremely long arms, with sharp claw-like hands. They gain +1 tile attack range with all Melee weapons, and may use 'Guado Rend' as a bonus action, as a Melee Attack Roll scaling to STR, and dealing 1d8+STR damage on a successful hit. Guado also gain a +2 to WIS."

/obj/perk/Raceperks/Guado/Connectiontodeath
	name="Connection to Death"
	desc="Guado are immune to the 'Doom' status effect, and due to their latent connection to the Aether - may return a single individual from the Aether as an 'Unsent' by drawing on the connection and bonds they have formed with them. This may only be used once per lifetime."

/obj/perk/Raceperks/Guado/GuadoRend
	name="Guado Rend"
	desc="A Guado attacks with their sharp fingers. This ability is a Bonus Action. Scales to Strength."
	ability=1
	mcost=5
	basecheck=10
	attack_roll_damage_dice = FALSE
	attack_roll_damage_lower = 1
	attack_roll_damage_upper = 8
	adddam=2
	addhit=1
	range="Melee"
	ability=1
	costtype="Stamina"
	atype="standard"
	damsource="str"
	typing="physical"
	ptype="spell"

/obj/perk/Raceperks/Cyborg
	icon='Icons/Perk/Cyborg.png'

/obj/perk/Raceperks/Cyborg/Manacore
	name="Mana Core"
	desc=" A Cyborg has Magitek technology within them, somewhere in their body - powered by a Magitek Core. This core grants them +40 MP, and also increases the damage of Magical attacks by +5."

/obj/perk/Raceperks/Cyborg/Cyberneticresilience
	name="Cybernetic Resilience"
	desc="A Cyborg has a much more sturdy body than a normal organism, and therefore gains +3 global damage reduction, as well as +1 AC."

/obj/perk/Raceperks/Miqote
	icon='Icons/Perk/Miqote.png'

/obj/perk/Raceperks/Miqote/Felinegrace
	name="Feline Grace"
	desc="Miqo’te when falling are almost sure to land more gracefully than any other race, granting them a reduced damage to falling. 10 damage reduced per tier of reflex when calculating fall damage."

/obj/perk/Raceperks/Miqote/Miqoteagility
	name="Miq'ote Agility"
	desc="This race is well known for its feline traits, they can use their agility to avoid large area of attacks more easily than other races. Miqo’te gain advantage on reflex saving throws."

/obj/perk/Raceperks/Gnath
	icon='Icons/Perk/Gnath.png'

/obj/perk/Raceperks/Gnath/Layeredmuscle
	name="Layered Muscle"
	desc="Gnath are typically very physically inclined creatures giving the creature +20 total HP and +2 to Strength."
/obj/perk/Raceperks/Gnath/Exoskeleton
	name="Exo Skeleton"
	desc="Gnath have a extremely tough shell that protects their gooey insides. They can harden this in extreme moments, allowing them to reduce the total damage taken in a turn by 10. This however can't reduce an attack below half damage, and goes on a 3 turn cooldown once used."
/obj/perk/Raceperks/Gnath/Carapaceofravana
	name="Carapace of Ravana"
	desc="Once Gnath have gathered enough ritualistic sacrifice, they can preform a ritual to their god Ravana. Typically the sacrifice can range in terms of vices of victory gathered from beasts that have been defeated, powerful magical items, and extreme degrees of gil. If Ravana respects your sacrifice he will grant you with an advanced carapace allowing you two additional arms. (This grants you an extra Weapon attack whenever making the first Weapon Attack on a turn.)"

/obj/perk/Raceperks/Ronso
	icon='Icons/Perk/Ronso.png'

/obj/perk/Raceperks/Ronso/NatureLore
	name="Nature Lore"
	desc="Ronso have a deep connection with nature, and understand monsters well. Ronso may gain an amount of BLU abilities from the BLU spell list equal to that of a BLU mage, even without choosing the class."

/obj/perk/Raceperks/Ronso/RonsoResilience
	name="Ronso Resilience"
	desc="Ronso, due to their connection with Ixion, the Stormhorse - have tempered their body throughout the ages against lightning and electricity. Ronso have resistance to Thunder damage."

/obj/perk/Raceperks/Namazu
	icon='Icons/Perk/Namazu.png'

/obj/perk/Raceperks/Namazu/Thebigoneswisdom
	name="The Big One's Wisdom"
	desc="Namazu are gifted with great inner wisdom, and emotional clarity. As a result, Namazu gain +2 WIS, +20 MP, and +1 to all Magical Attack Rolls."

/obj/perk/Raceperks/Namazu/Craftergatherer
	name="Crafter Gatherer"
	desc="The Namazu are most well known for their roles as crafters, and gatherers. Namazu get a latent +5 Gathering nodes, daily. They can also naturally Mastercraft weapons made by themselves and others, enhancing their Power and Hit by + if done."

/obj/perk/Raceperks/Viera
	icon='Icons/Perk/Viera.png'

/obj/perk/Raceperks/Viera/Bunnyears
	name="Bunny Ears"
	desc="Viera have an amazing sense of hearing and thusly can not be snuck up on. The slightest sound is easy captured within a range. Anything moving that is capable of making sound no matter how quiet, can be heard within 3 tiles of this person in all directions. This adversely can’t be used against them, as they can deafen their hearing when needed."

/obj/perk/Raceperks/Viera/Rabbitlegs
	name="Rabbit Legs"
	desc="This race has very strong legs, even at birth. When they begin their turn on solid ground, they can jump up to 2 additional tiles amidst movement in any direction for 10 SP. In addition, Viera take 20 less points of fall damage."

/obj/perk/Raceperks/Lalafell
	icon='Icons/Perk/Lalafell.png'

/obj/perk/Raceperks/Lalafell/Naturalenchanters
	name="Natural Enchanters"
	desc="Lalafell are known for their amazing enchanting skills, and averagely craft enchanted items with less practice and more ease then other races. Lalafell start with T3 Enchantment. Enchanting also does not take up one of their crafting slots."

/obj/perk/Raceperks/Lalafell/Pintsize
	name="Pint Size"
	desc="Lalafells are very tiny compared to the other races and have an easier time getting into small places, they can occupy the same tile as another person and if the willing person whom the Lalafell is sharing a tile with wants, they can be a shield and take half of the damage from an attack for the Lalafell. Lalafell gain a +2 to WIS."

/obj/perk/Raceperks/Roegadyn
	icon='Icons/Perk/Roegadyn.png'

/obj/perk/Raceperks/Roegadyn/Naturalsmithy
	name="Natural Smithy"
	desc="Roegadyn are adept at smithing and generally take it up at a young age. They can choose armor or weaponsmithing in creation without it taking a slot and start at T2."

/obj/perk/Raceperks/Roegadyn/Roegadynstrength
	name="Roegadyn Strength"
	desc="This person can lift, push, pull, etc with incredible strength and efficiency. This does not translate to combat strength, however they can use this to their advantage in combat to move debris or obstacles on the field. Roegadyn gain a +2 to their Strength score."

/obj/perk/Raceperks/Elezen
	icon='Icons/Perk/Elezen.png'

/obj/perk/Raceperks/Elezen/ElezenPhysiology
	name="Elezen Physiology"
	desc="The Elezen's characteristically tall, slim physiques and elongated limbs are part of a successful adaptation to the land's various environments. It is said that their highly sensitive ears can discern the squeak of a field mouse at a distance of up to several malms. Elezen gain +2 to DEX and advantage on any rolls that effect or are affected by their hearing."

/obj/perk/Raceperks/Elezen/LifestreamsGift
	name="Lifestream's Gift"
	desc="Elezen have a latent connection to the life-stream. This grants them innate understanding of to safely manipulate Mako and allows all Elezen to have Materia Melder latently. This connection to the life-stream also enhanced all healing abilities and spells used by the Elezen to heal by an additional +5 HP, gifting additional vigor to those they heal."

/obj/perk/Raceperks/AuRa
	icon='Icons/Perk/Au Ra.png'

/obj/perk/Raceperks/AuRa/CranialProjections
	name="Cranial Projections"
	desc="An Au Ra's horns are directly connected to their brain serving as a powerful sensory organ that can allow them to perceive the normally unperceivable. An Au Ra can sense anything within a 4 tile radius regardless of whether it is invisible or underground. This also makes Au Ra's nearly impossible to sneak up on as they will sense everything within their radius."

/obj/perk/Raceperks/AuRa/PreemptiveInstincts
	name="Preemptive Instincts"
	desc="An Au Ra knows when it is time to strike. Years of war have built in instincts into the Au Ra's being given them an almost paranormal sense of when a battle is about to start. When a battle begins Au Ra have +1 initiative, and a +1 attack bonus to Physical Attacks."

/obj/perk/Raceperks/Albhed
	icon='Icons/Perk/Albhed.png'

/obj/perk/Raceperks/Albhed/MasterMachinist
	name="Master Machinist"
	desc="Al-Bhed start with the 'Initiate Roboticist' and 'Basic Machina Weaponsmith' perks, irregardless of job."

/obj/perk/Raceperks/Albhed/CriticalThinker
	name="Critical Thinker"
	desc="This Al-Bhed has looked at a machine and assessed its build, they know all of the weak points it might have or even the weakest point and can deal double damage to any type of machine."

/obj/perk/Raceperks/Albhed/Pilot
	name="Pilot"
	desc="Al-Bhed are undeniably smart and thusly can drive any machine put in front of them."

/obj/perk/Raceperks/Moogle
	icon='Icons/Perk/Moogle.png'

/obj/perk/Raceperks/Moogle/Mooglepower
	name="Moogle Power"
	desc="Moogles naturally have higher magical reserves, granting them +50 flat MP on creation."

/obj/perk/Raceperks/Moogle/Cutething
	name="Cute Thing"
	desc="Moogles are very cute things! They have advantage on all persuasion, and Charisma checks for the sake of social interaction, Kupo!"

/obj/perk/Raceperks/Gria
	icon='Icons/Perk/Gria.png'

/obj/perk/Raceperks/Gria/Innerstrength
	name="Inner Strength"
	desc="Once per encounter, Gria are able to channel their inner strength to impose advantage on a single roll."

/obj/perk/Raceperks/Gria/Griastamina
	name="Gria Stamina"
	desc="Gria are somewhat more resilient than other races, gaining +10 HP on creation, as well as 1 flat impenetrable damage reduction from all sources."

/obj/perk/Raceperks/Cetra
	icon='Icons/Perk/Cetra.png'

/obj/perk/Raceperks/Cetra/AncientPower
	name="Ancient Power"
	desc="Cetra are imbued with a latent, and potent connection to the Lifestream. They are naturally peaceful, but hold immense strength within. Cetra gain +20 HP, and +20 MP as well as +2 to hit on all Magical Attack rolls."

/obj/perk/Raceperks/Cetra/VoiceofAncients
	name="Voice of the Ancients"
	desc="A Cetra is capable of communicating with the life-stream itself. As such, they have an increased ability to perceive the world around them. Cetra can passively sense any creature within 10 tiles of them, and sneak attack can not apply to them. They also have advantage on Perception checks."

/obj/perk/Raceperks/Cetra/PrayerofPower
	name="Prayer of Power"
	desc="Cetra are capable of borrowing the lifestream's power more reliably than anyone else. As a result, they may spend an additional 10 MP in order to empower a spell or ability, adding +2 to any of its DC checks, +2 to its hit roll, or to add 2d12 to any healing or damage it deals."

/obj/perk/Raceperks/Genome
	icon='Icons/Perk/Genome.png'

/obj/perk/Raceperks/Genome/Lifestreamconnection
	name="Lifestream Connection"
	desc="Similar to Cetra, Genome are inherently linked to the Lifestream, just in a different way. Being artificial souls created entirely by the lifestream, they have very little sense of urgency as they know they will one day join it again, and be recycled into the cycle of rebirth. While they are alive however, their Lifestream energy is quite potent, gaining them +2 to all physical ability scores (STR, DEX, CON), and luminescent green eyes."

/obj/perk/Raceperks/Golem
	icon='Icons/Perk/Golem.png'

/obj/perk/Raceperks/Golem/Aetherconnection
	name="Aether Connection"
	desc="Adverse to Genome, Golem too are usually lacking of a sense of urgency as they understand their souls will one day be filtered through the Aether crystal. Their connection grants them higher magical potency, as opposed to physical ; granting them +2 to all mental ability scores (INT, WIS, CHA.)"
