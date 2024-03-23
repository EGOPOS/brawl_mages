extends Node3D


func _ready():
	_updpate_cards()
	var st = func(a): _updpate_cards()
	child_entered_tree.connect(st)
	child_exiting_tree.connect(st)

func _updpate_cards():
	var cards = get_children()#.filter(func(a): return a is MeshInstance3D)
	for i in range(cards.size()):
		cards[i].rotation.z = float(i - cards.size()/2) * cards.size() / 360.0
		cards[i].position.x = -abs(float(i - cards.size()/2)) * 1.4# * (-1 if float(i) > cards.size()/2.0 else 1)
		#cards[i].position.y = float((i - cards.size()/2)) / 10
		cards[i].position.z = float(-(i - cards.size()/2)) * 0.05
	#scale.x = 1/(cards.size() * 0.45)
	#scale.y = 1/(cards.size() * 0.45)
