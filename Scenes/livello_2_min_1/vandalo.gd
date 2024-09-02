extends CharacterBody2D

var can_run: bool = false
var speed: int = 150
var direction: Vector2 = Vector2.ZERO
var player_position: Vector2 = Vector2.ZERO
var victory: bool = false
var schiva: bool = false

@onready var animation_tree = $AnimationTree
@onready var animation_state = animation_tree.get("parameters/playback")



func _process(delta):
	var player_position = position
	var min_limit = Vector2(-50, -980)  
	var max_limit = Vector2(1200, 600) 
	player_position.x = clamp(player_position.x, min_limit.x, max_limit.x)
	player_position.y = clamp(player_position.y, min_limit.y, max_limit.y)
	position = player_position





