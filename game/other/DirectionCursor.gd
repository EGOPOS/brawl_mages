extends Node3D

@export var direction_component: Node
@onready var cursor = $CSGCombiner3D

func _process(delta):
	cursor.position = lerp(cursor.position, direction_component.get_last_direction() * 1.5, delta * 16)
	cursor.rotation.y = lerp(cursor.rotation.y, Vector2(direction_component.get_last_direction().x, -direction_component.get_last_direction().z).angle() - PI/4, delta * 16)
