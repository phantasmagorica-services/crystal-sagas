/client/proc/open_tooltip(atom/movable/anchor, mouse_params, title, content, theme)
	// todo: our own theme
	tooltips?.show(anchor, mouse_params, title, content, theme = "midnight")

/client/proc/close_tooltip()
	tooltips?.hide()

/*
Tooltips v1.1 - 22/10/15
Developed by Wire (#goonstation on irc.synirc.net)
- Added support for screen_loc pixel offsets. Should work. Maybe.
- Added init function to more efficiently send base vars
Configuration:
- Set control to the correct skin element (remember to actually place the skin element)
- Set file to the correct path for the .html file (remember to actually place the html file)
- Attach the datum to the user client on login, e.g.
	/client/New()
		src.tooltips = new /datum/client_tooltips(src)
Usage:
- Define mouse event procs on your (probably HUD) object and simply call the show and hide procs respectively:
	/obj/abstract/screen/hud
		MouseEntered(location, control, params)
			usr.client.tooltip.show(params, title = src.name, content = src.desc)
		MouseExited()
			usr.client.tooltip.hide()
Customization:
- Theming can be done by passing the theme var to show() and using css in the html file to change the look
- For your convenience some pre-made themes are included
Notes:
- You may have noticed 90% of the work is done via javascript on the client. Gotta save those cycles man.
- This is entirely untested in any other codebase besides goonstation so I have no idea if it will port nicely. Good luck!
	- After testing and discussion (Wire, Remie, MrPerson, AnturK) ToolTips are ok and work for /tg/station13
*/

//* Modified by silicons for Phantasmagorica / Crystal Sagas *//
//* Assumed to be GPL. *//

/datum/client_tooltips
	/// owning client
	var/client/owner
	/// control ID
	var/skin_id = SKIN_BROWSER_ID_TOOLTIPS
	/// map control ID
	var/map_id = SKIN_MAP_ID_MAIN
	/// our file
	var/tooltips_html = 'html/html/tooltips.html'
	/// jquery file
	//  todo: asset cache
	var/jquery_html = 'html/js/jquery-3.7.1.min.js'
	/// currently showing?
	var/showing = FALSE
	/// hiding is queued
	var/hide_queued = FALSE
	/// initialized?
	var/initialized = FALSE


/datum/client_tooltips/New(client/C)
	if(!isnull(C))
		bind_client(C)

/**
 * Binds to the client and sends necessary data
 */
/datum/client_tooltips/proc/bind_client(client/C)
	owner = C
	// todo: this should be asset cache's job.
	C << browse_rsc(jquery_html, "jquery.min.js")
	C << browse(file2text(tooltips_html), "window=[skin_id]")

/datum/client_tooltips/proc/show(atom/movable/anchor, mouse_params, title, content, theme = "default", special = "none")
	if(QDELETED(anchor) || (!title && !content) || QDELETED(owner))
		return FALSE

	// initialize first
	if(!initialized)
		initialized = TRUE
		owner << output(list2params(list(world.icon_size, skin_id, map_id)), "[skin_id]:tooltip.init")

	// output
	showing = TRUE

	if (title && content)
		title = "<h1>[title]</h1>"
		content = "<p>[content]</p>"
	else if (title && !content)
		title = "<p>[title]</p>"
	else if (!title && content)
		content = "<p>[content]</p>"
	//Make our dumb param object
	mouse_params = {"{ "cursor": "[mouse_params]", "screenLoc": "[anchor.screen_loc]" }"}
	// patch for x/y
	var/list/owner_view = decode_view_size(owner.view)
	//Send stuff to the tooltip
	owner << output(list2params(list(mouse_params, owner_view[1], owner_view[2], "[title][content]", theme, special)), "[skin_id]:tooltip.update")

	showing = FALSE

	//If a hide() was hit while we were showing, run hide() again to avoid stuck tooltips
	if (hide_queued)
		hide()

	return TRUE

/datum/client_tooltips/proc/hide()
	if(hide_queued)
		// already queued? in 1 ds, kill it once showing expires, just in case it doesn't..
		spawn(1)
			winshow(owner, skin_id, FALSE)
	else
		// otherwise, kill it immediately
		winshow(owner, skin_id, FALSE)
	// queue if it's blocked by browse()
	hide_queued = showing? TRUE : FALSE
	return TRUE
