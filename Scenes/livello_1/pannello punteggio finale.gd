extends Control

func _ready():
	$Button.z_index = 3


func _on_button_button_down():
	var back_to_map = preload("res://Scenes/mappa_game/mappa.tscn") as PackedScene
	get_tree().change_scene_to_packed(back_to_map)
