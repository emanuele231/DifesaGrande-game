extends Area2D


@onready var livello_1 = preload("res://Scenes/livello_1/lvl_1_raccolta_rifiuti.tscn") as PackedScene

func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		var player = get_tree().get_nodes_in_group("player")
		if player.is_in_group("player"):
			get_tree().change_scene_to_packed(livello_1)
