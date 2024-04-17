extends Control

func _input(event: InputEvent) -> void:
	if event is InputEventJoypadButton and event.is_pressed():
		if Input.is_joy_button_pressed(JOY_BUTTON_A, JOY_BUTTON_RIGHT_SHOULDER):
			_on_capito_button_down()

func _ready():
	$Label.z_index = 3
	$aiuto.z_index = 3
	$"come-aiuto?".z_index = 3
	$capito.z_index = 3

func _on_capito_button_down():
	Engine.time_scale = 1
	$".".hide()
