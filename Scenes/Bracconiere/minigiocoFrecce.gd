# Script principale di MinigiocoFrecce
extends Node2D

signal vita_ridotta(danno)
signal minigioco_terminato(successo)

@export var durata_minigioco : float = 10.0
var timer_minigioco : Timer
@onready var animale = $Animale

func _ready():
	print("Minigioco inizializzato")
	animale.add_to_group("animale")
	
	timer_minigioco = Timer.new()
	add_child(timer_minigioco)
	timer_minigioco.wait_time = durata_minigioco
	timer_minigioco.one_shot = true  # Il timer scatta una sola volta
	timer_minigioco.timeout.connect(_on_minigioco_terminato)
	timer_minigioco.start()

func freccia_colpita(danno):
	print("Funzione freccia_colpita chiamata con danno:", danno)

	emit_signal("vita_ridotta", danno)

func _on_minigioco_terminato():
	get_tree().call_group("frecce", "queue_free")
	emit_signal("minigioco_terminato", true)
