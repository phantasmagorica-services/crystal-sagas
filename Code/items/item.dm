/obj/item
	//* new ability-attack system
	/// set this to the typepath of an attack ability or attack datum if you want a lazy-set attack (or attacks)
	var/tmp/list/attacks
	/// set this to list of typepaths of abilities
	//  todo: this does nothing yet
	var/tmp/list/abilities

	//* serialization
	/// if FALSE, we should reset to our typepath's stats as opposed to loading stats from disk
	var/modified = FALSE

	//* economy
	/// market value, aka default price of item
	//  todo: economy/worth system, static prices kind of suck
	var/market_value

// todo
