# DifesaState.gd
extends State

@onready var PlayerBar = $"../../GiocatoreBar"
##@onready var minigioco = $Minigioco

var minigioco_completato = false

##func enter():
   ## minigioco.start_game()
	##minigioco.game_over.connect(_on_game_over)
   ## minigioco.game_won.connect(_on_game_won)

##func exit():
	##if minigioco.game_over.is_connected(_on_game_over):
	  ##  minigioco.game_over.disconnect(_on_game_over)
   ## if minigioco.game_won.is_connected(_on_game_won):
		##minigioco.game_won.disconnect(_on_game_won)

##func _on_game_over():
	##giocatoreBar.value -= 20  # Danno al giocatore
	##if giocatoreBar.value <= 0:
	   ## get_parent().transition_to("res://FinalState.tscn")
	##else:
	   ## get_parent().transition_to("res://SelectState.tscn")

##func _on_game_won():
   ## get_parent().transition_to("res://SelectState.tscn")  # Continua il turno
