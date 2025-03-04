#SelectState.gd
extends State

@onready var selectUI = get_parent().get_parent().get_node("CanvasLayer/SelectUI")
@onready var speakButton = get_parent().get_parent().get_node("CanvasLayer/SelectUI/Bottom/ActionButtons/SpeakButton")
@onready var fugaButton = get_parent().get_parent().get_node("CanvasLayer/SelectUI/Bottom/ActionButtons/FugaButton")
@onready var istruzioni = get_parent().get_parent().get_node("CanvasLayer/SelectUI/Bottom/Istruzioni")
@onready var animationPlayer = get_parent().get_parent().get_node("Sprite2D/AnimationPlayer")
@onready var playerBar = get_parent().get_parent().get_node("CanvasLayer/PlayerBar")

@onready var scena_mappa = preload("res://Scenes/mappa_game/mappa.tscn")

func enter():
	selectUI.visible = true
	playerBar.visible = true
	istruzioni.text = "Convinci il bracconiere!"

	speakButton.pressed.connect(_on_parla_pressed)
	fugaButton.pressed.connect(_on_fuga_pressed)

func exit():
	selectUI.visible = false

	if speakButton.pressed.is_connected(_on_parla_pressed):
		speakButton.pressed.disconnect(_on_parla_pressed)

	if fugaButton.pressed.is_connected(_on_fuga_pressed):
		fugaButton.pressed.disconnect(_on_fuga_pressed)

func _on_parla_pressed():
	get_parent().transition_to("ParlaState")

func _on_fuga_pressed():
	print("Caricamento scena mappa...")
	get_tree().change_scene_to_packed(scena_mappa)
