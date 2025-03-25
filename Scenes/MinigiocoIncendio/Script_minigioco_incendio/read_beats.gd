extends Control

# Variabili per le scene che vengono istanziate
const nota_acqua_scena = preload("res://Scenes/MinigiocoIncendio/SubScenes/nota_acqua.tscn")
const nota_comb_scena = preload("res://Scenes/MinigiocoIncendio/SubScenes/nota_combustibile.tscn")
var scena_mappa = preload("res://Scenes/mappa_game/mappa.tscn") 
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

# Nodi per la modifica della visibilita'
@onready var nodi_da_nasc_1: Array = [$CanvasLayer/GUIPre, $CanvasLayer/GUIMinigioco]
@onready var nodi_da_nasc_2: Array = [$CanvasLayer/GUIMinigioco/Causa/CausaScopertaBox, $CanvasLayer/GUIMinigioco/Causa/QuestionMark]
@onready var nodi_da_nasc_3: Array = [$CanvasLayer/GUIMinigioco, $CanvasLayer/GUIPost]
@onready var nodi_da_nasc_4: Array = [$CanvasLayer/GUIPost/Istruzioni_win, $CanvasLayer/GUIPost/Causa, $CanvasLayer/GUIPost/NomeCausa, $CanvasLayer/GUIPost/DescrizioneCausa, $CanvasLayer/GUIPost/BackgroundDesc]
@onready var nodi_da_nasc_5: Array = [$CanvasLayer/GUIPost/Istruzioni_lose, $CanvasLayer/GUIPost/CausaNonScopertaLabel]

# Button mappa
@onready var mappa_Button = $CanvasLayer/GUIPost/ButtonTorna

# Themes
@onready var minigame_audio = $SoundEffects/ThemeMinigioco
@onready var minigame_fire= $SoundEffects/FireSound

# Sound effects
@onready var sound_fire = $SoundEffects/FireEffect
@onready var sound_water = $SoundEffects/WaterEffect
@onready var sound_gameover = $SoundEffects/GameOverEffect
@onready var sound_win = $SoundEffects/VictoryEffect

# Variabili per le cause dell'incendio in base al tipo
var fire_causes = {
	"small": [
		{
			"image": "res://Scenes/MinigiocoIncendio/Artstyle/Cause/fiammifero.png",
			"probability": 0.7,
			"text": "FIAMMIFERO",
			"desc": "[center]L'incendio è stato innescato da un fiammifero, intenzionalmente. Qualcuno ha arrecato volutamente danno alla natura.. che vergogna![/center]"
		},
		{
			"image": "res://Scenes/MinigiocoIncendio/Artstyle/Cause/fogliolini.png",
			"probability": 0.3,
			"text":"FOGLIAME",
			"desc": "[center]L'incendio è stato innescato dall'autocombustione di foglie secche, fenomeno che può verificarsi quando ci sono temperature alte e scarsa umidità. Anche se naturali, eventi di questo tipo possono essere prevenuti con una buona pulizia e manutenzione delle aree verdi![/center]"
		}
	],
	"medium":[
		{
			"image": "res://Scenes/MinigiocoIncendio/Artstyle/Cause/sigaretta.png",
			"probability": 0.4,
			"text": "MOZZICONE DI SIGARETTA",
			"desc": "[center]A quanto pare, l'incendio è stato causato da un mozzicone di sigaretta ancora acceso. Anche un piccolo gesto, come gettare un mozzicone per terra, può avere conseguenze devastanti sulla natura. I fumatori dovrebbero sempre spegnere completamente le sigarette e smaltirle negli appositi contenitori. È un incendio di tipo colposo![/center]"
		},
		{
			"image": "res://Scenes/MinigiocoIncendio/Artstyle/Cause/stoppie.png",
			"probability": 0.2,
			"text": "STOPPIE",
			"desc": "[center]L'incendio è stato causato dalla bruciatura di stoppie agricole, una pratica pericolosa che può facilmente sfuggire al controllo, come in questo caso. Bruciare resti agricoli, oltre ad essere rischioso, è anche dannoso per l'ambiente perché inquina l'aria e secca il suolo. È essenziale adottare metodi alternativi più sostenibili per la gestione dei rifiuti agricoli.[/center]"
		},
		{
			"image": "res://Scenes/MinigiocoIncendio/Artstyle/Cause/barbecue.png",
			"probability": 0.4,
			"text": "BARBECUE",
			"desc": "[center]L'incendio è stato causato dai resti di un barbecue lasciati incustoditi. Anche se può sembrare innocuo, accendere un fuoco in un'area boschiva è estremamente pericoloso, soprattutto in condizioni di vento e siccità. Incendi colposi come questo possono essere evitati con comportamenti più responsabili.[/center]"
		}
	],
	"large":[
		{
			"image": "res://Scenes/MinigiocoIncendio/Artstyle/Cause/accendino.png",
			"probability": 0.5, 
			"text": "ACCENDINO",
			"desc": "[center]L'incendio è stato provocato intenzionalmente con un accendino. Si tratta quindi di un incendio doloso, un atto grave e irresponsabile, che mette a rischio non solo il bosco, la sua fauna e la sua flora, ma anche la sicurezza delle persone. Incendiare volontariamente un'area verde è un crimine ambientale![/center]"
		},
		{
			"image": "res://Scenes/MinigiocoIncendio/Artstyle/Cause/sigaretta.png",
			"probability": 0.5,
			"text": "MOZZICONE DI SIGARETTA",
			"desc": "[center]A quanto pare, l'incendio è stato causato da un mozzicone di sigaretta ancora acceso. Anche un piccolo gesto, come gettare un mozzicone per terra, può avere conseguenze devastanti sulla natura. I fumatori dovrebbero sempre spegnere completamente le sigarette e smaltirle negli appositi contenitori. È un incendio di tipo colposo![/center]"
		}
	]
}



