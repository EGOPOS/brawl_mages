extends CanvasLayer

@onready var host_button = %HostButton
@onready var join_button = %JoinButton
@onready var address_edit = %AddressEdit

@onready var settings_button = %SettingsButton
@onready var exit_button = %ExitButton

@onready var settings = %Settings

@export var started_scene: String

func _ready():
	var start = func():
		get_tree().get_root().add_child(preload("res://game/userInterface/user_interface.tscn").instantiate())
		get_tree().change_scene_to_file(started_scene)

	host_button.pressed.connect(func():
		Network.host()
		start.call())
	join_button.pressed.connect(func():
		Network.join(address_edit.text)
		start.call())
	var settings = func():
		self.settings.visible = !self.settings.visible
	settings_button.pressed.connect(settings)
	exit_button.pressed.connect(get_tree().quit)

func _unhandled_input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		settings.visible = false
