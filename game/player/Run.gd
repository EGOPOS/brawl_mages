extends State

func enter(object: Object, state_machine: StateMachine):
	super(object, state_machine)
	state_machine.animation_component.play("run")


func update(delta: float):
	var direction = state_machine.direction_component.get_direction()
	if direction == Vector3():
		try_transition("Idle")
		return
	object.velocity = lerp(object.velocity, state_machine.movement_speed * direction, state_machine.movement_acceleration * delta)
	if direction.z != 0:
		object.get_node("Sprite3D").flip_h = direction.z > 0
		object.get_node("Sprite3D2").flip_h = direction.z > 0
	object.move_and_slide()
	
	if Input.is_action_pressed("lite_spell"):
		try_transition("LiteCast")


func exit():
	pass


func try_transition(state: String):
	state_machine.transition_to(state)
