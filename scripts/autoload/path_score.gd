extends Node

var purity := 0
var corruption := 0
var usage_corrupt := 0
var usage_pure := 0

func do_choice(corrupt:bool, worth:int = 1) -> void:
	if worth < 1:
		return
	if corrupt:
		corruption += worth
	else:
		purity += worth
		
func kill_alignment(cp:int = 0, pp:int = 0) -> void: #CorruptPoints, PurePoints
	if cp > 0 and pp > -1:
		usage_corrupt += cp
	if pp > 0 and cp > -1:
		usage_pure += pp
		
func is_corrupted() -> bool:
	var choice = 0.0
	var use = 0.0
	var has_choices = false
	var has_usage = false
	if (corruption + purity) > 0:
		has_choices = true
		if corruption > 0 and purity > 0:
			choice = float(corruption) / (purity + corruption)
		elif corruption > 0:
			choice = 1.0
		else:
			choice = 0.0
	if (usage_corrupt + usage_pure) > 0:
		has_usage = true
		if usage_corrupt > 0 and usage_pure > 0:
			use = float(usage_corrupt) / (usage_pure + usage_corrupt)
		elif usage_corrupt > 0:
			use = 1.0
		else:
			use = 0.0
		
	if has_choices and has_usage:
		if (choice + use) / 2 < 0.5:
			return false
	elif has_choices:
		if choice < 0.5:
			return false
	elif has_usage:
		if use < 0.5:
			return false
	return true
