extends Area2D

var entered: bool = false


func _on_body_entered(body: CharacterBody2D):
	entered = true


func _on_body_exited(body):
	entered = false

func _process(delta):
	if entered == true:
		if Input.is_key_label_pressed(KEY_C):
			var p_singleton = get_node("/root/Singleton")
			var index = p_singleton.get_custom_index()
			if index < 10:
				plastica()

func plastica():
	var plastica_sin = get_node("/root/SingletonPlastica")
	var plastica = plastica_sin.get_custom_plastica()
	plastica += 1
	plastica_sin.set_plastica(plastica)
	$"../player/Camera2D/punteggi/plastica_rimasta".text = str(plastica)

