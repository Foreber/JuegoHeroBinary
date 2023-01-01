extends Node
signal actualizar_datos()
signal game_over()

var vidas = 3
var moneda_especial = 0
var llaves = 0
var nivel_actual = ""
var puntaje = 0


func reset():
	vidas = 3
	moneda_especial = 0

func generar_puntaje():
	var valor_moneda_especial = moneda_especial * 5
	puntaje = valor_moneda_especial
	return puntaje


func restar_vidas():
	vidas -= 1
	if vidas == 0:
		emit_signal("game_over")


	emit_signal("actualizar_datos")
	
func restar_llaves():
	llaves -=1
	emit_signal("actualizar_datos")
	
func contabilizar_llaves(valor):
	llaves = valor
	emit_signal("actualizar_datos")

func sumar_monedas(moneda):
	match moneda:
		"especial":
			moneda_especial += 1
		_:
			print("Error")
	emit_signal("actualizar_datos")
