extends Area2D

var entered: bool = true
@onready var Raccolta_rifiuti = preload("res://Scenes/livello_1/raccolta_rifiuti_lvl_1.tscn") as PackedScene

func _on_body_entered(body: PhysicsBody2D):
	entered = true


func _on_body_exited(body):
	entered = false

func _process(delta):
	if entered == true:
		if Input.is_action_just_pressed("ui_accept"):
			get_tree().change_scene_to_packed(Raccolta_rifiuti)
			
