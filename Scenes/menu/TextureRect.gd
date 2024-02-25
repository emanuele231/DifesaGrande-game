extends TextureRect

var frames_forward = []  # Lista delle immagini della sequenza in avanti
var frames_backward = []  # Lista delle immagini della sequenza all'indietro
var current_frame = 0  # Indice del frame corrente
var frame_duration = 0.1  # Durata di ciascun frame in secondi
var time_accumulator = 0  # Accumulatore di tempo

func _ready():
	# Carica la sequenza di immagini in avanti
	for i in range(0, 61):
		var frame_path = "res://sfondi/Background_frame/frame_" + str(i).pad_zeros(2) + "_delay-0.07s.png"
		frames_forward.append(load(frame_path))

	# Carica la sequenza di immagini all'indietro
	for i in range(61, 0, -1):
		var frame_path = "res://sfondi/Background_frame/frame_" + str(i).pad_zeros(2) + "_delay-0.07s.png"
		frames_backward.append(load(frame_path))

	# Inizia con la prima immagine in avanti
	texture = frames_forward[0]

func _process(delta):
	# Aggiorna l'accumulatore di tempo
	time_accumulator += delta

	# Cambia il frame ogni frame_duration secondi
	if time_accumulator >= frame_duration:
		time_accumulator = 0
		next_frame()

func next_frame():
	# Passa al frame successivo
	current_frame += 1

	# Se tutti i frame in avanti sono stati mostrati, ricomincia dall'inizio
	if current_frame >= frames_forward.size() + frames_backward.size():
		current_frame = 0

	# Se siamo ancora nella sequenza in avanti, utilizza quella
	if current_frame < frames_forward.size():
		texture = frames_forward[current_frame]
	# Altrimenti, utilizza la sequenza all'indietro
	else:
		texture = frames_backward[current_frame - frames_forward.size()]
