extends Area2D

var entered: bool = false
@onready var Raccolta_rifiuti = preload("res://Scenes/livello_1/raccolta_rifiuti_lvl_1.tscn") as PackedScene

func _on_body_entered(body: CharacterBody2D):
	entered = true


func _on_body_exited(body):
	entered = false

func _process(delta):
	if entered == true:
		if Input.is_joy_button_pressed(JOY_BUTTON_Y,JOY_BUTTON_Y):
			get_tree().change_scene_to_packed(Raccolta_rifiuti)

