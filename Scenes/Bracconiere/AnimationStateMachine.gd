extends Node

@onready var animation_player = $AnimationPlayer

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
