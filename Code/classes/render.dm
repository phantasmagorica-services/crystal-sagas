/**
 * EVERYTHING IN THIS FILE IS TEMPORARY UNTIL REWORKS HAPPEN
 * THIS IS JUST FOR EASE OF USE
 */

/proc/render_classes_markdown()
	. = list()
	for(var/obj/perk/Jobperks/jobpath as anything in typesof(/obj/perk/Jobperks))
		var/list/bits = explode_typepath(jobpath)
		if(length(bits) < 4)
			continue
		var/rel_depth = length(bits) - 4
		for(var/i in 1 to rel_depth)
			. += "[HTML_TAB]"
		. += "- [initial(jobpath.name)? initial(jobpath.name) : bits[length(bits)]][initial(jobpath.rank)? " ([initial(jobpath.rank)])" : ""][initial(jobpath.desc)? ": [initial(jobpath.desc)]" : ""]"
		. += "<br>"

	. = jointext(., "")

/client/verb/__markdown_render_classes()
	set name = ".markdown_render_classes"
	set hidden = TRUE
	set category = "Debug"
	src << browse("[render_classes_markdown()]", "window=md_render_classes")
