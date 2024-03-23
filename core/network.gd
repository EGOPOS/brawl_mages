extends Node

var peer: WebSocketMultiplayerPeer = WebSocketMultiplayerPeer.new()
var main_scene: Node

var port = 2235

func _ready():
	peer.peer_connected.connect(_im_here)
	peer.peer_disconnected.connect(_im_leave)

func join(address: String):
	var error = peer.create_client("ws://" + address + ":" + str(port))
	print_debug(error_string(error))
	multiplayer.multiplayer_peer = peer

func host():
	var error = peer.create_server(port)
	print_debug(error_string(error))
	multiplayer.multiplayer_peer = peer

#@rpc("any_peer")
func _im_here(id: int):
	print("im here: ", str(id))
	if multiplayer.is_server():
		main_scene.spawn_player(id)

func _im_leave(id):
	print("im leave: ", str(id))
	if multiplayer.is_server():
		main_scene.despawn_player(id)

func check_connection():
	if multiplayer.is_server():
		return ""
	return peer.get_connection_status()

#func _process(delta):
	#print(check_connection())
