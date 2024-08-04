/obj/perk/Jobperks/Rogue
	jobneed="Rogue"
	icon='Icons/Perk/Thief.png'
	Rogue
		id = "RogueLegacyJob"
		name="Rogue"
		cat="Unique"
		desc="The Rogue is a quick and nimble individual, capable of striking faster than most can see. Their sleight of hand training as well as Lock-picking has honed their hand-eye-coordination and striking speed to an elevated level. Rogues have 30 feet of Obscuration ignorance, allowing them to see within 30 feet of Darkness or Obscuration. (+2 to hit with 1H Melee Weapons) +20 HP, +30 MP, +50 SP."
	ThrowingWeaponProficiency
		id = "RogueThrowingProficiency"
		name="Throwing Weapon Proficiency"
		rank="T1"
		desc="This individual has spent a copious amount of times practicing with throwing weapons. They can take on throwing weapons proficiency without taking a weapon slot, and gain +2 to hit while using them."
	SneakAttack
		id = "RogueSneakAttack"
		rank="T1"
		name="Sneak Attack"
		desc="This individual has the ability to strike from the shadows with deft precision. If a Rogue is obscured or in darkness, they also cannot be heard. If the Rogue is under the effects of Stealth, they gain extra sneak attack damage. Sneak damage procs when attacking with any form of advantage toward a target, but only once per turn. On a sneak attack deal an extra 1d6 damage per rank. Capping at Master Rank at 6d6. "
	Vigilance
		id = "RogueVigilance"
		rank="T1"
		name="Vigilance"
		desc="This individual has learned to watch their back. Attackers do not receive any bonus when flanking this user."
	Trapmaster
		id = "RogueTrapmaster"
		rank="T1"
		name="Trapmaster"
		desc="his individual has a sense for traps. They have learned how to set traps skillfully and can do so as a bonus action. This also allows them to notice any traps in their vision passively. As a Bonus Action the Rogue may set up a 1x1 trap on the ground within 2 Tiles of them. If an opponent is in this area at the start of their turn, they take 10 Damage and must succeed in Reflex Save of DC (10+Dex+Rank of the Rogue) or they’re Rooted until the end of their own turn. One Turn Cooldown."
	Weakpointspecialist
		id = "RogueWeakpointSpecialist"
		rank="T2"
		name="Weak Point Specialist"
		desc="+2 critical range as a global mod. When a critical strike is landed the victim must roll a dc 16 fortitude save or be knocked prone. This effect is only procable once per turn."
	FlurryofPetals
		id = "RoguePetalFlurry"
		rank="T2"
		name="Flurry of Petals"
		desc="After using a throwing weapon or knife-type weapon (Dagger or Thief Swords) as a Standard Attack or Ability, the Rogue may use their Bonus Action to swing their weapon, using trickery to manifest a tangible illusion of thrown knives at a foe. This allows them an additional standard attack at the cost of 20 Mana, at a range of 6 Tiles, even if their weapon would be melee range only. One Turn Cooldown."
	EmergencyHaste
		id = "RogueEmergencyHaste"
		rank="T2"
		name="Emergency Haste"
		desc="The user keeps a steady supply of emergency pills that can be used to hasten their movement in dire situations. . (When HP <40% grants haste status, lasts for 2 rounds if you go above 40% HP.)"
	FirstStrike
		id = "RogueFirstStrike"
		name="First Strike"
		rank="T3"
		desc="Strike fast and strike hard. These are words that the Rogue lives by. Rogues who make the first move gain a significant advantage in battle. If a Rogue takes the first turn in a battle, they gain a permanent +4 to PAB and MAB for the rest of the battle. Gives a permanent +5 to initiative rolls. The first basic attack on each of the Rogue's turn deals 10 additional damage, and said attack ignores damage reduction."
	DeepPockets
		id = "RogueDeepPockets"
		rank="T3"
		name="Deep Pockets"
		desc="Doubles the amount of times Rogue/Ninja based techniques can be used in a day. Example: Katon or Smoke increase from 3 uses a day to 6 uses a day."
	Assassin
		id = "RogueAssassin"
		rank="T5"
		name="Assassin"
		desc="This individual has trained to kill efficiently and ruthlessly. Attacks made while Obscured from a target deal 20 additional damage. When using daggers or thieves swords their sneak attack calculation is 1d8 instead of 1d6. They also receive a +2 proficiency bonus to hit with those weapons."
	NinjaArts
		id = "RogueNinjaArts"
		rank="T3"
		cat="Unique"
		name="Ninja Arts"
		desc="This individual has learned the ways of the ninja. Their job title is changed to Ninja, and they are granted access to the deep well of information about ninja arts known as Ninjutsu. In addition, they gain +20 permanent extra HP, as well as +20 permanent MP and SP, and an extra +1 to hit with 1H weapons."

