# FinalState.gd
extends State

@onready var fine_label = $FineLabel
@onready var confermaButton = $ConfermaButton

func enter():
	fine_label.text = "Combattimento terminato."
	confermaButton.visible = true
	confermaButton.pressed.connect(_on_conferma_pressed)

func exit():
	if confermaButton.pressed.is_connected(_on_conferma_pressed):
		confermaButton.pressed.disconnect(_on_conferma_pressed)
	confermaButton.visible = false

func _on_conferma_pressed():
	# Torna alla mappa principale (da implementare)
	print("Torna alla mappa!")
