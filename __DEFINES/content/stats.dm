
#define CHARACTER_STAT_STR "str"
#define CHARACTER_STAT_DEX "dex"
#define CHARACTER_STAT_CON "con"
#define CHARACTER_STAT_INT "int"
#define CHARACTER_STAT_WIS "wis"
#define CHARACTER_STAT_CHA "cha"

/proc/character_stat_to_name(stat)
	switch(stat)
		if(CHARACTER_STAT_STR)
			return "Strength"
		if(CHARACTER_STAT_DEX)
			return "Dexterity"
		if(CHARACTER_STAT_CON)
			return "Constitution"
		if(CHARACTER_STAT_INT)
			return "Intelligence"
		if(CHARACTER_STAT_WIS)
			return "Wisdom"
		if(CHARACTER_STAT_CHA)
			return "Charisma"
