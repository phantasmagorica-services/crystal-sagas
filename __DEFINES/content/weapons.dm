#define GENERATE_PATHS_FOR_WEAPON_METAL_TIERS(path, base_id) \
##path/Bronze { \
	weapon_tier = WEAPON_TIER_BRONZE; \
	entity_id = base_id + "Bronze"; \
} \
##path/Iron { \
	weapon_tier = WEAPON_TIER_IRON; \
	entity_id = base_id + "Iron"; \
} \
##path/Steel { \
	weapon_tier = WEAPON_TIER_STEEL; \
	entity_id = base_id + "Steel"; \
}  \
##path/Mythril { \
	weapon_tier = WEAPON_TIER_MYTHRIL; \
	entity_id = base_id + "Mythril"; \
}  \
##path/Adamantine { \
	weapon_tier = WEAPON_TIER_ADAMANTINE; \
	entity_id = base_id + "Adamantine"; \
}  \
##path/Orichalcum { \
	weapon_tier = WEAPON_TIER_ORICHALCUM; \
	entity_id = base_id + "Orichalcum"; \
}
