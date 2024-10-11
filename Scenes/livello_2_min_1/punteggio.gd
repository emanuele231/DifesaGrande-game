extends Control

@onready var back_to_menu = preload("res://Scenes/mappa_game/mappa.tscn") as PackedScene


func _on_button_button_down():
	get_tree().change_scene_to_packed(back_to_menu)
