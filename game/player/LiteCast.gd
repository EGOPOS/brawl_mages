extends State

func enter(object: Object, state_machine: StateMachine):
	super(object, state_machine)
	state_machine.animation_component.play("lite_cast")

func update(delta: float):
	var direction = object.direction_component.get_direction() # Для обновления last direction
	if direction.z != 0:
		object.get_node("Sprite3D").flip_h = direction.z > 0
		object.get_node("Sprite3D2").flip_h = direction.z > 0
	
	object.velocity = lerp(object.velocity, Vector3(), state_machine.movement_friction * delta)
	object.move_and_slide()
	
	if not state_machine.animation_component.is_playing():
		try_transition.bind("Idle").call()

func exit():
	pass


func try_transition(state: String):
	state_machine.transition_to(state)
