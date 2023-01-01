extends Control

func _ready():
	$PanelPuntaje/Puntaje.text = "Puntaje: {puntos}".format({"puntos": DatosPj.generar_puntaje()})


func _on_Menu_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Game/Menus/MenuPrincipal.tscn")
