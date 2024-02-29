extends CharacterBody2D


const speed = 50.0
var distance = 75
var direction = Vector2.UP

var is_moving = true 
var pause_duration = 2  
var time_accumulator = 0  

var initial_position: Vector2



func _ready():
	initial_position = position

func _process(delta):
	if is_moving:
		var new_position = position + direction * speed * delta
		if (new_position - initial_position).length() >= distance:
			direction *= -1
			new_position = position + direction * speed * delta
			is_moving = false
			time_accumulator = 0
		else:
			position = new_position
	else:
		time_accumulator += delta
		if time_accumulator >= pause_duration:
			is_moving = true
	
	

