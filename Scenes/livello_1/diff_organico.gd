extends Area2D

var entered: bool = false


func _on_body_entered(body: CharacterBody2D):
	entered = true


func _on_body_exited(body):
	entered = false

func _process(delta):
	if entered == true:
		if Input.is_key_label_pressed(KEY_C):
			var o_singleton = get_node("/root/Singleton")
			var index = o_singleton.get_custom_index()
			if index < 10:
				organico()

func organico():
	var organico_sin = get_node("/root/SingletonOrganico")
	var organico = organico_sin.get_custom_organico()
	organico += 1
	organico_sin.set_organico(organico)
	$"../player/Camera2D/CanvasLayer/punteggi/organico_rimasto".text = str(organico)

