extends CharacterBody2D

var speed: float = 100
var player: Node
var direction: Vector2
var is_moving: bool = true

func _ready():
	player = get_node("Player_prov")
	#var player_position = player_node.global_position
	move_towards()

func _process(delta):
	if is_moving:
		direction = (player.global_position - global_position).normalized()
		var new_position = position + direction * speed * delta
		global_position = new_position

func move_towards() -> void:
	is_moving = true
