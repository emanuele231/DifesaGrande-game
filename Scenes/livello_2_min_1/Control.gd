extends Control

var pausa_script = preload("res://Scenes/livello_1/pausa.gd")
var pausa = pausa_script.new()
var riprendi: bool = false

func _input(event: InputEvent) -> void:
			if Input.is_joy_button_pressed(JOY_BUTTON_A, JOY_BUTTON_B):
				_on_riprendi_button_down()
			elif Input.is_joy_button_pressed(JOY_BUTTON_A, JOY_BUTTON_Y)and pausa.paused == true:
				_on_ricomincia_button_down()
			elif Input.is_joy_button_pressed(JOY_BUTTON_A, JOY_BUTTON_X)and pausa.paused == true:
				_on_torna_al_menù_button_down()
				
func _ready():
	$Riprendi.z_index = 3
	$Ricomincia.z_index = 3
	$"Torna al menù".z_index = 3
	$Label.z_index = 3


func _on_riprendi_button_down():
	riprendi = true
	$".".hide()
	Engine.time_scale = 1





func _on_ricomincia_button_down():
	pass # Replace with function body.


func _on_torna_al_menù_button_down():
	pass # Replace with function body.
