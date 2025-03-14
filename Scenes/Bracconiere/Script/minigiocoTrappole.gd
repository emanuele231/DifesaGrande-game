extends Node2D

signal vita_ridotta(danno)
signal minigioco_terminato(successo)

@export var durata_turno : float = 5.0
@export var numero_turni : int = 3
@export var danno_per_turno : int = 10

var turno_corrente : int = 0
var trappole_rimanenti : int = 0
var timer_turno : Timer

@onready var spawner = $SpawnerTrappole
@onready var turnoLabel = $Turno

func _ready():
	print("Minigioco trappole inizializzato")
	timer_turno = Timer.new()
	add_child(timer_turno)
	timer_turno.wait_time = durata_turno
	timer_turno.one_shot = true
	timer_turno.timeout.connect(_on_turno_scaduto)

	inizia_turno()

func inizia_turno():
	if turno_corrente >= numero_turni:
		fine_minigioco()
		return
	
	turno_corrente += 1
	turnoLabel.text = "Turno: " + str(turno_corrente) + "/3"
	print("Turno:", turno_corrente)

	spawner.genera_trappole()

	# numero di trappole da eliminare
	trappole_rimanenti = spawner.get_numero_trappole()
	
	# Avvia il timer del turno
	timer_turno.start()

func rimuovi_trappola():
	trappole_rimanenti -= 1
	print("Trappole rimanenti:", trappole_rimanenti)

	if trappole_rimanenti <= 0:
		timer_turno.stop()
		await get_tree().create_timer(0.5).timeout
		inizia_turno()

func _on_turno_scaduto():
	if trappole_rimanenti > 0:
		print("Turno fallito, il giocatore subisce danno:", danno_per_turno)
		emit_signal("vita_ridotta", danno_per_turno)

	# Rimuove le trappole rimaste prima del prossimo turno
	spawner.rimuovi_tutte_trappole()

	await get_tree().create_timer(1.0).timeout
	inizia_turno()

func fine_minigioco():
	print("Minigioco trappole completato!")
	emit_signal("minigioco_terminato", true)
