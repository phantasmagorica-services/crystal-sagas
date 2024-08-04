/obj/perk/Jobperks/Ranger
	jobneed="Ranger"
	icon='Icons/Perk/Ranger.png'
	Ranger
		name="Ranger"
		cat="Unique"
		desc="The ranger is trained to see and fire upon a selected target. They have much better eyesight than the normal person as such, perhaps better than even 20/20 vision. Rangers gain advantage on Perception checks, and +2 hit and +2 PDB with physical ranged weapons. They also start off with Dagger Slot Type for free and may switch to or from a Dagger as a Bonus Action. +30 HP, +30 MP, +70 SP."
	XSlayer
		var/slaytype="X"
		name="X Slayer"
		rank="T1"
		desc="This individual has learned to study nature. In particular they have deeply studied anatomy and weak-points on an enemy, permitting them to whittle down their defenses and open up or mark vulnerable points for their allies. Once per turn, after a successful attack resolves, it reduces an opponent’s DR by 5, to a cap of 15. This reduction lasts 2 Turns, but a fresh hit refreshes the duration of all stacks."
		verb
			Designate()
				if(slaytype=="X")
					var/list/slayinglist = list("Humanoid","Dragon","Demon","Ghost","Summon","Machine","Beast")
					var/slaychoice = input(usr,"Designate your chosen Slaying type.") as anything in slayinglist
					switch(slaychoice)
						if("Humanoid")
							src.slaytype="Humanoid"
							name="[src.slaytype] Slayer"
							desc+=" Type: [src.slaytype]"
						if("Dragon")
							src.slaytype="Dragon"
							name="[src.slaytype] Slayer"
							desc+=" Type: [src.slaytype]"
						if("Demon")
							src.slaytype="Demon"
							name="[src.slaytype] Slayer"
							desc+=" Type: [src.slaytype]"
						if("Ghost")
							src.slaytype="Ghost"
							name="[src.slaytype] Slayer"
							desc+=" Type: [src.slaytype]"
						if("Summon")
							src.slaytype="Summon"
							name="[src.slaytype] Slayer"
							desc+=" Type: [src.slaytype]"
						if("Machine")
							src.slaytype="Machine"
							name="[src.slaytype] Slayer"
							desc+=" Type: [src.slaytype]"
						if("Beast")
							src.slaytype="Beast"
							name="[src.slaytype] Slayer"
							desc+=" Type: [src.slaytype]"
					usr.nolearn+="X Slayer"
	Hawkeye
		rank="T2"
		name="Hawkeye"
		desc="This individual has keen sight. They are able to see much further than a normal person, and have trained their eyes to spot living targets from almost any hiding spot. Their target has to be extremely well camouflaged in order to stay out of sight. A Ranger ignores an opponent’s stealth and obscuration and gains Resistance to Blind. (+1 to Hit and +2 to damage with ranged attacks.)"
	Camouflage
		rank="T2"
		name="Camouflage"
		desc="This individual has learned how to disguise themselves with the environment. They know how to use natural foliage as well as wearing the right colors in order to blend in with the environment, and therefore use it to their advantage. As a Standard Action, the ranger chooses a background tile that they are presently standing on, utilizing camouflage that corresponds to that specific tile. They may move (at -2 Speed to a minimum of 1) to other tiles of that same type without breaking camouflage, but once they move to a different type of tile, they lose this bonus. Camouflage grants opponents disadvantage on non-melee attacks aimed at them, and if the camouflaged Ranger passes a saving throw for half damage, they take no damage instead, as the opponent wasn't able to successfully target them due to their misdirection. Camouflage lasts until they've taken damage 3 times, being ruined at that point."
	Sniper
		name="Sniper"
		rank="T3"
		desc="The individual has an impeccable aim able to hit a target from nearly any range. When they take aim, time seems to slow for them allowing an almost sure fire hit. The Ranger may expend their Bonus Action at the same time as their Standard Action when making an attack to perform a ‘Sniper Shot’. They roll a standard attack with that Bonus Action, after their Standard Action’s attack, and if the Standard Action’s attack hits, they can add the damage of the Bonus Action’s standard attack to it. One Turn Cooldown. (+4 tiles to effective range with a bow.)"
	MiseriesEnd
		name="Misery's End"
		rank="T3"
		desc="This individual has learned how to deal killing blows to a weakened enemy. When targeting an enemy with less than 20% of their max health they receive advantage on attack rolls, and once per turn an attack may deal 1.5x its damage to that wounded target, but only when using ranged attacks."
	RapidFire
		name="Rapid Fire"
		rank="T4"
		desc="The individual through repetition has mastered the movement of pulling an arrow, and is able to load, and fire their bow much faster. (The Ranger may now give up a Reaction and 25 SP to make an additional ranged basic attack on their turn.)"
	AnimalWhisperer
		name="Animal Whisperer"
		rank="T5"
		desc="Time spent in the wilderness has led to the ranger being supernaturally attuned to nature. They are able to make special calls in order to call animals of the wild to their aid. They are capable of talking to animals in a way they understand the users intention. They are able to discern the intention of the user. The user is capable of making a nature check, on advantage to calm an animal or a BEAST type Monster. (Note: Animals are distinct from monsters.)"
		cat="Unique"

