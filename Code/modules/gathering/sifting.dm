/obj/resource_node/sifting
	name="Dirt Node"
	icon = 'Icons/Nodes.dmi'
	icon_state = "dirtpile"
	icon_state_full = "dirtpile"
	icon_state_empty = "remains"
	density = TRUE

/obj/resource_node/sifting/Click()
	var/mob/user = usr
	if(!(user in view(1, src)))
		return
	if(!can_harvest(user, FALSE))
		return
	if(!user.check_perk(/obj/perk/Gathering/Sifter/Sifter1))
		alert("You need to learn how to sift through dirt first.")
		return

	// initial roll out of 12
	var/gem_roll
	gem_roll = rand(1,12)
	if(user.check_perk(/obj/perk/Gathering/Sifter/Sifter2))
		if(alert(user, "You rolled a [gem_roll], would you like to reroll?", "Sifting", "Yes", "No") == "No")
			gem_roll = rand(1,12)
	// silently sanity check again after alert()
	if(!can_harvest(user, TRUE))
		return
	if(!user.client || !user.client)
		return
	// get reward type
	var/reward_type
	switch(gem_roll)
		if(1)
			reward_type = /obj/item/material/gem/fire
		if(2)
			reward_type = /obj/item/material/gem/ice
		if(3)
			reward_type = /obj/item/material/gem/water
		if(4)
			reward_type = /obj/item/material/gem/bio
		if(5)
			reward_type = /obj/item/material/gem/wind
		if(6)
			reward_type = /obj/item/material/gem/holy
		if(7)
			reward_type = /obj/item/material/gem/dark
		if(8)
			reward_type = /obj/item/material/gem/black
		if(9)
			reward_type = /obj/item/material/gem/white
		if(10)
			reward_type = /obj/item/material/gem/thunder
		if(11)
			reward_type = /obj/item/material/gem/earth
		if(12)
			reward_type = /obj/item/material/gem/diamond
	// get modifiers
	var/list/amount_modifier_describe = list()
	var/amount_modifier = 0
	var/amount_multiplier = 1
	if(user.check_perk(/obj/perk/Jobperks/Merchant/MasterGatherer))
		amount_modifier += 1
		amount_modifier_describe += "(Master Gatherer +1)"
	if(user.check_perk(/obj/perk/Gathering/Sifter/Sifter3))
		amount_modifier += 1
		amount_modifier_describe += "(Expert Sifter +1)"
	// finalize
	var/amount = (1 + amount_modifier) * amount_multiplier
	var/obj/item/material/casted_reward = reward_type
	var/reward_name = initial(casted_reward.name)
	var/describe_modifiers = length(amount_modifier_describe)? " [jointext(amount_modifier_describe, " ")]" : ""
	// give them the materials
	user.adjust_material_amount(reward_type, amount)
	user.adjust_material_amount(/obj/item/material/stone, user.check_perk(/obj/perk/Jobperks/Merchant/NothingWasted)? 6 : 5)
	user.send_chat("You sifted [amount] [reward_name]s, getting [user.check_perk(/obj/perk/Jobperks/Merchant/NothingWasted)? "6 stone (Nothing Wasted)" : "5 stone"] in the process.[describe_modifiers]", "oocout")
	// use up
	log_action("GATHER: [key_name(user)] mined [src] (+[amount] [reward_name]) (+[user.check_perk(/obj/perk/Jobperks/Merchant/NothingWasted)? 6 : 5] stone) [audit_coord(src)]")
	user.minednodes++
	use()
	//! legacy: update craft
	UpdateCraft(user)
