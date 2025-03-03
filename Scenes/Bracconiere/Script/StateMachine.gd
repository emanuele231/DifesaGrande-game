# StateMachine.gd
extends Node

var current_state: Node = null
@onready var animationStateMachine = get_parent().get_node("CanvasLayer/Sfondo/CenterContainer/Sprite2D")

func _ready():
	# Imposta lo stato iniziale
	change_state($SelectState)

func change_state(new_state: Node):
	if current_state:
		current_state.exit()  
	current_state = new_state
	current_state.enter()  
	animationStateMachine.play_animation(new_state.name)

func transition_to(state_name: String):
	var new_state = get_node(state_name)
	if new_state:
		change_state(new_state) 
