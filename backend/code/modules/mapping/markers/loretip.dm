/obj/map_marker/loretip
	name = "???"
	desc = "Some point of interest is here."
	layer = CONTEXT_LORETIP_LAYER
	plane = CONTEXT_PLANE
	icon = 'backend/icons/map_objects/loretips.dmi'
	icon_state = "default"
	invisibility = INVISIBILITY_NONE

	/// Title - defaults to name
	var/lore_title
	/// Short description - defaults to desc
	var/lore_short
	/// Long description - user must click to pop up to see this. HTML is allowed and encouraged.
	var/lore_long

/obj/map_marker/loretip/Initialize(mapload)
	if(!isnull(lore_title) && (src.name == initial(src.name)))
		src.name = lore_title
	if(!isnull(lore_short) && (src.desc == initial(src.desc)))
		src.desc = lore_short
	return ..()

/obj/map_marker/loretip/MouseEntered(location, control, params)
	. = ..()
	var/mob/showing = usr
	var/content = lore_short || desc
	if(!isnull(lore_long))
		content += "<hr><div style='text-align: right;'>Double-Click to see more!</div>"
	showing?.client?.open_tooltip(src, params, lore_title || name, content)

/obj/map_marker/loretip/MouseExited(location, control, params)
	. = ..()
	var/mob/showing = usr
	showing?.client?.close_tooltip()

// todo: this proc should probably have some abstraction
/obj/map_marker/loretip/DblClick(location, control, params)
	. = ..()
	if(isnull(lore_long))
		return
	var/mob/showing = usr
	if(isnull(showing))
		return
	var/datum/browser/window = new("loretip_[ref(src)]", lore_title || name, 400, 400)
	window.open(showing, {"
	[lore_long || "error; please report this to a coder!"]
	"})
