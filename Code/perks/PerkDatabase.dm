// todo: /datum/prototype/perk

/obj/perk
	var/element="Physical"
	var/heal=0
	var/cleanse=0
	var/monkability=0
	var/incompatible=null
	var/statuseffect
	var/infusiontype
	var/dispel=0
	var/revive=0
	var/greenmagic=0
	var/multi=0
	var/refresh=0

/obj/perk/New(loc)
	. = ..()
	if(src.rank=="T1")
		src.rpcost=1
	if(src.rank=="T2")
		src.rpcost=2
	if(src.rank=="T3")
		src.rpcost=3
	if(src.rank=="T4")
		src.rpcost=4
	if(src.rank=="T5")
		src.rpcost=5
	if(src.rank=="T6")
		src.rpcost=6
	if(src.rank=="E")
		src.rpcost=1
	if(src.rank=="D")
		src.rpcost=2
	if(src.rank=="C")
		src.rpcost=3
	if(src.rank=="B")
		src.addhit+=2
		src.basecheck+=1
		src.adddam+=15
		src.rpcost=4
	if(src.rank=="A")
		src.addhit+=3
		src.basecheck+=2
		src.adddam+=25
		src.rpcost=8
	if(src.rank=="S")
		src.addhit+=4
		src.basecheck+=3
		src.adddam+=40
		src.rpcost=16

