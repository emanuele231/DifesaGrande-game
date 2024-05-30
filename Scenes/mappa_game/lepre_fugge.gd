extends Area2D

var can_move: bool = false
var SPEED: int = 80



func _on_body_entered(body: CharacterBody2D):
	can_move = true
	print("ok")


func _on_body_exited(body: CharacterBody2D):
	can_move = false

func _physics_process(delta):
		move(delta)
	
func move(delta):
	var new_position = position + Vector2.DOWN * SPEED * delta
	position = new_position


