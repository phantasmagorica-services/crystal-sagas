/obj/perk/Jobperks/RedMage
	jobneed="Red Mage"
	icon='Icons/Perk/Red Mage.png'
	RedMage
		name="Red Mage"
		cat="Unique"
		desc="A Red Mage may switch between the 'Fencing' and 'Casting' stance as a bonus action. Fencing stance grants +1 to PAB and MAB, as well as granting +8 PDB. Casting stance grants +8 MDB, and boosts healing spells by 5. +60 HP, +50 MP, +50 SP."
	Chainspell
		name="Chainspell"
		rank="T1"
		desc="If this individual casts a white or black magic spell as a standard action, they are capable of using the opposite type as a bonus action on their next turn."
	PureRedMage
		name="Pure Red Mage"
		rank="T1"
		desc="This individual has departed down a truly arduous, but possibly rewarding path. They have internalized and synced their energy under a particular ritual ; disallowing them from learning any knowledge outside of the grasp of a Sage. This gives them the potential to become a Sage through rigorous trials, and the energy inside of them is completely balanced between Aetherial and Lifestream energies. This grants them +20 MP, +20 SP, and +2 ability score points."
	Composure
		name="Composure"
		rank="T2"
		desc="This individual can cast a magic ability as a full action in order to receive advantage on a magical attack roll."
	ScalesofRed
		name="Scales of Red"
		rank="T2"
		desc="When the user casts a Black or White magic spell, they gain stacks of that respective color, depending on spell rank. D Ranks = 2, C Ranks = 3, B Ranks = 4, A Ranks = 5, S Ranks = 6. You may spend these stacks in order to increase the healing of a white mage spell, or the damage of a black mage spell by 1 per stack - using the respective color. When both Black and White stacks are equal to each-other, you gain 10 PDB and MDB. For the damage bonus to take effect, you must have at least 1 active Black or White magic stack. Both White Magic and Black Magic stacks cap at 20."
	TipTheScales
		name="Tip the Scales"
		pre="Scales of Red"
		rank="T2"
		desc="A Red Mage is able to recycle magical energy better than any other profession. As a result, they may spend their standard action in order to reduce all White and Black stacks to 0 (requires at least 4 stacks each) - in order to apply the 'Refresh' status effect to themselves."
	InaPinch
		name="In a Pinch"
		rank="T2"
		desc="When the user falls below 20% health the cost of C rank or lower abilities is reduced to 0."
	Synchronicity
		name="Synchronicity"
		rank="T2"
		pre="Pure Red Mage"
		desc="This Red Mage has focused purely on the art of Red Magic ; combining all forms of Magic as deftly as possible, for true synergy - they live in yin and yang, energetically. As a result, their raw mana is much more potent. They gain +30 MP to their mana pool permanently, and in addition - their Magic Abilities gain +1 to hit, and deal 8 additional damage on hit."
	Attunement
		name="Attunement"
		rank="T3"
		desc="The Red Mage gains 5 Black Mage stacks whenever hit with a Black Mage ability, and gains 5 White Mage stacks whenever targeted by a White Mage Ability. They can choose not to take these stacks if they so wish."
	SharedPower
		pre="Tip the Scales"
		name="Shared Power"
		rank="T3"
		desc="This Red Mage is capable of not only recycling their built up excess energies, but they can also share it with their comrades. When utilizing the 'Tip the Scales' ability - the Red Mage may apply Refresh to up to two party members in addition to themselves."
	RedMageAdept
		name="Red Mage Adept"
		rank="T3"
		pre="Synchronicity"
		pre="Pure Red Mage"
		desc="This individual has strenuously studied the magical arts and as such is able to learn up to B rank Black, and White magic abilities."
	GoingitAlone
		pre="Pure Red Mage"
		name="Going it Alone"
		rank="T3"
		desc="This Red Mage has learned the true nature of conservation of energy. When they are not in a party, and are in a battle on their lonesome - the lack of a party's presence means there is more lingering magical essence around them. A Red Mage who does not have any player party members with them in battle gains +2 to hit, +2 AC, +5 Damage reduction, and deals 8 additional damage on all attacks, as the surplus of magical energy overloads them with magical power. This does not apply in PvP as the opposing Humans are still drawing a large amount of magical energy."
	JackofAllMages
		pre="Pure Red Mage"
		name="Jack of All Mages"
		rank="T3"
		desc="This individual has truly pushed their magical mastery to the utmost limit. They have pushed beyond traditional magic, and with their pure Red arts - have tapped into the Aether, now able to form a connection with a singular Eidolon, proving that they truly can use all forms of magic. (Requires pure Red Mage, incompatible with Subjob. Grants 1 C or B rank Summon.)"
	DoubleCast
		name="Double Cast"
		pre="Chainspell"
		rank="T4"
		desc="Allows the user to cast an extra spell as a bonus action. (Does not count for general magic abilities or general weapon abilities. Only white, black, green, or arcane magic.)"
	RedEmpowerment
		pre="Pure Red Mage"
		name="Red Empowerment"
		rank="T4"
		pre="Red Mage Adept"
		desc="The essence of Red Magic is 'energy' - this takes many forms. Vitality, physical energy, spiritual energy, magical energy. A Red Mage who has learned the Red Empowerment Ability has opened themselves up to the world around them, allowing more natural energy to flow freely throughout their bodies than normal. They gain a permanent +20 HP, +20 MP, and +20 SP - as well as +2 points to distribute to their ability scores."
	Sage
		name="Sage"
		rank="T5"
		cat="Unique"
		desc="This individual is a true magical master. They are capable of learning up to S rank white, black, green, arcane magic, and summons. +4 INT, +4 CHA, +4 WIS, +100 HP, +100 MP"

/obj/perk/Abilities/RedMage
	typing="magical"
	jobneed="Red Mage"
	icon='Icons/Perk/Red Mage.png'
	atype="standard"
	RedFlourish
		element="Laser"
		name="Red Flourish"
		rank="C"
		mcost=25
		costtype="Mana"
		atype="weapon"
		attack_roll_damage_dice = TRUE
		attack_roll_dice_count = 2
		attack_roll_dice_sides = 10
		damsource="wis"
		desc="This Red Mage has learned to mix their bladesmanship expertly with their Magic. By coating the blade with both Aetherial and Lifestream energies, they channel both Black and White magic, and strike at a target. This generates 1 Black Magic stack, and 1 White Magic stack when used. (Damage: Weapon Damage + 2d10+WIS Force damage | Melee Weapon attack, -25 Mana.)"
	ManaWall
		name="Mana Wall"
		rank="B"
		desc="This individual has learned to use their mana as a near impenetrable shield. Their mana coats their body soaking up any damage that would be caused to them instead affecting their mana pool. The Mana Wall has resistance to all types of damage. Uses up the users bonus action to sustain. (-10 mana each turn to sustain.)"

/obj/perk/Jobperks/Sage
	cat="Unique"
	icon='Icons/Perk/Sage.png'
	ajob="Sage"
	name="Sage"
	desc="This individual is a true magical prodigy. They are capable of learning up to S rank white, black, green, arcane magic, and summons."
