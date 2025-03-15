extends Control

@onready var punti_label = $punti
@onready var button = $Button

func _ready():
	# Assicuriamoci che il pulsante funzioni
	button.pressed.connect(_on_button_button_down)
	button.z_index = 3  # Assicura che sia davanti ad altri elementi

func _process(delta):
	# Controlla se il tasto A del controller è stato premuto
	if Input.is_joy_button_pressed(JOY_BUTTON_A,JOY_BUTTON_A):
		_on_button_button_down()

func _on_button_button_down():

	var punti_singleton = get_node("/root/PuntiSingleton")
	if punti_singleton:
		punti_singleton.set_puntiO(0)
		punti_singleton.set_puntiI(0)
		punti_singleton.set_puntiP(0)
		punti_singleton.set_puntiC(0)
	else:
		print("Errore: PuntiSingleton non trovato")


	var somma: int = 0
	punti_label.text = str(somma)

	Engine.time_scale = 1

	var back_to_map = load("res://Scenes/mappa_game/mappa.tscn") as PackedScene
	if back_to_map:
		get_tree().change_scene_to_packed(back_to_map)
	else:
		print("Errore: la scena mappa non è stata caricata correttamente!")
