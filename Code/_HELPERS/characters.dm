
/proc/character_rank_to_tier(rank)
	switch(rank)
		if(CHARACTER_RANK_FLEDGLING)
			return CHARACTER_TIER_FLEDGLING
		if(CHARACTER_RANK_ROOKIE)
			return CHARACTER_TIER_ROOKIE
		if(CHARACTER_RANK_ADEPT)
			return CHARACTER_TIER_ADEPT
		if(CHARACTER_RANK_VETERAN)
			return CHARACTER_TIER_VETERAN
		if(CHARACTER_RANK_HERO)
			return CHARACTER_TIER_HERO
		if(CHARACTER_RANK_MASTER)
			return CHARACTER_TIER_MASTER