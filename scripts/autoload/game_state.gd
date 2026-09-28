extends Node

const VERSION := 1
var twin := "Samothy"
var flags := {
	"opening_done": false,
	"talisman_given": false,
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
		"path":PathScore.to_dict()
	}
	
	return dict

func save_game() -> void:
	SaveIO.write(to_dict())
