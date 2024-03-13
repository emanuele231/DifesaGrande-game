extends CharacterBody2D


const SPEED = 70
var can_move: bool = false


func _ready():
	get_parent().get_node("player/Sprite2D/spiegazione_1_1")._assessore_1_callback = self


func _assessore_1():
	can_move = true

func _physics_process(delta):
	move(delta)
	
func move(delta):
	if can_move == true:
		var new_position = position + Vector2.DOWN * SPEED * delta
		position = new_position
