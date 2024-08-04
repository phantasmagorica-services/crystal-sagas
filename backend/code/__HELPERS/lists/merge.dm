/**
 * merge 1-deep assoc lists; from_list overwrites into_list
 *
 * * this will break horribly with nested lists due to not handling references!
 */
/proc/merge_assoc_list(list/into_list, list/from_list)
	return merge_assoc_list_inplace(into_list.Copy(), from_list)

/**
 * merge 1-deep assoc lists; from_list overwrites into_list
 *
 * * this will break horribly with nested lists due to not handling references!
 */
/proc/merge_assoc_list_inplace(list/into_list, list/from_list)
	. = into_list
	for(var/key in from_list)
		.[key] = from_list[key]
