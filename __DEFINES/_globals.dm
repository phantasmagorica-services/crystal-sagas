/**
 * defines for global variables
 *
 * please access global variables with `global.varname`
 */

/// defines untyped global
#define LEGACY_GLOBAL_VAR(__vname) var/global/##__vname
/// defines & inits untyped global
#define LEGACY_GLOBAL_VAR_INIT(__vname, __val) var/global/##__vname = ##__val
/// defines & inits untyped global without overwriting
#define LEGACY_GLOBAL_VAR_INIT_INPLACE(__vname, __val) var/global/##__vname = __global_init_##__vname(); /proc/__global_init_##__vname() { return (global.##__vname) || (##__val) }
/// defines typed global
#define LEGACY_GLOBAL_DATUM(__vname, __vtype) var/global##__vtype/##__vname
/// defines & inits typed global
#define LEGACY_GLOBAL_DATUM_INIT(__vname, __vtype, __val) var/global##__vtype/##__vname = ##__val
/// defines list global
#define LEGACY_GLOBAL_LIST_EMPTY(__vname) var/global/list/##__vname = list()
/// defines & inits list global
#define LEGACY_GLOBAL_LIST_INIT(__vname, __val) var/global/list/##__vname = ##__val
/// defines & inits list global without overwriting
#define LEGACY_GLOBAL_LIST_INIT_INPLACE(__vname, __val) var/global/list/##__vname = __global_init_##__vname(); /proc/__global_init_##__vname() { return (global.##__vname) || (##__val) }

/**
 * various more functional global list defines
 */

/// shoves something into list on new, and out on dispose  - *not* Del()
/// *Warning*: Beware of global init order. If another global inits before this, you'll have issues.
#define LEGACY_GLOBAL_LIST_BOILERPLATE(Name, Path)   \
var/global/list##Path/##Name = list();        \
##Path/New() {                                \
	. = ..();                                 \
	global.##Name += src;                     \
};                                            \
##Path/Destruct() {                           \
	global.##Name -= src;                     \
	return ..();                              \
};
