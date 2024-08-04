//* Controller definition helpers

// todo: auto-recover / New() handling, but for now it isn't done, because if a controller
//       somehow goes missing, you got way bigger issues.
#define CONTROLLER_DEF(NAME, NAMEOF) \
var/global/datum/controller/##NAME/##NAMEOF; \
/datum/controller/##NAME

/*
#define SUBSYSTEM_DEF(NAME) \
var/global/datum/controller/subsystem/##NAME/SS##NAME; \
/datum/controller/subsystem/##NAME

#define REPOSITORY_DEF(NAME) \
var/global/datum/controller/repository/##NAME/RS##NAME; \
/datum/controller/repository/##NAME

#define ENTITYMAP_DEF(NAME) \
var/global/datum/controller/entitymap/##NAME/ES##NAME; \
/datum/controller/entitymap/##NAME

#warn impl
*/

//* /datum/controller/subsystem/var/subsystem_flags

/// interval measured in ticks, has higher priority bracket than normal
#define SS_TICKER (1<<0)
/// has lower priority bracket than normal
#define SS_BACKGROUND (1<<1)
/// does not fire
#define SS_NO_FIRE (1<<2)
/// does not initialize
#define SS_NO_INIT (1<<3)
/// apply wait immediatley on firing, rather than only after a non-paused run.
#define SS_KEEP_TIMING (1<<4)
/// do not run whenever able to, if currently paused, instead wait for next interval
#define SS_ENFORCE_INTERVAL (1<<5)

DEFINE_BITFIELD(subsystem_flags, list(
	/datum/controller/subsystem = list(
		"subsystem_flags",
	),
), list(
	BITFIELD("Ticker", SS_TICKER),
	BITFIELD("Background", SS_BACKGROUND),
	BITFIELD("No Fire", SS_NO_FIRE),
	BITFIELD("No Init", SS_NO_INIT),
	BITFIELD("Keep Timing", SS_KEEP_TIMING),
	BITFIELD("Enforce Interval", SS_ENFORCE_INTERVAL),
))

//* /datum/controller/subsystem/var/runlevels

/// run during init
#define SS_RUNLEVEL_INIT (1<<0)
/// run during game simulation
#define SS_RUNLEVEL_GAME (1<<1)

DEFINE_BITFIELD(subsystem_runlevels, list(
	/datum/controller/subsystem = list(
		"runlevels",
	),
	/datum/controller/ticker = list(
		"runlevels",
	),
), list(
	BITFIELD("Init", SS_RUNLEVEL_INIT),
	BITFIELD("Main", SS_RUNLEVEL_GAME),
))

//* Subsystem init priorities - lower is higher

#define INIT_ORDER_DEFAULT 0

//* Subsystem tick priorities - higher is higher

//? TICKER SUBSYSTEMS ?//

// none yet

//? NORMAL SUBSYSTEMS ?//

#define FIRE_PRIORITY_DEFAULT 0
#define FIRE_PRIORITY_TGUI 100

//? BACKGROUND SUBSYSTEMS ?//

// none yet

//* /datum/controller/subsystem/var/initialized

#define SS_INIT_NOT_STARTED 0
#define SS_INIT_IN_PROGRESS 1
#define SS_INIT_FINISHED 2

//* /datum/controller/subsystem/proc/initialize() retvals

#define SS_INIT_SUCCESS 0
#define SS_INIT_FAILED 1

//* /datum/controller/subsystem/proc/shutdown() retvals

#define SS_SHUTDOWN_SUCCESS 0
#define SS_SHUTDOWN_FAILED 1

//* /datum/controller/subsystem/proc/recover() retvals

#define SS_RECOVER_SUCCESS 0
#define SS_RECOVER_FAILED 1
#define SS_RECOVER_IGNORED 2

//* /datum/controller/subsystem/var/status

/// doing nothing
#define SS_IDLE " "
/// subsystem igniting - you shouldn't see this on any UI
#define SS_IGNITING "I"
/// this is the one running right now
#define SS_FIRING "R"
/// something is sleep()ing - not good
#define SS_SLEEPING "S"
/// paused due to tick usage
#define SS_PAUSED "P"
/// pausing for an amount of time
#define SS_POSTPONED "W"

//* Helpers

/*

/// use during subsystem fire() call chain - returns if we should yield
#define SS_SHOULD_YIELD prob(2)
#warn impl
/// automatically yields ; do if(SS_AUTO_YIELD): return in fire().
#define SS_AUTO_YIELD (SS_SHOULD_YIELD? pause() : FALSE)

*/
