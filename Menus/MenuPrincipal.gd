extends Control

func _ready():
	DatosPj.reset()
	
func _on_Iniciar_pressed():
	MusicaGlobal.replay()
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Game/Niveles/NivelTutorial.tscn")
