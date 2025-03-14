extends Node

@onready var animation_player = $AnimationPlayer

var initial_scale: Vector2  
var initial_window_size: Vector2 

func _ready():
	center_sprite()  

func center_sprite():
	await get_tree().process_frame
	var viewport_size = get_viewport().size
	self.position = viewport_size / 2
	print("Sprite centrato in:", self.position)


func play_animation(state_name: String):
	if animation_player == null:
		print("Errore: AnimationPlayer non trovato!")
		return
	match state_name:
		"SelectState":
			animation_player.play("Idle")
		"ParlaState":
			animation_player.play("Idle")
		"DifesaState":
			animation_player.play("CamminaSX")
		"PunteggioState":
			animation_player.play("Idle")
