extends Control

@onready var pausa = $"." 
var ripresa: bool = false

func _input(event: InputEvent) -> void:
	if event is InputEventJoypadButton and event.is_pressed():
		if Input.is_joy_button_pressed(JOY_BUTTON_A, JOY_BUTTON_B):
			_on_riprendi_button_down()
		elif Input.is_joy_button_pressed(JOY_BUTTON_A, JOY_BUTTON_X):
			_on_back_button_down()

func _ready():
	$".".z_index = 3
	var p_position = position

func _on_riprendi_button_down():
	ripresa = true
	pausa.hide()
	Engine.time_scale = 1
	
	
func _on_back_button_down():
	get_tree().quit()
