extends Control

var pausa_script = preload("res://Scenes/livello_1/pausa.gd")
var pausa = pausa_script.new()
@onready var pannello_pausa = $"."
var riprendi: bool = false

func _input(event: InputEvent) -> void:
			if Input.is_joy_button_pressed(JOY_BUTTON_A, JOY_BUTTON_B):
				_on_riprendi_1_button_down()
			elif Input.is_joy_button_pressed(JOY_BUTTON_A, JOY_BUTTON_Y)and pausa.paused == true:
				_on_riavvia_1_button_down()
			elif Input.is_joy_button_pressed(JOY_BUTTON_A, JOY_BUTTON_X)and pausa.paused == true:
				_on_back_1_button_down()
			

func _ready():
	$".".z_index = 3
	$Label.z_index = 3
	$riprendi1.z_index = 3
	$riavvia1.z_index = 3
	$back1.z_index = 3
	
	


func _on_riprendi_1_button_down():
	riprendi = true
	pannello_pausa.hide()
	Engine.time_scale = 1




func _on_riavvia_1_button_down():
	get_tree().reload_current_scene()


func _on_back_1_button_down():
	var back = preload("res://Scenes/mappa_game/mappa.tscn") as PackedScene
	get_tree().change_scene_to_packed(back)