obj
	perk
		ElementalPerks
			Fire
				icon='Icons/Perk/Fire.png'
				name="Fire Attuned"
				desc="This creature is attuned to the element of Fire. It is immune to the 'Burn' status effect, and takes half damage from fire and ice, but 2x damage from water and earth."
			Water
				icon='Icons/Perk/Water.png'
				name="Water Attuned"
				desc="This creature is attuned to the element of Water. It is immune to the 'Wet' and 'Whorl' status effects, and takes half damage from fire and water, but 2x damage from ice and wind."
			Ice
				icon='Icons/Perk/Ice.png'
				name="Ice Attuned"
				desc="This creature is attuned to the element of Ice. It is immune to the 'Frostbite' status effect, and takes half damage from ice, water, and earth, but 2x damage from fire."
			Earth
				icon='Icons/Perk/Stone.png'
				name="Earth Attuned"
				desc="This creature is attuned to the element of Earth. It is immune to the 'Heavy', 'Bleed', and 'Weakness' status effects, and takes half damage from earth, thunder and fire, but 2x damage from ice and bio."
			Thunder
				icon='Icons/Perk/Thunder.png'
				name="Thunder Attuned"
				desc="This creature is attuned to the element of Thunder. It is immune to the 'Paralyze', 'Stun', and 'Wet' status effects, and takes half damage from thunder and bio attacks, but 2x damage from earth and wind."
			Bio
				icon='Icons/Perk/Bio.png'
				name="Bio Attuned"
				desc="This creature is attuned to the element of Bio. It is immune to the 'Poison' and 'Bleed' status effects, and takes half damage from bio, earth, and wind, but 2x damage from thunder."
			Aero
				icon='Icons/Perk/Wind.png'
				name="Wind Attuned"
				desc="This creature is attuned to the element of Wind. It is immune to the 'Squall' and 'Bleed' status effects, and takes half damage from wind, thunder, and water, but 2x damage from bio."
			Holy
				icon='Icons/Perk/Dia.png'
				name="Holy Attuned"
				desc="This creature is attuned to the element of Holy. It is immune to the 'Weakness', 'Doom', 'Break', 'Heavy', 'Blind', and 'Silence' status effects, and takes half damage from holy damage, but 2x from dark damage."
			Dark
				icon='Icons/Perk/Apocalypse.png'
				name="Dark Attuned"
				desc="This creature is attuned to the element of Holy. It is immune to the 'Weakness', 'Doom', 'Break', 'Heavy', 'Blind', and 'Silence' status effects, and takes half damage from dark damage, but 2x from holy damage."
		Crafting
			cat="Crafting"
			ptype="general"
			Armor
				icon='Icons/Perk/Weaponsmith.png'
				Armor2
					rank="T2"
					name="Armorsmith II"
					desc="This individual is capable of smithing Armor up to Steel tier given they have enough ore to do so, as well as have the tools and time."
				Armor3
					rank="T3"
					pre="Armorsmith II"
					name="Armorsmith III"
					desc="This individual is capable of smithing Armor up to Mithril tier given they have enough ore to do so, as well as have the tools and time."
				Armor4
					rank="T4"
					pre="Armorsmith III"
					name="Armorsmith IV"
					desc="This individual is a master smith. They're able to craft armor of up to Adamantine tier given they have enough ore to do so, as well as have the tools and time."
			Weapons
				icon='Icons/Perk/Weaponsmith.png'
				Weapons2
					rank="T2"
					name="Weaponsmith II"
					desc="This individual is capable of smithing Weapons up to Steel tier, assuming they have the materials to do so."
				Weapons3
					rank="T3"
					pre="Weaponsmith II"
					name="Weaponsmith III"
					desc="This individual is capable of smithing Weapons up to Mithril tier, assuming they have the materials to do so."
				Weapons4
					rank="T4"

					pre="Weaponsmith III"
					name="Weaponsmith IV"
					desc="This individual is  a master smith, and are capable of smithing Weapons up to Adamantine tier, assuming they have the materials to do so."
			Enchanter
				icon='Icons/Perk/Enchanter.png'
				rank="T2"
				desc="This individual is capable of enchanting weapons, armor, and accessories in order to give them bonus effects based on what they have been enchanted with."
			Jeweler
				icon='Icons/Perk/Jeweler.png'
				rank="T2"
				desc="This individual is capable of crafting complex jewelry of varying quality that is capable of storing magical enchantments within the affixed gemstones."
			MateriaMelder
				icon='Icons/Perk/Materia Melder.png'
				rank="T2"
				name="Materia Melder"
				desc="This individual has learned Midgar's ways of melding Materia together from the Life-stream, and are capable of converting raw Mako into different Materia Spheres."
				verb
					MeldMateria()
						if(!usr.check_perk("Materia Melder"))
							return
						// todo: actual inventory system
						var/obj/item/material/raw_mako/our_stack = locate() in usr.contents
						if(!our_stack || (our_stack.amount < 5))
							usr.alert_interaction_fail("You don't have at least 5 Raw Mako.")
							return
						var/choice = input(usr, "Choose a type of Materia to meld. The Materia melded will be random in that set.") as null|anything in list("Green", "Blue", "Yellow", "Purple", "Link")
						if(!choice)
							return
						if(!our_stack || (our_stack.amount < 5))
							usr.alert_interaction_fail("You don't have at least 5 Raw Mako.")
							return
						switch(choice)
							if("Green")
								RandomGreenMateria(usr)
							if("Blue")
								RandomBlueMateria(usr)
							if("Yellow")
								RandomYellowMateria(usr)
							if("Purple")
								RandomPurpleMateria(usr)
							if("Link")
								var/obj/item/Materia/PassiveMateria/c=new
								usr.contents+=c
								usr.visible_message("<b>[usr.name]</b> molded some Raw Mako into a <b>[c]</b>.", stream = "icout", color = TRUE)
							else
								return
						// todo: actual inventory system
						our_stack.amount -= 5

		Gathering
			cat="Crafting"
			ptype="general"
			Miner
				icon='Icons/Perk/Miner.png'
				Miner1
					rank="T1"
					name="Miner"
					desc="This individual is a novice Miner. They're able to forage for precious metals while they are in a cave or a mine biome, and find an ore node."
				Miner2
					rank="T2"
					name="Seasoned Miner"
					desc="This individual is a seasoned Miner. They're able to get the resources they require without wasting as much of the precious metal in the process. A Seasoned Miner gains a +10 to all Ore node rolls for normal metal (not towards Silver/Gold)."
					pre="Miner"
				Miner3
					rank="T3"
					name="Expert Miner"
					desc="This individual is an expert Miner. They gain x2 whatever they reap from their mining roll."
					pre="Seasoned Miner"
			Gatherer
				icon='Icons/Perk/Gatherer.png'
				Gatherer1
					rank="T1"
					name="Gatherer"
					desc="This individual is a novice Gatherer. They're able to forage for different rare plants, monster residue, and powders when they are in a forest or plains biome, when they find a Nature Node."
				Gatherer2
					rank="T2"
					name="Seasoned Gatherer"
					pre="Gatherer"
					desc="This individual is a seasoned Gatherer. They're able to more reliably find the resources that they want when searching. Adds +10 to gathering rolls."
				Gatherer3
					rank="T3"
					name="Expert Gatherer"
					pre="Seasoned Gatherer"
					desc="This individual is an expert Gatherer. They have an eye for hot-spots, and can more reliably find what they're looking for. Doubles the amount of resources attained from gathering from a Nature Node."
			Hunter
				icon='Icons/Perk/Hunter.png'
				Hunter1
					rank="T1"
					name="Hunter"
					desc="This individual is a novice Hunter. They're able to track down, and catch wild animals and weak monsters off-guard, then skin them for the resources they need so long as they are in a forest or plains biome, by finding a Hunting Spot."
				Hunter2
					rank="T2"
					name="Seasoned Hunter"
					pre="Hunter"
					desc="This individual is a seasoned Hunter. They're able to more reliably find the prey that they want when searching. Adds +10 to hunting rolls."
				Hunter3
					rank="T3"
					name="Expert Hunter"
					pre="Seasoned Hunter"
					desc="This individual is an expert Hunter. They're able to track the patterns of certain beasts, and this allows them to find what they want far more reliably than others. Doubles the amount of resources gathered from a Hunting Spot."
			Sifter
				icon='Icons/Perk/Sifter.png'
				Sifter1
					rank="T1"
					name="Sifter"
					desc="This individual is able to take large deposits of dirt and sand, and sift through them to find rare and valuable gemstones - so long as they are in a desert or mountain biome, and find a Soil Mound."
				Sifter2
					rank="T2"
					name="Seasoned Sifter"
					pre="Sifter"
					desc="This individual is able to pick out spots in the dirt that have a higher yield for natural gemstones, and this allows them to more reliably find valuable stones. You roll twice when interacting with a Soil Mound."
				Sifter3
					rank="T3"
					name="Expert Sifter"
					pre="Seasoned Sifter"
					desc="This individual is an expert Sifter. They have an innate sense for the location of even specific gemstones, highly increasing the likelihood that they'll find what they want to. Grants twice the amount of gems attained from a Soil Mound."

		Uniques
			cat="Unique"
			Telekinesis
				icon='Icons/Perk/Telekinesis.png'
				name="Telekinesis"
				desc="Thos person has a special bond with their weapon is is able to control it remotely with their mind. This technique only has a medium range, and the user is unable to send the weapon out too far without losing control. Telekinesis also empowers a weapon, granting it +2 to hit , and increasing damage by a flat 10 if expending Mana to use telekinesis. This can be used for Melee range as well. (Allows the user to expend -5 Mana to make a basic attack at an added 4 tile range.)"
			DualWield
				name="Dual Wield"
				icon='Icons/Perk/DualWield.png'
				desc="The individual is ambidextrous, and is able to skillfully fight with a one handed weapon in each hand. When wielding the same weapon type in each hand, if using the left hand weapon for an attack, after using the right hand weapon for an attack in the same round ; deal 15 additional true damage on hit. (Grants you an extra Standard attack or Standard Ability as long as you are wielding two weapons. Does not stack with Gestalt Drive)"
			HardenedCombatant
				name="Hardened Combatant"
				icon='Icons/Perk/HardenedCombatant.png'
				desc="This person through much experience and battle has increased their skills to be able to act more in a single round of combat. They are limited however to being able to do only 2 melee or magic skills in a turn. They can basic attack up to three times, if they do wish. (These extra points can be used towards anything BUT an extra 'reaction' action - which can only be taken once a turn no matter what.)"
			Jackofalltrades
				name="Jack of All Trades"
				icon='Icons/Perk/Jackofalltrades.png'
				desc="This individual is a jack of all trades, and are capable of wielding all non special weapon types. They also gain a +1 to hit with all non special weapons. "
			Strongarm
				icon='Icons/Perk/Strongarm.png'
				desc="This individual has learned to control a two handed weapon to the point where they are able to wield it in one hand allowing them to dual wield two handed weapons as well as completely freeing up the other hand for other uses. "
			Warroroflight
				name="Warrior of Light"
				icon='Icons/Perk/Warrioroflight.png'
				desc="The individual has been deemed worthy by the Knights of the Round, the ethereal guardians of Terra - forged by the Life-stream. This grants them the Light’s Blessing ability, and one free T2 specific immunity to a status ailment chosen at the time of the trial being passed. Only one who has a genuine wish to protect others may be deemed worthy. +100 HP, +100 MP, +100 SP, permanently."
				Lightsblessing
					name="Light's Blessing"
					ability=1
					desc="The Holy Light of the Aether has given the user a direct link to the mana of the universe, making them a conduit of mana just like the crystals each nation harbors. They are infused with great power and can call upon a golden, glowing aura of power. | +2 to hit, +3 AC, and +20 flat damage to all damage calculations."
					mcost="10 per turn"
					costtype="Mana"
			Harbinger_of_Chaos
				name="Harbinger of Chaos"
				rank="T4"
				cat="Unique"
				icon='Icons/Perk/EmbodimentofSin.png'
				desc="The user has awakened the true power of chaos inside them. At any time they are able to access this form, but can only control it if they possess the protomateria. The user becomes a demonic creature sprouting a pair of wings capable of agile flight. They also gain access to the death penalty. A massive gun that fires a powerful beam of Mana, and increases its power the more souls it absorbs. { Ex. Vincent }. This grants +50 HP, +30 MP, and +30 SP, as well as +2 to all Ability Scores. Allows the creation and application for 'Chaos Forms'."
			Lucisheir
				KingofLucis
					icon='Icons/Perk/Heiroflucis.png'
					name="King of Lucis"
					desc="This individual is the king of Insomnia. They have been granted the ring of Lucis which allows them the power of the crystal as well as the power of their ancestors. As long as they are king and in possession of the crystal they have access to several exclusive abilities. They are able to erect an impenetrable magical shield over their kingdom although doing so ages them faster over time. They are also able to anoint Kingsglaive who will share the power of the king as long as the king is alive. "
				Heiroflucis
					icon='Icons/Perk/Heiroflucis.png'
					name="Heir of Lucis"
					desc="This individual is the Prince / Princess of Lucis. They are Heir to the power of the Kings and Queens of Lucis, and are destined to take the helm of ruler after the current King or Queen. They have the ability to utilize Warp Strike by default, gaining power as they collect Royal Arms. Once they have gained possession of three Royal Arms, they unlock Armiger, Warp, and Phase. Additionally, they may appoint one Kingsglaive per Royal Arm collected, Royal Arms serving as a conduit to grant this power. The Heir gains +70 HP, +50 MP, +50 SP, +2 PAB, +2 MAB, +4 PDB, +4 MDB, +1 AC latently."
					Warp
						name="Warp"
						ability=1
						rank="C"
						desc="As a Bonus Action, the Heir of Lucis may materialize a weapon from their Armiger and throw it to a specific tile or surface within 6 tiles for 10 SP. This does not do damage and instead plants the weapon on this tile. They can recall it back to their Armiger as a Bonus Action and 10 MP. Lastly, as a Free Action once a turn they may either warp to that planted weapon or as a Reaction in response to an incoming attack giving resistance to that attack’s damage and warping themselves to the weapon. This last effect has a two Round cooldown and costs 15 MP, otherwise this technique does not have a cooldown. The Heir may ‘hang’ by the weapon on the tile they warped to, preventing falling."
					Warpstrike
						name="Warp Strike"
						ability=1
						rank="D"
						desc="As a standard action and for 10 SP and 20 MP the Heir of Lucis or a Kingsglaive member may launch their weapon at a target at blazing speeds, with a maximum range of up to 8 tiles. They roll a standard attack at Advantage. The Heir of Lucis or Kingsglaive then warps in a flash of azure - leaving a tracer of energy connecting them to their starting position - to an adjacent tile to the target."
					Phase
						name="Phase"
						ability=1
						rank="C"
						desc="The user focuses on a target watching their every move. Just before their opponent is about to land a blow the user expends a large amount of energy to teleport a short distance from the attack leaving only an afterimage of light in their place. They may appear on any tile within three tiles of their original position. (As a reaction, dodge a single ability / spell. -50 Mana.)"
					Arminger
						name="Arminger"
						ability=0
						rank="T4"
						desc="The Heir of Lucis need not bear a weapon within their hands, as such can be evoked from the Aether around them in a flash of azure light at exactly the time where it is needed. As a Bonus Action, the Heir of Lucis may swap between any weapon or shield in their inventory using the ‘Armiger’ ability for 10 MP. Upon switching to a new weapon, the weapon gains the ‘Armiger’ buff for 1 Round, boosting its respective damage bonus (PDB or MDB) by 5. One Round cooldown on use. OOC Effects: The Heir of Lucis’ weapons when equipped are not visibly equipped, though they still gain the weapon’s bonuses - as they materialize when they’re specifically being used or at the choice of the Heir. The Heir of Lucis’ Weapons and shields cannot be subject to Mug rolls as they are intangible, though anything else on their person can be.."
					ArmingerUnleashed
						name="Arminger Unleashed"
						ability=1
						rank="A"
						mcost=80
						desc="The Heir of Lucis may attack a singular time with each weapon in their arsenal, up to a maximum of 5 attacks. This ability has no cooldown. In addition, when the Heir of Lucis knows this ability, all weapons in their arsenal are considered equipped and may be utilized for Weapon Abilities, with no action cost. The Heir of Lucis gains a permanent +10 PDB and MDB due to this effect, which can stack with Arminger's +5 on switch. Using Arminger Unleashed costs 80 MP."
				Kingsglaive
					icon='Icons/Perk/Kingsglaive.png'
					rank="T4"
					desc="Having been anointed by the King of Lucis or the Heir of Lucis, this individual has gained a share of their power. Notably, they've gained the warping ability. This lasts for as long as the King/Heir is alive, and the Aether Crystal is in control of the Kingdom of Insomnia. The ability to use Warp Strike is only twice per encounter, unless the Kingsglaive is fighting on the same side as King/Heir in an engagement, or fighting within Insomnia. A Kingsglaive gains +1 PAB, +1 MAB, +2 PDB, +2 MDB, +10 HP, +10 MP, latently. (Unable to be combined with Appointed Guardian)"
			JunctionMaster
				icon='Icons/Perk/Junctionmaster.png'
				name="Junction Master"
				desc="This individual has learned how to utilize the secret art of Junctioning. Junctioning magic is similar to that of Summoning magic, except it calls on a higher power to embolden one's body and features rather than to summon it forth. A Junction Master is able to set a specific Summon as their 'Guardian Force' - by specifying it before a fight. The Junction Master's list of available Guardian Forces comes from either a list of 3 Summons (of rank C-B) chosen upon attaining this perk (which will be listed in a custom perk, given to the Junction Master as evidence as to which Guardian Forces were selected) - OR, if they are the practitioner of a Summoning type Job ; any Summon they currently have access to may also function as a Guardian Force. However, a Summon that is set as one's Guardian Force may not be summoned in battle, as it is focusing its power on emboldening the user of this perk."
			Makos
				MakoPoisoning
					icon='Icons/Perk/MakoPoisoning.png'
					name="Mako Poisoning"
					desc="This individual has been exposed to pure, raw Mako through some means - and managed to survive. Their body is currently trying to fight the massive dose of mako. They hear voices ocassionally some distant some not so distant. They also see vivid images from time to time as if they were ethereal beings. Once enough time has passed (1 month IRL) their body will either lose the fight against the mako or they will combine with the mako and the status will be replaced with Mako Affected."
				MakoAffected
					icon='Icons/Perk/MakoAffected.png'
					name="Mako Affected"
					desc="This individual either through the SOLDIER Second Class + program or some other means has been soaked in Mako (Lifestream) Mana just under the point of Mako poisoning, granting them a permanent boost in power, however not allowing the same growth or versatility as Jenova genes. This gives them noticeable light green eyes. Boost: +30 Permanent HP, +30 Permanent MP, +30 SP. +2 Strength, +2 CON, +2 DEX. A character who has this perk also has the 'Lifestream Overdrive' ability."
				LifestreamOverdrive
					icon='Icons/Perk/MakoAffected.png'
					name="Lifestream Overdrive"
					desc="This individual is able to summon forth the power of the Lifestream, at the sake of their body. By spending 50 HP, and 20 SP and MP; they are able to generate a state of being wherein they gain +4 STR, DEX, and CON ; and may apply 15 additional true damage to a single attack, once per round. While this is active, the character is permanently afflicted with 'Poison'. This can be deactivated as a bonus action."
			Jenova
				Imperfectjenovacells
					icon='Icons/Perk/ImperfectJenovaCells.png'
					name="Imperfect Jenova Cells"
					desc="The user has been injected as a fetus with cells from an otherworldly creature that have drastically affected their growth. The baby is born as a super soldier, and will grow into a warrior that will stand above the others. This individual is also capable of injecting their cells into another slowly killing the injected after 1 month resetting their own deadth flag by 1 month. Injections can only happen to a WILLING player or to a player who has been defeated in a danger 3 scenerio. This individual however did not get a perfected gene of the jenova cells, and their body will  degrade over time usually killing the individual 1 month after their cells activate. Boost: +50 Permanent HP, +30 MP, +30 SP. +4 STR, +4 DEX, +2 CON."
				CuredJenovaCells
					icon='Icons/Perk/ImperfectJenovaCells.png'
					name="Cured Jenova Cells"
					desc="This individual has undergone the hellish curse of being implanted with Imperfect Jenova Cells, and miraculously has come out with their life. The causes for this are 'generally' unknown, but a person whose Imperfect Jenova Cells have been cured retains the immense power granted by them. The stability of their cells however removes their ability to inject the DNA into others, and mutate them into clones. (Requires IC Circumstance, requires Imperfect Jenova cells.)(Removes clone creation ability, but grants +10 additional HP, MP, and SP - and removes early death penalty.)"
				Perfectjenovacells
					icon='Icons/Perk/PerfectJenovaCells.png'
					name="Perfect Jenova Cells"
					desc="This individual has received a much more perfected version of Jenova cells removing the degrading aspect from them. They are also able to incubate their cells inside of a host taking them over, and turning into a perfect copy. This essentially allows this individual to return to life after death. (Ex. Sephiroth) | Boost: +100 Permanent HP, +50 Permanent MP, +50 SP. +4 STR, +4 CON, +4 DEX."
				OneWingedAngel
					icon='Icons/Perk/PerfectJenovaCells.png'
					name="One Winged Angel"
					desc="This individual's Jenova cells, either Perfect or Imperfect - have awakened. They may enter a state wherein they gain a maximum flight elevation of 5 tiles, 50 temporary HP, +4 STR, DEX, CON, and WIS, an additional +1 tile movement per turn, and deal 20 additional true damage on one attack per round. This may be deactivated as a bonus action. This drains 20 MP and SP per turn active, and ends if either of these drains cannot be sustained."
			Lcie
				icon='Icons/Perk/Lcie.png'
				name="L'Cie"
				desc="This individual has been chosen by a Crystal to carry out its will. They are given a branding on their arm, and a focus. If they do not achieve this focus within five years of being branded, they will turn into a horrid crystal abomination, a C'ieth, with tremendous power. As a L'Cie, they have been washed of all knowledge of their prior jobs - and instead been given access to paradigms, a direct funnel of the crystal's power that can be shifted betwixt."
			OccurianAttendant
				icon='Icons/Perk/Occurian.png'
				name="Occurian Attendant"
				desc="This individual has a guardian spirit in the form of an Occurian. The occuria is an aetherial being, and will only be visible to those it chooses. At times this individual may seem to be talking to the air, but in fact they are conversing with a higher being. The attendant cannot fight for the master, but can be used once per two turns to materialize in a physical form blocking attacks with its near impenetrable body. The Occuria can also send out a shock-wave, keeping foes away from its master. As a reaction to an attack, you may summon your Occurian Attendant to take the damage instead. Occurian Attendants have 80 HP, and regain their HP at the end of a long rest. Occuria shockwave is cast as the spell 'Impact' using a basic 1d4 unarmed strike, with a 1d20+WIS attack roll."
			AttendantManifest
				icon='Icons/Perk/Occurian.png'
				name="Attendant Manifest"
				desc="This individual has formed a deep bond with their Attendant. They may now manifest it as a Summon, as a Standard action, at the cost of 80 MP ; and it has its own character sheet, and stats."
			OccurianEmpowerment
				icon='Icons/Perk/occurian.png'
				name="Occurian Empowerment"
				desc="This individual gains empwoerment from its Occurian Attendant, gaining a permanent +2 to all ability scores, +40 HP, +40 SP, and +40 MP."
			AetherAffected
				icon='Icons/Perk/Aetheraffected.png'
				name="Aether Affected"
				desc="This individual has been directly affected by the Aether, the opposition to the life-stream. They are imbued with a direct link to the source that the crystals draw their power from, although menial in comparison. This grants them a few unique abilities, and increases the potency of their magic - as well as gives them a light blue aetherial aura whenever casting magic. Boost: +30 Permanent HP, +30 Permanent MP, +30 SP. +2 WIS, +2 INT, +2 CHA. A character with this perk also gains the Aether Merge ability."
			AetherMerge
				icon='Icons/Perk/Aetheraffected.png'
				name="Aether Merge"
				desc="This individual is able to merge with the Aether. In doing so, their MP is immediately reduced to zero. However, they 40 flat points of reduction versus magical damage, +4 WIS, +4 CHA, and +4 INT. In addition, they may cast Black, and Arcane magic spells for 0 MP. Activating this ability afflicts the user with 'Doom' - but it can be dispelled by dispellation effects. When Doom ends, this effect also ends."
			Unsent
				icon='Icons/Perk/Unsent.png'
				desc="This individual is an Unsent. They seem to have died at one point, but their soul did not cross into the life-stream correctly. They appear to all others simply as a normal version of themselves, however they do not age. The Life-stream has given them a task that when they fulfill, they will be put back into the life-stream. Boost: +20 HP, +20 MP, +20 SP."
			TranceMode
				name="Trance Mode"
				icon='Icons/Perk/Trancemode.png'
				desc="A state which can be accessed by Genome and Golems alike ; Trance Mode is an ability that arises due to an artifical soul gaining true sentience and individuallity. If a Genome or Golem gained their own true sense of self, their artificial soul would then gain the components of a real soul ; and the two would begin to catalyze together, allowing for the creature to generate massive amounts of Mana, almost like a generator. Trance Mode may be activated as a bonus action, and grants a flowing aura. While active: 5 Global damage reduction, +5 PDB, MDB, +1 PAB, MAB, +2 to all ability scores. Lasts for 4 rounds, and can only be used once per battle."
			SummonerofYevons
				SummonerofYevon
					icon='Icons/Perk/SummonerofYevon.png'
					name="Summoner of Yevon"
					desc="This individual is a Summoner of Yevon. They are a devout of the religion of Yevon, and have the unique ability to travel to shrines of Yevon and obtain free Aeon summons by overcoming the trials within said shrines. When completing a shrine's trial, this summoner is granted the shrine's Aeon without any point cost. Aeons cost 50 MP to summon, regardless of which it is. In addition, up to two Aeons may be summoned at a time, and can be summoned to the field together. They gain +4 WIS, +4 CHA, +4 INT)"
				AppointedGuardian
					icon='Icons/Perk/AppointedGuardian.png'
					name="Appointed Guardian"
					desc="This individual has been appointed as a Guardian by a Yevonite Summoner, and as a result - the residual power of the Aeons is shared to the Guardian, and infused into them - making them somewhat stronger, and more capable of protecting the summoner after a proper ritual has been completed. A Summoner may only appoint up to 3 Guardians. (Incompatible with Kingsglaive.) +20 HP, +20 MP. +2 Ability score points."
				GrandSummoner
					icon='Icons/Perk/High Summoner.png'
					name="Grand Summoner"
					desc="This individual is the grand summoner of Yevon. They are capable of performing the summoning of the Final Aeon. This allows them to sacrifice their life in order to bestow the power of their soul to one individual, giving that individual a permanent boost of +50 Max HP, +50 Max MP, +2 to all scores. Only a final aeon created in this way is able to permanently kill Sin. (Requires having obtained all Aeon Summons from all Yevon Shrines.)"
			Sin
				EmbodimentofSin
					icon='Icons/Perk/EmbodimentofSin.png'
					name="Embodiment of Sin"
					desc="This individual is an embodiment of the monster Sin, which according to Yevonite religious belief, ravages Terra during times of man's dominance. They are a normal person, but every 1 OOC week (or when an Admin prompts you to), you must roll a 1d100. If they roll a 30 or lower, they will gain irresistable urges to destroy whatever is around them for 1 full OOC day. If this happens more than fifteen times, they lose this perk and gain the 'Body of Sin' perk.   Permanent Boost: +50 HP, +50 MP, +2 all ability scores."
				BodyofSin
					icon='Icons/Perk/BodyofSin.png'
					name="Body of Sin"
					desc="This individual has lost their humanity, and been turned into a vessel for the massive monster, Sin. Their conscience still beckons for freedom from this curse deep within, but their existence is now set purely to destroy the natural order of the world. This manifests either as a berserk fury, or scheming machinations. One who has the Body of Sin has an incurably corrupted, and dark heart - and therefore can not be returned to the light by anything but the Light Crystal itself. This grants a 'Sin Form' which may be activated or deactivated at will.  (Requires IC Circumstance.) Permanent Boost: +100 HP, +100 MP, +4 all ability scores. Sin Form attained."
			HalfEsper
				icon='Icons/Perk/HalfEsper.png'
				name="Half Esper"
				desc="This is a race of human-esc people, they can pass almost completely as human, aside from the birthmark on their back depicting them as a Half-Esper, this can be easily covered up though. At some point in history, the blood of a All-powerful Esper was mixed into mortal human blood, creating the first dozen of this kind. Half-Esper have a body that has aetherial magic tied into their very genetics. Half-Esper also have incredible longevity compared to most. They can live as little as three millennia, to five or six. They are a very rare race to find, and are well known for their ability to activate their latent Esper Bloodline, transforming, this allowing them access to a new font of power. Half Esper can be of any race, and gain the following perks to replace their racials. They may buy any spells and abilities of their Esper bloodline as well as those spells' and abilities pre-requirements, regardless of Job limitations, so long as they do not bypass Rank limitations. (Example, no buying A ranks before Veteran.) They still must pay the RPP price for these abilities."
				AetherialBody
					name="Aetherial Body"
					rank="D"
					ability=1
					desc="The Half-Esper can choose to expend 10 Mana to cleanse their body of one status effect and heal themselves 5 health points. This can only be activated once per turn."
				PsuedoTransformation
					name="Psuedo Transformation"
					ability=1
					rank="C"
					desc="The Half-Esper activates their latent Bloodline, which will affect their physical form in different ways. They take on form akin to the Eidolon they’ve been tied to, increasing their physical power and skill. 15 energy to enter in a scene. This cost goes up by 10 each time they re-enter the form in the same instance, dungeon, or encounter. (Choose Eidolon in application, this is supposed to not be something you can build around. More so you just get this form when you create your character.)"
				StageTwoTransformation
					ability=1
					rank="A"
					name="Stage Two Transformation"
					desc="This Half-Esper has gone through an extremely taxing event in their life, pushing them past their limits and drawing every drop of aetherial power from their bloodline, further changing their form to match their Eidolon Link, and boosting their power and skill once more. (Once unlocked the user must spend their entire turn transforming into this form, costs 30 energy to enter and 15 more each time they re-enter it in the same instance, dungeon, or encounter. Must be in Pseudo form before entering this state.)"


		Jobperks
			ptype="job"
			Lcies
				icon='Icons/Perk/Lcie.png'
				jobneed="L'cie"
				name="L'Cie"
				Lcie
					ability=0
					jobneed=null
					name="L'cie (Job)"
					icon='Icons/Perk/Lcie.png'
					desc="A L'cie is unable to take any subjobs, making the subjob and dual job perks incompatible with a L'cie. A L'cie has been granted immense power, for which to pursue the goal of their given focus. As a L'Cie grows, they are able to adopt more and more 'Paradigms' - which grant them specific, permanent benefits to aid in the pursuit of their goal. A L'cie has access to up to A rank magic in all four magic trees (Black, White, Arcane, Green.) +80 HP, +80 MP, +80 SP. +2 to all Ability Scores."
				Neutral
					rank="T1"
					rpcost=1
					LivingCrystal
						name="Living Crystal"
						desc="L'cie, are in truth, essentially 'miniature' crystals - having a piece of the crystal which gave them power, with them. As a result, Mana naturally flows to them. As a full turn action, a L'cie may apply the 'Refresh' status effect to themselves, also gaining 10 MP upon activation immediately."
					FlexibleFighter
						name="Flexible Fighter"
						desc="L'cie, due to the immense talent and power afforded to them by the will of the crystal, often make use of the versatility they are lucky enough to have attained. As a result, whenever a L'cie utilizes a Physical Ability, they enter 'Melee mode'. Whenever they use a Magical Ability, they enter 'Magic' mode. Melee Mode: +1 PAB, +5 PDB, 4 Physical DR. Magic Mode: +1 MAB, +5 MDB, 4 Magical DR."
				Hope
					icon='Icons/Perk/Hopelcie.png'
					DefyingFate
						name="Defying Fate"
						rank="T2"
						rpcost=2
						desc="This L'cie has chosen to defy their destiny, and act against the will of the crystal. They may now undertake the dangerous, and arduous path of 'Defiance' - attempting to turn the crystal's power against it, so they may retain their individuality, and humanity through immense willpower. This brands them as a traitor to the crystal, and other L'Cie will be ordered to eliminate them by the crystal itself. However, they have at least managed to break the Crystal's ability to observe their actions at all times, no longer having surveillance. In addition, their burning willpower grants them an additional +10 maximum HP, and 4 global damage reduction. Incompatible with Fear of Failure."
					BurningHumanity
						name="Burning Humanity"
						pre="Defying Fate"
						rpcost=3
						rank="T3"
						desc="This L'cie has realized the truth of their power, and what it implies. They understand that the crystal which has given them their power is using them, and as a result, their will to live is bolstered. They will do anything they can to either complete their focus, or resist their L'Cie degradation. Once per OOC Week, they may roll a CHA saving throw (DC 24) to break the crystal's control over them, and render their Focus inactive, taking the power for themselves. In addition, when reaching 0 HP in battle, they may return to consciousness at 20% HP. Incompatible with Fear of Failure. Requires Defying Fate."
					ForgeANewPath
						name="Forge A New Path"
						pre="Burning Humanity"
						rpcost=4
						rank="T4"
						desc="This L'cie has destroyed the Crystal's hold over them, and lives in utter defiance of its will. Their humanity burns so bright, that they have the power and ability to forge a new destiny for themselves, and even others. Having taken the power given to them for themselves, and incorporated it permanently into their body, they are granted great power - and they no longer have a Focus, having broken the chains of the Crystal entirely. They now gain +2 to all ability scores, and an additional +10 maximum HP, MP, and SP. (Attained via admin permission, after a successful Burning Humanity check.)"

				Despair
					icon='Icons/Perk/DespairLcie.png'
					FearofFailure
						name="Fear of Failure"
						rpcost=2
						rank="T2"
						desc="This L'cie has lived long enough under the thumb of the Crystal, that they have become desperate to complete the task given to them, in hopes they'll be rewarded - and to prevent their ultimate demise. This willpower reacts with the energy of the crystal inside of them, and they gain +2 CHA as well as +20 maximum HP, MP, and SP. Incompatible with Defying Fate."
					CrystalPuppet
						name="Crystal Puppet"
						rank="T3"
						rpcost=3
						pre="Fear of Failure"
						desc="This L'cie has accepted their role as a puppet of the Crystal, and as such have earned its trust. They are now granted a greater well of power for which to accomplish their task. They gain another +2 to all ability scores."
					FavoredPuppet
						name="Favored Puppet"
						rank="T4"
						rpcost=4
						pre="Crystal Puppet"
						desc="This L'cie has become truly favored by the Crystal, having become a closely guarded puppet. The chains around their soul are so strong that the Crystal can turn them into a crystallized mass at any given time, or rearrange their Focus to a new objective. This means the Crystal is able to crystallize them at any time, but it also means they have gained the utmost level of power possible from the crystal, making them a weapon of its will. They gain another +10 maximum HP, SP, and MP ; as well as a permanent +2 to PAB, PDB, MAB, and MDB. Requires Crystal Puppet."
				Paradigms
					rank="T3"
					rpcost=3
					Commando
						name="Commando"
						desc="This paradigm is acquired by those who have a particular desire to lead comrades into battle. A L'cie with the Commando paradigm attained grants +1 PAB, PDB, MAB, and MDB to all party members (excluding themselves), in every battle."
					Ravager
						name="Ravager"
						desc="This paradigm is acquired by those who have a focus on dishing out damage, and wreaking havoc across the battle-field. A L'cie with the Ravager paradigm attained gains +5 PDB, and MDB permanently."
					Medic
						name="Medic"
						desc="This paradigm is acquired by those who have a knack for healing their allies and selves. A L'cie with the Medic paradigm attained grants +15 additional healing to all healing spells they perform."
					Saboteur
						name="Saboteur"
						desc="This paradigm is acquired by those who have a knack for disabling enemies with Black and Arcane magic. Any spell they use which has a saving throw associated gains 10 additional damage, and the DC is increased by 2."
					Sentinel
						name="Sentinel"
						desc="This paradigm is acquired by those who wish to protect others. A L'cie with this paradigm attained gain +4 global damage reduction permanently, as well as the ability to use 'Sentinel' - which allows them to, as a reaction, teleport in front of an incoming attack which would deal damage to a party member, and take the damage for them instead, at the cost of 10 MP."
					Synergist
						name="Synergist"
						desc="This paradigm is acquired by those who wish to empower others. A L'cie with this paradigm attained adds 2 rounds of duration to positive status effects applied to allies, and in addition to this, whenever granting a new positive status effect to an ally or themselves, that creature is healed for 10 HP."
			Pirate
				jobneed="Pirate"
				icon='Icons/Perk/Pirate.png'
				Pirate
					name="Pirate"
					cat="Unique"
					desc="Pirates are great wariors of the Sea, and are at home when along the tides. Pirates gain +1 PAB when wielding either a Scimitar or a Magitek Pistol. Pirates are immune to the 'Wet' and 'Whorl' status effects, and have resistance to Water damage. Mainjob Pirates gain +40 HP, +70 SP, and +70 MP."
				WaveWalker
					name="Wave Walker"
					rank="T1"
					desc="This Pirate has gained the ability to walk across the water, by willing the waves to create platforms underneath their feet."
				SeaMaster
					name="Sea Master"
					rank="T1"
					desc="This Pirate is a Master of the Sea. When they are fighting on an active Water AoE or a Water tile, they gain +1 PAB, and MAB."
				WaveTamer
					name="Wave Tamer"
					rank="T1"
					desc="This Pirate is a tamer of the waves. They are immune to any of Pirate's Water AoE debuffs, and also move with +1 speed while actively within a Water AoE."
				ObscuredByWaves
					name="Obscured by Waves"
					rank="T2"
					desc="This Pirate is able to use the mist generated by the waves in order to obscure themselves in the midst of battle. While they are within a Water tile or an active Water AoE, the Pirate gains +2 AC."
				CalispoBlessing
					name="Calypso's Blessing"
					rank="T2"
					desc="This Pirate is blessed by the sea goddess, Calipso. So long as they are within an active Water AoE, or a water tile, they gain +2 DR."
				BlessingofPoseidon
					name="Blessing of Poseidon"
					rank="T3"
					desc="This Pirate is blessed by the sea god, Poseidon. So long as they are on an active Water AoE, or a water tile, they gain +10 PDB and +10 MDB."
				SwiftlikeWave
					name="Swift as a Wave"
					rank="T3"
					desc="This Pirate is trained to move with the swiftness of a raging wave. So long as they are on an active Water AoE, or a water tile, they are able to perform an additional standard attack, once per round, as a bonus action ; at the cost of 25 SP. After using this perk, it goes on cooldown for 1 round."
			SeaCaptain
				name="Sea Captain"
				rank="T3"
				cat="Unique"
				desc="This pirate has developed the skills to lead a crew of people. When the Sea Captain is fighting with allies they all gain the WaveWalker feat as long as they are withing 3 tiles of him."
				icon='Icons/Perk/SkyPirate.png'
			CaptainsCall
				ajob="Sea Captain"
				name="Captains Call"
				rank="T3"
				desc="As a bonus action The Sea captain can spend 20 sp and call out a hoarse battle cry giving all allies a +3 PAB and MAB  to their next attack. This last until the end of the Sea Captains next turn."
				icon='Icons/Perk/SkyPirate.png'
			WalkThePlank
				ajob="Sea Captain"
				name="Walk the Plank"
				rank="T4"
				desc="The Sea Captain chooses a target that is on a body of water that he resides on. That target must make a Will Save DC 20 if they fail they must begin walking away from the captain. Any creature who fails this roll cannot target the captain until the end of their next turn. The Captain also gains a +5 PAB and MAB when targeting that creature while the effects are active."
				icon='Icons/Perk/SkyPirate.png'

			ChocoboKnight
				jobneed="Chocobo Knight"
				icon='Icons/Perk/Chocobo Knight.png'
				ChocoboKnight
					name="Chocobo Knight"
					cat="Unique"
					desc="Chocobo Knights are masters of riding, and fighting alongside mounted companions. A Chocobo Knight starts with a Chocobo Steed upon learning the job. They gain a bonus of +2 to AC and +8 DR while they are mounted on any creature, as a primary benefit. Chocobo Knights may have 1 Companion/Familiar summoned at a time. +80 HP, +70 SP, +40 MP."
				GearShift
					name="Gear Shift"
					rank="T1"
					desc="This Chocobo Knight is capable of sharing their vitality with their steed. In doing so, they increase the steed's mobility by a massive degree. By spending 5 HP, their mount may move an additional 3 tiles as part of their movement."
				MountMaster
					name="Mount Master"
					rank="T1"
					desc="This Chocobo Knight is capable of riding even their allies' companions. With consent of another character, they may mount a party member's comapnion if it has the 'Rideable' feature, and apply up to T2 Chocobo Knight benefits to that creature as if it were their own."
				RideRescue
					name="Rider's Rescue"
					rank="T1"
					desc="This Chocobo Knight is capable of spending 20 SP from either their own SP pool, or that of their mount, as a free action (up to twice per round) - upon doing so, they may move their Mount's maximum movement towards an ally who is being attacked. If they can reach them, they may take the attack for them instead, but applying 15 points of reduction towards the attack in doing so. In the case of Multi-hit attacks and AoEs the Chocobo Knight or their mount covers all included allies, all instances of damages that all affected allies would take are instead assigned to the Chocobo Knight or its mount (at the Chocobo Knight's discretion). Saves are auto-failed when covered for. All instances of damage being covered for, merge into a single combined instance with their base damage combined, which DR applies to only once."
				RookieRider
					name="Rookie Rider"
					rank="T2"
					desc="This Chocobo Knight has elevated to the rank of a Rookie Rider. They may choose a new mount, from the following list: Adult Drake, Mesmerize, Blaze Beetle, and Ankheg."
				RidingSynergy
					name="Riding Synergy"
					rank="T2"
					desc="This Chocobo Knight has immense synergy with their mount. While mounted, both the Chocobo Knight's mount, and the Chocobo Knight themselves gain +5 True damage to all attacks they deal."
				SharedEssence
					name="Shared Essence"
					rank="T2"
					desc="This Chocobo Knight is able to link their vitality with any creature they have mounted. Whenever either the Knight or the Mount takes any form of damage, either creature may choose to take the full damage of an attack to bypass the effects of Rideable, at their discretion. In addition, for the sake of AoE attacks - the Chocobo Knight and their Mount count as a single entity for targetting, and only take a single instance of AoE damage between the two of them."
				CavalrySoul
					name="Cavalry Soul"
					rank="T2"
					desc="This Chocobo Knight has the soul of a cavalier. They inspire their mount, and their mount inspires them. When either the Chocobo Knight or the Mount takes damage, and the other creature takes no damage in the same turn, the creature who did not take damage heals for 25 HP, and gains 20 SP and MP."
				TacticalCavalier
					name="Tactical Cavalier"
					rank="T2"
					desc="This Chocobo Knight understands, values, and enacts the virtue of Strategy in combat. When their Mount moves out of Melee range of another creature, they do not provoke attacks of opportunity."
				TendMount
					name="Tend Mount"
					rank="T2"
					desc="This Chocobo Knight has the ability to convert their vital essence to that of their mount. As a bonus action, the Chocobo Knight is capable of spending up to 60 HP in order to restore HP to their mount, equal to the amount spent."
				TheTwoSpeed
					name="The Two Speed"
					rank="T2"
					desc="This Chocobo Knight has attained the blessing of the 'Two Speed' - granting whatever mount they are riding an additional +1 Tile Movement per turn, passively."
				AdeptRider
					name="Adept Rider"
					pre="Rookie Rider"
					rank="T3"
					desc="This Chocobo Knight has reached the rank of an Adept Rider. They may now choose their final mountable companion, from the following list: Alpha Drake, Gigantoad, Woolly Croc, Shoopuff, Black Chocobo, Red Chocobo, Fat Chocobo."
				MonsterSoul
					name="Monster Soul"
					rank="T3"
					desc="This Chocobo Knight has a soul that is attuned to that of monsters and creatures of all types. As a result, they may, when mounting a party member's companion with their consent, apply bonuses from Chocobo Knight features up to T4 as if the creature were their own."
				GreatCharge
					name="Great Charge"
					rank="T3"
					desc="This Chocobo Knight has learned empower their Mount's momentum with magical energies. By spending 45 MP, if their Mount has moved on this turn, and their Mount is making an attack ; the Chocobo Knight may add True Damage equal to 5 points per tile moved (up to 25) to that Mount's singular attack roll."
				FlowingLifeforce
					name="Flowing Lifeforce"
					rank="T3"
					desc="This Chocobo Knight has learned to empower their Mount's vitality by converting the energy of momentum as their mount moves, into restorative power. By spending 80 MP, the Chocobo Knight may restore their Mount for 10 HP per tile the Mount has moved on this turn, as a free action ; once per round (Capping at 100.)"
				TheFourSpeed
					name="The Four Speed"
					rank="T4"
					desc="This Chocobo Knight has attained the blessing of the 'Four Speed' - granting whatever mount they are riding an additional +2 Tile Movement (stacking with The Two Speed) per turn, passively."
				SonicBubble
					name="Sonic Bubble"
					rank="T4"
					desc="This Chocobo Knight is capable of gathering the air around their mount's body, as a 'Sonic Bubble' - which protects both the Chocobo Knight and their Mount based on how much they have moved on their turn. For every tile they have moved, they gain 5 unreducable Damage Reduction (capping at 30.) ; lasting until the start of their next turn."





			Gladiator
				jobneed="Gladiator"
				icon='Icons/Perk/Gladiator.png'
				Gladiator
					name="Gladiator"
					cat="Unique"
					desc="Gladiators are masters of many different weapon types. A Gladiator may change their weapon type as a bonus action, instead of a standard action, or instead as a free action (once per round) at the cost of 20 SP. A Gladiator gains +50 HP, +80 SP, and +40 MP."
				CombatIntelligence
					rank="T1"
					name="Combat Intelligence"
					desc="For every unique type of weapon that the Gladiator has attacked with in a single combat scene, the Gladiator gains +1 PAB and MAB, (capping at +5 PAB and MAB.) In addition, they gain 1 'Combat Intelligence' stack each time they switch from one weapon type to another."
				GladiatorialMight
					rank="T1"
					name="Gladiatorial Might"
					desc="The Gladiator is a master of Melee combat. If a character attacks them with a Melee attack or Weapon Ability, they gain +1 AC, and +1 DR (up to 2 AC, and 2 DR.) which persists for the rest of the battle."
				CombatFocused
					rank="T1"
					name="Combat Focused"
					desc="This Gladiator has become entirely focused on combat, and glory. For every consecutive turn the Gladiator attacks, the Gladiator gains +1 PDB (capping at +5.) which persists as long as he is attacking."
				Generalist
					rank="T2"
					name="Generalist"
					desc="This Gladiator has trained to become a Generalist. Gladiators are the most capable users of weaponry and general weapon abilities. If this Gladiator deals damage to a creature using a General Ability, The Gladiator gains a combat intelligence stack"
				CombatGenius
					name="Combat Genius"
					rank="T2"
					desc="Whenever this Gladiator utilizies a General Weapon Ability, they may spend Combat Intelligence stacks. For each stack spent, the ability gains +1 to its hit roll (to a maximum of +3), and +5 additional damage (to a maximum of 15)."
				WeaponMaster
					rank="T2"
					name="Weapon Master"
					desc="Whenever a Gladiator attacks with a Melee attack, they gain +1 Combat Intelligence stack."
				CounterAttack
					rank="T2"
					name="Counter Attack"
					desc="Whenever the Gladiator is attacked by a Melee attack, they may spend 45 SP as a reaction, in order to Counter Attack with a Standard Weapon Attack."
				Aggression
					rank="T2"
					name="Aggression"
					desc="Whenever the Gladiator is dealt damage by another creature, they gain +1 Combat Intelligence stack."
				Finisher
					rank="T3"
					name="Finisher"
					desc="This Gladiator is capable of utilizing General Abilities as 'finishers'. Upon doing so, they expend all Combat Intelligence stacks. However, this attack is considered an automatic hit, or in the case of a saving throw, an automatic failure on the defender's part. In addition, it deals 25 additional damage. This requires at least 5 Combat Intelligence Stacks to use. May only be used once per fight."
				Rage
					rank="T3"
					name="Rage"
					desc="This Gladiator is able to convert their stacks to pure fury, entering a Gladiatorial Rage. By consuming 3 Intelligence stacks, They gain +6 PAB. They also gain +5 DR. The user can sustain this by expending combat stacks further past the 3 initial rounds; this cost a Combat Intelligence Stack per turn. During this Rage, they cannot gain any combat Intelligence Stacks. When in this rage they cannot be healed."
				Desperation
					rank="T3"
					name="Desperation"
					desc="If a Gladiator with this feature is reduced to below 25% HP, they gain +1 PAB, +2 DR, +1 AC, and have resistance to Physical, Slashing, Piercing, and Bludgeoning damage until they raise back above 25% HP."
				FullForce
					rank="T4"
					name="Full Force"
					desc="If a creature who is targeted by this Gladiator is above 50% HP, the Gladiator deals 15 additional Damage of the type being delt to them with any attack that they use."
				CoupDeGrace
					rank="T4"
					name="Coup De Grace"
					desc="This Gladiator is an expert at defeating an opponent who is already on their back legs. When this Gladiator attacks a creature who is at 25% or less HP, the attack's to hit roll, or saving throw DC is increased by 2."
				Gunbreaker
					icon='Icons/Perk/Gunbreaker.png'
					cat="Unique"
					name="Gunbreaker"
					rank="T3"
					desc="This Gladiator has trained in the art of the Gunbreaker. They have learned how to use a Gunblade if they have not already"

			Gunplay
				icon='Icons/Perk/Gunbreaker.png'
				name="Gunplay"
				ajob="Gunbreaker"
				rank="T2"
				desc="This Gunbreaker has trained in the art of Gunplay. So long as they are wielding a Gunblade, they gain Combat Intellegence when they attack with a ranged basic attack."
			Triggerburst
				icon='Icons/Perk/Gunbreaker.png'
				name="Trigger Burst"
				rank="T2"
				ajob="Gunbreaker"
				desc="This Gunbreaker has mastered the art of the Trigger Burst. Whenever utilizing a General Weapon Ability, as a bonus action, they may spend 25 SP in order to release a Trigger Burst, thus allowing them to perform another General Weapon Ability of rank C or lower."
			LionHeart
				icon='Icons/Perk/Gunbreaker.png'
				name="Lion Heart"
				rank="T3"
				ajob="Gunbreaker"
				desc="This Gunbreaker has mastered the art of the Gunblade, and due to the ingenuity and courage required to utilize such a difficult to handle weapon, has gained more combat prowess than most individuals. They gain +1 PAB and MAB, as well as +1 AC for each enemy opponent in battle (capping at 5.)"



			Knight
				jobneed="Knight"
				icon='Icons/Perk/Knight.png'
				Knight
					name="Knight"
					cat="Unique"
					desc="The Knight is a warrior that focuses on mitigating incoming damage, and converting it into offensive power through Adrenaline and Heroics. Knights gain 'Adrenaline Stacks' every time they reduce damage, up to 10 stacks of Adrenaline. You may spend 1 Adrenaline stack per turn in order to regain 1d8+CON HP, or in order to add 1d6+STR damage to a single attack, spell, or ability of your choice. Knight's infusion spells may not be stacked with other Jobs' infusion spells. +100 HP, + 20 MP, +50 SP,"
				Resilience
					rank="T1"
					desc="Every time the Knight is damaged by an attack for over 15 damage, they gain +2 impenetrable passive damage reduction. This continues to stack up to passive 10 damage reduction. This bonus lasts until the end of a battle."
				Resolve
					rank="T1"
					desc="A Knight is trained to make the very most of their life-force. A Knight is able to transform physical energy into vitality with sheer resolve. By spending 20 SP, a Knight may regenerate 5d12 HP, once per battle as a bonus action."
				TowerShield
					name="Tower Shield"
					rank="T2"
					desc="The Knight can easily wield a gigantic Tower Shield with one arm, and maneuver another weapon with his other hand simultaneously. The Tower Shield hardly encumbers the Knight at all. Knights do not suffer the Dexterity de-buff from Tower Shields."
				ShatteringBlows
					name="Shattering Blows"
					rank="T2"
					desc="Knights throw their weight around far more than any other Job. They are trained to ensure that each blow is meant to blow past an opponent's defenses, so as to allow them an edge when it comes to outlasting a Melee combatant. When a Knight deals damage to a target with a melee attack or General Weapon Ability, that target is granted 1 stack of 'Shatter' - which lasts for up to 2 rounds. Each stack of 'Shatter' causes the creature to take 1d6 additional damage when dealt damage from any source. Each Shatter stack applied refreshes the cooldown back to 2 rounds. If A creature goes 2 rounds without having Shatter applied, all stacks are lost. A creature may only have up to 3 stacks of Shatter applied at a time, for a total of 3d6 additional damage. If a creature is healed while Shatter stacks are active, all Shatter stacks are lost. (Regeneration does not resolve this effect.)"
				HeavyArmament
					name="Heavy Armament"
					rank="T3"
					desc="The Knight is trained to wear Heavy Armour, as they are meant to be elite solo fighters, serving as their own tank. Heavy Armor no longer grants them any downsides."
				Bladesman
					rank="T3"
					desc="The Knight who focuses on the Blade is far more efficient than one who utilizes ranged weaponry. A Knight who is a trained Blades-man gains +1 PAB, and 5 PDB, so long as they are not utilizing a ranged weapon."
				SteelBody
					name="Steel Body"
					rank="T4"
					desc="The Knight’s body is trained, and toned to resist outside forces attempting to bring it down, a true tank. The Knight is immune to Poison, Break, and Doom."
				UnmatchedResilience
					name="Unmatched Resilience"
					rank="T4"
					pre="Resilience"
					desc="This Knight is more resilient than most, they are now able to gain up to 20 extra damage reduction from 'Resilience', and gain Resilience stacks from any amount of damage."
					cat="Unique"
				KnightofTheParty
					name="Knight of The Party"
					rank="T4"
					desc="A Knight is generally viewed as the 'front liner' of a party, and as such - they are generally counted on to draw in the aggro of the greatest threats, and suffer more blows than their counterparts, to keep the battlefield under control. As such, their body and soul has been tempered to receive aid far more efficiently than others. When they are affected by a friendly Green Magic, they are granted 5 additional HP as restoration. In addition, whenever a healing effect procs on them ; they regain an additional 10 HP in addition to whatever healing or regeneration occurred normally."
				UnmatchedVigor
					name="Unmatched Vigor"
					rank="T5"
					cat="Unique"
					desc="If the Knight's HP reaches zero, they are able to release latent, stored Mana in order to raise their HP back to 40%. Their Mana is also restored up to 50%. This has a 3 OOC day cool-down. Incompatible with 'Hero'."
				Hero
					name="Hero"
					rank="T5"
					cat="Unique"
					desc="This Knight has proven to be incomparably reckless compared to other Knights. Rather than having nigh unstoppable defenses, like their more vigorous counterparts - this Knight has chosen to pursue the path of flashy recklessness, and throws caution to the wind. This, however, grants them the benefit of growing stronger throughout the duration of combat. A Knight with this perk gains +2 STR per round of combat, capping at +6 after 3 rounds, which lasts until the end of battle. Incompatible with 'Unmatched Vigor'."

			Merchant
				jobneed="Merchant"
				icon='Icons/Perk/Merchant.png'
				Merchant
					name="Merchant"
					cat="Unique"
					desc="Merchants start with 6,000 Gil for which to grow their business. You only gain this bonus if you start with your main job as Merchant. +25 HP, +60 MP, +60 SP."
				MerchantT1
					rank="T1"
					name="Craftsmanship"
					desc="This individual is a trained Merchant. They are able to take up 2 crafting roles instead of just one."
				NothingWasted
					rank="T2"
					name="Nothing Wasted"
					desc="This individual knows the value of a brick or a block of wood and never leaves any behind when gathering. Increase the amount of wood or stone gained by 1 per node."
				Salesman
					rank="T2"
					name="Salesman"
					desc="The merchant has studied the art of the sale. When selling items to an NPC they sell the item at 50% the original price instead of 30."
				MasterGatherer
					rank="T3"
					name="Master Gatherer"
					desc="This Merchant understands the importance of gathering, and thus have refined their skill. They proc any Gathering node (Ore node, Hunting Spot, Nature Node, Soil Mound) they gain 2x the resource (+1 to resource if comboed with the gatherer T3 perk)."
				MasteroftheLand
					rank="T3"
					name="Master of the Land"
					desc="This Merchant has dedicated themselves to gathering what they need to maintain their business. When they gather from a node that node has a better chance at getting them what they want increase there rolls by 10."
				Duplicator
					cat="Unique"
					rank="T5"
					name="Duplicator"
					desc="(needs GM present) This Merchant is somehow able to duplicate any item they have seemingly through their connections to the rest of the Merchant world. For 5000 Gil, they can duplicate any crafting material in their inventory - once per day."
				MoogleMerchant
					rank="T5"
					name="Moogle Merchant"
					desc="This Merchant has learned the ways of Moogle culture, and is able to utilize the creatures for various purposes. They gain access to the Moogle Shop verb, which allows them to establish a player run shop that generates 20% extra Gil for each sale. In addition, they gain 'Gatherer' moogles for each gathering type, which they may place in a location of their choosing. Every 24 hours, the Gatherer moogles come off cooldown, and a free gather roll may be made from them."
					cat="Unique"

			Viking
				jobneed="Viking"
				icon='Icons/Perk/Viking.png'
				Viking
					name="Viking"
					cat="Unique"
					desc="Vikings are inherently powerful warriors, and they know how to wield most weapons effectively - but when using a Hammer or an Axe, Vikings gain a certain bonus. Hammers gain 1d4 Bludgeoning damage and +2 to Hit, while Axes gain 2d6+STR Slashing damage. +70 HP, +10 MP, +60 SP,"
				WarriorofGlory
					rank="T1"
					name="Warrior of Glory"
					desc="This individual has initiated their journey on the path of the Viking, and can utilize their Job’s signature resource. They gain 2 'Battle Momentum' every turn that passes in a single encounter. This resets at the end of every mission/event/scene/dungeon."
				CalltoThor
					rank="T1"
					name="Call to Thor"
					desc="This individual takes inspiration from the legend of Thor. They are able to spend 4 Battle Momentum stacks to imbue their weapon with a surge of Lightning that adds 1d6 extra Thunder damage to their Melee attacks, for two turns."
				OdinSight
					rank="T1"
					name="Odin Sight"
					desc="This individual takes inspiration from Odin, the All-Father. They are able to spend 4 Battle Momentum stacks to imbue themselves with the sight of Odin. They are able to gain advantage on Perception checks, and DEX and Reflex saving throws for three turns if they do so. Upon doing so, they also gain +4 AC for 3 rounds."
				MidgarsormrSlayer
					rank="T1"
					name="Midgarsormr Slayer"
					desc="This individual takes inspiration from tales of slaying great beasts. They are able to spend 8 Battle Momentum stacks to add +4 to all strength-based attacks and damage rolls against creatures larger than themselves, as well as advantage on strength saving throws."
				Tyrsjustice
					rank="T2"
					name="Tyr's Justice"
					desc="This individual takes inspiration from the tales of Tyr, the Norse Justicar. They are able to spend 8 Battle Momentum stacks in order to give themselves a thorns aura, which reflects half damage to all targets within melee range whenever hit by a melee attack, ignoring up to 30 points of reduction. This aura lasts for 3 turns."
				Skaadishunt
					rank="T2"
					name="Skaadi's Hunt"
					desc="This individual takes inspiration from the tales of Skaadi, the Huntress. They are able to spend 6 Battle Momentum stacks to give themselves +2 Tile Movement per turn for two turns, so long as they are not running away. If they are chasing one person, they can opt to spend 2 extra Battle Momentum to gain one more tile."
				Glorystance
					rank="T3"
					name="Glory Stance"
					desc="This individual has learned to become even more exhilarated than the average Viking. They are able to shift to a stance that doubles all damage that they receive from outside sources. They are given an additional 2 Battle Momentum per turn, and their Critical Range is changed to 15-20. Takes an action to enter, and disables other actions for that turn."
				FrostGiantVigor
					rank="T3"
					name="Frost Giant's Vigor"
					desc="This individual takes inspiration from the tales of the Frost Giants of Jotunheim. They are able to spend 4 Battle Momentum stacks to regain 100 MP, and reinvigorate themselves."
				WarriorRebound
					rank="T3"
					name="Warrior Rebound"
					desc="This individual bounces back in the face of adversity, hard. Whenever they take more than 20 damage from a single attack, they gain half the damage as Battle Momentum stacks (capping at 15)."
				GloriousFall
					rank="T4"
					name="Glorious Fall"
					desc="This individual has learned to be exhilarated even in the face of death. If they drop below 30 HP, they gain immunity to Bludgeoning, Slashing, and Piercing damage, as well as resistance to all Elemental damage for 4 turns. After 4 turns, if they haven’t taken enough damage to kill them outright, they regain +40 HP but cannot use this feature for 24 OOC hours."
				InspiringWarrior
					rank="T4"
					name="Inspiring Warrior"
					desc="This individual is an inspiring warrior, able to lead the charge like no other can. They are able to reinvigorate even their allies through their excitement! By spending 15 Battle Momentum stacks, they can restore 60 HP to all party members (up to 5), and boost their AC, and to hit +2 for three turns."
				TrueWarrior
					rank="T5"
					name="True Warrior"
					cat="Unique"
					desc="This individual is a Viking unmatched. When they drop below 30 HP, they immediately gain 10 Battle Momentum stacks, and gain 5 additional stacks whenever they take or deal damage. Additionally, use a Bonus Action for Stay in It while True Warrior is active."



			Bard
				jobneed="Bard"
				icon='Icons/Perk/Bard.png'
				Bard
					name="Bard"
					cat="Unique"
					desc="Bards are completely immune to the 'Silence' status effect, as their voices and instruments can not be stifled. Utilizing an instrument requires both hands, disabling weapon and shields from being equipped or used. +25 HP, +60 MP, +20 SP."
				ProjectionTraining1
					rank="T1"
					name="Projection Training I"
					desc="This individual has learned to project their range allowing songs to effect a larger radius. Songs now affect friendly targets within 4 tiles of the bard."
				ProjectionTraining2
					rank="T2"
					name="Projection Training II"
					desc="This individual has learned to project their range allowing songs to effect a larger radius. Songs now affect friendly targets within 5 tiles of the bard."
				ProjectionTraining3
					rank="T3"
					name="Projection Training III"
					desc="This individual has learned to project their range allowing songs to effect a larger radius. Songs now affect friendly targets within 6 tiles of the bard."
				Vocalist
					rank="T2"
					name="Vocalist"
					desc="This individual has opted to use their voice as an instrument. This frees up their hands, allowing them to utilize a Weapon or Shield but makes them unable to speak without stopping the song and losing its effects ; meaning that they can not cast Magic abilities while singing."
				Overture
					rank="T2"
					name="Overture"
					desc="The first song used during an encounter can be started at half cost."
				Encore
					rank="T3"
					name="Encore"
					desc="If a song has been sustained for at least 3 turns the bard can switch to another song for half the startup price."
				HarmonicHaste
					rank="T3"
					name="Harmonic Haste"
					desc="This individual has learned to play songs with as little movement as possible. Sustaining a song no longer takes a bonus action, however a bonus action is still required to start up a song."
				MuseBlessing
					rank="T4"
					name="Muse's Blessing"
					desc="This individual gains a shield around their being when they are performing a song. As long as a Song is being sustained, the Bard gains the 'Shell' status effect at no additional cost."
				MasterofMedley
					name="Master of Medley"
					desc="This individual has learned how to mix songs together. They are able to apply the effects of two songs at once (they must be two different songs). They may still only apply one Chord effect, however."
					rank="T5"

			Dancer
				jobneed="Dancer"
				icon='Icons/Perk/Dancer.png'
				Dancer
					name="Dancer"
					cat="Unique"
					desc="The Dancer is able to switch between the 'Waltz' and the 'Tango' stance in order to change the bonus that they gain whilst sustaining a dance. When in 'Waltz' stance, they gain +1 AC. When in Tango stance, they gain +1 PAB. It takes one full turn to change stances, and you may select one stance on your first turn of a battle, as a free action. All Dances count as a Bonus Action to activate and a Free Action to sustain, unless otherwise stated. +20 HP, +80 MP, +20 SP."
				EvasiveSteps
					rank="T1"
					name="Evasive Steps"
					desc="While performing a dance the dancer is focused on its target. Attacks made by the target to the dancer suffer disadvantage. (This only applies to single target attacks, AoEs are unaffected.)"
				DextriousUse
					rank="T1"
					name="Dextrious Use"
					desc="The dancer moves with such grace that any weapon in their hand is a weapon of finese. A Dancer may add their DEX mod to their  PDB and PAB as a Global Modifier. This applies only to weapons that do not scale with DEX."
				DanceLikeWater
					rank="T3"
					name="Dance Like Water"
					desc="This individual is able to flow like water when they dance. They are able to dance even while moving at top speed, moving elegantly from side to side and making complex bodily maneuvers. The Stun status effect does not disrupt a Dancer's dance sustain. While sustaining a Dance, this character gains 1 additional Tile Movement per turn, and +1 AC.."
				ImpeccableBalance
					rank="T3"
					name="Impeccable Balance"
					desc="Through years of perfecting their balance giving them impeccable poise. They are immune to being knocked prone, and gain advantage on any saves that involve knockback, as well as all Reflex saving throws."
				DanceWasMadeForMoreThanOne
					rank="T4"
					name="Dance Was Made for More Than One"
					desc="While sustaining a Dance, the Dancer is able to pick two targets instead of one for their Dance's status infliction."
				FinishingFlourish
					rank="T4"
					name="Finishing Flourish"
					desc=" If a dancer has sustained a single dance for at least 3 turns they can end their dance with a powerful finisher. A finisher will add 80 damage to the damage of any ability the Dancer directs towards a target of their current dance, at the cost of ending the dance and putting all Dances on a 3 turn cooldown."
				ImprovMaster
					rank="T5"
					name="Improv Master"
					desc="This individual has learned to improvise thier movements essentially mixing two types of dances at once. When dancing they can use 2 dances at the same time. This does not interrupt or refresh the build-up for Finishing Flourish."


			WhiteMage
				jobneed="White Mage"
				icon='Icons/Perk/White Mage.png'
				WhiteMage
					name="White Mage"
					cat="Unique"
					desc="A White Mage may activate the Regeneration status effect upon themselves and all party members for free as a standard action, once per OOC day. In addition, after casting a White Magic spell - they may cast an additional White Magic spell of 1 rank lower as a bonus action the next turn. +10 HP, +80 MP, +20 SP."
				LastingSupport
					rank="T2"
					name="Lasting Support"
					desc="A White Mage's supportive abilities have immense staying power. A White Mage's MP cost for using E, D and C rank White Magic Abilities is 0, 5, and 15 respectively. B rank and higher White Magic Abilities have their costs reduced by 25 for a White Mage."
				SecretoftheLily
					rank="T3"
					name="Secret of the Lily"
					cat="Unique"
					desc="This individual has learned an ancient art of healing. They have learned to harness the ambient magic formed from a battle into crystalline lilies that can be spent on healing magic to aid their side. For every 3 rounds of combat a lily is grown on the user. A maximum of 3 lilies can be held at a time. A lily can be expended as a free action once per turn, to cast a C Rank or lower White magic spell at half cost."
				WhiteLight
					rank="T3"
					pre="Lasting Support"
					name="White Light"
					desc="A White Mage of this individual's level is able to unleash the true power of White Magic. While sacrificing the MP reduction of Lasting Support, the user can cast any healing or status cleansing White Magic as an AoE to effect multiple friendly creatures, increasing the radius by +1 per CHA mod. Per every tile extended past the spells base radius, increase MP cost by 10. Requires Lasting Support."
				SupportSpecialist
					name="Support Specialist"
					rank="T3"
					desc="This individual has delved into the arts of green magic. They are capable of learning up to B rank green magic."
				QuickSupport
					rank="T3"
					name="Quick Support"
					desc="The individual has learned to cast their support actions quick. They can cast 'Status Cleansing' White Magic abilities as a bonus action instead of a standard action."
				DualSupport
					rank="T4"
					name="Dual Support"
					desc="Once per turn this individual can cast a White Magic skill of C Rank or lower as a free action, with no cost, ."

			BlueMage
				jobneed="Blue Mage"
				icon='Icons/Perk/Blue Mage.png'
				BlueMage
					name="Blue Mage"
					cat="Unique"
					desc="The Blue Mage is in tune with the magical energies of the world around them, able to actively sense and interpret them. A Blue Mage gains the ability to sense any creature within 5 tiles of them passively, and is able to understand the emotions of Monsters due to their connection to the flow of Mana around them. In addition, a Blue Mage may spend 40 Mana as a reaction to an incoming Spell Attack Roll, and store it away using 'Retain' - then use it at a later date if they know the 'Rebound' spell. They may only store one spell, and it must be a purely magic based attack. Weapon abilities may not be caught. The stored spell uses the original 'to hit' roll and damage roll, as well as any other of its original effects, when casted using 'Rebound'. A stored spell fades after 5 rounds if not used, or if battle ends. This can not capture B-S Rank spells. +30 HP, +50 MP, +30 SP."
				MasterMime
					name="Master Mime"
					cat="Unique"
					rank="T5"
					desc="This individual has superb memory and can memorize up to 3 abilities they have used previously through mimicry. These abilities are permanent and once committed cannot be replaced. They are capable of passing on these abilities assuming the student has the requirements to learn them."

			BeastMaster
				jobneed="Beast Master"
				icon='Icons/Perk/Beastmaster.png'
				BeastMaster
					name="Beast Master"
					cat="Unique"
					desc="The Beastmaster is in tune with nature, they have somewhat heightened senses - and are able to track a given target through the wilderness or even a city as long as they have their scent or know their mannerisms. They are expert trackers. They gain advantage on Animal Handling, and Survival Rolls. In addition they pick a beast type they know best, gaining +2 AC and to Hit against creatures of that type. A Beast Tamer can only tame monsters from their chosen classification. (Chosen Type: ) +40 HP, +30 MP, +30 SP."
				WildSense
					rank="T1"
					name="Wild Sense"
					desc="A Beast Master has a natural understanding of monsters and their behaviors through study of body language and their environments, capable of deducing the attitude and behaviors of monsters through careful study of their target. A Beast Master may use Insight Checks to determine the attitude, behaviors, and any abnormalities related to such. If the Beast Master specializes in the beast type they gain advantage on this roll."
				WildEmpathy
					rank="T1"
					name="Wild Empathy"
					desc="A Beast Master has a natural ability to connect with monsters, displaying a unique connection with nature as to mimic the necessary behaviors to seemingly communicate with beasts on a mundane level. A Beast Master may use Charisma Skill Checks on beasts to limited effect. If a Beast Master specializes in the beast type they gain advantage on this roll. If they do not they must succeed a DC 15 + Monster Rank Wild Sense check or roll at disadvantage. (Monster Rank D = 1, C = 2, etcetera)"
				VeterinaryTraining
					rank="T2"
					name="Veterinary Training"
					desc="This Beast Master has studied not only the behaviors of Monsters but their anatomy as well. A Beast Master may use this knowledge both to aid their monsters and to harm others. As a standard action the Beast Master may perform triage on an adjacent monster once per 3 rounds, healing it for Rank Bonus d10 HP or removing 1 status effect. They may alternatively use their action to perform a Perception Roll against a monster to determine if it has a weakness. Gain Advantage against monsters they specialize in."
				ExpandedSpecialty
					rank="T3"
					name="Expanded Specialty"
					desc="This Beast Master has expanded their knowledge base, and have mastered their art to the point of being able to tame an additional monster classification."
				PackLeader
					rank="T2"
					name="PackLeader"
					desc="This Beastmaster has opted to learn the ways of bringing a larger variety of beasts under their control, taming a pack of monsters to hound their foes from all sides for both quantity and versatility in their form. Pack Master can summon 2 monsters at a time and can tame D rank or lower monsters. They can also learn Command abilities. Incompatible with Lone Wolf."
				ExpandedStudy
					rank="T2"
					name="Expanded Study"
					pre="PackLeader"
					desc="The Pack Master understands the value in variety and flexibility a more diverse group of monsters brings, as well as how to cover their weaknesses in combat. The Pack Leader gains an additional classification of monsters to specialize in."
				ExpandedPack
					rank="T3"
					name="Expanded Pack"
					pre="PackLeader"
					desc="The Pack Master has grown in power, and as such carries a more imposing presence among monsters. Able to exert their dominance over a larger pack as a result of their ability, the Beast Master can now summon a third monster at a time, but it must be 1 rank lower than their highest tameable rank. They can now tame up to C rank monsters."
				PackTactics
					rank="T3"
					name="Pack Tactics"
					pre="PackLeader"
					desc="The Pack Master is an expert of directing his beasts from a horde of monsters into an organized pack of hounding beasts, capable of overwhelming their opponents with ease. They and their monsters gain the Pack Tactics ability, applying a -1 to hit and -1 to AC against opponents they have attacked in the last round for each monster they have summoned."
				WildCaller
					rank="T4"
					name="Wild Caller"
					pre="PackLeader"
					desc="The Pack Master has reached the pinnacle of their ability, a true master of the wild and over his pack. They can now tame up to B rank monsters."
				LoneWolf
					rank="T2"
					desc="This Beastmaster has opted to prioritize their skills in raising a smaller number of monsters, spending their time specializing their beasts to make their talents shine. Their companions are true threats, rivaling the power and potency of summoners of equal level. This Beastmaster can summon 1 Monster at a time, and can tame C rank or lower Monsters and their monsters have an additional training slot. Incompatible with Pack Leader."
				Unified
					rank="T3"
					name="Unified"
					pre="LoneWolf"
					desc="The Lone Wolf has furthered their bond with their small group of monsters, prioritizing their power and bond over variety and flexibility. This Beast Master can now Tame up to B rank monsters. The Lone Wolf can also learn C rank and lower Blue Magic from their monsters, but can only use spells learned from their currently summoned partner."
				FightAsOne
					name="Fight As One"
					rank="T3"
					pre="LoneWolf"
					desc="The Lone Wolf is an expert at fighting alongside their monsters, capable of keeping up in melee with even the most ferocious of their beasts. The Lone Wolf gains flanking bonuses so long as they and their monster are adjacent to the same enemy, regardless of position. Can not proc the same time as Tag Team."
				TagTeam
					rank="T3"
					name="Tag Team"
					pre="LoneWolf"
					desc="The Lone Wolf is an expert at working together to synchronize their attacks with their beasts, hounding their foes to ensure attacks land. When the Lone Wolfor Monster attacks a target with a single target attack they apply a mark of ‘vulnerable’, giving the other +4 to hit the vulnerable target and +8 Damage. Only 1 target can be marked at a time and only 1 mark can be had at a time. A Mark can not be applied the same round it is activated. Can not be used at the same time as Fight as One."
				TrueMonster
					rank="T4"
					name="True Monster"
					pre="LoneWolf"
					desc="The Lone Wolf has ascended to the status of being a true monster, one with their beasts and capable of fighting with a true ferocity and style identical to that of their partner. This Beast Master may now learn and use Blue Mage skills from their Monsters up to B rank. They can only be used so long as the monster who knows the skill is their summoned partner."
				MightOfTheWild
					rank="T4"
					name="Might Of The Wild"
					pre="LoneWolf"
					desc="The Lone Wolf has attained a mastery in beast taming few have achieved and are now capable of commanding all but the strongest of monsters. This Beast Master can tame up to A Rank Monsters. A Rank Monsters may have additional requirements to tame them beyond the normal."
				BeastUnchained
					rank="T4"
					name="Beast Unchained"
					pre="LoneWolf"
					desc="The Lone Wolf and their partner have ascended above the role of master and pet. The Lone Wolf’s partner monster can continue to fight for a number of  rounds equal to the Beast Master’s Charisma Modifier before being recalled."

				//Pre-Rework stuff. To be removed once we are sure we have no beast masters with any of these perks.
				CatchandControl1
					name="Catch and Control I"
					rank="T1"
					cat="Unique"
					desc="This individual is able to catch, and train D rank monsters. This individual can actively control one monster at a time."
				CatchandControl2
					name="Catch and Control II"
					rank="T2"
					cat="Unique"
					desc="This individual is able to catch, and train C rank monsters This individual can actively control two monsters at once."
				CatchandControl3
					name="Catch and Control III"
					rank="T3"
					cat="Unique"
					desc="This individual is able to catch, and train B rank monsters"
				CatchandControl4
					name="Catch and Control IV"
					rank="T4"
					cat="Unique"
					desc="This individual is able to catch, and train A rank monsters. This individual can actively control three monsters at once."
				CatchandControl5
					name="Catch and Control V"
					rank="T5"
					cat="Unique"
					desc="This individual is able to catch and train S rank monsters."
				LegendaryControl
					name="Legendary Control"
					rank="T6"
					cat="Unique"
					desc="This individual is able to catch and train a single legendary boss monster in their life-time, and maintain full control over it if they have the skills to catch it."
				MasteredScent
					name="Mastered Scent"
					rank="T1"
					cat="Unique"
					desc="This individual has a heightened sense of scent. Through spending time with the natural world and its creatures they have taken on this adaptation. They are capable of memorizing a number of scents equal to their Intelligence stat. They are capable of tracking and recognizing these scents as long as there is some undisturbed trail."
				NaturalStudy
					name="Natural Study"
					rank="T2"
					cat="Unique"
					desc="This individual is capable of diving deep into study of a specific creature. They spend a day gathering knowledge on that creature in specific and roll a naturalist skill check. On a successful roll the individual has “knowledge” on that creature letting them know everything about it including stats and abilities. They also gain advantage on rolls trying to catch the creature."
				BestialLink
					name="Bestial Link"
					rank="T4"
					cat="Unique"
					desc="The user has an energetic link to a monster under their control. They are able to determine the emotional state of the monster and determine its basic thoughts. Any positive status effect applied to either the user or the monster is shared between the two. They are also able to give commands mentally and do not need to use their bonus action to do so anymore. This link is active for up to a mile between the user and their creature."

			Samurai
				jobneed="Samurai"
				icon='Icons/Perk/Samurai.png'
				Samurai
					cat="Unique"
					name="Samurai"
					desc="The Samurai is a master of not only attacking with, but defending with the blade - able to use their weapon to defend themselves. When using some type of Sword, a Samurai gains +1 AC, and +1 PAB and MAB. +65 HP, +30 MP, +70 SP."
				Quickdraw
					rank="T1"
					name="Quickdraw"
					desc="The Samurai is able to switch their weapon from one type, to Katana type by spending only a Bonus Action. The Samurai's first attack in an encounter gains Advantage. Additionally, the first attack made after switching from a non Katana weapon type to a Katana gains advantage. (+1 to hit when using a Katana, and switching to or from a Katana is a bonus action.) "
				Hasso
					rank="T2"
					name="Hasso"
					desc="The samurai has trained in many different duelist styles for katanas. Whenever a Katana, Dagger, Longsword, Greatsword, Buster Sword, Gunblade, or Whip Blade is being wielded, this individual can add a bonus 3 to PDB."
				Katsuryu
					rank="T3"
					name="Katsuryu"
					desc="The Samurai has trained to use their blade in a defensive manner, just as much as an offensive one. While wielding a Katana, this Samurai gains +1 AC, and +3 Damage Reduction. In addition, they may use their Reaction in order to make an attack roll with their weapon, and reduce the damage of a -single- instance of damage rolled towards them on the round it is used. This reduction is capped at 40 points before the following modifications: If used against a Melee ability, the reduction is increased by another 10 ; and the Samurai has effective resistance against the attack, if used against a Magic or Ranged ability, it is decreased by 10. Doing so costs 25 SP."
				Zanshin
					rank="T3"
					name="Zanshin"
					desc="Once per turn if the samurai misses with a weapon based attack they are able to immediately follow up with the same attack as a free action, ignoring that attack's cooldown - but placing it on cooldown after the second attempt, if it has one."
				ThirdEye
					rank="T4"
					name="Third Eye"
					desc="This individual has activated their third eye and is capable of seeing moments into the future allowing super human precognition. While third eye is active, it grants the user +4 to AC. Third Eye deactivates after an attack has been made against this individual. Third eye recharges at the end of the user's turn."
				Yaegasumi
					rank="T5"
					name="Yaegasumi"
					desc="Everytime an attack aimed at this individual misses or a reaction is used. (This accounts for single target or AoE) they gain an instance of Yaegasumi. On their next turn they can use Yaegasumi to reduce the cost of their physical abilities making them cost 10 less for each point spent. They can also spend 3 points to gain another bonus or reaction action, or 5 to gain another standard action. At the end of the individual's turn they lose all yaegasumi points."
				Bushido
					rank="T3"
					name="Bushido"
					cat="Unique"
					desc="This individual has learned a fighting style based on holding their actions and waiting for the perfect moment. They store all the energy not used during a round capable of releasing this energy as powerful attacks. A number of Ken points are added to a character each round depending on what they hold back. Bonus Action = 1 point, Reaction = 1 point, Standard action = 2 points, Movement action = 2 points. The maximum amount of points stored is equal to the users dexterity stat, and all points are lost upon exiting combat. Ken points can be spent on powerful bushido abilities. Utilizing the Retaliate or Iaido Stance abilities generates 1 Ken point."


			Paladin
				jobneed="Paladin"
				icon='Icons/Perk/Paladin.png'
				Paladin
					name="Paladin"
					cat="Unique"
					desc="As champions of he light, and holy aspects of the world - a Paladin gains great power and resolve from their courage. Paladins take half damage from Light attacks, and negative status ailments last 1 turn less than usual. Paladins may learn up to C Rank White Magic, and D rank Green Magic inherently. Paladin's infusion spells may not be stacked with other Jobs' infusion spells. +90 HP, +40 MP, +30 SP, Sword Saint, White Magic and Green Magic all count as Paladin Abilities for the sake of effects referencing Paladin Abilities."
				BathedinLight
					rank="T1"
					name="Bathed in Light"
					desc="The Paladin is blessed by Holy Light. They gain more health when healed. | The Paladin is able to gain an extra +20 HP from all spells and abilities which grant healing. (This includes Life-Steal Effects.) This does NOT however include passive healing effects OR items. (Such as the Regen Status, Potions, etc) |"
				HolyMight
					rank="T2"
					name="Holy Might"
					desc="The user becomes the embodiment of Holy Light and is able to transfer said light into their weapon. | The Paladin is able to add the Holy Element to any attack for free. In addition to this, they may spend 10 MP to gain a temporary +2 PAB or MAB to an attack roll after it’s already been rolled, once per round. |"
				DivineRetribution
					rank="T2"
					name="Divine Retribution"
					desc="The Paladin is able to apply Divine Judgement upon their foes. Using Holy Magic to summon a Blade of Light down on those who would harm their allies. | Free Action AFTER using the Cover Ability (12d6 Damage (Holy) | Fortitude Save ( DC17) | Full damage on a Failed save, Half on a Successful one. | (Cost: 15 MP | 2 Round Cooldown.)"
				IndomitableSpirit
					rank="T3"
					name="Indomitable Spirit"
					desc="The individual has been gifted by the light, which protects them in times of danger. | The Paladin upon dropping below 50% of their maximum HP gains the “Protect” status effect immediately as well as granting resistance to Physical, Dark, and Force Damage.|"
				BlessingofAltruism
					rank="T3"
					name="Blessing of Altruism"
					desc="The Paladin is blessed by the Lifestream when they protect others. | As a Free Action after using the Cover Ability, the Paladin is able to spend MP to immediately heal themselves 50 HP while also applying the “Regen” status to themselves. | (Cost: 10 MP | 3 Round Cooldown.)"
				Templar
					rank="T3"
					name="Templar"
					desc="This individual is a Templar, a Holy warrior. They are able to learn up to B rank White magic, and C rank Green magic."
				EngulfedinLight
					rank="T3"
					pre="Bathed in Light"
					name="Engulfed in Light"
					desc="This individual is blessed by a holy light. They gain more health than others when being healed by magic, increasing the bonus from healing spells to 25, and are granted a 10 HP temporary shield whenever they are healed."
				Altruism
					rank="T4"
					name="Altruism"
					desc="When in a highly injured state the paladin musters what strength they have left to defend those around them granting +10 damage reduction when under 30% HP."
				SecondChance
					rank="T5"
					name="Second Chance"
					desc="Once per life-time, if a Paladin has been deemed truly blessed by the light - if they die, they will resurrect at the nearest crystal to the location of their death. This perk is removed once it has been used."

			DarkKnight
				jobneed="Dark Knight"
				icon='Icons/Perk/DarkKnight.png'
				DarkKnight
					name="Dark Knight"
					cat="Unique"
					desc="Dark Knights are inherently connected to their inner darkness, harnessing it for either good or evil. A Dark Knight wields the power of both self and external destruction for their goals. Dark Knight infusion spells may not be stacked with the infusion spells of other Jobs. +80 HP, +35 MP, +40 SP. Dark Knights take half damage from Darkness attacks."
				DarkResistance
					rank="T1"
					name="Dark Resistance"
					desc="The Dark Knight has trained to push themselves against crippling ailments that come with their dark arts. If the Dark Knight possesses this perk and any of the following abilities, Immolate Self, Frozen Heart, Weight of the World and Exhaust Soul; they gain Resistance to Burn, Frostbite, Heavy and Bleed respectively. If these self-inflicted ailments are active, their associated status resistance becomes Immunity."
				Masochist
					rank="T2"
					name="Masochist"
					desc="For every self-inflicted Dark Knight negative status that they suffer from; the Dark Knight gains an increase of +1 of Tile Movement, +1 to their MAB, and PAB, and +2 to their MDB and PDB. This applies to Immolate Self, Frozen Heart, Weight of the World and Exhaust Soul."
				Bloodthirst
					rank="T2"
					name="Bloodthirst"
					desc="After 3 successful melee attacks, the Dark Knight’s 4th attack restores HP equal to the damage dealt to the target. This is considered as its own Lifesteal proc."
				DarkArts
					rank="T2"
					name="Dark Arts"
					desc="The Dark Knight is trained not only in drawing out the power of their inner darkness for physical combat, but also the magical purposes of it as well. The Dark Knight with this perk gains access to the “Dark Arts” ability, granting them access to D Rank spells in both Black and Arcane Magic. Dark Arts allows the user to substitute any amount of MP from a General, Black or Arcane spell with HP, draining only what is left from their MP afterwards. If at least 5 HP is spent, the spell’s damage type is changed to “Dark” - and the damage the spell deals is increased by 8."
				BlackerthanBlack
					rank="T3"
					name="Blacker than Black"
					desc="The individual has been steeped in darkness for so long that they have become one with darkness itself. This allows the owner of this perk to absorb any Dark damage they take, healing half of the damage that would have been dealt to them."
				UnendingHunger
					rank="T3"
					name="Never Ending Hunger"
					desc="The Dark Knight has become accustomed to absorbing the life force from others. Whenever a Dark Knight procs a Lifesteal effect from the Dark Knight perk or ability list; they restore an additional +20 HP to any HP they drained."
				OnewiththeDarkness
					rank="T3"
					name="One With the Darkness"
					desc="The individual truly embodies the title of Dark Knight. When engulfed in the shadows, darkness or at nighttime; the individual becomes one with the night itself, gaining advantage on Stealth Checks, and a +2 AC"
				Moxie
					rank="T4"
					name="Moxie"
					desc="When an enemy is defeated, the Dark Knight is able to absorb the downed foe’s hatred into themselves, increasing their power. This grants the Dark Knight a stack of Moxie which grants a +5 to all Damage Calculations. The Dark Knight gains +1 Moxie from every player KO, and +1 Moxie from every 2 NPC/Monster KOs. This bonus continues as long as the Dark Knight continues to fight, and fades once combat ends."
				DarkMagus
					rank="T4"
					name="Dark Magus"
					cat="Unique"
					desc="This individual has taken a different path. They have studied the dark arts, but have learned to wield it with magic instead of martial strength. They gain access to A rank black magic, and can expend HP instead of MP for casting spells (Or any mix of the 2). Characters who also have the 'Dark Arts' perk halve the cost of spells cast using HP as a resource.."



			Machinist
				jobneed="Machinist"
				icon='Icons/Perk/Machinist.png'
				Machinist
					name="Machinist"
					cat="Unique"
					desc="Machinists are masters of machinery, and technology. They are able to dismantle any piece of technology depending on its size (1 turn for inventory sized objects, 2 for person sized, 4 for 10 foot+, 5 for 20 foot+, 10 for 30 foot+, 12 for 50 foot+.) They must be uninterrupted when doing so. Upon doing so, they salvage every ingredient that was required to build said piece of tech. In addition, Machinists gain +2 INT. +30 HP, +30 MP, +30 SP."
				Documentation
					rank="T1"
					name="Documentation"
					desc="This individual is capable of creating Manuals which allow the reader to gain the Machinist weapon proficiency, and are then consumed."
				Quickswap
					rank="T1"
					name="Quick Swap"
					desc="This Machinist is able to utilize their Bonus Action to switch between one Machinist weapon and another, at the cost of 5 SP."
				BasicMachinaWeaponsmith
					rank="T1"
					name="Basic Machina Weaponsmith"
					desc="This individual is capable of creating the basics of what every self respecting machina gunsmith can make. (Rudimentery guns like pistols/rifles, small bio blaster, chainsaw)"
				BasicAmmosmith
					rank="T2"
					name="Basic Ammosmith"
					desc="This individual is capable of infusing bullets with the basic elements of fire, water, earth, thunder as well as basic scattershot shells and low quality AP rounds."
				AdvancedMachinaWeaponsmith
					rank="T3"
					name="Advanced Machina Weaponsmith"
					desc="This individual has progressed in the creation of the traditional weapons of machinists. (Advanced guns and upgraded variants of their basic inventions)"
				Terraformer
					rank="T3"
					name="Terraformer"
					desc="This Machinist has learned how to make 'Terraforming' machines; i.e, Node Refreshers. When used, these Node Refreshers will reinvigorate used up Gathering nodes within a 3x3 radius of the user."
				AdvancedMachinaAmmosmith
					rank="T4"
					name="Advanced Machina Ammosmith"
					desc="This individual has become capable of creating all the elements as well as upgraded scattershot shells and high quality AP rounds."
				NethiciteAmmosmith
					cat="Unique"
					rank="T5"
					name="Nethicite Ammosmith"
					desc="This individual has discovered and become able to refine nethicite into bullets to be used within guns to deal 2x damage and force it to make a DC15 fortitude save or be stunned for the next round."
				InitiateRobiticist
					rank="T2"
					name="Initiate Roboticist"
					desc="This individual is capable of creating basic magitek troopers and small robots to a limit of two total."
				ExperiencedRoboticist
					rank="T3"
					name="Experienced Roboticist"
					desc="This individual has become capable of creating advanced magitek troopers and large robots with the same limit. (Must already have Initiate Roboticist)"
				ArmorEngineer
					rank="T4"
					name="Armor Engineer"
					desc="This individual has learned how to create and support the weight of a bipedal weapons platform in various models for combat."
				MechaEngineer
					rank="T5"
					name="Mecha Engineer"
					desc="This individual has learned how to utilize Magitek technology to a superb degree. They are able to create hundred foot tall Mecha Magitek Armor, that have immense power. These Mechas require an immense amount of resources to build, but are unrivaled in horse-power."
				VehicleMechanic
					rank="T2"
					name="Vehicle Mechanic"
					desc="This individual is able to make basic land vehicles, such as Land Rovers - and they can potentially augment their Rovers with custom parts."
				Shipwright
					rank="T2"
					name="Shipwright"
					desc="This individual is able to make naval vehicles, such as Ships - and they can potentially augment their Ships with custom parts."
				BehemothMechanic
					cat="Unique"
					rank="T3"
					name="Behemoth Mechanic"
					desc="Pushing their knowledge to the limits this individual can create massive wheeled vehicles."
				AirshipEngineer
					rank="T4"
					name="Airship Engineer"
					desc="This individual has learned the art of aerodynamics. They are able to design ships that can traverse the skies, and add onto them in time."

			Summoner
				jobneed="Summoner"
				icon='Icons/Perk/Summoner.png'
				Summoner
					name="Summoner"
					cat="Unique"
					desc="Summoners are masters of sharing and utilizing their Mana in order to empower others, and their Summons. As a result, a Summoner becomes a 'Mana Bank' - able to freely transfer points of their MP to party members, and monsters. Doing so is a bonus action. +10 HP, + 90 MP, +10 SP."
				PartialSummon
					rank="T2"
					name="Partial Summon"
					desc="Summon one of your lasting type summons as an attack type letting them use a single ability before disappearing. The cost for this is the cost of the attack used plus an extra 5 MP needed to summon the creature. Uses a Standard action."
				NoRest
					rank="T2"
					name="No Rest"
					desc="The summoner has learned to call their eidolon early. They are able to halve the time it takes for a summon to cool down."
				GrandSummon
					rank="T3"
					name="Grand Summon"
					desc="When summoning a Summon, the Summoner may use their bonus action in order to spend 50 SP in order to infuse their own life-force into the summoning process. That energy is then amplified, and released from the summoner as a 3x3 AoE around the summon's point of summoning, dealing 40 true damage to enemy target creatures."
				DimensionalRegeneration
					rank="T3"
					name="Dimensional Regeneration"
					desc="When in their native dimension, Summons are able to heal much quicker than in our plane. When not on the field, Summons are treated as having the 'Regen' Status effect, restoring HP so long as their either neither KOed or on the field of battle."
				DimensionalRefreshment
					rank="T3"
					name="Dimensional Refreshment"
					desc="When in their native dimension, Summons are able to rest much quicker than in our plane. When not on the field, Summons are treated as having the 'Refresh' Status effect, restoring SP and MP so long as their either neither KOed or on the field of battle."

				DualSummon
					rank="T4"
					name="Dual Summon"
					desc="This individual has trained long and hard. They have learned to summon and sustain two Espers at once with a significant mana drain leaving anyone without enormous pools of mana exhausted. This grants permanent +100 to MP pool. (Pre-requisite: May not Sub/Dual Job.)"

			Chemist
				jobneed="Chemist"
				icon='Icons/Perk/Chemist.png'
				Chemist
					name="Chemist"
					cat="Unique"
					desc="A Chemist has worked with noxious fumes and different gasses and liquids all their life, giving them a very high tolerance towards poisons. They start with immunity to poison. +30 HP, +30 MP, +30 SP."
				CombatSynthesis
					rank="T1"
					name="Combat Synthesis"
					desc="This Chemist is able to use their support based potions combatively. Rather than having to consume them, they are able to magically change the Potion item in question into a spray, and apply it to party members within a 5x5 radius of their current position when used. If used for a Chemist item that restores HP, MP, or SP - the restoration is reduced by 15 points when used in this way."
				MassPoison
					rank="T2"
					name="Mass Poison"
					desc="This individual has learned how to transform their poisons into a gaseous form. Rather than applying them to a weapon, they may now release them as a 5 tile cone saving throw attack, inflicting the given status effect on a failed saving throw, with a flat DC of 20. Doing so is a Standard action."
				BombCraft
					rank="T1"
					name="Bomb Craft"
					desc="This Chemist is able to create Elemental Bomb Bags, which store small gems of a particular elemental affinity that explode when introduced to extensive physical force."
				PotionLore
					rank="T1"
					name="Potion Lore"
					desc="The individual has studied the creation of health restoring potions, and are able to make a basic Potion."
				EtherLore
					rank="T1"
					name="Ether Lore"
					desc="This individual has studied the creation of mana restoring mixtures. They are able to make a basic ether that can restore a fair amount of mana to whoever drinks it."
				SilenceLore
					rank="T1"
					name="Silence Lore"
					desc="The individual has studied the effects of Silence. They have learned to create a mixture of herbs that will cure the ailment. The herbs must be ingested by someone suffering from the ailment. They have also learned to create a poison that can be applied to a weapon to induce the effect."
				BlindLore
					rank="T1"
					name="Blind Lore"
					desc="The individual has studied the effects of Blind. They have learned to make a mixture that can be used as eye drops curing the ailment. They have also learned to create a poison that can be applied to a weapon to induce the effect."
				PotionLore2
					rank="T2"
					name="Potion Lore II"
					desc="This individual has learned how to make higher grade potions. They are able to make Hi-Potions."
					pre="Potion Lore"
				StoneLore
					rank="T2"
					name="Stone Lore"
					desc=" The individual has studied the effects of the status effect break, and has learned to make an item to fix it. A golden needle must prick someone who is suffering the effects of break, however if the person has already died from the status effect nothing can be done."
				Demolitionist
					rank="T2"
					name="Demolitionist"
					desc=" This Chemist is a master of explosions and chaos. When a Chemist uses a Bomb attack, they may perform an additional Bomb attack, utilize a Chemist consumable, or utilize a Chemist ability at the cost of 15 additional SP, once per round."
				FrogLore
					rank="T2"
					name="Frog Lore"
					desc="The individual has studied the effects of the frog status. They have learned to culminate a mixture that when drunk by someone as a frog will revert them to normal. They have also learned to create a poison that can be applied to a weapon to induce the effect. This individual is also able to easily tell between a real frog, and someone under the effects."
				BerserkLore
					rank="T2"
					name="Berserk Lore"
					desc="This individual has studied the effects of chemically induced berserk. They are able to make items related to the status."
				PoisonLore
					rank="T2"
					name="Poison Lore"
					desc="This individual has studied magical poison and has learned to apply it in different ways."
				RemedyLore
					rank="T3"
					name="Remedy Lore"
					desc="The individual has a deep understanding of status ailments, and through rigorous study has learned of a panacea that can counter every status ailment."
				Alchemist
					rank="T3"
					name="Alchemist"
					desc="This Chemist has learned the art of Alchemy. They now have access to Alchemy Chemist abilities, which can be utilized at the cost of SP ; by transmuting one's physical lifeforce into the environment, to induce chemical reactions for various effects."
				CurativeExpert
					rank="T3"
					name="Curative Expert"
					desc="This Chemist is a master of enzymes, regenerative process, and antibodies. They have immunity to any status effect they have Lore for. In addition, they restore an additional +25 points for any resource one of their Chemist items restores, either to themselves or allies. With Remedy Lore, the Chemist has immunity to all status effects."
				EtherLore2
					rank="T3"
					name="Ether Lore II"
					desc="This individual has learned to create a mixture that revitalizes someone's mana pool."
				PotionLore3
					rank="T4"
					name="Potion Lore III"
					desc="This individual is able to make the legendary X-potion. A potion that is able to quickly restore someone to their maximum health."
				PhoenixLore
					rank="T4"
					name="Phoenix Lore"
					desc="This individual has learned the lost art of making phoenix downs. This is not a simple task as the ingredients are extremely rare, and make very little. But a phoenix down is able to bring someone back from the dead."
				FountainofYouth
					rank="T5"
					name="Fountain of Youth"
					cat="Unique"
					desc="his individual has learned how to create the Elixir of Youth, which when consumed - makes one unable to physically age beyond the point they have reached, effectively making one immortal outside of mortal afflictions. Elixir of Youth grants +80 HP, +80 MP, +80 SP, and +2 to all Ability Scores to a creature who drinks it, also placing their body into the prime of its youth ; and halting aging. . Costs 50,000 Gil to craft.)"

			Geomancer
				jobneed="Geomancer"
				icon='Icons/Perk/Geomancer.png'
				Geomancer
					name="Geomancer"
					cat="Unique"
					desc="Geomancers are one with nature. They are able to sense and immediately recognize any elemental attack coming at them even if it is not in their line of sight - but only if it is a natural element. Natural elements include Fire, Ice, Earth, Wind, Water, and Lightning. In addition, they take half damage from elemental spells, and are entirely immune to the status effects: Burn, Paralyze, Wet, Weakness, Heavy, Squall, Frostbite, and Whorl. +40 HP, +60 MP, +30 SP."
				GuidedSteps
					rank="T1"
					name="Guided Steps"
					desc="This individual has each of their steps guided as terra speaks to them. They can ignore all difficult terrain due to the natural environment."
				WaterWalking
					rank="T2"
					name="Water Walking"
					desc="This individual can walk on water as if it is solid ground. This can be done by choice and at any moment they can switch between swimming and standing on the water."
				NaturalAdaptation
					rank="T2"
					name="Natural Adaptation"
					desc="This individual is adapted to all natural environments. They do ignore any negative effects of being in extreme weather. They also gain 30ft of darkvision while in caves."
				NaturesWrath
					rank="T3"
					name="Nature's Wrath"
					desc="This individual is protected by the forces of nature. When the target of an attack this individual can use their reaction to counterattack with a Geomancer ability of C tier or less."
				Geosense
					rank="T3"
					name="Geosense"
					desc="This individual has an innate sense of the earth around them. They are able to detect any terrestrial creature within 50ft regardless of stealth or visibility. They are able to determine the elemental makeup of a patch of earth and gain double damage when attack objects or walls made of earth. They receive advantage when making attacks towards earthen constructs. They are able to sense pockets in the earth within their sensing range, and can find hidden passages or pockets."
				NaturalAtunement
					rank="T4"
					name="Natural Atunement"
					desc="This individual attunes to the environment around them. Depending on the type of terrain they are standing on they gain different bonuses. Cave - Gain advantage on stealth checks, gain darkvision 60ft. Grass - Whenever this individual receives healing gain an extra +20 to the healing effect. And cure one status ailment. Sand - Nullifies critical damage. Snow - Gains an aura that passively deals 1d12 ice damage to creatures 5ft around them. Stone(Outside) - Halves the effects of knockback effects. Water - Gain resistance to water and fire damage."
				WhisperoftheLifestream
					rank="T5"
					name="Whisper of the Lifestream"
					desc="This individual has become intune with the earth to the point they can hear the whispers of the very lifestream that fuels every living thing. They can make a nature check in order to try and communicate with the lifestream itself. Through this they are capable of communicating with any soul who has died and asking for advice or assistance from the planet itself."


			TimeMage
				jobneed="Time Mage"
				icon='Icons/Perk/TimeMage.png'
				TimeMage
					name="Time Mage"
					cat="Unique"
					desc="Time Mages are able to passively cast the 'Levitate' spell upon themselves, which makes it so that ground-based attacks can not hit them, and they hover across the ground about four feet off of the ground. This also allows them to cross things such as lava, and water freely. Time Mages also have access to D rank White, Arcane, Green, and Black Magic. +10 HP, +100 MP, +10 SP."
				TimeBalance
					rank="T1"
					name="Time Balance"
					desc="This individual has learned to solidify their place in time. They are immune to the effects of slow and stop."
				FlowofTime
					rank="T2"
					name="Flow of Time"
					desc="This individual is capable of constantly distorting the flow of time around them slowing down the aging process so that they may live double their species' normal lifespan, and are always in their prime in terms of appearance."
				CounterMeteor
					rank="T3"
					name="Counter Meteor"
					desc="This individual has their magic protecting them at all times. Anytime they take a direct hit from a non magical attack, a single medium sized meteor will be summoned from space to strike at where their opponent was when they made the attack, though this slightly drains their mana pool. This deals 15-20 damage + INT. | Autohit. -5 Mana for every proc. This procs once per round, per creature."
					CMeteor
						ability=1
						name="Counter Comet"
						mcost=5
						basecheck=10
						attack_roll_damage_dice = FALSE
						attack_roll_damage_lower = 15
						attack_roll_damage_upper = 20
						adddam=0
						addhit=100
						range="Autohit"
						ability=1
						costtype="Stamina"
						atype="standard"
						damsource="str"
						typing="magical"
						ptype="spell"
				ExtensionField
					rank="T3"
					name="Extension Field"
					desc="This individual has a constant aura around them that extends 5 tiles away from them. Any creature that receives a status effect while in the aura has its duration doubled. Even if they leave the aura."
				Quickened
					rank="T5"
					name="Quickened"
					desc="This individual flows through time with grace and is able to move twice as quick. They permanently have the 'Quick' status effect, allowing them to make 2 standard actions per turn."

			SwordSaint
				name="Sword Saint"
				cat="Unique"
				rank="T5"
				desc="A Sword Saint is a Paladin or Dark Knight who has fully embraced the duality of light and darkness - good, and evil. They live between these principles, and adhere to the blade - and the raw principle of justice above all else. A Sword Saint is able to mix Holy and Dark magic, and infuse their weapon with this combined and potent energy source, granting them access to Sword Saint perks and abilities. Note: This changes your primary job to 'Sword Saint'. Grants +65 HP, +65 MP, +65 SP, and +2 WIS, CHA, and STR. Requires Paladin or Dark Knight as main job, and Paladin or Dark Knight as sub job in combination."
				icon='Icons/Perk/Sword Saint.png'
				ajob="Sword Saint"
				DuskKnight
					cat="Swordsaint"
					rank="T3"
					name="Dusk Knight"
					desc="This Sword Saint is attuned to the darkness. A Sword Saint trained as a Dusk Knight is empowered by the darkness. Whenever damaging a creature with 'Dark' damage - the Dusk Knight restores 5 MP and Stamina to themselves."
				DawnKnight
					cat="Swordsaint"
					rank="T3"
					name="Dawn Knight"
					desc="This Sword Saint is attuned to the light. A Sword Saint trained as a Dawn Knight is empowered by the light. Whenever damaging a creature with 'Holy' damage - the Dawn Knight restores 10 HP to themselves."
				TwilightKnight
					cat="Swordsaint"
					rank="T3"
					name="Twilight Knight"
					desc="This Sword Saint is attuned to true karmic justice. A Sword Saint trained as a Twilight Knight is empowered by balance. Whenever damaging a creature with 'Psychic' damage - the Dawn Knight gains a 'Karma' stack. While Karma stacks are active, they may choose to expel them when taking damage. If they do so, the creature who damaged them takes 2d6 damage which may not be reduced as retribution."

			Reaper
				cat="Unique"
				rank="T4"
				icon='Icons/Perk/Reaper.png'
				ajob="Reaper"
				desc="A Reaper is a Dark Knight who has given in entirely to the darkness, and has become a servant of death. This changes the character's primary job to 'Reaper' - and grants access to unique Reaper perks and abilities. The Reaper has mastered the art of death. They can wield the power of darkness reaped from their slain foes in order to deal devastating blows and manifest beings of pure death. Every individual instance of Melee or Magical damage they inflict on a creature gets transferred into them as 'Soul' as 5 Soul stacks per. +80 MP, +80 HP."


			Necromancer
				cat="Unique"
				icon='Icons/Perk/Necromancer.png'
				ajob="Necromancer"
				desc="This Summoner has abandoned conventional connections to the aether, and embraced the very aspects of death itself. This changes the Summoner's job to Necromancer, and removes access to any summons they have learned as a Summoner. They are instead then replaced with unique 'Necromancer' summons. Necromancers and their summons are immune to the following status effects: Doom, Break, Poison, Bleed. Necromancers may still attain a single S Rank summon via approval on Unique application. Necromancers immediately attain all summons listed in the Necromancer Summons list. Unlike a Summoner, Necromancers may summon as many undead Summons at a time as they wish."

			HolyDragoon
				name="Holy Dragoon"
				cat="Unique"
				rank="T4"
				icon='Icons/Perk/HolyDragoon.png'
				ajob="Holy Dragoon"
				desc="This Dragoon has ascended beyond the level of a normal Dragoon. Their synergy with Dragons has gained them favor and recognition from the father of Dragons, the sacred Midgardsormr. Resultantly, they gain access to the power of the Midgardsormr's holy light, as well as ancient dragon magicks. A Holy Dragoon gains access to C Rank White magic, as well as Dragon Abilities. A Holy Dragoon who has a Wyvern companion also grants their Holy power to that Wyvern. It gains a Dragon Breath Ability of the Dragoon's choice upon attaining this perk, or upon a Wyvern being attained if the Dragoon attains Holy Dragoon first.+80 SP, +80 MP."
			OnionKnight
				name="--Onion Knight Directory--"
				icon='Icons/Perk/OnionKnight.png'
				ajob="Onion Knight"
				rank="T3"
				ptype="job"
				OnionKnight
					name="Onion Knight"
					cat="Unique"
					ajob="Onion Knight"
					desc="This individual has learned to be a more particularly 'Martial' Red Mage. As a result, they have learned to learn 'Red Bladespells' - which allow them to manifest blade-like constructs, cast from their weapon. Bladespells are unique in that they do not use dice, but flat and more consistent damage ranges for their damage. Bladespells count as spells, and use MDB/MAB rather than PDB/PAB. Onion Knight is incompatible with 'Pure Red Mage' +60 HP, +60 MP."
				Enhancer
					name="Enhancer"
					rank="T2"
					ajob="Onion Knight"
					desc="An Onion Knight is at home with a magical blade. They are trained to latently pour their soul's power into their weapon. When using a weapon with any sort of Enchantment, they gain +2 MAB and PAB."
				RunicStrike
					rank="T2"
					name="Runic Strike"
					ajob="Onion Knight"
					desc="An Onion Knight is known for their ability to weave magic into their swings. When using a Melee weapon, an Onion Knight may add their BASE unmodified MDB to their PDB, and grants the option to change it to Force damage."
				SpiritualBlade
					rank="T3"
					name="Spiritual Blade"
					ajob="Onion Knight"
					desc="An Onion Knight who has learned the Spiritual Blade technique has learned to merge their magic and blade into one. They may now cast a Bladespell as a free action whenever utilizing a Melee weapon to attack."
				Yggdrasil
					rank="T3"
					name="Yggdrasil"
					ajob="Onion Knight"
					desc="An Onion Knight who has learned the Yggdrasil technique is able to generate spiritual blades passively, by recycling the energy used to cast bladespells. Whenever a Bladespell is cast, a 'Magic Sword' projectile begins to hover around them, up to 8. When the Onion Knight takes damage from a target enemy creature, they may choose to expend the Magic Sword, firing it at the target as an automatic hit which deals 20 flat (unboostable) Force damage, ignoring up to 15 points of damage reduction. Magical"
				Bladespells
					ptype="spell"
					ability=1
					damsource="wis"
					costtype=" Mana"
					CrescentWave
						name="Crescent Wave"
						rank="D"
						atype="standard"
						typing="magical"
						range=" 3 tiles."
						attack_roll_damage_dice = FALSE
						attack_roll_damage_lower=10
						attack_roll_damage_upper=16
						desc="The user of this technique swings their blade, and releases a crescent shaped burst of magic, for which to slash at their target. This deals 10 to 16+WIS Force damage on a successful hit, and travels as a 3 tile wide projectile. Magical. Costs 10 Mana."
					AeroBlade
						name="Aero Blade"
						rank="D"
						atype="standard"
						typing="magical"
						attack_roll_damage_dice = FALSE
						attack_roll_damage_lower=8
						attack_roll_damage_upper=12
						desc="The user of this technique manifests a sword-shape construct of wind from the tip of their blade, which seperates and moves to independantly slash at the target, dealing 8 to 12+WIS Wind damage and inflicting 'Squall' on a successful hit. Magical. Costs 10 Mana."
						mcost=10
					AquaBlade
						name="Aqua Blade"
						range=" 3 tiles."
						rank="D"
						atype="standard"
						typing="magical"
						attack_roll_damage_dice = FALSE
						attack_roll_damage_lower=8
						attack_roll_damage_upper=12
						desc="The user of this technique manifests a sword-shaped construct of water from the tip of their blade, which seperates and moves to independantly slash at the target, dealing 8 to 12+WIS Water damage and inflicting 'Whorl' on a successful hit. Magical. Costs 10 Mana."
						mcost=10
					BrightBlade
						name="Bright Blade"
						range=" 5 tiles."
						rank="C"
						atype="standard"
						typing="magical"
						attack_roll_damage_dice = FALSE
						attack_roll_damage_lower=8
						attack_roll_damage_upper=12
						desc="The user of this technique manifests a sword-shape construct of light from the tip of their blade, which seperates and moves to independantly slash at the target, dealing 8 to 12+WIS Holy damage, and inflicting 'Silence' on a successful hit. Magical. Costs 25 Mana."
						mcost=25
					SpiritBlade
						name="Spirit Blade"
						rank="C"
						atype="standard"
						typing="magical"
						range=" 5 tiles."
						attack_roll_damage_dice = FALSE
						attack_roll_damage_lower=20
						attack_roll_damage_upper=35
						desc="The user of this technique manifests a sword-shaped construct of pure magical energy from the tip of their blade, which seperates and moves to independantly stab the target, dealing 20 to 35+WIS Force damage, and inflicting 'Weakness' on a successful hit. Magical. Costs 30 Mana."
						mcost=30
					Zanbatou
						name="Zanbatou"
						rank="B"
						atype="standard"
						typing="magical"
						range=" 5 tiles."
						attack_roll_damage_dice = FALSE
						attack_roll_damage_lower=40
						attack_roll_damage_upper=55
						mcost=50
						desc="The user of this technique swings their blade, and from it - another blade, in the shape of a greatsword or a buster sword forms, made entirely of magical energy. It flings forward, spinning like a Shuriken to cut its target down. This deals 40 to 55+WIS Force damage on a successful hit. Magical. Costs 50 Mana."
					IfritFalchion
						name="Ifrit's Falchion"
						rank="A"
						atype="standard"
						typing="magical"
						range=" 9 tiles."
						attack_roll_damage_dice = FALSE
						attack_roll_damage_lower=55
						attack_roll_damage_upper=70
						mcost=70
						desc="The user of this technique holds their blade above their head, and begins to gather magical energy approximately 20 feet above them. This energy forms into a sword made of Fire, and then slashes down at a target in range, dealing 55 to 70+WIS Fire damage, and inflicting 'Burn' on a successful hit. Magical. Costs 70 Mana."
					ShivaSaber
						name="Shiva's Saber"
						rank="A"
						atype="standard"
						typing="magical"
						range=" 9 tiles."
						attack_roll_damage_dice = FALSE
						attack_roll_damage_lower=55
						attack_roll_damage_upper=70
						mcost=70
						desc="The user of this technique holds their blade above their head, and begins to gather magical energy approximately 20 feet above them. This energy forms into a sword made of Fire, and then slashes down at a target in range, dealing 55 to 70+WIS Ice damage, and inflicting 'Frostbite' on a successful hit. Magical. Costs 70 Mana."
					RamuhRapier
						name="Ramuh's Rapier"
						range=" 9 tiles."
						desc="The user of this technique holds their blade above their head, and begins to gather magical energy approximately 20 feet above them. This energy forms into a sword made of Fire, and then slashes down at a target in range, dealing 55 to 70+WIS Thunder damage, and inflicting 'Paralyze' on a successful hit. Magical. Costs 70 Mana."
						rank="A"
						atype="standard"
						attack_roll_damage_dice = FALSE
						attack_roll_damage_lower=55
						attack_roll_damage_upper=70
						mcost=70
						typing="magical"
					BahamutBlade
						name="Bahamut's Blade"
						range=" 9 tiles."
						desc="The user of this technique holds their blade above their head, and begins to gather magical energy approximately 20 feet above them. This energy forms into a sword made of Fire, and then slashes down at a target in range, dealing 70 to 85+WIS Force damage, and inflicting 'Slow', and 'Heavy' on a successful hit. Magical. Costs 100 Mana."
						rank="S"
						atype="standard"
						attack_roll_damage_dice = FALSE
						attack_roll_damage_lower = 70
						attack_roll_damage_upper = 85
						mcost=100
						typing="magical"
			Oracle
				ptype="job"
				name="Oracle"
				icon='Icons/Perk/Oracle.png'
				jobneed="Oracle"
				ability=0
				desc="This individual has learned how to utilize a very specific kind of White Magic. Their studies in the Holy spell line have led them to a more offensive aspect of casting. Permanently, all Healing spells heal for 10 less damage - however, any Holy damage dealt by the Oracle is increased by a flat 15. Oracle Spells count as White Magic in terms of perks and technique references. An Oracle gains +20 HP, +60 MP, and +60 SP. Oracles have access to B Rank White Magic."
				TemperedSoul
					name="Tempered Soul"
					rank="T1"
					jobneed="Oracle"
					desc="An Oracle has undergone training to temper their soul. As a result, they have gained great resistance against divine intervention, as well as the degradation of depravity. An Oracle with this perk has resistance to Holy and Dark damage alike."
				OracleBlade
					name="Oracle Blade"
					rank="T2"
					jobneed="Oracle"
					desc="An Oracle is able to infuse their weapon with the guiding light of justice. Upon doing so, their acting weapon gains a projected blade of light. This allows them to use the weapon as a Melee weapon. When used as a Melee weapon - this grants it optional Holy damage, and grants the wielder +6 PDB and +3 MDB, also causing the weapon to apply 'Heavy' on hit."
				HolyJudgement
					name="Holy Judgement"
					jobneed="Oracle"
					rank="T2"
					desc="An Oracle is guided by the light of justice. As a result, their Holy magic is particularly potent - able to cling to the souls of those it affects. When dealing damage to a creature using Holy damage, that creature gains 1 stack of 'Judgement'. If the creature gains a total of 5 Judgement stacks, an explosion of Holy energy radiates from the creature, dealing an automatic 50 Holy damage to all enemy creatures in a 3x3 area of effect."
				VanquisherofEvil
					name="Vanquisher of Evil"
					jobneed="Oracle"
					rank="T2"
					desc="An Oracle is trained to banish and vanquish all forms of evil, moreso than any other Job. When an Oracle deals Holy damage to a creature that is weak to it, that creature takes an additional 15 Holy damage, and suffers disadvantage on its next attack roll."
				DivineVoice
					name="Divine Voice"
					rank="T3"
					jobneed="Oracle"
					desc="An Oracle of this calibre has a Divine Voice. As a result of this, they are immune to the 'Silence' status effect."
				Battleseer
					name="Battle Seer"
					jobneed="Oracle"
					rank="T3"
					desc="An Oracle is able to use divination to look forward and see possible futures. This combined with their trained battle sense allows them to pick the proper course in battle. By spending their Standard action, an Oracle may issue an order to their party, and grant all party members an expendable 'Seer' stack. A Seer stack may be expended as a free action, and grants a roll Advantage. The Oracle is also able to see through illusions, and thus immune to the Blind status effect."
				DivineOrdinance
					name="Divine Ordinance"
					jobneed="Oracle"
					rank="T4"
					desc="An Oracle is ordained by the light to guide others in combat, by leading the charge. They gain a +5 Initiative bonus, and if an Oracle is the first on the turn order in their party - they gain +3 PAB, and MAB for the duration of the encounter."
				OracleMagic
					ability=1
					damsource="cha"
					jobneed="Oracle"
					typing="magical"
					costtype=" Mana"
					ptype="spell"
					element="Holy"
					DiskofLight
						name="Disk of Light"
						rank="C"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 2
						attack_roll_dice_sides = 8
						addhit=8
						mcost=20
						range=" 5 tiles."
						atype="standard"
						desc="The user of this ability spins on the tip of their foot, tossing their arms out to the side. The rotation generates a sharp disk of light, which is then fired at a target as a homing projectile. This attack has +8 to hit, deals 2d8+CHA Holy damage and inflicts 'Bleed' on hit. Costs 20 Mana."
					DivineStorm
						name="Divine Storm"
						rank="C"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 3
						attack_roll_dice_sides = 10
						mcost=30
						basecheck=12
						atype="save"
						savetype="Fortitude"
						range=" 3x3 AoE within 5 tiles."
						desc="The user of this ability generates a divine cloud overhead, at a point within range. It then generates an area of holy lightning, which deals 3d10+CHA Thunder damage and inflicts 'Silence' on a failed Fortitude saving throw, or half as much and no 'Silence' on a success. Costs 30 Mana."
					SealingBlade
						name="Sealing Blade"
						rank="C"
						basecheck=13
						atype="save"
						range=" 8 tiles."
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 3
						attack_roll_dice_sides = 12
						savetype="Reflex"
						desc="The user of this ability opens a crackling portal over the head of a target within 8 tiles. From it, a massive blade made of divine energy launches forth like a meteor, to carve them up - before exploding. This prompts a Reflex saving throw, dealing 3d12+CHA Holy damage and inflicting 'Stun' on a failure, or half as much and no 'Stun' on a success. Costs 40 Mana."
					CircleofSealing
						name="Circle of Sealing"
						rank="B"
						mcost=50
						range=" 3x3 AoE within 8 tiles."
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 4
						attack_roll_dice_sides = 10
						basecheck=13
						atype="save"
						savetype="Fortitude"
						desc="The user of this ability holds their palm forward, and generates a ring of light on the ground, at a point within 8 tiles. This expands outward to cover a large area, before bursting outward in a powerful explosion of light. This prompts a Fortitude saving throw, inflicting 4d10+CHA Holy damage and dispelling all positive status effects on a failure, or half damage and no dispellation on a success. Costs 50 Mana."
					Sparkstrike
						name="Spark Strike"
						rank="B"
						mcost=45
						range=" 5 tiles."
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 2
						attack_roll_dice_sides = 6
						atype="weapon"
						typing="magical"
						desc="The user of this ability points their blade at a designated target within 5 tiles of their own location. They then teleport instantly to that location in a flash of light, releasing a spark from their weapon as they swing it towards the target, dealing Weapon Damage+2d6+CHA additional damage on the attack, on a successful hit. This counts as a Spell, despite being a Weapon attack, and uses Magic bonuses as opposed to Physical. Costs 45 Mana."
					SoulConvergence
						name="Soul Convergence"
						rank="A"
						mcost=70
						range=" 5x5 AoE within 8 tiles."
						desc="The user of this ability raises their hands over their head. Spears of light are generated overhead, and then launched forward, into the ground. They create a ring around a 5x5 radius, within 8 tiles of the caster.. This area continually pulses with divine energy, dealing 20 Holy damage to all creatures within its radius at the start of their turns. This area effect lasts for 5 rounds. Costs 50 Mana."
					SoulofRebirth
						name="Soul of Rebirth"
						rank="A"
						mcost=70
						desc="The user of this ability brings their hands together, forming a Mantra sign as they close their eyes. Divine mists begin to seep out from their form, before lashing out at a single target. This mist then obscures the target's form, eating away at them slowly. For 4 rounds, they are afflicted with 'Soul of Rebirth'. This effect causes them to take 15 Holy damage at the end of their turn, ignoring damage reduction. Costs 70 Mana."
					BanishingOrb
						name="Banishing Orb"
						rank="A"
						mcost=70
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 7
						attack_roll_dice_sides = 12
						mcost=80
						range=" 8 tiles."
						addhit=5
						atype="standard"
						desc="The caster of this ability holds their palm overhead, and generates a sphere of light. It slowly gathers light particles, growing in volume until it is roughly the size of a massive boulder. They then toss it forth at a target, as an attack roll with +5 to hit. On hit, it explodes ; dealing 7d12+CHA Holy damage, and inflicts 'Weakness'. If used against a Summon, a Primal, or any entity from the Void, this deals 50 additional flat Holy damage. Costs 80 Mana."
					HolyXIV
						name="Holy XIV"
						rank="A"
						mcost=90
						atype="save"
						savetype="Will"
						basecheck=16
						attack_roll_damage_dice = FALSE
						attack_roll_damage_lower = 80
						attack_roll_damage_upper = 90
						desc="The caster of this ability throws either arm to the side, and flattens their palms. Divine light begins to seep out in strands, moving to whirl around a target in a calm 'whirlwind' of light. It then bursts into millions of sparkling light particles, which begin to individually fire forth, directly attacking the target's soul. This attack deals 80 to 90+CHA Holy damage on a failed save, or half as much on a success. Costs 90 Mana."
					LakshmiDance
						name="Lakshmi's Dance"
						rank="A"
						mcost=80
						atype="weapon"
						range=" 3x3 AoE centered around user."
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 4
						attack_roll_dice_sides = 10
						desc="The user of this ability brandishes their weapon in a white, divine mist. They then spin a full 360 degrees in place, releasing the mist as a sharp blade towards all creatures in range. On a successful hit, a target takes Weapon Damage+4d10+CHA damage, and is inflicted with 'Sleep'. Costs 80 Mana."
					OdinGallop
						name="Odin's Gallop"
						rank="A"
						mcost=70
						attack_roll_damage_dice = FALSE
						attack_roll_damage_lower = 40
						attack_roll_damage_upper = 60
						atype="standard"
						range=" 3 tile wide, 5 tile line."
						desc="The user of this ability launches off of the ground from their current position. They summon two curved, ornate silver and gold blades used by Odin himself, into each hand. As the user travels 5 tiles forward, all creatures within 3 tiles that they pass are prompted with an attack roll, taking 40-60+CHA Holy damage on hit. This does not use the caster's movement action, and is a Standard action."
					TeleportXIV
						name="Teleport XIV"
						rank="A"
						mcost=70
						savetype="Will"
						range=" 8 tiles."
						atype="save"
						basecheck=15
						attack_roll_damage_dice = FALSE
						attack_roll_damage_lower = 60
						attack_roll_damage_upper = 70
						desc="The user of this ability raises their hands to the sky, and releases a pillar of light from the heavens upon a target within 8 tiles, targeting their soul. It is blasted with Holy Light, prompting a Will saving throw - and takes 60 to 70+CHA damage, and is then teleported to a tile of the caster's choice in view on a failed save, or takes half damage and is not teleported on a success."
					LifeConnect
						name="Life Connect"
						rank="A"
						mcost=100
						desc="The user of this ability tethers their soul to that of a target creature within view. This connection causes the target to take Holy Damage equal to any damage that the caster takes so long as it is established. It lasts for 5 rounds. This costs 100 Mana to cast."
					MightiestofSanctities
						name="Mightiest of Sanctities"
						rank="S"
						mcost=150
						desc="The user of this ability performs the ultimate Holy magic. Condensing the might of their own spirit, they release an astral projection of themselves with angelic wings, and a sacred blade upon a target creature within 6 tiles of their current position. The projection then carves away at the creature's very soul, before dissipating with an explosion of Divine Energy Upon utilizing this spell, they deal Holy damage equal to half of the oracle's maximum HP to a target creature, as an automatic hit. Costs 150 Mana."
			Ninja
				cat="Unique"
				icon='Icons/Perk/Ninja.png'
				ajob="Ninja"
				Suimen
					cat="Ninja"
					rank="T1"
					name="Suimen"
					desc="This individual has learned the art of channeling energy into their feet in order to walk on water."
				Ninpo
					cat="Ninja"
					rank="T3"
					name="Ninpo"
					desc="This individual has learned to convert their vital energies into a particular type called 'Ninpo' - which is essentially lifeforce that is stored passively through meditation during times of rest. A Ninja with this perk has a 'Ninpo' pool of 200 which regenerates at the end of each encounter, and may use a Bonus action to restore their HP, SP, or MP of up to 50 by spending that much Ninpo once per turn."
				NinpoEmpowerment
					cat="Ninja"
					rank="T3"
					name="Ninpo Empowerment"
					desc="This individual has learned to utilize their Ninpo in order to transform a non Ninja technique into Ninjutsu. If this Ninja knows a General Magic, Black Magic, or Arcane Magic ability - they may spend that technique's cost using Ninpo points instead of its initial cost resource. If they do so, the technique is then considered a 'Ninjutsu' technique and is cast by using Mantra seals instead. It also gains 10 additional damage if it is a damaging technique, and any associated saving throw DCs are increased by 1. This bonus applies per attack roll, for multi-hits."
				HugeReserves
					cat="Ninja"
					rank="T4"
					name="Huge Reserves"
					desc="This individual has increased their Ninpo reserves by an additional 150 Ninpo points."

			Berserker
				cat="Unique"
				icon='Icons/Perk/Berserker.png'
				ajob="Berserker"
				rank="T5"
				desc="This person has become a master of the art of 'Berserking' -- this allows them to, as a bonus action, inflict themselves with the 'Berserk' status effect at any time. This perk removes all negative effects from the Berserk status effect, whenever this person is inflicted with Berserk, only maintaining the +6 to Strength score. In addition, if this character is inflicted with the Berserk status effect, they are also inflicted with the 'Bravery', 'Protect' and 'Shell' status effects, making them an absolutely terrifying adversary to combat when they are enraged, as they have learned to harness that rage into a pure, focused, razor sharp edge. Berserk's new negative infliction is that it locks this person to being less refined in terms of raw skill, and they rely on pure instinct. Whilst they are inflicted with Berserk, they are only capable of utilizing up to B rank General Weapon / Job abilities, and if they know Magic - they may not use any Spells at all. A person with this perk may expend their bonus action to immediately remove the Berserk status effect, thus also removing any positive benefits which came with it. This advanced job grants +20 HP, MP, and SP, as well as +2 STR, DEX, and CON. (Bravery, Protect, Shell.)"





