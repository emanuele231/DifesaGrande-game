extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().get_node("Player_prov/Sprite2D/Dialogo_01")._label_01_callback = self
	hide()

func _on_dialogo_completo():
	show()
