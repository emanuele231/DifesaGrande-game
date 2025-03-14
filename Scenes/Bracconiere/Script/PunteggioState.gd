extends State

@onready var difesaUI = get_parent().get_parent().get_node("UI/PunteggioUI")
@onready var punteggio_label = get_parent().get_parent().get_node("UI/PunteggioUI/punti")
@onready var mappaButton = get_parent().get_parent().get_node("UI/PunteggioUI/Button")
@onready var sprite = get_parent().get_parent().get_node("Sprite2D")
@onready var bracconiereBar = get_parent().get_parent().get_node("UI/ConvinzioneBracconiere")
@onready var scena_mappa = preload("res://Scenes/mappa_game/mappa.tscn") 

func enter():
	sprite.visible = false
	difesaUI.visible = true
	bracconiereBar.visible = false
	punteggio_label.text = str(PunteggioBracconiere.punteggio)
	mappaButton.visible = true
	if not mappaButton.pressed.is_connected(_on_mappa_pressed):
		mappaButton.pressed.connect(_on_mappa_pressed)

func exit():
	mappaButton.pressed.disconnect(_on_mappa_pressed)

func _on_mappa_pressed():
	print("Caricamento scena mappa...") 
	get_tree().change_scene_to_packed(scena_mappa)
