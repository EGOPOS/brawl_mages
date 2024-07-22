extends Node

enum Components {FIRE, ICE, THUNDER, CURVED_PATH, PING_PONG_PATH, REMOTE_PATH, SPEED_UP, SPEED_DOWN, TIME_UP, TIME_DOWN, NONE}
var components_packed: Dictionary = {
	Components.FIRE: load("res://game/projectiles/fire_component.tscn"),
	Components.ICE: load("res://game/projectiles/ice_component.tscn"),
	Components.THUNDER: load("res://game/projectiles/thunder_component.tscn"),
	Components.CURVED_PATH: load("res://game/projectiles/curved_path_component.tscn"),
	Components.PING_PONG_PATH: load("res://game/projectiles/fire_component.tscn"),
	Components.REMOTE_PATH: load("res://game/projectiles/remote_control_component.tscn"),
	Components.SPEED_UP: load("res://game/projectiles/speed_up_component.tscn"),
	Components.SPEED_DOWN: load("res://game/projectiles/speed_down_component.tscn"),
	Components.TIME_UP: load("res://game/projectiles/time_up_component.tscn"),
	Components.TIME_DOWN: load("res://game/projectiles/time_down_component.tscn"),
}
enum Elements {FIRE, ICE, THUNDER, NONE}
