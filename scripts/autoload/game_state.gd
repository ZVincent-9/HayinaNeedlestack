extends Node

const VERSION := 1
var twin := "Samothy"
var flags := {
	"opening_done": false,
	"talisman_given": false,
	"walkback": false,
}
var location := {
	"tier": "farm",
	"spawn": "wake"
}

func to_dict() -> Dictionary:
	var dict = {
		"VERSION": VERSION,
		"twin": twin,
		"flags": flags.duplicate(true),
		"location":location.duplicate(true),
		"inventory": Inventory.to_dict(),
		"path":PathScore.to_dict(),
		"talisman":Talisman.to_dict()
	}
	
	return dict

func save_game() -> void:
	SaveIO.write(to_dict())

func from_dict(data: Dictionary) -> void:
	twin = data.get("twin", "Samothy")
	flags = data.get("flags", flags).duplicate(true)
	location = data.get("location", location).duplicate(true)
	if "inventory" in data:
		Inventory.from_dict(data["inventory"])
	if "path" in data:
		PathScore.from_dict(data["path"])
	if "talisman" in data:
		Talisman.from_dict(data["talisman"])
		
		
		
func load_game() -> bool:
	var data = SaveIO.read()
	if typeof(data) == TYPE_DICTIONARY:
		from_dict(data)
		return true
	else:
		return false
		
func respawn() -> void:
	if flags.get("walkback", false):
		return
	save_game()
	#TODO make scenes + scene change
