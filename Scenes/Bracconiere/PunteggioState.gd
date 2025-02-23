#PunteggioState.gd
extends State

## Trova i nodi all'interno di CombatScene
##@onready var punteggio_label = get_parent().get_node("CombatScene/PunteggioUI/PunteggioLabel")
##@onready var confermaButton = get_parent().get_node("CombatScene/PunteggioUI/ConfermaButton")

##var punteggio = 100  # Base

##func enter():
   ## punteggio_label.text = "Punteggio Finale: " + str(punteggio)
   ## confermaButton.visible = true
   ## confermaButton.pressed.connect(_on_conferma_pressed)

##func exit():
   ## if confermaButton.pressed.is_connected(_on_conferma_pressed):
   ##     confermaButton.pressed.disconnect(_on_conferma_pressed)
   ## confermaButton.visible = false

##func _on_conferma_pressed():
   ## get_parent().transition_to("FinalState")  # Torna alla mappa
