extends Node2D

@export var min_tempo_spawn : float = 0.5
@export var max_tempo_spawn : float = 2.0
@export var variazione_altezza : float = 100.0
@export var percorso_scena_freccia : String = "res://Scenes/Bracconiere/Freccia.tscn"

var timer : Timer
var posizione_y_base : float = -42
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
	
	# Memorizza la posizione base di spawn
	##posizione_y_base = position.y
	
	# Configura il timer per gli spawn
	timer.wait_time = randf_range(min_tempo_spawn, max_tempo_spawn)
	timer.timeout.connect(_on_timer_timeout)
	timer.start()

func _on_timer_timeout():
	# Verifica che la scena sia stata caricata
	if scena_freccia == null:
		push_error("Scena freccia non disponibile!")
		timer.start()
		return
	
	# Genera una nuova freccia
	var nuova_freccia = scena_freccia.instantiate()
	
	# Posiziona la freccia con una certa variazione verticale
	nuova_freccia.position.y = posizione_y_base + randf_range(-variazione_altezza, variazione_altezza)
	nuova_freccia.position.x = 100 # Assicura che appaia sul lato sinistro
	
	# Aggiungi la freccia alla scena
	add_child(nuova_freccia)
	
	# Riconfigura il timer per il prossimo spawn
	timer.wait_time = randf_range(min_tempo_spawn, max_tempo_spawn)
	timer.start()
