/obj/resource_node/mining
	name="Mine Node"
	icon = 'Icons/Nodes.dmi'
	icon_state = "Ore"
	icon_state_empty = "Emptyore"
	icon_state_full = "Ore"
	density=1

/obj/resource_node/mining/Click()
	var/mob/user = usr
	if(!(user in view(1,src)))
		return
	if(!can_harvest(user, FALSE))
		return
	if(!user.check_perk(/obj/perk/Gathering/Miner/Miner1))
		alert(user, "You need to learn how to mine properly first.")
		return

	// initial roll out of 100
	var/ore_roll = rand(1, 100)
	// get modifiers
	if(user.check_perk(/obj/perk/Jobperks/Merchant/MasteroftheLand))
		ore_roll += 10
	if(user.check_perk(/obj/perk/Gathering/Miner/Miner2))
		ore_roll += 10
	// get reward type
	var/reward_type
	switch(ore_roll)
		if(1 to 39)
			reward_type = /obj/item/material/ingot/bronze
		if(40 to 69)
			reward_type = /obj/item/material/ingot/iron
		if(70 to 89)
			reward_type = /obj/item/material/ingot/steel
		if(90 to 99)
			reward_type = /obj/item/material/ingot/mythril
		if(100 to INFINITY)
			reward_type = /obj/item/material/ingot/adamantine
	// get modifiers
	var/list/amount_modifier_describe = list()
	var/amount_modifier = 0
	var/amount_multiplier = 1
	if(user.check_perk(/obj/perk/Jobperks/Merchant/MasterGatherer))
		amount_modifier += 1
		amount_modifier_describe += "(Master Gatherer +1)"
	if(user.check_perk(/obj/perk/Gathering/Miner/Miner3))
		amount_modifier += 1
		amount_modifier_describe += "(Expert Miner +1)"
	// finalize
	var/amount = (1 + amount_modifier) * amount_multiplier
	var/obj/item/material/casted_reward = reward_type
	var/reward_name = initial(casted_reward.name)
	var/describe_modifiers = length(amount_modifier_describe)? " [jointext(amount_modifier_describe, " ")]" : ""
	// give them the materials
	user.adjust_material_amount(reward_type, amount)
	user.adjust_material_amount(/obj/item/material/stone, user.check_perk(/obj/perk/Jobperks/Merchant/NothingWasted)? 4 : 3)
	// calculate additional rewards
	var/additional_roll = rand(1, 20)
	var/additional_text
	var/additional_log
	switch(additional_roll)
		if(1 to 16)
		if(17 to 19)
			user.adjust_material_amount(/obj/item/material/ingot/silver, 1)
			additional_log = " (+1 silver)"
			additional_text = " and 1 silver"
		if(20)
			user.adjust_material_amount(/obj/item/material/ingot/gold, 1)
			additional_log = " (+1 gold)"
			additional_text = " and 1 gold"
	user.send_chat("You mined [amount] pieces of [reward_name], getting [user.check_perk(/obj/perk/Jobperks/Merchant/NothingWasted)? "4 stone (Nothing Wasted)" : "3 stone"] [additional_text] in the process.[describe_modifiers]", "oocout")
	// use up
	log_action("GATHER: [key_name(user)] mined [src] (+[amount] [reward_name]) [user.check_perk(/obj/perk/Jobperks/Merchant/NothingWasted)? "+4 stone (Nothing Wasted)" : "+3 stone"][additional_log] [audit_coord(src)]")
	user.minednodes++
	use()
	//! legacy: update craft
	UpdateCraft(user)
