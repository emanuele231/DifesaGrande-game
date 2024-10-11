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
	if entered == true:
		if Input.is_key_label_pressed(KEY_C):
			$CollisionShape2D.free()
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

