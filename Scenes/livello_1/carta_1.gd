extends Area2D


var entered: bool = true

func _on_body_entered(body: PhysicsBody2D):
	entered = true


func _on_body_exited(body: PhysicsBody2D):
	entered = false

func _process(delta):
	if entered == true:
		if Input.is_key_label_pressed(KEY_C):
			free()
