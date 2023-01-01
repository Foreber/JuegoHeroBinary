extends Area2D

onready var detector_pj = $contraPj
onready var detectorSalto = $detectorSalto/pisotonSalto
onready var animacion = $Sprite/AnimationPlayer

func _on_detectorSalto_body_entered(body):
	desactivar_enemigo([detector_pj, detectorSalto])
	animacion.stop()
	animacion.play("morir")
	body.impulsar()


func _on_bolitaAzul_body_entered(body):
	body.respawn()

func desactivar_enemigo(colisionadores):
	for colision in colisionadores:
		colision.set_deferred("disabled", true)
		colision.set_deferred("visible", false)
