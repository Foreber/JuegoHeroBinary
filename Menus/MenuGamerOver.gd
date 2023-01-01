extends Control

var nivel_actual = ""

func _ready():
	nivel_actual = DatosPj.nivel_actual
	DatosPj.reset()

func _on_Menu_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Game/Menus/MenuPrincipal.tscn")

func _on_Iniciar_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene(nivel_actual)
