/obj/perk/Jobperks/Spellblade
	jobneed="Spellblade"
	icon='Icons/Perk/Spellblade.png'
	Spellblade
		cat="Unique"
		name="Spellblade"
		desc="The spellblade is in tune with the mana surrounding and inside of them. They have resistance to Force damage. A Spellblade may have up to 2 Infusions active simultaneously(1 Elemental, and 1 Status based). Spellblade infusions may not be stacked with the infusions of other Jobs. +30 HP, +70 MP, +30 SP."
	Memento
		rank="T1"
		name="Memento"
		desc="This individual has learned to expend their energy in times of stress. When this individual suffers a KO, their remaining mana will be sent into the air being distributed equally between their allies."
	EmergencyShell
		rank="T2"
		name="Emergency Shell"
		desc="The user has an enchantment on their sword that automatically raises a magical shell when the user is in a weakened condition protecting them from magic based attacks. (When HP < 40% grants shell status, lasts for 2 rounds if you go above 40% HP.)"
	AdvancedInfusion
		rank="T2"
		name="Advanced Infusion"
		desc="This individual has learned to infuse magic of the second tier. Elemental infusions grant an extra 5 PDB, DC’s for status effects increase by 1 and last for 1 more turn."
	PermanentInfusion
		rank="T2"
		name="Permanent Infusion"
		desc="This user is capable of permanently infusing an object with magical energy. If the Spellblade's weapon is enchanted with an Elemental enchantment, they may passively apply that element's infusion to its attacks at no cost, if they know that infusion."
	ManaWeapon
		rank="T2"
		name="Mana Weapon (OLD)"
		desc="This perk is removed. Please adminhelp for a refund."
		cat="Unique"
	AutoShell
		rank="T3"
		name="Auto Shell"
		desc="After rolling initiative grants the user shell, lasting for 4 turns."
	MagicArmor
		rank="T3"
		name="Magic Armor"
		desc="This user has learned how to channel an element into their armor as well as their weapon. Meaning that if a user uses thunder infusion, their armor will be infused with the element as well granting a full resistance to any attacks received by that element."
	PhantomBlade
		rank="T3"
		name="Phantom Blade"
		desc="This individual has learned to meld their weapon with magic until there is almost no distinction between the two. When wielding a Melee weapon, they may add their BASE PAB and PDB to their MAB and MDB as a global modifier respectively."
	ExpertElementalInfusion
		rank="T4"
		name="Expert Elemental Infusion"
		desc="This individual has learned to infuse tier 3 elemental magic. They can gain a further +5 PDB from infusions at the cost of +5 additional MP drain per turn."
	AntiMagic
		rank="T4"
		name="Anti-Magic"
		desc="This individual has learned to take some of the energy taken from a magical attack, and form it into a temporary barrier that prevents further harm from magic. When this user is hit by a magic attack they will have a temporary barrier that lessens damage taken by half if the next attack is magic based."
	DualInfusion
		rank="T4"
		name="Dual Infusion"
		desc="While the Spellblade has two Infusions active at the same time, they gain +5 PAB and MAB, as well as deal +15 additional true damage on hit."
	TreInfusion
		rank="T5"
		name="Tre Infusion"
		cat="Unique"
		desc="This Spellblade is a master of Infusion, and can activate up to 3 infusions at the same time. One damage dealing, one status, and either drain or osmose."

