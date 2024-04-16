extends Control


func _ready():
	$Label.z_index = 3
	$aiuto.z_index = 3
	$"come-aiuto?".z_index = 3
	$capito.z_index = 3

func _on_capito_button_down():
	Engine.time_scale = 1
	$".".hide()
