extends Node

@export var multiplier: float

func _ready():
	if not get_parent().is_node_ready(): await get_parent().ready
	get_parent().speed *= multiplier

