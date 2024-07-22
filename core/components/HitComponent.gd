class_name HitComponent extends Area3D

var exeptions_bodies: Array = []

@export var hurt_on_enter: bool = true
@export var hurt_value: int

signal hitted

func _ready():
	if multiplayer.is_server():
		area_entered.connect(hit)

@rpc("call_remote", "reliable", "any_peer") 
func hit(area, is_remote = false, path = ""):
	#if multiplayer.is_server(): hit.rpc(area, true, area.get_path())
	if is_remote: area = get_node(path)
	if area is HurtComponent and not exeptions_bodies.has(area.get_parent()):
		area.hurt(hurt_value)
		hitted.emit()
