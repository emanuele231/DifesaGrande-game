extends Node2D

var spawn_time : float
var speed : float 
var bpm : float 
var fire_type : String # Tipo di fuoco che definisce la difficolta' (piccolo, medio, grande)

# Variabili per la gestione delle note
enum NoteType {WATER, FUEL}  # Tipo di nota (acqua o combustibile)
var note_type

func _ready():
	spawn_time = get_meta("spawn_time")  # Ottieni il tempo di spawn passato dal nodo principale
	fire_type = get_meta("fire_type") # Ottieni il tipo di fuoco
	bpm = float(get_meta("bpm"))

	# Calcola la velocita' di discesa delle note in base al BPM e al tipo di fuoco
	speed = calculate_speed(bpm, fire_type) 
	set_process(true)  # Inizia a processare il movimento

	# Funzione per l'impostazione del threshold di errori in base al tipo di fuoco
	set_error_limit()

	# Collega il segnale per la collisione della nota con il fuoco
	$Nota/Collision.connect("area_entered", Callable(self, "_on_area_entered"))

	# Collega il segnale per l'input dell'utente


# Funzione che processa le note. Le fa spostare in basso e controlla se l'utente preme il tasto giusto.
func _process(delta):
	
	# Muovi la nota verso il basso (velocita' dipendente dal BPM)
	position.y += speed * delta

# Funzione che in base al tipo di fuoco calcola la velocita' di discesa delle note
func calculate_speed(bpm, fire_type):
	var base_speed = 200

	var speed_multiplier = {
		"small":1.0,  # Fuoco piccolo, velocita' minore
		"medium":1.2, # Fuoco medio, velocita' normale
		"large":1.4 # Fuoco grande, velocita' massima
	}.get(fire_type, 1.0)
	
	# Calcola il tempo tra i beat in base al BPM
	var beat_interval = 60 / bpm  
	return base_speed * speed_multiplier * beat_interval

# Funzione chiamata quando la nota entra in collisione con il fuoco
func _on_area_entered(area):
	if area.is_in_group("fire"):

		if note_type == "WATER":
			print("Nota di acqua persa!")
			update_error_count()
			queue_free()
		elif note_type == "FUEL":
			queue_free()
		
		var main_game = get_tree().current_scene.get_node("Control")
		if main_game:
			main_game.play_sound_fuel()
		else:
			print("Errore: Nodo MainGame non trovato!")
			

# Funzione per inizializzare la nota con un tipo e un tasto assegnato
func initialize_note(type):
	note_type = type

# Funzione per la gestione dell'input dell'utente - L'input dev'essere gestito sulla base del click dell'utente sulla nota!
func _on_water_note_pressed():

	print("Nota di acqua premuta!")
	var main_game = get_tree().current_scene.get_node("Control")
	if main_game:
		main_game.play_sound_water()
	else:
		print("Errore: Nodo MainGame non trovato!")
	
	queue_free()

func _on_fuel_note_pressed():
	
	print("Nota di combustibile premuta!")
	update_error_count()

	var main_game = get_tree().current_scene.get_node("Control")
	if main_game:
		main_game.play_sound_fuel()
	else:
		print("Errore: Nodo MainGame non trovato!")

	queue_free()

func set_error_limit():
	match fire_type:
		"small": VariabiliGlobali.error_limit = 5
		"medium": VariabiliGlobali.error_limit = 3
		"large": VariabiliGlobali.error_limit = 2
		_: VariabiliGlobali.error_limit = 3 # Default

func update_error_count():
	VariabiliGlobali.error_count += 1
	print("Errore! Errori totali: ", VariabiliGlobali.error_count)

	if VariabiliGlobali.error_count >= VariabiliGlobali.error_limit:
	# Mostrare a schermo il punteggio finale, non vengono scoperte le cause, ecc.
		print("SEI MORTO")
		#get_tree().paused = true

		# Trova il nodo principale e chiama il game over
		# Debug: Controlla la scena corrente
		print("Scena corrente: ", get_tree().current_scene.name)

		var main_game = get_tree().current_scene.get_node("Control")
		if main_game:
			main_game.game_over()
		else:
			print("Errore: Nodo MainGame non trovato!")

# Cambia la visibilita' ai nodi in un certo array di nodi
func toggle_visibility(node):
	
	if node: 
		node.visible = !node.visible # Inverte la visibilita del nodo
