extends Node

@export var element: MagicResources.Elements

func _ready():
	if not get_parent().is_node_ready(): await get_parent().ready
	get_parent().set_element(element)
	get_parent().add_child(MagicResources.components_packed[MagicResources.Components.SPEED_UP].instantiate())
