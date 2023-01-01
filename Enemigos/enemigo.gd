extends KinematicBody2D

export var velocidad = 200.0

var gravedad = 100.0
var movimiento = Vector2.ZERO

onready var animacion = $Caminando
onready var detector_caida = $RayCast2D
onready var detectar_colision = $EspacioPared


func _physics_process(_delta): 
	caer()
	caminar()
	
# warning-ignore:return_value_discarded
	move_and_slide(movimiento, Vector2.UP)

func caer():
	if not is_on_floor():
		movimiento.y = gravedad
		
func caminar():
	if not animacion.is_playing():
		animacion.play("correr")
		
	if not detector_caida.is_colliding():
			velocidad *= -1
			detector_caida.position *= -1
			animar(animacion.flip_h)
	movimiento.x = velocidad

func animar(valor_actual):
	animacion.flip_h = !valor_actual


func _on_Area2D_body_entered(body):
	body.respawn()
