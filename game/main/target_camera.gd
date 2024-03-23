extends Camera3D

@export var target: Node3D
@onready var started_position = global_position

func _process(delta):
	if target:
		global_position = lerp(global_position, target.global_position + started_position, delta * 8.0)
	else:
		global_position = lerp(global_position, started_position, delta * 8.0)
