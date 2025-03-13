extends CharacterBody2D

@export var speed: float = 200.0  
@export var min_x: float = -460
@export var max_x: float = -21  
@export var min_y: float = -313
@export var max_y: float = 181  
@onready var animation_player = $AnimationPlayer 

func _ready():
	position.x = -45
	position.y = -42
	animation_player.play("movimentoAnimale")  
	add_to_group("animale") 
	print("Animale inizializzato, posizione:", global_position)

func _physics_process(delta):
	var direction = Vector2.ZERO 

	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1
	# Normalizza la direzione per evitare velocità eccessive nei movimenti diagonali
	if direction.length() > 0:
		direction = direction.normalized()
		velocity = direction * speed  
	else:
		velocity = Vector2.ZERO
	move_and_slide()  
	
	position.x = clamp(position.x, min_x, max_x)
	position.y = clamp(position.y, min_y, max_y)
