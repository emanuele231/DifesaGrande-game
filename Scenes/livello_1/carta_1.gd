extends Area2D

var entered: bool = false

func _on_body_entered(body: CharacterBody2D):
	entered = true

func _on_body_exited(body):
	entered = false


func _process(delta):
	if entered == true:
		if Input.is_key_label_pressed(KEY_C):
			free()
