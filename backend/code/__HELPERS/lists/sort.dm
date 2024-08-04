#define INSERTION_SORT_HEURISTIC 8

// todo: this is shit lol

/**
 * BYOND-adapted timsort algorithm with arbitrary comparator procs
 *
 * todo: this needs optimization
 */
/proc/sort_list_inplace(list/L, cmp = /proc/cmp_text_asc, associative = FALSE, start = 1, end = 0)
	if(start == end)
		return L

	// get list size
	var/size = length(L)
	// ughh list of lists
	var/list/merging = list()
	// sort everything on the intervals
	for(var/cycle in 1 to CEILING1(size / INSERTION_SORT_HEURISTIC))
		var/low = (cycle - 1) * INSERTION_SORT_HEURISTIC + 1
		var/high = min(cycle * INSERTION_SORT_HEURISTIC, size)
		insertion_sort_inplace(L, cmp, associative, low, high)
		merging[++merging.len] = L.Copy(low, high + 1)
	while(length(merging) > 1)
		var/list/next = list()
		for(var/i in 1 to length(merging) step 2)
			next[++next.len] = merge_sorted_lists(merging[i], merging[i+1], cmp, associative)
		merging = next
	return merging[1]


/**
 * * works with associative lists
 */
/proc/insertion_sort_inplace(list/L, cmp = /proc/cmp_text_asc, associative = FALSE, start = 1, end = 0)
	if(start == end)
		return L
	if(associative)
		for(var/i in start + 1 to end? length(L) : end)
			for(var/j in i to 2 step -1)
				if(call(cmp)(L[L[j]], L[L[j-1]]) < 0)
					L.Swap(j, j-1)
	else
		for(var/i in start + 1 to end? length(L) : end)
			for(var/j in i to 2 step -1)
				if(call(cmp)(L[j], L[j-1]) < 0)
					L.Swap(j, j-1)
	return L

/**
 * L2 is merged into L1, both are assumed sorted as per cmp proc
 *
 * We also assume that neither list is empty.
 *
 * todo: this needs optimization
 *
 * * works with associative lists
 */
/proc/merge_sorted_lists(list/L1, list/L2, cmp = /proc/cmp_text_asc, associative = FALSE)
	// left index
	var/l_i = 1
	// right index
	var/r_i = 1
	// get sizes
	var/l1_size = length(L1)
	var/l2_size = length(L2)
	// new list, prealloc
	. = list()

	if(associative)
		while(l_i < l1_size && r_i <= l2_size)
			if(call(cmp)(L1[L1[l_i]], L2[L2[r_i]]) < 0)
				.[L1[l_i]] = L1[L1[l_i]]
				l_i++
			else
				.[L2[r_i]] = L2[L2[r_i]]
				r_i++
	else
		while(l_i < l1_size && r_i <= l2_size)
			if(call(cmp)(L1[l_i], L2[r_i]) < 0)
				.[L1[l_i]] = L1[L1[l_i]]
				l_i++
			else
				.[L2[r_i]] = L2[L2[r_i]]
				r_i++

	if(length(L1))
		. += L1
	else if(length(L2))
		. += L2

#undef INSERTION_SORT_HEURISTIC
