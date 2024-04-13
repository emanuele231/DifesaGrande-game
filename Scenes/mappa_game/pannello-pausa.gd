extends Control

@onready var pausa = $"." 
var ripresa: bool = false



func _on_riprendi_button_down():
	ripresa = true
	pausa.hide()
	Engine.time_scale = 1
	
	


func _on_back_button_down():
	var rigioca = preload("res://Scenes/menu/menu.tscn") as PackedScene
	get_tree().change_scene_to_packed(rigioca)
