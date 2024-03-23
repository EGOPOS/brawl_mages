extends Area3D

var direction: Vector3
@onready var life_timer = $Timer
@onready var cpu_particles_2d = $SubViewport/Node2D/CPUParticles2D
@onready var cpu_particles_2d_2 = $SubViewport/Node2D/CPUParticles2D2

func  _ready():
	life_timer.start()
	life_timer.timeout.connect(queue_free)
	body_entered.connect(func(a):
		cpu_particles_2d.emitting = false
		cpu_particles_2d_2.emitting = false
		direction = Vector3()
		await get_tree().create_timer(2.0).timeout
		queue_free())

func _process(delta):
	position += direction * delta * 5
	cpu_particles_2d.gravity.x = direction.z * 100
	cpu_particles_2d_2.gravity.x = direction.z * 100
