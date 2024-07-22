extends Node

var last_direction: Vector3 = Vector3.RIGHT

func get_input_direction():
	return Input.get_vector("movement_left", "movement_right", "movement_up", "movement_down")

func get_direction():
	var direction = -Vector3(-get_input_direction().y, 0, get_input_direction().x)
	if direction.length() != 0:
		last_direction = direction
	return direction

func get_last_direction():
	return last_direction
