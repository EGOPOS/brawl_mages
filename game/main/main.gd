extends Node

func _input(event):
	if Input.is_action_just_pressed("1_spell") and $SubViewport2/Node3D/CardContainer.get_child_count():
		$SubViewport2/Node3D/CardContainer.get_child(0).queue_free()
	elif Input.is_action_just_pressed("1_spell"):
		pass

@onready var players_container = $SubViewport/World/Players
@onready var spawn_points = $SubViewport/World/SpawnPoints
@onready var cast_component = $SubViewport/World/CastComponent

signal time_to_choose_component
signal time_to_end_choose_component

func spawn_player(id):
	var new_player = preload("res://game/player/player.tscn").instantiate()
	new_player.name = str(id)
	new_player.position = get_spawn_point().global_position
	new_player.target_arr[0]["position"] = new_player.position
	#if id == multiplayer.get_unique_id():
	new_player.cast_component = cast_component
	players_container.add_child(new_player)

func despawn_player(id):
	var player = players_container.get_node_or_null(str(id))
	if player:
		players_container.remove_child(player)
		player.queue_free()

func _on_multiplayer_spawner_spawned(node):
	node.cast_component = cast_component
	node.position = get_spawn_point().global_position
	node.target_arr[0]["position"] = node.position

func get_spawn_point():
	return spawn_points.get_children()[max(players_container.get_child_count()-1, 0)]

func _ready():
	Network.main_scene = self
	if multiplayer.is_server():
		players_container.round_end.connect( func(winner: Player):
			await get_tree().get_root().get_node("UserInterface").get_node("Hud").show_winner(winner.name)
			reload_round())
		spawn_player(1)
	players_container.round_end.connect( func(winner: Player):
		var comps = get_3_random_components()
		for component in range(3):
			get_tree().get_root().get_node("UserInterface").get_node("Hud").components_choose_container.get_child(component).component = comps[component]
			time_to_choose_component.emit())

func reload_round():
	despawn_player(1)
	spawn_player(1)
	for peer in multiplayer.get_peers():
		despawn_player(peer)
		spawn_player(peer)

func get_3_random_components():
	var arr = MagicResources.components_packed.keys()
	arr.shuffle()
	return [arr[0], arr[1], arr[2]]
