extends Control

func _on_button_button_down():
	var back_to_menu = load("res://Scenes/mappa_game/mappa.tscn") as PackedScene
	if back_to_menu:
		SingletonStats.set_vittoria(1)
		get_tree().change_scene_to_packed(back_to_menu)
	else:
		print("Errore: scena non caricata!")
