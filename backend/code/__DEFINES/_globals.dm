
#define GLOBAL_INTERNAL_INIT(NAME, VAL) \
/datum/controller/globals/proc/init_global_##NAME() { \
	src.##NAME = VAL; \
} \
/datum/controller/globals/global_init_procs() { \
	. = ..(); \
	. += TYPE_PROC_REF(/datum/controller/globals, init_global_##NAME); \
}

#define GLOBAL_VAR(NAME) \
/datum/controller/globals/var/##NAME;

#define GLOBAL_VAR_INIT(NAME, VAL) \
/datum/controller/globals/var/##NAME; \
GLOBAL_INTERNAL_INIT(NAME, VAL);

#define GLOBAL_LIST(NAME) \
/datum/controller/globals/var/list/##NAME;

#define GLOBAL_LIST_INIT(NAME, VAL) \
/datum/controller/globals/var/list/##NAME; \
GLOBAL_INTERNAL_INIT(NAME, VAL);

#define GLOBAL_LIST_EMPTY(NAME) \
/datum/controller/globals/var/list/##NAME; \
GLOBAL_INTERNAL_INIT(NAME, list());

#define GLOBAL_DATUM(NAME, PATH) \
/datum/controller/globals/var##PATH/##NAME;

#define GLOBAL_DATUM_INIT(NAME, PATH, VAL) \
/datum/controller/globals/var##PATH/##NAME; \
GLOBAL_INTERNAL_INIT(NAME, VAL);

#define GLOBAL_REAL_VAR(NAME) \
var/global/##NAME;

#define GLOBAL_REAL_LIST(NAME) \
var/global/list/##NAME;

#define GLOBAL_REAL_DATUM(NAME, PATH) \
var/global##PATH/##NAME;

//! Defined at top of compile order so no override, well, runtimes.
/datum/controller/globals/proc/global_init_procs()
	return list()
