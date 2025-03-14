extends Node2D

@export var min_tempo_spawn : float = 0.5
@export var max_tempo_spawn : float = 1.5
@export var variazione_altezza : float = 40.0
@export var percorso_scena_freccia : String = "res://Scenes/Bracconiere/Scene/Freccia.tscn"
@export var animale : CharacterBody2D

var timer : Timer
var posizione_y_base : float = -15
var scena_freccia : PackedScene

@onready var audioPlayer = $AudioStreamPlayer
@onready var label_istruzioni = get_parent().get_node("Istruzioni")  # Riferimento alla Label delle istruzioni

var istruzioni_scomparse : bool = false  # Variabile per tenere traccia della visibilità delle istruzioni

func _ready():
	# Inizializza il timer
	timer = Timer.new()
	add_child(timer)

	# Carica la scena della freccia
	if ResourceLoader.exists(percorso_scena_freccia):
		scena_freccia = load(percorso_scena_freccia)
		print("Scena freccia caricata con successo")
	else:
		push_error("Impossibile trovare la scena freccia al percorso: " + percorso_scena_freccia)
	
	# Avvia un timer per nascondere la Label delle istruzioni dopo 2 secondi
	var timer_istruzioni = Timer.new()
	add_child(timer_istruzioni)
	timer_istruzioni.wait_time = 2.0  # Tempo di visualizzazione della Label (2 secondi)
	timer_istruzioni.one_shot = true
	timer_istruzioni.timeout.connect(_nascondi_istruzioni)
	timer_istruzioni.start()

# Funzione per nascondere le istruzioni e abilitare lo spawn delle frecce
func _nascondi_istruzioni():
	label_istruzioni.visible = false
	istruzioni_scomparse = true  # Le istruzioni sono scomparse

	# Ora che le istruzioni sono scomparse, inizia a spawnare le frecce
	_inizia_spawn_frecce()

# Funzione per iniziare lo spawning delle frecce, che verrà chiamata solo quando le istruzioni sono scomparse
func _inizia_spawn_frecce():
	if istruzioni_scomparse:
		timer.wait_time = randf_range(min_tempo_spawn, max_tempo_spawn)
		timer.timeout.connect(_on_timer_timeout)
		timer.start()

# Funzione chiamata dal timer per spawnare una freccia
func _on_timer_timeout():
	if scena_freccia == null:
		push_error("Scena freccia non disponibile!")
		timer.start()
		return
	
	var nuova_freccia = scena_freccia.instantiate()

	nuova_freccia.position.y = animale.position.y + 50  # Usa il valore desiderato per la posizione
	nuova_freccia.position.x = 220  # Assicura che appaia sul lato sinistro
	
	print("freccia posizione", nuova_freccia.position)
	add_child(nuova_freccia)
	
	# Riproduci il suono di sparo quando la freccia viene istanziata
	audioPlayer.stream = load("res://Scenes/Bracconiere/Sound Effects/happy-pop-1-185286.mp3")  # Carica il suono
	audioPlayer.play()  # Riproduce il suono
	
	# Rilancia il timer per spawnare la prossima freccia
	timer.wait_time = randf_range(min_tempo_spawn, max_tempo_spawn)
	timer.start()
