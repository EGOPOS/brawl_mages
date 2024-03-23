extends State

func enter(object: Object, state_machine: StateMachine):
	super(object, state_machine)
	state_machine.animation_component.play("idle")


func update(delta: float):
	var direction = state_machine.direction_component.get_direction()
	if direction != Vector3():
		try_transition("Run")
	object.velocity = lerp(object.velocity, Vector3(), state_machine.movement_friction * delta)
	object.move_and_slide()
	
	if Input.is_action_pressed("lite_spell"):
		try_transition("LiteCast")

func exit():
	pass


func try_transition(state: String):
	state_machine.transition_to(state)
