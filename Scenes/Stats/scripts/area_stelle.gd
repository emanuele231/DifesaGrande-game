extends Control

# Area Stelle
@onready var stelleVuote = $Stelle
@onready var unaStella = $Stelle2
@onready var dueStelle = $Stelle3
@onready var treStella = $Stelle4
@onready var quattroStelle = $Stelle5
@onready var cinqueStelle = $Stelle6

@onready var fraseBase = $FraseBase
@onready var frase5Stelle = $Frase5Stelle

# Varie costanti
var vittorie_prima_stella = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	init_stelle()

# Inizializza le stelle in base alle vittorie
func init_stelle():
	var totaleVittorie = SingletonStats.get_numero_vittorie(0) + SingletonStats.get_numero_vittorie(1) + SingletonStats.get_numero_vittorie(2) + SingletonStats.get_numero_vittorie(3)
	if totaleVittorie >= vittorie_prima_stella:
		stelleVuote.visible = false
		unaStella.visible = true
	# Continuare per le altre stelle e il cambio di frase alle 5 stelle
