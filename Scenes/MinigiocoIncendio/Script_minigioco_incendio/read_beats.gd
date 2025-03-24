extends Control

# Variabili per le scene che vengono istanziate
const nota_acqua_scena = preload("res://Scenes/MinigiocoIncendio/SubScenes/nota_acqua.tscn")
const nota_comb_scena = preload("res://Scenes/MinigiocoIncendio/SubScenes/nota_combustibile.tscn")
var fire_scene = preload("res://Scenes/MinigiocoIncendio/SubScenes/Fuoco.tscn")

# Variabili per la gestione dei beat
var beat_times = [] # Lista di tempi dei beat, letti dal file
var pending_notes = [] # Lista di note in attesa di essere spawnate

# Variabili per la gestione del minigioco
var bpm = 120 # Valore di default BPM
var fire_type = "small"
var first_play = true
var game_started = false
var start_time = 0 # Tempo di inizio del minigioco -> da impostare dopo che il giocatore preme "ok"
var spawn_interval = 0.0 # Intervallo tra lo spawn delle note
var last_spawn_time = 0.0 # Ultimo tempo di spawn

@onready var nodi_da_nasc: Array = [$CanvasLayer/GUIPre, $CanvasLayer/GUIMinigioco]
@onready var minigame_audio = $SoundEffects/ThemeMinigioco

# Funzione _ready, in cui si carica il file dei beat e si inizia il minigioco
func _ready():
	load_beat_times("res://Scenes/MinigiocoIncendio/beats.txt") # Carica i tempi del beat
	#pending_notes = beat_times.duplicate() # Copia la lista dei tempi dei beat

# VECCHIA FUNZIONE PROCESS con algoritmo di beat tracking Funzione _process, si gestisce lo spawning delle note al tempo corretto
#func _process(delta):
#	var current_time = Time.get_ticks_msec() / 1000 - start_time # Tempo attuale in secondi
#
#	if pending_notes.size() > 0 and current_time >= pending_notes[0]: # Se ci sono note in attesa e il tempo corrente e' maggiore o uguale al tempo della prima nota
#		var spawn_time = pending_notes.pop_front() # Rimuove il primo elemento della lista
#		create_note_at_time(spawn_time) # Crea la nota al tempo specificato

# Funzione _process, gestisce lo spawning delle note in base al tipo di fuoco.
# Per ogni tipo di fuoco, puo' spawnare un numero di note da 1 a max_notes.
func _process(delta):

	if not game_started:
		return  # Se il gioco non è iniziato, non fare nulla

	var current_time = Time.get_ticks_msec() / 1000 - start_time # Tempo attuale in secondi

	if current_time - last_spawn_time >= spawn_interval: # Se il tempo trascorso dall'ultimo spawn e' maggiore o uguale all'intervallo di spawn
		last_spawn_time = current_time

		# Decido quante note spawnare in base al tipo di fuoco
		var max_notes = 0
		match fire_type:
			"small": max_notes = 3
			"medium": max_notes = 4
			"large": max_notes = 5
			_: max_notes = 2

		var num_notes = randi_range(1, max_notes) # Numero casuale di note da spawnare (da 1 a max_notes)

		for i in range(num_notes): # Crea le note in base alla difficolta'
			create_note_at_time(current_time, num_notes, i)

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


# Cambia la visibilita' ai nodi in un certo array di nodi
func toggle_visibility(nodes_array: Array):
	
	# Itera sull'array di nodi e cambia la visibilita
	for node in nodes_array:
		if node: 
			node.visible = !node.visible # Inverte la visibilita del nodo

# Quando il TextureButton in GUIPre e' premuto, inizia il minigioco e lo scorrere del tempo
func _on_texture_button_pressed():
	toggle_visibility(nodi_da_nasc)
	start_time = Time.get_ticks_msec() / 1000 # Ottiene il tempo attuale in secondi
	game_started = true
	start_minigame()
	minigame_audio.play()

# Funzione per la gestione del minigioco.
func start_minigame():
	var fire = fire_scene.instantiate()
	
	var screen_size = get_viewport_rect().size
	var fire_sprite = fire.get_node("Fuoco")
	var fire_size= fire_sprite.get_sprite_frames().get_frame_texture(fire_sprite.animation, 0).get_size()
	fire.position.x = (screen_size.x - fire_size.x) / 2
	fire.position.y= 400 

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
	
	set_spawn_interval(fire_type) # Imposta l'intervallo di tempo di spawn delle notein base al tipo di fuoco

# Funzione per impostare l'intervallo di tempo di spawn in base al tipo di fuoco
func set_spawn_interval(fire_type):
	match fire_type:
		"small": spawn_interval = randf_range(2.5, 4.0)# Tempo di spawn per il fuoco piccolo
		"medium": spawn_interval = randf_range(2.0, 3.0) # Tempo di spawn per il fuoco medio
		"large": spawn_interval = randf_range(1.5, 2.0) # Tempo di spawn per il fuoco grande
		_: spawn_interval = randf_range(1.0, 2.0) # Default

# Funzione che spawna la scena "Note" (spawna le note) in una certa posizione iniziale.
func create_note_at_time(time, num_notes, index):
	var note_scene
	# Utilizza l'algoritmo di sampling per decidere il tipo di nota da spawnare
	var note_type = get_note_type_based_on_fire(fire_type)
	
	if note_type == "WATER":
		note_scene = nota_acqua_scena.instantiate()
		note_scene.initialize_note("WATER")  # Inizializza la nota con il tipo scelto - da tenere d'occhio
	elif note_type == "FUEL":
		note_scene = nota_comb_scena.instantiate()
		note_scene.initialize_note("FUEL") 

	var spawn_position_x = lerp(500, 1700, float(index) / float(num_notes - 1)) # Posizione x della nota
	var spawn_position_y = -50 # Posizione fissa sull'asse Y, o eventualmente casuale

	var spawn_position = Vector2(spawn_position_x, spawn_position_y)
	note_scene.position = spawn_position

	note_scene.set_meta("spawn_time", time)
	note_scene.set_meta("fire_type", fire_type) # Passa il tipo di fuoco alla nota
	note_scene.set_meta("bpm", bpm)
	#print("Nota creata al tempo:", time, "Secondi attuali:", Time.get_ticks_msec() / 1000 - start_time)
	add_child(note_scene)

# Funzione che decide il tipo di nota da spawnare in base al tipo di fuoco - Algoritmo di sampling con distribuzione discreta
# (Random weighted choice tra acqua e combustibile)
func get_note_type_based_on_fire(fire_type):
	var random_value = randf_range(0.0, 1.0) # Valore casuale tra 0 e 1
	match fire_type:
		"small":
			return "WATER" if random_value < 0.7 else "FUEL" # 70% di probabilita' di acqua, 30% di combustibile
		"medium":
			return "WATER" if random_value < 0.5 else "FUEL" # 50% di probabilita' di acqua, 50% di combustibile
		"large":
			return "WATER" if random_value < 0.4 else "FUEL" # 40% di probabilita' di acqua, 60% di combustibile
		_:
			return "WATER" if random_value < 0.5 else "FUEL" # Default
