extends CharacterBody2D


const SPEED = 70
var can_move: bool = false
var can_talk: bool = false
signal now_you_can_talk

func _ready():
	get_parent().get_node("Player_prov/Sprite2D/Dialogo_02")._assessore_2_callback = self


func _assessore_2():
	can_move = true

func _physics_process(_delta):
	move(_delta)
	
func move(_delta):
	if can_move == true:
		var new_position = position + Vector2.DOWN * SPEED * _delta
		position = new_position


func _on_area_2d_body_entered(body: CharacterBody2D):
		can_talk = true
		emit_signal("now_you_can_talk")
		print("ok")


func _on_area_2d_body_exited(body: CharacterBody2D):
	can_talk = false



