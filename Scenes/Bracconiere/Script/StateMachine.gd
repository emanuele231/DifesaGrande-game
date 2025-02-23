# StateMachine.gd
extends Node

var current_state: Node = null

func _ready():
	# Imposta lo stato iniziale
	change_state($SelectState)

func change_state(new_state: Node):
	if current_state:
		current_state.exit()  # Chiama la funzione exit() dello stato corrente
	current_state = new_state
	current_state.enter()  # Chiama la funzione enter() del nuovo stato

func transition_to(state_name: String):
	var new_state = get_node(state_name)
	if new_state:
		change_state(new_state)

