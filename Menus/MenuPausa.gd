extends Control

func _ready():
	visible = false

func _input(event):
	if event.is_action_pressed("Pause"):
		visible = not visible
		get_tree().paused = not get_tree().paused

func _on_Continuar_pressed():
	get_tree().paused = false
	visible = false

func _on_Menu_pressed():
	get_tree().paused = false
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Game/Menus/MenuPrincipal.tscn")
