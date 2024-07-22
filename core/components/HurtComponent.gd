class_name HurtComponent extends Area3D

@export var transmit_hurt_to: Node
@export var transmit_hurt_method: String

func hurt(value):
	transmit_hurt_to.callv(transmit_hurt_method, [value])
