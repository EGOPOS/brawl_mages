extends Node


func _ready():
	if not get_parent().is_node_ready(): await get_parent().ready

func _process(delta):
	get_parent().direction = lerp(get_parent().direction, get_parent().spawner_mage.direction_component.get_last_direction(), delta * 2)

