extends Control

# Variabili per le scene che vengono istanziate
const NOTA_ACQUA = preload("res://Scenes/MinigiocoIncendio/SubScenes/nota_acqua.tscn")
const NOTA_COMBUSTIBILE = preload("res://Scenes/MinigiocoIncendio/SubScenes/nota_combustibile.tscn")
var fire_scene = preload("res://Scenes/MinigiocoIncendio/SubScenes/Fuoco.tscn")

# Variabili per la gestione dei beat
var beat_times = [] # Lista di tempi dei beat, letti dal file
var pending_notes = [] # Lista di note in attesa di essere spawnate

# Variabili per la gestione del minigioco
var bpm = 120 # Valore di default BPM
var fire_type = "small"
var first_play = true
var start_time = 0 # Tempo di inizio del minigioco
var spawn_interval = 0.0 # Intervallo tra lo spawn delle note
var last_spawn_time = 0.0 # Ultimo tempo di spawn

# Funzione _ready, in cui si carica il file dei beat e si inizia il minigioco
func _ready():
	load_beat_times("res://Scenes/MinigiocoIncendio/beats.txt") # Carica i tempi del beat
	start_time = Time.get_ticks_msec() / 1000 # Ottiene il tempo attuale in secondi
	pending_notes = beat_times.duplicate() # Copia la lista dei tempi dei beat
	start_minigame()

# VECCHIA FUNZIONE PROCESS con algoritmo di beat tracking Funzione _process, si gestisce lo spawning delle note al tempo corretto
#func _process(delta):
#	var current_time = Time.get_ticks_msec() / 1000 - start_time # Tempo attuale in secondi
#
#	if pending_notes.size() > 0 and current_time >= pending_notes[0]: # Se ci sono note in attesa e il tempo corrente e' maggiore o uguale al tempo della prima nota
#		var spawn_time = pending_notes.pop_front() # Rimuove il primo elemento della lista
#		create_note_at_time(spawn_time) # Crea la nota al tempo specificato

# Funzione _process, gestisce lo spawning delle note in base al tipo di fuoco
func _process(delta):
	var current_time = Time.get_ticks_msec() / 1000 - start_time # Tempo attuale in secondi

	if current_time - last_spawn_time >= spawn_interval: # Se il tempo trascorso dall'ultimo spawn e' maggiore o uguale all'intervallo di spawn
		last_spawn_time = current_time
		create_note_at_time(current_time) # Crea la nota al tempo specificato


# Funzione per la lettura e salvataggio dei beat all'interno della lista
func load_beat_times(path):
	var file = FileAccess.open(path, FileAccess.READ)
	if file:
		bpm = file.get_line() # Prende il primo rigo, ovvero il BPM che legge nel file, e lo salva
		print("Sono il BPM!", bpm)
		while not file.eof_reached():
			var line = file.get_line()
			if line.is_valid_float():
				beat_times.append(float(line)) # Salva i tempi del beat che legge nel file
				print("Sto appendendo i tempi correttamente!\n")
				print(line)
	else:
		print("Errore!!")

# Funzione per la gestione del minigioco.
func start_minigame():
	var fire = fire_scene.instantiate()
	fire.position = Vector2(960, 400)
	add_child(fire)  # Il fuoco viene aggiunto alla scena

	# Se il giocatore gioca al minigioco per la prima volta, il fuoco e' piccolo.
	if first_play:
		fire.set_fire_type(fire.FireType.SMALL)
		fire_type = "small"
		first_play = false
	else:
		var random_fire = randi_range(0, 2) # Randomizza il tipo di fuoco
		fire.set_fire_type(random_fire)
		match random_fire:
			0: fire_type = "small"
			1: fire_type = "medium"
			2: fire_type = "large"
	
	set_spawn_interval(fire_type) # Imposta l'intervallo di tempo di spawn in base al tipo di fuoco

# Funzione per impostare l'intervallo di tempo di spawn in base al tipo di fuoco
func set_spawn_interval(fire_type):
	match fire_type:
		"small": spawn_interval = 3.0 # Tempo di spawn per il fuoco piccolo
		"medium": spawn_interval = 2.0 # Tempo di spawn per il fuoco medio
		"large": spawn_interval = 1.0 # Tempo di spawn per il fuoco grande
		_: spawn_interval = 1.0 # Default

# Funzione che spawna la scena "Note" (spawna le note) in una certa posizione iniziale
func create_note_at_time(time):
	var note_scene

	# Decide casualmente se la nota sarà acqua o combustibile - eventualmente implementare un sistema di probabilità
	var note_type = randi() % 2  # 0 = Acqua, 1 = Combustibile

	if note_type == 0:
		note_scene = NOTA_ACQUA.instantiate()
		note_scene.initialize_note("WATER")  # Inizializza la nota con il tipo scelto - da tenere d'occhio
	else:
		note_scene = NOTA_COMBUSTIBILE.instantiate()
		note_scene.initialize_note("FUEL") 
	

	note_scene.position = Vector2(640, -50)

	note_scene.set_meta("spawn_time", time)
	note_scene.set_meta("fire_type", fire_type) # Passa il tipo di fuoco alla nota
	note_scene.set_meta("bpm", bpm)
	#print("Nota creata al tempo:", time, "Secondi attuali:", Time.get_ticks_msec() / 1000 - start_time)
	add_child(note_scene)

func note_missed():
	print("Nota mancata!")
	# Comportamento per l'errore: decrementa numero possibilita' in base al tipo di fuoco
