extends State

func enter(object: Object, state_machine: StateMachine):
	super(object, state_machine)
	object.get_node("HurtComponent").set_deferred("monitorable", false)
	
	object.base_sprite.modulate.a = 0.5
	object.attack_sprite.modulate.a = 0.5
	await get_tree().create_timer(0.5).timeout
	try_transition("Idle")

func exit():
	object.get_node("HurtComponent").set_deferred("monitorable", true)
	object.attack_sprite.modulate.a = 1
	object.base_sprite.modulate.a = 1

func try_transition(state: String):
	state_machine.transition_to(state)
