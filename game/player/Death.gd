extends State

func enter(object: Object, state_machine: StateMachine):
	super(object, state_machine)
	object.get_node("HurtComponent").set_deferred("monitorable", false)
	
	state_machine.animation_component.play("death")
	object.set_collision_layer_value(2, false)
	await state_machine.animation_component.animation_finished
	object.queue_free()

#func update(delta: float):
	#object.velocity = lerp(object.velocity, Vector3(), state_machine.movement_friction * delta)
	#object.move_and_slide()
	#
	#if not state_machine.animation_component.is_playing():
		#try_transition.bind("Idle").call()

func exit():
	object.get_node("HurtComponent").set_deferred("monitorable", true)
	object.set_collision_layer_value(2, true)
