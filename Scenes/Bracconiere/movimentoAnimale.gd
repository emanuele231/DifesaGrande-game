extends CharacterBody2D

@export var speed: float = 200.0  # Velocità del personaggio in pixel/sec
@onready var animation_player = $AnimationPlayer  # Riferimento all'AnimationPlayer

func _ready():
	animation_player.play("movimentoAnimale")  # Avvia subito l'animazione e la tiene sempre attiva


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

	# Normalizza la direzione per il movimento diagonale
	if direction.length() > 0:
		direction = direction.normalized()
		velocity = direction * speed  # Imposta la velocità del personaggio
		
	else:
		velocity = Vector2.ZERO

	move_and_slide()  # Movimento con la fisica
