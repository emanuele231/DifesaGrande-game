extends Control


var paused: bool = false

func _input(event: InputEvent) -> void:
	if event is InputEventJoypadButton and event.is_pressed():
		if Input.is_joy_button_pressed(JOY_BUTTON_A, JOY_BUTTON_START):
			paused = true

func _ready():
	paused = false
	Engine.time_scale = 1
	$".".z_index = 3


func _on_button_down():
	paused = true
	Engine.time_scale = 0
	$"../Control".show()