obj
	perk
		Abilities
			New()
				if(src.level==1)
					src.rank="E"
				if(src.level==2)
					src.rank="D"
				if(src.level==3)
					src.rank="C"
				if(src.level==4)
					src.rank="B"
				if(src.level==5)
					src.rank="A"
				if(src.level==6)
					src.rank="S"
				if(src.rank=="E")
					src.rpcost=1
				if(src.rank=="D")
					src.rpcost=2
				if(src.rank=="C")
					src.rpcost=3
				if(src.rank=="B")
					src.rpcost=4
				if(src.rank=="A")
					src.rpcost=8
				if(src.rank=="S")
					src.rpcost=16
			ability=1
			Knight
				element="Physical"
				typing="physical"
				damsource="str"
				jobneed="Knight"
				icon='Icons/Perk/Knight.png'
				atype="standard"
				HonorableDuel
					name="Honorable Duel"
					rank="D"
					desc="The Knight points at an opponent, and calls on the power of their heroics in order to force a target creature to fight them, and only them. So long as only the Knight is targeting their attacks towards the creature, that creature must fight them. This can only be used on one creature at a time. Bonus action. (Drains 10 Stamina per turn active.)"
				ThrillofBattle
					name="Thrill of Battle"
					rank="C"
					desc="The Knight is trained to use his adrenaline to its fullest potential in order to last longer on the battlefield. Through Mana infusion and mixing of Adrenaline, the Knight becomes more durable. +5 damage reduction for 4 turns. This is slightly draining initially but does not drain over time. (Cannot exceed 30 total Damage reduction.) (-20 Stamina.) "
				Holmgang
					rank="C"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 1
					attack_roll_dice_sides = 12
					range=" 7x7 AoE centered around user."
					mcost=15
					atype="save"
					savetype="Strength"
					basecheck=14
					desc="The Knight slams their weapon into the ground, and activates Gravity Magic within it. The center of gravity of the area becomes wherever the blade is stuck in the ground as long as the blade is in the ground, and pulls people and things towards it. This wears off when the weapon is removed from the ground.  Inflicts 'Slow' to pulled targets."
				Engage
					rank="C"
					desc="The Knight focuses on a single target. They then hold their weapon in a backwards grip, and kick off towards them by augmenting their legs with a burst of energy. This allows them to approach a target at an additional 2 tiles of extra movement, and perform a basic Melee Attack on them if they are able to reach them. If this Melee attack hits, the target is forced into the effects of 'Honorable Duel' - but the effect only drains 2 Stamina per turn active rather than 5, if activated this way (starting on the turn after this is procced). (-10 Stamina.)"
				Overpower
					rank="C"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 8
					range=" 3 tile wide cone."
					mcost=15
					atype="standard"
					desc="The Knight focuses Mana and Adrenaline into their muscles, and slams their fists together in-front of them to send a shockwave of wind and mana forward with a radius of eight yards, and in the shape of a cone.  (Damage: 2d8+STR | Ranged attack roll (1d20+STR+1) 3 Tile Wide Cone, -15 Stamina.) "
				Deliverance
					rank="C"
					desc="The Knight gains a blue aura around their weapon which increases its effective cutting power, draining mana a bit during activation, but easy to sustain. (Character gains +1 PAB, and +5 PDB. Drains 5 Mana per turn active.)"
				BladeofResilience
					name="Blade of Resilience"
					rank="C"
					desc="The Knight is able to imbue the resilience of their spirit into their blade, expunging all stacks of Adrenaline in order to deal extra damage for their next Melee attack. This consumes all Adrenaline stacks. (Next Melee attack deals 1d4 extra damage per Adrenaline point spent. -20 Mana.)"
				StormsPath
					name="Storm's Path"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 12
					atype="standard"
					range=" 3 tile wide projectile, 6 tile range."
					basecheck=14
					mcost=30
					desc="The Knight prepares their weapon in a backwards grip at their side, and begins to focus their Mana into the weapon whilst preparing their muscles. They then swing horizontally, and a blade-like beam of horizontal magic lashes outward in front of them, covering a large area. Opponents hit by this beam will suffer a temporary decrease to their durability for a turn after.  (Damage: 2d12+STR | 3 Tile Wide projectile, 6 tile range. STR Attack roll (DC 14+STR+Rank Bonus), inflicting -2 AC to creatures who are hit ; lasting 2 rounds.  -30 Stamina.) "
				Lockdown
					rank="B"
					desc="The Knight focuses all of their energy on entirely locking a target down, by washing a wave of restrictive, binding energy outward in the form of a wave. This ability can only be utilized on a creature under the effects of 'Honorable Duel'. If it is, that creature must make a Fortitude saving throw, DC 18. If the saving throw is failed, that creature has their tile movement reduced by 5 (to a minimum of 1) - and is inflicted with the 'Heavy' and 'Weakness' status effects. (-40 Stamina.)"
				SteelCyclone
					name="Steel Cyclone"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 12
					atype="weaponsave"
					savetype="Reflex"
					basecheck=14
					range=" 5x5 AoE centered around user."
					desc="The Knight charges their weapon with Mana, and spins around in a circle, kicking up a whirlwind around their body as they dig their feet into the ground. This releases sharp and powerful winds in a circle around them.  (Damage: 2d12+STR | Prompts a Reflex save in order to take full or half damage, 5x5 AoE, 4 Tile Knockback on hit. -15 Stamina, -15 Mana.)"
					mcost=15
				Unchained
					rank="B"
					desc="The Knight is able to use the adverse of Thrill of Battle’s power by removing themselves of their anger and burdens, as well as calming themselves thus deactivating their Adrenaline Rush and causing Thrill of Battle to be unable to be used whilst active. Gain +1 to hit, +5 damage to all attacks, and disables all Damage Reduction - even from equipment. (4 turns, deactivates Thrill of Battle during use.)  (-40 Mana.) "
				Defiance
					rank="B"
					desc="The Knight’s Mana-Adrenal rush is extremely powerful. When activated, the Knight’s mana and adrenaline work together to restore his body, which allows him to perform at a level far greater than that of normal (+3 turns Regen, Haste.) (-25 Mana, -25 Stamina, absorbs all Adrenaline stacks.)"
				OathofOrder
					name="Oath of Order"
					rank="A"
					desc="The Knight is able to utilize a peculiar manifestation of willpower, to magically reinforce their body. Their resolve to protect others, and keep the concept of 'Order' alive in the world is so strong, that they can mentally manifest power and draw it out around themselves. The Knight gains an aura of power, and their ability to protect themselves as well as dish out justice is generally increased. This enhanced state lasts for 5 rounds, and grants the following benefits at the cost of 50 Mana: (+2 PAB, 2d8 additional damage on Melee attacks and General Weapon Abilities, +2 STR.)"
				Imprison
					rank="A"
					desc="The Knight is able to call upon the power of 'Law' and 'Authority' in order to cast the Imprison spell on a target creature. They point their weapon forward, and call upon justice itself, to begin casting a set of binding runes on a given creature. The creature must make a Will saving throw, DC 20. If they fail the saving throw, they are surrounded in a jail-cell like structure manifested from a transparent, crystal-like structure. While within this jail-cell, the creature is protected from harm - but also cannot use any abilities, or attack from the inside. The prison must be destroyed from the outside, and has 100 HP. (-40 Mana, -30 Stamina.)"
				AegisStrike
					name="Aegis Strike"
					rank="S"
					atype="weapon"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 5
					attack_roll_dice_sides = 10
					range=" Melee."
					mcost=45
					desc=" The user holds their shield or weapon forward grounding their feet as they shift all their energy into their shield or weapon. They then dash forward shield or weapon raised brimming with energy. They then crash their shield into the target, thus hitting them with a solid wall that sends shockwaves throughout their body.  (Damage: 5d10 + Current Damage Reduction | Attack Roll (1d20+STR+4), - 45 Mana.) "


			Swordsaint
				icon='Icons/Perk/Sword Saint.png'
				ajob="Sword Saint"
				atype="weapon"
				range="Melee"
				costtype="Stamina"
				attack_roll_damage_dice = FALSE
				attack_roll_damage_lower = 0
				attack_roll_damage_upper = 0
				typing="physical"
				CrushArmor
					name="Crush Armor"
					rank="B"
					mcost=50
					desc="A Melee weapon attack, which if successful is capable of disabling armor of a lower metal tier than the weapon used on hit, for 3 rounds. (-50 Stamina.)"
				CrushWeapon
					name="Crush Weapon"
					rank="B"
					mcost=50
					desc="A Melee weapon attack, which if successful is capable of disabling a weapon of a lower metal tier than the weapon used on hit, for 3 rounds. (-50 Stamina.)"
				Duskblade
					element="Dark"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 1
					attack_roll_dice_sides = 12
					mcost=30
					desc="A Melee weapon attack, which is imbued with dark magic. It's capable of drawing the magical energy out of a target, restoring MP equal to half of the damage dealt. This also changes the damage from physical to Dark. (Damage: Weapon Damage + 1d12, -30 Stamina.)"
				Shadowblade
					element="Dark"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 1
					attack_roll_dice_sides = 12
					mcost=30
					desc="A Melee weapon attack, which is imbued with dark magic. It's capable of drawing the magical energy out of a target, restoring HP equal to half of the damage dealt. This also changes the damage from physical to Dark. (Damage: Weapon Damage + 1d12, -30 Stamina.)"
				JudgementBlade
					element="Holy"
					name="Judgement Blade"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 12
					mcost=30
					range=" 2 Tile line."
					desc="A Melee weapon attack, which is imbued with holy magic. It's capable of dealing tremendous holy damage. Changes the weapon's base damage to holy. The blade is extended by a holy beam of light, granting 2 extra tiles of range. (Damage: Weapon Damage + 2d12, -30 Stamina.)"
				CleansingStrike
					element="Holy"
					name="Cleansing Strike"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 1
					attack_roll_dice_sides = 10
					mcost=30
					desc="A Melee weapon attack, which is imbued with cleansing holy magic. It's capable of dispelling positive status effects, applying 'Dispel' on hit. Changes damage to holy damage. (Damage: Weapon Damage + 1d10, -30 Stamina.)"
				NorthwainStrike
					element="Holy"
					name="Northwain Strike"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 1
					attack_roll_dice_sides = 10
					mcost=30
					range=" 3 tile line."
					desc="A Melee weapon attack, which is imbued with penetrative holy magic. This extends a holy blade in the shape of the wielded weapon, to stab a target creature, ignoring defenses and gaining extra range. Changes damage to holy damage. (Damage: Weapon Damage + 1d10 | Ignores 20 damage reduction. 3 tile range, -30 Stamina.)"
				HallowedBolt
					element="Thunder"
					name="Hallowed Bolt"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 1
					attack_roll_dice_sides = 10
					mcost=50
					desc="A Melee weapon attack, which is imbued with holy thunder. Make a normal weapon attack roll, then a Hallowed Bolt roll immediately after. Hallowed Bolt's damage is lightning damage - the initial weapon attack roll's damage is holy damage. If the Hallowed Bolt roll hits the target, it inflicts 'Paralyze'. (Damage: Weapon Damage + 1d10, -50 Stamina.)"
				ShadowflameBlade
					element="Fire"
					name="Shadowflame Blade"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 1
					attack_roll_dice_sides = 10
					mcost=50
					desc="A Melee weapon attack, which is imbued with cursed flames. Make a normal weapon attack roll, then a Shadowflame Blade roll immediately after. Shadowflame Blade's damage is fire damage - the initial weapon attack roll's damage is dark damage. If the Shadowflame Blade roll hits the target, it inflicts 'Burn'. (Damage: Weapon Damage + 1d10, -50 Stamina.)"
				TwilightBlade
					element="Dark"
					name="Twilight Blade"
					rank="B"
					costtype="Mana"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 1
					attack_roll_dice_sides = 20
					mcost=50
					desc="A Melee weapon attack, which is imbued with karmic power - attacking the very soul. A target hit by this attack has their essence sapped, restoring SP equal to half the damage dealt to the user. The attack's damage is Psychic damage. (Damage: Weapon Damage + 1d20, -50 Mana.)"
				SunsetSeverance
					element="Thunder"
					name="Sunset Severance"
					rank="B"
					costtype="Mana"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 1
					attack_roll_dice_sides = 10
					mcost=50
					desc="A Melee weapon attack, which is imbued with a karmic chill. Make a normal weapon attack roll, then a Sunset Severance roll immediately after. Sunset Severance's damage is ice damage - the initial weapon attack roll's damage is Psychic damage. If the Sunset Severance roll hits the target, they are inflicted with 'Heavy'. (Damage: Weapon Damage + 1d10, -50 Mana.)"
				DivineRuination
					element="Holy"
					name="Divine Ruination"
					rank="A"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 20
					mcost=80
					desc="A Melee weapon attack, which is imbued with immense holy power. Upon striking the target with Divine Ruination, the target is inflicted with 'Silence' and 'Slow'. (Damage : Weapon Damage + 2d20, -80 Stamina.)"
				ApocalypseStrike
					element="Dark"
					name="Apocalypse Strike"
					rank="A"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 20
					mcost=80
					desc="A Melee weapon attack, which is imbued with immense corruptive power. Upon striking a target with Apocalypse Strike, the target is inflicted with 'Blind' and 'Weakness'. (Damage: Weapon Damage + 2d20, -80 Stamina.)"
				EclipseBlade
					element="Thunder"
					name="Eclipse Blade"
					rank="S"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 3
					attack_roll_dice_sides = 12
					range=" 3 tile wide, 8 tile line."
					mcost=120
					desc="The penultimate Sword Saint ability. It acts as a Melee weapon attack, which is imbued with immense karmic power. The blade is extended in a massive stream of karmic mana. The range is increased due to the massive size of the blade. When a target is struck by this blade, they are inflicted with Burn, Poison, and Bleed. (Damage: Weapon Damage + 3d12, -120 Stamina.)"

			Viking
				element="Physical"
				typing="physical"
				jobneed="Viking"
				icon='Icons/Perk/Viking.png'
				atype="standard"
				costtype="Stamina"
				damsource="str"
				range="Melee"
				Provoke
					rank="D"
					desc="This individual is able to cast magic upon their words, and provoke even the mightiest of beasts to target them exclusively for 2 turns. (Only works on Monsters / Animals, -15 Mana.)"
				MightyStrike
					name="Mighty Strike"
					rank="C"
					addhit=2
					attack_roll_damage_dice = FALSE
					attack_roll_damage_exact = 0
					atype="weapon"
					addhit=2
					mcost=30
					desc="Lunge forward with your weapon to administer a powerful strike, which is carried by a mighty charge. (Damage: Weapon Damage | Weapon Attack Roll +2 to hit, +2 Tile Movement during usage, -30 Stamina.)"
				StayInIt
					name="Stay in It"
					rank="C"
					desc="Spend all of your current Battle Momentum to administer a minor Self Heal to yourself. (Restores 10 HP per Battle Momentum spent. This caps at 80 HP restored. This has a 5 turn cooldown. -20 Mana.)"
				BorrowedTime
					name="Borrowed Time"
					rank="C"
					desc="Spend an exceptional amount of Mana in order to stand in place, and hype yourself up. (Gain 2 Battle Momentum per Character Rank -30 Mana. Bonus action.)"
				ShatterStrike
					element="Earth"
					name="Shatter Strike"
					rank="C"
					atype="weaponsave"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 8
					range=" 5x5 AoE, centered around user."
					savetype="Strength"
					basecheck=12
					mcost=20
					desc="Slam your weapon into the ground, and create a 3 tile wide crevice either horizontally or vertically. Those caught in the AoE of the quake are damaged. (Damage: 2d8+STR | Prompts a STR saving throw, dealing half damage on a success. 5x5 AoE,  - 20 Stamina.)"
				MightyShout
					name="Mighty Shout"
					rank="C"
					desc="Shout at your opponents with magically imbued vigor. This decreases their AC by 2 for five turns if their CON score is lower than yours. (-20 Stamina.)"
				MightyCyclone
					name="Mighty Cyclone"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 8
					rank="C"
					addhit=2
					atype="weapon"
					range=" 5x5 AoE"
					mcost=40
					desc="Spin in a mighty circle, swinging your weapon with you. As you spin, you move forward in a straight line up to 4 tiles forward. (Damage: 2d8+STR | Weapon Attack Roll +2 to hit, 5x5 AoE, -40 Stamina.)"
				FallingStrike
					name="Falling Strike"
					rank="B"
					atype="weapon"
					mcost=45
					addhit=2
					desc="Leap about ten feet into the air, and bring your weapon down on an opponent with the weight of your body, to shatter them. (Damage: 1d8 per tile moved | Weapon Attack Roll +2 to hit, -45 Stamina.)"
				ThorsJudgement
					element="Thunder"
					name="Thor's Judgement"
					rank="B"
					atype="weapon"
					mcost=25
					costtype="Mana, Stamina."
					addhit=4
					desc="Channel all of your battle momentum into your weapon, and strike at your opponent. A bolt of lightning will explode from your weapon on contact, dealing immense damage. This removes all Battle Momentum. (Damage: 1d6 per Battle Momentum stack lightning damage (caps at 8 stacks of B.M.) | Weapon Attack Roll +4 to hit, -25 Mana, 25 Stamina.)"
				JotunStrike
					element="Ice"
					name="Jotun Strike"
					rank="B"
					atype="weapon"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 8
					addhit=3
					mcost=20
					costtype="Mana, Stamina."
					desc="Strike your opponent, and if your strike hits - they will be engulfed in a frosty ice, that lowers their tile movement by 2 for 5 turns, and inflicts 'Slow'. This removes all Battle Momentum stacks. (Damage: Weapon Damage + 2d8+STR ice | Weapon Attack Roll +3 to hit, -20 Stamina, 20 Mana.)"
				Fenrir
					element="Dark"
					rank="A"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 3
					attack_roll_dice_sides = 8
					addhit=4
					mcost=60
					costtype="Mana."
					atype="weapon"
					desc="Leap into the air, and then begin spinning towards your opponent as you fall - swinging your weapon along with you. All of your Battle Momentum is infused into one, crushing strike.  (Damage: 3d8 + 6 per Battle Momentum stack (caps at 10 stacks) | Weapon Attack Roll +4 to hit, - 60 Mana.)"
				Odinspear
					element="Holy"
					name="Odin's Spear"
					rank="S"
					mcost=90
					costtype="Mana"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 5
					attack_roll_dice_sides = 12
					range="Melee"
					addhit=5
					atype="weapon"
					desc="Channel your passion and invigoration into your weapon, and throw it into the air. A massive construct of mana engulfs your weapon in the form of a giant spear. All of your Battle Momentum is used up, for a spectacular finishing blow. (Damage: 5d12 + 8 extra per Battle Momentum Stack (Caps at 10 stacks) |  Weapon Attack Roll +5 to hit, -90 Mana.)"

			Bard
				jobneed="Bard"
				icon='Icons/Perk/Bard.png'
				atype="standard"
				NaturesMinne
					name="Nature's Minne"
					rank="D"
					desc="Targets of this song gain an increased healing effect. Whenever health is restored by use of magic the bard can add their CHA modifier x2 to the healing effect for free. This only applies to active abilities such as Cure etc, and not passive effects such as Regen. (-10 mana initial 3 to sustain)"
				SinewyEtude
					name="Sinewy Etude"
					rank="D"
					desc="Targets of this song gain a bonus to PDB equal to the bard's charisma mod. (-10 mana initial 3 to sustain.)"
				LearnedEtude
					name="Learned Etude"
					rank="D"
					desc="Targets of this song gain a bonus to MDB equal to the bard's charisma mod. (-10 mana initial 3 to sustain)"
				PelotonPolka
					name="Peloton Polka"
					rank="C"
					desc="Targets of this song gain bonus tile movement equal to half of the bard's charisma mod (rounding up on a decimal). (-15 mana initial 5 to sustain.)"
				FoesChord
					name="Foe's Chord"
					rank="C"
					desc="As a free action in response to starting a Bard Song, the Bard may apply this Chord's effect to the song for the song's duration: Enemy creatures within the song's range take 10 Force damage at the start of their turn. Only one Chord effect may be active on a Bard song at a time."
				LovingChord
					name="Loving Chord"
					rank="C"
					desc="As a free action in response to starting a Bard song, the Bard may apply this Chord's effect to the song for the song's duration: Allied creatures within the song's range are healed for 8 HP at the start of their turn. Only one Chord effect may be active on a Bard song at a time."
				ProtectiveChord
					name="Protective Chord"
					rank="C"
					desc="As a free action in response to starting a Bard song, the Bard may apply this Chord's effect to the song for the song's duration: Allied creatures within the song's range gain +3 AC and +2 DR whilst it is active. Only one Chord effect may be active on a Bard song at a time."
				RefreshingChord
					name="Refreshing Chord"
					rank="C"
					desc="As a free action in response to starting a Bard song, the Bard may apply this Chord's effect to the song for the song's duration: Allied creatures within the song's range gain 5 MP at the start of their turn. Only one Chord effect may be active on a Bard song at a time."
				AggressiveMix
					name="Aggressive Mix"
					rank="B"
					desc="In order to mix up the intricacies of a Bard Song, a Bard may build up 1 'Style' stack for each turn that a single Bard song is sustained. All stacks are lost when changing songs. As a standard action and at the cost of 3 Style stacks, the Bard may cause a sudden, and aggressive Mix in their song, to drastically and forcefully change the tone. Upon doing so, enemy creatures within the song's range take 35 damage, and the Bard is forced to use their Bonus Action to switch to a new song, while their previous song is put on a 5 turn Cooldown."
				CalmingMix
					name="Calming Mix"
					rank="B"
					desc="In order to mix up the intricacies of a Bard Song, a Bard may build up 1 'Style' stack for each turn that a single Bard song is sustained. All stacks are lost when changing songs. As a standard action and at the cost of 3 Style stacks, the Bard may cause a subtle, and gradual change in tone. Upon doing so, allied creatures within the song's range are healed for 70 HP, and the Bard is forced to use their Bonus Action to switch to a new song, while their previous song is put on a 5 turn Cooldown."
				StalwartMix
					name="Stalwart Mix"
					rank="B"
					desc="In order to mix up the intricacies of a Bard Song, a Bard may build up 1 'Style' stack for each turn that a single Bard song is sustained. All stacks are lost when changing songs. As a standard action and at the cost of 3 Style stacks, the Bard may cause a bold and unexpected change in tone. Upon doing so, the Bard heals for 80 HP, gains +5 DR, and +4 AC, and up to 3 chosen enemy creatures may only target the Bard for 1 round ; and then the Bard is forced to use their Bonus Action to switch to a new song, while their previous song is put on a 5 turn Cooldown."
				ManaPaean
					name="Mana Paean"
					rank="B"
					desc="Targets of this song regenerate MP each round equal to the bard's charisma mod. This occurs in addition to a proc of the 'Refresh' status effect each turn this song is applied.  (- 20 STAMINA initial, 10 to sustain)"
				WardensPaean
					name="Warden's Paean"
					rank="B"
					desc="Targets of this song gain the 'Safe' status effect at the beginning of each of their turns. (-30 initial, 10 to sustain.)"
				MagickFinale
					name="Magick Finale"
					rank="B"
					desc="If an enemy target starts their turn while in the range of this song they have 1 beneficial status effect dispelled. (Starting from the most recently cast.) (-30 initial, 10 to sustain.)"
				WanderersMinuet
					name="The Wanderer's Minuet"
					rank="A"
					desc="Targets of this song have increased critical chance. Allies affected by this song have their critical hit range reduced by 1. In addition, critical hits made by Allies while this song is active deal 40 additional damage. (- 30 initial, 10 to sustain.)"
				RadiantFinale
					name="Radiant Finale"
					rank="S"
					desc="The bard puts their all into a final song. While this song is active targeted creatures are unable to be KOed or have their HP reduced below 0. The song lasts for 3 turns which at the end the Bard is rendered incapacitaed for 3 turns. (- 50 mana.)"


			Dancer
				jobneed="Dancer"
				icon='Icons/Perk/Dancer.png'
				atype="standard"
				DrainSamba
					name="Drain Samba"
					rank="D"
					desc="When the target of this dance is attacked, the attacker drains 20 HP from the target. Cannot exceed damage done by the ability or attack. Drains 5 SP per turn active."
				AspirSamba
					name="Aspir Samba"
					rank="D"
					desc="When the target of this dance is attacked, the attacker drains 15 MP from the target. Cannot exceed damage done by the ability or attack. Drains 5 SP per turn active."
				SpectralJig
					name="Spectral Jig"
					rank="C"
					desc="While dancing, as a reaction the dancer may halve all damage done until the start of the their next turn, using this ability ends their current dance instantly. Drains 20 SP."
				CelestialSashay
					name="Celestial Sashay"
					rank="C"
					desc="After activating a dance, as a standard action, the dancer may apply the following additional effect to the chosen dance: This dance releases a pulse of energy that heals all ally creatures within 5 tiles for 8 HP. Costs 20 MP to activate."
				BallroomBlitz
					name="Ballroom Blitz"
					rank="C"
					desc="When the target of this dance is attacked, the attacker gains an effective +5 to their rolled attack roll, and is deal an additional 10 true damage. Drains 15 SP per turn active."
				MartyrMacarena
					name="Martyr's Macarena"
					rank="C"
					desc="While this dance is being performed, all allies take 15 less damage from attacks. However, when an ally would take damage from an attack, the dancer then takes 15 true damage. Drains 15 SP per turn active."
				ShieldSamba
					name="Shield Samba"
					rank="B"
					desc="While dancing, as a bonus action, the Dancer may add the Shield Samba into the movements of their current dance. Until the start of their next turn allies within view gain 5 DR. This does not interrupt the current dance. This costs 20 MP."
				HeathenFrolic
					name="Heathen Frolic"
					rank="B"
					desc="While this dance is active the target has disadvantage on Magical attack rolls, Black Magic attack rolls, White Magic attack rolls, General Magic attack rolls, and Arcane Magic attack rolls. In addition, the Dancer gains advantage on saving throws against spells of those types - and has resistance to damage from spells of those types. Drains 15 SP per turn active."
				FeatherStep
					name="Feather Step"
					rank="A"
					desc="As a bonus action, while dancing, mix in a step as light as a feather into your dance. Make a melee attack roll. On a succesful attack the target is rendered vulnerable. Until the start of the dancer's next turn all attacks made against this target have advantage, and deal 15 additional damage. Drains 30 SP."
				Resplendance
					rank="S"
					cat="Unique"
					desc=" A dance that seems to twist time and dance around the user and the target. While performing the dance reality seems to fall away and they seem to be fighting in a white void. While the dance is active ; the target and the user are incapable of perceiving anything else. Attacks made towards them have advantage, and they also suffer disadvantage when making skill saves. They are also incapable of targeting anything else besides each other. If Finishing Flourish is used to end this dance, the additional damage it applies is 150 instead of 80. Drains 20 SP per turn active."


			BlueMage
				typing="magical"
				jobneed="Blue Mage"
				icon='Icons/Perk/Blue Mage.png'
				atype="standard"
				Scan
					rank="E"
					desc="As a bonus action, scan a creature. Make an insight roll. Depending on the roll gain detailed information on the creature. Able to determine creature type, resistances, weaknesses, HP, and whether they have blue mage abilities. While doing a dmed event DM reveals information, and can determine the creature's DC for the information. (-5 Mana.)"
				Manipulate
					rank="D"
					desc="The Blue mage connects with a creature to manipulate it. As long as they are aware that a spell or ability is in a monster's arsenal, they are able to manipulate the monster into using it on them, or their ally. This can only be used per encounter equal to the user's Charisma mod. (-15 mana.)"
				Rebound
					rank="D"
					desc="The Blue Mage reaches into the pocket void wherein they keep their 'Retain' spells. They then release a Retained spell, conjuring it forth at the cost of some Mana, as an exact copy of when it was captured. (-15 Mana.)"
				Sketch
					rank="B"
					cat="Unique"
					desc="The user has learned how to infuse the essence of a creature into a painted form by using magically infused paint and paper. It takes a full action to create a sketch. The user is able to transfer one ability of a creature and place it into a sketch, later using a standard action to cast that ability. They are only capable of carrying 5 sketches on them at a time, but can store any number for later use. Sketches are not destroyed when used. (When making a 'Sketch' - take a screenshot of the creature's ability usage, with all relevant information contained, in addition to the RP. Store this in a Scroll object, to be shown as proof when using later. The 'Sketched' ability uses the rolls that were used in the sketch screenshot.) Out of Battle Effects: This individual is a skilled artist. They are capable of creating life like sketches of creatures or people down to the smallest detail. However they are hyper focused, and cannot draw objects or landscapes to the same extent. (40 Mana to sketch, to cast uses the Sketched spell's cost.)"
				Mimic
					rank="A"
					cat="Unique"
					desc="The user copies any move used in the previous round beside their own. They perform the move with the target's own stats the target rolls the ability, and the Mimic chooses the target for the ability, and take the ability's drain +10. They can mimic any ability even if they do not possess the requirements to use them. This can not be used on S Rank abilities, only E-A."

			Beastmaster
				jobneed="Beast Master"
				icon='Icons/Perk/Beastmaster.png'
				atype="standard"
				ability=1
				damsource="str"
				costtype="Stamina"
				atype="standard"
				typing="physical"
				TamingStrikes
					desc="A Technique which is used by Beast Masters both to capture monsters and to punish insubordinate monsters. As a bonus action the Beast Master may convert their attacks for the round into ‘non lethal’ attacks. They can only deal up to half of their damage rolls, but defenses and mitigations are applied to the full damage to determine damage dealt. These Non-Lethal attacks can not reduce a target below 1 HP. Cost 20 SP."
					mcost=20
					rank="D"
					name="Taming Strikes"
				Callout
					desc="The Beast Master and their beast can communicate with one another in basic ways, the most well known of which being signals for threats. As a bonus action the Beast Tamer or their Monster can Call Out an enemy they can sense, alerting the other to their position. The Beast Master and their Monster can target any enemies the other could target. Cost 25 SP."
					mcost=25
					rank="C"
					name="Callout"
				CommandSwitch
					desc="The Pack Master has instilled a sense of unity in his monsters and they understand their weaknesses. As a Reaction when a monster is attacked the Pack Master may order a switch, prompting two of their monsters to trade positions so long as they are within 3 tiles of one another. When this is done, resolve the attack against the new monster. Both monsters involved also drain for this technique. Lone Wolves can learn and use Switch to trade places with their partner. Cost 25 SP."
					mcost=25
					rank="C"
					name="CommandSwitch"
				CommandMush
					desc="The Pack Master’s call encourages their monsters to hustle and speed up, by spending their standard action they gain 4 tile movement they can distribute among their monsters.Costs 30 SP."
					mcost=30
					rank="C"
					name="CommandMush"
				CommandSetUp
					desc="The Pack Master uses their standard action to direct their monsters, giving them methods to support one another. One monster of their choice gains an extra Standard Action or 2 different monsters gain an extra bonus action. 40 SP"
					mcost=40
					rank="C"
					name="CommandSetUp"
				CommandHeckle
					desc="The Pack Master gives a command to his monsters to heckle a target, hindering their ability to move freely rather than aiming for direct damage. The target makes a Reflex  Save, DC 8+Rank Bonus+Charisma or is afflicted with Slow and has their movement speed reduced by half. If they are hit by an attack of opportunity by these monsters they must make the save again or be knocked prone. DCs Increases by 3 per adjacent monster. Lasts 1 round per adjacent monster at the time of casting, ends early if they start their turn with no adjacent monsters. 45 SP."
					mcost=45
					rank="B"
					name="CommandHeckle"
				CommandGuard
					desc="The Pack Master gives direct commands for his monsters to group up and guard one another, denying opponents the option to attack them freely. When this is in effect the Pack Master and Monsters under their control gain the ‘Guard’ status, gaining +1 AC for every adjacent ally with the Guard status. 50 SP."
					mcost=50
					rank="B"
					name="CommandGuard"
				CommandSwarm
					desc="The Pack Master gives an order for his monsters to descend upon a single target as a full round action afflicting their target with the ‘Target’ status. Each successive monster to attack a ‘Target’ gains +3 to hit and deals +5 damage on all attacks they make. If all of their monsters attack the same target in 1 turn the final monster gains an additional standard attack. This status lasts for 3 rounds, requiring a standard action to sustain each turn, and caps at 3 stacks. 50 SP,  15 to upkeep."
					mcost=50
					rank="A"
					name="CommandSwarm"
				CommandStampede
					desc="The Pack Master has instilled a command into his pack for whenever they see him critically wounded. When the Pack Master is knocked unconscious they may use this as a free action, causing their monsters to go completely berserk and stampede through the battlefield. The Pack Master rolls to pick a target for each of their summoned monsters. Each target must make a Reflex Save, DC 10+Rank Bonus+Charisma + The Monster’s Rank. If they fail they suffer 10d10 + The Monster’s PDB or MDB damage, ignoring DR or half as much on a save. The Pack Master must roll death saving throws for every monster involved in this ability in accordance to the lethality of the encounter. "
					mcost=50
					rank="A"
					name="CommandStampede"




				//PreRework, remove once we have confirmed that all of these abilities. have been removed from current beastmasters
				CalmMonster
					name="Calm Monster"
					rank="D"
					cat="Unique"
					desc="The user attempts to calm down an aggressive monster. They can make a naturalist roll in order to influence the creature. The DM can decide what DC and what affect the calm with have. This can be making the monster less aggressive and gaining disadvantage, making the monster lose all will to fight, etc."
				StrategicLeadership
					name="Strategic Leadership"
					rank="C"
					cat="Unique"
					desc="This individual uses their standard action to give out commands to all their controlled creatures. Any actions the creatures take this turn gain a bonus of the users Charisma mod to their rolls."

			Samurai
				element="Physical"
				jobneed="Samurai"
				icon='Icons/Perk/Samurai.png'
				typing="physical"
				atype="standard"
				Retaliate
					rank="E"
					desc="The Samurai uses their standard action to enter a defensive state. While in this state, and until the start of their next turn they can make 2 reactions in a single turn, also increasing their AC by 1 if Retaliate is active. In addition, while Retaliate is active ; a Samurai is able to make 1 Standard Melee attack as a free action in response to an enemy within Melee range targeting them with any attack  Retaliate ends at the beginning of the Samurai's next turn. Costs 10 SP."
				Mineuchi
					rank="D"
					atype="weaponsave"
					basecheck=10
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 4
					costtype="Stamina"
					mcost=20
					damsource="str"
					savetype="Fortitude"
					desc="The Samurai imbues their blade with gravitational force, then swings downward attempting to exert the force upon the target, and increase their weight. This prompts a Fortitude saving throw (DC 10+STR+Rankbonus); dealing Weapon Damage+2d4+STR damage, and inflicting 'Heavy' on a failed save or half damage and no 'Heavy' on a success. (-20 Stamina.)"
				Yukikaze
					rank="D"
					atype="weapon"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 2
					damsource="str"
					savetype="Fortitude"
					mcost=20
					costtype="Stamina"
					desc="The Samurai imbues their blade with a shining sheen of ice, resembling a diamond.. They they make an attack roll towards the target, which on hit deals Ice damage, and prompts a DC 15 Fortitude saving throw ; inflicting Blind on failure, as the dazzling light blinds them in a flash. (- 20 stamina.)"
				TachiKagero
					name="Tachi Kagero"
					rank="C"
					atype="weaponsave"
					basecheck=10
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 4
					attack_roll_dice_sides = 7
					damsource="str"
					mcost=30
					savetype="Fortitude"
					costtype="Stamina"
					desc="The Samurai imbues their blade with a roaring, and passionate flame ; green in coloration. They then strike forth, releasing the fury of blade and flame simultaneously - prompting a Fortitude saving throw, thus dealing Weapon Damage+4d6+STR Fire damage and inflicting Burn on a failure, or half damage and no burn on a success. Costs 30 Stamina."
				Higanbana
					rank="D"
					atype="weapon"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 8
					damsource="str"
					mcost=25
					costtype="Stamina"
					desc="The Samurai cleaves with the force of a Sickle Weasel, dealing weapon damage+2d8+STR Wind damage, and inflicting 'Bleed' on a successful hit. (-25 stamina.)"
				Zeninage
					name="Zeninage"
					rank="C"
					desc="A very arcane, and curious technique passed down by Samurai through the ages. The Samurai pulls a bag of Gil out from their pouch, and slams their free palm onto it, placing a Kanji sealing tag upon it. The tag then ignites, and the bag of Gil bursts into an array of light particles. They then rearrange behind the Samurai in a dazzling display. When the Samurai points forward, the millions of dazzling light particles burst forth to skewer a target. Depending on the Gil spent, the attack deals a flat amount of damage, and has a different DC. On a failure, the target takes full damage and is inflicted with 'Astonished' - a unique status effect which causes them to have disadvantage on all rolls on their turn, unless they spend their movement and bonus actions to slap their face or pinch themselves. 10 Gil: 10 Damage, DC 12. 50 Gil: 20 damage, DC 14. 100 Gil: 30 damage, DC 16. 500 Gil: 20 damage, DC 18. 5.000 Gil: 50 damage, DC: 20. 10,000 Gil: 100 damage, DC 25. "
				Gyoten
					name="Gyoten"
					rank="C"
					desc="The user of this technique may accelerate their movement rapidly, utilizing the thought of protecting an ally as motivation. Using Gyoten, a Samurai may move up to their base Tile Movement per turn +1 tiles to reach an ally who is taking damage. If they are able to reach the ally, they take the damage in the ally's place. If they pass by Melee range of an enemy creature on the way there, they gain a free Standard attack against that creature. The first time this is used on a round is a free action. Any time after that requires a Reaction.  In the case of Multi-hit attacks and AoEs the Samurai covers all included allies, all instances of damages that all affected allies would take are instead assigned to the Samurai. Saves are auto-failed when covered for. All instances of damage being covered for, merge into a single combined instance with their base damage combined, which DR applies to only once.  Costs 10 Stamina."
				Shirahadori
					rank="C"
					desc="As a reaction, lash out with your blade in order to stop an incoming Melee attack. Perform a STR versus STR check contest against the attacker. On a failure, the attack's damage is reduced by 20 and if the attacker is attacking with a held weapon, the weapon is disarmed, requiring the target to use their bonus action on their next turn to pick it back up. Immediately after the contest, regardless of success or not ; the Samurai may make a Standard weapon attack roll against their target, which deals 10 additional damage on a successful hit. (-25 Stamina.)"
				MirrorofEquity
					name="Mirror of Equity"
					rank="B"
					desc="As a bonus action, the Samurai imbues their blade with strange red energy ; giving the blade a mirror-like sheen. The energy coats the blade, and curls around the Samurai's hand as well. While active, if the target of a Samurai's attack has more current HP than the Samurai's current HP, the attack will heal the Samurai for HP equal to half of the attack's total damage. In addition, this grants the Samurai a bonus of +2 PDB while active. This costs 20 MP to cast, and lasts for 3 rounds."
				GekkoCombo
					name="Gekko Combo"
					rank="B"
					atype="weapon"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_exact = 0
					damsource="str"
					addhit=6
					desc="The Samurai lashes out in a three part combo. Make three separate standard weapon attacks, each with a +6 to hit. If at least one attack hits; the Samurai receives a buff named Fugetsu, which lasts for 3 turns. While Fugetsu is active the Samurai receives +3 to their PDB, and their weapon may optionally deal Wind damage. In addition, their Weapon Attacks inflict the 'Squall' status effect on hit. Costs 50 Stamina."
				IaidoStance
					name="Iaido Stance"
					rank="A"
					costtype="Stamina"
					range="Melee"
					pre="Retaliate"
					desc="The Samurai enters a defensive stance, which is meant to ramp into an offensive manuever. They sheathe their blade, and stand their ground. This bars them from taking a regular Movement action on the turn it is used, but applies 'Retaliate' on use, and grants +5 Damage Reduction until the start of their next turn. On the turn after using Iaido Stance, the Samurai may choose to spend 50 SP in order to travel a 7 Tile line, and perform a Standard attack roll to all creatures in the line, with 30 additional damage applied."
				Tsubamagaeshi
					rank="A"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 10
					atype="weaponsave"
					damsource="str"
					basecheck=14
					savetype="Fortitude"
					range=" 3x3 AoE"
					mcost=60
					costtype="Stamina"
					desc="The Samurai makes a sweeping motion with their sword; targeting everything in a 3x3 radius around their position. Targets must succeed a DC 14+STR+Rankbonus Fortitude saving throw or be sent 6 tiles upwards, and take Weapon Damage+2d10+STR damage. If any creature is sent into the air, the Samurai may perform any C Rank or lower Samurai Ability they know which targets all airborne creatures in the 3x3 radius, at half cost - as a free action. Costs 60 Stamina."
				Demonsblood
					name="Demon's Blood"
					rank="S"
					desc="As a full turn action, the Samurai stabs their blade into the ground. From their location, a glyph extends outward to reach 5 seperate points on the battlefield, at locations of the Samurai's choice within 10 tiles of their current position. At each of these points, a spiritual copy of the Samurai appears. These spiritual copies have the exact same stats as the Samurai, however - they may only perform a singular action per turn. This action may be any known C Rank or lower Samurai ability, using its normal rules and the Samurai's own stats. After utilizing an action, a Phantom dissipates. Additionally, a Phantom is capable of utilizing the 'Gyoten' ability if the Samurai knows it, which allows the Phantom to take the brunt of an attack in the Samurai's place. If Gyoten is used by a Phantom, the damage to the Samurai's spiritual manifestation still occurs for the main body, as half of the damage the Phantom would have taken. After a Phantom uses Gyoten, it dissipates. Phantoms do not spend SP to utilize Samurai abilities, instead using themselves and dissipating as a resource after use. Phantoms persist for up to 3 rounds if not used. Costs 100 SP to cast."
				BushidoAbilities
					icon='Icons/Perk/Bushido.png'
					pre="Bushido"
					costtype=" Ken"
					Fang
						rank="D"
						mcost=2
						desc="As a bonus action, strike an enemy with your sword mimicking the fang of a wolf. Make a weapon attack roll. This attack deals the weapon's normal damage while ignoring half of the target's DR. (-2 Ken.)"
					Sky
						rank="D"
						mcost=2
						costtype="Ken"
						atype="weapon"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 2
						attack_roll_dice_sides = 6
						damsource="str"
						desc="As a reaction, strike at an enemy with a powerful overhead swing by exploiting a gap in the enemy's defenses. Make a weapon attack roll ; dealing weapon damage+2d6+STR damage on a successful hit, ignoring DR, and smashing the target into the ground. If the attack hits, they must perform a DC:15 Fortitude saving throw, or be afflicted with 'Stun'."
					Tiger
						rank="C"
						atype="standard"
						costtype="Ken"
						range=" Melee"
						damsource="str"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 4
						attack_roll_dice_sides = 8
						savetype="Fortitude"
						basecheck=12
						mcost=4
						desc="The user makes a deep cutting slash with their sword mimicking the claws of a tiger. Make a weapon attack roll. If the attacks hits, target first takes the damage of a normal weapon attack, and then is attacked by a 'Tiger' attack, which manifests as a Fortitude saving throw, DC 12+STR+Rankbonus, dealing 4d8+STR Thunder damage on a failure, or half as much on a success. On a failed save, the target is stricken with 'Paralyze'. Costs 4 Ken."
					Flurry
						rank="B"
						costtype="Ken"
						range=" 5x5 AoE"
						atype="weapon"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 3
						attack_roll_dice_sides = 10
						damsource="str"
						mcost=5
						desc="The Samurai makes a series of quick slashes barely seen by the naked eye. This attack targets all enemy creatures in a 5x5 AoE  around the Samurai. Make a single weapon attack that applies against all targets. The attack deals Weapon Damage+3d10+STR damage on hit. Costs 5 Ken."
					Dragon
						rank="B"
						atype="weapon"
						damsource="str"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 2
						attack_roll_dice_sides = 20
						mcost=6
						costtype="Ken"
						range=" 3 tile wide, 6 tile line."
						desc="The user charges Ken into their weapon ; stabbing forward and causing a Green Dragon of energy to erupt from the tip - then soaring forward and passing through anything in its path, draining their energy - and granting it back to the Samurai as lifeforce. (Damage: Weapon Damage + 2d20+STR | 3 tile wide, 6 tile line Weapon attack roll, absorbs HP and SP equal damage dealt -10 Ken.)"
					Eclipse
						rank="A"
						mcost=8
						attack_roll_damage_dice = FALSE
						attack_roll_damage_exact = 0
						adddam=6
						atype="weapon"
						range=" Melee"
						desc="The user swings their blade to the side, forming a glyph in the shape of the pattern of a full moon, lighting their visage up with a light blue shade. They make an attack towards the target. On a successful attack the moon goes black, and the target is stopped in their tracks ; frozen in time. (Damage: Weapon damage + 10 | Melee attack roll, inflicts 'Stop' on hit. -8 Ken.)"
					Oblivion
						rank="S"
						atype="weapon"
						adddam=50
						attack_roll_damage_dice = FALSE
						attack_roll_damage_exact = 0
						mcost=8
						desc="The Samurai forms a powerful stance, pouring everything they have into a single attack. They strike at an enemy, cutting deep and flooding them with glowing red energy as they bury their blade. This technique floods the target with potent energy, rupturing from the inside out through the cut. After this attack, they are heavily wounded, making combat harder after the strike - and inflicting them with the 'Weakness', 'Bleed' and 'Slow' status effects ; and disabling the target's ability to use Reaction actions for 2 rounds. In addition to these effects, if they are hit - they must make a Fortitude saving throw (DC 15 + STR + Rankbonus) - or be afflicted with 'Doom' in addition to the prior listed effects. (Damage: Weapon damage + 50 | Melee attack.  -8 Ken.)"

			MachAbilities
				icon='Icons/Perk/Machinist.png'
				jobneed="Machinist"
				cat="Unique"
				ability=1
				costtype=" Stamina"
				basecheck=10
				savetype="Reflex"
				RunCommand
					name="Run Command"
					rank="C"
					desc="The Machinist sends a command to one of their Robots. Upon doing so, that Robot gains an additional standard action. Doing so costs the Machinist 40 SP."
				DefensiveSubroutine
					name="Defensive Subroutine"
					rank="C"
					desc="The Machinist utilizes their tech to send a signal to one of their Robots, using a reaction. Upon doing so, their Robot gains an additional 'reaction' action in the moment this ability is used. Costs 40 SP."
				TacticalTargetting
					name="Tactical Targetting"
					rank="C"
					desc="The Machinist targets a specific enemy, and then performs a standard weapon attack. If this weapon attack hits the target, a tracking beacon is placed upon them, which grants any Machinist or Robot weapon attack or Ability against that creature +8 to hit, and causes it to deal 10 additional true damage (once per turn) on hit."
				MobilitySubroutine
					name="Mobility Subroutine"
					rank="C"
					desc="The Machinist grants a single Robot the ability to move double its movement speed for 3 rounds, at the cost of 40 SP."
				Overload
					name="Overload"
					rank="C"
					desc="The Machinist overloads their current weapon, and then attacks a target creature. This attack deals 2d10+20 additional damage, and ignores damage reduction. After utilizing this ability, that weapon malfunctions and cannot be used for 5 rounds. Costs 50 SP."
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 10
					mcost=50
					atype="weapon"
					damsource="int"
					typing="physical"
				BatonPass
					name="Baton Pass"
					rank="C"
					desc="The Machinist is able to make a standard attack with one of their Machinist weapons, and then switch to another as a free action, also making an attack with that weapon. This costs 50 SP to perform, and has a 4 turn cooldown."
					mcost=50
				MissileBarrage
					element="Metal"
					name="Missile Barrage"
					rank="B"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower = 40
					attack_roll_damage_upper = 50
					basecheck=14
					mcost=60
					range=" 8 tile range, 3x3 AoE."
					damsource="int"
					typing="physical"
					atype="save"
					desc="The Machinist points at a target, releasing a tracking laser on their location. The target is then assailed, and barraged by a flux of missiles, as a Reflex saving throw. On a failure, the creature is dealt full damage and knocked back 5 tiles in a direction of the Machinist's choosing, or half damage and no KB on a success. Costs 60 SP."
				SelfDestruct
					element="Fire"
					name="Self Destruct"
					rank="B"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_exact = 150
					atype="save"
					typing="physical"
					range=" 3x3 AoE centered on Robot."
					mcost=100
					desc="The Machinist activates the Self Destruct protocol for a Robot, permanently destroying it - and dealing 150 damage to any creatures within range, or half as much on a successful save. Costs 100 SP."
				OrbitalLaser
					element="Laser"
					name="Oribtal Laser"
					rank="A"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower = 40
					attack_roll_damage_upper = 50
					basecheck=15
					mcost=50
					range= " 3x3 AoE, sustainable, can move up to 5 tiles."
					atype="save"
					typing="physical"
					desc="The Machinist pulls out a laser pointer, and designates a specific location, sending a signal to an orbital laser. This laser then bares down at a tile in view, prompting a Reflex saving throw, and dealing full damage on a failure, or half on a success. This orbital laser can then be moved for the cost of 20 additional SP, and the Machinist's bonus action on their turn, for a maximum of 3 rounds.  Force Damage. Costs 50 initial SP."


			Paladin
				element="Holy"
				jobneed="Paladin"
				icon='Icons/Perk/Paladin.png'
				typing="physical"
				atype="standard"
				DivineThorns
					name="Divine Thorns"
					rank="E"
					desc="As a bonus action, the individual creates an aura that reflects and mitigates 1d12 damage (Holy) back at targets that strikes it with a Melee Attack. (Cost: 10 MP | Lasts 3 Rounds.)"
				HolyEnchant
					name="Holy Enchant"
					rank="D"
					desc="The Paladin is able to imbue their weapon or an ally’s weapon with Holy Light, granting it a Holy Infusion. | As a Bonus Action, this Infusion grants a bonus +2 PAB while also changing the element of the weapon attacks to Holy. Attacks made while this is active deal 10 additional True Damage on hit. | Infusion | ( Cost 10 MP | Last 3 Rounds )|"
				BracingBash
					element="Physical"
					name="Bracing Bash"
					rank="D"
					atype="weapon"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 1
					attack_roll_dice_sides = 8
					damsource="con"
					range=" Melee"
					mcost=15
					costtype="Stamina"
					desc="The Paladin stands their ground, raising their shield or weapon, then delivers a swift powerful blow with it. | Bonus Action (Damage: Weapon Damage + 1d8 + CON ) | Melee Weapon Attack Roll | (Cost: 15 SP)"
				Flash
					rank="D"
					desc="The individual emits a bright flash of Holy Light from their body in the attempts to blind all the targets around them. | Standard Action | 2 Tile Radius around the caster | Fortitude Save ( DC 12 + Rank Bonus + CHA ) | Applies Blind for 4 rounds on a Failed Save | (Cost: 15 MP) |"
					basecheck=12
					atype="save"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_exact = 0
					costtype="Mana"
					damsource="cha"
					mcost=15
				ShieldofLight
					name="Shield of Light"
					rank="C"
					atype="standard"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 1
					attack_roll_dice_sides = 12
					damsource="cha"
					range=" 6 tile line."
					mcost=20
					addhit=2
					costtype="Mana"
					desc="The Paladin holds up their weapon in front of them, spinning it quickly while infusing it with Holy magic; creating a magical disk to protect the Paladin from harm. This disk may then be potentially used to launch a counter attack. | As a Reaction upon being attacked, the Paladin is granted 50 Temp HP in the form of shield. If the Shield is not broken, the Paladin launches it as a Ranged Attack Roll (Damage: 1d12 + CHA ) with a +2 to PAB as a Free Action. The Shield then dissipates. (Cost: 20 MP) | This can be used with Cover | )"
				Cover
					rank="C"
					desc="The user, while in the heat of battle, valiantly jumps in front of their allies, taking an attack that was otherwise meant for them. | Once per round as a Free Action, and then as a Reaction for any subsequent usages that round; the Paladin may take an attack for an ally. Teleporting in front of them, then returning back to their position afterwards. The Paladin reduces the damage of the attack by a flat 15 points. (To a minimum of 1). If the Paladin attempts to block a Multi-Hit Attack or an AOE, the Paladin takes ALL instances of damage from every party member and is assumed to have failed their save against the attack. The total is added together BEFORE any forms of DR are applied. (IE. The 15 given by Cover itself.) (Cost: 10 MP | No Cooldown. Stacks with all other Damage Mitigation Reactions.)"
				HolyBarrier
					name="Holy Barrier"
					rank="C"
					desc="The individual creates a barrier of Magic around themselves using their Holy Magic. | As a Standard Action, the Paladin applies the 'Bubble' status to themselves with an additional 15 HP applied to it. The user is considered Immobilized whilst this ability is active. (Cost: 40 MP)"
				Supercharge
					rank="B"
					atype="weapon"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 12
					damsource="con"
					mcost=40
					costtype="Stamina"
					desc="The Paladin charges forward, shield or weapon raised; ready to knock down anything that stands within their path. | As a Movement Action, the Paladin is able to rush forward and make an attack; however must be AT LEAST 6 tiles away to use this ability. (Damage: Weapon Damage + 2d12 + CON + Additional damage to the users Physical DR) | Weapon Attack Roll | (Cost: 40 SP ) |"
				PassageofArms
					name="Passage of Arms"
					rank="B"
					desc="The individual kneels down, concentrating Holy Magic around them; causing them to sprout magical wings of Holy energy to protect themselves and their allies. | As a Standard Action, the Paladin creates a 3 Tile Cone behind them, granting the Paladin and any target behind them a bonus of +10 DR. The Paladin sacrifices their Standard, Bonus and Movement actions while sustaining this Stance, however are able to use two Paladin Abilities (Except Cover) per turn as Free Actions and may still use Reactions. (Cost: 25 MP to activate | 25 MP per turn to sustain. )"
				Crossover
					rank="A"
					atype="weapon"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 1
					attack_roll_dice_sides = 8
					damsource="cha"
					mcost=65
					costtype=" Melee"
					desc="The individual infuses their weapon temporarily with Holy Magic and strikes three times at their target, releasing that energy with each strike into the target upon hit. | As a Standard action, the Paladin makes 3 Melee Weapon Attacks; for each successful hit, the enemy gains a stack of 'Holy Energy' (Roll 1d10 (Holy) for each stack). If after 3 rounds, the Paladin is still above 0 HP, these stacks explode for the total amount rolled. ( Damage: Weapon Damage + 1d8 + CHA (Holy) ) | Melee Weapon Attack Roll | (Cost: 65 SP)"
				MinusStrike
					name="Minus Strike"
					rank="A"
					atype="weapon"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_exact = 0
					range=" Melee"
					mcost=70
					costtype="Stamina"
					desc="The individual summons a massive blade of Holy Light and uses it to deal a damaging blow to an enemy, dealing more damage the more injured the user is. | As a Standard Action, the Paladin makes a standard Weapon Attack (Damage: Weapon Damage ) that upon hitting, deals additional damage equal to half of the difference between the Paladin’s current HP and Maximum HP. (Cost: 70 SP | Weapon Attack Roll |+2 Cooldown)"
				Oversoul
					rank="S"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 20
					damsource="cha"
					atype="weapon"
					desc="The individual imbues their weapon with Holy Light, then proceeds to charge down an enemy, making a well aimed blow directly at the target's very soul. Upon landing the blow, the target is infused with Holy Magic, causing swords of light to explode from their soul in a blast of bright light. | Standard Action (Damage: Weapon Damage + 2d10 + CHA (Holy) | Melee Weapon Attack Roll | Deals 30% of target’s CURRENT HP on hit. | (Cost: None | Once per encounter. ) |"


			DarkKnight
				element="Dark"
				jobneed="Dark Knight"
				icon='Icons/Perk/DarkKnight.png'
				damsource="str"
				costtype="Mana"
				typing="physical"
				atype="standard"
				BloodWeapon
					name="Blood Weapon"
					rank="E"
					desc="This individual can cut themselves with their own blade allowing the blood to form a spiritual connection with the user. The more blood they spend, the more pleased their weapon becomes - and the more fierce in turn. | As a Standard Action the Dark Knight grants themselves 'Darkness' stacks that grant a +4 to PDB for every 10 HP spent; up to a maximum equal to the Dark Knight’s CON Modifier. (Lasts 5 turns.)|"
				Intimidate
					name="Intimidate"
					rank="D"
					desc="The Dark Knight slams their blade into the ground, beginning to beat at their chest with glowing eyes, forcing a nearby foe to temporarily avoid them. | As a Bonus Action, choose a single target. This target may not attack the Dark Knight until the start of the Dark Knight’s next turn. (Cost: 20 SP ) |"
				Taunt
					name="Taunt"
					rank="D"
					desc="As a master of negative emotions, the Dark Knight channels said energy combined with Dark Magic to force a single target into combat with them and them alone. | As a Standard Action, the Dark Knight selects a single target. This target may only attack the Dark Knight. This effect ends if the Dark Knight attacks another creature, uses an ability on another creature, or chooses to no longer sustain the Taunt. (Cost: 20 SP to activate, 10 SP and a Free Action to maintain) |"
				DarkCannon
					name="Dark Cannon"
					rank="D"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 1
					attack_roll_dice_sides = 6
					damsource="str"
					atype="save"
					savetype="Fortitude"
					basecheck=12
					mcost=10
					costtype="Mana"
					range=" 6 tiles."
					desc="Fire orbs of darkness that swirl forward and back to the user, which grab at a target's soul in order to drag them closer with a dark, magnetic force when successfully landed. (Damage: 1d6+STR dark | 5 Tile range, prompts a fortitude save of (12+Rank Bonus+STR), dealing full damage and pulling the target towards the caster by 2 tiles on a failure, or half damage on a success. - 10 Mana)"
				BlazingBlood
					name="Blazing Blood"
					rank="D"
					desc="As a bonus action the user heats their blood with dark energy to the point it is boiling. When this ability is active and they receive damage through physical attacks they receive an additional 1d8 damage. Upon taking damage, targets within a 3 tile radius around the user also take 2d6 dark damage from the boiling blood. Lasts until deactivated. (Costs 10 Mana per turn to sustain.)"
				Lifeeater
					name="Life Eater"
					rank="D"
					desc="The Dark Knight infuses their weapon with a lime green, soul-infused energy that drains the very lifeforce from their foes. | As a Bonus Action, whenever the Dark Knight deals damage to a target, they restore up to half of the damage dealt to their own HP. | This is a Lifesteal Proc | Infusion |. (Cap: 40 HP per proc | Cost: 20MP | Lasts 3 turns.) |"
				SoulEater
					name="Soul Eater"
					rank="C"
					desc="The Dark Knight surrounds their weapon in an aura of darkness that feeds off their very own life force, dramatically increasing their power. | As a bonus action the Dark Knight activates Soul Eater they are able to add the Dark Element to their attacks; and for each round it is active including the starting round, they must spend 10 HP, generating 1 stack of Soul Eater per 10 HP spent while active (Cap of 4 Stacks). They gain +1 PAB and deal an additional 2d4 Dark Damage on standard attacks per stack of Soul Eater. Each round the user may choose to instead drain 20 HP to generate Soul Eater quicker. (Lasts 5 rounds)|"
				DarkFlame
					name="Dark Flame"
					rank="C"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 4
					attack_roll_dice_sides = 4
					atype="weapon"
					range=" 6 tiles."
					mcost=30
					costtype="Mana"
					desc="While the Dark Knight has infused it’s weapon with the effects of Blood Weapon, they may stab the ground, causing a chain eruption of black flames that rapidly travels towards their target. These explosions can travel airborne.| Standard Action ( Weapon Damage + 4d4 (Dark) | Weapon Attack Roll | 6 Tile Range | Deals an additional 1d6 (Fire) per 'Darkness' stack, consuming them in the process | Cost: 30 MP )|"
				ImmolateSelf
					name="Immolate Self"
					rank="C"
					desc="The Dark Knight shrouds themselves in hellish flames, immolating themselves, in return for enhanced strength. | As a Bonus Action, the Dark Knight applies the ‘Shadow Burn’ negative status effect to themselves, dealing 3% MAX HP of damage to them per turn, while also granting them a +3 to their PDB. This also allows the Dark Knight to change their weapon attack’s element to Fire. Lasts until ended as a Bonus action or until combat ends. (Cost: 20 MP to activate, 3% MAX HP per turn to maintain.)|"
				WeightoftheWorld
					name="Weight of the World"
					rank="C"
					desc="The Dark Knight shrouds themselves in a gravitational force, making it harder for them to move, in return for enhanced strength. | As a Bonus Action, the Dark Knight applies the ‘Shadow Burden’ negative status effect to themselves, causing them to suffer a -2 to their Tile Movement, disadvantages on all STR checks and a +3 to their PDB while active. (Cost: 20 MP to activate, Free to maintain) |"
				FrozenSoul
					name="Frozen Heart"
					rank="C"
					desc="The Dark Knight turns their focus inwards, shutting themselves out to all around them, turning their heart an icy cold, granting them extra strength. | As a Bonus Action, the Dark Knight applies the ‘Shrouded Frostbite’ negative status effect to themselves, dealing 3% MAX HP of damage to them per turn, while also granting them a +3 to their PDB. This also allows the Dark Knight to change their weapon attack’s element to Ice. Lasts until ended as a Bonus action or until combat ends. (Cost: 20 MP to activate, 3% MAX HP per turn to maintain.)|"
				ExhaustedSoul
					name="Exhausted Soul"
					rank="C"
					desc="The Dark Knight begins to exhaust the energy and stamina from their very soul, empowering their strength. | As a Bonus Action the Dark Knight applies the ‘Exhausted Soul’ negative status effect to themselves, causing them to drain 10Mp and 10SP per turn in return for +3 PDB, +2 PAB and +2 MAB. Lasts until ended as a Bonus action or until combat ends. (Cost: 10 MP and SP to activate/ and per turn.)"
				SalttheEarth
					name="Salt the Earth"
					rank="C"
					desc="The Dark Knight wounds themselves with their weapon, causing darkness infused blood to spew into the immediate area, coating it in a sickly black miasma. | As a Standard Action, the Dark Knight spends 10 to 50 HP to place a 5x5 tile AOE centered on themselves, which deals 1d6 per 10 HP spent to a maximum of 5d6 damage (Dark) to any enemies who start their turns within the AOE. (Lasts 5 turns.)"
				DarkNebula
					name="Dark Nebula"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 5
					attack_roll_dice_sides = 10
					damsource="wis"
					savetype="Fortitude"
					atype="save"
					basecheck=13
					costtype="Mana"
					mcost=40
					desc="The Dark Knight holds out their hand,to fire a ball of dark magic, which upon contact with the ground, expands outwards into a globe like shape, drawing in their enemies before exploding in a powerful shockwave of darkness. | Standard Action ( 5d10 + WIS Damage (Dark) + 1d10 additional damage per Moxie Stack ) | 3x3 tile Radius within 7 tiles of the Caster | Fortitude Save ( DC13 + Rank Bonus + WIS) | Targets are pulled to the center of the AOE and take full damage on a Failed Save, and half damage on a Successful one.| (Cost: 40 MP)"
				SoulRender
					name="Soul Render"
					rank="B"
					costtype="Mana"
					mcost=60
					atype="weapon"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 4
					attack_roll_dice_sides = 10
					damsource="str"
					range=" 3 tiles"
					desc="The Dark Knight surrounds their weapon in dark mana, causing it to extend along it into a long blade. Which upon striking their target, drains a substantial amount of their life force. | Standard Action ( Weapon Damage + 4d10 + STR Damage ) | 3 Tile Range |  Restores half of damage dealt. This is an On-Hit Lifesteal Proc. Stacks with Life Eater. | (Cap: 50HP | Cost: 60 MP ) |"
				SeeyouinHell
					name="See you in Hell"
					rank="A"
					desc="The Dark Knight on the brink of death, musters what little life they have into their remaining negative emotions, sending out a shockwave of mana that lashes at their targets soul, attempting to kill them as well. | Use as a Free Action only if the caster was struck a killing blow via a direct spell or attack roll from a target within a 2 Tile Radius. If the target was below 40% of their Maximum HP, they automatically die alongside the Dark Knight. (Cost: 120 MP)"
				SanguineCross
					element="Dark"
					name="Sanguine Cross"
					rank="A"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 3
					attack_roll_dice_sides = 12
					damsource="str"
					range=" 5 tile cross centered on user."
					atype="weaponsave"
					savetype="Reflex"
					basecheck=15
					mcost=80
					costtype="Mana"
					desc="The Dark Knight draws upon their immense power, channeling it into their weapon, to which they slam it into the ground, sending eruptions of darkness in a cross pattern, tearing the ground asunder in its path. | Standard Action (Weapon Damage + 3d12 + STR) | 5 Tile Line in a cross, centered on the caster | Reflex Save (DC:15 + Rank Bonus + STR ) | Deals Full Damage + 1d12 damage (Dark) per “Darkness” stack, consuming them in the process on a failed save. Deals half damage on a successful save.| (Cost: 80MP)"
				MarkofDarkness
					name="Mark of Darkness"
					rank="S"
					desc="The Dark Knight surrounds their weapon with a pitch black aura that completely obscures the blade and attempts to pierce the target's heart. | As a Standard action, the user attacks their target. On a successful hit, the target takes 10d8 damage (Dark), and is rendered weak to the Dark Element and takes an additional 1d10 damage (Dark) per turn. (Cost: 100MP | Lasts 5 turns )"
				Zeal
					rank="S"
					desc="The Dark Knight bathes themselves in dark ethereal magic, becoming intangible to avoid danger for a brief moment of time. | As a Reaction, the Dark Knight may become completely invulnerable to Physical Attacks and are unable to interact with the Physical plane until the start of their next turn. Magic still affects them. (Cost: 100 MP)"


			HolyDragoon
				icon='Icons/Perk/HolyDragoon.png'
				ajob="Holy Dragoon"
				atype="save"
				savetype="Fortitude"
				basecheck=17
				attack_roll_damage_dice = TRUE
				attack_roll_dice_count = 6
				attack_roll_dice_sides = 12
				mcost=50
				range=" 5 tile cone."
				costtype="Mana"
				damsource="wis"
				typing="magical"
				HolyBreath
					element="Holy"
					name="Holy Breath"
					rank="B"
					desc="The Dragoon releases a powerful breath, as if a dragon themselves. This breath is imbued with the power of Holy, and prompts a saving throw against targets in its radius. (Damage: 6d12+WIS holy | Prompts a Fortitude saving throw, dealing full damage and inflicting Silence on failure ; and half on success. 5 tile cone. -50 Mana.)"
				FireBreath
					element="Fire"
					name="Fire Breath"
					rank="B"
					desc="The Dragoon releases a powerful breath, as if a dragon themselves. This breath is imbued with the power of Flame and prompts a saving throw against targets in its radius. (Damage: 6d12+WIS fire | Prompts a Fortitude saving throw, dealing full damage and inflicting Burn on failure ; and half on success. 5 tile cone. -50 Mana.)"
				FrostBreath
					element="Ice"
					name="Frost Breath"
					rank="B"
					desc="The Dragoon releases a powerful breath, as if a dragon themselves. This breath is imbued with the power of Ice and prompts a saving throw against targets in its radius. (Damage: 6d12+WIS ice | Prompts a Fortitude saving throw, dealing full damage and inflicting Frostbite on failure ; and half on success. 5 tile cone. -50 Mana.)"
				LightningBreath
					element="Thunder"
					name="Lightning Breath"
					rank="B"
					desc="The Dragoon releases a powerful breath, as if a dragon themselves. This breath is imbued with the power of Thunder and prompts a saving throw against targets in its radius. (Damage: 6d12+WIS lightning | Prompts a Fortitude saving throw, dealing full damage and inflicting Paralyze on failure ; and half on success. 5 tile cone. -50 Mana.)"
				WindBreath
					element="Wind"
					name="Wind Breath"
					rank="B"
					desc="The Dragoon releases a powerful breath, as if a dragon themselves. This breath is imbued with the power of Wind and prompts a saving throw against targets in its radius. (Damage: 6d12+WIS wind | Prompts a Fortitude saving throw, dealing full damage and inflicting a 5 tile knockback and Bleed on failure ; and half on success. 5 tile cone. -50 Mana.)"
				OceanBreath
					element="Water"
					name="Ocean Breath"
					rank="B"
					desc="The Dragoon releases a powerful breath, as if a dragon themselves. This breath is imbued with the power of Water and prompts a saving throw against targets in its radius. (Damage: 6d12+WIS water | Prompts a Fortitude saving throw, dealing full damage and Wet on failure ; and half on success. 5 tile cone. -50 Mana.)"
				PoisonBreath
					element="Bio"
					name="Poison Breath"
					rank="B"
					desc="The Dragoon releases a powerful breath, as if a dragon themselves. This breath is imbued with the power of Bio and prompts a saving throw against targets in its radius. (Damage: 6d12+WIS bio | Prompts a Fortitude saving throw, dealing full damage as well as Weakness, and Poison on failure ; and half on success. 5 tile cone. -50 Mana.)"
				SacredSpear
					element="Holy"
					name="Sacred Spear"
					rank="B"
					mcost=40
					costtype="Mana"
					desc="Calling upon the power of the most ancient and sacred of Dragons, the Dragoon imbues their weapon with the light of judgement. The light extends from their weapon as a spear of judgement, which pierces defenses. This is a bonus action to activate, and doing so grants your weapon 2d20 additional Holy damage on hit, as well as a 3 tile Melee extension, and 15 damage reduction piercing. It lasts for 3 rounds after being cast."
				RegalWings
					name="Regal Wings"
					rank="A"
					desc="The Dragoon may activate this ability as a bonus action. For every 30 Mana they spend, this ability lasts for 2 rounds (capping at 6 rounds with 90 Mana spent). Channeling sacred draconic energy, a holy light erupts from the Dragoon - and they gain draconic wings of light which sprout from their back. While these wings are active, the Dragoon has the Float status effect ; which is unremovable. In addition, they gain +2 additional tile movement AND jump tiles, +2 to PAB and MAB, and 8 PDB and MDB. This allows a Dragoon to change the damage type of their weapon attacks to Holy, optionally and at no cost. This also allows a Dragoon to utilize Glide's cardinal movement at full movement speed, instead of half. (-30 mana, up to 90 Mana.)"


			Ninja
				icon='Icons/Perk/Ninja.png'
				ajob="Ninja"
				typing="physical"
				atype="standard"
				Fuuinjutsu
					rank="B"
					atype="save"
					basecheck=15
					damsource="dex"
					savetype="Reflex"
					range="8 tile range."
					attack_roll_damage_dice = FALSE
					attack_roll_damage_exact = 0
					mcost=60
					costtype=" Stamina or Ninpo."
					desc="The user of this technique performs a Mudra that summons forth a set of adamantine chains to bind the target, and sap them of their energy to immobilize them. This prompts a Reflex saving throw, which if failed constricts the user, immobilizing them until they break out. In addition, they are drained of 30 Stamina and Mana per turn that they are bound in this way - which is then restored to the Ninja. After being bound, a Strength check with a DC equal to the Reflex save's DC must be made in order to break out, using a standard action to do so. The Ninja must use their Standard action each turn to sustain this effect. Out of battle effect: The Ninja may now seal objects and weapons into scrolls. An object sealed into a scroll this way becomes immune to any 'Steal' effects."
				Mikage
					rank="B"
					desc="The user performs a mudra that solidifies images around them. For each stack of blink form a clone of the user. The clone retains all basic stats, but has 10% of the HP as the user, and can only perform up to C rank abilities. Consumes all instances of blink upon use. (-40 stamina or Ninpo.)"
				ShurikenStorm
					element="Physical"
					name="Shuriken Storm"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 12
					range=" 10 tile range."
					addhit=2
					damsource="dex"
					desc="The user of this technique releases a flurry of Shuriken unsealed from a scroll, that attack separately as their own attack rolls. Up to three attack rolls are made, to targets of the caster's choice. 3 / encounter."
				Dokumoya
					element="Bio"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 5
					attack_roll_dice_sides = 10
					damsource="dex"
					range=" 7x7 AoE in a 10 tile range."
					mcost=60
					costtype=" Stamina or Ninpo."
					desc="The user of this technique performs a series of Mantra seals, condensing poisonous fog in their stomach, then releasing it in a corrosive mist. Creatures who start their turn in the cloud formed take Bio damage and are inflicted with 'Poison' each time they do so."
				Shunshin
					rank="B"
					desc="The user of this technique throws down a smoke-bomb, while also focusing their energy internally with a formed Mantra. They then flicker out of the smoke bomb to a position within 10 tiles to hide in the shadows with a supernatural camouflage, and are automatically stealthed without having to make a stealth check. It requires a DC 15 Perception check to notice them during this stealth. 3 / encounter. Out of battle effects: A Ninja who uses this technique may escape a scene completely unseen, with no discernable knowledge of which direction they might have gone, without sensory techniques being utilized. (-20 Stamina or Ninpo.)"
				Katon
					rank="B"
					desc="The user opens a scroll containing a powerful fire spell. The fire bursts out from the scroll in a 4 tile cone. Targets in the AoE must make a DC 22 Reflex saving throw or suffer 7d10 fire damage and be inflicted with 'Burn' and 'Weak'. 3 / encounter."
				Suiton
					rank="B"
					desc="The user opens a scroll containing a powerful water spell. A wave of water bursts out from the scroll sweeping away a 5x5 area infront of the user. Targets in the AoE must make a DC: 22 fortitude saving throw or suffer 7d10 water damage and be inflicted with wet. 3 / encounter"
				Doton
					rank="B"
					desc="The user opens a scroll throwing it onto the ground where the magic stored is released creating a patch of cursed earth 7x7 tiles in size. Targets starting their turn in the affected area suffer 4d10 earth damage. 12 tile range. This cursed earth remains for 4 rounds. 3 / encounter"
				Fuuton
					rank="B"
					desc="The user opens a scroll summoning a cutting whirlwind that travels to an area before releasing a torrent of cutting wind. Targets a 3x3 area. Targets in the AoE must make a fortitude saving throw DC: 22 or suffer 8d12 wind damage, and be inflicted with 'Bleed' until healed. 12 tile range. 3 / encounter."
				Hyoton
					rank="B"
					desc="The user opens a scroll releasing a frozen wind on a 5x5 tile area in front of them. The wind freezes all sources of water. Targets in the AoE must make a DC: 22 fortitude save or take 7d10 ice damage, and be afflicted with 'Slow' and 'Frostbite'. 3 / encounter."
				Kirigakure
					rank="B"
					desc="The user performs a series of Mantra which generates magical energy around them. This energy is then transformed into a mist, which manifests in a 7x7 AoE. Any party members or creatures who are friendly to the Ninja that start their turn within this Mist gain the 'Veil' status effect. In addition, any character with the Ninja perk who is within this mist gains a bonus of +5 to AC so long as they are within it. Out of battle effects: This Ninja may manipulate naturally occuring Mist and Fog, and clear or dispel non magical Mist/Fog based effects. (-50 Mana or Ninpo.)"
				Ryudan
					element="Holy"
					atype="standard"
					rank="A"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 9
					attack_roll_dice_sides = 12
					range=" 10 tile line."
					addhit=2
					mcost=100
					damsource="dex"
					costtype=" Mana or Ninpo."
					desc="The user performs a series of Mantra with their hands, before ending in a 'prayer' like configuration. After doing so, vital energy surges forth in the form of a golden dragon that soars at a target creature, threatening to slam into and shred them with its glowing maw, dealing Holy damage. Out of battle effects: This Ninja is now capable of communing with Dragons, Wyverns, and Drakes - and is well liked by them, having the blessing of the Dragon. Magical attack roll. Inflicts 'Bleed', 'Slow', and 'Silence' on hit. -100 Mana or Ninpo.)"
				Hikigaeru
					rank="A"
					desc="The user of this technique summons forth a large Ninja Toad to fight at their side using a summoning scroll, with a sheet of its own. Attaining this ability grants +50 HP, and +2 STR, also granting the 'Toad Kata', 'Magic Tongue', and 'Oil Bullet' Blue Mage abilities at no cost. Grants permanent Immunity to the 'Toad' status.  Incompatible with Hebi and Namekuji. The Toad summoned is counted as a 'Large' creature. Out of battle effects: This person is able to commune with Toads. Their personal Toad summon is sentient and has the ability to speak. (-60 Mana or Ninpo.)"
				Hebi
					rank="A"
					desc="The user of this technique summons forth a large Ninja Snake to fight at their side using a summoning scroll, with a sheet of its own. Attaining this ability grants +2 DEX, and a permanent +1 PAB. Grants permanent Immunity to the 'Break' status. Incompatible with Hikigaeru and Namekuji. A Hebi type Ninja also gains access to up to C Rank Arcane Magic. The Snake summoned is counted as a 'Large' creature. Out of battle effects: This person is able to commune with Snakes. Their personal Snake summon is sentient and has the ability to speak. (-60 Mana or Ninpo.)"
				Namekuji
					rank="A"
					desc="The user of this technique summons forth a large Ninja Snake to fight at their side using a summoning scroll, with a sheet of its own. Attaining this ability grants +50 MP, and SP ; as well as access to up to C Rank Green Magic. Grants the 'Regnerate' status permanently, which is unable to be dispelled. Grants permanent Immunity to the 'Silence' status. Incompatible with Hikigaeru and Hebi. The Slug summoned is counted as a 'Large' creature. Out of battle effects: This person is able to commune with Slugs. Their personal Slug summon is sentient and has the ability to speak. (-60 Mana or Ninpo.)"
				Juuinjutsu
					rank="A"
					cat="Unique"
					desc="This Ninja has a secret Ninja art placed upon their body which corrodes it in exchange for immense power drawn directly from the Aether. When activating this ability, the Ninja must spend 50 HP. It then drains 15 HP per turn active, but regenerates Ninpo for the Ninja to use later. While Juuinjutsu is active, the Ninja is surrounded by a purple fog that grants them +2 to hit, +5 physical and magical damage bonus, +1 tile movement, and advantage on all Ninja ability attack rolls. Any instance of Holy or Force damage this Ninja deals is changed to 'Dark' damage. Incompatible with Senjutsu. Out of battle effects: This person has a connection with Aether and Death. They are able to sense Aether energy, and locate its origin. They can also sense Undead creatures passively, as long as they are on the same map. (Regenerates 40 Ninpo per turn active.)"
				Senjutsu
					rank="A"
					cat="Unique"
					desc="This Ninja, similar to a Geomancer, has learned to combine their Ninja Arts with the natural essence of the Lifestream. Doing so requires an extremely calm mind. A Ninja using the Senjutsu technique must spend 2 full turn actions communing with the Lifestream. Once they have spent the necessary amount of time, the Lifestream makes a temporary connection with the Ninja, empowering their body and Ninjutsu greatly. They gain a Mako aura, and their eyes gain an emerald green coloration in the hues. Senjutsu lasts for exactly 5 rounds, and whilst it is active - a Ninja gains +2 to hit, +5 physical and magical damage bonus +1 tile movement, and advantage on all Ninja ability attack rolls. Any instance of Force or Dark damage this Ninja deals is changed to 'Holy' damage. When Senjutsu is first activated, the Ninja is healed for 50 HP exactly, as the Lifestream grants its blessing. Incompatible with Juuinjutsu. Out of battle effects: This person has a connection with the Lifestream. They are able to sense Lifestream energy, and locate its origin. They can also sense living creatures passively, as long as they are on the same map. (5 turn Duration. Regenerates 40 Ninpo per turn active.)"
				KogekiShinryaku
					element="Thunder"
					name="Kogeki Shinryaku"
					rank="A"
					cat="Unique"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 1
					attack_roll_dice_sides = 10
					damsource="dex"
					range=" 10 tile range."
					addhit=1
					mcost=80
					costtype=" 80 Mana or Ninpo."
					desc="The user of this technique performs a special Mantra, which materializes a Kunai made of magical energy that is then fired off at a target. Four of these Kunai are made, and are performed with separate attack rolls each. If a creature is hit by one of these Kunai, their soul is then 'marked' by a 'Kogeki' seal. A creature who has a Kogeki seal upon them can be teleported to by the Ninja irregardless of distance by spending either 40 Mana or 40 Stamina. When choosing to do so, the Ninja may utilize a basic attack or a Rogue, Ninja, General Magic, or General Weapon Ability as an incidental action upon appearing. This incidental action can also be used on a technique that has been turned into a Ninjutsu technique via the Ninpo Empowerment perk. Teleporting is a bonus action. The Kogeki seal lasts until the end of battle, and can not be cleared by Esuna or other cleansing effects."
				KogekiUkemi
					name="Kogeki Ukemi"
					rank="A"
					cat="Unique"
					desc="The user of this technique performs a special Mantra, which places a Kogeki seal on an object or party member within 1 tile of their current location. A Ninja who knows the Kogeki Ukemi technique may spend either 50 Mana or 50 Stamina as a reaction in order to instantly teleport to a placed Kogeki seal. This can teleport a maximum distance of 2 maps from the current position (if proof of a Kogeki seal is provided). If used to flee battle, the Ninja may not return to the scene until it has concluded. When using this teleportation reaction, negate any attack roll or prompted saving throw so long as you are teleporting out of the given attack or effect's area of effect. Seals that are placed outside of battle last for a maximum of 48 OOC hours. This only applies to seals placed by Kogeki Ukemi. Seals placed by Kogeki Shinryaku dissipate after battle ends. (-80 Mana or Ninpo.)"

			Reaper
				icon='Icons/Perk/Reaper.png'
				ajob="Reaper"
				atype="weapon"
				costtype=" Soul."
				damsource="wis"
				typing="physical"
				ShadowofDeath
					name="Shadow of Death"
					rank="D"
					costtype="Mana"
					mcost=10
					desc="As a bonus action, after making a successful melee attack, you may mark the target of the attack with the mark of death. While the mark of death is active, attacks made to that target by the user gain a bonus 1d8 dark damage, and generate an additional 5 soul per instance of damage dealt to that target. Only one individual can be marked at a time. (-10 mana per turn to sustain.)"
				RendingSlice
					element="Physical"
					name="Rending Slice"
					rank="C"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 1
					attack_roll_dice_sides = 12
					mcost=30
					costtype="Mana"
					atype="weapon"
					range=" 5 tile range"
					mcost=30
					desc="The user imbues their weapon with a sanguine red aura, radiating brightly. They then swing their weapon in an arc, releasing a blade of sharp blood at a target creature. On a successful hit, this projectile inflicts 'Bleed' on the target. (Damage: Weapon Damage + 1d12+WIS | Ranged Weapon attack roll, 5 Tile range, 3 Tile Wide projectile. -30 Mana.)"
				InfernalSlice
					element="Fire"
					name="Infernal Slice"
					rank="C"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 1
					attack_roll_dice_sides = 8
					mcost=30
					costtype="Mana"
					desc="The user imbues their weapon with a sinister aura, making an overhead swing bringing their weapon down onto an opponent slicing them across their body. (Deals weapon damage + 1d8 dark damage, and generates 10 bonus soul on hit. -30 mana.)"
				BloodStalk
					name="Blood Stalk"
					rank="C"
					mcost=20
					desc="As a bonus action, after making a successful melee attack expend Soul to summon an avatar of darkness to slice at the target with blood soaked claws. (Deals an automatic 2d10 slashing damage if target is suffering from Bleed, does 0 damage otherwise - drain 1d20 HP from the target if damage is dealt ; transferring it into soul instead of health.  -20 soul.)"
				NightmareSlice
					element="Physical"
					name="Nightmare Slice"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 1
					attack_roll_dice_sides = 12
					damsource="wis"
					mcost=40
					atype="weaponsave"
					savetype="Fortitude"
					basecheck=15
					costtype="Mana"
					desc="The user imbues their weapon with a fierce, and dark miasmic energy before swinging it around them as they bring their feet together like a top, allowing the weapon's movement to carry them - this releases a nova like tornado of dark energy that cuts at opponents in range within their path of movement. (Damage: Weapon Damage + 1d12+WIS dark damage. | 3x3 AoE centered around user - user may move up to 4 tiles, dragging the AoE with them. Prompts a reflex saving throw (DC 15+Rank Bonus+DEX), dealing damage on a failure or none on a success. Generates 5 soul per target hit. -40 mana.)"
				GrimSwath
					element="Physical"
					name="Grim Swath"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 4
					attack_roll_dice_sides = 8
					damsource="wis"
					range=" 3 tile cone."
					mcost=50
					basecheck=12
					atype="weaponsave"
					savetype="Fortitude"
					desc="The user summons their avatar of darkness, and it begins summoning forth bio-corruptive energy. The avatar then coughs out a plume of degrading energy, spreading the vile miasma in a cone in front of it.  (Damage: 4d8+WIS | 3 tile cone, prompts a Fortitude saving throw DC (12+Rankbonus+WIS) deals full damage and inflicts 'Poison' on a failure, deals half damage on a success.- 50 soul.)"
				Gluttony
					element="Dark"
					rank="B"
					mcost=80
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 5
					attack_roll_dice_sides = 12
					damsource="wis"
					range=" 3x3 AoE within a 6 tile range."
					basecheck=14
					atype="weaponsave"
					savetype="Fortitude"
					desc="The user summons their avatar of death, using it to create a glyph of malicious magic on the ground in range. The glyph activates shortly after, firing black beams of energy upwards which drain those who are unable to resist of their strength. Targets in the AoE must make a fortitude saving throw or take immense darkness damage and possibly suffer 'Weakness'. This ability is particularly effective on creatures who are already weakened, as it saps them of their strength more effectively. (Damage: 5d12+WIS Darkness | 3x3 AoE, 6 tile range, Fortitude saving throw, DC (14+Rankbonus+WIS) Full Damage + Weakness on failure | Half damage on save.  Additional 1d12 damage on creatures with 'Weakness' status effect. -80 soul.)"
				Enshroud
					rank="A"
					desc="The reaper offers their body as a vessel for the avatar of darkness letting it completely take control. While under the effects of enshroud the user has red eyes and takes on a sinister red aura. Dark damage heals them rather than damages them, they gain immunity to drain effects, and gain 1d12 bonus dark damage to every melee attack they make. While Enshroud is active, you may double the 'dark' type damage of an attack up to 3 times per encounter. While enshrouded the user can expend soul in place of HP when suffering an attack. While Enshroud is active, instead of gaining 5 Soul per instance of damage dealt ; they gain 10. (-20 soul per turn of duration, must spend a minimum of 60 on activation.)"


			Geomancer
				typing="magical"
				jobneed="Geomancer"
				icon='Icons/Perk/Geospells.png'
				damsource="cha"
				costtype="Mana"
				atype="standard"
				Earth
					element="Earth"
					atype="standard"
					icon='Icons/Perk/Stone.png'
					Stone
						rank="E"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 1
						attack_roll_dice_sides = 12
						mcost=10
						range=" 6 tile range."
						desc="The user calls to the ground, causing it to spit sharp rocks towards a target. Out of Battle Effects: This individual is capable of controlling earth. They can move and shape a 5ft block of earth. They are capable of making one 5ft area of earth into non difficult terrain. (Damage: 1d12+CHA earth| 6 tile range, magic attack roll, -10 Mana.)"
					Stonra
						rank="D"
						pre="Stone"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 2
						attack_roll_dice_sides = 12
						range=" 6 tile range."
						mcost=15
						desc="The user calls to the earth causing it to erupt spikes that aim to impale a target. Out of Battle Effects: This individual is capable of controlling earth. They can move and shape a 10ft block of earth. They are capable of making one 10ft area of earth into non difficult terrain. (Damage: 2d12+CHA earth | 6 tile range, magic attack roll, -15 Mana.)"
					Stoneaga
						rank="C"
						pre="Stonra"
						atype="save"
						savetype="Reflex"
						basecheck=12
						mcost=30
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 4
						attack_roll_dice_sides = 10
						range=" 3x3 AoE within a 10 tile range."
						desc="The user calls to the earth, causing pillars of rock to erupt from the ground and crush everything beneath it. Out of Battle Effects: This individual is capable of controlling earth. They can move and shape a 15ft block of earth. They are capable of making one 15ft area of earth into non difficult terrain. (Damage: 4d10+CHA | 10 tile range, 3x3 AoE. Prompts a Reflex saving throw (DC 12+WIS+Rankbonus), inflicting full damage and knocking prone on a failure, or half as much on a success. -30 Mana.)"
					Stonaja
						rank="B"
						pre="Stoneaga"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 5
						attack_roll_dice_sides = 12
						basecheck=15
						range=" 5x5 AoE within a 10 tile range."
						mcost=40
						atype="save"
						savetype="Reflex"
						desc="The user calls to the earth. They cause boulders to rise in the air before then releasing their hold, allowing them to drop down and cause mayhem upon a selected area of effect. Out of Battle Effects: This individual is capable of controlling earth. They can move and shape a 20ft block of earth. They are capable of making one 20ft area of earth into non difficult terrain. (Damage: 5d12+CHA earth | 10 tile range, 5x5 AoE. Prompts a Reflex saving throw, dealing full damage and inflicting prone on a failure, or half as much on a success. -40 Mana.)"
				SpiritedTree
					element="Nature"
					name="Spirited Tree"
					rank="D"
					desc="The user summons forth a tree from the ground. They speak to the tree bringing it under their control They may only control one tree at a time. While the tree is spirited they can spend a bonus action to have the tree perform the following attacks; Branch Arrow Branch Spear The tree has 50 HP, and resistance to all elements except Fire, which it is weak to. It also has its own set of ability scores. The Tree has its own MP pool. A tree can be planted in the ground and grown with Mana for the additional cost of 50 MP. Out of Battle Effects: This individual is capable of communicating with trees and plants. They can ask the plants for advice and knowledge and can ask favors as well. (-10 Mana per turn to sustain connection.)"
					BranchArrow
						name="Branch Arrow"
						rank="D"
						pre="Spirited Tree"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 2
						attack_roll_dice_sides = 12
						range=" 8 tile range."
						mcost=10
						desc="The tree releases an enchanted arrow, forged of its own branches from its structure - at a single target. (Damage: 2d12+CHA piercing | 8 tile range, Ranged attack roll, -10 Mana.)"
					BranchSpear
						name="Branch Spear"
						rank="C"
						pre="Branch Arrow"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 3
						attack_roll_dice_sides = 12
						range=" 8 tile range."
						mcost=25
						desc="The tree fires off an enchanted spear, forged of its own branches - at a single target. (Damage: 3d12+CHA piercing | 8 tile range, ranged attack roll - inflicts bleed on successful hit. -25 Mana.)"
				InfuseElemental
					name="Infuse Elemental"
					rank="C"
					desc="As a reaction, after being damaged by an Elemental damage spell, and if the Geomancer's 'Spirited Tree' has been summoned, the Geomancer may redirect that elemental energy to the tree. Upon doing so, the Tree gains immunity to the element afforded to it, and shifts forms, gaining the 'aja' spell for the element it shifts to. This can be used instead as a Bonus action to revert the elemental back into the form of a Spirited Tree."
				ElementalMagnet
					name="Elemental Magnet"
					rank="C"
					desc="As a reaction, the Geomancer may activate a field of magic around themselves which draws elemental attacks in. Upon doing so, the Geomancer may redirect the damage of a Fire, Water, Earth, Thunder, Ice, or Wind based spell that is targeted at an ally to themselves, and also reduce its incoming damage by 10 points before applying resistance. In the case of an AoE, the entire AoE is drawn towards them, and they must take damage for each party member that would have taken damage from it initially. This costs 15 MP to activate. Exempt from Cooldowns. "
				Bindweed
					rank="C"
					desc="The user calls out to the nature in the area around them. They can select a number of targets equal to their WIS mod, within 10 tiles. The user causes the weeds around the targets to grow rapidly wrapping around the legs of the targets. This causes targets to become immobile. Targets can use their standard action to cut the weeds with a slashing weapon. (-30 Mana.)"
				LifestreamRain
					element="Heal"
					atype="heal"
					heal=1
					name="Lifestream Rain"
					damsource="cha"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 3
					attack_roll_dice_sides = 20
					rank="C"
					desc="The user calls out to the Lifestream, and draws it out in a font overhead. This Lifestream energy then rains down upon the area, healing all designated creatures within the radius for 3d20+CHA HP. In addition, this Lifestream energy has a reinvigorating power. Once per 24 hours, a Geomancer who knows this spell can use the 'Node Refresh' verb in order to reinvigorate any Gathering nodes within a 12 tile radius of their current position, out of combat. (-40 Mana)."
					verb
						Refresh()
							alert(usr,"Are you sure you wish to use Lifestream Refresh? This can only be done once per 24 hour period.")
							var/list/roles=list("Yes","No")
							var/rolechoice=input(usr,"Use refresh?") as anything in roles
							switch(rolechoice)
								if("Yes")
									view() << output("<font color=[usr.textcolor]><b>[usr]</b></font> has called upon the power of the <b></font color=#A3F875>Lifestream</b></font> to refresh the Natural Resources around them!","icout")
									usr.Lifestreamraincooldown=1
									for(var/obj/resource_node/mining/a in view(12))
										if(a.name=="Mine Node")
											a.icon_state="Ore"
											a.used=0
									for(var/obj/resource_node/sifting/a in view(12))
										if(a.name=="Dirt Node")
											a.icon_state="dirtpile"
											a.used=0
									for(var/obj/resource_node/mako/a in view(12))
										if(a.name=="Materia Node")
											a.icon_state="activemako"
											a.used=0
									for(var/obj/resource_node/foraging/a in view(12))
										if(a.name=="Herb Node")
											a.icon_state="Herb"
											a.used=0
									for(var/obj/resource_node/hunting/a in view(12))
										if(a.name=="Hunter Node")
											a.icon_state="trap"
											a.used=0

								if("No")
									return

				Sandstorm
					rank="C"
					desc="The user calls out to the nature in the sand around them causing it to whip up into a wicked sandstorm. Can affect up to a 6x6 area within 15 tiles of the caster, as long as there's enough sand tiles (needing a minimum of 1). Targets in the AoE suffer 2d8 earth damage at the start of their turn for as long as they are in the storm. Targets must also make a fortitude saving throw, DC 15 ; or suffer blind. (-30 mana to cast -10 mana to sustain.)"
				ShiningFlare
					element="Laser"
					name="Shining Flare"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 5
					attack_roll_dice_sides = 10
					range=" 1 tile within 8 tiles of the caster, beam can move in a 5 tile line."
					atype="save"
					savetype="Reflex"
					basecheck=16
					mcost=40
					desc="The user harnesses the power of a sunny day to smite their foes. The user calls out to the power of the sun, concentrating its power into a beam of energy. Can only be used outside when the sun is shining. (Damage: 5d10+CHA fire | Generates a beam at a chosen tile within 8 tiles of the caster, the beam then moves in a 5 tile line from that tile. Prompts a Reflex saving throw from any creature it passes, dealing full damage and inflicting 'Burn' and 'Weakness' on a failure, or half as much on a success. -40 mana.)"
				Quake
					element="Earth"
					rank="A"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 7
					attack_roll_dice_sides = 10
					basecheck=12
					range=" 6x6 AoE within 20 tiles of the caster."
					savetype="Fortitude"
					atype="save"
					mcost=65
					desc="The user causes the earth to quake violently, anything in the area is throw around at the whims of the earth beneath them. This is considered the 'ultimate' Earth spell. (Damage: 7d10+CHA earth | 6x6 AoE within 20 tiles of the caster, prompts a fortitude saving throw - dealing full damage and inflicting prone on a failure, or half as much on a success. -65 mana.)"
				Whirlpool
					element="Water"
					rank="A"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 4
					attack_roll_dice_sides = 10
					range="5x5 AoE on any water in view."
					savetype="Athletics Check"
					mcost=65
					basecheck=14
					atype="save"
					desc="The user reaches out to an area of water stirring it into a powerful whirlpool. Those caught within the radius of the Whirlpool must prove their physical abilities, or be sucked to the watery depths and crushed under the raging tide. (Damage: 4d10+CHA water | 5x5 AoE on any water in view, prompts a DC (base 14) athletics check, disabling movement for 1 turn on a failure. Damage is always taken when starting one's turn within the whirlpool. -65 mana. -15 mana per turn to sustain.)"
				MagmaSpout
					element="Fire"
					name="Magma Spout"
					rank="A"
					desc="The user calls out to the powers deep within the earth. They cause spouts of magma to erupt from the ground. They can create a number of magma spouts equal to their wisdom modifier. Each magma spout covers a 3x3 tile area. Magma spouts remain for the duration of battle. Magma spouts create pools of magma in their AoE. Targets who end their turn in a magma pool take 10 fire damage, 15 earth damage, and suffer 'Burn' and 'Slow'. Magma spouts can be created within 15 tiles of the caster. (-65 mana.)"
				BlackHole
					element="Dark"
					name="Black Hole"
					rank="S"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 6
					attack_roll_dice_sides = 12
					range=" 3x3 AoE at a tile in view."
					mcost=100
					atype="save"
					savetype="Fortitude"
					basecheck=15
					desc="Can only be performed in a cave with no source of light for 60ft. The individual calls to the natural darkness of the area around them - then, they converge it into a single point creating a swirling vortex of energy that draws in everything around it, with crushing gravitational force. (Damage: 6d12+CHA dark damage. | Black hole takes up a 3x3 AoE, and prompts hostile creatures within 6 tiles of it to make a Fortitude saving throw (DC 15+WIS+Rankbonus) ; on a failure, the target is drawn 3 tiles towards the epicenter, and take Black Hole damage. If a target fails the saving throw in the epicenter of the Black Hole, they are inflicted with the 'Doom' status effect. Black Hole lasts for 5 turns. -100 mana.)"


			ChemistAbilities
				jobneed="Chemist"
				icon='Icons/Perk/Chemist.png'
				ability=1
				typing="physical"
				costtype="Stamina"
				basecheck=10
				damsource="con"
				MutliChemical
					rank="C"
					name="Multi Chemical"
					desc="As a free action, after utilizing a Chemist item, the Chemist may then utilize a secondary Chemist item, at the cost of 20 SP."
				ElementalReagent
					rank="C"
					name="Elemental Reagent"
					desc="As a reaction to an elemental ability being cast, the Chemist may toss a Potion, or Potion variant into the Elemental attack. The Potion is infused into it, and the damage of the Elemental attack is reduced by the amount the Potion would heal. This costs 20 SP."
				Transmutation
					pre="Alchemist"
					rank="B"
					adddam=15
					TransmuteSoil
						name="Transmute Soil"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 4
						attack_roll_dice_sides = 12
						range=" 5x5 AoE at a tile in view."
						mcost=50
						atype="save"
						savetype="Fortitude"
						basecheck=14
						desc="By transmuting one's life essence into the ground, they manipulate the various chemical compounds in the Earth, and shift the molecular composition into that of spikes ; dealing earth damage, and inflicting bleed on a failed save, or half damage and no bleed on a success. This ability does not target allies."
					TransmuteAir
						name="Transmute Air"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 4
						attack_roll_dice_sides = 12
						range=" 5x5 AoE at a tile in view."
						mcost=50
						atype="save"
						savetype="Fortitude"
						basecheck=14
						desc="By transmuting one's life essence into the air, they manipulate the Oxygen in the air to create a tornado at a target location;  wind dealing damage, and inflicting Squall on a failed save, or half damage and no Squall on a success. This ability does not target allies."
					TransmuteFlames
						name="Transmute Flames"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 4
						attack_roll_dice_sides = 12
						range=" 5x5 AoE at a tile in view."
						mcost=50
						atype="save"
						savetype="Fortitude"
						basecheck=14
						desc="By transmuting one's life essence into the air, they manipulate the gaseous compounds in the air, and ignite it into a roaring fireball; dealing  fire damage, and inflicting Burn on a failed save, or half damage and no Burn on a success. This ability does not target allies."
					TransmuteWater
						name="Transmute Water"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 4
						attack_roll_dice_sides = 12
						range=" 5x5 AoE at a tile in view."
						mcost=50
						atype="save"
						savetype="Fortitude"
						basecheck=14
						desc="By transmuting one's life essence into the air, they manipulate the H20 in the air to create a water whorl at a target location; dealing damage, and inflicting Whorl on a failed save, or half damage and no Whorl on a success. This ability does not target allies."
					TransmuteIce
						name="Transmute Ice"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 4
						attack_roll_dice_sides = 12
						range=" 5x5 AoE at a tile in view."
						mcost=50
						atype="save"
						savetype="Fortitude"
						basecheck=14
						desc="By transmuting one's life essence into the air, they manipulate the H20 in the air to create transform the moisture into orbs of Ice; dealing damage, and inflicting Frostbite on a failed save, or half damage and no Frostbite on a success. This ability does not target allies."
					TransmuteFlesh
						name="Transmute Flesh"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 50
						attack_roll_dice_sides = 1
						range=" 5x5 AoE at a tile in view."
						mcost=50
						atype="heal"
						savetype="Fortitude"
						basecheck=14
						desc="By transmuting one's life essence into a target's flesh, they may manipulate their bio-mass in order to restore 50+CHA HP, and apply the Regenerate status effect to any creature within range."
					TransmuteSteel
						name="Transmute Steel"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 4
						attack_roll_dice_sides = 12
						range=" 5x5 AoE at a tile in view."
						mcost=50
						atype="save"
						savetype="Fortitude"
						basecheck=14
						desc="By transmuting one's life essence into the Earth, they manipulate the metallic alloys in the ground to create skewering steel beams; dealing physical damage, and inflicting a 10 tile Knockback in a direction of the caster's choice on a failed save, or half damage and no knockback on a success. This ability does not target allies."
					TransmuteEnergy
						name="Transmute Energy"
						desc="By transmuting one's life essence into a creature's soul, reinvigorating them - and granting them 50 MP and SP in exchange for 50 SP from the caster."
					TransmuteSoul
						name="Transmute Soul"
						desc="By transmuting one's life essence into a downed creautre, they are able to bring them back from being unconscious, at 50% HP. The Chemist is reduced to 10 HP upon doing so, as they sacrifice an immense amount of their own vitality to do so."


			PirateAbilities
				jobneed="Pirate"
				icon='Icons/Perk/Pirate.png'
				ability=1
				typing="physical"
				costtype="Stamina"
				basecheck=10
				element="Water"
				Splash
					rank="D"
					name="Splash"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower = 10
					attack_roll_damage_upper = 15
					range=" 8 tile range."
					atype="standard"
					mcost=10
					desc="The Pirate releases a burst of water from their hand, dealing water damage to a target on hit. Costs 10 SP, and has an 8 tile range."
				BubbleBlade
					rank="D"
					name="Bubble Blade"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower = 12
					attack_roll_damage_upper = 18
					mcost=15
					atype="weapon"
					range=" Melee."
					desc="The Pirate wraps their weapon in a bubble, and then strikes at an opponent, causing it to pop on hit. On hit, knocks the target back 5 tiles. Deals water damage. This creates a 3x3 Water AoE as a puddle at the point of attack, regardless of miss or hit, which persists for 3 rounds. Any enemy creatures within this AoE suffer -3 AC. Costs 15 SP."
				BubbleBeam
					rank="C"
					name="Bubble Beam"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower = 20
					attack_roll_damage_upper = 35
					mcost=30
					range=" 7 tile line."
					savetype="Fortitude"
					atype="save"
					basecheck=12
					desc="The Pirate tosses both hands forward, and releases a stream of bubbles forth, dealing damage to all creatures in a 7 tile line, and applying wet on a failed save ; or half damage and no wet on a success. Costs 30 SP."
				TyphoonCutter
					rank="C"
					name="Typhoon Cutter"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower = 25
					attack_roll_damage_upper = 38
					mcost=35
					atype="weapon"
					range=" 7 tiles, 3 tile wide. Generates 5x5 persisting AoE."
					desc="The Pirate releases a swing of their blade, as a 3 tile wide 'crescent' strike, striking any creature that it passes through. This then creates a 5x5 Water AoE at the point of contact, which persists for 3 rounds. Any enemy creatures within this AoE are dealt 10 wind damage at the start of their turns. Costs 35 SP."
				LakeBlade
					rank="C"
					name="Lake Blade"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower = 30
					attack_roll_damage_upper = 40
					mcost=45
					atype="weapon"
					range=" Melee"
					desc="The Pirate swings their blade upward, generating a ball of water at the tip. They then strike downward, allowing the ball of water to explode. generating a 3x3 AoE, which persists for 3 rounds. Creatures within this AoE suffer -3 to hit. Costs 45 SP."
				NautilusAnchor
					rank="C"
					name="Nautilus Anchor"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower = 25
					attack_roll_damage_upper = 30
					atype="standard"
					range=" 8 tiles"
					mcost=40
					desc="The Pirate manifests an anchor of aetheric energy in-hand, then tosses it forward in order to attempt grabbing an opponent, dealing damage on a hit, and then prompting a STR check contest between caster and target. If the caster succeeds, the target is dragged to a tile within the distance between the two, of the caster's choice. Costs 40 SP."
				WildWave
					rank="C"
					name="Wild Wave"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower = 35
					attack_roll_damage_upper = 45
					mcost=50
					savetype="Reflex"
					atype="save"
					basecheck=14
					desc="The Pirate cups their hands together at their side, gathering water in their palsm - before releasing them forward, releasing a rolling wave of water that prompts a Reflex saving throw. On a failure, creatures take full damage and are dragged to the end of the attack's range. On a success, they take no damage and are not dragged. 50 SP."
				BubbleField
					rank="C"
					name="Bubble Field"
					mcost=40
					desc="The Pirate releases a barrage of bubbles from their body, which then wrap around up to 4 target creatures' bodies. The next time these creatures take damage, the bubbles pop - dealing 15 true damage, and knocking the creature back in a direction of the caster's choosing, 2 tiles. 40 SP."
				WaterfallCrash
					rank="B"
					name="Waterfall Crash"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower = 50
					attack_roll_damage_upper = 60
					mcost=55
					basecheck=14
					savetype="Fortitude"
					range=" Melee"
					atype="save"
					desc="The Pirate tosses both hands above their head, releasing a stream of water that then comes down as a crashing waterfall on a creature in Melee range. This prompts a Fortitude saving throw, dealing full damage on failure, or half on success. This then creates a 3x3 AoE around the caster which persists for 3 rounds, afflicting 'Whorl' to any creature that starts their turn within 55 SP."
				TyphoonVortex
					rank="B"
					name="Typhoon Vortex"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower = 55
					attack_roll_damage_upper = 65
					range=" 3 tile wide, 7 tile line."
					savetype="Fortitude"
					atype="save"
					desc="The Pirate compresses water in their palm, before tossing it forward, allowing it to explode outward in a massive burst of water. This attack inflicts 'Bleed' and 'Heavy' on failed save, and deals water damage. 60 SP."
					mcost=60
				WaterWhip
					rank="B"
					name="Water Whip"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_exact = 70
					mcost=70
					atype="standard"
					desc="The Pirate creates a whip of water in their hand, and then swings it forth to smack into a target. On hit, this sends the target creature flying in a direction of their choosing, 5 tiles. If they impact a surface or another creature, both targets take 30 true damage. Costs 70 SP."
				GreatLake
					rank="B"
					name="Great Lake"
					mcost=60
					desc="The Pirate creates a 7x7 AoE of water, which persists for 3 rounds. This area afflicts 'Whorl', 'Slow', and 'Heavy' to all creatures who start their turn within its range. 60 SP"
				ManifestOcean
					rank="A"
					name="Manifest Ocean"
					mcost=60
					desc="The Pirate transforms the terrain of the battlefield, for 5 rounds. This area is considered filled with water, and creatures who start their turn within it are afflicted with 'Whorl', 'Slow', 'Heavy', and 'Weakness'. 60 SP"
				CaptainCutlass
					rank="A"
					name="Captain's Cutlass"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower = 80
					attack_roll_damage_upper = 85
					atype="standard"
					mcost=70
					addhit=5
					desc="The Pirate creates a massive blade of water, the attack gaining +5 to hit, in their hand, and then cleaves downward, dealing massive amounts of Water damage on hit, and also inflicting 'Bleed'. If the creature is already bleeding when hit, they take 40 additional true damage. 70 SP."



			TimeMage
				jobneed="Time Mage"
				icon='Icons/Perk/TimeMage.png'
				costtype="Mana"
				damsource="int"
				typing="magical"
				atype="standard"
				element="Time"
				Times
					icon='Icons/Perk/Time.png'
					Slow
						rank="E"
						atype="save"
						savetype="Reflex"
						attack_roll_damage_dice = FALSE
						attack_roll_damage_lower = 8
						attack_roll_damage_upper = 12
						basecheck=10
						mcost=10
						range="6 tile range."
						desc="The user creates an ethereal clock that slows a target upon contact, and launches it forward at a single target.  Out of Battle Effects: This spell can be cast against objects in order to make them 'heavier' by making them move 'slower' when force is applied to them. (6 Tile range, prompts a Reflex saving throw (DC 10+INT+Rankbonus), inflicting 'Slow' on failure. -10 Mana.)"
					Haste
						rank="E"
						desc="The user releases a burst of accelerating energy, which grants 'Haste' to a target in range. Haste lasts 2 turns. Out of Battle Effects: This spell can be cast on objects in order to make them 'lighter' by making them move 'faster' when force is applied to them. (6 tile range, -5 Mana.)"
					Teleport
						rank="E"
						desc="As a movement action the user uses magic to place themselves in another place in space instantly. They can travel anywhere in view as long as the tile is unoccupied. The user can travel a maximum of 1 tile per INT mod point. This action is immune to Attacks of Opportunity and similar reaction due to being instant. (-10 mana.)"
					Slowga
						rank="C"
						pre="Slow"
						range=" 3x3 AoE in a 10 tile range."
						atype="save"
						savetype="Reflex"
						basecheck=10
						mcost=30
						desc="The user of this ability casts forth a concentrated ball of time magic that explodes into ethereal time altering clocks which slow everything they touch.  (10 tile range, explodes into a 3x3 AoE. Prompts a Reflex saving throw (DC 10+INT+Rank bonus) - inflicting 'Slow' on a failure. -30 mana)"
					Hastega
						rank="C"
						pre="Haste"
						desc="The user sends out a nova of accelerating energy around themselves, granting all friendly allies haste within a 5x5 AoE range around the user. Haste lasts 1 turn when applied via Hastega. (-30 mana.)"
					Stop
						rank="B"
						pre="Slowga"
						range=" 6 tile range."
						savetype="Reflex"
						atype="save"
						basecheck=13
						mcost=50
						desc="The user generates an ethereal 'clock' shaped projectile, that upon making contact with its target stops it in time if it makes contact with them. Out of Battle Effects: Can be cast on an object to lock it in time. Force can be applied to the object that hits all at once when the object is unfrozen. (6 tile range, prompts a Reflex saving throw, DC 13+INT+Rank bonus, inflicting 'Stop' on a failure.) (-50 Mana.)"
					Warp
						rank="B"
						pre="Teleport"
						atype = "save"
						savetype = "Fortitude"
						basecheck = 10
						mcost = 55
						desc="Changes a target's location in space. As a standard action warp anything in view placing it up to 10 tiles away in any direction. When used on a hostile target, the target can make a fortitude saving throw to negate the effect. Spell can also be cast as a 30 minute ritual to warp the user and everyone directly around them to a spot they have previously been to, as long as the caster has marked it. (Fortitude saving throw, DC 13 + INT + Rankbonus, - 55 mana.)"
					Stopaga
						rank="A"
						pre="Stop"
						atype="save"
						savetype="Fortitude"
						basecheck=13
						attack_roll_damage_dice = FALSE
						attack_roll_damage_exact = 0
						mcost=65
						desc="The user creates a giant clock made of magic on the ground around them. The clock hands slow until they stop causing time to stop in the entire area except for the user and their allies. Targets in the AoE (5x5) must make a fortitude saving throw or be afflicted with stop for 4 turns. (DC 13+INT+Rank bonus.) (- 65 mana.)"
					Old
						rank="A"
						pre="Hastega"
						atype="save"
						savetype="Will"
						basecheck=15
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 12
						attack_roll_dice_sides = 10
						damsource="int"
						mcost=85
						desc="The user accelerates time around a target, causing it to rapidly age. Out of battle, This can be used on objects, plants, and other inanimant objects in order to decay them forcibly, to a total of 6 years in the future. As a combat attack, this rapidly decays the cells of the target, forcing a Will saving throw - and dealing 12d10+INT true damage on a failure, or half as much on a success. Against inanimate objects, and robots - this damage is doubled. (-85 mana.)"
				Greens
					icon='Icons/Perk/Barrier.png'
					Reflect
						rank="C"
						desc="As a reaction, erect a shield dome around yourself. The shield is tuned to magic and can bounce back spells fired at the user. This only works on single target attacks and cannot block AoE effects. Blocks one single target attack of B rank or lower ; directing it back towards the caster. (-30 mana.)"
					Veil
						rank="C"
						desc="Conjure a magical field around a target distorting the view from the outside and making it harder for the target to be seen and hit with attacks, whilst also protecting them from negative afflictions. Grants the 'Veil' status effect. (-20 Mana.)"
					Mute
						icon='Icons/Perk/Dispel.png'
						rank="C"
						desc="The user creates a field in which sound cannot be created or heard. The field is a 5x5 AoE around the user. Any hostile creature in the field suffers 'Silence' as long as they are within it. They are unable to make or hear noises, granting unseen targets advantage on stealth checks. The user must use their bonus action each round to keep this field active. (-10 mana per turn to sustain.)"
					Veilga
						rank="B"
						pre="Veil"
						desc="The user bends space around an area, creating distortions. All friendly targets within a 10 tile area around the user gain 'Veil' for as long as the field is sustained. In order to sustain this spell the time mage must use their bonus action each turn. (-20 mana per turn to sustain.)"
				Whites
					icon='Icons/Perk/Cure.png'
					Reraise
						greenmagic=1
						statuseffect="Reraise"
						rank="S"
						desc="The user forms a copy of a target in time, allowing them to be revived automatically upon dying. Grants the 'reraise' status effect to the target. This also applies 'Reraise sickness' - which prevents it from being applied to the same target a second time until the encounter has concluded. (-100 mana.)"
					Return
						rank="S"
						desc="The user resets time turning every chosen participant's health, and status effects back to the beginning of an encounter. Can only be used once for day. Allows the user to start a battle over retaining IC knowledge gained during the fight. Only affects a local space, and only turns back time for those involved in the encounter. Doing so in combat inflicts a permanent debuff on the user due to the immense magical energy require to perform such a feat. For the rest of the battle, their maximum MP is equal to 50% of its normal value. Out of Battle Effects: Can be used to turn back time in a localized area. Can turn back time up to an hour only affected roughly the area in view. Can be manipulated to allow exceptions I.E. allowing party members to be excluded from the effect. Out of battle effect can be used multiple times a day. (-100% Mana.)"
				Comets
					element="Comet"
					icon='Icons/Perk/Comet.png'
					Comet
						rank="C"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 6
						attack_roll_dice_sides = 6
						range=" 3x3 AoE within 10 tiles."
						atype="save"
						savetype="Reflex"
						basecheck=10
						mcost=35
						desc="The user summons small comets from outer space to pelt an area, with fierce indiscrimination. (Damage: 6d6+INT | 10 Tile range, targets 3x3 AoE. Prompts a reflex saving throw (DC 10+INT+Rank bonus) - dealing full damage on a failure, or half on a success. -35 mana.)"
					Meteor
						rank="A"
						pre="Comet"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 2
						attack_roll_dice_sides = 12
						range="7 tile range."
						mcost=20
						typing="magical"
						desc="The user calls meteors from the heavens holding them in place with magic over their head before aiming and firing them wherever they choose. Make a number of Meteor attack rolls on any target within range, equal to your INT modifier. Each Meteor attack roll costs 20 MP. (Damage: 2d12+INT Force damage | 7 tile range, Magical attack roll. -20 MP.) This caps at two Meteors per creature, per round."
				Gravitys
					icon='Icons/Perk/Gravity.png'
					Float
						rank="D"
						desc="Cast a shimmering beam of light that bestows float upn yourself or a party member, with a duration for 4 turns. Out of Battle Effects: Can be cast on an object in order to lift it off the ground. Can only be used on an object up to 1 ton in weight. (10 tile range, -15 Mana.)"
					Gravity
						rank="D"
						desc="Create a centralized gravity field around a target in range. The field follows the target for as long as it is sustained; while under the effects of Gravity, the creature is afflicted with 'Heavy'. They also suffer 1d12+3 force damage per turn. Pierces 5 points of DR.(-8 mana per turn to sustain.) This can only be applied to one creature at a time."
						mcost=8
						range="1x1 in view."
					Gravara
						rank="C"
						pre="Gravity"
						desc="The user creates a 3x3 area of high gravitational force. While under the effects of Gravity, a creature is afflicted with Heavy, and take 2d10+5 force damage when starting a turn in the field. The field's epicenter can be moved up to 3 tiles as a bonus action. Pierces 8 points of DR. "
						mcost=15
						range="3x3 in view."
					Graviga
						rank="B"
						pre="Gravara"
						desc="Create a large area where gravity is heavily increased, and crush hostile creatures under its weight. While under the effects of Gravity, a creature is afflicted with Heavy, Hostile targets in the area are considered over encumbered no matter what their carry weight is. Targets also take 2d12+8 force damage if starting their turn in the field. Pierces 10 points of DR. The user can use their bonus action to move the field's epicenter by 5 tiles. The radius of this field is a 5x5 AoE. Graviga can be placed anywhere within 15 tiles of the caster. (-20 mana per turn to sustain.)"
						mcost=20
						range="5x5 in view."
					Gravija
						rank="A"
						pre="Graviga"
						desc="Create a massive area where gravity is heavily increased, and crush hostile creatures under its weight. While under the effects of Gravity, a creature is afflicted with Heavy, Hostile targets in the area are considered over encumbered no matter what their carry weight is. Targets take 3d10+10 force damage if starting their turn in the field. Pierces 15 points of DR. The user can use their bonus action to move the field's epicenter by 5 tiles.  The radius of this field is a 7x7 AoE. Gravija can be placed anywhere within 15 tiles of the caster. (-30 mana per turn to sustain.)"
						mcost=30
						range="7x7 in view."







