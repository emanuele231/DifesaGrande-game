extends Area2D

var entered: bool = false


func _on_body_entered(body: CharacterBody2D):
	entered = true

func _on_body_exited(body):
	entered = false

func _process(delta):
	if entered == true:
		if Input.is_key_label_pressed(KEY_C):
			var I_singleton = get_node("/root/Singleton")
			var index = I_singleton.get_custom_index()
			if index < 10:
				indifferenziato()

func indifferenziato():
	var indiff_sin = get_node("/root/SingletonIndiff")
	var indiff = indiff_sin.get_custom_indiff()
	indiff += 1
	indiff_sin.set_indiff(indiff)
	$"../player/Camera2D/punteggi/indifferenziato_rimasto".text = str(indiff)