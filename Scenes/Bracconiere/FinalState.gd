#FinalState.gd
extends State

##@onready var fine_label = get_parent().get_parent().get_node("FinalState/FineLabel")
##@onready var confermaButton = get_parent().get_parent().get_node("FinalState/ConfermaButton")


##func enter():
	##fine_label.text = "Combattimento terminato."
	##confermaButton.visible = true
	##confermaButton.pressed.connect(_on_conferma_pressed)

##func exit():
	##if confermaButton.pressed.is_connected(_on_conferma_pressed):
		##confermaButton.pressed.disconnect(_on_conferma_pressed)
	##confermaButton.visible = false

##func _on_conferma_pressed():
	# Torna alla mappa principale (da implementare)
	##print("Torna alla mappa!")
