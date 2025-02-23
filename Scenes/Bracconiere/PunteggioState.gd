# PunteggioState.gd
extends State

##@onready var punteggio_label = $PunteggioLabel
##@onready var confermaButton = $ConfermaButton

##var punteggio = 100  # Base

##func enter():
   ## punteggio_label.text = "Punteggio Finale: " + str(punteggio)
	##confermaButton.visible = true
	##confermaButton.pressed.connect(_on_conferma_pressed)

##func exit():
   ## if confermaButton.pressed.is_connected(_on_conferma_pressed):
	 ##   confermaButton.pressed.disconnect(_on_conferma_pressed)
	##confermaButton.visible = false

##func _on_conferma_pressed():
  ##  get_parent().transition_to("res://FinalState.tscn")  # Torna alla mappa
