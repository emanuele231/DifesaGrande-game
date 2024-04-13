
extends Node2D

# Called when the node enters the scene tree for the first time.



func _on_start_button_down():
	var Start_level = preload("res://Scenes/mappa_game/mappa.tscn") as PackedScene
	get_tree().change_scene_to_packed(Start_level)




func _on_esci_button_down():
	get_tree().quit()