/obj/perk/Abilities/Ranger
	jobneed="Ranger"
	icon='Icons/Perk/Ranger.png'
	costtype="Stamina"
	damsource="dex"
	typing="physical"
	atype="standard"
	element="Physical"
	RepellingShot
		name="Repelling Shot"
		rank="E"
		desc="As a bonus action, after an attack that hits its target, move up to 1 Tile away from the target. 10 SP Cost"
	Aim
		rank="D"
		atype="weapon"
		attack_roll_damage_dice = FALSE
		attack_roll_damage_exact = 0
		range=" Weapon range."
		addhit=3
		mcost=10
		desc="As a bonus action the ranger stops in their place taking a deep breath as they focus on a target. They shut out the world around them focusing only on a single target. This allows them to track, and aim at their prey much easier although putting them at risk as their focus shifts. (Gains +3 to hit on a single target, can keep focus on a target for 5 turns. May only be active on a single target at a time.) -10 Stamina.)"
	NefariousWound
		name="Nefarious Wound"
		rank="D"
		atype="weapon"
		attack_roll_damage_dice = TRUE
		attack_roll_dice_count = 2
		attack_roll_dice_sides = 6
		range=" Weapon range."
		addhit=1
		mcost=20
		desc="A poison coated shot targeted at a vital point on the target. Has a +1 to hit. On a successful hit, this attack inflicts Poison.| Damage: Weapon Damage+2d6, attack roll. Costs 20 SP."
	FootShot
		name="Foot Shot"
		rank="C"
		atype="weapon"
		attack_roll_damage_dice = FALSE
		attack_roll_damage_exact = 0
		range=" Weapon range."
		mcost=20
		desc="The ranger takes aim at the targets foot. They then fire an arrow that pins the poor target to the ground. This deals zero damage. (Ranged Attack Roll, On a successful hit applies Slow. -20 Stamina.)"
	ArrowRain
		name="Arrow Rain"
		rank="C"
		attack_roll_damage_dice = TRUE
		attack_roll_dice_count = 5
		attack_roll_dice_sides = 6
		atype="weaponsave"
		range=" 3x3 AoE within weapon's range."
		mcost=30
		savetype="Reflex"
		basecheck=13
		desc="The user puts several arrows into their bow, and pointing it upwards is able to fire them in the air where they arc, and then come down showering the target with arrows. (Damage: 5d6+DEX piercing damage | Reflex Save, can be used within the rangers bow range, hits in a 3x3 AoE, - 30 Stamina.)"
	Barrage
		rank="B"
		attack_roll_damage_dice = TRUE
		attack_roll_dice_count = 7
		attack_roll_dice_sides = 6
		range=" 5 tile wide projectile, weapon's range."
		atype="weaponsave"
		savetype="Reflex"
		basecheck=15
		mcost=40
		desc="The user loads up to several shots of ammo firing before out a barrage of projectiles. (Damage: 7d6+DEX| Reflex Save, creates a 5 tile wide projectile, - 40 Stamina)"
	UltimaArrow
		name="Ultima Arrow"
		rank="A"
		attack_roll_damage_dice = TRUE
		attack_roll_dice_count = 7
		attack_roll_dice_sides = 10
		atype="weaponsave"
		savetype="Reflex"
		basecheck=18
		range=" Weapon range, 3x3 AoE projectile."
		mcost=65
		desc="The user fires a single arrow imbued with a mass of magic. The arrow travels for a short time in the air. The arrow explodes into a shower of arrows of light that barrages the area below. (7d10+DEX force damage. Bow range. Hits in a 15ft AoE prompting a reflex saving throw. - 65 Stamina)"
	HeartPierce
		name="Heart Pierce"
		rank="S"
		attack_roll_damage_dice = TRUE
		attack_roll_dice_count = 8
		attack_roll_dice_sides = 10
		addhit=5
		mcost=100
		atype="weapon"
		desc="The user aims an arrow for their targets most vital spot, their heart. After letting the arrow loose it travels with grace until it shreds through the body of the unfortunate carrier, whose heart has been plucked from their chest by the passing arrow. Even if not initially fatal the damage dealt puts the target at a severely weakened state. (Damage: 8d10+DEX | Ranged attack roll, reduces AC, MAB, PAB, and DR by 4 for 4 rounds. - 100 Stamina.)"
