extends CharacterBody2D

@onready var anim_tree = $AnimationTree
@onready var animazione = anim_tree.get("parameters/playback")

var SPEED = 70
var RUN_SPEED = 120 
var input_movement = Vector2.ZERO
var can_move: bool = false

func _ready():
	add_to_group("giocatore")
	get_node("Sprite2D/Dialogo_01")._on_dialog_complete_callback = self
	
func _on_dialog_complete():
	can_move = true

func _process(delta):
	var player_position = position
	var min_limit = Vector2(-415, -2690) # -1060 per la zona 1
	var max_limit = Vector2(880, 425) 

	player_position.x = clamp(player_position.x, min_limit.x, max_limit.x)
	player_position.y = clamp(player_position.y, min_limit.y, max_limit.y)
	position = player_position

func _physics_process(_delta):
	move()

func move():
	if can_move:
		input_movement = Vector2.ZERO

		if Input.is_action_pressed("ui_left"):
			input_movement.x = -1
		if Input.is_action_pressed("ui_right"):
			input_movement.x = 1
		if Input.is_action_pressed("ui_up"):
			input_movement.y = -1
		if Input.is_action_pressed("ui_down"):
			input_movement.y = 1

		# Corsa
		var current_speed = SPEED
		if Input.is_action_pressed("ui_shift"):  #ui_shift impostato nella mappa degli input 
			current_speed = RUN_SPEED

		if input_movement != Vector2.ZERO:
			anim_tree.set("parameters/idle/blend_position", input_movement)
			anim_tree.set("parameters/walk/blend_position", input_movement)
			#anim_tree.set("parameters/run/blend_position", input_movement)

			# Impostare un'animazione, per ora lascio quella della camminata
			#if current_speed == RUN_SPEED:
				#animazione.travel("run")
			#else:
			animazione.travel("walk")

			velocity = input_movement.normalized() * current_speed

		if input_movement == Vector2.ZERO:
			animazione.travel("idle")
			velocity = Vector2.ZERO

		move_and_slide()
