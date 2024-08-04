#define TGS_EXTERNAL_CONFIGURATION
#define TGS_DEFINE_AND_SET_GLOBAL(Name, Value) LEGACY_GLOBAL_VAR_INIT(Name, Value)
#define TGS_READ_GLOBAL(Name) global.##Name
#define TGS_WRITE_GLOBAL(Name, Value) global.##Name = Value
#define TGS_PROTECT_DATUM(Path)
#define TGS_WORLD_ANNOUNCE(message) world.send_chat(message)
#define TGS_NOTIFY_ADMINS(event) world.send_chat(event)
#define TGS_INFO_LOG(message) tgs_info_log(message)
#define TGS_WARNING_LOG(message) tgs_warning_log(message)
#define TGS_ERROR_LOG(message) tgs_error_log(message)
#define TGS_CLIENT_COUNT length(global.clients)
