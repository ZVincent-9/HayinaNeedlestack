class_name InputComponent extends Node

var move_dir: Vector2 = Vector2.ZERO
var jump_pressed := false

func update() -> void:
	move_dir = Input.get_vector("key_a","key_d","key_w", "key_s")
	jump_pressed = Input.is_action_just_pressed("key_space")
	
