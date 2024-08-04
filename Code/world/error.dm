LEGACY_GLOBAL_VAR_INIT_INPLACE(runtime_count, global.runtime_count || 0)
LEGACY_GLOBAL_VAR_INIT_INPLACE(runtime_skipped, global.runtime_skipped || 0)
LEGACY_GLOBAL_LIST_INIT_INPLACE(runtime_data, global.runtime_data || list())
LEGACY_GLOBAL_LIST_INIT_INPLACE(runtime_skipping, global.runtime_skipping || list())

#define RUNTIME_SKIP_TIME (5 MINUTES)
#define RUNTIME_SKIP_THRESHOLD 15
#define RUNTIME_MAX_TRACKING 50

/world/Error(exception/E)
	global.runtime_count = global.runtime_count + 1

	// weird non-exception runtime, log and exit
	if(!istype(E))
		// weird runtime
		log_error("Non-exception runtime: [E]")
		return ..()

	// stack overflow, send to log and exit
	if(copytext(E.name, 1, 32) == "Maximum recursion level reached")
		world.log << "!! STACK OVERFLOW !!\n[E.name]\n[E.desc]"
		return

	var/identifier = "[E.file]|[E.line]|[E.name]"
	var/skipping = FALSE
	var/dump_skip = FALSE

	// + = until then, 0 or below = amount so far
	if(global.runtime_skipping[identifier] > 0)
		if(global.runtime_skipping[identifier] > world.time)
			global.runtime_skipping[identifier] = 0
			dump_skip = TRUE
		else
			skipping = TRUE
	else
		global.runtime_skipping[identifier] = global.runtime_skipping[identifier] - 1
		if((-global.runtime_skipping[identifier]) > RUNTIME_SKIP_THRESHOLD)
			global.runtime_skipping[identifier] = world.time + RUNTIME_SKIP_TIME
			skipping = TRUE

	if(skipping)
		global.runtime_skipped = global.runtime_skipped + 1

	var/datum/error_data/entry = error_datum(identifier, E.name, E.file, E.line)

	if(entry.tracked >= RUNTIME_MAX_TRACKING)
		return	// don't bother, too many, we'll run out of memory.

	if(dump_skip)
		entry.dump_skip()

	if(skipping)
		++entry.skipped
	else
		++entry.tracked
		entry.log_exception(E)

/proc/error_datum(id, name, file, line)
	if(global.runtime_data[id])
		return global.runtime_data[id]
	var/datum/error_data/created = new(id, name, file, line)
	global.runtime_data[id] = created
	return created

/datum/error_data
	/// unique id generated from name and file
	var/identifier
	/// file
	var/file
	/// line
	var/line
	/// name
	var/name
	/// skipped count
	var/skipped = 0
	/// last skipped count
	var/last_skipped = 0
	/// tracked count
	var/tracked = 0
	/// list of stored data
	var/list/instances = list()

/datum/error_data/New(id, name, file, line)
	src.identifier = id
	src.file = file
	src.line = line
	src.name = name

/datum/error_data/proc/log_exception(exception/E)
	var/list/info = list()
	var/list/builtin = splittext(E.desc, "\n")
	for(var/line in builtin)
		// skip some inbuilt data, we just care about trace and some other stuff
		if(findtext(line, "usr:"))
			continue
		if(findtext(line, "usr.loc:"))
			continue
		if(findtext(line, "source file:"))
			continue
		// pad if needed
		if(copytext(line, 1, 3) != "  ")
			info += "  [line]"
		else
			info += "[line]"
	if(istype(usr))
		var/location
		var/turf/T
		if(isturf(usr.loc))
			location = "[usr.x], [usr.y], [usr.z]"
		else if(isnull(usr.loc))
			location = "nullspace"
		else if((T = get_turf(usr)))
			location = "turf: [usr.x], [usr.y], [usr.z], loc: [usr.loc] ([ref(usr.loc)] - [usr.loc.type])"
		info += "usr: [usr] / [usr.ckey] ([ref(usr)] - [usr.type]) ([location])"
	var/built = jointext(info, "\n")
	log_error("Runtime error in [file] line [line]: [name]\n" + built)
	instances += replacetext_char(html_encode(built), "\n", "<br>")

/datum/error_data/proc/dump_skip()
	var/amt = skipped - last_skipped
	if(!amt)
		return
	log_error("!! Skipped [amt] runtimes in [file] [line] !!")
	last_skipped = skipped

#undef RUNTIME_MAX_TRACKING
#undef RUNTIME_SKIP_THRESHOLD
#undef RUNTIME_SKIP_TIME
