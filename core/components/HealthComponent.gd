extends Node

@export var max_health: int
@onready var health: int = max_health

signal health_changed(value)
signal health_end

func damage(value):
	if not health: # Шоб лишние сигналы не отправлял
		return
	
	health -= value
	health = max(health, 0)
	if health:
		health_changed.emit(value)
	else:
		health_end.emit()
