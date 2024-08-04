/**
 * EVERYTHING IN THIS FILE IS TEMPORARY UNTIL REWORKS HAPPEN
 * THIS IS JUST FOR EASE OF USE
 */

/proc/render_perks_markdown()
	. = list()
	for(var/obj/perk/perkpath as anything in typesof(/obj/perk))
		var/list/bits = explode_typepath(perkpath)
		if(length(bits) < 3)
			continue
		var/rel_depth = length(bits) - 3
		for(var/i in 1 to rel_depth)
			. += "[HTML_TAB]"
		. += "- [initial(perkpath.name)? initial(perkpath.name) : bits[length(bits)]][initial(perkpath.rank)? " ([initial(perkpath.rank)])" : ""][initial(perkpath.desc)? ": [initial(perkpath.desc)]" : ""]"
		. += "<br>"

	. = jointext(., "")

/client/verb/__markdown_render_perks()
	set name = ".markdown_render_perks"
	set hidden = TRUE
	set category = "Debug"
	src << browse("[render_perks_markdown()]", "window=md_render_perks")
