class_name Player extends CharacterBody3D

@onready var input_component: InputComponent = %InputComponent
@onready var movement_component: MovementComponent = %MovementComponent
@onready var health_component: HealthComponent = %HealthComponent

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	input_component.update()
	
	movement_component.direction = input_component.move_dir
	movement_component.wants_jump = input_component.jump_pressed
	movement_component.tick(delta)
	
