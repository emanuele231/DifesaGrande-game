# SelectState.gd
extends State

@onready var speakButton = $SpeakButton
@onready var fugaButton = $FugaButton
@onready var istruzioni = $Istruzioni

func enter():
	speakButton.visible = true
	fugaButton.visible = true
	istruzioni.text = "Scegli un'azione: Parla o Fuga."

	speakButton.pressed.connect(_on_parla_pressed)
	fugaButton.pressed.connect(_on_fuga_pressed)

func exit():
	speakButton.visible = false
	fugaButton.visible = false

	# Disconnessione con controllo per evitare errori
	if speakButton.pressed.is_connected(_on_parla_pressed):
		speakButton.pressed.disconnect(_on_parla_pressed)

	if fugaButton.pressed.is_connected(_on_fuga_pressed):
		fugaButton.pressed.disconnect(_on_fuga_pressed)

func _on_parla_pressed():
	get_parent().transition_to("ParlaState")


func _on_fuga_pressed():
	get_parent().transition_to("FinalState")
  # Gestisci il ritorno alla mappa principale
