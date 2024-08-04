/obj/perk/GeneralPerks/HP
	icon='Icons/Perk/HP.png'
	HP1
		name="Tier 1 HP"
		rank="T1"
		rpcost=1
		desc="Gives a flat bonus of 50 HP."
	HP2
		name="Tier 2 HP"
		rank="T2"
		rpcost=2
		purchase_stat_requirements = list(
			"con" = 14,
		)
		desc="Gives a flat bonus of 20 HP."
		pre="Tier 1 HP"
	HP3
		name="Tier 3 HP"
		rank="T3"
		rpcost=3
		purchase_stat_requirements = list(
			"con" = 16,
		)
		desc="Gives a flat bonus of 20 HP."
		pre="Tier 2 HP"
	HP4
		name="Tier 4 HP"
		rank="T4"
		rpcost=4
		purchase_stat_requirements = list(
			"con" = 18,
		)
		desc="Gives a flat bonus of 50 HP."
		pre="Tier 3 HP"
	HP5
		name="Tier 5 HP"
		rank="T5"
		rpcost=5
		purchase_stat_requirements = list(
			"con" = 20,
		)
		desc="Gives a flat bonus of 40 HP."
		pre="Tier 4 HP"
	HP6
		name="Tier 6 HP"
		rank="T6"
		rpcost=6
		purchase_stat_requirements = list(
			"con" = 22,
		)
		desc="Gives a flat bonus of 100 HP."
		pre="Tier 5 HP"

/obj/perk/GeneralPerks/MP
	icon='Icons/Perk/Mana.png'
	MP1
		name="Tier 1 MP"
		rank="T1"
		rpcost=1
		desc="Gives a flat bonus of 40 MP."
	MP2
		name="Tier 2 MP"
		rank="T2"
		rpcost=2
		stattype=3
		stattypedisplay="Wisdom"
		purchase_stat_requirements_any = list(
			"wis" = 14,
			"int" = 14,
			"cha" = 14,
		)
		desc="Gives a flat bonus of 20 MP."
		pre="Tier 1 MP"
	MP3
		name="Tier 3 MP"
		rank="T3"
		rpcost=3
		purchase_stat_requirements_any = list(
			"wis" = 16,
			"int" = 16,
			"cha" = 16,
		)
		desc="Gives a flat bonus of 20 MP."
		pre="Tier 2 MP"
	MP4
		name="Tier 4 MP"
		rank="T4"
		rpcost=4
		purchase_stat_requirements_any = list(
			"wis" = 18,
			"int" = 18,
			"cha" = 18,
		)
		desc="Gives a flat bonus of 80 MP."
		pre="Tier 3 MP"
	MP5
		name="Tier 5 MP"
		rank="T5"
		rpcost=5
		purchase_stat_requirements_any = list(
			"wis" = 20,
			"int" = 20,
			"cha" = 20,
		)
		desc="Gives a flat bonus of 60 MP."
		pre="Tier 4 MP"
	MP6
		name="Tier 6 MP"
		rank="T6"
		rpcost=6
		purchase_stat_requirements_any = list(
			"wis" = 22,
			"int" = 22,
			"cha" = 22,
		)
		desc="Gives a flat bonus of 100 MP."
		pre="Tier 5 MP"

/obj/perk/GeneralPerks/SP
	icon='Icons/Perk/Stamina.png'
	SP1
		name="Tier 1 SP"
		rank="T1"
		rpcost=1
		desc="Gives a flat bonus of 40 SP."
	SP2
		name="Tier 2 SP"
		rank="T2"
		rpcost=2
		purchase_stat_requirements = list(
			"str" = 14,
		)
		desc="Gives a flat bonus of 20 SP."
		pre="Tier 1 SP"
	SP3
		name="Tier 3 SP"
		rank="T3"
		rpcost=3
		purchase_stat_requirements = list(
			"str" = 16,
		)
		desc="Gives a flat bonus of 20 SP."
		pre="Tier 2 SP"
	SP4
		name="Tier 4 SP"
		rank="T4"
		rpcost=4
		purchase_stat_requirements = list(
			"str" = 18,
		)
		desc="Gives a flat bonus of 80 SP."
		pre="Tier 3 SP"
	SP5
		name="Tier 5 SP"
		rank="T5"
		rpcost=5
		purchase_stat_requirements = list(
			"str" = 20,
		)
		desc="Gives a flat bonus of 60 SP."
		pre="Tier 4 SP"
	SP6
		name="Tier 6 SP"
		rank="T6"
		rpcost=6
		purchase_stat_requirements = list(
			"str" = 22,
		)
		desc="Gives a flat bonus of 100 SP."
		pre="Tier 5 SP"

/obj/perk/GeneralPerks/Speed
	icon='Icons/Perk/Speed.png'
	Speed1
		name="Speed(T1)"
		desc="Grants +1 Tile Movement per turn, for a total of 4."
		rank="T1"
		rpcost=1
	Speed2
		name="Speed(T2)"
		desc="Grants +2 Tile Movement per turn, for a total of 5."
		rank="T2"
		rpcost=2
		purchase_stat_requirements = list(
			"dex" = 14,
		)
		pre="Speed(T1)"
	Speed3
		name="Speed(T3)"
		desc="Grants +3 Tile Movement per turn, for a total of 6."
		rank="T3"
		rpcost=3
		purchase_stat_requirements = list(
			"dex" = 16,
		)
		pre="Speed(T2)"
	Speed4
		name="Speed(T4)"
		desc="Grants +4 Tile Movement per turn, for a total of 7."
		rank="T4"
		rpcost=4
		purchase_stat_requirements = list(
			"dex" = 18,
		)
		pre="Speed(T3)"
	Speed5
		name="Speed(T5)"
		desc="Grants +5 Tile Movement per turn, for a total of 8."
		rank="T5"
		rpcost=5
		purchase_stat_requirements = list(
			"dex" = 20,
		)
		pre="Speed(T4)"
	Speed6
		name="Speed(T6)"
		desc="Grants +6 Tile Movement per turn, for a total of 9."
		rank="T6"
		rpcost=6
		purchase_stat_requirements = list(
			"dex" = 22,
		)
		pre="Speed(T5)"

/obj/perk/GeneralPerks/AbilityScoreImprovements
	icon='Icons/Perk/AbilityScore.png'
	ASI1
		name="Ability Score Improvement T1"
		desc="+2 to ability score pool."
		rank="T1"
		cat="Unique"
		rpcost=1
	ASI2
		name="Ability Score Improvement T2"
		desc="+2 to ability score pool."
		rank="T2"
		cat="Unique"
		rpcost=2
		pre="Ability Score Improvement T1"
	ASI3
		name="Ability Score Improvement T3"
		desc="+2 to ability score pool."
		rank="T3"
		cat="Unique"
		rpcost=3
		pre="Ability Score Improvement T2"
	ASI4
		name="Ability Score Improvement T4"
		desc="+2 to ability score pool."
		rank="T4"
		cat="Unique"
		rpcost=4
		pre="Ability Score Improvement T3"
	ASI5
		name="Ability Score Improvement T5"
		desc="+2 to ability score pool."
		rank="T5"
		cat="Unique"
		rpcost=5
		pre="Ability Score Improvement T4"
	ASI6
		name="Ability Score Improvement T6"
		desc="+2 to ability score pool."
		rank="T6"
		cat="Unique"
		rpcost=6
		pre="Ability Score Improvement T5"

