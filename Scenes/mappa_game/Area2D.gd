extends Area2D

var entered: bool = false
@onready var Raccolta_rifiuti = preload("res://Scenes/livello_1/raccolta_rifiuti_lvl_1.tscn") as PackedScene


func _on_body_entered(body):
	entered = true
	print("siamo dentro")

func _on_body_exited(body):
	entered = false


func _process(delta):
	if entered == true:
		if Input.is_joy_button_pressed(JOY_AXIS_LEFT_X,JOY_BUTTON_X) or Input.is_key_label_pressed(KEY_Y):
			get_tree().change_scene_to_packed(Raccolta_rifiuti)
