

/// manual debug
#define WORLD_DEBUG_LINE world.send_chat("Executing: [__FILE__] L [__LINE__]")

/// block proc until
#define BLOCK_ON(_cond) while(!_cond) {sleep(1); };
