extends Control

@onready var pausa = $"." 
var ripresa: bool = false

func _ready():
	$".".z_index = 3

func _on_riprendi_button_down():
	ripresa = true
	pausa.hide()
	Engine.time_scale = 1
	
	


func _on_back_button_down():
	get_tree().quit()
