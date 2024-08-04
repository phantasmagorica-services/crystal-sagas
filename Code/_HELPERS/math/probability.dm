/**
 * roll NdS die.
 *
 * @params
 * * dice - number of dice to throw
 * * sides - how many sides from 1 to sides does each dice have
 *
 * @return combined result
 */
/proc/dice_roll(dice = 1, sides = 6)
	// todo: actual distribution PDF for efficiency at extreme nmbers
	// for now, enjoy a clamp
	ASSERT((dice >= 1) && (dice <= 100))
	. = 0
	for(var/i in 1 to dice)
		. += rand(1, sides)
