extends Node

@export var time_multiplier: float

func _ready():
	if not get_parent().is_node_ready(): await get_parent().ready
	get_parent().life_timer.wait_time *= time_multiplier
	get_parent().life_timer.start()
	