# Funzione _ready, in cui si carica il file dei beat e si inizia il minigioco
func _ready():
	load_beat_times("res://Scenes/MinigiocoIncendio/beats.txt") # Carica i tempi del beat

# Funzione _process, gestisce lo spawning delle note in base al tipo di fuoco.
# Per ogni tipo di fuoco, puo' spawnare un numero di note da 1 a max_notes.
func _process(delta):

	if not game_started:
		return  # Se il gioco non e' iniziato, non fa nulla

	var current_time = Time.get_ticks_msec() / 1000 - start_time # Tempo attuale in secondi

	#
	if not minigame_audio.playing and game_started:
		end_minigame()
		return

	if current_time - last_spawn_time >= spawn_interval: # Se il tempo trascorso dall'ultimo spawn e' maggiore o uguale all'intervallo di spawn
		last_spawn_time = current_time

		# Decido quante note spawnare in base al tipo di fuoco
		var max_notes = 0
		match fire_type:
			"small": max_notes = 4
			"medium": max_notes = 5
			"large": max_notes = 6
			_: max_notes = 4

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
	toggle_visibility(nodi_da_nasc_1)
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
	#fire.position.x = (screen_size.x - fire_size.x) / 2
	fire.position.x = 900
	fire.position.y= 500

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

	var spawn_position_x = lerp(128, 1700, float(index) / float(num_notes - 1)) # Posizione x della nota
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

# Funzione che permette di finire il minigioco
func end_minigame():
	game_started = false # Blocca la generazione di nuove note

	minigame_fire.stop()
	sound_win.play()
	await get_tree().create_timer(10.0).timeout
	# Trova e rimuove tutte le note esistenti nella scena
	for note in get_children():
		if note is Node2D and (note.name.begins_with("NotaAcqua") or note.name.begins_with("NotaCombustibile")):
			note.queue_free()

	toggle_visibility(nodi_da_nasc_2)
	# Mostra la schermata di fine minigioco con le cause dell'incendio
	show_fire_cause()
	await get_tree().create_timer(10.0).timeout
	toggle_visibility(nodi_da_nasc_3)
	toggle_visibility(nodi_da_nasc_4)

# Funzione che estrae un evento casuale con la probabilita' specificata
func pick_fire_cause(fire_type):
	var causes = fire_causes[fire_type]
	var random_value = randf() 
	var cumulative_prob = 0.0

	for cause in causes:
		cumulative_prob += cause["probability"]
		if random_value <= cumulative_prob:
			return cause

# Funzione che mostra la schermata con le cause
func show_fire_cause():
	var chosen_cause = pick_fire_cause(fire_type)

	print(chosen_cause["image"])

	var image_path = chosen_cause["image"]
	if ResourceLoader.exists(image_path):
		var texture = load(image_path)

		var sprite_cause = [
			$CanvasLayer/GUIMinigioco/Causa/CausaScoperta,
			$CanvasLayer/GUIMinigioco/Causa/CausaScopertaBox/Sprite2D,
			$CanvasLayer/GUIPost/Causa
		]
	
		for sprite in sprite_cause:
			sprite.texture = texture
			sprite.queue_redraw()
	
	# Mostra il nome della causa
	var text_node = $CanvasLayer/GUIMinigioco/Causa/CausaScopertaBox/NomeCausa
	text_node.text = chosen_cause["text"]
	text_node = $CanvasLayer/GUIPost/NomeCausa
	text_node.text = chosen_cause["text"]

	# Mostra la descrizione della causa - da implementare bene la logica?
	var text_desc = $CanvasLayer/GUIPost/DescrizioneCausa
	text_desc.text = chosen_cause["desc"]


func _on_mappa_pressed():
	print("Caricamento scena mappa...") 
	get_tree().change_scene_to_packed(scena_mappa)

# Funzione che mostra il game over quando il giocatore perde
func game_over():
	print("Game over!")

	# Trova e rimuove tutte le note esistenti nella scena
	for note in get_children():
		if note is Node2D and (note.name.begins_with("NotaAcqua") or note.name.begins_with("NotaCombustibile")):
			note.queue_free()

	minigame_audio.stop()
	await get_tree().create_timer(1.0).timeout
	# Musica di game over
	sound_gameover.play()
	minigame_fire.stop()
	toggle_visibility(nodi_da_nasc_3)
	toggle_visibility(nodi_da_nasc_5)
	#emit_signal("game_over")


# Funzioni per il play dei sound effects delle note
func play_sound_fuel():
	sound_fire.play()

func play_sound_water():
	sound_water.play()