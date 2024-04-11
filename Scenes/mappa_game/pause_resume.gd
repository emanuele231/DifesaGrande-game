extends Control

@onready var Start_level = preload("res://Scenes/menu/menu.tscn") as PackedScene

func _ready():
	$"../pausa/Label".hide()
	$"../pausa/Label".z_index = 3
	$"../pausa/riprendi".z_index = 3
	$"../pausa/back".z_index = 3
	$"../pausa/riprendi".hide()
	$"../pausa/back".hide()
	
func _on_button_pressed():
	$"../pausa/Label".show()
	Engine.time_scale = 0
	$Button.hide()
	$"../pausa/riprendi".show()
	$"../pausa/back".show()


func _on_riprendi_pressed():
	Engine.time_scale = 1
	$"../pausa".hide()
	$Button.show()
	$"../pausa/back".hide()

func _on_back_pressed():
	get_tree().change_scene_to_packed(Start_level)
