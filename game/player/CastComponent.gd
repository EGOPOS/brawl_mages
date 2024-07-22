class_name CastComponent extends Node

var deck: Array:
	set(value):
		deck = value
		var hud = get_tree().get_root().get_node("UserInterface").get_node("Hud")
		for slot in range(hud.deck_slots_container.get_child_count()):
			hud.deck_slots_container.get_child(slot).component = deck[slot]
		
var max_deck_size: int = 5
var components_sets: = [[], []]

var max_set_size: int = 4
var current_set: bool = false

var Components = MagicResources.Components
var components_packed = MagicResources.components_packed

var is_component_time: bool = false
var choosed_component = null:
	set(value):
		choosed_component = value

func _ready():
	deck = [Components.FIRE, Components.ICE, Components.THUNDER, Components.CURVED_PATH, Components.REMOTE_PATH]
	deck = [Components.NONE, Components.NONE, Components.NONE, Components.NONE, Components.NONE]
	var hud = get_tree().get_root().get_node("UserInterface").get_node("Hud")
	hud.component_selected.connect(func(component):
		choosed_component = component
		prints("comp:", choosed_component))
	get_tree().current_scene.time_to_choose_component.connect(func(): is_component_time = true)

func _process(delta):
	if Input.is_action_just_pressed("switch_spell"):
		current_set = !current_set
	
	var component_index: int = 0
	if Input.is_action_just_pressed("1_spell"):
		component_index = 1
	elif Input.is_action_just_pressed("2_spell"):
		component_index = 2
	elif Input.is_action_just_pressed("3_spell"):
		component_index = 3
	elif Input.is_action_just_pressed("4_spell"):
		component_index = 4
	elif Input.is_action_just_pressed("5_spell"):
		component_index = 5
		
	if component_index and  choosed_component != null:
		deck[component_index-1] = choosed_component
		is_component_time = false
		get_tree().current_scene.time_to_end_choose_component.emit()
		choosed_component = null
		_update_ui_set_slots()
		return

	if component_index and deck.size() >= component_index:
		if get_current_set_size() == max_set_size:
			components_sets[int(current_set)].clear()
			_update_ui_set_slots()
			return
		add_component_to_set(component_index-1)
		_update_ui_set_slots()

func add_component_to_set(index):
	if deck[index] != Components.NONE:
		components_sets[int(current_set)].append(deck[index])

func get_current_set_size():
	return components_sets[int(current_set)].size()

func get_components():
	return components_sets[int(current_set)].filter(func(a): return a != Components.NONE)

func _update_ui_set_slots():
	var hud = get_tree().get_root().get_node("UserInterface").get_node("Hud")
	for slot in range(hud.set_slots_containers[int(current_set)].get_child_count()):
		hud.set_slots_containers[int(current_set)].get_child(slot).component = components_sets[int(current_set)][slot] if components_sets[int(current_set)].size() >= slot+1 else Components.NONE
		
	for slot in range(max_deck_size):
		hud.deck_slots_container.get_child(slot).component = deck[slot]
