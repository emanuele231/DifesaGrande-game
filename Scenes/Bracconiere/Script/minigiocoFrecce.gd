extends Node2D

signal vita_ridotta(danno)
signal minigioco_terminato(successo)

@export var durata_minigioco : float = 10.0
var timer_minigioco : Timer

@onready var animale = $Animale
@onready var audioPlayer = get_node("SpawnerFrecce/AudioStreamPlayer")
@onready var label_istruzioni = $Istruzioni  # Riferimento alla Label delle istruzioni

var istruzioni_scomparse : bool = false  # Variabile per tenere traccia della visibilità delle istruzioni

func _ready():
	print("Genitore del nodo:", get_parent().name)
	print("Minigioco inizializzato")
	
	animale.add_to_group("animale")
	
	# Mostra la Label con le istruzioni
	label_istruzioni.visible = true
	
	# Avvia un timer per nascondere la Label dopo 2 secondi
	var timer_istruzioni = Timer.new()
	add_child(timer_istruzioni)
	timer_istruzioni.wait_time = 3.0  # Tempo di visualizzazione della Label (2 secondi)
	timer_istruzioni.one_shot = true
	timer_istruzioni.timeout.connect(_nascondi_istruzioni)
	timer_istruzioni.start()

func freccia_colpita(danno):
	audioPlayer.stream = load("res://Scenes/Bracconiere/Sound Effects/classic-game-action-negative-19-224578.mp3") 
	audioPlayer.play()
	print("Funzione freccia_colpita chiamata con danno:", danno)
	emit_signal("vita_ridotta", danno)

func _on_minigioco_terminato():
	get_tree().call_group("frecce", "queue_free")
	emit_signal("minigioco_terminato", true)

# Funzione per nascondere la Label dopo 2 secondi
func _nascondi_istruzioni():
	label_istruzioni.visible = false
	istruzioni_scomparse = true  # Le istruzioni sono state nascoste

	# Ora che le istruzioni sono scomparse, inizia il minigioco
	_inizia_minigioco()

# Funzione per avviare il minigioco, che verrà chiamata solo quando le istruzioni sono scomparse
func _inizia_minigioco():
	if istruzioni_scomparse:
		# Inizializza il timer del minigioco
		timer_minigioco = Timer.new()
		add_child(timer_minigioco)
		timer_minigioco.wait_time = durata_minigioco
		timer_minigioco.one_shot = true  # Il timer scatta una sola volta
		timer_minigioco.timeout.connect(_on_minigioco_terminato)
		timer_minigioco.start()
