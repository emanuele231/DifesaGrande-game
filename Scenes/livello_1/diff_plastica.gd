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
		if Input.is_key_label_pressed(KEY_C):
			$CollisionShape2D.free()
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
	$"../player/Camera2D/CanvasLayer/punteggi/plastica_rimasta".text = str(plastica)

