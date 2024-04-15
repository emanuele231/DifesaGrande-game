extends Control

@onready var pannello_pausa = $"."
var riprendi: bool = false

func _ready():
	$".".z_index = 3
	$Label.z_index = 3
	$riprendi.z_index = 3
	$riavvia.z_index = 3
	$back.z_index = 3

func _on_riprendi_button_down():
	riprendi = true
	pannello_pausa.hide()
	Engine.time_scale = 1


func _on_riavvia_button_down():
	get_tree().reload_current_scene()
	


func _on_back_button_down():
	var back = preload("res://Scenes/mappa_game/mappa.tscn") as PackedScene
	get_tree().change_scene_to_packed(back)
