# DifesaState.gd
extends State
@onready var playerBar = get_parent().get_parent().get_node("PlayerBar")
@onready var bracconiereBar = get_parent().get_parent().get_node("Sprite2D/ConvinzioneBracconiere")
@onready var bracconiere = get_parent().get_parent().get_node("Sprite2D")
@onready var difesaUI = get_parent().get_parent().get_node("DifesaUI")
@onready var sfondoMinigioco = get_parent().get_parent().get_node("DifesaUI/SfondoMinigioco")
@onready var animationPlayer = get_parent().get_parent().get_node("Sprite2D/AnimationPlayer")
@onready var playerBarLabel = get_parent().get_parent().get_node("PlayerBar/Label")

var minigioco_instance = null
var minigioco_path = "res://Scenes/Bracconiere/minigiocoFrecce.tscn"

func enter():
	difesaUI.visible = true
	sfondoMinigioco.visible = false
	bracconiereBar.visible = false
	
	await animationPlayer.animation_finished  # Aspetta la fine di qualsiasi animazione
	
	sfondoMinigioco.visible = true
	precarica_minigioco()
	avvia_minigioco()
	
func precarica_minigioco():
	var minigioco_scene = load(minigioco_path)
	if minigioco_scene:
		minigioco_instance = minigioco_scene.instantiate()
		# Importante: rendi invisibile il minigioco all'inizio
		minigioco_instance.visible = false
		# Connetti i segnali
		minigioco_instance.vita_ridotta.connect(_on_vita_ridotta)
		minigioco_instance.minigioco_terminato.connect(_on_minigioco_terminato)
		##Aggiungi il minigioco allo sfondo
		sfondoMinigioco.add_child(minigioco_instance)
		# Posiziona correttamente il minigioco
		
	else:
		push_error("Impossibile caricare il minigioco: " + minigioco_path)
		_on_minigioco_terminato(false)  # Fallback
	
func avvia_minigioco():
	if minigioco_instance:
		minigioco_instance.visible = true  # Rendi visibile il minigioco già precaricato
	else:
		push_error("Minigioco non precaricato!")
		
func _on_vita_ridotta(danno):
	print("Vita ridotta di: ", danno)  # Debug per verificare che il segnale venga ricevuto
	# Riduci la barra della vita del giocatore
	playerBar.value -= danno
	
	playerBarLabel.text = str(playerBar.value) + "%"  # Aggiorna il testo
	await get_tree().create_timer(0.05).timeout
	
	# Verifica se il giocatore è stato sconfitto
	if playerBar.value <= 0:
		# Termina il minigioco immediatamente
		if minigioco_instance != null:
			minigioco_instance.queue_free()
			minigioco_instance = null
		
		# Passa allo stato finale (sconfitta)
		get_parent().transition_to("FinalState")

func _on_minigioco_terminato(successo):
	# Pulisci il riferimento al minigioco
	if minigioco_instance != null:
		minigioco_instance.queue_free()
		minigioco_instance = null
	
	# Transizione allo stato successivo
	get_parent().transition_to("SelectState")

func exit():
	# Pulizia finale
	if minigioco_instance != null:
		minigioco_instance.queue_free()
		minigioco_instance = null
	
	bracconiereBar.visible = true
	difesaUI.visible = false
	sfondoMinigioco.visible = false
