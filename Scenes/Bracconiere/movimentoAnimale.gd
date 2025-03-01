extends CharacterBody2D

@export var speed: float = 200.0  # Velocità del personaggio in pixel/sec
@export var min_x: float = -460
@export var max_x: float = -21  # Imposta i limiti orizzontali
@export var min_y: float = -313
@export var max_y: float = 181  # Imposta i limiti verticali

@onready var animation_player = $AnimationPlayer  # Riferimento all'AnimationPlayer

func _ready():
	position.x = -45
	position.y = -42
	animation_player.play("movimentoAnimale")  # Avvia subito l'animazione e la tiene sempre attiva
	print("Posizione iniziale globale:", global_position)
	##global_position = Vector2(-45, -42)



func _physics_process(delta):
	var direction = Vector2.ZERO  # Vettore di direzione

	# Controlli con le frecce direzionali
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
		velocity = direction * speed  # Imposta la velocità del personaggio
	else:
		velocity = Vector2.ZERO

	move_and_slide()  # Movimento con la fisica
	
	##print("posizione",position)

	# Limita la posizione ai confini della schermata
	position.x = clamp(position.x, min_x, max_x)
	position.y = clamp(position.y, min_y, max_y)
