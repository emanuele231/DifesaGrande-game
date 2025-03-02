#FinalState.gd
extends State

@onready var scena_mappa = preload("res://Scenes/mappa_game/mappa.tscn")  # Sostituisci con il percorso corretto
##@onready var fine_label = get_parent().get_parent().get_node("FinalState/FineLabel")
##@onready var confermaButton = get_parent().get_parent().get_node("FinalState/ConfermaButton")


func enter():
	print("Caricamento scena mappa...") 
	get_tree().change_scene_to_packed(scena_mappa)

#func exit():
	##if confermaButton.pressed.is_connected(_on_conferma_pressed):
		##confermaButton.pressed.disconnect(_on_conferma_pressed)
	##confermaButton.visible = false

##func _on_conferma_pressed():
	# Torna alla mappa principale (da implementare)
	##print("Torna alla mappa!")
