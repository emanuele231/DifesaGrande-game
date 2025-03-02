extends State

@onready var difesaUI = get_parent().get_parent().get_node("CanvasLayer/PunteggioUI")
@onready var punteggio_label = get_parent().get_parent().get_node("CanvasLayer/PunteggioUI/punti")
@onready var mappaButton = get_parent().get_parent().get_node("CanvasLayer/PunteggioUI/Button")

@onready var scena_mappa = preload("res://Scenes/mappa_game/mappa.tscn")  # Sostituisci con il percorso corretto

func enter():
	difesaUI.visible = true
	punteggio_label.text = str(PunteggioBracconiere.punteggio)
	mappaButton.visible = true
	if not mappaButton.pressed.is_connected(_on_mappa_pressed):
		mappaButton.pressed.connect(_on_mappa_pressed)

func exit():
	mappaButton.pressed.disconnect(_on_mappa_pressed)
	get_parent().transition_to("FinalState")

func _on_mappa_pressed():
	print("Caricamento scena mappa...")  # Debug
	get_tree().change_scene_to_packed(scena_mappa)
