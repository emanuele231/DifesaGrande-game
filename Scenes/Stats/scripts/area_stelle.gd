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


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	init_stelle()

# Inizializza le stelle in base alle vittorie
func init_stelle():
	
	if SingletonStats.tutti_minigiochi_completati() == true:
		stelleVuote.visible = false
		unaStella.visible = true
	# Continuare per le altre stelle e il cambio di frase alle 5 stelle
