//* calls for writing logs

#define WRITE_LOG(fname, text) rustg_log_write(fname, text, "true")
#define WRITE_LOG_NO_FORMAT(fname, text) rustg_log_write(fname, text, "false")
