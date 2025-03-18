extends Control

@onready var shader_material = $TextureRects/TextureRect_1/ColorRect.material # Assumendo che la maschera sia un TextureRect


# Called when the node enters the scene tree for the first time.
@onready var nodi_da_nasc_1 : Array = [$Foglioline, $TextureRects/TextureRect_1, $TextureRects/DialogueBox]
@onready var nodi_da_nasc_2 : Array = [$TextureRects/TextureRect_1, $TextureRects/TextureRect_2]

var brush_size = 0.5 # Dimensione della pennellata

func _input(event):
	if event is InputEventMouseMotion and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var mouse_pos = get_viewport().get_mouse_position() / Vector2(get_viewport().size)
		shader_material.set_shader_parameter("brush_position", mouse_pos)
		shader_material.set_shader_parameter("brush_size", brush_size)

# Cambia la visibilita' ai nodi in un certo array di nodi
func toggle_visibility(nodes_array: Array):
	
	# Itera sull'array di nodi e cambia la visibilita
	for node in nodes_array:
		if node: 
			node.visible = !node.visible # Inverte la visibilita del nodo

func _on_texture_button1_pressed():
	toggle_visibility(nodi_da_nasc_1)

func _on_texture_button2_pressed():
	toggle_visibility(nodi_da_nasc_2)

'func _on_texture_button3_pressed():
	toggle_visibility(nodi_da_nasc_3)

func _on_texture_button4_pressed():
	toggle_visibility(nodi_da_nasc_4)	

'
