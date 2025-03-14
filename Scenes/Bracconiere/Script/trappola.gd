extends Area2D

@onready var animationPlayer = $Sprite2D/AnimationPlayer

signal trappola_eliminata(trappola)

func _ready():
	animationPlayer.play("trappola")

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("Trappola eliminata")
		emit_signal("trappola_eliminata", self)
