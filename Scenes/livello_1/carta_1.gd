extends Area2D

var entered: bool = false
var punteggi_script = preload("res://Scenes/livello_1/punteggi.gd")
var punteggi = punteggi_script.new()

func _on_body_entered(body: CharacterBody2D):
	entered = true

func _on_body_exited(body):
	entered = false


func _process(delta):
	if entered == true:
		if Input.is_key_label_pressed(KEY_C):
			punteggi.object_found()
			free()
