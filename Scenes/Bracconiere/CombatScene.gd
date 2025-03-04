extends Node

#func _ready():
	# Imposta le ancore per il Control
	#$CanvasLayer/Sfondo/CenterContainer.anchor_right = 1
	#$CanvasLayer/Sfondo/CenterContainer.anchor_bottom = 1
	
	# Imposta la posizione dello Sprite inizialmente a zero
	#$CanvasLayer/Sfondo/CenterContainer/Sprite2D.position = Vector2.ZERO
	
	# Collega i segnali per il ridimensionamento
	#get_window().size_changed.connect(update_sprite_position)
	#get_tree().node_added.connect(_on_node_added)
	
	# Aggiorna la posizione iniziale dopo un frame
	#call_deferred("update_sprite_position")

#func _on_node_added(node):
	# Quando un nodo viene aggiunto, verifica se dobbiamo aggiornare la posizione
	#call_deferred("update_sprite_position")

#func update_sprite_position():
	# Ottieni il controllo
	#var control = $CanvasLayer/Sfondo/CenterContainer
	
	# Calcola il centro esatto del controllo
	#var center = Vector2(control.size.x / 2, control.size.y / 2)
	
	# Imposta la posizione dello sprite al centro
	#$CanvasLayer/Sfondo/CenterContainer/Sprite2D.position = center
	
	# Debug: stampa i valori per verificare
	#print("Control size: ", control.size)
	#print("Sprite position: ", $CanvasLayer/Sfondo/CenterContainer/Sprite2D.position)

# Aggiungi questo per aggiornare costantemente in caso di problemi con gli eventi
#func _process(delta):
	#update_sprite_position()
