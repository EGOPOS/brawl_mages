extends CanvasLayer

@onready var winner_label = %WinnerLabel
@onready var animation_player = $AnimationPlayer
@onready var set_slots_containers = [%SetSlotsHBoxContainer, %SetSlotsHBoxContainer2]
@onready var deck_slots_container = $Control/PanelContainer3/MarginContainer/VBoxContainer/DeckSlotsHBoxContainer
@onready var components_choose_container = %ComponentsChooseHBoxContainer
@onready var components_choose = $Control/PanelContainer2

signal component_selected(component)

func _ready():
	for slot in components_choose_container.get_children():
		slot.get_node("Button").pressed.connect((func(slot):
			component_selected.emit(slot.component)).bind(slot))
	await get_tree().create_timer(0.1).timeout
	get_tree().current_scene.time_to_choose_component.connect(show_choose)

@rpc()
func show_winner(winner_name):
	if multiplayer.is_server():
		show_winner.rpc(winner_name)
	winner_label.text = winner_name
	animation_player.play("winner_animation")
	await animation_player.animation_finished

func show_choose():
	await animation_player.animation_finished
	components_choose.show()
	animation_player.play("choose_component")
	await get_tree().current_scene.time_to_end_choose_component
	animation_player.play_backwards("choose_component")
	components_choose.hide()
