extends CharacterBody2D

var can_move: bool = false
var SPEED: int = 10

func _on_scappa_body_entered(body: CharacterBody2D):
	can_move = true


func _on_scappa_body_exited(body: CharacterBody2D):
	can_move = false



func _physics_process(delta):
	if can_move == true:
		move(delta)
	
func move(delta):
	var new_position = position + Vector2.RIGHT * SPEED * delta
	position = new_position

