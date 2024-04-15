extends Area2D

var entered: bool = false





func _on_body_entered(body: CharacterBody2D):
	entered = true 


func _on_body_exited(body):
	entered = false

func _process(delta):
	if entered == true and Input.is_joy_button_pressed(JOY_BUTTON_A, JOY_BUTTON_A):
		var singleton = get_node("/root/Singleton")
		var index = singleton.get_custom_index()
		if index < 10:
			carta()

func carta():
	var carta_sin = get_node("/root/SingletonCarta")
	var carta = carta_sin.get_custom_carta()
	carta += 1
	carta_sin.set_carta(carta)
	$"../player/Camera2D/punteggi/carta_rimasta".text = str(carta)



