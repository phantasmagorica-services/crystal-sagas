/**
 * register to event signals on another datum
 *
 * @params
 * * target - what to register with
 * * sigtype - signal type define
 * * procpath - proc to call on self
 */
/datum/proc/register_signal(datum/target, sigtype, procpath)
	ASSERT(istext(sigtype))
	ASSERT(hascall(src, procpath))
	LAZYLIST_INIT(target.signals_lookup)
	LAZYLIST_INIT(target.signals_lookup[sigtype])
	if(target.signals_lookup[sigtype][src])
		stack_trace("overwriting [sigtype] on [target.type]; this is bad practice")
	target.signals_lookup[sigtype][src] = procpath
	LAZYLIST_INIT(signals_hooked)
	LAZYLIST_INIT(signals_hooked[target])
	signals_hooked[target] |= sigtype

/**
 * unregister from event signals on another datum
 *
 * @params
 * * target - what to unregister from
 * * sigtype - signal type define or list of signal type defines
 */
/datum/proc/unregister_signal(datum/target, list/sigtype)
	if(islist(sigtype))
		for(var/sig as anything in sigtype)
			unregister_signal(target, sigtype)
		return
	if(signals_hooked?[target])
		signals_hooked[target] -= sigtype
		if(!length(signals_hooked[target]))
			signals_hooked -= target
			if(!length(signals_hooked))
				signals_hooked = null
	if(target.signals_lookup?[sigtype])
		target.signals_lookup[sigtype] -= src
		if(!length(target.signals_lookup[sigtype]))
			target.signals_lookup -= sigtype
			if(!length(target.signals_lookup))
				target.signals_lookup = null

/**
 * cleans up our signals
 */
/datum/proc/cleanup_signals()
	for(var/datum/D as anything in signals_hooked)
		unregister_signal(D, signals_hooked[D])
	for(var/sig as anything in signals_lookup)
		var/list/datums = signals_lookup[sig]
		for(var/datum/D as anything in datums)
			D.unregister_signal(src, sig)

/**
 * raise signal
 *
 * signal handlers will be called with (raising, ...) where raising is just us, and ... are additional args provided for the signal.
 */
/datum/proc/raise_signal(sigtype, ...)
	var/list/datums = signals_lookup?[sigtype]
	if(!datums)
		return
	var/list/argv = args.Copy(2)
	argv.Insert(1, src)
	for(var/datum/D as anything in datums)
		var/proctype = datums[D]
		call(D, proctype)(arglist(argv))
