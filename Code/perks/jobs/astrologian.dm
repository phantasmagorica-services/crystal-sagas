/obj/perk/Jobperks/Astrologian
	jobneed="Astrologian"
	icon='Icons/Perk/Astrologian.png'
	Astrologian
		name="Astrologian"
		cat="Unique"
		desc="At the start of an encounter, or battle; the astrologian is capable of entering into a stance as a free action: Diurnal - granting a five hp shield along with any green magic they cast.(Cannot stack this) Nocturnal - Lowers the cost of green magic by a flat 5 mana. 30 HP, 70 MP, 20 SP."
	Redraw
		rank="T1"
		desc="Allows one reroll for arcane draw per turn as a free action."
	QuickDraw
		name="Quick Draw"
		rank="T2"
		desc="Allows one use of arcane draw as a free action per turn."
	Mutlitasker
		name="Multi Tasker"
		rank="T2"
		desc="When casting a Green Magic spell, an Astrologian may cast another Green Magic spell for half of its original cost as part of the same standard action."
	EnchantedDraw
		name="Enchanted Draw"
		rank="T2"
		desc="Effects from arcane draw last as a 2 turn buff instead of a single use effect."
	Ensurance
		name="Ensurance"
		rank="T3"
		desc="When casting a Green Magic spell, an Astrologian may choose a single target being affected by the Green Magic spell to automatically apply the 'Safe' status effect to."
	ProlongedGreen
		name="Prolonged Green"
		rank="T3"
		desc="Green magic buffs cast by the astrologian last double the time."
	LearnedMind
		name="Learned Mind"
		rank="T3"
		desc="This astrologian has expanded their knowledge of white magic, allowing them to perform up to B rank White Magic spells."
	GloriousDraw
		name="Glorious Draw"
		rank="T4"
		desc="Doubles the effect of all buffs created through arcane draw."
	Synastry
		rank="T5"
		desc=" Individuals under the effect of an arcana are magically linked to the user. As long as the arcana buff remains active. When the astrologian heals another through white magic, they also receive healing equal to half the original. Whenever an astrologian uses green magic, linked individuals also receive the buff at half the time."

/obj/perk/Abilities/Astrologian
	jobneed="Astrologian"
	icon='Icons/Perk/Astrologian.png'
	atype="standard"
	ArcaneDraw
		name="Arcane Draw"
		rank="E"
		desc="As a bonus action, randomly draw a card from your deck. Roll a 1d6 depending on the result, grant the following buff to an ally within view. Only one effect may be active at a time. Drawing a new card swaps effects to the new result. 1. The Spear: increases PDB for one attack by +2 2. The Wand: Increases MDB for one attack by +2 3. The Bole: Adds +10 to the next instance of healing. 4. The Ewer: Reduces the cost of the next spell by 10. 5. The Aegis: Reduce the next instance of damage by 5 6. The Arrow: Increases MAB and PAB by +2 for one attack Out of Battle Effects: The user is capable of divining the future. They can consult the cards to pass a knowledge check regarding a person, place or thing."
	Horoscope
		rank="D"
		desc="As a reaction, change a roll by adding or subtracting a roll by up to 2 points within view. (-15 mana.)"

/obj/perk/Jobperks/Gambler
	cat="Unique"
	icon='Icons/Perk/Gambler.png'
	ajob="Gambler"
	rank="T4"
	desc="The Gambler is an Astrologian who rather than manipulating luck to their advantage, gives themselves up to it entirely - and thus, luck favors them. This gives access to unique 'Gambler' abilities."
	Dealer
		cat="Gambler"
		name="Dealer"
		rank="T2"
		desc="A Gambler is latently trained in the art of card reading, but has also weaponized their cards. They gain a +2 bonus to hit for Akademia cards, as well as 5 flat damage to attacks utilizing them. In addition, they gain proficiency with them if they do not have it already."
	GamblersLuck
		cat="Gambler"
		name="Gambler's Luck"
		rank="T3"
		desc="A Gambler's luck is favored by the planet, and thusly they are able to - once per long rest, reroll any roll at advantage after having rolled it."
	LucksShield
		cat="Gambler"
		name="Luck's Shield"
		rank="T3"
		desc="A Gambler is protected by their luck - and thusly they are able to enforce disadvantage upon up to 3 attack rolls targeted at them per long rest."

/obj/perk/Abilities/Gambler
	icon='Icons/Perk/Gambler.png'
	ajob="Gambler"
	atype="standard"
	SuiteDraw
		name="Suite Draw"
		rank="B"
		pre="Arcane Draw"
		desc="As a bonus action, randomly draw a card from your Suite deck. Roll a 1d17, and resolve the effect based on the result. These effects can stack on top of Arcane Draw. Only one effect may be active at a time, and the effect lasts until the end of battle. Drawing a new card incurs a new effect. 1. King of Hearts: Gain 2d40 temporary HP. (Does not refresh on additional applications.) 2. Queen of Hearts: Grant a party member 2d40 temporary HP. (Does not refresh on additional applications.) 3. Jack of Hearts: Grant entire party 2d20 temporary HP. (Does not refresh on additional applications.) 4. King of Diamonds: Gain +2 global attack and damage bonus. 5. Queen of Diamonds: Party gains +2 global attack and damage bonus. 6. Jack of Diamonds: Party gains +1 global attack and damage bonus. 7. King of Spades: Opponent suffers global -2 to hit and damage. 8. Queen of Spades: Enemy party suffers global -2 to hit and damage. 9. Jack of Spades: Enemy party suffers global -1 to hit and damage. 10. King of Clubs:  Opponent suffers 5 unreducable damage per turn at the start of each turn. 11. Queen of Clubs: Enemy party suffers 5 unreducable damage per turn at the start of each turn. 12. Jack of Clubs: Enemy party suffers 3 unreducable damage per turn at the start of each turn. 13. Ace of Hearts: Party gains +2 to hit, +2 damage reduction, +5 global damage, and regenerates 2 HP per turn. 14. Ace of Diamonds: Party gains advantage on all attack rolls, and saving throws. 15.  Ace of Spades: Enemy part suffers -2 to hit, -2 damage reduction, -5 global damage, and takes 2 unreducable damage each turn. 16. Ace of Clubs: Enemy party suffers disadvantage on all attack rolls, and saving throws. 17. Joker: Nothing. Costs 20 Mana per draw."
	ChangeFate
		name="Change Fate"
		rank="B"
		pre="Horoscope"
		desc="As a reaction, change a roll by adding or subtracting a roll by up to 4 points within view. (-15 mana.)"

