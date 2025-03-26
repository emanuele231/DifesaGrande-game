extends Node2D

var spawn_time : float
var speed : float 
var bpm : float 
var fire_type : String # Tipo di fuoco che definisce la difficolta' (piccolo, medio, grande)
var waternote_has_collided = false

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
			waternote_has_collided = true
			update_error_count()
			set_score(fire_type)
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
	VariabiliGlobali.acqua_pressed = true
	set_score(fire_type)
	update_ingame_text()

	var main_game = get_tree().current_scene.get_node("Control")
	if main_game:
		main_game.play_sound_water()
	else:
		print("Errore: Nodo MainGame non trovato!")
	
	queue_free()

func _on_fuel_note_pressed():
	
	VariabiliGlobali.acqua_pressed = false
	print("Nota di combustibile premuta!")
	update_error_count()
	set_score(fire_type)

	var main_game = get_tree().current_scene.get_node("Control")
	if main_game:
		main_game.play_sound_fuel()
	else:
		print("Errore: Nodo MainGame non trovato!")

	queue_free()

# Imposta il numero di errori limite per ciascun tipo di fuoco
func set_error_limit():
	match fire_type:
		"small": VariabiliGlobali.error_limit = 5
		"medium": VariabiliGlobali.error_limit = 4
		"large": VariabiliGlobali.error_limit = 3
		_: VariabiliGlobali.error_limit = 3 # Default

# Funzione che aggiorna il label degli errori sull'interfaccia
func update_error_text():
	var main_game = get_tree().current_scene.get_node("Control")
	if main_game:
		main_game.set_error_label()

# Funzione che aggiorna il label del messaggio sull'interfaccia
func update_ingame_text():
	var main_game = get_tree().current_scene.get_node("Control")
	if main_game:
		main_game.set_ingame_label()

# Funzione che aggiorna gli errori e controlla che gli errori non abbiano superato
# il numero di errori totali impostato.
func update_error_count():
	VariabiliGlobali.error_count += 1
	print("Errore! Errori totali: ", VariabiliGlobali.error_count)

	update_error_text() # Aggiorna il label degli errori
	update_ingame_text() # Aggiorna il label del messaggio ingame

	if VariabiliGlobali.error_count >= VariabiliGlobali.error_limit:
	# Mostrare a schermo il punteggio finale, non vengono scoperte le cause, ecc.
		print("SEI MORTO")

		# Trova il nodo principale e chiama il game over
		# Debug: Controlla la scena corrente
		print("Scena corrente: ", get_tree().current_scene.name)

		var main_game = get_tree().current_scene.get_node("Control")
		if main_game:
			
			if VariabiliGlobali.game_over_called == false:
				main_game.game_over()
				main_game.set_score_label() # Eventualmente potrebbe anche non servire dato che è sempre 0 se perde
				VariabiliGlobali.game_over_called = true
		else:
			print("Errore: Nodo MainGame non trovato!")

# Funzione che imposta lo score in base al tipo di fuoco e aggiorna il label della combo sull'interfaccia
func set_score(fire_type):

	# Per aggiornare la combo
	var main_game = get_tree().current_scene.get_node("Control")

	# Definizione dei moltiplicatori in base al tipo di fuoco
	var fire_multipliers = {
		"small": 1.0,  # Moltiplicatore di base per fuoco piccolo
		"medium": 1.2,  # Moltiplicatore ampliato per fuoco medio -> piu' punteggio
		"large": 1.5 # Moltiplicatore estremizzato per fuoco grande -> piu' punteggio
	}

	var max_score = 1000 # Limite massimo di punteggio

	if note_type == "WATER":

		if waternote_has_collided:
			waternote_has_collided = false

			var penality = 30 * fire_multipliers[fire_type]

			VariabiliGlobali.combo = 0  # Reset combo
			VariabiliGlobali.score -= penality  # Sottrae punti
			print("Nota persa! Penalita': -", penality, " | Punteggio:", VariabiliGlobali.score)
			main_game.set_combo_label()
			
		else:
			# Aumenta il punteggio
			VariabiliGlobali.combo += 1  
			var combo_multiplier = 1.0 + (VariabiliGlobali.combo * 0.05)  # Combo piu' controllata
			var base_score = 20 * fire_multipliers[fire_type]

			VariabiliGlobali.score += round(base_score * combo_multiplier)

			# Impedisce che il punteggio superi 1000
			VariabiliGlobali.score = min(VariabiliGlobali.score, max_score)

			print("Punteggio attuale: ", VariabiliGlobali.score, " | Combo: x", combo_multiplier)
			main_game.set_combo_label()

	elif note_type == "FUEL":

		var penality = 50 * fire_multipliers[fire_type]
		VariabiliGlobali.combo = 0  # Reset combo
		VariabiliGlobali.score -= penality  # Sottrae punti
		print("Errore! Nota FUEL cliccata. Penalita':", penality, " | Punteggio:", VariabiliGlobali.score)
		main_game.set_combo_label()

	#print("Punteggio attuale: ", VariabiliGlobali.score, " | Combo: x", multiplier)
