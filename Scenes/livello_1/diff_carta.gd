extends Area2D

var entered: bool = false
var carta: int = 0


func _on_body_entered(body: CharacterBody2D):
	entered = true 


func _on_body_exited(body):
	entered = false

func _process(delta):
	if entered == true and Input.is_key_label_pressed(KEY_C):
		carta += 1
		print("ok")
		$"../player/Camera2D/punteggi/carta_rimasta".text = str(carta)
