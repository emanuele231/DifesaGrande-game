extends CharacterBody2D


var SPEED = 150
var input_movement = Vector2.ZERO
var can_move: bool = true



func _physics_process(delta):
	
	move()

	


func move():
	if can_move:
		input_movement = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
		if input_movement != Vector2.ZERO:
			velocity = input_movement * SPEED

		if input_movement == Vector2.ZERO:
			velocity = Vector2.ZERO
	
		move_and_slide()


