/obj/item/stack/incentive_box
	name = "mysterious package"
	desc = "A reward for inviting a friend to Crystal Sagas. Aren't you excited to see what's inside?"
	icon = 'Icons/Items/Tome.dmi'

/obj/item/stack/incentive_box/verb/open()
	set name = "Open"
	set desc = "Open the box."
	set category = "Item"

	ASSERT(!isnull(usr))

	usr.send_chat("You open the launch incentive box..", "oocout")

	// todo: repository subsystem
	var/datum/prototype/struct/loot_pack/pack = new /datum/prototype/struct/loot_pack/incentive_box
	var/list/got = pack.flatten()
	for(var/path in got)
		var/amount = got[path]
		usr.legacy_inventory_ingest(path, amount, "Launch Incentive Get - ")

	// todo: inventory system should handle this
	src.loc = null
	usr.Refreshinventoryscreen()
	// end
	qdel(src)
