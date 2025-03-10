extends Node2D

@export var min_tempo_spawn : float = 0.5
@export var max_tempo_spawn : float = 2.0
@export var variazione_altezza : float = 200.0
@export var percorso_scena_freccia : String = "res://Scenes/Bracconiere/Freccia.tscn"

var timer : Timer
var posizione_y_base : float = -15
var scena_freccia : PackedScene

func _ready():
	timer = Timer.new()
	add_child(timer)
	
	# Carica la scena freccia
	if ResourceLoader.exists(percorso_scena_freccia):
		scena_freccia = load(percorso_scena_freccia)
		print("Scena freccia caricata con successo")
	else:
		push_error("Impossibile trovare la scena freccia al percorso: " + percorso_scena_freccia)
	
	timer.wait_time = randf_range(min_tempo_spawn, max_tempo_spawn)
	timer.timeout.connect(_on_timer_timeout)
	timer.start()

func _on_timer_timeout():
	if scena_freccia == null:
		push_error("Scena freccia non disponibile!")
		timer.start()
		return
	
	var nuova_freccia = scena_freccia.instantiate()

	nuova_freccia.position.y = posizione_y_base + randf_range(-variazione_altezza,variazione_altezza)
	nuova_freccia.position.x = 220 # Assicura che appaia sul lato sinistro
	
	print("freccia posizione",nuova_freccia.position)
	add_child(nuova_freccia)
	
	timer.wait_time = randf_range(min_tempo_spawn, max_tempo_spawn)
	timer.start()
