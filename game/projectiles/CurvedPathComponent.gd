extends Node

var start_time: float

func _ready():
	if not get_parent().is_node_ready(): await get_parent().ready
	get_parent().add_child(MagicResources.components_packed[MagicResources.Components.SPEED_UP].instantiate())
	start_time = Time.get_ticks_msec()

func _process(delta):
	get_parent().direction.x += sign(cos(Time.get_ticks_msec() - start_time)) * delta  * min(get_parent().speed, 5)
