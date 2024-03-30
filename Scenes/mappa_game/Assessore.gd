extends CharacterBody2D


const SPEED = 70
var can_move: bool = false
@onready var anim_ass = $AnimationTree
@onready var animazione = anim_ass.get("parameters/playback")


func _ready():
	get_parent().get_node("Player_prov/Sprite2D/Dialogo_01")._assessore_callback = self

func _on_dialogo_completato():
	can_move = true

func _physics_process(delta):
	move(delta)
	
func move(delta):
	if can_move == true:
		var new_position = position + Vector2.DOWN * SPEED * delta
		anim_ass.set("parameters/walk/blend_position", new_position)
		animazione.travel("walk")
		position = new_position



