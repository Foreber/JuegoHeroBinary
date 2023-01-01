extends Area2D

var esta_activo = false
export var proximo_lvl = ""

func _on_body_entered(_body):
	if esta_activo:
		_body.play_ingreso_portal(global_position)
		yield(get_tree().create_timer(1.5), "timeout")
		cambiar_nivel()

func cambiar_nivel():
# warning-ignore:return_value_discarded
	get_tree().change_scene(proximo_lvl)

func play_animation():
	esta_activo = true
	$AnimatedSprite.play("default")
	$AnimationPlayer.play("activo")
	
