extends Node2D

# Called when the node enters the scene tree for the first time.
@onready var bottone_indietro = $Label/Indietro
@onready var bottoneCredits = $MarginContainer/HBoxContainer/VBoxContainer/creditsButton
@onready var labelCredits = $Label


func _ready() -> void:
	labelCredits.visible = false
	bottone_indietro.pressed.connect(gestisci_indietro)
	bottoneCredits.pressed.connect(gestisci_credits)

func _input(event):
	if event is InputEventJoypadButton: 
		if event.button_index == 0 and event.pressed: 
			_on_start_button_down()
		elif event.button_index == 1 and event.pressed:
			_on_esci_button_down()


func _on_start_button_down():
	SceneTransition.change_scene("res://Scenes/mappa_game/mappa.tscn")

func _on_esci_button_down():
	get_tree().quit()
	
func gestisci_indietro():
	labelCredits.visible = false

func gestisci_credits():
	labelCredits.visible = true
	
