extends Control

##livello di sovrapposizione degli elementi UI
func _ready():
	$Label.z_index = 3
	$riprendi.z_index = 3
	$ricomincia.z_index = 3
	$torna_al_menu.z_index = 3


##nasconde il menu di pausa
func _on_riprendi_button_down():
	$".".hide()
	Engine.time_scale = 1

##ricarica la scena
func _on_ricomincia_button_down():
	get_tree().reload_current_scene()

##torna alla prima scena, non al menu
func _on_torna_al_menu_button_down():
	var back = preload("res://Scenes/mappa_game/mappa.tscn") as PackedScene
	get_tree().change_scene_to_packed(back)
