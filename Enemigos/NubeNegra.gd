extends Node2D

onready var detector_pj = $Sprite/RayCast2D

export var rayo: PackedScene

func _process(delta):
	if detector_pj.is_colliding():
		disparar()

func disparar():
	var nuevo_rayo = rayo.instance()
	nuevo_rayo.crear($Sprite/PosicionRayo.global_position)
	add_child(nuevo_rayo)
