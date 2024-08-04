/// sleep current proc if tick is over a certain amount of usage
#define YIELD_FOR_TICK(tick_amount) if(world.tick_usage > tick_amount) sleep(world.tick_lag)
/// sleep current proc if lagging
#define YIELD_IF_LAGGING YIELD(80)

// todo: better tick logic
