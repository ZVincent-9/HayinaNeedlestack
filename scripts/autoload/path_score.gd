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
