extends KinematicBody2D

export var velocidad = Vector2(150.0, 150.0)
export var acel_caida = 400
export var fuerza_salto = 3000
export var fuerza_caida = 350
export var impulso = -5000
export var acel_caida_power_up = 60

var movimiento = Vector2.ZERO
var fuerza_salto_original 
var acel_caida_original
var puede_moverse = true

onready var animacion = $Animacion
onready var audio_salto = $SonidoSalto
onready var choque_caida = $SonidoCaida
onready var camera = $Camera2D
onready var CCPowerUP = $CCSuperSalto
onready var CCSuperVuelo = $CCSuperVuelo
onready var animacion_Hero = $AnimationPlayer



func _ready():
	animacion_Hero.play("aclarar")
	fuerza_salto_original = fuerza_salto
	acel_caida_original = acel_caida

func _physics_process(_delta):
	movimiento.x = velocidad.x * tomar_direccion()
	caer()
	saltar()
	colision_arriba()
	caida_al_vacio()
	
# warning-ignore:return_value_discarded
	move_and_slide(movimiento, Vector2.UP)

func tomar_direccion():
	var direccion = 0
	if puede_moverse:
		direccion = Input.get_action_strength("Derecha") - Input.get_action_strength("Izquierda")
		if direccion == 0:
			animacion.play("Quieto")
		else:
			if direccion < 0:
				animacion.flip_h = true
			else:
				animacion.flip_h = false
			animacion.play("Correr")
	return direccion

func caer():
		if not is_on_floor():
			animacion.play("Salto")
			movimiento.y += acel_caida
			movimiento.y = clamp(movimiento.y, impulso, velocidad.y)

func saltar():
		if Input.is_action_just_pressed("Saltar")  and is_on_floor() and puede_moverse:
			audio_salto.play()
			animacion.play("Salto")
			movimiento.y = 0
			movimiento.y -= fuerza_salto
			saltar_movimiento()

func saltar_movimiento():
	movimiento.y = 0
	movimiento.y -= fuerza_salto

func colision_arriba():
	if is_on_ceiling():
		movimiento.y = fuerza_caida

func volar():
	CCSuperVuelo.start()
	acel_caida = 45
	animacion_Hero.play("volar")
	saltar_movimiento()

func impulsar():
	movimiento.y = impulso
	
func cambiar_fuerza_salto():
	CCPowerUP.start()
	fuerza_salto = -impulso * 1

func caida_al_vacio():
	if position.y > camera.limit_bottom:
		respawn()

func respawn():
	DatosPj.restar_vidas()
	animacion_Hero.play("oscurecer")
	if DatosPj.vidas >= 1:
# warning-ignore:return_value_discarded
		get_tree().reload_current_scene()

func _on_CCPowerUP_timeout():
	fuerza_salto = fuerza_salto_original

func _on_CCSuperVuelo_timeout():
	animacion_Hero.play("default")
	acel_caida = acel_caida_original
	
func play_ingreso_portal(posicion_portal):
	puede_moverse = false
	animacion_Hero.play("ingreso")
	$Tween.interpolate_property(
		self,
		"global_position",
		global_position,
		posicion_portal,
		1,
		Tween.TRANS_LINEAR,
		Tween.EASE_OUT_IN
	)
	$Tween.start()

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "ingreso_portal":
		animacion_Hero.play("oscurecer")
