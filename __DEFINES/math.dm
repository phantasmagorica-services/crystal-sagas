/// rounds num to *lowest* multiple of to_nearest. undefined behavior if to_nearest is negative.
#define FLOOR(num, to_nearest) (round(num / to_nearest) * to_nearest)
/// rounds num to *highest* multiple of to_nearest. undefined behavior if to_nearest is negative.
#define CEILING(num, to_nearest) (-round(-num / to_nearest) * to_nearest)
/// modulo operation but with decimal support
#define MODULUS(num, to_nearest) ( (num) - (to_nearest) * round((num) / (to_nearest)) )

#if DM_VERSION < 515
	#define CEILING1(N) CEILING(N, 1)
	#define FLOOR1(N) FLOOR(N, 1)
#else
	#define CEILING1(N) ceil(N)
	#define FLOOR1(N) floor(N)
#endif
