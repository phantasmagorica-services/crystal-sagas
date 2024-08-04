/client/AllowUpload(filename, filelength)
	if(filelength >= (1024 * 1024 * 10)) // 10MB tops
		send_chat("Rejecting upload of [filename] due to exceeding upload limit.")
		return FALSE
	log_world("FTP: [src] uploading [filename] with length of [filelength]")
	return TRUE
