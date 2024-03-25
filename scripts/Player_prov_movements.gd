extends CharacterBody2D

@onready var anim_tree = $AnimationTree
@onready var animazione = anim_tree.get("parameters/playback")

var SPEED = 70
var input_movement = Vector2.ZERO
var can_move: bool = false

func _ready():
	get_node("Sprite2D/Dialogo_01")._on_dialog_complete_callback = self
	
func _on_dialog_complete():
	can_move = true

func _process(delta):
	var player_position = position
	var min_limit = Vector2(-415, -1060)  # Imposta i limiti minimi della mappa
	var max_limit = Vector2(880, 425) 

	player_position.x = clamp(player_position.x, min_limit.x, max_limit.x)
	player_position.y = clamp(player_position.y, min_limit.y, max_limit.y)
	position = player_position





func _physics_process(_delta):
		move()


func move():
	if can_move:
		input_movement = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
		if input_movement != Vector2.ZERO:
			anim_tree.set("parameters/walk/blend_position", input_movement)
			animazione.travel("walk")
			velocity = input_movement * SPEED

		if input_movement == Vector2.ZERO:
			velocity = Vector2.ZERO
		move_and_slide()





