class_name Player extends CharacterBody3D

@onready var state_machine = $StateMachine
@onready var multiplayer_synchronizer = $MultiplayerSynchronizer
@export var target_position: Vector3 

@onready var attack_sprite = $Sprite3D2
@onready var base_sprite = $Sprite3D

func _enter_tree():
	set_multiplayer_authority(name.to_int())

func _ready():
	state_machine.set_process(false)
	await get_tree().create_timer(1.0).timeout
	state_machine.set_process(is_multiplayer_authority())
	#for peer in multiplayer.get_peers():
		#multiplayer_synchronizer.set_visibility_for(peer, true)
	
func _process(delta):
	if not is_multiplayer_authority():
		return
	
	target_position = global_position

func _on_multiplayer_synchronizer_synchronized():
	if not is_multiplayer_authority():
		get_tree().create_tween().tween_property(self, "position", target_position, .2).set_ease(Tween.EASE_IN_OUT)
		
@onready var projectiles = $Projectiles

func spawn_fireball():
	var new_fireball = preload("res://game/projectiles/fireball.tscn").instantiate()
	new_fireball.position = global_position
	new_fireball.direction = Vector3.BACK if base_sprite.flip_h else Vector3.FORWARD
	projectiles.add_child(new_fireball)
