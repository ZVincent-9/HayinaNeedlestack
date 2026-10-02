class_name MovementComponent extends Node

@export var body: CharacterBody3D
@export var model: Node3D
@export var speed:= 8.0
@export var jump_velocity:= 12.0
@export var gravity_mult:= 3.0
@onready var camera: Camera3D = $"../CameraAnchor/Camera3D"
@export var drag: float = 8.0
@export var ground_accel: float = 30
@export var air_accel: float = 15

var direction: Vector2 = Vector2.ZERO
var wants_jump := false
var CameraX : Vector3
var CameraZ : Vector3

func tick(delta: float) -> void:
	if body == null:
		return
	
	if direction.length_squared() > .001:
		CameraX = camera.global_transform.basis.x.slide(Vector3.UP).normalized()
		CameraZ = camera.global_transform.basis.z.slide(Vector3.UP).normalized()
		
		var CameraDir: Vector3 = (CameraX * direction.x) + (CameraZ * direction.y)
		
		var current_accel = ground_accel*delta if body.is_on_floor() else air_accel*delta
		body.velocity.x = move_toward(body.velocity.x, CameraDir.x * speed, current_accel)
		body.velocity.z = move_toward(body.velocity.z, CameraDir.z * speed, current_accel)
		
		if model:
			var look_dir := CameraDir.normalized()
			model.look_at(model.global_position + look_dir, Vector3.UP)
	else:
		var friction := speed * drag * delta if body.is_on_floor() else speed * (drag*.8) * delta
		body.velocity.x = move_toward(body.velocity.x, 0.0, friction)
		body.velocity.z = move_toward(body.velocity.z, 0.0, friction)
			
	if not body.is_on_floor():
		body.velocity += body.get_gravity() * delta * gravity_mult

	if wants_jump and body.is_on_floor():
		body.velocity.y = jump_velocity
	wants_jump = false

	body.move_and_slide()
