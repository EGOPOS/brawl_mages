extends Node3D

var direction: Vector3
@onready var life_timer = $Timer
@onready var cpu_particles_2d = $SubViewport/Node2D/CPUParticles2D
@onready var cpu_particles_2d_2 = $SubViewport/Node2D/CPUParticles2D2

@onready var hit_component = $HitComponent

func  _ready():
	life_timer.start()
	life_timer.timeout.connect(destroy)
	hit_component.area_entered.connect(destroy)
	hit_component.body_entered.connect(destroy)

func _process(delta):
	position += direction * delta * 5
	cpu_particles_2d.gravity.x = direction.z * 100
	cpu_particles_2d_2.gravity.x = direction.z * 100
	
func destroy(a):
	hit_component.set_deferred("monitoring", false)
	
	cpu_particles_2d.emitting = false
	cpu_particles_2d_2.emitting = false
	direction = Vector3()
	await get_tree().create_timer(2.0).timeout
	queue_free()
