extends Control


@onready var pannello_pausa = $"."
var riprendi: bool = false



func _on_riprendi_button_down():
	riprendi = true
	pannello_pausa.hide()
	Engine.time_scale = 1
