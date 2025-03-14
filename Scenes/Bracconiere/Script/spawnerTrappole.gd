extends Node2D

@export var scena_trappola: PackedScene

var trappole_attive = []
var pattern_trappole = [
	# M
	[Vector2(112, 112), Vector2(540, 112), Vector2(540,510), Vector2(112, 510), Vector2(322, 260)],  

	# M
	[Vector2(130, 500), Vector2(200, 200), Vector2(330, 400), Vector2(460, 200), Vector2(530, 500)],

	# A
	[Vector2(200, 500), Vector2(320, 200), Vector2(440, 500), Vector2(270, 350), Vector2(370, 350)],    

	# Linea diagonale dall'angolo in basso a sinistra a quello in alto a destra
	[Vector2(100, 500), Vector2(200, 400), Vector2(300, 300), Vector2(400, 200), Vector2(500, 100)],    

	# Croce (una trappola centrale e quattro attorno)
	[Vector2(320, 150), Vector2(320, 450), Vector2(200, 300), Vector2(440, 300)],  

	# Triangolo con vertice in alto
	[Vector2(200, 450), Vector2(440, 450), Vector2(320, 200)],

	# Posizionamento sparso senza schemi particolari
	[Vector2(150, 150), Vector2(500, 100), Vector2(220, 370), Vector2(420, 470), Vector2(330, 260)],  

	# Denso a sinistra dello schermo
	[Vector2(100, 200), Vector2(130, 270), Vector2(180, 350), Vector2(160, 420), Vector2(140, 500)],  

	# Denso a destra dello schermo
	[Vector2(500, 200), Vector2(530, 270), Vector2(480, 350), Vector2(520, 420), Vector2(540, 500)],  

	# Zig-zag (alternanza tra alto e basso)
	[Vector2(100, 100), Vector2(200, 200), Vector2(300, 100), Vector2(400, 200), Vector2(500, 100)],  

	# Largamente distribuito su tutta l'area
	[Vector2(120, 500), Vector2(500, 120), Vector2(220, 330), Vector2(420, 250), Vector2(330, 500)],  

	# Disposizione circolare, ma sfalsata
	[Vector2(300, 100), Vector2(450, 150), Vector2(500, 300), Vector2(400, 450), Vector2(250, 400), Vector2(150, 250)],  

	# Sparso con centro volutamente vuoto
	[Vector2(100, 100), Vector2(500, 100), Vector2(100, 500), Vector2(500, 500)],  

	# Doppia diagonale che attraversa l'area
	[Vector2(120, 120), Vector2(220, 220), Vector2(320, 320), Vector2(420, 420), Vector2(520, 520)],  

	# Quasi linea orizzontale ma leggermente irregolare
	[Vector2(100, 300), Vector2(200, 320), Vector2(300, 310), Vector2(400, 290), Vector2(500, 300)],  

	# Arcata (disposizione a semi-cerchio)
	[Vector2(100, 400), Vector2(200, 500), Vector2(320, 550), Vector2(440, 500), Vector2(540, 400)],  
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
	
	print("Generato pattern con", trappole_attive.size(), "trappole")

func rimuovi_tutte_trappole():
	for trappola in trappole_attive:
		trappola.queue_free()
	trappole_attive.clear()
	print("Tutte le trappole rimosse.")

func get_numero_trappole():
	return trappole_attive.size()

func _on_trappola_eliminata(trappola):
	if trappola in trappole_attive:
		trappole_attive.erase(trappola)
		trappola.queue_free()
		get_parent().rimuovi_trappola()
		print("Trappola eliminata. Rimangono:", get_numero_trappole())
