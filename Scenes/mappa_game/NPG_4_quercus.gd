extends CharacterBody2D

const SPEED = 45.0
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
		var velocity = direction * SPEED
		var collision = move_and_collide(velocity * delta)
		if collision:
			direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
			is_moving = false
			time_accumulator = 0
	else:
		time_accumulator += delta
		if time_accumulator >= pause_duration:
			is_moving = true
