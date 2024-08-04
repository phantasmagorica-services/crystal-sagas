/**
 * splits byond view string or number to list(x, y)
 */
/proc/decode_view_size(vs)
	if(isnum(vs))
		return list(vs * 2 + 1, vs * 2 + 1)
	else if(istext(vs))
		. = splittext(vs, "x")
		ASSERT(length(.) == 2)
		.[1] = text2num(.[1])
		.[2] = text2num(.[2])
		ASSERT(isnum(.[1]) && isnum(.[2]))
	else
		CRASH("invalid: [vs]")

/**
 * encodes width/height into a byond view string or number
 */
/proc/encode_view_size(width, height)
	ASSERT(isnum(width) && isnum(height))
	return (width == height)? width : "[width]x[height]"
