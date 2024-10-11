extends Area2D

var entered: bool = false

func _ready():
	$"../player/Sprite2D/spiegazione_1_1/indicazione2".hide()
	$"../player/Sprite2D/spiegazione_1_1/indicazione2".z_index = 2


func _on_body_entered(body: CharacterBody2D):
	entered = true
	$"../player/Sprite2D/spiegazione_1_1/indicazione2".show()

func _on_body_exited(body):
	entered = false
	$"../player/Sprite2D/spiegazione_1_1/indicazione2".hide()


func _process(delta):
	if entered == true:
		if Input.is_joy_button_pressed(JOY_BUTTON_A, JOY_BUTTON_A) or Input.is_key_label_pressed(KEY_C):
			$CollisionShape2D.free()
			var I_singleton = get_node("/root/Singleton")
			var index = I_singleton.get_custom_index()
			if index < 10:
				indifferenziato()

func indifferenziato():
	var indiff_sin = get_node("/root/SingletonIndiff")
	var indiff = indiff_sin.get_custom_indiff()
	indiff += 1
	indiff_sin.set_indiff(indiff)
	$"../player/Camera2D/CanvasLayer/punteggi/indifferenziato_rimasto".text = str(indiff)
