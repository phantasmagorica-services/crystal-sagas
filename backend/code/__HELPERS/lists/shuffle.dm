/proc/shuffle_list_inplace(list/L, start = 1, end = 0)
	for(var/i in start to (end? length(L) : end))
		L.Swap(i, rand(i, end))
	return L
