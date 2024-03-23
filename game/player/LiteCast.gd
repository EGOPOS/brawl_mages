extends State

func enter(object: Object, state_machine: StateMachine):
	super(object, state_machine)
	state_machine.animation_component.play("lite_cast")

func update(delta: float):
	object.velocity = lerp(object.velocity, Vector3(), state_machine.movement_friction * delta)
	object.move_and_slide()
	
	if not state_machine.animation_component.is_playing():
		try_transition.bind("Idle").call()

func exit():
	pass


func try_transition(state: String):
	state_machine.transition_to(state)
