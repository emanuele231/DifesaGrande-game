extends Area2D

@export var scena_target: String = "res://Scenes/Bracconiere/Bracconiere.tscn"
var giocatore_dentro = false

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	print("Interazione scena inizializzata")

func _on_body_entered(body):
	print("Corpo entrato:", body.name)
	if body.is_in_group("giocatore"):
		giocatore_dentro = true
		print("Giocatore dentro l'area di interazione! Premi X per cambiare scena")

func _on_body_exited(body):
	print("Corpo uscito:", body.name)
	if body.is_in_group("giocatore"):
		giocatore_dentro = false
		print("Giocatore uscito dall'area di interazione")

func _process(delta):
	if giocatore_dentro and Input.is_key_pressed(KEY_X):
		print("Tasto X premuto mentre il giocatore è nell'area - Cambio scena...")
		get_tree().change_scene_to_file(scena_target)
