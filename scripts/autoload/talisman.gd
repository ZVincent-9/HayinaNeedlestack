extends Node

var given := false
var shattered := false

func give() -> void:
	given = true
	GameState.flags["talisman_given"] = true

func shatter() -> void:
	shattered = true
	GameState.flags["walkback"] = true
	
func can_warp() -> bool:
	return given and !shattered
	
	
func on_player_died() -> void:
	if !can_warp():
		return
	Inventory.drop_raw_scrap()
	GameState.save_game()
	#TODO: Scene change/respawn management
	
func to_dict() -> Dictionary:
	return {
		"given": given,
		"shattered": shattered
	}
	
func from_dict(data: Dictionary) -> void:
	given = data.get("given", given)
	shattered = data.get("shattered", shattered)
	
