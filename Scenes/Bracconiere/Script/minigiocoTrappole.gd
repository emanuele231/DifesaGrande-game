extends Node2D
 
signal vita_ridotta(danno)
signal minigioco_terminato(successo)

@export var durata_turno : float = 5.0
@export var numero_turni : int = 3
@export var danno_per_trappola : int = 10

var turno_corrente : int = 0
var trappole_rimanenti : int = 0
var timer_turno : Timer
var istruzioni_mostrate : bool = true  # Impedisce di iniziare il gioco finché le istruzioni sono visibili

@onready var spawner = $SpawnerTrappole
@onready var turnoLabel = $Turno
@onready var istruzioniLabel = $Istruzioni  
@onready var audioPlayer = get_node("SpawnerTrappole/AudioStreamPlayer")

func _ready():
	print("Minigioco trappole inizializzato")

	# Inizializza il timer del turno
	timer_turno = Timer.new()
	add_child(timer_turno)
	timer_turno.wait_time = durata_turno
	timer_turno.one_shot = true
	timer_turno.timeout.connect(_on_turno_scaduto)

	# Mostra le istruzioni per 2 secondi, poi avvia il minigioco
	var timer_istruzioni = Timer.new()
	add_child(timer_istruzioni)
	timer_istruzioni.wait_time = 2.0
	timer_istruzioni.one_shot = true
	timer_istruzioni.timeout.connect(_nascondi_istruzioni)
	timer_istruzioni.start()

func _nascondi_istruzioni():
	istruzioniLabel.visible = false
	istruzioni_mostrate = false
	inizia_turno()

func inizia_turno():

	if turno_corrente >= numero_turni:
		fine_minigioco()
		return
		
	audioPlayer.stream = load("res://Scenes/Bracconiere/Sound Effects/happy-pop-1-185286.mp3")
	audioPlayer.play()
	turno_corrente += 1
	turnoLabel.text = "Turno: " + str(turno_corrente) + "/" + str(numero_turni)
	print("Turno:", turno_corrente)

	spawner.genera_trappole()

	# Numero di trappole da eliminare
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
		audioPlayer.stream = load("res://Scenes/Bracconiere/Sound Effects/classic-game-action-negative-19-224578.mp3")
		audioPlayer.play()
		emit_signal("vita_ridotta", danno_per_trappola * trappole_rimanenti)

	# Rimuove le trappole rimaste prima del prossimo turno
	spawner.rimuovi_tutte_trappole()

	await get_tree().create_timer(1.0).timeout
	inizia_turno()

func fine_minigioco():
	emit_signal("minigioco_terminato", true)
