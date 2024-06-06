extends Area2D

var entered: bool = false
@onready var Caccia_al_Vandalo = preload("res://Scenes/livello_2_min_1/acchiappa_il_vandalo_1.tscn") as PackedScene


func _on_body_entered(body: CharacterBody2D):
	entered = true

func _on_body_exited(body):
	entered = false
	
func _process(delta):
	if entered == true:
		if Input.is_joy_button_pressed(JOY_AXIS_LEFT_X,JOY_BUTTON_X) or Input.is_action_just_pressed("ui_accept"):
			get_tree().change_scene_to_packed(Caccia_al_Vandalo)


