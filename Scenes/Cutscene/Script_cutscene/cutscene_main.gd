extends Control

# Variabili per CanvasLayer e per il box del dialogo
#@onready var canvas_layer = $CanvasLayerDialogue # Assumendo che la maschera sia un TextureRect
@onready var main_node = get_node("CanvasLayerDialogue/DialogueBox")

# Variabili che catturano a priori i nodi che devono essere nascosti
@onready var nodi_da_nasc_1 : Array = [$Foglioline, $CanvasLayerDialogue, $CanvasLayerDialogue/TextureRects/TextureRect_1]
@onready var nodi_da_nasc_2 : Array = [$CanvasLayerDialogue/TextureRects/TextureRect_1, $CanvasLayerDialogue/TextureRects/TextureRect_2]
@onready var nodi_da_nasc_3 : Array = [$CanvasLayerDialogue/TextureRects/TextureRect_2, $CanvasLayerDialogue/TextureRects/TextureRect_3]
@onready var nodi_da_nasc_4 : Array = [$CanvasLayerDialogue/TextureRects/TextureRect_3, $CanvasLayerDialogue/TextureRects/TextureRect_4]
@onready var nodi_da_nasc_5 : Array = [$CanvasLayerDialogue/TextureRects/TextureRect_4, $CanvasLayerDialogue/TextureRects/TextureRect_5]
@onready var nodi_da_nasc_6 : Array = [$CanvasLayerDialogue/TextureRects/TextureRect_5, $CanvasLayerDialogue/TextureRects/TextureRect_6]
@onready var nodi_da_nasc_7 : Array = [$CanvasLayerDialogue/TextureRects/TextureRect_6, $CanvasLayerDialogue/TextureRects/TextureRect_7]
@onready var nodi_da_nasc_8 : Array = [$CanvasLayerDialogue/TextureRects/TextureRect_7]

var brush_size = 0.5 # Dimensione della pennellata

# Funzione che verifica che l'input sia click e trascinamento sullo schermo, limitando l'area alla dimensione del ColorRect.
func _input(event):
	if event is InputEventMouseMotion and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var mouse_pos = get_viewport().get_mouse_position() / Vector2(get_viewport().size)
		
		var color_rects = $CanvasLayerDialogue.find_children("", "ColorRect", true)

		# Ciclo su tutti i ColorRect dentro CanvasLayerDialogue
		for color_rect in color_rects:
			if color_rect.material and color_rect.material is ShaderMaterial:
				color_rect.material.set_shader_parameter("brush_position", mouse_pos)
				color_rect.material.set_shader_parameter("brush_size", brush_size)

# Resetta la posizione del puntatore del mouse ogni volta che appare un nuovo ColorRect da scoprire.
func reset_vision():

	var color_rects = $CanvasLayerDialogue.find_children("", "ColorRect", true)
	
	for color_rect in color_rects:
		if color_rect.material and color_rect.material is ShaderMaterial:
			# Sposta la posizione del brush fuori dallo schermo
			color_rect.material.set_shader_parameter("brush_position", Vector2(-1, -1))

# Cambia la visibilita' ai nodi in un certo array di nodi
func toggle_visibility(nodes_array: Array):
	
	# Itera sull'array di nodi e cambia la visibilita
	for node in nodes_array:
		if node: 
			node.visible = !node.visible # Inverte la visibilita del nodo

# Insieme di funzioni che servono a cambiare la visibilita' dei nodi e inviare segnali sui pulsanti premuti.
func _on_texture_button1_pressed():
	toggle_visibility(nodi_da_nasc_1)

func _on_texture_button2_pressed():
	toggle_visibility(nodi_da_nasc_2)
	reset_vision()
	main_node._on_next_pressed()

func _on_texture_button3_pressed():
	toggle_visibility(nodi_da_nasc_3)
	reset_vision()
	main_node._on_next_pressed()

func _on_texture_button4_pressed():
	toggle_visibility(nodi_da_nasc_4)
	reset_vision()
	main_node._on_next_pressed()

func _on_texture_button5_pressed():
	toggle_visibility(nodi_da_nasc_5)
	reset_vision()
	main_node._on_next_pressed()

func _on_texture_button6_pressed():
	toggle_visibility(nodi_da_nasc_6)
	reset_vision()
	main_node._on_next_pressed()

func _on_texture_button7_pressed():
	toggle_visibility(nodi_da_nasc_7)
	reset_vision()
	main_node._on_next_pressed()

func _on_texture_button8_pressed():
	toggle_visibility(nodi_da_nasc_8)
	main_node._on_next_pressed()


