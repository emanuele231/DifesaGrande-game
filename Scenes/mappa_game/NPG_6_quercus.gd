extends CharacterBody2D

const speed = 45.0
var distance = 100
var direction = Vector2.RIGHT

var is_moving = true 
var pause_duration = 5  
var time_accumulator = 0  
var initial_position: Vector2

func _ready():
	initial_position = position

func _process(delta):
	if is_moving:
		var new_position = position + direction * speed * delta
		if (new_position - initial_position).length() >= distance:
			direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized() # Modifica la direzione in modo casuale
			new_position = position + direction * speed * delta
			is_moving = false
			time_accumulator = 0
		else:
			position = new_position
	else:
		time_accumulator += delta
		if time_accumulator >= pause_duration:
			is_moving = true

	
	
