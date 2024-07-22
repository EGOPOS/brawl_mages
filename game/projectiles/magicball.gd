class_name MagicProjectile extends Node3D

var speed: int  = 5
var direction: Vector3
@onready var life_timer = $Timer
@onready var trail_particle = $SubViewport/Node2D/CPUParticles2D
@onready var sphere_particle = $SubViewport/Node2D/CPUParticles2D2

@export var target_position: Vector3

@onready var hit_component = $HitComponent
var spawner_mage: Player:
	set(value):
		if not is_node_ready(): await ready
		spawner_mage = value
		hit_component.exeptions_bodies.append(spawner_mage)

@export var has_trail: bool = false:
	set(value):
		has_trail = value
		if not is_node_ready(): await ready
		trail_particle.emitting = has_trail

@export var has_sphere: bool = true:
	set(value):
		has_sphere = value
		if not is_node_ready(): await ready
		sphere_particle.emitting = has_sphere

func _enter_tree():
	await ready
	set_multiplayer_authority(spawner_mage.name.to_int())

func  _ready():
	life_timer.start()
	life_timer.timeout.connect(func(): destroy(null))
	hit_component.area_entered.connect(destroy)
	hit_component.body_entered.connect(destroy)
	set_element(MagicResources.Elements.NONE)

func _process(delta):
	#if not is_multiplayer_authority():
		#return
	
	target_position = global_position
	
	position += direction * delta * speed
	trail_particle.gravity.x = direction.z * 100

func destroy(a):
	hit_component.set_deferred("monitoring", false)
	sphere_particle.emitting = false
	trail_particle.emitting = false
	if a: direction = Vector3()
	await get_tree().create_timer(2.0).timeout
	queue_free()

func set_element(element: MagicResources.Elements):
	var element_gradient: Gradient
	match element:
		MagicResources.Elements.FIRE:
			element_gradient = preload("res://assets/elements/fire.tres")
			has_sphere = true
			has_trail = true
		MagicResources.Elements.ICE:
			element_gradient = preload("res://assets/elements/ice.tres")
			has_sphere = false
			has_trail = true
		MagicResources.Elements.THUNDER:
			element_gradient = preload("res://assets/elements/thunder.tres")
			has_trail = false
			has_sphere = true
		_:
			element_gradient = preload("res://assets/elements/mana.tres")
			has_trail = randi_range(0, 1)
	sphere_particle.color_ramp = element_gradient
	trail_particle.color_ramp = element_gradient

func _on_multiplayer_synchronizer_synchronized():
	if not is_multiplayer_authority():
		get_tree().create_tween().tween_property(self, "position", target_position, .2).set_ease(Tween.EASE_IN_OUT)
