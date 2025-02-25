extends CanvasLayer

@onready var box_caricamento = $Box_Caricamento

func change_scene(target: String):

	# Nota bene: non si puo' fare il preload della scena che viene passata in input,
	# in quanto la stringa non e' statica. Anche volendo utilizzare ResourceLoader.load(),
	# non va bene, dato che poi restituiremmo un oggetto di tipo PackedScene e non una stringa.
	# Si puo' smorzare la lentezza del cambio di scena, aggiungendo un loading screen fatto bene.
	box_caricamento.show()
	$AnimationPlayer.play('dissolve')
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(target)
	$AnimationPlayer.play('loaded')
	# implementare un loading screen fatto bene -> grafiche con foglie, alberi, simili.
