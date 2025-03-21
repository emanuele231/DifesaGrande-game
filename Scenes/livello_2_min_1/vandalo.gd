extends CharacterBody2D

var can_run: bool = false
var speed: int = 180
var direction: Vector2 = Vector2.ZERO
var player_position: Vector2 = Vector2.ZERO
var victory: bool = false

@onready var animation_tree = $AnimationTree
@onready var animation_state = animation_tree.get("parameters/playback")
@onready var fuga_timer = $Timer

func _process(delta):
	var player_position = position
	var min_limit = Vector2(-130, -835)  
	var max_limit = Vector2(1450, 1150) 
	player_position.x = clamp(player_position.x, min_limit.x, max_limit.x)
	player_position.y = clamp(player_position.y, min_limit.y, max_limit.y)
	position = player_position

func _on_rincorri_body_entered(body: CharacterBody2D):
	can_run = true
	fuga_timer.start(3.0)
	fugaSu()

func _on_rincorri_body_exited(body):
	if fuga_timer.is_stopped():
		can_run = false

func _physics_process(delta):
	if can_run:
		move(delta)

func fugaDestra():
	direction = Vector2.RIGHT

func fugaSinistra():
	direction = Vector2.LEFT

func fugaSu():
	direction = Vector2.UP

func fugaGiu():
	direction = Vector2.DOWN

func move(delta):
	var motion = direction * speed * delta
	position += motion
	update_animation(motion)

func update_animation(motion: Vector2):
	if motion.length() > 0 and can_run == true:
		if direction == Vector2.RIGHT:
			animation_state.travel("walk_right")
		elif direction == Vector2.LEFT:
			animation_state.travel("walk_left")
		elif direction == Vector2.UP:
			animation_state.travel("walk_up")
		elif direction == Vector2.DOWN:
			animation_state.travel("walk_down")
	elif can_run == false:
		if direction == Vector2.RIGHT:
			animation_state.travel("idle_right")
		elif direction == Vector2.LEFT:
			animation_state.travel("idle_left")
		elif direction == Vector2.UP:
			animation_state.travel("idle_up")
		elif direction == Vector2.DOWN:
			animation_state.travel("idle_down")

# Segnali per gestire il movimento in diverse direzioni
func _on_rincorrisu_body_entered(body: CharacterBody2D):
	can_run = true
	fugaSinistra()

func _on_rincorrisu_body_exited(body):
	can_run = false

func _on_rincorrigiu_body_entered(body: CharacterBody2D):
	can_run = true
	fuga_timer.start(3.0)
	fugaDestra()

func _on_rincorrigiu_body_exited(body):
	if fuga_timer.is_stopped():
		can_run = false

func _on_rincorrisinistra_body_entered(body: CharacterBody2D):
	can_run = true
	fugaGiu()

func _on_rincorrisinistra_body_exited(body):
	can_run = false

func _on_changedirection_body_entered(body: CharacterBody2D):
	can_run = true
	fugaSu()

func _on_changedirection_body_exited(body):
	can_run = true

func _on_changedirectionopposite_body_entered(body: CharacterBody2D):
	can_run = true
	fugaGiu()

func _on_changedirectionopposite_body_exited(body):
	can_run = true

func _on_lookaround_body_entered(body: CharacterBody2D):
	can_run = true
	fugaDestra()

func _on_lookaround_body_exited(body):
	can_run = true

func _on_scappa_body_entered(body: CharacterBody2D):
	can_run = true

func _on_scappa_body_exited(body):
	can_run = false

func _on_lookaroundopposite_body_entered(body: CharacterBody2D):
	can_run = true
	fugaSinistra()

func _on_lookaroundopposite_body_exited(body):
	can_run = true
