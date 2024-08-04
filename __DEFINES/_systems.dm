/// system def
#define LEGACY_GLOBAL_SYSTEM_SINGLETON(_SYS, _GVAR)    \
var/global/datum/system/##_SYS/##_GVAR = -1;    \
/datum/system/##_SYS/New() {                    \
	if(global.##_GVAR != -1) {                  \
		Restore(global.##_GVAR);                \
	};                                          \
	global.##_GVAR = src;                       \
}                                               \
/datum/system/##_SYS

/// repository system def
#define LEGACY_GLOBAL_REPOSITORY_SINGLETON(_SYS, _GVAR)        \
var/global/datum/system/repository/##_SYS/##_GVAR = -1; \
/datum/system/repository/##_SYS/New() {                 \
	if(global.##_GVAR != -1) {                          \
		Restore(global.##_GVAR);                        \
	};                                                  \
	global.##_GVAR = src;                               \
}                                                       \
/datum/system/repository/##_SYS


