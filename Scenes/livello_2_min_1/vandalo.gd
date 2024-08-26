extends CharacterBody2D

var can_run: bool = false
var speed: int = 150
var direction: Vector2 = Vector2.ZERO
var player_position: Vector2 = Vector2.ZERO
var victory: bool = false
var schiva: bool = false

@onready var animation_tree = $AnimationTree
@onready var animation_state = animation_tree.get("parameters/playback")

func _on_rincorri_body_entered(body: CharacterBody2D):
	can_run = true
	player_position = body.position
	direction = (position - player_position).normalized()

func _on_rincorri_body_exited(body):
	can_run = false

func _process(delta):
	var player_position = position
	var min_limit = Vector2(-50, -980)  # Imposta i limiti minimi della mappa
	var max_limit = Vector2(1200, 600) 

	player_position.x = clamp(player_position.x, min_limit.x, max_limit.x)
	player_position.y = clamp(player_position.y, min_limit.y, max_limit.y)
	position = player_position

func _physics_process(delta):
	if can_run:
		if schiva:
			direction = change_direction_90_degrees(direction)
			schiva = false  # Reset the flag after changing direction
		else:
			direction = (position - player_position).normalized()
		move(delta)

func move(delta):
	var motion = direction * speed * delta
	position += motion
	update_animation(motion)

func change_direction_90_degrees(current_direction: Vector2) -> Vector2:
	var new_direction = current_direction.rotated(deg_to_rad(90))
	return new_direction

func _ready():
	randomize()

func update_animation(motion: Vector2):
	if motion.length() > 0:
		animation_state.travel("walk")
	else:
		animation_state.travel("idle")

func _on_catturato_body_entered(body: CharacterBody2D):
	victory = true

func _on_catturato_body_exited(body):
	victory = false

func _on_changedirection_body_entered(body: CharacterBody2D):
	schiva = true

func _on_changedirection_body_exited(body):
	schiva = false
