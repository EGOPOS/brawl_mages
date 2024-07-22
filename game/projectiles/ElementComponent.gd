extends Node

@export var element: MagicResources.Elements

func _ready():
	if not get_parent().is_node_ready(): await get_parent().ready
	get_parent().set_element(element)
