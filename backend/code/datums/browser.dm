/**
 * lightweight, non-state-synchronizing browser datum
 * quick and dirty allows you to show popups and whatnot
 */
/datum/browser
	/// window id
	var/window_id
	/// next auto id
	var/static/next_window_id = 0
	/// title
	var/title = "Browser"
	/// width
	var/width = 400
	/// height
	var/height = 600

/datum/browser/New(window_id, title, width, height)
	if(!isnull(window_id))
		src.window_id = window_id
	else
		src.window_id = "browser_[++src.next_window_id]"
	if(!isnull(title))
		src.title = title
	if(!isnull(width))
		src.width = width
	if(!isnull(height))
		src.height = height

/datum/browser/proc/open(mob/user, content)
	if(istype(user, /client))
		user = user:mob
	if(!window_id)
		CRASH("no window id")
	user << browse("[header()][body(content)][footer()]",
		"window=[window_id];size=[width]x[height]"
	)

/datum/browser/proc/close(mob/user)
	if(!window_id)
		CRASH("no window id")
	user << browse(null, "window=[window_id]")

/datum/browser/proc/header()
	var/list/additional_headers = list(
		"<title>[title]</title>",
	)
	// todo: stylesheets
	return \
	{"
	<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
	<html>
	<head>
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<meta http-equiv='X-UA-Compatible' content='IE=edge'>
		[jointext(additional_headers, "")]
	</head>
	<body scroll=auto>
	"}

/datum/browser/proc/body(content)
	return \
	{"
	[content]
	"}

/datum/browser/proc/footer()
	return \
	{"
	</body>
	</html>
	"}
