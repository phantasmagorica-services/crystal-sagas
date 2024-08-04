LEGACY_GLOBAL_DATUM_INIT(runtime_viewer, /datum/runtime_viewer, new)

/client/verb/view_runtimes()
	set name = "View Runtimes"
	set category = "Debug"

	if(!global.is_dev(src))
		send_chat("Only admins and developers can view errors.")
		return
	global.runtime_viewer.show_to(src)

/datum/runtime_viewer
	/// browser
	var/datum/browser/browser

/datum/runtime_viewer/New()
	browser = new("runtime_viewer", "Runtime Viewer", 600, 400)

/datum/runtime_viewer/proc/show_to(mob/user, datum/error_data/specific, index = 1)
	var/list/assembled = list()
	if(specific)
		assembled += "<a href='?src=[ref(src)];act=main'>Runtimes</a>"
		var/len = length(specific.instances)
		index = clamp(index, 1, len)
		assembled += "<span style='float: right'>"
		if(index > 1)
			assembled += " <a href='?src=[ref(src)];act=view;id=[specific.identifier];index=1'>&lt;&lt;</a>"
			assembled += " <a href='?src=[ref(src)];act=view;id=[specific.identifier];index=[index-1]'>&lt;</a>"
		assembled += "<a class='link-on' href='?src=[ref(src)];act=view;id=[specific.identifier]'>[index]</a>"
		if(index < len)
			assembled += " <a href='?src=[ref(src)];act=view;id=[specific.identifier];index=[length(specific.instances)]'>&gt;&gt;</a>"
			assembled += " <a href='?src=[ref(src)];act=view;id=[specific.identifier];index=[index+1]'>&gt;</a>"
		assembled += "</span><br>"
		var/instance = specific.instances[index]
		assembled += "<h3>Runtime error in [specific.file] line [specific.line]: [specific.name]</h3>"
		assembled += "<div class='section'>[instance]</div>"
	else
		assembled += "[global.runtime_count] runtimes, [global.runtime_skipped] skipped.<br>"
		for(var/id in global.runtime_data)
			var/datum/error_data/runtime = global.runtime_data[id]
			assembled += "<a href='?src=[ref(src)];act=view;id=[runtime.identifier];index=1'>Runtime error in [runtime.file] line [runtime.line]: [runtime.name]</a><br>"
	browser.open(user, jointext(assembled, ""))

/datum/runtime_viewer/Topic(href, href_list)
	. = ..()
	if(.)
		return
	if(!allowed(usr))
		return
	var/action = href_list["act"]
	switch(action)
		if("view")
			var/id = href_list["id"]
			var/index = href_list["index"]
			if(isnull(index))
				index = input(usr, "Enter page number", "Seek to Runtime", 1) as num|null
				if(!index)
					return TRUE
			else if(index)
				index = text2num(index)
			show_to(usr, global.runtime_data[id], index)
			return TRUE
		if("main")
			show_to(usr)
			return TRUE

/datum/runtime_viewer/proc/allowed(mob/user)
	if(!user)
		return FALSE
	var/client/C = istype(user, /client)? user : user.client
	return is_admin(C) || is_dev(user)
