/**
 * capitalize a string
 */
/proc/capitalize(str)
	// todo: optimize
	return "[uppertext(copytext_char(str, 1, 2))][copytext_char(str, 2)]"
