extends Control

@onready var riavvia = preload("res://Scenes/livello_1/lvl_1_raccolta_rifiuti.tscn")
@onready var pannello_pausa = $"."
var riprendi: bool = false



func _on_riprendi_button_down():
	riprendi = true
	pannello_pausa.hide()
	Engine.time_scale = 1


func _on_riavvia_button_down():
	get_tree().reload_current_scene()
	
