extends Node2D

var spawn_time : float
var speed : float 
var bpm : float 
var fire_type : String # Tipo di fuoco che definisce la difficolta' (piccolo, medio, grande)

# Variabili per la gestione delle note
enum NoteType {WATER, FUEL}  # Tipo di nota (acqua o combustibile)
var note_type
var assigned_key

# Lista dei tasti assegnati per le note
const WATER_KEYS = [KEY_A, KEY_S, KEY_D, KEY_F]
const FUEL_KEYS = [KEY_H, KEY_J, KEY_K, KEY_L]

func _ready():
	spawn_time = get_meta("spawn_time")  # Ottieni il tempo di spawn passato dal nodo principale
	fire_type = get_meta("fire_type") # Ottieni il tipo di fuoco
	bpm = float(get_meta("bpm"))

	# Calcola la velocita' di discesa delle note in base al BPM e al tipo di fuoco
	speed = calculate_speed(bpm, fire_type) 
	set_process(true)  # Inizia a processare il movimento

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

# Funzione che processa le note. Le fa spostare in basso e controlla se l'utente preme il tasto giusto.
func _process(delta):
	
	# Muovi la nota verso il basso (velocita' dipendente dal BPM)
	position.y += speed * delta

# Funzione per inizializzare la nota con un tipo e un tasto assegnato
func initialize_note(type):
	note_type = type
	assigned_key = get_assigned_key()
	update_assigned_key_sprite() # Aggiorna lo sprite del tasto assegnato

# Funzione per ottenere un tasto casuale in base al tipo di nota
func get_assigned_key():
	if note_type == "WATER":
		return WATER_KEYS[randi() % WATER_KEYS.size()]
	elif note_type == "FUEL":
		return FUEL_KEYS[randi() % FUEL_KEYS.size()]
	return ""

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

	if note_type == "WATER":
		$Nota/Key.texture = load("res://Scenes/MinigiocoIncendio/Artstyle/WaterKeys/Key_" + key_sprite + ".png")
	elif note_type == "FUEL":
		$Nota/Key.texture = load("res://Scenes/MinigiocoIncendio/Artstyle/FuelKeys/Key_" + key_sprite + ".png")

# Funzione per la gestione dell'input dell'utente
func _input(event):
	if event is InputEventKey and event.pressed:
		var key_pressed = OS.get_keycode_string(event.keycode)
		
		# Controlla se il tasto premuto è quello della nota attuale
		if key_pressed == OS.get_keycode_string(assigned_key):
			if note_type == "WATER":
				# CORRETTO: il giocatore ha premuto una nota acqua
				queue_free()  # Rimuove la nota
				print("Bravo! Hai spento il fuoco con", key_pressed)
			elif note_type == "FUEL":
				# ERRORE: il giocatore ha premuto una nota combustibile
				print("Errore! Hai alimentato il fuoco con", key_pressed)
				queue_free()  # Rimuove la nota
				emit_signal("note_missed")  # Segnala che il giocatore ha sbagliato
		else:
			# Se ha premuto un tasto non assegnato, non succede nulla
			pass
