extends CharacterBody2D

var can_move: bool = false
var normal_speed: int = 10
var fast_speed: int = 70
var current_speed: int = normal_speed
var direction: Vector2 = Vector2.ZERO
var time_passed: float = 0.0
var change_interval: float = 2.0


func _on_scappa_body_entered(body: CharacterBody2D):
	can_move = false
	current_speed = fast_speed
	set_escape_direction(body.position)



func _on_scappa_body_exited(body):
	can_move = false
	current_speed = normal_speed
	



func _physics_process(delta):
	if can_move == true:
		time_passed += delta
		if time_passed >= change_interval:
			randomize_direction()
			time_passed = 0.0 
		move_in(delta)


func move_out(delta):
	var new_position = position + direction * normal_speed * delta
	position = new_position
	
	
	
func move_in(delta):
	var new_position = position + direction * current_speed * delta
	position = new_position

func randomize_direction():
	var angle = randf_range(0, 2 * PI) 
	direction = Vector2(cos(angle), sin(angle)).normalized()

func _on_timer_timeout():
	randomize_direction()

func set_escape_direction(player_position: Vector2):
	var escape_angle: float = 0.0
	var diff = position - player_position
	if abs(diff.x) > abs(diff.y):
		if diff.x > 0:
			escape_angle = randf_range(-PI/4, PI/4)
		else:
			escape_angle = randf_range(3*PI/4, 5*PI/4)
	else:
		if diff.y > 0:
			escape_angle = randf_range(PI/4, 3*PI/4)
		else:
			escape_angle = randf_range(5*PI/4, 7*PI/4)
			direction = Vector2(cos(escape_angle), sin(escape_angle)).normalized()
