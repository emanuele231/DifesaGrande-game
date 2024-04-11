extends Control

var timer_script = preload("res://Scenes/livello_1/punteggi.gd")
var timer = timer_script.new()

func _ready():
	pannello_finale()

func pannello_finale():
	if timer.end == false:
		hide() 
	else:
		show()
