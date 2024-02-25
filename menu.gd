class_name menu
extends Control

@onready var Start = $MarginContainer/HBoxContainer/VBoxContainer/Start as Button
@onready var Esci = $MarginContainer/HBoxContainer/VBoxContainer/Esci as Button
@onready var Start_level = preload("res://Scenes/mappa_game/mappa.tscn") as PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	Start.button_down.connect(on_start_pressed)
	Esci.button_down.connect(on_exit_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func on_start_pressed() -> void:
	get_tree().change_scene_to_packed(Start_level)

func on_exit_pressed() -> void:
	get_tree().quit()
