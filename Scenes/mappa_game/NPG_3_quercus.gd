extends CharacterBody2D


const speed = 52.0
var distance = 200
var direction = Vector2.LEFT
@onready var npg_3_anim_tree = $AnimationTree
@onready var animazione = npg_3_anim_tree.get("parameters/playback")

var is_moving = true 
var pause_duration = 2  
var time_accumulator = 0  

var initial_position: Vector2



func _ready():
	initial_position = position

func _process(delta):
	if is_moving:
		var new_position = position + direction * speed * delta
		npg_3_anim_tree.set("parameters/idle/blend_position", direction)
		npg_3_anim_tree.set("parameters/walk/blend_position", direction)
		animazione.travel("walk")
		if (new_position).length() >= distance:
			direction *= -1
			new_position = position + direction * speed * delta
			is_moving = false
			time_accumulator = 0
		else:
			position = new_position
	else:
		animazione.travel("idle")
		time_accumulator += delta
		if time_accumulator >= pause_duration:
			is_moving = true
	
	
