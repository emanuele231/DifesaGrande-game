extends CharacterBody2D


const SPEED = 70
var can_move: bool = false


func _ready():
	get_parent().get_node("Player_prov/Sprite2D/Dialogo_01")._assessore_callback = self


func _on_dialogo_completato():
	can_move = true

func _physics_process(delta):
	move(delta)
	
func move(delta):
	if can_move == true:
		var new_position = position + Vector2.DOWN * SPEED * delta
		position = new_position





	