/obj/perk/Abilities/Spellblade
	jobneed="Spellblade"
	icon='Icons/Perk/Spellblade.png'
	atype="standard"
	FireInfusion
		name="Fire Infusion"
		rank="E"
		desc="This individual can surround their sword with fire. (Gain 5 PDB Adds fire element to all physical attacks. -3 Mana per turn active.)"
	WaterInfusion
		name="Water Infusion"
		rank="E"
		desc="This individual can surround their sword with water. (Gain 5 PDB. Adds water element to all physical attacks. -3 Mana per turn active.)"
	LightningInfusion
		name="Lightning Infusion"
		rank="E"
		desc="This individual can surround their sword with sparking electricity. (Gain 5 PDB. Adds thunder element to all physical attacks, -3 Mana per turn active.)"
	IceInfusion
		name="Ice Infusion"
		rank="E"
		desc="This individual can surround their sword with chilling cold, and a sheen of ice. (Gain 5 PDB. Adds Ice element to all physical attacks, -3 Mana per turn active.)"
	AeroInfusion
		name="Aero Infusion"
		rank="E"
		desc="This individual can surround their sword with air. (Gain 5 PDB. Adds aero element to all physical attacks -3 Mana per turn active.)"
	EarthInfusion
		name="Earth Infusion"
		rank="E"
		desc="This individual can surround their blade with stone. (Gain 5 PDB. Adds Earth element to all physical attacks. -5 Mana per turn active.)"
	DrainInfusion
		name="Drain Infusion"
		rank="D"
		desc="This individual can surround their weapon with malicious energy, which allows them to drain the lifeforce of others. (Gain 5 PDB. and Melee attacks heal for half of the total damage dealt. This caps at 40 HP per drain. -5 Mana per turn active.)"
	OsmoseInfusion
		name="Osmose Infusion"
		rank="D"
		desc="This individual can surround their weapon in a vacuum of Mana with draws energy towards it. (Gain 5 PDB. and Melee attacks restore MP equal to half of the total damage dealt. -1 Mana per turn active.)"
	PoisonInfusion
		name="Poison Infusion"
		rank="C"
		desc="This individual can use their magic to add a magical poison to their weapon. (Upon a successful hit the target will make a Fortitude save of 15, or be inflicted with the 'Poison' status effect. Lasts for 3 turns. -2 mana per turn active.)"
	SilenceInfusion
		name="Silence Infusion"
		rank="C"
		desc="This individual can add the status effect of silence to their weapon. If the weapon so much as cuts the opponent it will give them the status effect. (Upon a successful hit the target will make a Fortitude save of 15, or be inflicted with the 'Silence' status effect. Lasts for 3 turns, -5 mana per turn active.)"
	SleepInfusion
		name="Sleep Infusion"
		rank="C"
		desc="This individual can use their magic to add a sleeping effect to their strikes. Anyone who is hit by the weapon will find themselves becoming fatigued. (Upon a successful hit the target will make a Fortitude save of 15, or be inflicted with the 'Sleep' status effect. Lasts for 3 turns, -2 Mana.)"
	BlindInfusion
		name="Blind Infusion"
		rank="C"
		desc="This individual can add the status effect of blind to their weapon. If the weapon so much as cuts the opponent it will give them the status effect. (Upon a successful hit the target will make a Fortitude save of 15, or be inflicted with the 'Blind' status effect. Lasts for 3 turns, -4 mana per turn active.)"
	DispelBlade
		name="Dispel Blade"
		rank="B"
		desc="This individual can add a banishing force to their sword. Every successful attack done while under this infusion removes one positive status effect from the target. (Starting with the newest first.) (-10 mana per turn active.)"
	Runic
		rank="B"
		desc="The user casts their weapon upwards creating a magical field around them that extends 3 tiles outward in every direction. They cannot move or perform any other action while doing this, but while runic is active all magic that passes through the field is instantly absorbed into the user restoring their MP equal to the cost of the spell."
	FlareInfusion
		name="Flare Infusion"
		rank="B"
		desc="The user coats their weapon in plasma energy. While active, gain 15 PDB. and weapon attacks ignore up to 10 DR. (-8 mana per turn active.)"
	BreakInfusion
		name="Break Infusion"
		rank="A"
		desc="This individual can add the status effect of break to their weapon. If the weapon so much as cuts the opponent it will give them the status effect. (Upon a successful hit the target will make a Fortitude save of 15, or be inflicted with the 'Petrify' status effect, -30 mana per turn active.)"
	DoomInfusion
		name="Doom Infusion"
		rank="S"
		desc="This individual adds an eerie dark magic onto their weapon. This infuses the weapon with the doom status. Each attack has a chance of inflicting the doom status effect. Due to the nature of the energy it only works on beings with a weak soul, and will not work on humans or powerful boss creatures. (Upon a successful hit the target will make a Fortitude save of 15, or be inflicted with the ‘doom’ status effect, -40 mana per turn active.)"
	UltimaInfusion
		name="Ultima Infusion"
		rank="S"
		desc="This individual infuses their weapon with ultima magic granting it a brilliant green glow. Each weapon attack while this infusion is active, gain 20 PDB, and Weapon Attacks deal True Damage. (-25 mana per turn active.)"
		cat="Unique"
