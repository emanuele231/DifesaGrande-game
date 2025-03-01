# Script principale di MinigiocoFrecce
extends Node2D

# Segnali per comunicare con la scena principale
signal vita_ridotta(danno)
signal minigioco_terminato(successo)

# Variabili per la gestione del gioco
@export var durata_minigioco : float = 10.0
var timer_minigioco : Timer
@onready var animale = $Animale

func _ready():
	# Aggiungi l'animale al gruppo per identificarlo nelle collisioni
	animale.add_to_group("animale")
	
	# Crea e configura il timer per la durata del minigioco
	timer_minigioco = Timer.new()
	add_child(timer_minigioco)
	timer_minigioco.wait_time = durata_minigioco
	timer_minigioco.one_shot = true  # Il timer scatta una sola volta
	timer_minigioco.timeout.connect(_on_minigioco_terminato)
	timer_minigioco.start()
	
	#print("Posizione iniziale globale:", global_position)
	#print("Nodo genitore:", get_parent().name)
	#print("Posizione genitore:", get_parent().global_position)

func freccia_colpita(danno):
	# Emetti il segnale per ridurre la vita
	emit_signal("vita_ridotta", danno)
	
	# Qui puoi aggiungere effetti visivi o sonori quando l'animale viene colpito

func _on_minigioco_terminato():
	# Termina il minigioco e invia segnale
	get_tree().call_group("frecce", "queue_free")
	# Emetti il segnale che il minigioco è terminato con successo
	emit_signal("minigioco_terminato", true)
