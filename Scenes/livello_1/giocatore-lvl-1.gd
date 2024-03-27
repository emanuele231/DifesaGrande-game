extends CharacterBody2D


var SPEED = 70
var input_movement = Vector2.ZERO
var can_move: bool = false
@onready var anim_tree = $AnimationTree
@onready var animazioni = anim_tree.get("parameters/playback")

func _ready():
	get_node("Sprite2D/spiegazione_1_1")._on_player_1_callback = self

func _on_player_1():
	can_move = true



func _process(delta):
	var player_position = position
	var min_limit = Vector2(-520, -755)  # Imposta i limiti minimi della mappa
	var max_limit = Vector2(860, 905) 

	player_position.x = clamp(player_position.x, min_limit.x, max_limit.x)
	player_position.y = clamp(player_position.y, min_limit.y, max_limit.y)
	position = player_position





func _physics_process(_delta):
		move()


func move():
	if can_move == true:
		input_movement = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
		if input_movement != Vector2.ZERO:
			anim_tree.set("parameters/idle/blend_position", input_movement)
			anim_tree.set("parameters/walk/blend_position", input_movement)
			animazioni.travel("walk")
			velocity = input_movement * SPEED

		if input_movement == Vector2.ZERO:
			animazioni.travel("idle")
			velocity = Vector2.ZERO
		move_and_slide()








