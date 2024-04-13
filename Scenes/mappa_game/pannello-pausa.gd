extends Control

@onready var pausa = $"."
@onready var rigioca = preload("res://Scenes/livello_1/lvl_1_raccolta_rifiuti.tscn") as PackedScene
var ripresa: bool = false



func _on_riprendi_button_down():
	ripresa = true
	pausa.hide()
	Engine.time_scale = 1
	
	
