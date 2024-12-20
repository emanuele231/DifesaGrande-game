extends Area2D

var entered: bool = false


func _ready():
	$"../player/Sprite2D/spiegazione_1_1/indicazione2".z_index = 2
	$"../player/Sprite2D/spiegazione_1_1/indicazione2".hide()



func _on_body_entered(body: CharacterBody2D):
	entered = true 
	$"../player/Sprite2D/spiegazione_1_1/indicazione2".show()


func _on_body_exited(body):
	entered = false
	$"../player/Sprite2D/spiegazione_1_1/indicazione2".hide()

func _process(delta):
	if entered == true and Input.is_key_label_pressed(KEY_C):
		$CollisionShape2D.free()
		var singleton = get_node("/root/Singleton")
		var index = singleton.get_custom_index()
		if index < 10:
			carta()

func carta():
	var carta_sin = get_node("/root/SingletonCarta")
	var carta = carta_sin.get_custom_carta()
	carta += 1
	carta_sin.set_carta(carta)
	$"../player/Camera2D/CanvasLayer/punteggi/carta_rimasta".text = str(carta)



