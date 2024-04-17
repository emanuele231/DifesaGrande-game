extends Area2D

var entered: bool = false


func _on_body_entered(body: CharacterBody2D):
	entered = true


func _on_body_exited(body):
	entered = false

func _process(delta):
	if entered == true:
		if Input.is_joy_button_pressed(JOY_BUTTON_A, JOY_BUTTON_A) or Input.is_action_just_pressed("ui_accept"):
			var p_singleton = get_node("/root/Singleton")
			var index = p_singleton.get_custom_index()
			if index < 10:
				plastica()

func plastica():
	var plastica_sin = get_node("/root/SingletonPlastica")
	var plastica = plastica_sin.get_custom_plastica()
	plastica += 1
	plastica_sin.set_plastica(plastica)
	print(plastica)
	$"../player/Camera2D/CanvasLayer/punteggi/capienza_sacco".text = str(plastica)

