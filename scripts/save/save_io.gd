extends Node

const SAVEFILE := "user://savedata_1.json"

func write(data:Dictionary) -> void:
	var file = FileAccess.open(SAVEFILE,FileAccess.WRITE)
	if file == null:
		push_error("Failed to open: %s" % SAVEFILE)
		return
	file.store_string(JSON.stringify(data, "\t"))
	
func read():
	var file = FileAccess.open(SAVEFILE,FileAccess.READ)
	if file == null:
		push_error("Failed to open: %s" % SAVEFILE)
		return
	else:
		var savefile = JSON.parse_string(file.get_as_text())
		if typeof(savefile) != TYPE_DICTIONARY:
			return
		else:
			return savefile
