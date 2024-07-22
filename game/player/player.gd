class_name Player extends CharacterBody3D

var cast_component:
	set(value):
		if not is_node_ready(): await ready
		cast_component = value

@onready var direction_component = $DirectionComponent
@onready var health_component = $HealthComponent
@onready var state_machine = $StateMachine
@onready var multiplayer_synchronizer = $MultiplayerSynchronizer
@export var target_arr: Array = [{
	"position": Vector3()
}, {"piska": 0}]

@onready var attack_sprite = $Sprite3D2
@onready var base_sprite = $Sprite3D

func _enter_tree():
	set_multiplayer_authority(name.to_int())

func _ready():
	state_machine.set_process(false)
	await get_tree().create_timer(1.0).timeout
	state_machine.set_process(is_multiplayer_authority())
	
	#if is_multiplayer_authority():
	health_component.health_changed.connect(func(value):
		if value > 0:
			state_machine.transition_to("Damage"))
	health_component.health_end.connect(func():
		state_machine.transition_to("Death"))
	#for peer in multiplayer.get_peers():
		#multiplayer_synchronizer.set_visibility_for(peer, true)
	
func _process(delta):
	if not is_multiplayer_authority():
		return
	
	target_arr[0]["position"] = global_position

func _on_multiplayer_synchronizer_synchronized():
	if not is_multiplayer_authority():
		get_tree().create_tween().tween_property(self, "position", target_arr[0]["position"], .2).set_ease(Tween.EASE_OUT_IN)
		
@onready var projectiles = $Projectiles

@rpc("call_remote")
func spawn_fireball(remote: bool = false, direction = direction_component.get_last_direction()):
	if is_multiplayer_authority():
		spawn_fireball.rpc(true, direction)
	elif not remote:
		return
	
	var new_fireball = preload("res://game/projectiles/fireball.tscn").instantiate()
	new_fireball.position = global_position + direction  * 1.5 #global_position + (Vector3.BACK if base_sprite.flip_h else Vector3.FORWARD) * 1.5
	new_fireball.direction = direction#Vector3.BACK if base_sprite.flip_h else Vector3.FORWARD
	#new_fireball.direction = Vector3.BACK if base_sprite.flip_h else Vector3.FORWARD
	projectiles.add_child(new_fireball)

@rpc("call_remote",  "reliable")
func spawn_magicball(remote: bool, direction = direction_component.get_last_direction(), components = cast_component.get_components(), _name: String = name):
	if is_multiplayer_authority():
		spawn_magicball.rpc(true, direction, components, name)
	elif not remote:
		return
	
	var new_magicball = preload("res://game/projectiles/magicball.tscn").instantiate()
	new_magicball.position = global_position + direction  * 1.5
	new_magicball.direction = direction
	new_magicball.spawner_mage = self
	if remote: new_magicball.name = _name
	projectiles.add_child(new_magicball)
	
	for component in components:
		var new_component = MagicResources.components_packed[component].instantiate()
		new_magicball.add_child(new_component)
