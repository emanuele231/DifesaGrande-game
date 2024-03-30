extends CharacterBody2D


const SPEED = 70
var can_move: bool = false
@onready var anim_ass = $AnimationTree
@onready var animazione = anim_ass.get("parameters/playback")


func _ready():
	get_parent().get_node("player/Sprite2D/spiegazione_1_1")._assessore_1_callback = self


func _assessore_1():
	can_move = true

func _physics_process(_delta):
	move(_delta)
	
func move(_delta):
	if can_move == true:
		var new_position = position + Vector2.DOWN * SPEED * _delta
		anim_ass.set("parameters/walk/blend_position", new_position)
		animazione.travel("walk")
		position = new_position
