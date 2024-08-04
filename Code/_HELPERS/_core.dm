/**
 * intentionally runtimes and creates a stack trace without terminating proc
 *
 * @params
 * * msg - what to display in the CRASH()
 */
/proc/stack_trace(msg)
	CRASH(msg)

/**
 * does nothing; useful as a debug hook or to shut up the compiler
 */
/proc/pass()
	return

/**
 * asynchronously invokes a proc
 * useful for situations where you cannot allow a calling proc to be blocked
 * called proc will break off from stack if so
 * be careful while using
 *
 * @params
 * * target - what to call on; null for global proc
 * * procpath - function to call
 * * ...rest - args to pass into the call
 */
/proc/async_call(target, procpath, ...)
	if(target)
		return call(target, procpath)(arglist(args.Copy(3)))
	return call(procpath)(arglist(args.Copy(3)))

/**
 * gets a ref or tag based on if the thing wants to use its tag
 */
/proc/ref_tag(datum/D)
	if(D.use_tag)
		ASSERT(D.tag)
		return D.tag
	return ref(D)