//Del Note- Monster Abilities
obj
	perk
		MonsterAbilities
			icon='Icons/Perk/MonsterAbility.png'

			RobotAbilities
				atype="standard"
				basecheck=10
				ability=1
				icon='Icons/Perk/Machinist.png'
				blu=0
				costtype="Stamina"
				element="General"

				Pounce
					rank = "D"
					name = "Pounce"
					mcost = 20
					range = "8 tile movement must end on a square next to an opponent"
					desc = "This creature moves with accelerating speed, jumping onto its target in an attempt to pin it down before using its sword to stab it. Damage: Make a Sword Attack. Effect: Prone."

				Sniper_Art_Silencing_Shot
					rank = "D"
					name = "Sniper Art: Silencing Shot"
					mcost = 20
					range = "6 tiles"
					desc = "The Striker aims its laser at the head of an enemy, the Laser sacrifices half of its damage to induce Silence. Damage: Half of Laser. Effect: Silence."

				Tail_Blade_Feral_Stance
					rank = "D"
					name = "Tail Blade (Feral Stance)"
					mcost = 15
					range = "Melee"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 4
					damsource="dex"
					desc = "Flicks their mechanical tail at an enemy dealing 2d4 + Dex Slashing Damage as it pierces or slashes the opponent."

				Kriegsmesser_Krieger_Stance
					rank = "C"
					name = "Kriegsmesser (Krieger Stance)"
					mcost = 20
					range = "Melee"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 10
					damsource="str"
					desc = "The Blitzer’s Tail Blade becomes a heavier, deadlier weapon, dealing 2d10+STR Slashing Damage."

				Heilige_Nacht_Krieger_Stance
					rank = "C"
					name = "Heilige Nacht (Krieger Stance)"
					mcost = 30
					range = "Owner/Self"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 10
					damsource="str"
					desc = "The Blitzer gains the ability to be wielded by its owner, becoming a weapon that deals 2d10+STR Magical Slashing Damage (Bypassing Physical Resistance)"
			BLU
				atype="standard"
				basecheck=10
				ability=1
				icon='Icons/Perk/Blue Mage.png'
				blu=1
				costtype="Mana"
				typing="magical"
				level=3
				element="General"

				Ruby_Light
					rank = "D"
					name = "Ruby Light"
					mcost = 20
					range = "4 tile range"
					desc = "Carbuncle casts Reflect on an individual. Range 4 tiles, costs 20 mp, Reflect's effect- The creature erects a barrier around itself and one ally that is capable of reflecting one attack, melee or magic back at the attacker, then dissipating. Counts as a positive status effect."

				Diamond_Light
					rank = "D"
					name = "Diamond Light"
					mcost = 20
					range = "4 tile range"
					desc = "Carbuncle casts Vanish on an individual. Range 4 tiles, costs 20 mp, Vanish's effect - The creature becomes invisible to sight. While invisible all creatures cannot sense the creature using sight giving them advantage to attacks against anyone who cannot sense them. Vanish lasts 3 rounds or until the creature attacks someone."

				Emerald_Light
					rank = "D"
					name = "Emerald Light"
					mcost = 20
					range = "4 tile range"
					desc = "Carbuncle casts Haste on an individual. Range 4 tiles, costs 20 mp, Hastes effect - Grants one additional basic attack per turn, as well as bonus of +2 to PAB and MAB, and 1 additional Tile Movement. 2 turn duration. If used on a Slowed individual, simply cancels out Slow."

				Moonstone_Light
					rank = "D"
					name = "Moonstone Light"
					mcost = 20
					range = "4 tile range"
					desc = "Carbuncle casts Shell on an individual. Range 4 tiles, costs 20 mp, Shell's effect - Similar to protect a magical shell is placed around the affected sapping the power of magic causing it to deal less damage. + 8 reduction against magical attacks. Lasts for four turns."

				ShrapnelSeed
					element="Nature"
					rank="D"
					name="Shrapnel Seed"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 8
					damsource="wis"
					range=" 7 tile range."
					mcost= 10
					desc="The creature fires a hard seed that explodes into shrapnel when it hits. (Damage: 2d8+WIS slashing | 7 Tile range, Magical Attack Roll, inflicts 'Bleed' on hit.  -10 Mana.) (BLU)"

				PhotosyntheticWave
					name="Photosynthetic Wave"
					rank="C"
					heal=1
					desc="This ability can only be used amidst sunlight. The creature releases photosynthetic waves which upon touching a target creature, heals it for exactly 55 HP. (7 tile range, 30 Mana.) (BLU)"
					mcost = 30

				Chestnut
					name = "Chestnut"
					rank = "C"
					desc = "Targets 1, Range 6 tiles, Effect- Deals damage equal to the amount of health removed from this monster. Caps at 75 damage Costs 40MP"
					mcost = 40

				Shriek
					name = "Shriek"
					rank = "D"
					desc = "Targets 1, Range 6 tiles, Effect- DC 14 fortitude save or silenced. Costs 30MP"
					range = "6 tile range"
					mcost = 30

				GeezardClaw
					element="Physical"
					rank="D"
					name="Geezard Claw"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 12
					atype="weapon"
					mcost=10
					range=" melee"
					damsource="wis"
					desc=" The creature raises its arm into the air, and generates a blade of Mana from its claws which it slashes down upon a target with. This inflicts Weakness on the target if it hits. (Damage: Weapon Damage + 2d12+WIS Slashing | Weapon Attack Roll, inflicts Weakness on hit, -10 Mana.) (BLU)"

				Goblin_Strike
					rank = "D"
					name = "Goblin Strike"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 4
					atype="weapon"
					mcost = 10
					range = "melee"
					damsource = "wis"
					desc = "Targets 1, Range Melee, Effect- Roll Magic Attack on hit deal 2D4+WIS, Then roll a Physical Attack With a bonus +1 to hit, on Hit deal Weapon Damage. Costs 10MP"

				Goblin_Hammer
					rank = "C"
					name = "Goblin Hammer"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 10
					atype = "weapon"
					mcost = "0-100"
					range = "melee"
					damsource = "str"
					desc = "Targets 1, Range Melee, Effect- Before rolling stat a number between 0-100 that is the mana cost of this ability for the turn. Make a Physical attack roll, On hit deal 2d10+STR damage to the opponent and drain their MP the same amount as the cost for the spell. Costs Between 0-100MP"

				Crude_Potion
					rank = "D"
					name = "Crude Potion"
					mcost = 10
					range = "self"
					desc = "Targets Self, Range Self, Effect. Drink a poorly crafted potion that restores 25HP. Costs 10MP"

				Steal
					rank = "C"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 12
					damsource = "str"
					atype = "weapon"
					mcost = 15
					range = "melee"
					desc = "Targets 1, Range Melee, Effect Make an attack roll on hit deal 2d12+STR, roll 1d100 then steal that much gold from the opponent. If flanking then steal 100 gold on hit. Costs 15MP"

				PoisonPowder
					element="Dark"
					rank="D"
					name="Poison Powder"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 2
					desc="The creature collects a magical powder on its wings. When enough powder has been collected it flaps its wing spreading the powder throughout the area. Even the smallest breath can inflict poison. Prompts a flat Fortitude saving throw (DC 15), inflicting poison on failure. (10 tile range, 3x3 AoE, - 10 Mana.) (BLU)"
					mcost = 10
					range = "10 tile range, 3x3 squares on impact."

				Monster_Gaze
					rank = "D"
					name = "Monster Gaze"
					mcost = 15
					range = "7 tile range"
					desc = "Targets 1, Range 7 Tiles, Effect- Target makes a Fortitude save. On failure they become paralyzed."

				Sticky_Webs
					rank = "C"
					name = "Sticky Webs"
					mcost = 15
					range = "6 tile movement 3x3 area on impact"
					desc = "Targets anyone in a 3x3, Range 6 tiles. Effect- Spits a web on the ground that causes slow for anyone who is inside it. Costs 15MP"

				Spider_Bite
					rank = "C"
					mcost = 15
					range = "melee"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 6
					damsource = "str"
					desc = "This creature bites the opponent for 2d6+str if it hits the opponent makes a fortitude save (DC 15) or becomes poisoned."

				Howl
					rank = "C"
					mcost = 30
					range = "3x3 tile range centered on caster."
					desc = "Targets anyone in a 3x3 square centered on the caster. Effect- All enemies in the range make a DC 14 Fortitude save or become paralyzed. Cost 30MP."

				ChocoKick
					rank = "C"
					mcost = 30
					range = "melee"
					desc = "Targets one enemy in melee range, attacking them twice with both talons. Effect- Multi-Attack x2 Physical Attack deals 2d12+Str each attack. Costs 30SP"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 12
					damsource = "str"

				Ultra_Waves
					rank = "C"
					name = "Ultra Waves"
					mcost = 30
					range = "4 tile line."
					desc = "Targets anyone in a 4-tile Line, dealing 3d12+WIS Damage, and causes a 4-tile Knockback. Costs 30MP."
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 3
					attack_roll_dice_sides = 12
					damsource = "wis"

				Paralyzing_Sting
					rank = "C"
					name = "Paralyzing Sting"
					mcost = 30
					range = "6 tiles."
					desc = "Targets 1 enemy within 6 tile range, dealing 2d12+WIS damage. On hit, the target makes a Fortitude save with DC 16 or becomes paralyzed. Costs 30MP"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 12
					damsource = "wis"

				Gelatinous_Lake
					rank = "C"
					name = "Gelatinous Lake"
					mcost = 30
					range = "5x5 field that follows the Flan."
					desc = "Affects anyone within a 5x5 field around the Flan, as long as they aren't Flans themselves (or the caster) will have their tile speed lowered by 2. Costs 30MP, 5MP Sustain."

				Goo_Stream
					rank = "C"
					name = "Goo Stream"
					mcost = 30
					range = "6 tile range."
					desc = "Targets 1 creature within a 6 tile range, dealing 2d8+WIS damage. On hit, also reduces target's AC by 2 for 3 rounds. Costs 30MP."
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 8
					damsource = "wis"

				Blinder_Beak
					rank = "C"
					name = "Blinder Beak"
					mcost = 0
					range = "Melee"
					desc = "Targets 1 creature in melee range, dealing 2d8+STR damage to them. The target then makes a Fortitude save of (DC14) or gains the Blind Status."
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 8
					damsource = "str"

				Charge
					rank = "C"
					mcost = 30
					range = "Special - Until it hits a wall or expended 2x movement speed."
					desc = "The creature charges in a straight line until it hits a wall or moves 2x its movement speed. Anything hit by the charge takes 3d10+STR Damage and is knocked back 3 tiles. They also make a DC18 Reflex Save or fall prone. If the creature hits a wall, the Rock Fall Lair Effect activates. Cost 30SP."
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 3
					attack_roll_dice_sides = 10
					damsource = "str"

				Horn_Skewer
					rank = "C"
					name = "Horn Skewer"
					mcost = 20
					range = "Melee"
					desc = "The monster attacks with its massive horns, dealing 2d12+STR Damage on hit and causing bleed. Costs 20SP."
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 12
					damsource = "str"

				Build_Up_Steam
					rank = "C"
					name = "Build-up Steam"
					mcost = 20
					range = "Self"
					desc = "The monster stomps around in anger, increasing its PDB by 5 until the end of battle. (Max 15) Costs 20SP."

				GiganToad_Tongue_Restrict
					rank = "B"
					name = "Tongue Restrict"
					mcost = 0
					range = "6 tile range."
					desc = "When attacking, the opponent makes a Fortitude Save of (DC18). If they fail, they become paralyzed and considered grabbed by the toad."

				GiganToad_Consume
					rank = "B"
					name = "Consume"
					mcost = 0
					range = "Special - See Description."
					desc = "If an opponent is grabbed by this creature, tongue or otherwise, they can either drag the creature 2 squares for every 2 points of strength they have over the opponent (Minimum 2 squares). If they end or start their turn in a square next to the toad, they will be consumed by the toad, taking 4d12 Acid damage each turn until the toad is killed and they are rescued. While inside the toad, any attack the victim makes comes at the cost of 2d12 Acid damage. The victim can make a fortitude check DC12 to climb out of the Toad once it has been slain."

				Whispering_Wind
					rank = "D"
					name = "Whispering Wind"
					mcost = 30
					range = "5x5 area centered on caster."
					desc = "Non-Elemental Magic damage that surrounds the caster and hits enemies within a 5x5 area centered on the caster. The damage is 2d4+Int. After the attack subsides, a gentle wind blows, casting cure on all allies within a 5x5 area, centered on the caster."
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 4
					damsource = "int"

				Hellfire
					rank = "B"
					mcost = 50
					range = "7 squares."
					desc = "Ifrit can amass a large amount of fire to unleash on a single target. When casting this spell, it takes 1 turn to charge up unless Ifrit has been hit by fire-based attacks, or he's standing in fire. The attack deals 4d12+WIS damage. Costs 50MP."
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 4
					attack_roll_dice_sides = 12
					damsource = "wis"

				Diamond_Dust
					rank = "B"
					name = "Diamond Dust"
					mcost = 50
					range = "7x7 area centered on caster."
					desc = "Shiva can expel the ice storm around her to hit everyone in a 7x7 radius focused on herself. Everyone in that radius must make a Fortitude save (DC16) or take 3d8+WIS damage and be slowed. Half Damage on a save and no slow. If the targets are wet they become paralyzed as well. Costs 50MP. Lasts 3 turns."
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 3
					attack_roll_dice_sides = 8
					damsource = "wis"

				Judgement_Bolt
					rank = "B"
					name = "Judgement Bolt"
					mcost = 50
					range = "5x5 area from within 6 squares of user."
					desc = "Ramuh summons a thunder storm that encompasses a 5x5 area of his choice - within 6 squares of himself. Each creature starting their turn in that storm takes 3 bolts of Lightning on a failed reflex save (DC 16) for each. Each bolt does 2d6+WIS Damage. Costs 50MP. Lasts 3 turns."

				Glare
					rank = "C"
					name = "Glare"
					mcost = 30
					range = "6 tiles, in line of sight."
					desc = "As long as there's a line of sight, and both sides are looking at each other, even if just a glimpse, the target has to succeed a Will Save of (DC16) or be paralyzed."

				Stone_Throw
					rank = "C"
					name = "Stone Throw"
					mcost = 20
					range = "8 tile range."
					desc = "This creature can throw a rock or boulder at an enemy with great accuracy, dealing 2d10+STR damage and a 10ft knockback on impact."
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 10
					damsource = "str"

				Baby_Charge
					rank = "D"
					name = "Baby Charge"
					mcost = 20
					range = "8 tile range."
					desc = "The creature charges in a straight line until it hits a wall or opponent. If it its an opponent that opponent takes 1d12 + Str +PDB and makes a DC 16 Reflex safe or be knocked back 3 tiles. If its a wall this creature takes damage for every square traveled as if hit with knockback into a wall."
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 1
					attack_roll_dice_sides = 12
					damsource = "str"