/obj/perk/Abilities/Rogue
	jobneed="Rogue"
	icon='Icons/Perk/Thief.png'
	typing="physical"
	atype="standard"
	Smoke
		id = "RogueSmokeBomb"
		rank="E"
		desc="The Rogue is able to create a dense smoke screen by throwing down specially prepared smoke bombs as a Bonus Action. Creates a 3x3 AoE that obscures the caster of the ability. If a creature enters this Smoke, the Rogue becomes targetable to the creature. If the Rogue is attacking another creature while in a Smoke bomb, they gain advantage on attack rolls against that creature. This Smoke can be dispelled by any amount of damage from an attack that utilizes Wind damage, and it has an AC of 10, and fails saves automatically. This has a 3 turn cooldown. Smoke lasts for 2 turns. 3 / encounter."
	RopeKnife
		id = "RogueRopeKnife"
		name="Rope Knife"
		rank="E"
		desc="The user attaches a rope to a throwing weapon. Make a weapon attack roll. If this attack deals damage, the opponent is pulled towards the Rogue an amount of tiles equal to the higher of their Strength or Dexterity mod. The rope knife can be used as a grappling hook outside of combat, allowing the user to traverse vertical obstacles. 50ft range."
	Image
		id = "RogueMirrorImage"
		rank="D"
		desc="As a Standard Action, the user uses a specially prepared tag that quickens their pace forming a strange mirage around them that looks like there are two of the user. Grants one instance of blink. 5 / encounter."
	Mug
		id = "RogueMug"
		rank="C"
		desc="This Rogue is trained in the art of thievery beyond that of a normal individual. When performing a ‘Mug’ check during a PvP or PvE battle, they may add +5 to their thievery roll’s result after it has been rolled. This ability has an alternate use: As a Standard Action, make a weapon attack, if this attack deals damage, the Rogue severs important straps or parts of the opponents backpack, causing them to be unable to easily reach their items. For 2 Turns they cannot use items (ex. Mechanist bullets, potions, chemist items, rogue abilities with usage limits)."
	Shadowbind
		id = "RogueShadowbind"
		rank="C"
		desc="As a Standard Action, the Rogue may make a weapon attack, having added a binding seal to their weapon. If the attack hits and after damage, the target must make a DC:(13+Rank+Dex) Fortitude saving throw or suffer the effects of Slow. 5 / encounter."
	Bloodfest
		id = "RogueBloodfest"
		rank="C"
		desc="The user focuses directly around them making deep cutting attacks towards all targets in their vicinity. They can make any number of weapon attacks against targets within 5 feet (only one per creature). After a successful attack, the target must make a fortitude saving throw. Dex DC. Or suffer the 'Bleed' status effect. In addition, if at least one creature was dealt damage in this way, the Rogue gains +10 PDB for 3 rounds. Costs 20 Stamina."
	SpellbreakerVolley
		id = "RogueSpellbreaker"
		name="Spellbreaker Volley"
		rank="B"
		desc="As a reaction, use a specially prepared throwing weapon imbued with a charm that absorbs MP from a spell. Can only be used on single target spells in users' throw range. Negate the spell. The higher the rank the more tools will be needed E=1, D=2 etc. 10 / encounter."
	AuraSteal
		id = "RogueAuraSteal"
		name="Aura Steal"
		rank="B"
		desc="As a Standard Action, the user aims to stab a knife into an opponent’s aura, then draw positive energies out from them, and into themselves. Make a standard attack, if that hits and after damage the target makes a DC: (14+Rank+Dex) Will saving throw or has all positive status effects drained from them, and placed upon the user. 2 / encounter"
	Gauntlet
		id = "RogueGauntlet"
		rank="B"
		desc="Five throwing weapons are thrown in a circle. Once they land specially prepared tags on the weapons activate causing them to explode releasing energy on everything inside the circle. Targets a 15ft area. Targets in the AoE must make DC: (14+Rank+Dex) Reflex slaving throw or take 4d12 force damage 3/day. 3 / encounter."
	GodspeedStrike
		id = "RogueGodspeedStrike"
		rank="A"
		desc="As a Standard Action when using this technique, the Rogue launches themselves at their foe at incredible speeds and carves them up with their knives. This attack is so fast that the opponent may be caught completely unaware, until their wounds open. The Rogue may move up to half their speed - as a teleportation type of movement - before making a Standard Attack with advantage. This attack ignores DR. If both rolls would have hit, then the Rogue adds their Sneak Attack to this damage. 60 Stamina."
	MirageDive
		id = "RogueMirageDive"
		name="Mirage Dive"
		rank="S"
		desc="The user slaps a specially prepared tag onto themselves surging their bodies with energy. While mirage dive is active the user gains haste, quicken, and 3 stacks of blink, ; additionally, abilities do not consume SP while active. Lasts for 3 turns. 1 / encounter."
