/**
 * EVERYTHING IN THIS FILE IS TEMPORARY UNTIL REWORKS HAPPEN
 * THIS IS JUST FOR EASE OF USE
 */

/proc/render_races_markdown()
	. = list()
	for(var/obj/perk/Raceperks/racepath as anything in typesof(/obj/perk/Raceperks))
		var/list/bits = explode_typepath(racepath)
		// immediate subtypes only on outer loop aka races only
		if(length(bits) != 4)
			continue
		// name
		. += "- [bits[length(bits)]]"
		// racial
		for(var/obj/perk/Raceperks/perkpath as anything in typesof(racepath))
			var/list/bits2 = explode_typepath(perkpath)
			// immediate subtypes only aka race perks
			if(length(bits2) != 5)
				continue
			. += "[HTML_TAB]- [initial(perkpath.name)]: [initial(perkpath.desc)]"
	. = jointext(., "<br>")

/client/verb/__markdown_render_races()
	set name = ".markdown_render_races"
	set hidden = TRUE
	set category = "Debug"
	src << browse("[render_races_markdown()]", "window=md_render_races")