//Old Abilites

				Acid
					element="Dark"
					rank="D"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 8
					damsource="wis"
					mcost=10
					range=" 7 tile range."
					desc="The creature releases a shot of Acid that degrades upon a creature, eating away at it on hit. (Damage: 2d8+WIS Bio damage | 7 Tile range, Magical attack Roll, -10 Mana.) (BLU)"
				MagicHammer
					rank="D"
					name="Magic Hammer"
					damsource="str"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 10
					range="Melee"
					mcost="Variable"
					desc="The creature creates a huge hammer made of Magic, which when slamming into a target, drains them of their MP. This Hammer has a variable Mana cost (maximum of 100) - and on hit, depletes the target creature of Mana equal to the Mana spent to cast this spell. (Damage: 2d10+STR Force damage | Melee attack roll, Mana cost variable.) (BLU)"
				MonsterFlame
					element="Fire"
					rank="D"
					name="Monster Flame"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 8
					damsource="wis"
					range=" 7 tile range."
					mcost=10
					desc="The creature generates a small sphere of flame, and lobs it at a target creature, threatening to singe them. (Damage: 2d8+WIS Fire damage | 7 tile range, Magical attack roll. -10 Mana.) (BLU)"
				GoblinStrike
					element="Monk"
					rank="C"
					name="Goblin Strike"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 4
					damsource="wis"
					range=" Melee"
					addhit=1
					mcost=10
					desc="The creature coats its hand or weapon in magic delivering a punch that mixes physical and magic. Roll a Weapon Attack roll immediately after Goblin Strike. Blue Magic ability. (Damage: 2d4+WIS Force | Goblin Strike roll (+1 to hit) + Weapon Attack roll, -10 MP.) (BLU)"
				SilverFang
					rank="C"
					name="Silver Fang"
					damsource="wis"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 12
					range=" Melee"
					mcost=15
					desc="The creature creates a flaring aura of energy around the front of its body and charges forward at an opponent. If the Loboscreature hits its mark, the target is knocked back by a blast of energy. (Damage: 2d12+WIS Force | Melee Attack Roll, 3 Tile Knockback on hit. -15 Mana.) (BLU)"
				MuClaw
					element="Physical"
					rank="C"
					name="Mu Claw"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 12
					range=" Melee"
					damsource="wis"
					mcost=15
					desc="The creature lashes out with its claw, to deal damage to an opponent ; also stealing their vitality, and restoring themselves for the amount of damage inflicted. (Damage: 2d12+WIS | Melee Attack Roll, restores HP to the user equal to damage dealt. -15 Mana.) (BLU)"
				Stinger
					element="Nature"
					rank="C"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 10
					damsource="dex"
					range=" 8 tile range."
					mcost=15
					desc="The creature fires a magically imbued, spike shaped projectile made of Bio energy at an opponent. (Damage: 2d10+DEX Bio | 8 tile range, Magical Attack Roll, inflicts Poison on hit. -15 Mana.) (BLU)"
				BombosFire
					element="Fire"
					rank="C"
					name="Bombos Fire"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 12
					damsource="wis"
					range=" 6 tiles."
					mcost=15
					desc="The creature lobs a blast of flame that explodes on contact with a surface. (Damage: 2d12+WIS Fire Damage | Magic Attack Roll, inflicts Burn on hit. - 15 Mana.) (BLU)"
				GelatinousLake
					name="Gleatinous Lake"
					rank="C"
					element="Bio"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_exact = 0
					desc="The creature creates an area of goop-like substance, slowing anything within it that isn’t a Flan. While in the substance, creatures and players’ tile movement is reduced by two tiers. This ‘lake’ has a duration of five turns. (-20 Mana. 5x5 AoE.) (BLU)"
				WaterGun
					element="Water"
					name="Water Gun"
					rank="C"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 12
					range=" 6 tiles."
					damsource="wis"
					mcost=15
					desc="The creature fires a bolt of water from it’s mouth, which explodes on contact and inflicts 'Wet'. (Damage: 2d12+WIS Water | Magical Attack Roll, Inflicts Wet on hit. -15 Mana.) (BLU)"
				MesmaBlade
					element="General"
					name="Mesma Blade"
					rank="C"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 20
					addhit=2
					range=" 8 tile."
					damsource="wis"
					mcost=15
					desc="The creature lobs a magical crescent shaped blade from its head-blade or any other blade, that can inflict Slow on a target if it damages them. (Damage: 2d20+WIS | Magical Attack Roll, +2 to hit, inflicts Slow on hit, -15 Mana.) (BLU)"
				ShellDefense
					name="Shell Defense"
					rank="C"
					desc="The creature coats its own or an ally’s body in a coat of magic giving it a similar effect to protect, granting 10 Physical Damage Reduction, which lasts for 3 turns. (8 tile range, -25 Mana.) (BLU)"
				Reflect
					rank="C"
					desc="The creature erects a barrier around itself and one ally that is capable of reflecting one attack, melee or magic back at the attacker, then dissipating. Counts as a positive status effect. (-30 Mana) (BLU)"
				MagicTongue
					element="Physical"
					name="Magic Tongue"
					rank="C"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 3
					attack_roll_dice_sides = 12
					range=" 8 tile range."
					damsource="str"
					mcost=20
					desc="The creature creates a tongue or extends their natural tongue using magical energy, lashing forward to strike and then pull an opponent towards it after firing it from its mouth. (Damage: 3d12+STR Bio damage | 8 tile range, Magical attack roll, draws opponent to you on hit.) (BLU)"
				MythriteGuard
					name="Mythrite Guard"
					rank="C"
					desc=" The creature creates a magical barrier with the sheen of Mythril around itself and an ally, granting Protect. (8 tile range, -25 Mana.) (BLU)"
				Ram
					element="Physical"
					rank="C"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 3
					attack_roll_dice_sides = 18
					range=" Melee"
					mcost=20
					damsource="str"
					desc="The creature rams its magically shrouded head into an opponent, inflicting the Stun status on them if it deals over 10 damage to the target after calculations. (Damage: 3d6+STR Force damage | Melee attack roll, -20 Mana.) (BLU)"
				VineWall
					name="Vine Wall"
					rank="C"
					desc="The creature creates a wall of sturdy vines to protect itself and allies from harm. This can be used as a standard action, or a reaction. Any damage that exceeds the wall's HP continues forward as normal, when the wall is reduced to 0. (50 HP wall, 5 tiles wide. -35 Mana.) (BLU)"
				MatraMagic
					element="Robot"
					name="Matra Magic"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 12
					range=" 7 tile range."
					mcost=60
					damsource="wis"
					rank="C"
					desc="The creature generates metallic missiles made of magic, which fire off at a target in sequence. A total of four are created, and they explode on contact - dealing magical Force damage on explosion. Each missile prompts its own Missile Magic attack roll. (Damage: 2d12+WIS | 7 Tile range, Magical attack roll. -60 Mana.) (BLU)"
				GargoyleBreath
					element="Dark"
					name="Gargoyle Breath"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 4
					attack_roll_dice_sides = 10
					damsource="wis"
					range=" 5 tile cone."
					mcost=50
					desc="The creature releases a cloud of acidic gas that inflicts Poison on those who are damaged by it. (Damage: 4d10+WIS | Magical Attack roll, 5 tile cone, inflicts Poison on hit. -50 Mana.) (BLU)"
				ToadKata
					element="Monk"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 3
					attack_roll_dice_sides = 10
					monkability=1
					name="Toad Kata"
					damsource="str"
					range=" Melee"
					mcost=50
					desc="The creature throws forward a Toad-Style Karate Punch infused with natural energy that inflicts Toad on a target if it lands. (Damage: 3d10+STR Force damage | Melee Attack Roll, -50 Mana.) (BLU, MONK)"
				HydroCannon
					element="Water"
					name="Hydro Cannon"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 5
					attack_roll_dice_sides = 12
					damsource="con"
					range=" 3x3 sized projectile, 7 tile range."
					mcost=50
					desc="The creature condenses water in its throat, and then releases it as a burst of powerful water in the form of a sphere that explodes on contact. (Damage: 5d12+CON Water damage | 3x3 Sized projectile, Magical attack roll, inflicts Wet on hit. -50 Mana.) (BLU)"
				Flamethrower
					element="Fire"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 6
					attack_roll_dice_sides = 12
					damsource="cha"
					mcost=55
					desc="The creature emits a stream of flames from its mouth that singes a target, and any targets in a straight line in front of it. (Damage: 6d12+CHA Fire damage | 8 tile line, Magical attack roll, -55 Mana.) (BLU)"
				MightyGuard
					name="Mighty Guard"
					rank="B"
					desc="The creature holds its hand out, and uses its magic to form a dual layered shell around them. This barrier consists of one layer of protect, and another of shell granting a great resistance. This is a fairly draining move. (Grants Shell and Protect to the user for 3 rounds, - 80 Mana.) (BLU)"
				Vampire
					element="Drain"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 20
					range=" 10 tile range."
					mcost=50
					damsource="wis"
					desc="The creature draws health and energy out of an opponent through a magical stream. (Damage: 2d20+WIS Dark damage | 10 tile range, Magical Attack Roll, restores HP equal to damage dealt. -50 Mana) (BLU)"
				Tusk
					element="Physical"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 4
					attack_roll_dice_sides = 10
					atype="weapon"
					range=" Melee"
					damsource="wis"
					mcost=50
					desc="The creature surrounds its tusks or weapon in a massive sheen of Mana, before stabbing forward - sending a piercing sheen of Mana forth to strike an opponent directly. (Damage: 4d10+WIS | Melee Attack Roll, ignores up to 15 points of damage reduction, -50 Mana.) (BLU)"
				SilverWheel
					element="Metal"
					name="Silver Wheel"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 6
					attack_roll_dice_sides = 12
					damsource="wis"
					addhit=2
					range=" 10 tile range."
					mcost=85
					desc="The creature fires out a silver saw-blade of energy, having it travel in an arc and slicing at people as it travels in a circle. (Damage: 6d12+WIS Force damage | 10 tile range, Magical Attack Roll, +2 to hit, Can attack 3 enemies who are within 5 tiles of each other, inflicts 'Bleed' on hit. - 85 Mana.) (BLU)"
				HundredNeedles
					rank="B"
					element="General"
					name="100 Needles"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_exact = 75
					desc="The creature releases a large and powerful spread of exactly 100 needles made of Mana from its body. (10x10 AoE, exactly 75 true damage, ignoring reductions. Auto-hit. -100 Mana.) (BLU)"
				WhiteWind
					heal=1
					name="White Wind"
					rank="B"
					desc="The creature casts a holy wind that can heal itself and up to two allies for exactly 120 HP. (10 tile range, -80 Mana.) (BLU)"
				Plainscracker
					element="Earth"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 6
					attack_roll_dice_sides = 12
					range=" 7x7 AoE within view."
					atype="save"
					savetype="Fortitude"
					basecheck=15
					damsource="str"
					mcost=60
					desc="The creature focuses Earthen energy into its body, and then stomps its foot. A wave of Earth explodes outward, inflicting Stun on those it damages. (Damage: 6d12+WIS | 7x7 AoE, prompts a Fortitude saving throw, DC (15+STR+Rankbonus), dealing full damage and inflicting stun on a failure, or dealing half damage on a success.-60 Mana.) (BLU)"
				GrenadoFire
					element="Fire"
					name="Grenado Fire"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 7
					attack_roll_dice_sides = 10
					range=" 7 tile range."
					damsource="wis"
					range=" 3x3 sized projectile, 8 tile range."
					mcost=65
					desc="The creature lobs a blast of flame that explodes on contact with a surface. (Damage: 7d10+WIS | 7 tile range, Magical Attack Roll, 3x3 sized projectile, inflicts Burn on hit, - 65 MP.) (BLU)"
				Flash
					rank="B"
					desc="The creature channels a large amount of energy to release a burst of energy which inflicts Blind on anyone unfortunate enough to witness it. (7x7 AoE, which prompts a Will saving throw, DC 18, inflicting Blind on a failure, -40 Mana.) (BLU)"
				AngelWhisper
					rank="B"
					name="Angel's Whisper"
					desc="The creature releases an angelic hymn into the mind of a fallen creature, bringing them back from the unconscious state with 50 HP. (7 Tile range, -80 Mana.) (BLU)"
				Night
					element="Dark"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 10
					damsource="int"
					range=" 7x7 AoE"
					mcost=70
					desc="The creature releases a radial wave of energy that resembles the night sky in appearance. It inflicts 'Sleep' on any creature that it successfully hits. Sleep is applied after the damage takes place. (Damage: 2d10+INT Force damage | 7x7 AoE, magical attack roll, inflicts Sleep on hit.) (BLU)"
				DispelFoe
					element="Holy"
					name="Dispel Foe"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 5
					attack_roll_dice_sides = 12
					damsource="cha"
					range=" 8 tile range."
					mcost=60
					desc="The creature creates a sphere of energy that seeks to entrap a target, and then explode - damaging and also inflicting 'Silence' upon them. (Damage: 5d12+CHA Force damage | 8 Tile range, Magical attack roll, inflicts 'Silence' on hit. -60 Mana.) (BLU)"
				Gust
					element="Wind"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 7
					attack_roll_dice_sides = 10
					damsource="wis"
					range=" 3x3 sized projectile, 10 tile range."
					mcost=70
					desc=" The creature sweeps its wings forward, sending a massive wave of air forward that can knock opponents back. (Damage: 7d10+WIS Wind damage | 3x3 Sized projectile, 10 tile range, 5 Tile Knockback, -70 Mana.) (BLU)"
				SerpentBreath
					element="Dark"
					rank="B"
					name="Serpent Breath"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 5
					attack_roll_dice_sides = 10
					damsource="int"
					range=" 5 tile cone."
					atype="save"
					savetype="Fortitude"
					basecheck=16
					desc="The creature releases a breath charged with electricity that inflicts the Paralyze status effect on those fully damaged by it. (Damage: 5d10+INT Force damage | 5 tile cone, prompts a Fortitude saving throw ; inflicting Paralyze and dealing full damage on a failure, or dealing half damage on a success.) (BLU)"
				PhotonRay
					element="Holy"
					rank="B"
					name="Photon Ray"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 10
					damsource="wis"
					range=" 8 tile range."
					mcost=100
					desc="The creature releases five spheres of light energy which attack and explode to deal damage individually. (Damage: 2d10+WIS Force damage | 8 Tile range, Magical attack roll, -100 Mana.) (BLU)"
				DragoFlare
					element="Flare"
					rank="B"
					name="Drago Flare"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 6
					attack_roll_dice_sides = 12
					damsource="wis"
					range="3 tiles wide, 7 tile piercing line."
					mcost=60
					desc="The creature opens its mouth and releases a laser like flare of energy from its mouth, dealing massive damage. (Damage: 6d12+WIS Force damage | 3 tiles wide, 7 tile piercing line, -60 Mana.) (BLU)"
				LimitGlove
					element="Monk"
					rank="B"
					name="Limit Glove"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 6
					attack_roll_dice_sides = 12
					mcost=60
					range="Melee"
					damsource="str"
					desc=" The creature manifests a massive fist construct made of pure Mana around its hand, and then tosses a punch at a foe. If the creature casting this ability has 50 or less current HP, this spell deals an additional 50 damage on hit. (Damage: 6d12+STR Force damage | Melee attack roll, -60 Mana.) (BLU)"
				ForceField
					name="Force Field"
					rank="B"
					desc=" The creature generates a magical forcefield around its entire party, granting them Barfire, Barfrost, Barthunder, and Barwind. This requires considerable Mana to cost however, and is extremely cost inefficient. (-110 Mana.) (BLU)"
				HomingLaser
					element="Laser"
					name="Homing Laser"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 4
					attack_roll_dice_sides = 10
					damsource="int"
					range="All hostile creatures in view."
					mcost=80
					desc="The creature generates orbs of magical energy around their form, charging it intensively - before then releasing it in spurts of laser blasts. This spell targets all creatures on the opposing party, making two separate attack rolls, with each of the two applying to all creatures. (Damage: 4d10+INT Force damage | Targets all enemy creatures in view, Magical attack roll, -80 Mana.) (BLU)"
				Hastebreak
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 5
					attack_roll_dice_sides = 12
					damsource="wis"
					mcost=65
					range=" Melee"
					desc="The creature coats their fist in a compressed aura made of gravity magic, and then slams it into a target creature. If the creature has the 'Haste' status effect, this removes Haste and applies 'Slow' in its place. (Damage: 5d12+WIS Force damage | Melee attack roll, -65 Mana.) (BLU)"
				WarDance
					name="War Dance"
					rank="B"
					desc="The creature performs an ancient War Dance, infusing the spirit of battle to all of its party members. This when used grants a boost to all current party members, of +2 to hit and 10 additional damage on all attacks, which lasts for 4 rounds. (-100 Mana.) (BLU)"
				VarunaArrow
					element="General"
					name="Varuna Arrow"
					rank="A"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 9
					attack_roll_dice_sides = 12
					damsource="str"
					range=" 8 tile range."
					mcost=100
					desc="The creature creates an arrow of magical energy between its two hands, which inflicts Poison, and Break upon those damaged by it. (Damage: 9d12+STR Bio damage | 8 Tile range, Magical attack roll, inflicts 'Poison' and 'Break' on hit. -100 Mana.) (BLU)"
				GreatCleave
					element="Flare"
					name="Great Cleave"
					rank="A"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 6
					attack_roll_dice_sides = 10
					damsource="str"
					range=" 7 tile range."
					mcost=100
					desc="The creature imbues its blade with a glow of bright mana. It then slashes, releasing three separate blades of energy to separate targets, which each must serve as their own attack roll. (Damage: 6d10+STR Force damage | 7 tile range, Magical attack roll, -100 Mana. ) (BLU)"
				ShoopuffCannon
					element="Water"
					name="Shoopuff Cannon"
					rank="A"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 9
					attack_roll_dice_sides = 12
					damsource="con"
					range=" 8 tile line."
					mcost=100
					desc="The creature draws a large degree of water into its gut, and then releases it in a massive burst similar to Hydro Cannon, but far more draining - also targeting anything in a line of the stream's trajectory. (Damage: 9d12+CON Water damage | 8 tile line, Magic attack roll, inflicts Wet on hit. -100 Mana.) (BLU)"
				OilBullet
					element="Bio"
					name="Oil Bullet"
					rank="A"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 7
					attack_roll_dice_sides = 10
					damsource="str"
					range=" 3x3 sized projectile, 8 tile range."
					mcost=80
					desc="The creature spews a burst of compressed Oil at an opponent, making whatever it hits much more flammable. For 3 turns, the afflicted individual takes 2x the damage from Fire attacks if they are hit. (Damage: 7d10+STR Force damage | 8 Tile range, 3x3 Sized projectile, Magical attack roll. -80 Mana.)(BLU)"
				BioSphere
					element="Bio"
					name="Bio Sphere"
					rank="A"
					damsource="dex"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 8
					attack_roll_dice_sides = 12
					range=" 8 tile range."
					desc="The creature charges a sphere of Bio Energy between its tendrils, and fires it forward. Those hit by it are afflicted with the Poison and Paralyze status effects. (Damage: 8d12+DEX Bio damage | 8 tile range, Magical attack roll, -90 Mana.) (BLU)"
				Heave
					element="Physical"
					rank="A"
					damsource="str"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 8
					attack_roll_dice_sides = 10
					range=" Melee"
					mcost=95
					desc="The creature rushes forward and slams its horns into an opponent, forcefully launching them into the air. (Damage: 8d10+STR Force damage | Melee attack roll, on hit knocks creature 6 tiles into the air. -95 Mana.) (BLU)"
				IceSpikes
					name="Ice Spikes"
					rank="A"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_exact = 20
					desc="The creature surrounds itself with magical ice-spikes, that immediately counter-attack opponents for exact damage when it is attacked with Melee. This lasts for three turns. (20 exact damage Ice counter-attack, ignoring reductions and hitting automatically. -40 Mana.) (BLU)"
				DeathBreath
					element="Dark"
					name="Death Breath"
					rank="A"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 5
					attack_roll_dice_sides = 12
					damsource="wis"
					range=" 5 tile cone."
					atype="save"
					savetype="Reflex"
					basecheck=14
					mcost=90
					desc="The creature releases cone of cursed breath, which degrades upon those that it makes contact with - threatening to corrode away and weaken them. (Damage: 5d12+WIS Force damage | 5 Tile cone, prompts a Reflex saving throw (DC 14+WIS+Rank bonus), inflicting full damage, Slow, Weak, and Poison on a failure ; or half as much damage on a success. -90 Mana.) (BLU)"
				GriffinWind
					heal=1
					name="Griffin Wind"
					rank="A"
					desc="The creature releases a burst of holy energy that heals a target for a tremendous amount of static healing. Heals the creature for exactly 200 HP. Single target only. (-125 Mana.) (BLU)"
				Blaster
					element="Laser"
					rank="A"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 10
					attack_roll_damage_upper = 10
					damsource="cha"
					range=" 7 tile line."
					mcost=100
					desc=" The creature rears back, and charges a combination of physical and magical energy with its whiskers. It then fires it forward in the form of a powerful energy ray. If this ray hits, it inflicts the Paralyze status effect on the target. (Damage: 10d10+CHA Force damage | 7 tile line, Magic attack roll,-100 Mana.) (BLU)"
				Sporefall
					rank="A"
					desc="The creature magically creates a large collection of spores which fall from the sky to inflict Poison, Paralyze, and Stun on any those that start their turn within the cloud of spores. The spores remain in the air for 3 turns. (5x5 AoE,-100 Mana.) (BLU)"
				ClawStrike
					element="Physical"
					name="Claw Strike"
					rank="A"
					damsource="dex"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 9
					attack_roll_damage_upper = 12
					range=" Melee"
					mcost=100
					desc="The creature rushes forward, and magical claws emanate from its body to skewer an opponent at close range. (Damage: 9d12+DEX Dark damage | Melee attack roll, inflicts 'Bleed' on hit. - 100 Mana.) (BLU)"
				BadBreath
					element="All"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_exact = 55
					name="Bad Breath"
					rank="A"
					desc="The creature releases a wave of putrid breath that inflicts Posion, Silence, Paralyze, Stun, and Slow to those who fail its saving throw. Prompts a Fortitude saving throw, DC 20. Stun lasts 1 turn, all other status effects last for their standard duration. (5 tile cone, -100 Mana.) (BLU)"
				Drain
					element="Dark"
					rank="A"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 9
					attack_roll_damage_upper = 12
					damsource="cha"
					range=" 8 tile range."
					mcost=110
					desc="The creature siphons energy from its victim via an incredibly potent, dark magical stream. (Damage: 9d12+CHA Dark damage | 8 tile range, Magical attack roll, heals user for the damage dealt. -110 Mana.) (BLU)"
				CrystalLance
					element="Flare"
					name="Crystal Lance"
					rank="A"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 10
					attack_roll_damage_upper = 10
					damsource="str"
					range=" 3 tile range, Melee"
					mcost=100
					desc="The creature coats a magical lance in a dense crystal manifestation ;adding to its power and range before making an attack. (Damage: 10d10+STR Force damage | Melee attack roll, inflicts 'Weak' on hit. -100 Mana) (BLU)"
				CleansingWind
					heal=1
					cleanse=1
					name="Cleansing Wind"
					rank="A"
					level=5
					desc="The creature creates a burst of magical wind which cleanses itself and one ally of all positive and negative status effects, granting them a completely clean slate. (-50 Mana.) (BLU)"
				AdamantDrum
					element="General"
					name="Adamant Drum"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 12
					attack_roll_damage_upper = 12
					rank="S"
					range=" 14x14 AoE"
					atype="save"
					savetype="Reflex"
					damsource="str"
					mcost=140
					basecheck=20
					desc="The creature strikes the ground with massive, magically imbued force. The ground then explodes into a massive quake, throwing rubble about and inflicting Paralyze on anything unfortunate enough to be hit. (Damage: 12d12+STR Earth damage | 14x14 AoE, prompts a Reflex saving throw - inflicting Paralyze and full damage on a failure, or half as much damage on a success. -140 Mana.) (BLU)"
				MysticWing
					element="Wind"
					name="Mystic Wing"
					rank="S"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 11
					attack_roll_damage_upper = 12
					damsource="dex"
					range=" +3 tile movement, Melee."
					addhit=5
					desc="The creature creates a construct of magical energy around its wings, and uses them to propel forward at an opponent for an extremely fast and ridiculously powerful Melee attack. After using this ability, the caster gains +2 tile movement, and a bonus of +4 to hit for 4 rounds. (Damage: 11d12+DEX Force damage | +3 tile movement, +5 to hit, Melee attack roll. -140 Mana. ) (BLU)"
					mcost=140
				Gaze
					element="Laser"
					rank="S"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 11
					attack_roll_damage_upper = 12
					damsource="wis"
					range=" 6 tile line."
					mcost=130
					desc=" The creature gazes at an opponent, firing a powerful laser that can cut up the ground below, and inflicts Paralyze on opponents it hits. This also moves in a piercing, set line. (Damage: 11d12+WIS Force damage | 6 Tile line, Magical attack roll. -130 Mana.) (BLU)"
				MindBlastRamuh
					icon='Icons/Perk/Apocalypse.png'
					element="Thunder"
					name="Mind Blast"
					blu=0
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 7
					attack_roll_damage_upper = 10
					range=" 5x5 AoE around user."
					atype="save"
					savetype="Will"
					mcost=40
					basecheck=16
					damsource="int"
					desc="The creature releases a burst of psycho-kinetic electrical energy, which inflicts Stun and Paralyze on anything damaged by it. (Damage: 7d10+INT Psychic damage | 5x5 AoE, Prompts a Will saving throw - dealing full damage and inflicting Stun and Paralyze on a failure, or half damage on a success. -80 Mana.)"
				MindBlast
					element="Thunder"
					name="Mind Blast"
					rank="S"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 12
					attack_roll_damage_upper = 10
					range=" 9x9 AoE around user."
					atype="save"
					savetype="Will"
					mcost=140
					basecheck=20
					damsource="int"
					desc="The creature releases a burst of psycho-kinetic electrical energy, which inflicts Stun and Paralyze on anything damaged by it. (Damage: 12d10+INT Psychic damage | 9x9 AoE, Prompts a Will saving throw - dealing full damage and inflicting Stun and Paralyze on a failure, or half damage on a success. -140 Mana.) (BLU)"
				GreatFlamethrower
					element="Fire"
					name="Great Flamethrower"
					rank="S"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 9
					attack_roll_damage_upper = 12
					range=" 5 tile wide, 8 tile line."
					mcost=120
					damsource="wis"
					desc="The creature releases a burst of flames from its mouth which deals immense burning damage to anyone unfortunate enough to be within its massive, and explosive range of attack. (Damage: 9d12+WIS Fire damage | 5 tile wide, 8 tile line. Magical attack roll. Inflicts 'Burn' and 5 tile knockback on hit. -120 Mana.) (BLU)"
				ShadowFlare
					element="Dark"
					name="Shadow Flare"
					rank="S"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 12
					attack_roll_damage_upper = 12
					damsource="cha"
					mcost=150
					desc="The creature focuses on a target, outstretching their hand towards them. After casting the spell several shimmering orbs of darkness appear around the target quickly honing in on them and converging into a dense mass of energy trapping the target, and tearing at their body from the inside. (Damage: 12d12+CHA Dark damage | Magical attack roll, inflicts 'Burn', 'Weak', and 'Slow' on hit. -150 Mana.) (BLU)"
				Beta
					element="Fire"
					rank="S"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 12
					attack_roll_damage_upper = 12
					damsource="int"
					range=" 5 tile wide, 8 tile line."
					mcost=140
					desc="The creature releases a monstrous flamethrower which is so hot, that its flame is actually white rather than blue, yellow, or red ; which reduces most things in its path to ash. (Damage: 12d12+INT Fire damage | 5 tiles wide, 8 tile line. Magical attack roll. Inflicts 'Burn' on hit. -140 Mana.) (BLU)"
				CounterComet
					name="Counter Comet"
					rank="S"
					desc="he creature surrounds itself with an aura of energy that causes anything which attacks it to be struck automatically by a homing comet from above. This aura lasts for three turns. Comets are automatic hits, and deal flat damage. (Comet damage: 50 Force damage. -150 Mana. )(BLU)"
			Monster
				ability=1
				icon='Icons/Perk/MonsterAbility.png'
				Tentacle
					name="Tentacle"
					desc="A basic, tentacle based attack."
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower=1
					attack_roll_damage_upper=10
					addhit=4
					adddam=5
					range="2 tile range."
					damsource="str"
				CrudePotion
					name="a Crude Potion"
					heal=1
					level=1
				GooStream
					name="Goo Stream"
					element="Water"
					typing="magical"
					damsource="wis"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower=10
					attack_roll_damage_upper=25
				Scissors
					name="Scissors"
					element="Drain"
					typing="physical"
					damsource="str"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower=20
					attack_roll_damage_upper=30
				SahauginTrident
					name="Sahaugin Trident"
					element="Physical"
					typing="physical"
					damsource="str"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower=14
					attack_roll_damage_upper=28
				WormQuake
					name="Sahaugin Trident"
					element="Earth"
					typing="magical"
					damsource="wis"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower=14
					attack_roll_damage_upper=30
				Howl
				ChocoKick
					name="Choco Kick"
					desc="A simple Chocobo kick."
					damsource="str"
					atype="standard"
					typing="physical"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower=10
					attack_roll_damage_upper=25
				DoublePeck
					name="Double Peck"
					desc="The Chocobo pecks twice, at the cost of 20 SP."
					damsource="str"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower=8
					attack_roll_damage_upper=16
				StickyWeb
					name="Sticky Web"
					element="Bio"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower=8
					attack_roll_damage_upper=14
				CursedClaws
					name="Cursed Claws"
					element="Physical"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower=25
					attack_roll_damage_upper=35
				DragonClaws
					name="Dragon Claws"
					element="Physical"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower=25
					attack_roll_damage_upper=35
					atype="standard"
					typing="physical"
					addhit=3
					adddam=5
					desc="A Wyvern's basic attack action."
					mcost=0
					range=" Melee"
				PhysicalAttack
					element="Physical"
					name="Physical Attack"
					atype="standard"
					typing="physical"
					damsource="str"
					addhit=5
					adddam=4
				MagicalAttack
					element="General"
					name="Magical Attack"
					atype="standard"
					typing="magical"
					addhit=5
					damsource="wis"
					adddam=4
				Emperor
					heal=1
					level=4
					element="Heal"
				ThousandNeedles
					name="1,000 Needles"
					element="Nature"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower=150
					attack_roll_damage_upper=150

			Summon
				ability=1
				icon='Icons/Perk/Summoner.png'
				PoisonCloud
					name="Poison Cloud"
					rank="A"
					desc="Scarmiglione generates a cloud of poison. The cloud eats away and degrades anything within it like an acid. Creatures who start their turn within the cloud take 5d10 poison damage, and are inflicted with Poison. As a bonus action, Scarmiglione is capable of moving the cloud’s epicenter up to 3 tiles, at the cost of 5 MP - the cloud lasts for 5 rounds. (-70 Mana.)"
				CorruptEarth
					name="Corrupt Earth"
					rank="B"
					desc="Lich generates foul corruption, with the epicenter being a tile within 8 tiles of Lich’s location. The ground in a 7x7 area becomes extremely dangerous, dealing 4d12 damage to any creature standing within the area - and inflicting poison to those who are currently in contact with it. Corrupted Earth lasts for 4 rounds. (-70 Mana.)"
