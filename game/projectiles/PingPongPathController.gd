extends Node

func _ready():
	if not get_parent().is_node_ready(): await get_parent().ready
	get_parent().add_child(MagicResources.components_packed[MagicResources.Components.SPEED_UP].instantiate())
	await get_tree().create_timer(0.5).timeout
	change_direction()

@onready var target_direction: Vector3 = get_parent().direction

func _process(delta):
	get_parent().direction = lerp(get_parent().direction, target_direction, delta*4)

func change_direction():
	target_direction = -get_parent().direction
	await get_tree().create_timer(0.5).timeout
	change_direction()
