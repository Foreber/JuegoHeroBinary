extends Node2D

onready var detector_pj = $Sprite/RayCast2D
onready var posiciones_rayos = $Sprite/Posiciones
onready var tiempo_disparo = $Timer
onready var sonido_rayo = $Rayos
var puede_disparar = true

export var rayo: PackedScene

func _process(_delta):
	if detector_pj.is_colliding() and puede_disparar:
		disparar()
		puede_disparar = false
		tiempo_disparo.start()

func disparar():
	sonido_rayo.play()
	for posicion in posiciones_rayos.get_children():
		var nuevo_rayo = rayo.instance()
		nuevo_rayo.crear(posicion.global_position)
		owner.get_node("ContenedorRayos").add_child(nuevo_rayo)

func _on_Timer_timeout():
	puede_disparar = true
