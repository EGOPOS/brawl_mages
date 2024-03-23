extends Node

func _input(event):
	if Input.is_action_just_pressed("1_spell") and $SubViewport2/Node3D/CardContainer.get_child_count():
		$SubViewport2/Node3D/CardContainer.get_child(0).queue_free()
	elif Input.is_action_just_pressed("1_spell"):
		pass
		
@onready var players_container = $SubViewport/World/Players
@onready var spawn_points = $SubViewport/World/SpawnPoints

func spawn_player(id):
	var new_player = preload("res://game/player/player.tscn").instantiate()
	new_player.name = str(id)
	new_player.position = get_spawn_point().global_position
	new_player.target_position = new_player.position
	players_container.add_child(new_player)

func despawn_player(id):
	var player = players_container.get_node_or_null(str(id))
	if player:
		players_container.remove_child(player)
		player.queue_free()

func _on_multiplayer_spawner_spawned(node):
	node.position = get_spawn_point().global_position
	node.target_position = node.position

func get_spawn_point():
	return spawn_points.get_children()[multiplayer.get_peers().size()]

func _ready():
	Network.main_scene = self
	
	if multiplayer.is_server():
		spawn_player(1)
