extends Control

@onready var pannello_pausa = $"../../pausa-panel"
var paused: bool = false

func _input(event: InputEvent) -> void:
	if event is InputEventJoypadButton and event.is_pressed():
		if Input.is_joy_button_pressed(JOY_BUTTON_A, JOY_BUTTON_START):
			_on_button_button_down()
			paused = true

func _ready():
	paused = false
	pannello_pausa.hide()
	Engine.time_scale = 1
	$Button.z_index = 3



func _on_button_button_down():
	paused = true
	pannello_pausa.show()
	Engine.time_scale = 0

	
