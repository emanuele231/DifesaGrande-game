extends Control

# Area Record
@onready var punteggioRifiuti = $VBoxContainer/MinigiocoRifiuti/Punteggio
@onready var punteggioVandalo = $VBoxContainer/MinigiocoVandalo/Punteggio
@onready var punteggioBracconiere = $VBoxContainer/MinigiocoBracconiere/Punteggio
@onready var punteggioIncendio = $VBoxContainer/MinigiocoIncendio/Punteggio


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	punteggioRifiuti.text = str(SingletonStats.get_punteggio(0))
	punteggioVandalo.text = str(SingletonStats.get_punteggio(1))
	punteggioBracconiere.text = str(SingletonStats.get_punteggio(2))
	punteggioIncendio.text = str(SingletonStats.get_punteggio(3))
