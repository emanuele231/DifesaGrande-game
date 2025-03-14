extends CharacterBody2D


var SPEED = 100
var input_movement = Vector2.ZERO
var can_move: bool = false
@onready var anim_tree = $AnimationTree
@onready var animazioni = anim_tree.get("parameters/playback")
var points_script = preload("res://Scenes/livello_2_min_1/timer.gd")
var points = points_script.new()

##prende il sistema di dialogo del vandalo (?)
func _ready():
	get_node("Sprite2D/Camera2D/CanvasLayer/dialogo_min_2")._on_player_2_callback = self
	$Sprite2D/Camera2D/CanvasLayer/punteggio.hide()
	$Sprite2D/Camera2D/CanvasLayer/punteggio.z_index = 4
	
func _on_player_2():
	can_move = true


##limiti mappa
func _process(delta):
	var player_position = position
	var min_limit = Vector2(-200, -1180)  # Imposta i limiti minimi della mappa
	var max_limit = Vector2(1400, 800) 

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



##cattura del vandalo
func _on_catturato_body_entered(body: CharacterBody2D):
	if Input.is_key_label_pressed(KEY_A):
		Engine.time_scale = 0
		$Sprite2D/Camera2D/CanvasLayer/punteggio.show()
		$Sprite2D/Camera2D/CanvasLayer/dialogo_min_2/indicazione.hide()



func _on_catturato_body_exited(body):
	pass




func _on_area_2d_body_entered(body: CharacterBody2D):
	$Sprite2D/Camera2D/CanvasLayer/dialogo_min_2/indicazione.show()


func _on_area_2d_body_exited(body):
	$Sprite2D/Camera2D/CanvasLayer/dialogo_min_2/indicazione.hide()
