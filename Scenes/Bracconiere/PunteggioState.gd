#PunteggioState.gd
extends State

@onready var difesaUI = get_parent().get_parent().get_node("PunteggioUI")
@onready var punteggio_label = get_parent().get_parent().get_node("PunteggioUI/punti")
##@onready var confermaButton = get_parent().get_node("CombatScene/PunteggioUI/ConfermaButton")

##var punteggio = 100  # Base

func enter():
	difesaUI.visible = true
	punteggio_label.text = str(PunteggioBracconiere.punteggio)
   ## confermaButton.visible = true
   ## confermaButton.pressed.connect(_on_conferma_pressed)

func exit():
	get_parent().transition_to("FinalState") 
   ## if confermaButton.pressed.is_connected(_on_conferma_pressed):
   ##     confermaButton.pressed.disconnect(_on_conferma_pressed)
   ## confermaButton.visible = false

##func _on_conferma_pressed():
   ## get_parent().transition_to("FinalState")  # Torna alla mappa
