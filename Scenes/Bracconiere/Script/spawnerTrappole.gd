extends Node2D

@export var scena_trappola: PackedScene

var trappole_attive = []
var pattern_trappole = [
	[Vector2(100, 100), Vector2(200, 50), Vector2(300, 100), Vector2(250, 200), Vector2(150, 200)],  # Pentagono
	[Vector2(150, 150), Vector2(300, 150), Vector2(300, 300), Vector2(150, 300)],  # Quadrato
	[Vector2(100, 100), Vector2(250, 50), Vector2(400, 100), Vector2(350, 250), Vector2(150, 250), Vector2(50, 200)]  # Esagono
]

func genera_trappole():
	rimuovi_tutte_trappole()
	var pattern = pattern_trappole[randi() % pattern_trappole.size()]
	
	for pos in pattern:
		var trappola = scena_trappola.instantiate()
		trappola.position = pos
		trappola.trappola_eliminata.connect(_on_trappola_eliminata)
		add_child(trappola)
		trappole_attive.append(trappola)

func rimuovi_tutte_trappole():
	for trappola in trappole_attive:
		trappola.queue_free()
	trappole_attive.clear()

func get_numero_trappole():
	return trappole_attive.size()

func _on_trappola_eliminata(trappola):
	if trappola in trappole_attive:
		trappole_attive.erase(trappola)
		trappola.queue_free()
		get_parent().rimuovi_trappola()
