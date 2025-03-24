extends Node2D

var spawn_time : float
var speed : float 
var bpm : float 
var fire_type : String # Tipo di fuoco che definisce la difficolta' (piccolo, medio, grande)

# Variabili per la gestione delle note
enum NoteType {WATER, FUEL}  # Tipo di nota (acqua o combustibile)
var note_type
var assigned_key

@onready var nodi_da_nasc: Array = [$CanvasLayer/GUIPost]

# Lista dei tasti assegnati per le note
const KEYS = [KEY_A, KEY_S, KEY_D, KEY_F, KEY_H, KEY_J, KEY_K, KEY_L]

# Variabili per contare gli errori

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
		"small":0.8,  # Fuoco piccolo, velocita' minore
		"medium":1.0, # Fuoco medio, velocita' normale
		"large":1.3 # Fuoco grande, velocita' massima
	}.get(fire_type, 1.0)
	
	#match fire_type:
	#	"small":
	#		speed_multiplier = 0.8  # Fuoco piccolo = velocita' di discesa più lenta, meno note?, più errori ammessi
	#	"medium":
	#		speed_multiplier = 1.0  # Fuoco medio = velocita' normale
	#	"large":
	#		speed_multiplier = 1.3  # Fuoco grande = velocita' massimizzata
	
	# Calcola il tempo tra i beat in base al BPM
	var beat_interval = 60 / bpm  
	return base_speed * speed_multiplier * beat_interval

# Funzione chiamata quando la nota entra in collisione con il fuoco
func _on_area_entered(area):
	if area.is_in_group("fire"):

		if note_type == "WATER":
			print("Nota di acqua persa!")
			update_error_count()
			remove_note()
			queue_free()
		elif note_type == "FUEL":
			remove_note()
			queue_free()
		

# Funzione per inizializzare la nota con un tipo e un tasto assegnato
func initialize_note(type):
	note_type = type
	assigned_key = get_assigned_key()

	if assigned_key == null:
		print("Tutti i tasti sono gia' assegnati!")
		queue_free()  # Se non ci sono tasti disponibili, rimuovi la nota
		return
	
	VariabiliGlobali.active_notes[assigned_key] = self # Aggiunge questa nota alla lista delle note attive
	update_assigned_key_sprite() # Aggiorna lo sprite del tasto assegnato

# Funzione per ottenere un tasto casuale in base al tipo di nota
func get_assigned_key():
	var available_keys = []
	
	# Trova i tasti che NON sono attualmente in uso
	for key in KEYS:
		if not VariabiliGlobali.active_notes.has(key):
			available_keys.append(key)
		
	print("Tasti disponibili: ", available_keys)

	# Se ci sono tasti disponibili, scegli un tasto casuale
	if available_keys.size() > 0:
		return available_keys[randi() % available_keys.size()]
	else:
		print("Nessun tasto disponibile!")
		return null  # Se non ci sono tasti disponibili, restituisce null

# Funzione per aggiornare lo sprite del tasto assegnato
func update_assigned_key_sprite():

	# Dizionario per mappare i tasti assegnati con gli sprite corrispondenti
	var key_sprite = {
		KEY_A: "A",
		KEY_S: "S",
		KEY_D: "D",
		KEY_F: "F",
		KEY_H: "H",
		KEY_J: "J",
		KEY_K: "K",
		KEY_L: "L"
	}.get(assigned_key, "")

	$Nota/Key.texture = load("res://Scenes/MinigiocoIncendio/Artstyle/Keys/Key_" + key_sprite + ".png")

# Funzione per la gestione dell'input dell'utente
func _input(event):
	if event is InputEventKey and event.pressed:
		var key_pressed = OS.get_keycode_string(event.keycode)
		
		# Controlla se il tasto premuto e' quello della nota attuale
		if key_pressed == OS.get_keycode_string(assigned_key):
			if note_type == "WATER":
				# CORRETTO: il giocatore ha premuto una nota acqua
				remove_note()  # Rimuove la nota dalla lista delle note attive
				queue_free()  # Libera la risorsa
				print("Bravo! Hai spento il fuoco con", key_pressed)
			elif note_type == "FUEL":
				# ERRORE: il giocatore ha premuto una nota combustibile
				print("Errore! Hai alimentato il fuoco con", key_pressed)
				update_error_count()
				remove_note()  # Rimuove la nota dalla lista delle note attive
				queue_free()  # Libera la risorsa
				# emit_signal("note_missed")  # Segnala che il giocatore ha sbagliato -> da implementare
		else:
			# Se ha premuto un tasto non assegnato, non succede nulla
			pass

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
		get_tree().paused = true
		toggle_visibility(nodi_da_nasc)

# Cambia la visibilita' ai nodi in un certo array di nodi
func toggle_visibility(nodes_array: Array):
	
	# Itera sull'array di nodi e cambia la visibilita
	for node in nodes_array:
		if node: 
			node.visible = !node.visible # Inverte la visibilita del nodo

# Funzione per rimuovere una nota dalla lista delle note attive
func remove_note():
	if assigned_key in VariabiliGlobali.active_notes:
		VariabiliGlobali.active_notes.erase(assigned_key)
	else:
		print("Errore! La nota non e' presente nella lista delle note attive: ", assigned_key)
