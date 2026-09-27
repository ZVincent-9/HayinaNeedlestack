extends Node

const MAX_SCRAP := 1000
const SCRAP_TO_INGOT_RATIO := 10 #How many scraps to make 1 ingot
const PURIFY_RATIO := 2 #How many times more expensive pure is compared to corrupt
const PURIFY_AMOUNT := 10 #How many scrap to purify at once
const WEAPON_VAL := 3
const ARMOR_VAL := 1
var corrupted_scrap := 0
var purified_scrap := 0
var corrupt_ingots := 0
var pure_ingots := 0
#var fiendish_ingots := 0
#var blessed_ingots := 0
var unlocked_equipment := [
	{"type":"boots", "name":"work boots", "armor":1, "path":"", "sfx":[]},
 	{"type":"armor", "name":"basic clothing", "armor":0, "path":"", "sfx":[]}
]
var current_equipment := {
	"helmet" : "",
	"armor" : "basic clothing",
	"boots" : "work boots",
	"weapon" : ""
}

func add_scrap(num:int) -> void:
	corrupted_scrap = clampi(corrupted_scrap + num, 0, MAX_SCRAP)
	
func drop_raw_scrap() -> void:
	corrupted_scrap = 0
	
func purify_scrap(num:int = 1) -> bool:
	if num < 1:
		return false
	if corrupted_scrap < PURIFY_AMOUNT * num:
		return false
	corrupted_scrap -= PURIFY_AMOUNT * num
	@warning_ignore("integer_division")
	purified_scrap += (PURIFY_AMOUNT / PURIFY_RATIO) * num
	return true
	
func corrupt_press(num:int = 1) -> bool:
	if num < 1:
		return false
	if corrupted_scrap < SCRAP_TO_INGOT_RATIO * num:
		return false
	corrupted_scrap -= SCRAP_TO_INGOT_RATIO * num
	corrupt_ingots += num
	return true
	
func pure_press(num:int = 1) -> bool:
	if num < 1:
		return false
	if purified_scrap < SCRAP_TO_INGOT_RATIO * num:
		return false
	purified_scrap -= SCRAP_TO_INGOT_RATIO * num
	pure_ingots += num
	return true
	
func parse_paths() -> Dictionary:
	var pp = 0
	var cp = 0
	var worth = 0
	for slot in current_equipment:
		if !current_equipment[slot]:
			continue
		if slot == "weapon":
			worth = WEAPON_VAL
		else:
			worth = ARMOR_VAL
		for equipment in unlocked_equipment:
			if equipment["name"] == current_equipment[slot]:
				if equipment["path"] == "":
					continue
				elif equipment["path"] == "corrupt":
					cp += worth
				elif equipment["path"] == "pure":
					pp += worth
	return {"pp":pp, "cp":cp}
	
