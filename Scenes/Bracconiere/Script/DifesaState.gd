# DifesaState.gd
extends State

@onready var playerBar = get_parent().get_parent().get_node("PlayerBar")
@onready var bracconiereBar = get_parent().get_parent().get_node("Sprite2D/ConvinzioneBracconiere")

@onready var bracconiere = get_parent().get_parent().get_node("Sprite2D")
@onready var difesaUI = get_parent().get_parent().get_node("DifesaUI")
@onready var sfondoMinigioco = get_parent().get_parent().get_node("DifesaUI/SfondoMinigioco")

@onready var animationPlayer = get_parent().get_parent().get_node("Sprite2D/AnimationPlayer")

##@onready var minigioco = get_parent().get_parent().get_node_or_null("DifesaUI/Bottom/Minigioco") 


##var minigioco_completato = false

func enter():
	difesaUI.visible = true
	sfondoMinigioco.visible = false
	
	bracconiereBar.visible = false
	##bracconiere.transform.origin.x -= 350  # Muove lo sprite a sinistra
	
	await animationPlayer.animation_finished  # Aspetta la fine di qualsiasi animazione
	
	sfondoMinigioco.visible = true 
   ## minigioco.start_game()
	##minigioco.game_over.connect(_on_game_over)
   ## minigioco.game_won.connect(_on_game_won)

func exit():
	difesaUI.visible = false
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
