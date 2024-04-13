extends Control

@onready var pausa = $"."
var ripresa: bool = false



func _on_riprendi_button_down():
	ripresa = true
	pausa.hide()
	Engine.time_scale = 1
