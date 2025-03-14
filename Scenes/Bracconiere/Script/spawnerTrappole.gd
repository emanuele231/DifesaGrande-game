extends Node2D

@export var scena_trappola: PackedScene

var trappole_attive = []
var pattern_trappole = [
	[Vector2(112, 112), Vector2(540, 112), Vector2(540,510), Vector2(112, 510), Vector2(322, 260)],  
	[Vector2(330, 300), Vector2(112,300), Vector2(540, 112), Vector2(330,112), Vector2(540, 510)], 
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
